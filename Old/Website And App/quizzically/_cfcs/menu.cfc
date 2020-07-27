
<CFCOMPONENT>

	<!--- Set THIS scope constructor variables --->
	<CFSET THIS.dsn = "" />
	<CFSET THIS.username_hash = "" />


    <!--- Get Menu Numbers --->
	<CFFUNCTION NAME="getMenuNumbers" ACCESS="public" RETURNTYPE="query">

		<CFQUERY NAME="userrole" DATASOURCE="#THIS.dsn#">

        	SELECT user_role_UUID

                FROM sys_users

                <CFIF THIS.username_hash NEQ ''>
                	WHERE username_hash = <CFQUERYPARAM VALUE="#THIS.username_hash#" CFSQLTYPE="cf_sql_varchar" />
                </CFIF>

        </CFQUERY>

        <CFQUERY NAME="menunumbers" DATASOURCE="#THIS.dsn#">

        	SELECT IFNULL(SUM(CASE WHEN a.quiz_cancelled IS NULL AND a.quiz_finished IS NULL THEN 1 ELSE 0 END), 0) AS ongoing_number,
                   IFNULL(SUM(CASE WHEN a.quiz_cancelled IS NOT NULL OR a.quiz_finished IS NOT NULL THEN 1 ELSE 0 END), 0) AS historic_number,
				   b.credits,
				   <CFIF userrole.user_role_UUID NEQ 'a88aaf23-0d3f-11e5-a315-38b1dbe2bc0e'>'Quiz Credits'<CFELSE>'Total Credits Sold'</CFIF> AS credits_label,
				   c.userscount,
				   d.deleteduserscount,
				   e.playerscount,
				   f.deletedplayerscount

                FROM (SELECT quiz_cancelled, quiz_finished FROM data_quizzes <CFIF userrole.user_role_UUID NEQ 'a88aaf23-0d3f-11e5-a315-38b1dbe2bc0e'>WHERE added_by = <CFQUERYPARAM VALUE="#THIS.username_hash#" CFSQLTYPE="cf_sql_varchar" /></CFIF>) a,
					 (SELECT SUM(IFNULL(paid_credits, 0) + IFNULL(free_credits, 0)) AS credits FROM sys_users WHERE deleted IS NULL <CFIF userrole.user_role_UUID NEQ 'a88aaf23-0d3f-11e5-a315-38b1dbe2bc0e'>AND username_hash = <CFQUERYPARAM VALUE="#THIS.username_hash#" CFSQLTYPE="cf_sql_varchar" /></CFIF>) b,
					 (SELECT IFNULL(COUNT(*), 0) AS userscount FROM sys_users WHERE deleted IS NULL AND user_role_UUID <> <CFQUERYPARAM VALUE="a88aaf23-0d3f-11e5-a315-38b1dbe2bc0e" CFSQLTYPE="cf_sql_varchar" />) c,
					 (SELECT IFNULL(COUNT(*), 0) AS deleteduserscount FROM sys_users WHERE deleted IS NOT NULL) d,
					 (SELECT IFNULL(COUNT(*), 0) AS playerscount FROM sys_players WHERE deleted IS NULL) e,
					 (SELECT IFNULL(COUNT(*), 0) AS deletedplayerscount FROM sys_players WHERE deleted IS NOT NULL) f

		</CFQUERY>

		<CFRETURN menunumbers />

	</CFFUNCTION>
	<!--- End Get Menu Numbers --->


</CFCOMPONENT>
