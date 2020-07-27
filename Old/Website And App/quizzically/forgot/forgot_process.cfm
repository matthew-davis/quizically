
<!--- Authentication of user --->
<CFIF (#IsDefined('cookie.remember_username')# AND #IsDefined('cookie.remember_password')#) OR (#IsDefined('cookie.remember_username_mobile')# AND #IsDefined('cookie.remember_password_mobile')#)>

	<CFIF #url.format# EQ 'mobile'>

	    <CFLOCATION URL="./quizzes/mobile_quizzes_login.cfm" ADDTOKEN="No" />

	<CFELSE>

		<CFLOCATION URL="./dashboard/dashboard.cfm" ADDTOKEN="No" />

	</CFIF>

<CFELSE>

	<CFCOOKIE NAME="remember_username" VALUE="-99" EXPIRES="NOW" />
    <CFCOOKIE NAME="remember_password" VALUE="-99" EXPIRES="NOW" />
    <CFCOOKIE NAME="myadmin_username" VALUE="-99" EXPIRES="NOW" />
    <CFCOOKIE NAME="myadmin_password" VALUE="-99" EXPIRES="NOW" />
	<CFCOOKIE NAME="remember_username_mobile" VALUE="-99" EXPIRES="NOW" />
	<CFCOOKIE NAME="remember_password_mobile" VALUE="-99" EXPIRES="NOW" />
	<CFCOOKIE NAME="myadmin_username_mobile" VALUE="-99" EXPIRES="NOW" />
	<CFCOOKIE NAME="myadmin_password_mobile" VALUE="-99" EXPIRES="NOW" />

</CFIF>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

  		<CFINCLUDE TEMPLATE="../_includes/_head_meta.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_css.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_shim.cfm" />

	</head>


	<CFSET forgotObj = CreateObject("component","quizzicallyincludes.forgot") />
	<CFSCRIPT>
    	forgotObj.dsn = dsn;
        forgotObj.format = url.format;
        forgotObj.admin_email = form.admin_email;
		myresult = forgotObj.forgotProcess();
    </CFSCRIPT>


	<body class="hold-transition sidebar-mini skin-blue">

    	<div class="wrapper">

        	<CFINCLUDE TEMPLATE="../_includes/_header.cfm" />

            <CFINCLUDE TEMPLATE="../_includes/_menu.cfm" />

            <!-- Content Wrapper. Contains page content -->
      		<div class="content-wrapper">

                <CFIF #url.format# EQ 'web'>
					<CFSET locationurl = "./web_login.cfm?toastCode=" & "#myresult.statusCode#" & "&statusclass=" & "#myresult.statusClass#" & "&statusmessage=" & "#myresult.statusMessage#" />
				<CFELSE>
					<CFSET locationurl = "./mobile_login.cfm?toastCode=" & "#myresult.statusCode#" & "&statusclass=" & "#myresult.statusClass#" & "&statusmessage=" & "#myresult.statusMessage#" />
                </CFIF>

                <CFLOCATION URL="#locationurl#" />

            </div>

            <CFINCLUDE TEMPLATE="../_includes/_footer.cfm" />

            <CFINCLUDE TEMPLATE="../_includes/_settings.cfm" />

    	</div><!-- ./wrapper -->

        <CFINCLUDE TEMPLATE="../_includes/_head_js.cfm" />

    </body>

</html>
