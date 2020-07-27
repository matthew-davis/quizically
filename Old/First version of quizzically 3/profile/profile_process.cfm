
<!--- Authentication of user --->
<CFINCLUDE TEMPLATE="../authenticate.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

		<CFINCLUDE TEMPLATE="../_includes/_head_internal_meta.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_internal_css.cfm" />
        
        <style>
			.nav-tabs-custom > .nav-tabs > li.active {
				border-top-color: #00C0EF;
			}

			label.error {
				margin-top: 10px;
				color: #DD4B39;	
			}
		</style>
        
        <CFINCLUDE TEMPLATE="../_includes/_head_shim.cfm" />

		<!--- Menu Bookmark Variable --->
        <CFSET menupage = 'x' />

	</head>
    
    
     <!--- Logged in user details --->
    <CFSET loginObj = CreateObject("component","quizzicallyincludes.login") />	
	<CFSCRIPT>
        loginObj.dsn = dsn;
		loginObj.username = cookie.myadmin_username;
		loginObj.password = cookie.myadmin_password;
        logindetails = loginObj.getLoginDetails();
    </CFSCRIPT> 
       
    
    <!--- Send form details to the database --->
    <CFSET profileObj = CreateObject("component","quizzicallyincludes.profile") />	
	<CFSCRIPT>
        profileObj.dsn = dsn;
		profileObj.user_UUID = form.user_UUID;
        profileObj.user_details_UUID = form.user_details_UUID;
        profileObj.logged_user = cookie.myadmin_username;
        profileObj.user_firstname = form.user_firstname;
		profileObj.user_lastname = form.user_lastname;
		profileObj.user_phone = form.user_phone;
		profileObj.user_organisation = form.user_organisation;
		profileObj.location_UUID = form.user_location;
		profileObj.uploadfile1 = form.uploadfile1;			       
		profileObj.new_password = form.new_password;
		profileObj.currentimage = form.currentimage1;					
        myresult = profileObj.profileProcess();
    </CFSCRIPT>

	<body class="hold-transition sidebar-mini skin-blue">
    
    	<div class="wrapper">
        
        	<CFINCLUDE TEMPLATE="../_includes/_header.cfm" />
            
            <CFINCLUDE TEMPLATE="../_includes/_menu.cfm" />
            
            <!-- Content Wrapper. Contains page content -->
      		<div class="content-wrapper"> 
 				
                
                <CFIF #myresult.statusType# EQ 'normal'>
                
                	<CFSET locationurl = "../dashboard/dashboard.cfm?statuscode=" & "#myresult.statusCode#" & "&statusclass=" & "#myresult.statusClass#" & "&statusmessage=" & "#myresult.statusMessage#" /> 
                
                <CFELSE>
                
                	<CFCOOKIE NAME="remember_username" VALUE="-99" EXPIRES="NOW">
                    <CFCOOKIE NAME="remember_password" VALUE="-99" EXPIRES="NOW">
                    <CFCOOKIE NAME="myadmin_username" VALUE="-99" EXPIRES="NOW">
                    <CFCOOKIE NAME="myadmin_password" VALUE="-99" EXPIRES="NOW"> 
                
                	<CFSET locationurl = "../login.cfm?statuscode=" & "#myresult.statusCode#" & "&statusclass=" & "#myresult.statusClass#" & "&statusmessage=" & "#myresult.statusMessage#" /> 
                
                </CFIF>
                
                
                <CFLOCATION URL="#locationurl#" />

            </div>          
      
            
            <CFINCLUDE TEMPLATE="../_includes/_footer.cfm" />
            
            <CFINCLUDE TEMPLATE="../_includes/_settings.cfm" />           
    
    	</div><!-- ./wrapper -->
        
        <CFINCLUDE TEMPLATE="../_includes/_head_internal_js.cfm" /> 
    
    </body>

</html>
