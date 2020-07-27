<CFCOMPONENT HINT="dynamic component">

	<!--- Set THIS scope constructor variables --->
	<CFSET THIS.dsn = "" />
	<CFSET THIS.action = "" />

    <CFSET THIS.user_details_UUID = "" />
	<CFSET THIS.user_firstname = "" />
    <CFSET THIS.user_lastname = "" />
    <CFSET THIS.user_phone = "" />
    <CFSET THIS.user_organisation = "" />
	<CFSET THIS.user_email = "" />
    <CFSET THIS.user_password = "" />
    <CFSET THIS.user_newpassword = "" />
    <CFSET THIS.user_role_UUID = "" />
    <CFSET THIS.location_UUID = "" />
    <CFSET THIS.uploadfile1 = "" />
    <CFSET THIS.currentimage1 = "" />
    <CFSET THIS.free_credits = "" />
    <CFSET THIS.user_undelete = "" />

	<CFSET THIS.username_hash = "" />
	<CFSET THIS.logged_user = "" />


	<!--- User --->
	<CFFUNCTION NAME="userProcess" ACCESS="public" RETURNTYPE="struct">


		<!--- Setting the user_details_UUID if not already set --->
		<CFIF #THIS.user_details_UUID# NEQ ''>
            <CFSET user_details_UUID = THIS.user_details_UUID />
        <CFELSE>
        	<CFSET user_details_UUID = #CreateUUID()# />
        </CFIF>


		<!--- Setting the file name for upload or edit --->
		<CFIF #THIS.action# EQ 'edit'>
			<CFSET myfile1 = #THIS.currentimage1# />
        <CFELSE>
			<CFSET myfile1 = '' />
        </CFIF>


        <!--- Upload the image to the server --->
		<CFSET mydirectory = #user_details_UUID#>
        <CFSET currentDirectory = '#request.rootdirectory#/_img/avatars/#mydirectory#' />

        <CFIF NOT DirectoryExists(currentDirectory)>
            <CFDIRECTORY ACTION="create" DIRECTORY="#currentDirectory#" >
        </CFIF>

        <CFIF #THIS.uploadfile1# NEQ ''>

            <CFFILE ACTION="upload" FILEFIELD="uploadfile1" DESTINATION="#currentDirectory#/" NAMECONFLICT="Overwrite" />
            <CFSET myfile1 = #FILE.ServerFile#>

        </CFIF>


        <!--- Check to see if username is already in the database --->
        <CFQUERY NAME="usercheck" DATASOURCE="#THIS.dsn#">

            SELECT *

                FROM users a
                        LEFT JOIN users_details b ON a.user_details_UUID = b.user_details_UUID

                WHERE a.deleted IS NULL

                AND b.user_email = <CFQUERYPARAM VALUE="#THIS.user_email#" CFSQLTYPE="cf_sql_varchar" />

        </CFQUERY>


		<!--- Add User --->
		<CFIF #THIS.action# is "add">

            <CFIF usercheck.RECORDCOUNT GT 0>

                <CFSET resultStruct.statusCode = -1 />
                <CFSET resultStruct.statusClass = "Error" />
                <CFSET resultStruct.statusMessage = "The Username" & " " & "#usercheck.user_email#" & " " & "has already been used!" />
                <CFRETURN RESULTSTRUCT />

            <CFELSE>

				<CFTRY>

                    <CFLOCK TIMEOUT="20">

                        <CFTRANSACTION>

                            <CFQUERY NAME="additem1" DATASOURCE="#THIS.dsn#">

                                INSERT INTO users_details (user_details_UUID, user_firstname, user_lastname, user_phone, user_organisation, user_email, location_UUID, uploadfile1, added_by, added_date)
                                    VALUES	(
                                            <CFQUERYPARAM VALUE="#user_details_UUID#" CFSQLTYPE="cf_sql_varchar" />,
                                            <CFQUERYPARAM VALUE="#THIS.user_firstname#" CFSQLTYPE="cf_sql_varchar" />,
                                            <CFIF THIS.user_lastname is not "">
                                                <CFQUERYPARAM VALUE="#THIS.user_lastname#" CFSQLTYPE="cf_sql_varchar" />
                                            <CFELSE>
                                                <CFQUERYPARAM VALUE="" CFSQLTYPE="cf_sql_varchar" NULL="yes" />
                                            </CFIF>,
                                            <CFIF THIS.user_phone is not "">
                                                <CFQUERYPARAM VALUE="#THIS.user_phone#" CFSQLTYPE="cf_sql_varchar" />
                                            <CFELSE>
                                                <CFQUERYPARAM VALUE="" CFSQLTYPE="cf_sql_varchar" NULL="yes" />
                                            </CFIF>,
                                            <CFIF THIS.user_organisation NEQ "">
                                                <CFQUERYPARAM VALUE="#THIS.user_organisation#" CFSQLTYPE="cf_sql_varchar" />
                                            <CFELSE>
                                                <CFQUERYPARAM VALUE="" CFSQLTYPE="cf_sql_varchar" NULL="yes" />
                                            </CFIF>,
                                            <CFQUERYPARAM VALUE="#THIS.user_email#" CFSQLTYPE="cf_sql_varchar" />,
                                            <CFIF THIS.location_UUID NEQ "">
                                                <CFQUERYPARAM VALUE="#THIS.location_UUID#" CFSQLTYPE="cf_sql_varchar" />
                                            <CFELSE>
                                                <CFQUERYPARAM VALUE="" CFSQLTYPE="cf_sql_varchar" NULL="yes" />
                                            </CFIF>,
                                            <CFQUERYPARAM VALUE="#myfile1#" CFSQLTYPE="cf_sql_varchar" />,
                                            <CFQUERYPARAM VALUE="#THIS.logged_user#" CFSQLTYPE="cf_sql_varchar" />,
                                            <CFQUERYPARAM VALUE="#Now()#" CFSQLTYPE="cf_sql_timestamp" />
                                            )

                            </CFQUERY>

                            <CFSET myID = "#request.mysalt#" & "#THIS.user_email#" & "#request.mysalt#">
                            <CFSET mypassword = "#request.mysalt#" & "#THIS.user_password#" & "#request.mysalt#">
                            <CFSET myadmin_username_hash = #hash(myID)#>
                            <CFSET myadmin_password_hash = #hash(mypassword)#>

                            <CFQUERY NAME="additem2" DATASOURCE="#THIS.dsn#">

                                INSERT INTO users (user_UUID, username_hash, password_hash, user_role_UUID, user_details_UUID, free_credits, added_by, added_date)

                                    VALUES (
                                            <CFQUERYPARAM VALUE="#CreateUUID()#" CFSQLTYPE="cf_sql_varchar" />,
                                            <CFQUERYPARAM VALUE="#myadmin_username_hash#" CFSQLTYPE="cf_sql_varchar" />,
                                            <CFQUERYPARAM VALUE="#myadmin_password_hash#" CFSQLTYPE="cf_sql_varchar" />,
                                            <CFQUERYPARAM VALUE="#THIS.user_role_UUID#" CFSQLTYPE="cf_sql_varchar" />,
                                            <CFQUERYPARAM VALUE="#user_details_UUID#" CFSQLTYPE="cf_sql_varchar" />,
                                            <CFIF THIS.free_credits NEQ "">
                                                <CFQUERYPARAM VALUE="#THIS.free_credits#" CFSQLTYPE="cf_sql_integer" />
                                            <CFELSE>
                                                <CFQUERYPARAM VALUE="" CFSQLTYPE="cf_sql_integer" NULL="yes" />
                                            </CFIF>,
                                            <CFQUERYPARAM VALUE="#THIS.logged_user#" CFSQLTYPE="cf_sql_varchar" />,
                                            <CFQUERYPARAM VALUE="#Now()#" CFSQLTYPE="cf_sql_timestamp" />
                                           )

                            </CFQUERY>

                        </CFTRANSACTION>

                    </CFLOCK>

                    <CFSET resultStruct.statusCode = 1 />
                    <CFSET resultStruct.statusClass = "Success" />
                    <CFSET resultStruct.statusMessage = "#THIS.user_email#" & " " & "has been created!" />
                    <CFRETURN RESULTSTRUCT />

                    <CFCATCH>

                       <CFSET resultStruct.statusCode = -1 />
                       <CFSET resultStruct.statusClass = "Error" />
                       <CFSET resultStruct.statusMessage = "Sorry, there was an error creating" & " " & "#THIS.user_email#" & "!" />
                       <CFRETURN RESULTSTRUCT />

                    </CFCATCH>

                </CFTRY>

            </CFIF>

		</CFIF>
		<!--- End Add User --->


		<!--- Edit User --->
		<CFIF #THIS.action# is "edit">

            <CFTRY>

                <CFLOCK  timeout="20">

                    <CFTRANSACTION>

                        <CFQUERY NAME="edititem1" DATASOURCE="#THIS.dsn#">

                            UPDATE users_details

                                SET user_firstname = <CFQUERYPARAM VALUE="#THIS.user_firstname#" CFSQLTYPE="cf_sql_varchar">,
                                    user_lastname = <CFIF THIS.user_lastname is not "">
                                                        <CFQUERYPARAM VALUE="#THIS.user_lastname#" CFSQLTYPE="cf_sql_varchar" />
                                                    <CFELSE>
                                                        <CFQUERYPARAM VALUE="" CFSQLTYPE="cf_sql_varchar" NULL="yes" />
                                                    </CFIF>,
                                    user_phone = <CFIF THIS.user_phone is not "">
                                                     <CFQUERYPARAM VALUE="#THIS.user_phone#" CFSQLTYPE="cf_sql_varchar">
                                                 <CFELSE>
                                                     <CFQUERYPARAM VALUE="" CFSQLTYPE="cf_sql_varchar" null="yes">
                                                 </CFIF>,
                                    user_organisation = <CFIF THIS.user_organisation NEQ "">
                                                            <CFQUERYPARAM VALUE="#THIS.user_organisation#" CFSQLTYPE="cf_sql_varchar" />
                                                        <CFELSE>
                                                            <CFQUERYPARAM VALUE="" CFSQLTYPE="cf_sql_varchar" NULL="yes" />
                                                        </CFIF>,
                                    user_email = <CFQUERYPARAM VALUE="#THIS.user_email#" CFSQLTYPE="cf_sql_varchar">,
                                    location_UUID = <CFIF THIS.location_UUID NEQ "">
                                                        <CFQUERYPARAM VALUE="#THIS.location_UUID#" CFSQLTYPE="cf_sql_varchar" />
                                                    <CFELSE>
                                                        <CFQUERYPARAM VALUE="" CFSQLTYPE="cf_sql_varchar" NULL="yes" />
                                                    </CFIF>,
                                    uploadfile1 = <CFQUERYPARAM VALUE="#myfile1#" CFSQLTYPE="cf_sql_varchar">,
                                    modified_by = <CFQUERYPARAM VALUE="#THIS.logged_user#" CFSQLTYPE="cf_sql_varchar">,
                                    modified_date = <CFQUERYPARAM VALUE="#Now()#" CFSQLTYPE="cf_sql_timestamp">

                                WHERE user_details_UUID = <CFQUERYPARAM VALUE="#user_details_UUID#" CFSQLTYPE="cf_sql_varchar">

                        </CFQUERY>

						<!--- Set a new username and password hash --->
                        <CFSET myID = "#request.mysalt#" & "#THIS.user_email#" & "#request.mysalt#">
                        <CFSET mypassword = "#request.mysalt#" & "#THIS.user_newpassword#" & "#request.mysalt#">
                        <CFSET myadmin_username_hash = #hash(myID)#>
                        <CFSET myadmin_password_hash = #hash(mypassword)#>

                        <CFQUERY NAME="edititem2" DATASOURCE="#THIS.dsn#">

                            UPDATE users

                                SET username_hash = <CFQUERYPARAM VALUE="#myadmin_username_hash#" CFSQLTYPE="cf_sql_varchar">,
									<CFIF THIS.user_newpassword NEQ "">
                                        password_hash = <CFQUERYPARAM VALUE="#myadmin_password_hash#" CFSQLTYPE="cf_sql_varchar">,
                                        modified_by = <CFQUERYPARAM VALUE="#THIS.logged_user#" CFSQLTYPE="cf_sql_varchar">,
                                    	modified_date = <CFQUERYPARAM VALUE="#Now()#" CFSQLTYPE="cf_sql_timestamp">,
                                    </CFIF>
									free_credits = <CFIF THIS.free_credits NEQ "">
                                                	   <CFQUERYPARAM VALUE="#THIS.free_credits#" CFSQLTYPE="cf_sql_integer" />
                                            	   <CFELSE>
                                                	   <CFQUERYPARAM VALUE="" CFSQLTYPE="cf_sql_integer" NULL="yes" />
                                            	   </CFIF>,
									user_role_UUID = <CFQUERYPARAM VALUE="#THIS.user_role_UUID#" CFSQLTYPE="cf_sql_varchar">

                                WHERE user_details_UUID = <CFQUERYPARAM VALUE="#user_details_UUID#" CFSQLTYPE="cf_sql_varchar">

                        </CFQUERY>

                    </CFTRANSACTION>

                </CFLOCK>

                <CFSET resultStruct.statusCode = 1 />
                <CFSET resultStruct.statusClass = "Success" />
                <CFSET resultStruct.statusMessage = "#THIS.user_email#" & " " & "has been edited!" />
                <CFRETURN resultStruct />

                <CFCATCH>

                   <CFSET resultStruct.statusCode = -1 />
                   <CFSET resultStruct.statusClass = "Error" />
                   <CFSET resultStruct.statusMessage = "Sorry, there was an error editing" & " " & "#THIS.user_email#" & "!" />
                   <CFRETURN resultStruct />

                </CFCATCH>

            </CFTRY>

		</CFIF>
		<!--- End Edit User --->


		<!--- Delete User --->
		<CFIF #THIS.action# is "delete">

    		<CFTRY>

            	<CFQUERY NAME="deleteitem1" DATASOURCE="#THIS.dsn#">

        			SELECT user_email

                    	FROM users_details

                        WHERE user_details_UUID = <CFQUERYPARAM VALUE="#THIS.user_details_UUID#" CFSQLTYPE="cf_sql_varchar">

				</CFQUERY>

				<CFQUERY NAME="deleteitem2" DATASOURCE="#THIS.dsn#">

        			UPDATE users

                    	SET deleted = <CFQUERYPARAM VALUE="1" CFSQLTYPE="cf_sql_bit">,
                        	modified_by = <CFQUERYPARAM VALUE="#THIS.logged_user#" CFSQLTYPE="cf_sql_varchar">,
                            modified_date = <CFQUERYPARAM VALUE="#Now()#" CFSQLTYPE="cf_sql_timestamp">

						WHERE user_details_UUID = <CFQUERYPARAM VALUE="#user_details_UUID#" CFSQLTYPE="cf_sql_varchar">

				</CFQUERY>

				<CFSET resultStruct.statusCode = 1 />
                <CFSET resultStruct.statusClass = "Success" />
                <CFSET resultStruct.statusMessage = "#deleteitem1.user_email#" & " " & "has been deleted!" />
                <CFRETURN resultStruct />

        		<CFCATCH>

				   <CFSET resultStruct.statusCode = -1 />
                   <CFSET resultStruct.statusClass = "Error" />
                   <CFSET resultStruct.statusMessage = "Sorry, there was an error deleting" & " " & "#deleteitem1.user_email#" & "!" />
                   <CFRETURN resultStruct />

           		</CFCATCH>

           </CFTRY>

		</CFIF>
		<!--- End Delete User --->


        <!--- Un-Delete User --->
		<CFIF #THIS.action# is "undelete">

    		<CFTRY>

            	<CFQUERY NAME="undeleteitem1" DATASOURCE="#THIS.dsn#">

        			SELECT user_email

                    	FROM users_details

                        WHERE user_details_UUID = <CFQUERYPARAM VALUE="#THIS.user_details_UUID#" CFSQLTYPE="cf_sql_varchar">

				</CFQUERY>

				<CFQUERY NAME="undeleteitem2" DATASOURCE="#THIS.dsn#">

        			UPDATE users

                    	SET deleted = <CFQUERYPARAM VALUE="" CFSQLTYPE="cf_sql_bit" NULL="yes" />,
                        	modified_by = <CFQUERYPARAM VALUE="#THIS.logged_user#" CFSQLTYPE="cf_sql_varchar">,
                            modified_date = <CFQUERYPARAM VALUE="#Now()#" CFSQLTYPE="cf_sql_timestamp">

						WHERE user_details_UUID = <CFQUERYPARAM VALUE="#user_details_UUID#" CFSQLTYPE="cf_sql_varchar">

				</CFQUERY>

				<CFSET resultStruct.statusCode = 1 />
                <CFSET resultStruct.statusClass = "Success" />
                <CFSET resultStruct.statusMessage = "#undeleteitem1.user_email#" & " " & "has been un-deleted!" />
                <CFRETURN resultStruct />

        		<CFCATCH>

				   <CFSET resultStruct.statusCode = -1 />
                   <CFSET resultStruct.statusClass = "Error" />
                   <CFSET resultStruct.statusMessage = "Sorry, there was an error un-deleting" & " " & "#undeleteitem1.user_email#" & "!" />
                   <CFRETURN resultStruct />

           		</CFCATCH>

           </CFTRY>

		</CFIF>
		<!--- End Un-Delete User --->


	</CFFUNCTION>
	<!--- End User --->


	<!--- User Details --->
	<CFFUNCTION NAME="getUserDetails" ACCESS="public" RETURNTYPE="query">

		<CFQUERY NAME="userdetails" DATASOURCE="#THIS.dsn#">
			SELECT *,
            	   SUBSTRING(b.user_email, 1, LOCATE('@', b.user_email) - 1) AS email_name,
            	   CASE WHEN b.modified_date IS NULL THEN b.added_date ELSE b.modified_date END AS last_modified,
                   c.last_login

            	FROM users a
                		INNER JOIN users_details b ON a.user_details_UUID = b.user_details_UUID
                		LEFT JOIN (SELECT user_UUID, MAX(login_date) AS last_login FROM logins GROUP BY user_UUID) c ON a.user_UUID = c.user_UUID

                WHERE 0 = 0

                <CFIF THIS.user_undelete EQ "">
                	AND a.deleted IS NULL
				</CFIF>

				<CFIF THIS.user_details_UUID NEQ "">
					AND b.user_details_UUID = <CFQUERYPARAM VALUE="#THIS.user_details_UUID#" CFSQLTYPE="cf_sql_varchar" />
				</CFIF>

                <CFIF THIS.username_hash NEQ ''>
                    AND a.user_role_UUID <> <CFQUERYPARAM VALUE="a88aaf23-0d3f-11e5-a315-38b1dbe2bc0e" CFSQLTYPE="cf_sql_varchar" />
                </CFIF>

		</CFQUERY>

		<CFRETURN userdetails />

	</CFFUNCTION>
	<!--- End User Details --->


    <!--- Deleted User Details --->
	<CFFUNCTION NAME="getDeletedUserDetails" ACCESS="public" RETURNTYPE="query">

		<CFQUERY NAME="userdetails" DATASOURCE="#THIS.dsn#">
			SELECT *,
            	   SUBSTRING(b.user_email, 1, LOCATE('@', b.user_email) - 1) AS email_name,
            	   CASE WHEN b.modified_date IS NULL THEN b.added_date ELSE b.modified_date END AS last_modified,
                   c.last_login

            	FROM users a
                		INNER JOIN users_details b ON a.user_details_UUID = b.user_details_UUID
                		LEFT JOIN (SELECT user_UUID, MAX(login_date) AS last_login FROM logins GROUP BY user_UUID) c ON a.user_UUID = c.user_UUID

                WHERE a.deleted IS NOT NULL

				<CFIF THIS.user_details_UUID NEQ "">
					AND b.user_details_UUID = <CFQUERYPARAM VALUE="#THIS.user_details_UUID#" CFSQLTYPE="cf_sql_varchar" />
				</CFIF>

		</CFQUERY>

		<CFRETURN userdetails />

	</CFFUNCTION>
	<!--- End Deleted User Details --->


    <!--- User Roles --->
	<CFFUNCTION NAME="getUserRoles" ACCESS="public" RETURNTYPE="query">

		<CFQUERY NAME="userroles" DATASOURCE="#THIS.dsn#">

			SELECT *

                FROM users_roles

                <CFIF THIS.user_role_UUID NEQ 'a88aaf23-0d3f-11e5-a315-38b1dbe2bc0e'>
                	WHERE user_role_UUID <> <CFQUERYPARAM VALUE="a88aaf23-0d3f-11e5-a315-38b1dbe2bc0e" CFSQLTYPE="cf_sql_varchar" />
                </CFIF>

                ORDER BY user_role_order ASC

		</CFQUERY>

		<CFRETURN userroles />

	</CFFUNCTION>
	<!--- End User Roles --->


    <!--- Total Credits --->
	<CFFUNCTION NAME="getUserCredits" ACCESS="public" RETURNTYPE="query">

		<CFQUERY NAME="usercredits" DATASOURCE="#THIS.dsn#">

			SELECT SUM(IFNULL(paid_credits, 0) + IFNULL(free_credits, 0)) AS total_credits

                FROM users

                WHERE deleted IS NULL

		</CFQUERY>

		<CFRETURN usercredits />

	</CFFUNCTION>
	<!--- End Total Credits --->


    <!--- User Number --->
	<CFFUNCTION NAME="getUsersNumber" ACCESS="public" RETURNTYPE="query">

        <CFQUERY NAME="usersnumber" DATASOURCE="#THIS.dsn#">

        	SELECT IFNULL(COUNT(*), 0) AS userscount

            	FROM users

                WHERE deleted IS NULL

                <CFIF THIS.username_hash NEQ ''>
                	AND user_role_UUID <> <CFQUERYPARAM VALUE="a88aaf23-0d3f-11e5-a315-38b1dbe2bc0e" CFSQLTYPE="cf_sql_varchar" />
                </CFIF>

        </CFQUERY>

		<CFRETURN usersnumber />

	</CFFUNCTION>
	<!--- End User Number --->


    <!--- Deleted User Number --->
	<CFFUNCTION NAME="getDeletedUsersNumber" ACCESS="public" RETURNTYPE="query">

        <CFQUERY NAME="usersnumber" DATASOURCE="#THIS.dsn#">

        	SELECT IFNULL(COUNT(*), 0) AS deleteduserscount

            	FROM users

                WHERE deleted IS NOT NULL

        </CFQUERY>

		<CFRETURN usersnumber />

	</CFFUNCTION>
	<!--- End Deleted User Number --->


    <!--- Get Locations --->
	<CFFUNCTION NAME="getLocations" ACCESS="public" RETURNTYPE="query">

        <CFQUERY NAME="locations" DATASOURCE="#THIS.dsn#">

        	SELECT *

            	FROM locations

                WHERE deleted IS NULL

                AND location_type = 'Normal'

        </CFQUERY>

		<CFRETURN locations />

	</CFFUNCTION>
	<!--- End Get Locations --->


</CFCOMPONENT>
