<CFCOMPONENT HINT="dynamic component">

	<!--- Set THIS scope constructor variables --->
	<CFSET THIS.dsn = "" />


	<!--- Get Quote --->
	<CFFUNCTION NAME="getQuote" ACCESS="public" RETURNTYPE="query">

		<CFQUERY NAME="quote" DATASOURCE="#THIS.dsn#">

			SELECT quote_person,
            	   quote

            	FROM sys_quotes

                ORDER BY RAND()

				LIMIT 1

		</CFQUERY>

		<CFRETURN quote />

	</CFFUNCTION>
	<!--- End Get Quote --->


</CFCOMPONENT>
