
<CFCOMPONENT>


	<CFSET THIS.dsn = "" />
	<CFSET THIS.question_UUID = "" />
	<CFSET THIS.quiz_UUID = "" />
	<CFSET THIS.username_hash = "" />


	<!--- Get Question Details --->
	<CFFUNCTION NAME="getQuestionNumberDetails" ACCESS="public" RETURNTYPE="query">

        <CFQUERY NAME="questionnumberdetails" DATASOURCE="#THIS.dsn#">

        	SELECT b.game_UUID,
            	   a.quiz_rounds - b.game_rounds_left + 1 AS round_number,
            	   a.quiz_questions - b.game_questions_left + 1 AS question_number

                FROM data_quizzes a
                		LEFT JOIN data_games b ON a.quiz_UUID = b.quiz_UUID

                WHERE a.quiz_UUID = <CFQUERYPARAM VALUE="#THIS.quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />

        </CFQUERY>

		<CFRETURN questionnumberdetails />

	</CFFUNCTION>
	<!--- End Get Question Details --->

	<!--- Get Question Details --->
	<CFFUNCTION NAME="getQuestionDetails" ACCESS="public" RETURNTYPE="query">

		<CFQUERY NAME="questiondetails" DATASOURCE="#THIS.dsn#">

			SELECT a.interaction_answer

				FROM data_interactions a
						LEFT JOIN data_participants b ON a.participant_UUID = b.participant_UUID
						LEFT JOIN sys_players c ON b.player_UUID = c.player_UUID

				WHERE a.quiz_UUID = <CFQUERYPARAM VALUE="#THIS.quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />
				AND a.question_UUID = <CFQUERYPARAM VALUE="#THIS.question_UUID#" CFSQLTYPE="cf_sql_varchar" />
				AND c.username_hash = <CFQUERYPARAM VALUE="#THIS.username_hash#" CFSQLTYPE="cf_sql_varchar" />

		</CFQUERY>

		<CFIF questiondetails.RECORDCOUNT EQ 0>

	        <CFQUERY NAME="questiondetails" DATASOURCE="#THIS.dsn#">

	        	SELECT a.question_UUID,
	            	   b.category,
	                   a.question,
	                   a.answer_correct,
	                   a.answer_wrong_1,
	                   a.answer_wrong_2,
	                   a.answer_wrong_3,
					   a.question_UUID AS answer1_UUID,
					   <CFQUERYPARAM VALUE="#CreateUUID()#" CFSQLTYPE="cf_sql_varchar" /> AS answer2_UUID,
					   <CFQUERYPARAM VALUE="#CreateUUID()#" CFSQLTYPE="cf_sql_varchar" /> AS answer3_UUID,
					   <CFQUERYPARAM VALUE="#CreateUUID()#" CFSQLTYPE="cf_sql_varchar" />  AS answer4_UUID

	                FROM data_questions a
	                		LEFT JOIN sys_categories b ON a.category_UUID = b.category_UUID

	                WHERE a.question_UUID = <CFQUERYPARAM VALUE="#THIS.question_UUID#" CFSQLTYPE="cf_sql_varchar" />

	        </CFQUERY>

	    </CFIF>

		<CFRETURN questiondetails />

	</CFFUNCTION>
	<!--- End Get Question Details --->

    <!--- Get Question --->
	<CFFUNCTION NAME="getQuestion" ACCESS="remote" RETURNTYPE="string">

		<CFARGUMENT NAME="dsn" />
		<CFARGUMENT NAME="quiz_UUID">
		<CFARGUMENT NAME="username_hash">

		<CFSET question = 'x' />

		<CFQUERY NAME="playercheck" DATASOURCE="#dsn#">

        	SELECT *

				FROM sys_players a
						LEFT JOIN data_participants b ON a.player_UUID = b.player_UUID

				WHERE a.username_hash = <CFQUERYPARAM VALUE="#username_hash#" CFSQLTYPE="cf_sql_varchar" />
				AND b.quiz_UUID = <CFQUERYPARAM VALUE="#quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />
				AND b.participant_accepted = 'yes'

        </CFQUERY>

		<CFIF #playercheck.RECORDCOUNT# NEQ 0>

			<CFQUERY NAME="roundcheck" DATASOURCE="#dsn#">

	            SELECT game_status

	            	FROM data_games

	                WHERE quiz_UUID = <CFQUERYPARAM VALUE="#quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />

	        </CFQUERY>

			<CFIF #roundcheck.game_status# EQ 'RC'>

				<CFSET question = 'roundcomplete' />

			<CFELSEIF #roundcheck.game_status# EQ 'F'>

				<CFSET question = 'quizcomplete' />

			<CFELSE>

		        <CFQUERY NAME="questioncheck" DATASOURCE="#dsn#">

		        	SELECT a.question_UUID

						FROM data_games_questions a

						WHERE a.quiz_UUID = <CFQUERYPARAM VALUE="#quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />
		        		AND a.question_date = (SELECT MAX(question_date) FROM data_games_questions WHERE quiz_UUID = <CFQUERYPARAM VALUE="#quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />)
						AND a.question_status = 'complete'
						AND a.question_UUID NOT IN (SELECT question_UUID FROM data_interactions WHERE participant_UUID = <CFQUERYPARAM VALUE="#playercheck.participant_UUID#" CFSQLTYPE="cf_sql_varchar" />)

		        </CFQUERY>

				<CFIF #questioncheck.RECORDCOUNT# NEQ 0>

					<CFSET question = questioncheck.question_UUID />

				</CFIF>

			</CFIF>

		</CFIF>

		<CFRETURN question />

	</CFFUNCTION>
	<!--- End Get Question --->

	<!--- Check Answer --->
	<CFFUNCTION NAME="checkAnswer" ACCESS="remote" RETURNFORMAT="plain">

		<CFARGUMENT NAME="dsn" />
		<CFARGUMENT NAME="quiz_UUID" />
		<CFARGUMENT NAME="elapsed" />
		<CFARGUMENT NAME="question_UUID" />
		<CFARGUMENT NAME="answer_UUID" />
		<CFARGUMENT NAME="answer" />
		<CFARGUMENT NAME="username_hash" />

		<CFQUERY NAME="checkanswer1" DATASOURCE="#dsn#">

        	SELECT *

                FROM data_questions

                WHERE question_UUID = <CFQUERYPARAM VALUE="#answer_UUID#" CFSQLTYPE="cf_sql_varchar" />

        </CFQUERY>

		<CFQUERY NAME="checkanswer2" DATASOURCE="#dsn#">

        	SELECT *

                FROM sys_players a
						LEFT JOIN data_participants b ON a.player_UUID = b.player_UUID

                WHERE a.username_hash = <CFQUERYPARAM VALUE="#username_hash#" CFSQLTYPE="cf_sql_varchar" />
				AND b.quiz_UUID = <CFQUERYPARAM VALUE="#quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />

        </CFQUERY>

		<CFSET score = #checkanswer2.participant_score# />

		<CFSET time = #checkanswer2.participant_time# />

		<CFSET correct = 0 />

		<CFIF #checkanswer1.RECORDCOUNT# NEQ 0>

			<CFSET score = Int(11 - ((#elapsed# * 10) / 30000)) + #checkanswer2.participant_score# />

			<CFSET time = #NumberFormat((elapsed / 1000), '.__')# + #checkanswer2.participant_time# />

			<CFSET correct = 1 />

		</CFIF>

		<CFQUERY NAME="checkanswer3" DATASOURCE="#dsn#">

        	UPDATE data_participants

				SET participant_score = <CFQUERYPARAM VALUE="#score#" CFSQLTYPE="cf_sql_integer" />,
					participant_time = <CFQUERYPARAM VALUE="#time#" CFSQLTYPE="cf_sql_float" />

                WHERE participant_UUID = <CFQUERYPARAM VALUE="#checkanswer2.participant_UUID#" CFSQLTYPE="cf_sql_varchar" />

        </CFQUERY>

		<CFQUERY NAME="checkanswer4" DATASOURCE="#dsn#">

        	INSERT INTO data_interactions (interaction_UUID, quiz_UUID, participant_UUID, question_UUID, interaction_score, interaction_time, interaction_answer, interaction_correct)

				VALUES (
						<CFQUERYPARAM VALUE="#CreateUUID()#" CFSQLTYPE="cf_sql_varchar" />,
						<CFQUERYPARAM VALUE="#quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />,
						<CFQUERYPARAM VALUE="#checkanswer2.participant_UUID#" CFSQLTYPE="cf_sql_varchar" />,
						<CFQUERYPARAM VALUE="#question_UUID#" CFSQLTYPE="cf_sql_varchar" />,
						<CFQUERYPARAM VALUE="#score#" CFSQLTYPE="cf_sql_varchar" />,
						<CFQUERYPARAM VALUE="#time#" CFSQLTYPE="cf_sql_varchar" />,
						<CFQUERYPARAM VALUE="#answer#" CFSQLTYPE="cf_sql_varchar" />,
						<CFQUERYPARAM VALUE="#correct#" CFSQLTYPE="cf_sql_bit" />
						)

        </CFQUERY>

		<CFRETURN "correct=" & ToString(#correct#) & "&score=" & ToString(#score#) />

	</CFFUNCTION>
	<!--- End Check Answer --->


</CFCOMPONENT>
