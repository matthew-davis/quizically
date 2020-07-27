<CFCOMPONENT>
	
	<!--- Set THIS scope constructor variables --->	
	<CFSET THIS.dsn = "" />
    
    <CFSET THIS.user_UUID = "" />
    <CFSET THIS.user_details_UUID = "" />
	<CFSET THIS.user_firstname = "" />
    <CFSET THIS.user_lastname = "" />
    <CFSET THIS.user_phone = "" />
    <CFSET THIS.user_organisation = "" />
    <CFSET THIS.new_password = "" />
    <CFSET THIS.user_role_UUID = "" />
    <CFSET THIS.location_UUID = "" />
    <CFSET THIS.uploadfile1 = "" />
    <CFSET THIS.currentimage1 = "" />

	<CFSET THIS.logged_user = "" />


	<!--- Edit Profile --->
	<CFFUNCTION NAME="profileProcess" ACCESS="public" RETURNTYPE="struct">

		<CFSET updatetype = 'normal' />
	
		<CFSET myfile1 = #THIS.currentimage1# />


        <!--- Upload the image to the server --->
		<CFSET mydirectory = #THIS.user_details_UUID#>
        <CFSET currentDirectory = '#request.rootdirectory#/_img/avatars/#mydirectory#' />

        <CFIF NOT DirectoryExists(currentDirectory)>
            <CFDIRECTORY ACTION="create" DIRECTORY="#currentDirectory#" >
        </CFIF>

        <CFIF #THIS.uploadfile1# NEQ ''>
        
            <CFFILE ACTION="upload" FILEFIELD="uploadfile1" DESTINATION="#currentDirectory#/" NAMECONFLICT="Overwrite" />
            <CFSET myfile1 = #FILE.ServerFile#>
                        
        </CFIF>

		   
        <CFTRY>

            <CFLOCK  TIMEOUT="20">

                <CFTRANSACTION>

                    <CFQUERY NAME="editprofile1" DATASOURCE="#THIS.dsn#">
    
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
                                location_UUID = <CFIF THIS.location_UUID NEQ "">
                                                    <CFQUERYPARAM VALUE="#THIS.location_UUID#" CFSQLTYPE="cf_sql_varchar" />
                                                <CFELSE>
                                                    <CFQUERYPARAM VALUE="" CFSQLTYPE="cf_sql_varchar" NULL="yes" />
                                                </CFIF>,
                                uploadfile1 = <CFQUERYPARAM VALUE="#myfile1#" CFSQLTYPE="cf_sql_varchar">,
                                modified_by = <CFQUERYPARAM VALUE="#THIS.logged_user#" CFSQLTYPE="cf_sql_varchar">,
                                modified_date = <CFQUERYPARAM VALUE="#Now()#" CFSQLTYPE="cf_sql_timestamp">

                            WHERE user_details_UUID = <CFQUERYPARAM VALUE="#THIS.user_details_UUID#" CFSQLTYPE="cf_sql_varchar">

                    </CFQUERY>

                    <!--- Set a new password hash --->
					<CFIF #THIS.new_password# NEQ ''>
                    
                    	<CFSET mypassword = "#request.mysalt#" & "#THIS.new_password#" & "#request.mysalt#">
                    	<CFSET myadmin_password_hash = #hash(mypassword)#>
			
						<CFQUERY NAME="editprofile2" DATASOURCE="#THIS.dsn#">
                    
                            UPDATE users 
                            
                                SET password_hash = <CFQUERYPARAM VALUE="#myadmin_password_hash#" CFSQLTYPE="cf_sql_varchar">,
                                    modified_by = <CFQUERYPARAM VALUE="#THIS.logged_user#" CFSQLTYPE="cf_sql_varchar">,
                                    modified_date = <CFQUERYPARAM VALUE="#Now()#" CFSQLTYPE="cf_sql_timestamp">
                                                                    
                                WHERE user_details_UUID = <CFQUERYPARAM VALUE="#THIS.user_details_UUID#" CFSQLTYPE="cf_sql_varchar">
                    
                        </CFQUERY>
                        
                        <CFSET updatetype = 'password' />

                    </CFIF>
 
            	</CFTRANSACTION> 

            </CFLOCK>

			<CFSET resultStruct.statusType = "#updatetype#" />
            <CFSET resultStruct.statusCode = 1 />
            <CFSET resultStruct.statusClass = "Success" />
            <CFSET resultStruct.statusMessage = "Your profile has been updated!" />
            <CFRETURN resultStruct />
            
            <CFCATCH>
            
            	<CFSET resultStruct.statusType = "#updatetype#" />
                <CFSET resultStruct.statusCode = -1 />
                <CFSET resultStruct.statusClass = "Error" />
                <CFSET resultStruct.statusMessage = "Sorry, there was an error editing your profile!" />
                <CFRETURN resultStruct />
               
            </CFCATCH>
            
        </CFTRY> 
		   
           
	</CFFUNCTION>
	<!--- End Edit Profile --->


</CFCOMPONENT>
