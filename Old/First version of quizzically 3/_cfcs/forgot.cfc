<CFCOMPONENT>
	
	<!--- set THIS scope constructor variables --->
	<CFSET THIS.dsn = "" />
    <CFSET THIS.admin_username = "">
    <CFSET THIS.username_hash = "">
    <CFSET THIS.password = "">
    <CFSET THIS.confirm_password = "">
	
    
	<cffunction name="forgotten_password_process" access="public" displayname="Create a new registrant" hint="Sets new registarnt ID in THIS scope" returntype="struct">
		   
		<cftry>
        
        	<CFSET mysalt = 'wat3r'>
            <CFSET myID = '#mysalt#' & '#THIS.admin_username#' & '#mysalt#'>
            <CFSET admin_username_hash = #hash(myID)#>
		   		
        	<cfquery name="qGetregistrant" datasource="#THIS.dsn#">
				
                SELECT * 
                
                	FROM users 
                    
                    WHERE 0 = 0
                    
					<CFIF THIS.admin_username NEQ "">
						AND username_hash = <cfqueryparam value="#admin_username_hash#" cfsqltype="cf_sql_varchar" />
					</CFIF>
					
				</cfquery>
				
				<!--- Check if real user --->
				<CFIF qGetregistrant.recordcount is not 0>
							
									
					<!--- CFMAIL --->
				   	<CFMAIL
						FROM="#request.adminemail#"
						TO="#THIS.admin_username#"
						FAILTO="#request.adminemail#"
						TYPE="html"
						SUBJECT="Golf Travellers - Reset Password">
							
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

                                <img src="http://golftravellers.bannermantechnology.co.uk/images/logo.png" width="300">
                                
                                <br />

								<p>We have received a request to reset your Golf Travellers password.</p>
								<p>If you requested this password reset, please click on the link below to reset your password.</p>

								<CFOUTPUT>
									<p>
                                    	<a href="http://golftravellers.bannermantechnology.co.uk/forgotten/password_reset.cfm?username_hash=#qGetregistrant.username_hash#&email=#THIS.admin_username#">
                                        	http://golftravellers.bannermantechnology.co.uk/forgotten/password_reset.cfm?username_hash=#qGetregistrant.username_hash#&email=#THIS.admin_username#
                                        </a>
                                    </p>
								</CFOUTPUT>
						
                        		<p>If you did not request this password reset please ignore this email.</p>
                                
                                <br />
                                
                                <p>Best,</p>
                                
                                <p>Golf Travellers Team</p>
						
							</body>

						</html>
			
            		</CFMAIL>

					<cfset resultStruct.statusCode = 1 />
                    <cfset resultStruct.statusClass = "success" />
                    <cfset resultStruct.statusMessage = "We have emailed you a link to reset your password" />
                    <cfreturn resultStruct />						
						
				<cfelse>
			  
					<cfset resultStruct.statusCode = -2 />
		            <cfset resultStruct.statusClass = "error" />
		            <cfset resultStruct.statusMessage = "Sorry, the email address does not exist!" />
		            <cfreturn resultStruct />	 		
					
				</CFIF>
                
            <cfcatch>
           
                <cfset resultStruct.statusCode = -1 />
                <cfset resultStruct.statusClass = "error" />
                <cfset resultStruct.statusMessage = "Sorry, there was an error retrieving your details!" />
                <cfreturn resultStruct />
           
           	</cfcatch> 
           
		</cftry>	   

	</cffunction>


	<CFFUNCTION NAME="password_reset" ACCESS="public" RETURNTYPE="struct">

		<CFIF THIS.password is "">
	  		<CFSET resultStruct.statusCode = -2 />
            <CFSET resultStruct.statusClass = "error" />
            <CFSET resultStruct.statusMessage = "Sorry, you must enter a password!" />
            <CFRETURN resultStruct />
	    </CFIF>
       
        <CFIF THIS.confirm_password is "">
	  		<CFSET resultStruct.statusCode = -2 />
            <CFSET resultStruct.statusClass = "error" />
            <CFSET resultStruct.statusMessage = "Sorry, you must confirm your password!" />
            <CFRETURN resultStruct />
	    </CFIF>
       
        <CFIF THIS.password NEQ THIS.confirm_password>
       		<CFSET resultStruct.statusCode = -2 />
            <CFSET resultStruct.statusClass = "error" />
            <CFSET resultStruct.statusMessage = "Sorry, the password and re-entered passwords must match." />
            <CFRETURN resultStruct />
	    </CFIF>
        
        <CFSET mysalt = 'wat3r'>
        <CFSET mypass = '#mysalt#' & '#THIS.password#' & '#mysalt#'>
        <CFSET change_password_hash = #hash(mypass)#>

		<CFTRY> 
	
            <CFQUERY NAME="changepassword" DATASOURCE="#THIS.dsn#">
                
                UPDATE users 
            
                    SET password_hash = <CFQUERYPARAM VALUE="#change_password_hash#" CFSQLTYPE="cf_sql_varchar">
                    
                    WHERE username_hash = <CFQUERYPARAM VALUE="#THIS.username_hash#" CFSQLTYPE="cf_sql_varchar">
        
            </CFQUERY>
    
            <CFSET resultStruct.statusCode = 1 />
            <CFSET resultStruct.statusClass = "success" />
            <CFSET resultStruct.statusMessage = "Your password has been updated!" />
            <CFRETURN resultStruct />
            
            <CFCATCH>
            
               <cfset resultStruct.statusCode = -1 />
               <cfset resultStruct.statusClass = "error" />
               <cfset resultStruct.statusMessage = "Sorry, there was an error updating your password!" />
               <CFRETURN resultStruct />
               
           </CFCATCH>
               
       </CFTRY> 
       
	</CFFUNCTION>

	
</CFCOMPONENT>
