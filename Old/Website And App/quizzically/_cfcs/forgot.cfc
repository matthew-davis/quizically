<CFCOMPONENT>

	<!--- set THIS scope constructor variables --->
	<CFSET THIS.dsn = "" />
	<CFSET THIS.format = "" />

	<CFSET THIS.admin_email = "" />

    <CFSET THIS.username_hash = "" />
    <CFSET THIS.password = "" />


	<CFFUNCTION NAME="forgotProcess" ACCESS="public" RETURNTYPE="struct">

		<CFTRY>

            <CFSET myID = '#request.mysalt#' & '#THIS.admin_email#' & '#request.mysalt#'>
            <CFSET email_hash = #hash(myID)#>

			<CFIF THIS.format EQ 'web'>

	        	<CFQUERY NAME="forgot1" DATASOURCE="#THIS.dsn#">

	                SELECT *

	                	FROM sys_users

	                    WHERE deleted IS NULL

						<CFIF THIS.admin_email NEQ "">
							AND username_hash = <CFQUERYPARAM VALUE="#email_hash#" CFSQLTYPE="cf_sql_varchar" />
						</CFIF>

				</CFQUERY>

			<CFELSE>

				<CFQUERY NAME="forgot1" DATASOURCE="#THIS.dsn#">

	                SELECT *

	                	FROM sys_players

	                    WHERE deleted IS NULL

						<CFIF THIS.admin_email NEQ "">
							AND username_hash = <CFQUERYPARAM VALUE="#email_hash#" CFSQLTYPE="cf_sql_varchar" />
						</CFIF>

				</CFQUERY>

			</CFIF>

			<!--- If user is in the database --->
			<CFIF forgot1.RECORDCOUNT NEQ 0>

				<!--- CFMAIL --->
			   	<CFMAIL FROM="#request.adminemail#" TO="#THIS.admin_email#" FAILTO="#request.adminemail#" TYPE="html" SUBJECT="quizzically - Reset Password">

                	<html>

                       	<head>
                           	<style>
								body {
									font-family: Verdana, Arial, Helvetica, sans-serif;
									font-size: 12px;
									font-weight: normal;
									background: rgb(246, 244, 245);
									margin:10px 10px 10px 10px !important;
								}

								a {
									color: rgb(65, 55, 44);
									text-decoration: none;
								}

								a:link {
									color: rgb(158, 55, 3);
									text-decoration: none;
								}

								a:visited {
									color: rgb(158, 55, 3);
									text-decoration: none;
								}

								a:active {
									color: rgb(158, 55, 3);
									text-decoration: none;
								}

								a:hover	{
									color: rgb(158, 55, 3);
									text-decoration: underline;
								}
							</style>
                       	</head>

                       	<body>

                        	<img src="http://www.quizzically.co.uk/quizzically/_img/logo.png" width="300">

                            <br />

							<p>We have received a request to reset your quizzically password.</p>
							<p>If you requested this password reset, please click on the link below to reset your password.</p>

							<CFOUTPUT>
								<p>
                                	<a href="http://www.quizzically.co.uk/quizzically/forgot/password_reset.cfm?format=#url.format#&username_hash=#forgot1.username_hash#&email=#THIS.admin_email#">
                                       	http://www.quizzically.co.uk/quizzically/forgot/password_reset.cfm?format=#url.format#&username_hash=#forgot1.username_hash#&email=#THIS.admin_email#
                                    </a>
                                </p>
							</CFOUTPUT>

                       		<p>If you did not request this password reset please ignore this email.</p>

                            <br />

                            <p>Best,</p>

                            <p>quizzically Team</p>

						</body>

					</html>

           		</CFMAIL>

				<CFSET resultStruct.toastCode = 1 />
                <CFSET resultStruct.toastTitle = "Success" />
                <CFSET resultStruct.toastMessage = "We have emailed #THIS.admin_email# a link to reset your password!" />
                <CFRETURN RESULTSTRUCT />

			<CFELSE>

				<CFSET resultStruct.toastCode = -1 />
	            <CFSET resultStruct.toastTitle = "Error" />
	            <CFSET resultStruct.toastMessage = "Sorry, #THIS.admin_email# does not exist in the system!" />
	            <CFRETURN resultStruct />

			</CFIF>

            <CFCATCH>

                <CFSET resultStruct.toastCode = -1 />
                <CFSET resultStruct.toastTitle = "Error" />
                <CFSET resultStruct.toastMessage = "Sorry, there was an error retrieving your details!" />
                <CFRETURN resultStruct />

           	</CFCATCH>

		</CFTRY>

	</CFFUNCTION>

	<CFFUNCTION NAME="passwordReset" ACCESS="public" RETURNTYPE="struct">

        <CFSET mypass = '#request.mysalt#' & '#THIS.password#' & '#request.mysalt#'>
        <CFSET change_password_hash = #hash(mypass)#>

		<CFTRY>

			<CFIF THIS.format EQ 'web'>

	        	<CFQUERY NAME="password1" DATASOURCE="#THIS.dsn#">

	                UPDATE sys_users

	                    SET password_hash = <CFQUERYPARAM VALUE="#change_password_hash#" CFSQLTYPE="cf_sql_varchar" />

	                    WHERE username_hash = <CFQUERYPARAM VALUE="#THIS.username_hash#" CFSQLTYPE="cf_sql_varchar" />

            	</CFQUERY>

			<CFELSE>

				<CFQUERY NAME="password1" DATASOURCE="#THIS.dsn#">

	                UPDATE sys_players

	                    SET password_hash = <CFQUERYPARAM VALUE="#change_password_hash#" CFSQLTYPE="cf_sql_varchar" />

	                    WHERE username_hash = <CFQUERYPARAM VALUE="#THIS.username_hash#" CFSQLTYPE="cf_sql_varchar" />

            	</CFQUERY>

			</CFIF>

            <CFSET resultStruct.toastCode = 1 />
            <CFSET resultStruct.toastTitle = "Success" />
            <CFSET resultStruct.toastMessage = "Your password has been updated!" />
            <CFRETURN resultStruct />

            <CFCATCH>

               <CFSET resultStruct.toastCode = -1 />
               <CFSET resultStruct.toastTitle = "Error" />
               <CFSET resultStruct.toastMessage = "Sorry, there was an error updating your password!" />
               <CFRETURN resultStruct />

           </CFCATCH>

       </CFTRY>

	</CFFUNCTION>


</CFCOMPONENT>
