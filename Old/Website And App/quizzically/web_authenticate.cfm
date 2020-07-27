
<!--- Set the default username and password to x --->
<CFSET myadmin_username_hash = 'x' />
<CFSET myadmin_password_hash = 'x' />

<!--- Logging in using the session username and password hashes --->
<CFIF #IsDefined('cookie.myadmin_username')# AND #IsDefined('cookie.myadmin_password')# AND #cookie.myadmin_username# NEQ -99 AND #cookie.myadmin_password# NEQ -99>

    <CFSET myadmin_login = 'no' />
	<CFSET myadmin_username_hash = #cookie.myadmin_username# />
	<CFSET myadmin_password_hash = #cookie.myadmin_password# />

<CFELSE>

	<CFSET myadmin_login = 'yes' />

	<!--- Logging in using the sign in form--->
	<CFIF #IsDefined('form.admin_username')# AND #IsDefined('form.admin_password')#>

        <CFSET myID = '#request.mysalt#' & '#form.admin_username#' & '#request.mysalt#' />
        <CFSET mypassword = '#request.mysalt#' & '#form.admin_password#' & '#request.mysalt#' />
        <CFSET myadmin_username_hash = #hash(myID)# />
        <CFSET myadmin_password_hash = #hash(mypassword)# />

 	<!--- Logging in using the remember me method and rememeber cookies --->
	<CFELSEIF #IsDefined('cookie.remember_username')# AND #IsDefined('cookie.remember_password')# AND #cookie.remember_username# NEQ -99 AND #cookie.remember_password# NEQ -99>

        <CFSET myadmin_username_hash = #cookie.remember_username# />
        <CFSET myadmin_password_hash = #cookie.remember_password# />

    <!--- Self Registering as a Quizmaster --->
	<CFELSEIF #IsDefined('form.user_repeatpassword')#>

        <CFQUERY NAME="register1" DATASOURCE="#dsn#">

            SELECT 1 AS test

                FROM sys_users a, sys_users_details b

                WHERE a.user_details_UUID = b.user_details_UUID
                AND a.deleted IS NULL
                AND b.user_email = <CFQUERYPARAM VALUE="#form.user_email#" CFSQLTYPE="cf_sql_varchar" />

        </CFQUERY>

        <CFIF register1.test EQ 1>

			<CFLOCATION URL="../register.cfm?toastCode=-1&toastTitle=User%20Details%20Error&toastMessage=Sorry,%20the%20email%20address%20has%20already%20been%20used!" />
			<CFABORT />

        <CFELSEIF form.user_password NEQ form.user_repeatpassword>

			<CFLOCATION URL="../register.cfm?toastCode=-1&toastTitle=User%20Details%20Error&toastMessage=Sorry,%20the%20password%20and%20repeat%20password%20don't%20match!" />
			<CFABORT />

        <CFELSEIF NOT #IsDefined('form.user_terms')#>

			<CFLOCATION URL="../register.cfm?toastCode=-1&toastTitle=User%20Details%20Error&toastMessage=Sorry,%20the%20terms%20must%20be%20accepted!" />
            <CFABORT />

        <CFELSE>

			<CFTRY>

                <CFLOCK TIMEOUT="20">

                    <CFTRANSACTION>

                        <CFSET user_details_UUID = #CreateUUID()# />

                        <CFQUERY NAME="register2" DATASOURCE="#dsn#">

                            INSERT INTO sys_users_details (user_details_UUID, user_firstname, user_email, added_by, added_date)

								VALUES	(
                                        <CFQUERYPARAM VALUE="#user_details_UUID#" CFSQLTYPE="cf_sql_varchar">,
                                        <CFIF form.user_firstname is not "">
                                            <CFQUERYPARAM VALUE="#form.user_firstname#" CFSQLTYPE="cf_sql_varchar">
                                        <CFELSE>
                                            <CFQUERYPARAM VALUE="" CFSQLTYPE="cf_sql_varchar" null="yes">
                                        </CFIF>,
                                        <CFQUERYPARAM VALUE="#form.user_email#" CFSQLTYPE="cf_sql_varchar">,
                                        <CFQUERYPARAM VALUE="Self Registered" CFSQLTYPE="cf_sql_varchar">,
                                        <CFQUERYPARAM VALUE="#Now()#" CFSQLTYPE="cf_sql_timestamp">
                                        )

                        </CFQUERY>

                        <CFSET myID = "#request.mysalt#" & "#form.user_email#" & "#request.mysalt#">
                        <CFSET mypassword = "#request.mysalt#" & "#form.user_password#" & "#request.mysalt#">
                        <CFSET myadmin_username_hash = #hash(myID)#>
                        <CFSET myadmin_password_hash = #hash(mypassword)#>

                        <CFQUERY NAME="register3" DATASOURCE="#dsn#">

                            INSERT INTO sys_users (user_UUID, username_hash, password_hash, user_role_UUID, user_details_UUID, added_by, added_date)

                                VALUES (
                                        <CFQUERYPARAM VALUE="#CreateUUID()#" CFSQLTYPE="cf_sql_varchar">,
                                        <CFQUERYPARAM VALUE="#myadmin_username_hash#" CFSQLTYPE="cf_sql_varchar">,
                                        <CFQUERYPARAM VALUE="#myadmin_password_hash#" CFSQLTYPE="cf_sql_varchar">,
                                        <CFQUERYPARAM VALUE="87fc3819-0d3f-11e5-a315-38b1dbe2bc0e" CFSQLTYPE="cf_sql_varchar">,
                                        <CFQUERYPARAM VALUE="#user_details_UUID#" CFSQLTYPE="cf_sql_varchar">,
                                        <CFQUERYPARAM VALUE="Self Registered" CFSQLTYPE="cf_sql_varchar">,
                                        <CFQUERYPARAM VALUE="#Now()#" CFSQLTYPE="cf_sql_timestamp">
                                       )

                        </CFQUERY>

                    </CFTRANSACTION>

                </CFLOCK>

                <CFCATCH>

					<CFLOCATION URL="../register.cfm?toastCode=-1&toastTitle=User%20Details%20Error&toastMessage=Sorry,%20there%20was%20an%20error%20while%20registering!" />
                    <CFABORT />

                </CFCATCH>

            </CFTRY>

        </CFIF>

    </CFIF>

</CFIF>


<!--- Get the user from the system if he currently exists --->
<CFQUERY NAME="logindetails" DATASOURCE="#dsn#">

    SELECT *,
		   a.added_date AS member_since,
           SUBSTRING(b.user_email, 1, LOCATE('@', b.user_email) - 1) AS email_name,
           CASE WHEN b.modified_date IS NULL THEN b.added_date ELSE b.modified_date END AS last_modified,
           d.last_login,
           IFNULL(a.paid_credits, 0) + IFNULL(a.free_credits, 0) AS credits

        FROM sys_users a
                LEFT JOIN sys_users_details b ON a.user_details_UUID = b.user_details_UUID
                LEFT JOIN sys_users_roles c ON a.user_role_UUID = c.user_role_UUID
				LEFT JOIN (SELECT user_UUID, MAX(login_date) AS last_login FROM sys_logins GROUP BY user_UUID) d ON a.user_UUID = d.user_UUID

        WHERE a.deleted IS NULL

        AND a.username_hash = <CFQUERYPARAM VALUE="#myadmin_username_hash#" CFSQLTYPE="cf_sql_varchar" />
        AND a.password_hash = <CFQUERYPARAM VALUE="#myadmin_password_hash#" CFSQLTYPE="cf_sql_varchar" />

</CFQUERY>


<!--- If needed record the date and time that the user logged into the system --->
<CFIF (#myadmin_login# EQ 'yes') AND (#logindetails.user_UUID# NEQ "")>

    <CFQUERY NAME="loginuser" DATASOURCE="#dsn#">

        INSERT INTO sys_logins (login_UUID, user_UUID, login_date)
            VALUES (
                    <CFQUERYPARAM VALUE="#CreateUUID()#" CFSQLTYPE="cf_sql_varchar" />,
                    <CFQUERYPARAM VALUE="#logindetails.user_UUID#" CFSQLTYPE="cf_sql_varchar" />,
                    <CFQUERYPARAM VALUE="#Now()#" CFSQLTYPE="cf_sql_timestamp" />
                    )

    </CFQUERY>

</CFIF>


<!--- Check whether the user record was found. If not direct to the login page. --->
<CFIF #logindetails.RecordCount# EQ 1>

	<CFIF (#IsDefined('form.remember')#) OR (#IsDefined('cookie.remember_username')# AND #IsDefined('cookie.remember_password')#)>
    	<CFCOOKIE NAME="remember_username" VALUE="#logindetails.username_hash#" EXPIRES="21" />
    	<CFCOOKIE NAME="remember_password" VALUE="#logindetails.password_hash#" EXPIRES="21" />
    </CFIF>

	<CFCOOKIE NAME="myadmin_username" VALUE="#logindetails.username_hash#" EXPIRES="1" />
    <CFCOOKIE NAME="myadmin_password" VALUE="#logindetails.password_hash#" EXPIRES="1" />

<CFELSE>

	<CFCOOKIE NAME="remember_username" VALUE="-99" EXPIRES="NOW" />
    <CFCOOKIE NAME="remember_password" VALUE="-99" EXPIRES="NOW" />
    <CFCOOKIE NAME="myadmin_username" VALUE="-99" EXPIRES="NOW" />
    <CFCOOKIE NAME="myadmin_password" VALUE="-99" EXPIRES="NOW" />

	<CFLOCATION URL="../web_login.cfm?toastCode=-1&toastTitle=User%20Details%20Error&toastMessage=Sorry,%20there%20was%20an%20error%20signing%20in!" />
    <CFABORT />

</CFIF>
