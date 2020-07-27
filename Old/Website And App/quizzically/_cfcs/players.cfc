
<CFCOMPONENT>

    <!--- Set THIS scope constructor variables --->
	<CFSET THIS.dsn = "" />
	<CFSET THIS.action = "" />
    <CFSET THIS.player_details_UUID = "" />
	<CFSET THIS.player_firstname = "" />
    <CFSET THIS.player_lastname = "" />
    <CFSET THIS.player_birthday = "" />
    <CFSET THIS.player_gender = "" />
	<CFSET THIS.player_email = "" />
    <CFSET THIS.player_password = "" />
    <CFSET THIS.player_newpassword = "" />
    <CFSET THIS.player_occupation = "" />
    <CFSET THIS.player_location = "" />
    <CFSET THIS.player_undelete = "" />
	<CFSET THIS.logged_user = "" />


	<!--- Player Details --->
	<CFFUNCTION NAME="getPlayerDetails" ACCESS="public" RETURNTYPE="query">

		<CFQUERY NAME="playerdetails" DATASOURCE="#THIS.dsn#">
			SELECT *,
            	   SUBSTRING(b.player_email, 1, LOCATE('@', b.player_email) - 1) AS email_name,
            	   CASE WHEN b.modified_date IS NULL THEN b.added_date ELSE b.modified_date END AS last_modified,
                   c.last_login

            	FROM sys_players a
                		INNER JOIN sys_players_details b ON a.player_details_UUID = b.player_details_UUID
                		LEFT JOIN (SELECT player_UUID, MAX(login_date) AS last_login FROM sys_logins GROUP BY player_UUID) c ON a.player_UUID = c.player_UUID

                WHERE 0 = 0

                <CFIF THIS.player_undelete EQ "">
                	AND a.deleted IS NULL
				</CFIF>

				<CFIF THIS.player_details_UUID NEQ "">
					AND b.player_details_UUID = <CFQUERYPARAM VALUE="#THIS.player_details_UUID#" CFSQLTYPE="cf_sql_varchar" />
				</CFIF>

		</CFQUERY>

		<CFRETURN playerdetails />

	</CFFUNCTION>
	<!--- End Player Details --->

	<!--- Deleted Player Details --->
	<CFFUNCTION NAME="getDeletedPlayerDetails" ACCESS="public" RETURNTYPE="query">

		<CFQUERY NAME="playerdetails" DATASOURCE="#THIS.dsn#">
			SELECT *,
            	   SUBSTRING(b.player_email, 1, LOCATE('@', b.player_email) - 1) AS email_name,
            	   CASE WHEN b.modified_date IS NULL THEN b.added_date ELSE b.modified_date END AS last_modified,
                   c.last_login

            	FROM sys_players a
                		INNER JOIN sys_players_details b ON a.player_details_UUID = b.player_details_UUID
                		LEFT JOIN (SELECT player_UUID, MAX(login_date) AS last_login FROM sys_logins GROUP BY player_UUID) c ON a.player_UUID = c.player_UUID

                WHERE a.deleted IS NOT NULL

				<CFIF THIS.player_details_UUID NEQ "">
					AND b.player_details_UUID = <CFQUERYPARAM VALUE="#THIS.player_details_UUID#" CFSQLTYPE="cf_sql_varchar" />
				</CFIF>

		</CFQUERY>

		<CFRETURN playerdetails />

	</CFFUNCTION>
	<!--- End Deleted Player Details --->

	<!--- Player --->
	<CFFUNCTION NAME="playerProcess" ACCESS="public" RETURNTYPE="struct">

        <!--- Check to see if username is already in the database --->
        <!--- Also bring through the users name to be used in returned messages --->
        <CFQUERY NAME="playercheck" DATASOURCE="#THIS.dsn#">

            SELECT *

                FROM sys_players a
                        LEFT JOIN sys_players_details b ON a.player_details_UUID = b.player_details_UUID

                WHERE a.deleted IS NULL

                AND b.player_email = <CFQUERYPARAM VALUE="#THIS.player_email#" CFSQLTYPE="cf_sql_varchar" />

        </CFQUERY>

       	<CFIF THIS.player_birthday NEQ "">
			<CFSET my_birthday = #CreateDate(ListGetAt(#THIS.player_birthday#, 3, "/" ), ListGetAt(#THIS.player_birthday#, 2, "/" ), ListGetAt(#THIS.player_birthday#, 1, "/" ))#>
            <CFSET myODBCdate_birthday = #CreateODBCDate(my_birthday)#>
        </CFIF>


		<!--- Add Player --->
		<CFIF #THIS.action# is "add">

            <CFIF playercheck.RECORDCOUNT GT 0>

                <CFSET resultStruct.toastCode = -1 />
                <CFSET resultStruct.toastTitle = "Error" />
                <CFSET resultStruct.toastMessage = "The Player" & " " & "#THIS.player_email#" & " " & "has already been created!" />
                <CFRETURN RESULTSTRUCT />

            <CFELSE>

                 <CFTRY>

                    <CFLOCK TIMEOUT="20">

                        <CFTRANSACTION>

                        	<CFSET player_details_UUID = #CreateUUID()# />

                            <CFQUERY NAME="additem1" DATASOURCE="#THIS.dsn#">

                                INSERT INTO sys_players_details (player_details_UUID, player_firstname, player_lastname, player_birthday, player_gender, player_email, player_occupation, location_UUID, player_quizzes, added_by, added_date)
                                    VALUES	(
                                            <CFQUERYPARAM VALUE="#player_details_UUID#" CFSQLTYPE="cf_sql_varchar" />,
                                            <CFIF THIS.player_firstname is not "">
                                                <CFQUERYPARAM VALUE="#THIS.player_firstname#" CFSQLTYPE="cf_sql_varchar" />
                                            <CFELSE>
                                                <CFQUERYPARAM VALUE="" CFSQLTYPE="cf_sql_varchar" NULL="yes" />
                                            </CFIF>,
                                            <CFIF THIS.player_lastname is not "">
                                                <CFQUERYPARAM VALUE="#THIS.player_lastname#" CFSQLTYPE="cf_sql_varchar" />
                                            <CFELSE>
                                                <CFQUERYPARAM VALUE="" CFSQLTYPE="cf_sql_varchar" NULL="yes" />
                                            </CFIF>,
                                            <CFIF THIS.player_birthday is not "">
                                                <CFQUERYPARAM VALUE="#myODBCdate_birthday#" CFSQLTYPE="cf_sql_timestamp" />
                                            <CFELSE>
                                                <CFQUERYPARAM VALUE="" CFSQLTYPE="cf_sql_timestamp" NULL="yes" />
                                            </CFIF>,
                                            <CFIF THIS.player_gender NEQ "">
                                                <CFQUERYPARAM VALUE="#THIS.player_gender#" CFSQLTYPE="cf_sql_varchar" />
                                            <CFELSE>
                                                <CFQUERYPARAM VALUE="" CFSQLTYPE="cf_sql_varchar" NULL="yes" />
                                            </CFIF>,
                                            <CFQUERYPARAM VALUE="#THIS.player_email#" CFSQLTYPE="cf_sql_varchar" />,
                                            <CFIF THIS.player_occupation NEQ "">
                                                <CFQUERYPARAM VALUE="#THIS.player_occupation#" CFSQLTYPE="cf_sql_varchar" />
                                            <CFELSE>
                                                <CFQUERYPARAM VALUE="" CFSQLTYPE="cf_sql_varchar" NULL="yes" />
                                            </CFIF>,
                                            <CFIF THIS.location_UUID NEQ "">
                                                <CFQUERYPARAM VALUE="#THIS.location_UUID#" CFSQLTYPE="cf_sql_varchar" />
                                            <CFELSE>
                                                <CFQUERYPARAM VALUE="" CFSQLTYPE="cf_sql_varchar" NULL="yes" />
                                            </CFIF>,
                                            <CFQUERYPARAM VALUE="0" CFSQLTYPE="cf_sql_integer" />,
                                            <CFQUERYPARAM VALUE="#THIS.logged_user#" CFSQLTYPE="cf_sql_varchar" />,
                                            <CFQUERYPARAM VALUE="#Now()#" CFSQLTYPE="cf_sql_timestamp" />
                                            )

                            </CFQUERY>

                            <CFSET myID = "#request.mysalt#" & "#THIS.player_email#" & "#request.mysalt#">
                            <CFSET mypassword = "#request.mysalt#" & "#THIS.player_password#" & "#request.mysalt#">
                            <CFSET myadmin_username_hash = #hash(myID)#>
                            <CFSET myadmin_password_hash = #hash(mypassword)#>

                            <CFQUERY NAME="additem2" DATASOURCE="#THIS.dsn#">

                                INSERT INTO sys_players (player_UUID, username_hash, password_hash, player_details_UUID, added_by, added_date)

                                    VALUES (
                                            <CFQUERYPARAM VALUE="#CreateUUID()#" CFSQLTYPE="cf_sql_varchar" />,
                                            <CFQUERYPARAM VALUE="#myadmin_username_hash#" CFSQLTYPE="cf_sql_varchar" />,
                                            <CFQUERYPARAM VALUE="#myadmin_password_hash#" CFSQLTYPE="cf_sql_varchar" />,
                                            <CFQUERYPARAM VALUE="#player_details_UUID#" CFSQLTYPE="cf_sql_varchar" />,
                                            <CFQUERYPARAM VALUE="#THIS.logged_user#" CFSQLTYPE="cf_sql_varchar" />,
                                            <CFQUERYPARAM VALUE="#Now()#" CFSQLTYPE="cf_sql_timestamp" />
                                           )

                            </CFQUERY>

                        </CFTRANSACTION>

                    </CFLOCK>

                    <CFSET resultStruct.toastCode = 1 />
                    <CFSET resultStruct.toastTitle = "Success" />
                    <CFSET resultStruct.toastMessage = "#THIS.player_email#" & " " & "has been created!" />
                    <CFRETURN RESULTSTRUCT />

                    <CFCATCH>

                       <CFSET resultStruct.toastCode = -1 />
                       <CFSET resultStruct.toastTitle = "Error" />
                       <CFSET resultStruct.toastMessage = "Sorry, there was an error creating" & " " & "#THIS.player_email#" & "!" />
                       <CFRETURN RESULTSTRUCT />

                    </CFCATCH>

                </CFTRY>

            </CFIF>

		</CFIF>
		<!--- End Add Player --->


		<!--- Edit Player --->
		<CFIF #THIS.action# is "edit">

            <CFTRY>

                <CFLOCK  timeout="20">

                    <CFTRANSACTION>

                        <CFQUERY NAME="edititem1" DATASOURCE="#THIS.dsn#">

                            UPDATE sys_players_details

                                SET player_firstname = <CFIF THIS.player_firstname is not "">
                                                        <CFQUERYPARAM VALUE="#THIS.player_firstname#" CFSQLTYPE="cf_sql_varchar" />
                                                    <CFELSE>
                                                        <CFQUERYPARAM VALUE="" CFSQLTYPE="cf_sql_varchar" NULL="yes" />
                                                    </CFIF>,
                                    player_lastname = <CFIF THIS.player_lastname is not "">
                                                        <CFQUERYPARAM VALUE="#THIS.player_lastname#" CFSQLTYPE="cf_sql_varchar" />
                                                    <CFELSE>
                                                        <CFQUERYPARAM VALUE="" CFSQLTYPE="cf_sql_varchar" NULL="yes" />
                                                    </CFIF>,
                                    player_birthday = <CFIF THIS.player_birthday is not "">
                                                     <CFQUERYPARAM VALUE="#myODBCdate_birthday#" CFSQLTYPE="cf_sql_timestamp">
                                                 <CFELSE>
                                                     <CFQUERYPARAM VALUE="" CFSQLTYPE="cf_sql_timestamp" null="yes">
                                                 </CFIF>,
                                    player_gender = <CFIF THIS.player_gender NEQ "">
                                                            <CFQUERYPARAM VALUE="#THIS.player_gender#" CFSQLTYPE="cf_sql_varchar" />
                                                        <CFELSE>
                                                            <CFQUERYPARAM VALUE="" CFSQLTYPE="cf_sql_varchar" NULL="yes" />
                                                        </CFIF>,
                                    player_email = <CFQUERYPARAM VALUE="#THIS.player_email#" CFSQLTYPE="cf_sql_varchar">,
                                    player_occupation = <CFIF THIS.player_occupation NEQ "">
                                                            <CFQUERYPARAM VALUE="#THIS.player_occupation#" CFSQLTYPE="cf_sql_varchar" />
                                                        <CFELSE>
                                                            <CFQUERYPARAM VALUE="" CFSQLTYPE="cf_sql_varchar" NULL="yes" />
                                                        </CFIF>,
                                    location_UUID = <CFIF THIS.location_UUID NEQ "">
                                                        <CFQUERYPARAM VALUE="#THIS.location_UUID#" CFSQLTYPE="cf_sql_varchar" />
                                                    <CFELSE>
                                                        <CFQUERYPARAM VALUE="" CFSQLTYPE="cf_sql_varchar" NULL="yes" />
                                                    </CFIF>,
                                    modified_by = <CFQUERYPARAM VALUE="#THIS.logged_user#" CFSQLTYPE="cf_sql_varchar">,
                                    modified_date = <CFQUERYPARAM VALUE="#Now()#" CFSQLTYPE="cf_sql_timestamp">

                                WHERE player_details_UUID = <CFQUERYPARAM VALUE="#player_details_UUID#" CFSQLTYPE="cf_sql_varchar">

                        </CFQUERY>

						<!--- Set a new username and password hash --->
                        <CFSET myID = "#request.mysalt#" & "#THIS.player_email#" & "#request.mysalt#">
                        <CFSET mypassword = "#request.mysalt#" & "#THIS.player_newpassword#" & "#request.mysalt#">
                        <CFSET myadmin_username_hash = #hash(myID)#>
                        <CFSET myadmin_password_hash = #hash(mypassword)#>

                        <CFQUERY NAME="edititem2" DATASOURCE="#THIS.dsn#">

                            UPDATE sys_players

                                SET <CFIF THIS.player_newpassword NEQ "">
                                        password_hash = <CFQUERYPARAM VALUE="#myadmin_password_hash#" CFSQLTYPE="cf_sql_varchar">,
                                        modified_by = <CFQUERYPARAM VALUE="#THIS.logged_user#" CFSQLTYPE="cf_sql_varchar">,
                                    	modified_date = <CFQUERYPARAM VALUE="#Now()#" CFSQLTYPE="cf_sql_timestamp">,
                                    </CFIF>
									username_hash = <CFQUERYPARAM VALUE="#myadmin_username_hash#" CFSQLTYPE="cf_sql_varchar">

                                WHERE player_details_UUID = <CFQUERYPARAM VALUE="#player_details_UUID#" CFSQLTYPE="cf_sql_varchar">

                        </CFQUERY>

                    </CFTRANSACTION>

                </CFLOCK>

                <CFSET resultStruct.toastCode = 1 />
                <CFSET resultStruct.toastTitle = "Success" />
                <CFSET resultStruct.toastMessage = "#THIS.player_email#" & " " & "has been edited!" />
                <CFRETURN resultStruct />

                <CFCATCH>

                   <CFSET resultStruct.toastCode = -1 />
                   <CFSET resultStruct.toastTitle = "Error" />
                   <CFSET resultStruct.toastMessage = "Sorry, there was an error editing" & " " & "#THIS.player_email#" & "!" />
                   <CFRETURN resultStruct />

                </CFCATCH>

            </CFTRY>

		</CFIF>
		<!--- End Edit Player --->


		<!--- Delete Player --->
		<CFIF #THIS.action# is "delete">

    		<CFTRY>

            	<CFQUERY NAME="deleteitem1" DATASOURCE="#THIS.dsn#">

        			SELECT player_email

                    	FROM sys_players_details

                        WHERE player_details_UUID = <CFQUERYPARAM VALUE="#THIS.player_details_UUID#" CFSQLTYPE="cf_sql_varchar">

				</CFQUERY>

				<CFQUERY NAME="deleteitem2" DATASOURCE="#THIS.dsn#">

        			UPDATE sys_players

                    	SET deleted = <CFQUERYPARAM VALUE="1" CFSQLTYPE="cf_sql_bit">,
                        	modified_by = <CFQUERYPARAM VALUE="#THIS.logged_user#" CFSQLTYPE="cf_sql_varchar">,
                            modified_date = <CFQUERYPARAM VALUE="#Now()#" CFSQLTYPE="cf_sql_timestamp">

						WHERE player_details_UUID = <CFQUERYPARAM VALUE="#THIS.player_details_UUID#" CFSQLTYPE="cf_sql_varchar">

				</CFQUERY>

				<CFSET resultStruct.toastCode = 1 />
                <CFSET resultStruct.toastTitle = "Success" />
                <CFSET resultStruct.toastMessage = "#deleteitem1.player_email#" & " " & "has been deleted!" />
                <CFRETURN resultStruct />

        		<CFCATCH>

				   <CFSET resultStruct.toastCode = -1 />
                   <CFSET resultStruct.toastTitle = "Error" />
                   <CFSET resultStruct.toastMessage = "Sorry, there was an error deleting" & " " & "#deleteitem1.player_email#" & "!" />
                   <CFRETURN resultStruct />

           		</CFCATCH>

           </CFTRY>

		</CFIF>
		<!--- End Delete Player --->


        <!--- Un-Delete User --->
		<CFIF #THIS.action# is "undelete">

    		<CFTRY>

            	<CFQUERY NAME="undeleteitem1" DATASOURCE="#THIS.dsn#">

        			SELECT player_email

                    	FROM sys_players_details

                        WHERE player_details_UUID = <CFQUERYPARAM VALUE="#THIS.player_details_UUID#" CFSQLTYPE="cf_sql_varchar">

				</CFQUERY>

				<CFQUERY NAME="undeleteitem2" DATASOURCE="#THIS.dsn#">

        			UPDATE sys_players

                    	SET deleted = <CFQUERYPARAM VALUE="" CFSQLTYPE="cf_sql_bit" NULL="yes" />,
                        	modified_by = <CFQUERYPARAM VALUE="#THIS.logged_user#" CFSQLTYPE="cf_sql_varchar">,
                            modified_date = <CFQUERYPARAM VALUE="#Now()#" CFSQLTYPE="cf_sql_timestamp">

						WHERE player_details_UUID = <CFQUERYPARAM VALUE="#THIS.player_details_UUID#" CFSQLTYPE="cf_sql_varchar">

				</CFQUERY>

				<CFSET resultStruct.toastCode = 1 />
                <CFSET resultStruct.toastTitle = "Success" />
                <CFSET resultStruct.toastMessage = "#undeleteitem1.player_email#" & " " & "has been un-deleted!" />
                <CFRETURN resultStruct />

        		<CFCATCH>

				   <CFSET resultStruct.toastCode = -1 />
                   <CFSET resultStruct.toastTitle = "Error" />
                   <CFSET resultStruct.toastMessage = "Sorry, there was an error un-deleting" & " " & "#undeleteitem1.player_email#" & "!" />
                   <CFRETURN resultStruct />

           		</CFCATCH>

           </CFTRY>

		</CFIF>
		<!--- End Un-Delete User --->


	</CFFUNCTION>
	<!--- End Player --->


</CFCOMPONENT>
