
<CFCOMPONENT>

	<!--- Set THIS scope constructor variables --->
	<CFSET THIS.dsn = "" />
    <CFSET THIS.quiz_type = "" />
    <CFSET THIS.quiz_rounds = "" />
	<CFSET THIS.quiz_questions = "" />
    <CFSET THIS.location_UUID = "" />
    <CFSET THIS.quiz_round_1 = "" />
    <CFSET THIS.quiz_round_2 = "" />
    <CFSET THIS.quiz_round_3 = "" />
    <CFSET THIS.quiz_round_4 = "" />
    <CFSET THIS.quiz_round_5 = "" />
    <CFSET THIS.quiz_round_6 = "" />
	<CFSET THIS.category_UUID = "" />
    <CFSET THIS.quiz_UUID = "" />
    <CFSET THIS.user_UUID = "" />
    <CFSET THIS.username_hash = "" />
    <CFSET THIS.logged_user = "" />


    <!--- Quiz Details --->
	<CFFUNCTION NAME="getQuizDetails" ACCESS="public" RETURNTYPE="query">

        <CFQUERY NAME="quizdetails" DATASOURCE="#THIS.dsn#">

        	SELECT *,
            	   CASE WHEN a.quiz_finished IS NULL THEN a.quiz_cancelled
                   		ELSE a.quiz_finished END AS quiz_completed,
                   CONCAT(d.user_firstname, ' ', d.user_lastname) AS winner,
                   CASE WHEN a.quiz_cancelled IS NULL and a.quiz_finished IS NULL THEN 'ongoing'
                   		WHEN a.quiz_cancelled IS NOT NULL OR a.quiz_finished IS NOT NULL THEN 'historic'
                        ELSE 'unknown' END AS quiz_status

            	FROM data_quizzes a
                		LEFT JOIN sys_locations b ON a.location_UUID = b.location_UUID
                        LEFT JOIN sys_users c ON a.quiz_winner = c.user_UUID
                        LEFT JOIN sys_users_details d ON c.user_details_UUID = d.user_details_UUID

                <CFIF THIS.quiz_type EQ 'ongoing'>
                	 WHERE a.quiz_cancelled IS NULL
               		 AND a.quiz_finished IS NULL
                <CFELSEIF THIS.quiz_type EQ 'historic'>
                	WHERE (a.quiz_cancelled IS NOT NULL
               		OR a.quiz_finished IS NOT NULL)
                <CFELSE>
                	WHERE 0 = 0
                </CFIF>

                <CFIF THIS.quiz_UUID NEQ ''>
                	AND a.quiz_UUID = <CFQUERYPARAM VALUE="#quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />
                </CFIF>

                <CFIF THIS.username_hash NEQ ''>
                	AND a.added_by = <CFQUERYPARAM VALUE="#THIS.username_hash#" CFSQLTYPE="cf_sql_varchar" />
                </CFIF>

        </CFQUERY>

		<CFRETURN quizdetails />

	</CFFUNCTION>
	<!--- End Quiz Details --->

	<!--- Add Quiz --->
	<CFFUNCTION NAME="addQuiz" ACCESS="public" RETURNTYPE="struct">

		<CFTRY>

            <CFLOCK TIMEOUT="20">

                <CFTRANSACTION>

                	<CFIF #THIS.user_role_UUID# EQ '87fc3819-0d3f-11e5-a315-38b1dbe2bc0e'>

                        <CFQUERY NAME="additem1" DATASOURCE="#THIS.dsn#">

                            SELECT IFNULL(free_credits, 0) AS free_credits

                                FROM sys_users

                                WHERE user_UUID = <CFQUERYPARAM VALUE="#THIS.user_UUID#" CFSQLTYPE="cf_sql_varchar" />

                        </CFQUERY>

                        <CFIF #additem1.free_credits# GT 0>

                            <CFQUERY NAME="additem2" DATASOURCE="#THIS.dsn#">

                                UPDATE sys_users

                                    SET free_credits = free_credits - 1

                                    WHERE user_UUID = <CFQUERYPARAM VALUE="#THIS.user_UUID#" CFSQLTYPE="cf_sql_varchar" />

                            </CFQUERY>

                        <CFELSE>

                            <CFQUERY NAME="additem3" DATASOURCE="#THIS.dsn#">

                                UPDATE sys_users

                                    SET paid_credits = paid_credits - 1

                                    WHERE user_UUID = <CFQUERYPARAM VALUE="#THIS.user_UUID#" CFSQLTYPE="cf_sql_varchar" />

                            </CFQUERY>

                        </CFIF>

                    </CFIF>

					<CFQUERY NAME="additem4" DATASOURCE="#THIS.dsn#">

						SELECT quiz_code

							FROM data_quiz_codes

							WHERE quiz_code NOT IN (SELECT quiz_code FROM data_quizzes)

							ORDER BY RAND()

							LIMIT 1

					</CFQUERY>

                    <CFSET quiz_UUID = #CreateUUID()# />

                    <CFQUERY NAME="additem5" DATASOURCE="#THIS.dsn#">

                        INSERT INTO data_quizzes (quiz_UUID, quiz_code, quiz_rounds, quiz_questions, location_UUID, quiz_round_1, quiz_round_2, quiz_round_3, quiz_round_4, quiz_round_5, quiz_round_6, quiz_created, added_by)

                            VALUES	(
                                    <CFQUERYPARAM VALUE="#quiz_UUID#" CFSQLTYPE="cf_sql_varchar">,
                                    <CFQUERYPARAM VALUE="#additem4.quiz_code#" CFSQLTYPE="cf_sql_varchar">,
                                    <CFQUERYPARAM VALUE="#THIS.quiz_rounds#" CFSQLTYPE="cf_sql_varchar">,
                                    <CFQUERYPARAM VALUE="#THIS.quiz_questions#" CFSQLTYPE="cf_sql_varchar">,
                                    <CFQUERYPARAM VALUE="#THIS.location_UUID#" CFSQLTYPE="cf_sql_varchar">,
                                    <CFQUERYPARAM VALUE="#THIS.quiz_round_1#" CFSQLTYPE="cf_sql_varchar">,
                                    <CFQUERYPARAM VALUE="#THIS.quiz_round_2#" CFSQLTYPE="cf_sql_varchar">,
                                    <CFQUERYPARAM VALUE="#THIS.quiz_round_3#" CFSQLTYPE="cf_sql_varchar">,
                                    <CFQUERYPARAM VALUE="#THIS.quiz_round_4#" CFSQLTYPE="cf_sql_varchar">,
                                    <CFQUERYPARAM VALUE="#THIS.quiz_round_5#" CFSQLTYPE="cf_sql_varchar">,
                                    <CFQUERYPARAM VALUE="#THIS.quiz_round_6#" CFSQLTYPE="cf_sql_varchar">,
                                    <CFQUERYPARAM VALUE="#Now()#" CFSQLTYPE="cf_sql_timestamp">,
                                    <CFQUERYPARAM VALUE="#THIS.logged_user#" CFSQLTYPE="cf_sql_varchar">
                                    )

                    </CFQUERY>

                    <CFSET game_UUID = #CreateUUID()# />

                    <CFQUERY NAME="additem6" DATASOURCE="#THIS.dsn#">

                        INSERT INTO data_games (game_UUID, quiz_UUID, game_rounds_left, game_questions_left, game_status)

                            VALUES	(
                            		<CFQUERYPARAM VALUE="#game_UUID#" CFSQLTYPE="cf_sql_varchar">,
                                    <CFQUERYPARAM VALUE="#quiz_UUID#" CFSQLTYPE="cf_sql_varchar">,
                                    <CFQUERYPARAM VALUE="#THIS.quiz_rounds#" CFSQLTYPE="cf_sql_varchar">,
                                    <CFQUERYPARAM VALUE="#THIS.quiz_questions#" CFSQLTYPE="cf_sql_varchar">,
                                    <CFQUERYPARAM VALUE="N" CFSQLTYPE="cf_sql_varchar">
                                    )

                    </CFQUERY>

                </CFTRANSACTION>

            </CFLOCK>

            <CFSET resultStruct.statusCode = 1 />
            <CFSET resultStruct.statusClass = "success" />
            <CFSET resultStruct.quiz_UUID = #quiz_UUID# />
            <CFSET resultStruct.quizCode = #additem4.quiz_code# />
			<CFSET resultStruct.statusMessage = "The Quiz has been created!" />
            <CFRETURN RESULTSTRUCT />

            <CFCATCH>

            	<CFSET resultStruct.statusCode = -1 />
                <CFSET resultStruct.statusClass = "error" />
                <CFSET resultStruct.quiz_UUID = "x" />
                <CFSET resultStruct.quizCode = "x" />
                <CFSET resultStruct.statusMessage = "Sorry, there was an error creating this Quiz!" />
                <CFRETURN RESULTSTRUCT />

            </CFCATCH>

        </CFTRY>

	</CFFUNCTION>
	<!--- End Add Quiz --->

    <!--- Cancel Quiz --->
	<CFFUNCTION NAME="cancelQuiz" ACCESS="remote">

        <CFARGUMENT NAME="dsn" />
        <CFARGUMENT NAME="quiz_UUID" />
        <CFARGUMENT NAME="logged_user" />

        <CFQUERY NAME="cancelquiz1" DATASOURCE="#dsn#">

            UPDATE data_quizzes

            	SET quiz_winner = <CFQUERYPARAM VALUE="Quiz Cancelled" CFSQLTYPE="cf_sql_varchar" />,
                	quiz_cancelled = <CFQUERYPARAM VALUE="#Now()#" CFSQLTYPE="cf_sql_timestamp" />,
                	cancelled_by = <CFQUERYPARAM VALUE="#logged_user#" CFSQLTYPE="cf_sql_varchar" />

                WHERE quiz_UUID = <CFQUERYPARAM VALUE="#quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />

        </CFQUERY>

        <CFQUERY NAME="cancelquiz2" DATASOURCE="#dsn#">

            UPDATE data_games

            	SET game_status = <CFQUERYPARAM VALUE="F" CFSQLTYPE="cf_sql_varchar" />

                WHERE quiz_UUID = <CFQUERYPARAM VALUE="#quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />

        </CFQUERY>

    </CFFUNCTION>
	<!--- End Cancel Quiz --->


	<!--- Select Question Number --->
	<CFFUNCTION NAME="getQuestionNumber" ACCESS="public" RETURNTYPE="query">

        <CFQUERY NAME="getquizdetails" DATASOURCE="#THIS.dsn#">

        	SELECT a.quiz_rounds - b.game_rounds_left + 1 AS round_number,
            	   a.quiz_questions - b.game_questions_left + 1 AS question_number,
                   CASE WHEN b.game_rounds_left = 6 THEN h.category
                   		WHEN b.game_rounds_left = 5 THEN g.category
                        WHEN b.game_rounds_left = 4 THEN f.category
                        WHEN b.game_rounds_left = 3 THEN e.category
                        WHEN b.game_rounds_left = 2 THEN d.category
                        WHEN b.game_rounds_left = 1 THEN c.category
                        END AS round_category,
                   CASE WHEN b.game_rounds_left = 6 THEN a.quiz_round_6
                   		WHEN b.game_rounds_left = 5 THEN a.quiz_round_5
                        WHEN b.game_rounds_left = 4 THEN a.quiz_round_4
                        WHEN b.game_rounds_left = 3 THEN a.quiz_round_3
                        WHEN b.game_rounds_left = 2 THEN a.quiz_round_2
                        WHEN b.game_rounds_left = 1 THEN a.quiz_round_1
                        END AS category_UUID

                FROM data_quizzes a
                		LEFT JOIN data_games b ON a.quiz_UUID = b.quiz_UUID
                        LEFT JOIN sys_categories c ON a.quiz_round_1 = c.category_UUID
                        LEFT JOIN sys_categories d ON a.quiz_round_2 = d.category_UUID
                        LEFT JOIN sys_categories e ON a.quiz_round_3 = e.category_UUID
                        LEFT JOIN sys_categories f ON a.quiz_round_4 = f.category_UUID
                        LEFT JOIN sys_categories g ON a.quiz_round_5 = g.category_UUID
                        LEFT JOIN sys_categories h ON a.quiz_round_6 = h.category_UUID

                WHERE a.quiz_UUID = <CFQUERYPARAM VALUE="#THIS.quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />

        </CFQUERY>

		<CFRETURN getquizdetails />

	</CFFUNCTION>
	<!--- End Select Question Number --->

    <!--- Select Question --->
	<CFFUNCTION NAME="getQuestion" ACCESS="public" RETURNTYPE="query">

        <CFQUERY NAME="quizdetails" DATASOURCE="#THIS.dsn#">

        	SELECT b.game_UUID,
            	   a.quiz_rounds - b.game_rounds_left + 1 AS round_number,
            	   a.quiz_questions - b.game_questions_left + 1 AS question_number

                FROM data_quizzes a
                		LEFT JOIN data_games b ON a.quiz_UUID = b.quiz_UUID

                WHERE a.quiz_UUID = <CFQUERYPARAM VALUE="#THIS.quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />

        </CFQUERY>

        <CFQUERY NAME="checkquestion" DATASOURCE="#THIS.dsn#">

        	SELECT *

            	FROM data_games_questions

                WHERE quiz_UUID = <CFQUERYPARAM VALUE="#THIS.quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />

                AND question_date = (SELECT MAX(question_date) FROM data_games_questions WHERE quiz_UUID = <CFQUERYPARAM VALUE="#THIS.quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />)

        </CFQUERY>

        <CFQUERY NAME="selectquestion" DATASOURCE="#THIS.dsn#">

        	SELECT a.question_UUID,
            	   b.category,
                   a.question,
                   a.answer_correct,
                   a.answer_wrong_1,
                   a.answer_wrong_2,
                   a.answer_wrong_3

                FROM data_questions a
                		LEFT JOIN sys_categories b ON a.category_UUID = b.category_UUID

                <CFIF (checkquestion.RECORDCOUNT EQ 0) OR (checkquestion.question_status EQ 'complete')>

                    WHERE a.question_UUID NOT IN (SELECT DISTINCT IFNULL(c.question_UUID, 'x') AS question_UUID FROM data_games_questions c WHERE c.quiz_UUID = <CFQUERYPARAM VALUE="#THIS.quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />)

					<CFIF #THIS.category_UUID# NEQ '78c0fdb9-1b48-11e5-80b8-38b1dbe2bc0e'>
                        AND a.category_UUID = <CFQUERYPARAM VALUE="#THIS.category_UUID#" CFSQLTYPE="cf_sql_varchar" />
                    </CFIF>

                    ORDER BY RAND()

                    LIMIT 1

                <CFELSE>

                    WHERE a.question_UUID = <CFQUERYPARAM VALUE="#checkquestion.question_UUID#" CFSQLTYPE="cf_sql_varchar" />

                </CFIF>

        </CFQUERY>

        <CFIF (checkquestion.RECORDCOUNT EQ 0) OR (checkquestion.question_status EQ 'complete')>

            <CFQUERY NAME="insertintoquestions" DATASOURCE="#THIS.dsn#">

                INSERT INTO data_games_questions (game_question_UUID, quiz_UUID, game_UUID, question_UUID, round_number, question_number, question_status, question_date)

                    VALUES (
                            <CFQUERYPARAM VALUE="#CreateUUID()#" CFSQLTYPE="cf_sql_varchar" />,
                            <CFQUERYPARAM VALUE="#THIS.quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />,
                            <CFQUERYPARAM VALUE="#quizdetails.game_UUID#" CFSQLTYPE="cf_sql_varchar" />,
                            <CFQUERYPARAM VALUE="#selectquestion.question_UUID#" CFSQLTYPE="cf_sql_varchar" />,
                            <CFQUERYPARAM VALUE="#quizdetails.round_number#" CFSQLTYPE="cf_sql_integer" />,
                            <CFQUERYPARAM VALUE="#quizdetails.question_number#" CFSQLTYPE="cf_sql_integer" />,
                            <CFQUERYPARAM VALUE="new" CFSQLTYPE="cf_sql_varchar" />,
                            <CFQUERYPARAM VALUE="#Now()#" CFSQLTYPE="cf_sql_timestamp" />
                            )

            </CFQUERY>

        </CFIF>

		<CFRETURN selectquestion />

	</CFFUNCTION>
	<!--- End Select Question --->

    <!--- Release Question --->
	<CFFUNCTION NAME="releaseQuestion" ACCESS="remote">

        <CFARGUMENT NAME="dsn" />
        <CFARGUMENT NAME="quiz_UUID" />

		<CFTRY>

	        <CFQUERY NAME="releasequestion1" DATASOURCE="#dsn#">

	            UPDATE data_games

	            	SET game_status = <CFQUERYPARAM VALUE="R" CFSQLTYPE="cf_sql_varchar" />

	                WHERE quiz_UUID = <CFQUERYPARAM VALUE="#quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />

	        </CFQUERY>

	        <CFQUERY NAME="releasequestion2" DATASOURCE="#dsn#">

	            UPDATE data_games_questions

	            	SET question_status = <CFQUERYPARAM VALUE="complete" CFSQLTYPE="cf_sql_varchar" />

	                WHERE quiz_UUID = <CFQUERYPARAM VALUE="#quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />

	        </CFQUERY>

		<CFCATCH>
		</CFCATCH>

		</CFTRY>

    </CFFUNCTION>
	<!--- End Release Question --->

    <!--- Next Question --->
	<CFFUNCTION NAME="nextQuestion" ACCESS="remote" RETURNFORMAT="plain" RETURNTYPE="string">

        <CFARGUMENT NAME="dsn" />
        <CFARGUMENT NAME="quiz_UUID" />

        <CFQUERY NAME="nextquestion1" DATASOURCE="#dsn#">

            UPDATE data_games

            	SET game_status = <CFQUERYPARAM VALUE="N" CFSQLTYPE="cf_sql_varchar" />,
                	game_questions_left = game_questions_left - 1

                WHERE quiz_UUID = <CFQUERYPARAM VALUE="#quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />

        </CFQUERY>

        <CFQUERY NAME="checknumbers1" DATASOURCE="#dsn#">

            SELECT *

            	FROM data_quizzes a
                		INNER JOIN data_games b ON a.quiz_UUID = b.quiz_UUID

                WHERE a.quiz_UUID = <CFQUERYPARAM VALUE="#quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />

        </CFQUERY>

        <CFIF checknumbers1.game_questions_left GT 0>

        	<CFRETURN 'nextquestion' />

        <CFELSE>

        	<CFQUERY NAME="nextquestion2" DATASOURCE="#dsn#">

                UPDATE data_games

                    SET game_questions_left = <CFQUERYPARAM VALUE="#checknumbers1.quiz_questions#" CFSQLTYPE="cf_sql_integer" />,
                        game_rounds_left = game_rounds_left - 1

                    WHERE quiz_UUID = <CFQUERYPARAM VALUE="#quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />

            </CFQUERY>

            <CFQUERY NAME="checknumbers2" DATASOURCE="#dsn#">

                SELECT *

                    FROM data_quizzes a
                            INNER JOIN data_games b ON a.quiz_UUID = b.quiz_UUID

                    WHERE a.quiz_UUID = <CFQUERYPARAM VALUE="#quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />

            </CFQUERY>

            <CFIF checknumbers2.game_rounds_left GT 0>

				<CFQUERY NAME="releasequestion1" DATASOURCE="#dsn#">

		            UPDATE data_games

		            	SET game_status = <CFQUERYPARAM VALUE="RC" CFSQLTYPE="cf_sql_varchar" />

		                WHERE quiz_UUID = <CFQUERYPARAM VALUE="#quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />

		        </CFQUERY>

                <CFRETURN 'roundcomplete' />

            <CFELSE>

				<CFQUERY NAME="finishquiz1" DATASOURCE="#dsn#">

                    SELECT CASE WHEN a.participant_team = '' OR a.participant_team IS NULL THEN
							    (CASE WHEN c.player_firstname IS NULL THEN SUBSTRING(c.player_email, 1, LOCATE('@', c.player_email) - 1)
							   		  ELSE CONCAT(c.player_firstname, ' ', c.player_lastname) END)
							    ELSE a.participant_team END AS winner,
						   b.player_UUID

						FROM data_participants a
								LEFT JOIN sys_players b ON a.player_UUID = b.player_UUID
								LEFT JOIN sys_players_details c ON b.player_details_UUID = c.player_details_UUID

                        WHERE a.quiz_UUID = <CFQUERYPARAM VALUE="#quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />

						ORDER BY a.participant_score DESC

						LIMIT 1

                </CFQUERY>

            	<CFQUERY NAME="finishquiz2" DATASOURCE="#dsn#">

                    UPDATE data_quizzes

                        SET quiz_finished = <CFQUERYPARAM VALUE="#Now()#" CFSQLTYPE="cf_sql_timestamp" />,
							quiz_winner = <CFQUERYPARAM VALUE="#finishquiz1.winner#" CFSQLTYPE="cf_sql_varchar" />,
							quiz_winner_UUID = <CFQUERYPARAM VALUE="#finishquiz1.player_UUID#" CFSQLTYPE="cf_sql_varchar" />

                        WHERE quiz_UUID = <CFQUERYPARAM VALUE="#quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />

                </CFQUERY>

                <CFQUERY NAME="finishquiz3" DATASOURCE="#dsn#">

                    UPDATE data_games

                        SET game_status = <CFQUERYPARAM VALUE="F" CFSQLTYPE="cf_sql_varchar" />

                        WHERE quiz_UUID = <CFQUERYPARAM VALUE="#quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />

                </CFQUERY>

            	<CFRETURN 'quizcomplete' />

            </CFIF>

        </CFIF>

    </CFFUNCTION>
	<!--- End Next Question --->

    <!--- Question Details --->
	<CFFUNCTION NAME="getQuestionList" ACCESS="public" RETURNTYPE="query">

        <CFQUERY NAME="questionlist" DATASOURCE="#THIS.dsn#">

        	SELECT *,
            	   CONCAT('R', a.round_number, 'Q', a.question_number) AS question_place

            	FROM data_games_questions a
                		LEFT JOIN data_questions b ON a.question_UUID = b.question_UUID

                <CFIF THIS.quiz_UUID NEQ ''>
                	WHERE a.quiz_UUID = <CFQUERYPARAM VALUE="#THIS.quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />
                </CFIF>

        </CFQUERY>

		<CFRETURN questionlist />

	</CFFUNCTION>
	<!--- End Question Details --->


</CFCOMPONENT>
