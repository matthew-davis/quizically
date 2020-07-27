<CFCOMPONENT HINT="dynamic component">

	<!--- Set THIS scope constructor variables --->
	<CFSET THIS.dsn = "" />

    <CFSET THIS.username = "" />
	<CFSET THIS.password = "" />


	<!--- Logged In User Details --->
	<CFFUNCTION NAME="getLoginDetails" ACCESS="public" RETURNTYPE="query">

         <CFQUERY NAME="logindetails1" DATASOURCE="#THIS.dsn#">
			SELECT player_UUID

            	FROM players

                WHERE deleted IS NULL

                AND username_hash = <CFQUERYPARAM VALUE="#THIS.username#" CFSQLTYPE="cf_sql_varchar">
        		AND password_hash = <CFQUERYPARAM VALUE="#THIS.password#" CFSQLTYPE="cf_sql_varchar">

		</CFQUERY>

		<CFQUERY NAME="logindetails2" DATASOURCE="#THIS.dsn#">
			SELECT *,
            	   a.added_date AS member_since,
            	   SUBSTRING(b.player_email, 1, LOCATE('@', b.player_email) - 1) AS email_name,
            	   CASE WHEN b.modified_date IS NULL THEN b.added_date ELSE b.modified_date END AS last_modified,
                   d.last_login

            	FROM players a
                		LEFT JOIN players_details b ON a.player_details_UUID = b.player_details_UUID
                		LEFT JOIN (SELECT player_UUID, MAX(login_date) AS last_login FROM logins GROUP BY player_UUID) d ON a.player_UUID = d.player_UUID

                WHERE a.deleted IS NULL

				AND a.player_UUID = <CFQUERYPARAM VALUE="#logindetails1.player_UUID#" CFSQLTYPE="cf_sql_varchar" />

		</CFQUERY>

		<CFRETURN logindetails2 />

	</CFFUNCTION>
	<!--- End Logged In User Details --->


</CFCOMPONENT>
