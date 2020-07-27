
<CFCOMPONENT>

	<!--- Set THIS scope constructor variables --->
	<CFSET THIS.dsn = "" />
	<CFSET THIS.action = "" />
    <CFSET THIS.user_role_UUID = "" />


    <!--- Get quizmaster roles --->
	<CFFUNCTION NAME="getUserRoles" ACCESS="public" RETURNTYPE="query">

		<CFQUERY NAME="userroles" DATASOURCE="#THIS.dsn#">

			SELECT *

                FROM sys_users_roles

                <CFIF THIS.user_role_UUID NEQ 'a88aaf23-0d3f-11e5-a315-38b1dbe2bc0e'>
                	WHERE user_role_UUID <> <CFQUERYPARAM VALUE="a88aaf23-0d3f-11e5-a315-38b1dbe2bc0e" CFSQLTYPE="cf_sql_varchar" />
                </CFIF>

                ORDER BY user_role_order ASC

		</CFQUERY>

		<CFRETURN userroles />

	</CFFUNCTION>
	<!--- End Get quizmaster roles --->

    <!--- Get locations --->
	<CFFUNCTION NAME="getLocations" ACCESS="public" RETURNTYPE="query">

        <CFQUERY NAME="locations" DATASOURCE="#THIS.dsn#">

        	SELECT *

            	FROM sys_locations

                WHERE deleted IS NULL

                AND location_type = 'Normal'

        </CFQUERY>

		<CFRETURN locations />

	</CFFUNCTION>
	<!--- End Get locations --->

	<!--- Get categories --->
	<CFFUNCTION NAME="getCategories" ACCESS="public" RETURNTYPE="query">

        <CFQUERY NAME="categorydetails" DATASOURCE="#THIS.dsn#">

        	SELECT *

            	FROM sys_categories

                WHERE deleted IS NULL

                ORDER BY category_order ASC

        </CFQUERY>

		<CFRETURN categorydetails />

	</CFFUNCTION>
	<!--- End Get categories --->


</CFCOMPONENT>
