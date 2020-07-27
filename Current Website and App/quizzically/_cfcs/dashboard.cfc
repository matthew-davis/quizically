
<CFCOMPONENT>

	<!--- Set THIS scope constructor variables --->
	<CFSET THIS.dsn = "" />
	<CFSET THIS.username_hash = "" />


	<!--- Latest Quizzes --->
	<CFFUNCTION NAME="getLatestQuizzes" ACCESS="public" RETURNTYPE="query">

        <CFQUERY NAME="quizlist" DATASOURCE="#THIS.dsn#" MAXROWS="4">

        	SELECT *,
				   IFNULL(e.score, 0) AS quiz_score

            	FROM data_quizzes a
                		LEFT JOIN sys_locations b ON a.location_UUID = b.location_UUID
                        LEFT JOIN sys_users c ON a.quiz_winner = c.user_UUID
                        LEFT JOIN sys_users_details d ON c.user_details_UUID = d.user_details_UUID
						LEFT JOIN (SELECT quiz_UUID, MAX(participant_score) AS score FROM data_participants GROUP BY quiz_UUID) e ON a.quiz_UUID = e.quiz_UUID

                <CFIF THIS.username_hash NEQ ''>
                	WHERE a.added_by = <CFQUERYPARAM VALUE="#THIS.username_hash#" CFSQLTYPE="cf_sql_varchar" />
                </CFIF>

                ORDER BY quiz_created DESC

        </CFQUERY>

		<CFRETURN quizlist />

	</CFFUNCTION>
	<!--- End Latest Quizzes --->


	<!--- Daily Quizzes --->
	<CFFUNCTION NAME="getDailyQuizzes" ACCESS="public" RETURNTYPE="query">

		<CFQUERY NAME="dailyquizzess" DATASOURCE="#THIS.dsn#">

           SELECT IFNULL(ROUND((SUM(CASE WHEN DAYOFWEEK(quiz_created) = 2 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2), 0.00) AS monday_quizzes,
                  IFNULL(ROUND((SUM(CASE WHEN DAYOFWEEK(quiz_created) = 3 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2), 0.00) AS tuesday_quizzes,
                  IFNULL(ROUND((SUM(CASE WHEN DAYOFWEEK(quiz_created) = 4 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2), 0.00) AS wednesday_quizzes,
            	  IFNULL(ROUND((SUM(CASE WHEN DAYOFWEEK(quiz_created) = 5 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2), 0.00) AS thursday_quizzes,
            	  IFNULL(ROUND((SUM(CASE WHEN DAYOFWEEK(quiz_created) = 6 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2), 0.00) AS friday_quizzes,
             	  IFNULL(ROUND((SUM(CASE WHEN DAYOFWEEK(quiz_created) = 7 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2), 0.00) AS saturday_quizzes,
                  IFNULL(ROUND((SUM(CASE WHEN DAYOFWEEK(quiz_created) = 1 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2), 0.00) AS sunday_quizzes

            	FROM data_quizzes

                WHERE quiz_cancelled IS NULL

                AND quiz_created BETWEEN DATE_FORMAT(NOW(), '%Y-%m-01') AND NOW()

		</CFQUERY>

		<CFRETURN dailyquizzess />

	</CFFUNCTION>
	<!--- End Daily Quizzes --->


    <!--- Daily Credits --->
	<CFFUNCTION NAME="getDailyCredits" ACCESS="public" RETURNTYPE="query">

		<CFQUERY NAME="dailyquizzess" DATASOURCE="#THIS.dsn#">

           SELECT IFNULL(ROUND((SUM(CASE WHEN DAYOFWEEK(credit_bought) = 2 THEN credits ELSE 0 END) / SUM(credits)) * 100, 2), 0.00) AS monday_credits,
                  IFNULL(ROUND((SUM(CASE WHEN DAYOFWEEK(credit_bought) = 3 THEN credits ELSE 0 END) / SUM(credits)) * 100, 2), 0.00) AS tuesday_credits,
                  IFNULL(ROUND((SUM(CASE WHEN DAYOFWEEK(credit_bought) = 4 THEN credits ELSE 0 END) / SUM(credits)) * 100, 2), 0.00) AS wednesday_credits,
            	  IFNULL(ROUND((SUM(CASE WHEN DAYOFWEEK(credit_bought) = 5 THEN credits ELSE 0 END) / SUM(credits)) * 100, 2), 0.00) AS thursday_credits,
            	  IFNULL(ROUND((SUM(CASE WHEN DAYOFWEEK(credit_bought) = 6 THEN credits ELSE 0 END) / SUM(credits)) * 100, 2), 0.00) AS friday_credits,
             	  IFNULL(ROUND((SUM(CASE WHEN DAYOFWEEK(credit_bought) = 7 THEN credits ELSE 0 END) / SUM(credits)) * 100, 2), 0.00) AS saturday_credits,
                  IFNULL(ROUND((SUM(CASE WHEN DAYOFWEEK(credit_bought) = 1 THEN credits ELSE 0 END) / SUM(credits)) * 100, 2), 0.00) AS sunday_credits

            	FROM data_credits

                WHERE credit_bought BETWEEN DATE_FORMAT(NOW(), '%Y-%m-01') AND NOW()

		</CFQUERY>

		<CFRETURN dailyquizzess />

	</CFFUNCTION>
	<!--- End Daily Credits --->


</CFCOMPONENT>
