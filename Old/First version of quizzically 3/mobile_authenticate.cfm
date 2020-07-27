
<!--- Set the default username and password to x --->
<CFSET myadmin_username_hash_mobile = 'x'>
<CFSET myadmin_password_hash_mobile = 'x'>

<!--- Logging in using the session username and password hashes --->
<CFIF #IsDefined('cookie.myadmin_username_mobile')# AND #IsDefined('cookie.myadmin_password_mobile')# AND #cookie.myadmin_username_mobile# NEQ -99 AND #cookie.myadmin_password_mobile# NEQ -99>

    <CFSET myadmin_login_mobile = 'no' />
	<CFSET myadmin_username_hash_mobile = #cookie.myadmin_username_mobile#>
	<CFSET myadmin_password_hash_mobile = #cookie.myadmin_password_mobile#>

<CFELSE>

	<CFSET myadmin_login_mobile = 'yes' />

	<!--- Logging in using the sign in form--->
	<CFIF #IsDefined('form.player_username')# AND #IsDefined('form.player_password')#>

        <CFSET myID = '#request.mysalt#' & '#form.player_username#' & '#request.mysalt#'>
        <CFSET mypassword = '#request.mysalt#' & '#form.player_password#' & '#request.mysalt#'>
        <CFSET myadmin_username_hash_mobile = #hash(myID)#>
        <CFSET myadmin_password_hash_mobile = #hash(mypassword)#>

 	<!--- Logging in using the remember me method and rememeber cookies --->
	<CFELSEIF #IsDefined('cookie.remember_username_mobile')# AND #IsDefined('cookie.remember_password_mobile')# AND #cookie.remember_username_mobile# NEQ -99 AND #cookie.remember_password_mobile# NEQ -99>

        <CFSET myadmin_username_hash_mobile = #cookie.remember_username_mobile#>
        <CFSET myadmin_password_hash_mobile = #cookie.remember_password_mobile#>

    <!--- Self Registering as a Player --->
	<CFELSEIF #IsDefined('form.player_repeatpassword')#>

        <CFQUERY NAME="register1" DATASOURCE="#dsn#">

            SELECT 1 AS test

                FROM players a, players_details b

                WHERE a.player_details_UUID = b.player_details_UUID
                AND a.deleted IS NULL
                AND b.player_email = <CFQUERYPARAM VALUE="#form.player_email#" CFSQLTYPE="cf_sql_varchar">

        </CFQUERY>

        <CFIF register1.test EQ 1>

            <CFLOCATION URL="../mobile_register.cfm?mymessage=Sorry,%20Email%20has%20already%20been%20used!" />
            <CFABORT>

        <CFELSEIF form.player_password NEQ form.player_repeatpassword>

            <CFLOCATION URL="../mobile_register.cfm?mymessage=Sorry,%20Password%20and%20Repeat%20don't%20match!" />
            <CFABORT>

        <CFELSEIF NOT #IsDefined('form.player_terms')#>

            <CFLOCATION URL="../mobile_register.cfm?mymessage=Sorry,%20the%20terms%20must%20be%20accepted!" />
            <CFABORT>

        <CFELSE>

            <CFTRY>

                <CFLOCK TIMEOUT="20">

                    <CFTRANSACTION>

                        <CFSET player_details_UUID = #CreateUUID()# />

                        <CFQUERY NAME="register2" DATASOURCE="#dsn#">

                            INSERT INTO players_details (player_details_UUID, player_firstname, player_email, player_quizzes, added_by, added_date)
                                VALUES	(
                                        <CFQUERYPARAM VALUE="#player_details_UUID#" CFSQLTYPE="cf_sql_varchar">,
                                        <CFIF form.player_firstname is not "">
                                            <CFQUERYPARAM VALUE="#form.player_firstname#" CFSQLTYPE="cf_sql_varchar">
                                        <CFELSE>
                                            <CFQUERYPARAM VALUE="" CFSQLTYPE="cf_sql_varchar" null="yes">
                                        </CFIF>,
                                        <CFQUERYPARAM VALUE="#form.player_email#" CFSQLTYPE="cf_sql_varchar">,
										<CFQUERYPARAM VALUE="0" CFSQLTYPE="cf_sql_integer">,
                                        <CFQUERYPARAM VALUE="Self Registered" CFSQLTYPE="cf_sql_varchar">,
                                        <CFQUERYPARAM VALUE="#Now()#" CFSQLTYPE="cf_sql_timestamp">
                                        )

                        </CFQUERY>

                        <CFSET myID = "#request.mysalt#" & "#form.player_email#" & "#request.mysalt#">
                        <CFSET mypassword = "#request.mysalt#" & "#form.player_password#" & "#request.mysalt#">
                        <CFSET myadmin_username_hash_mobile = #hash(myID)#>
                        <CFSET myadmin_password_hash_mobile = #hash(mypassword)#>

                        <CFQUERY NAME="register3" DATASOURCE="#dsn#">

                            INSERT INTO players (player_UUID, username_hash, password_hash, player_details_UUID, added_by, added_date)

                                VALUES (
                                        <CFQUERYPARAM VALUE="#CreateUUID()#" CFSQLTYPE="cf_sql_varchar">,
                                        <CFQUERYPARAM VALUE="#myadmin_username_hash_mobile#" CFSQLTYPE="cf_sql_varchar">,
                                        <CFQUERYPARAM VALUE="#myadmin_password_hash_mobile#" CFSQLTYPE="cf_sql_varchar">,
                                        <CFQUERYPARAM VALUE="#player_details_UUID#" CFSQLTYPE="cf_sql_varchar">,
                                        <CFQUERYPARAM VALUE="Self Registered" CFSQLTYPE="cf_sql_varchar">,
                                        <CFQUERYPARAM VALUE="#Now()#" CFSQLTYPE="cf_sql_timestamp">
                                       )

                        </CFQUERY>

                    </CFTRANSACTION>

                </CFLOCK>

                <CFCATCH>

                    <CFLOCATION URL="../mobile_register.cfm?mymessage=Sorry,%20there%20was%20an%20error%20while%20registering!" />
                    <CFABORT>

                </CFCATCH>

            </CFTRY>

        </CFIF>

    </CFIF>

</CFIF>


<!--- Get the user from the system if he currently exists --->
<CFQUERY NAME="getplayer" DATASOURCE="#dsn#">

    SELECT *

        FROM players a
                LEFT JOIN players_details b ON a.player_details_UUID = b.player_details_UUID

        WHERE a.deleted IS NULL

        AND a.username_hash = <CFQUERYPARAM VALUE="#myadmin_username_hash_mobile#" CFSQLTYPE="cf_sql_varchar">
        AND a.password_hash = <CFQUERYPARAM VALUE="#myadmin_password_hash_mobile#" CFSQLTYPE="cf_sql_varchar">

</CFQUERY>


<!--- If needed record the date and time that the user logged into the system --->
<CFIF (#myadmin_login_mobile# EQ 'yes') AND (#getplayer.player_UUID# NEQ "")>

    <CFQUERY NAME="loginplayer" DATASOURCE="#dsn#">

        INSERT INTO logins (login_UUID, player_UUID, login_date)
            VALUES (
                    <CFQUERYPARAM VALUE="#CreateUUID()#" CFSQLTYPE="cf_sql_varchar">,
                    <CFQUERYPARAM VALUE="#getplayer.player_UUID#" CFSQLTYPE="cf_sql_varchar">,
                    <CFQUERYPARAM VALUE="#Now()#" CFSQLTYPE="cf_sql_timestamp">
                    )

    </CFQUERY>

</CFIF>




<!--- Check whether the user record was found. If not direct to the login page. --->
<CFIF #getplayer.RecordCount# EQ 1>

	<CFIF (#IsDefined('form.player_remember')#) OR (#IsDefined('cookie.remember_username_mobile')# AND #IsDefined('cookie.remember_password_mobile')#)>
    	<CFCOOKIE NAME="remember_username_mobile" VALUE="#getplayer.username_hash#" EXPIRES="21">
    	<CFCOOKIE NAME="remember_password_mobile" VALUE="#getplayer.password_hash#" EXPIRES="21">
    </CFIF>

	<CFCOOKIE NAME="myadmin_username_mobile" VALUE="#getplayer.username_hash#" EXPIRES="1">
    <CFCOOKIE NAME="myadmin_password_mobile" VALUE="#getplayer.password_hash#" EXPIRES="1">

<CFELSE>

	<CFCOOKIE NAME="remember_username_mobile" VALUE="-99" EXPIRES="NOW">
    <CFCOOKIE NAME="remember_password_mobile" VALUE="-99" EXPIRES="NOW">
    <CFCOOKIE NAME="myadmin_username_mobile" VALUE="-99" EXPIRES="NOW">
    <CFCOOKIE NAME="myadmin_password_mobile" VALUE="-99" EXPIRES="NOW">

	<CFLOCATION URL="../mobile_login.cfm?mymessage=Sorry,%20there%20was%20an%20issue%20signing%20in." />
    <CFABORT>

</CFIF>
