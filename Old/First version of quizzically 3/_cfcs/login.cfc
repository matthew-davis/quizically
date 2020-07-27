<CFCOMPONENT HINT="dynamic component">
	
	<!--- Set THIS scope constructor variables --->	
	<CFSET THIS.dsn = "" />
	
    <CFSET THIS.myadmin_username = "" />
	<CFSET THIS.myadmin_password = "" />


	<!--- Logged In User Details --->
	<CFFUNCTION NAME="getLoginDetails" ACCESS="public" RETURNTYPE="query">
			
         <CFQUERY NAME="logindetails1" DATASOURCE="#THIS.dsn#">
			SELECT user_UUID
            
            	FROM users
                
                WHERE username_hash = <CFQUERYPARAM VALUE="#myadmin_username#" CFSQLTYPE="cf_sql_varchar">
        		AND password_hash = <CFQUERYPARAM VALUE="#myadmin_password#" CFSQLTYPE="cf_sql_varchar">
                    
		</CFQUERY>   
 
		<CFQUERY NAME="logindetails2" DATASOURCE="#THIS.dsn#">
			SELECT *,
            	   a.added_date AS member_since,
            	   SUBSTRING(b.user_email, 1, LOCATE('@', b.user_email) - 1) AS email_name,
            	   CASE WHEN b.modified_date IS NULL THEN b.added_date ELSE b.modified_date END AS last_modified,
                   d.last_login,
                   IFNULL(a.paid_credits, 0) + IFNULL(a.free_credits, 0) AS credits
            
            	FROM users a
                		LEFT JOIN users_details b ON a.user_details_UUID = b.user_details_UUID
                        LEFT JOIN users_roles c ON a.user_role_UUID = c.user_role_UUID
                		LEFT JOIN (SELECT user_UUID, MAX(login_date) AS last_login FROM logins GROUP BY user_UUID) d ON a.user_UUID = d.user_UUID
                
                WHERE a.deleted IS NULL

				AND a.user_UUID = <CFQUERYPARAM VALUE="#logindetails1.user_UUID#" CFSQLTYPE="cf_sql_varchar" />
                    
		</CFQUERY>
		
		<CFRETURN logindetails2 />
	
	</CFFUNCTION>
	<!--- End Logged In User Details ---> 


</CFCOMPONENT>
