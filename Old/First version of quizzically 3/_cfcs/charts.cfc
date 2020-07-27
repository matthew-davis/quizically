<CFCOMPONENT>
	
	<!--- Set THIS scope constructor variables --->	
	<CFSET THIS.dsn = "" />


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
         
            	FROM quizzes

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
         
            	FROM credits

                WHERE credit_bought BETWEEN DATE_FORMAT(NOW(), '%Y-%m-01') AND NOW()
    
		</CFQUERY>
		
		<CFRETURN dailyquizzess />
	
	</CFFUNCTION>
	<!--- End Daily Credits ---> 


</CFCOMPONENT>
