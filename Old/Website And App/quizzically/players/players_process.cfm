
<!--- Authentication of user --->
<CFINCLUDE TEMPLATE="../web_authenticate.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

		<CFINCLUDE TEMPLATE="../_includes/_head_meta.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_css.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_shim.cfm" />

        <!--- Menu Bookmark Variable --->
        <CFIF #url.action# EQ 'undelete'>
        	<CFSET menupage = 'managedeletedplayers' />
       	<CFELSE>
        	<CFSET menupage = 'manageplayers' />
		</CFIF>

	</head>


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

            <!--- Content Wrapper. Contains page content --->
      		<div class="content-wrapper">

				<CFIF myresult.toastCode is 1>

					<CFIF #form.action# EQ 'undelete'>

						<CFSET locationurl = "./manage_deleted_players.cfm?toastCode=" & "#myresult.toastCode#" & "&toastTitle=" & "#myresult.toastTitle#" & "&toastMessage=" & "#myresult.toastMessage#" />

					<CFELSE>

						<CFSET locationurl = "./manage_players.cfm?toastCode=" & "#myresult.toastCode#" & "&toastTitle=" & "#myresult.toastTitle#" & "&toastMessage=" & "#myresult.toastMessage#" />

					</CFIF>

				<CFELSE>

					<CFIF form.action EQ "edit">

						<CFSET locationurl = "./players.cfm?toastCode=#myresult.toastCode#&toastTitle=Error&toastMessage=#myresult.toastMessage#&user_details_UUID=#user_details_UUID#&action=edit" />

					<CFELSEIF form.action EQ "delete">

						<CFSET locationurl = "./players.cfm?toastCode=#myresult.toastCode#&toastTitle=Error&toastMessage=#myresult.toastMessage#&user_details_UUID=#user_details_UUID#&action=delete" />

					</CFIF>

				</CFIF>

                <CFLOCATION URL="#locationurl#" />

            </div><!--- /.content-wrapper --->

            <CFINCLUDE TEMPLATE="../_includes/_footer.cfm" />

    	</div><!--- ./wrapper --->

        <CFINCLUDE TEMPLATE="../_includes/_head_js.cfm" />

    </body>

</html>
