
<CFCOMPONENT HINT="dynamic component">


	<!--- Update Accepted --->
	<CFFUNCTION NAME="updateAccepted" ACCESS="remote">

        <CFARGUMENT NAME="dsn" />
		<CFARGUMENT NAME="participant_UUID" />

		<CFQUERY NAME="updateaccepted" DATASOURCE="#dsn#">

        	UPDATE participants

				SET participant_accepted = <CFQUERYPARAM VALUE="yes" CFSQLTYPE="cf_sql_varchar">

                WHERE participant_UUID = <CFQUERYPARAM VALUE="#participant_UUID#" CFSQLTYPE="cf_sql_varchar">

        </CFQUERY>

	</CFFUNCTION>
	<!--- End Update Accepted --->


</CFCOMPONENT>
