<CFCOMPONENT HINT="dynamic component">

	<!--- Set THIS scope constructor variables --->
	<CFSET THIS.dsn = "" />

    <CFSET THIS.participant_team = "" />
	<CFSET THIS.quiz_code = "" />

	<CFSET THIS.quiz_UUID = "" />
    <CFSET THIS.username_hash = "" />


    <!--- Join Quiz --->
	<CFFUNCTION NAME="joinQuiz" ACCESS="public" RETURNTYPE="struct">

		<CFTRY>

            <CFLOCK TIMEOUT="20">

                <CFTRANSACTION>

                	<CFQUERY NAME="additem1" DATASOURCE="#THIS.dsn#">

                        SELECT *

                        	FROM quizzes

                            WHERE quiz_code = <CFQUERYPARAM VALUE="#THIS.quiz_code#" CFSQLTYPE="cf_sql_varchar">

                    </CFQUERY>

					<CFCOOKIE NAME="myadmin_quiz_UUID_mobile" VALUE="#additem1.quiz_UUID#" EXPIRES="1">

					<CFIF #additem1.RECORDCOUNT# EQ 0>

						<CFSET resultStruct.toastCode = -1 />
                		<CFSET resultStruct.toastTitle = "error" />
                		<CFSET resultStruct.quiz_UUID = "x" />
                		<CFSET resultStruct.toastMessage = "Sorry, the quiz code is incorrect!" />
                		<CFRETURN RESULTSTRUCT />

						<CFABORT>

					</CFIF>

                    <CFQUERY NAME="additem2" DATASOURCE="#THIS.dsn#">

                        SELECT *,
							   CASE WHEN b.player_firstname IS NULL THEN SUBSTRING(b.player_email, 1, LOCATE('@', b.player_email) - 1)
									ELSE CONCAT(b.player_firstname, ' ', b.player_lastname) END AS player_name

                        	FROM players a
									LEFT JOIN players_details b ON a.player_details_UUID = b.player_details_UUID

                            WHERE a.username_hash = <CFQUERYPARAM VALUE="#THIS.username_hash#" CFSQLTYPE="cf_sql_varchar">

                    </CFQUERY>

					<CFQUERY NAME="additem3" DATASOURCE="#THIS.dsn#">

                        SELECT *

                        	FROM participants

                            WHERE quiz_UUID = <CFQUERYPARAM VALUE="#additem1.quiz_UUID#" CFSQLTYPE="cf_sql_varchar">
							AND player_UUID = <CFQUERYPARAM VALUE="#additem2.player_UUID#" CFSQLTYPE="cf_sql_varchar">

                    </CFQUERY>

					<CFIF #additem3.RECORDCOUNT# EQ 0>

						<CFIF #THIS.participant_team# EQ ''>

							<CFSET #THIS.participant_team# = #additem2.player_name# />

						</CFIF>

                    	<CFSET participant_UUID = #CreateUUID()# />

	                    <CFQUERY NAME="additem5" DATASOURCE="#THIS.dsn#">

	                        INSERT INTO participants (participant_UUID, player_UUID, quiz_UUID, participant_team, participant_accepted, participant_created, participant_score, participant_time)

	                            VALUES	(
	                                    <CFQUERYPARAM VALUE="#participant_UUID#" CFSQLTYPE="cf_sql_varchar">,
	                                    <CFQUERYPARAM VALUE="#additem2.player_UUID#" CFSQLTYPE="cf_sql_varchar">,
	                                    <CFQUERYPARAM VALUE="#additem1.quiz_UUID#" CFSQLTYPE="cf_sql_varchar">,
	                                    <CFQUERYPARAM VALUE="#THIS.participant_team#" CFSQLTYPE="cf_sql_varchar">,
	                                    <CFQUERYPARAM VALUE="no" CFSQLTYPE="cf_sql_varchar">,
	                                    <CFQUERYPARAM VALUE="#Now()#" CFSQLTYPE="cf_sql_timestamp">,
	                                    <CFQUERYPARAM VALUE="0" CFSQLTYPE="cf_sql_integer">,
	                                    <CFQUERYPARAM VALUE="0.0" CFSQLTYPE="cf_sql_float">
	                                    )

	                    </CFQUERY>

	                    <CFQUERY NAME="additem5" DATASOURCE="#THIS.dsn#">

	                        UPDATE players_details

	                            SET player_quizzes = player_quizzes + 1

	                            WHERE player_details_UUID = <CFQUERYPARAM VALUE="#additem2.player_details_UUID#" CFSQLTYPE="cf_sql_varchar">

	                    </CFQUERY>

					</CFIF>

                </CFTRANSACTION>

            </CFLOCK>

            <CFSET resultStruct.toastCode = 1 />
            <CFSET resultStruct.toastTitle = "success" />
            <CFSET resultStruct.quiz_UUID = #additem1.quiz_UUID# />
			<CFSET resultStruct.toastMessage = "Connected to the quiz!" />
            <CFRETURN RESULTSTRUCT />

            <CFCATCH>

            	<CFSET resultStruct.toastCode = -1 />
                <CFSET resultStruct.toastTitle = "error" />
                <CFSET resultStruct.quiz_UUID = "x" />
                <CFSET resultStruct.toastMessage = "Sorry, there was an error connecting to this quiz!" />
                <CFRETURN RESULTSTRUCT />

            </CFCATCH>

        </CFTRY>

	</CFFUNCTION>
	<!--- End Join Quiz --->


	<!--- Get Player Score --->
	<CFFUNCTION NAME="getPlayerScore" ACCESS="public" RETURNTYPE="query">

        <CFQUERY NAME="playerscore" DATASOURCE="#THIS.dsn#">

        	SELECT *,
				   b.participant_team

            	FROM players a
						LEFT JOIN participants b ON a.player_UUID = b.player_UUID
						LEFT JOIN players_details c ON a.player_details_UUID = c.player_details_UUID

                WHERE a.username_hash = <CFQUERYPARAM VALUE="#THIS.username_hash#" CFSQLTYPE="cf_sql_varchar" />
				AND b.quiz_UUID = <CFQUERYPARAM VALUE="#THIS.quiz_UUID#" CFSQLTYPE="cf_sql_varchar" />

        </CFQUERY>

		<CFRETURN playerscore />

	</CFFUNCTION>
	<!--- End Get Player Score --->


</CFCOMPONENT>
