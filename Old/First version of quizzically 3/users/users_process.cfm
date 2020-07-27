
<!--- Authentication of user --->
<CFINCLUDE TEMPLATE="../authenticate.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

		<CFINCLUDE TEMPLATE="../_includes/_head_internal_meta.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_internal_css.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_shim.cfm" />

        <!--- Menu Bookmark Variable --->
        <CFSET menupage = 'manageusers' />

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
    <CFSET usersObj = CreateObject("component","quizzicallyincludes.users") />
	<CFSCRIPT>
        usersObj.dsn = dsn;
        usersObj.action = form.action;
        usersObj.user_details_UUID = form.user_details_UUID;
        usersObj.logged_user = cookie.myadmin_username;
		if (form.action == 'add' || form.action == 'edit') {
            usersObj.user_firstname = form.user_firstname;
            usersObj.user_lastname = form.user_lastname;
            usersObj.user_phone = form.user_phone;
            usersObj.user_organisation = form.user_organisation;
            usersObj.user_email = form.user_email;
            usersObj.user_role_UUID = form.user_role;
			usersObj.location_UUID = form.user_location;
			usersObj.uploadfile1 = form.uploadfile1;
			usersObj.free_credits = form.free_credits;
            if (form.action == 'add') {
                usersObj.user_password = form.user_password;
            } else if (form.action == 'edit') {
                usersObj.user_newpassword = form.user_newpassword;
				usersObj.currentimage1 = form.currentimage1;
            }
        }
        myresult = usersObj.userProcess();
    </CFSCRIPT>

	<body class="hold-transition sidebar-mini skin-blue">

    	<div class="wrapper">

        	<CFINCLUDE TEMPLATE="../_includes/_header.cfm" />

            <CFINCLUDE TEMPLATE="../_includes/_menu.cfm" />

            <!-- Content Wrapper. Contains page content -->
      		<div class="content-wrapper">

                <CFIF #form.action# EQ 'undelete'>
					<CFSET locationurl = "./manage_deleted_users.cfm?statuscode=" & "#myresult.statusCode#" & "&statusclass=" & "#myresult.statusClass#" & "&statusmessage=" & "#myresult.statusMessage#" />
				<CFELSE>
					<CFSET locationurl = "./manage_users.cfm?statuscode=" & "#myresult.statusCode#" & "&statusclass=" & "#myresult.statusClass#" & "&statusmessage=" & "#myresult.statusMessage#" />
                </CFIF>

                <CFLOCATION URL="#locationurl#" />

            </div>


            <CFINCLUDE TEMPLATE="../_includes/_footer.cfm" />

            <CFINCLUDE TEMPLATE="../_includes/_settings.cfm" />

    	</div><!-- ./wrapper -->

        <CFINCLUDE TEMPLATE="../_includes/_head_internal_js.cfm" />

    </body>

</html>
