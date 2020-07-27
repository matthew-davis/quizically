
<!--- Authentication of user --->
<CFINCLUDE TEMPLATE="../authenticate.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

		<CFINCLUDE TEMPLATE="../_includes/_head_internal_meta.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_internal_css.cfm" />
        
        <CFINCLUDE TEMPLATE="../_includes/_head_shim.cfm" />
        
        <!--- Menu Bookmark Variable --->
        <CFSET menupage = 'manageplayers' />

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
    <CFSET playersObj = CreateObject("component","quizzicallyincludes.players") />	
	<CFSCRIPT>
        playersObj.dsn = dsn;
        playersObj.action = form.action;
        playersObj.player_details_UUID = form.player_details_UUID;
        playersObj.logged_user = cookie.myadmin_username;
		if (form.action == 'add' || form.action == 'edit') {
            playersObj.player_firstname = form.player_firstname;
            playersObj.player_lastname = form.player_lastname;
            playersObj.player_birthday = form.player_birthday;
            playersObj.player_gender = form.player_gender;
            playersObj.player_email = form.player_email;
            playersObj.player_occupation = form.player_occupation;
			playersObj.location_UUID = form.player_location;		
            if (form.action == 'add') {
                playersObj.player_password = form.player_password;				
            } else if (form.action == 'edit') {
                playersObj.player_newpassword = form.player_newpassword;		
            }			
        }
        myresult = playersObj.playerProcess();
    </CFSCRIPT>


	<body class="hold-transition sidebar-mini skin-blue">
    
    	<div class="wrapper">
        
        	<CFINCLUDE TEMPLATE="../_includes/_header.cfm" />
            
            <CFINCLUDE TEMPLATE="../_includes/_menu.cfm" />
            
            <!-- Content Wrapper. Contains page content -->
      		<div class="content-wrapper"> 
 				
				<CFSET locationurl = "./manage_players.cfm?statuscode=" & "#myresult.statusCode#" & "&statusclass=" & "#myresult.statusClass#" & "&statusmessage=" & "#myresult.statusMessage#" /> 
                <CFLOCATION URL="#locationurl#" />

            </div>          
      
            
            <CFINCLUDE TEMPLATE="../_includes/_footer.cfm" />
            
            <CFINCLUDE TEMPLATE="../_includes/_settings.cfm" />           
    
    	</div><!-- ./wrapper -->
        
        <CFINCLUDE TEMPLATE="../_includes/_head_internal_js.cfm" /> 
    
    </body>

</html>
