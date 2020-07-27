
<!--- Authentication of user --->
<CFINCLUDE TEMPLATE="../mobile_authenticate.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

		<CFINCLUDE TEMPLATE="../_includes/_head_meta.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_css.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_shim.cfm" />

	</head>


    <!--- Send form details to the database --->
	<CFSET quizzesObj = CreateObject("component","quizzicallyincludes.mobile_quizzes") />
    <CFSCRIPT>
        quizzesObj.dsn = dsn;
		quizzesObj.participant_team = form.team_name;
		quizzesObj.quiz_code = form.quiz_code;
		quizzesObj.username_hash = cookie.myadmin_username_mobile;
        myresult = quizzesObj.joinQuiz();
    </CFSCRIPT>

    <CFCOOKIE NAME="myadmin_quiz_UUID_mobile" VALUE="#myresult.quiz_UUID#" EXPIRES="1">


	<body class="hold-transition login-page">

        <div class="login-box">

          	<div class="login-logo">

                <img src="<CFOUTPUT>#request.baseurl#</CFOUTPUT>_img/logo.png" width="300px" />

            </div><!--- /.login-logo --->

            <div class="login-box-body">

            	<CFIF #myresult.toastCode# EQ  1>

					<CFSET locationurl = "#request.baseurl#quizzes/mobile_quizzes_wait.cfm" />

				<CFELSE>

					<CFSET locationurl = "#request.baseurl#mobile_quizzes_login.cfm?toastCode=#myresult.toastCode#&toastTitle=#myresult.toastTitle#&toastMessage=#myresult.toastMessage#" />

                </CFIF>

				<CFLOCATION URL="#locationurl#" />

            </div><!--- /.login-box-body --->

        </div><!--- /.login-box --->

        <CFINCLUDE TEMPLATE="../_includes/_head_js.cfm" />

	</body>

</html>
