
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
        	<CFSET menupage = 'managedeletedquizmasters' />
       	<CFELSE>
        	<CFSET menupage = 'managequizmasters' />
		</CFIF>

	</head>


    <!--- Send form details to the database --->
    <CFSET quizmastersObj = CreateObject("component","quizzicallyincludes.quizmasters") />
	<CFSCRIPT>
        quizmastersObj.dsn = dsn;
        quizmastersObj.action = form.action;
        quizmastersObj.user_details_UUID = form.user_details_UUID;
        quizmastersObj.logged_user = cookie.myadmin_username;
		if (form.action == 'add' || form.action == 'edit') {
            quizmastersObj.user_firstname = form.user_firstname;
            quizmastersObj.user_lastname = form.user_lastname;
            quizmastersObj.user_phone = form.user_phone;
            quizmastersObj.user_organisation = form.user_organisation;
            quizmastersObj.user_email = form.user_email;
            quizmastersObj.user_role_UUID = form.user_role;
			quizmastersObj.location_UUID = form.user_location;
			quizmastersObj.uploadfile1 = form.uploadfile1;
			quizmastersObj.free_credits = form.free_credits;
            if (form.action == 'add') {
                quizmastersObj.user_password = form.user_password;
            } else if (form.action == 'edit') {
                quizmastersObj.user_newpassword = form.user_newpassword;
				quizmastersObj.currentimage1 = form.currentimage1;
            }
        }
        myresult = quizmastersObj.quizmastersProcess();
    </CFSCRIPT>


	<body class="hold-transition sidebar-mini skin-blue">

    	<div class="wrapper">

        	<CFINCLUDE TEMPLATE="../_includes/_header.cfm" />

            <CFINCLUDE TEMPLATE="../_includes/_menu.cfm" />

            <!--- Content Wrapper. Contains page content --->
      		<div class="content-wrapper">

				<CFIF myresult.toastCode is 1>

					<CFIF #form.action# EQ 'undelete'>

						<CFSET locationurl = "./manage_deleted_quizmasters.cfm?toastCode=" & "#myresult.toastCode#" & "&toastTitle=" & "#myresult.toastTitle#" & "&toastMessage=" & "#myresult.toastMessage#" />

					<CFELSE>

						<CFSET locationurl = "./manage_quizmasters.cfm?toastCode=" & "#myresult.toastCode#" & "&toastTitle=" & "#myresult.toastTitle#" & "&toastMessage=" & "#myresult.toastMessage#" />

					</CFIF>

				<CFELSE>

					<CFIF form.action EQ "edit">

						<CFSET locationurl = "./quizmasters.cfm?toastCode=#myresult.toastCode#&toastTitle=Error&toastMessage=#myresult.toastMessage#&user_details_UUID=#user_details_UUID#&action=edit" />

					<CFELSEIF form.action EQ "delete">

						<CFSET locationurl = "./quizmasters.cfm?toastCode=#myresult.toastCode#&toastTitle=Error&toastMessage=#myresult.toastMessage#&user_details_UUID=#user_details_UUID#&action=delete" />

					</CFIF>

				</CFIF>

                <CFLOCATION URL="#locationurl#" />

            </div><!--- /.content-wrapper --->

            <CFINCLUDE TEMPLATE="../_includes/_footer.cfm" />

    	</div><!--- ./wrapper --->

        <CFINCLUDE TEMPLATE="../_includes/_head_js.cfm" />

    </body>

</html>
