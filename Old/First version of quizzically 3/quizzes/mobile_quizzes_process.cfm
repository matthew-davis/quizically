
<!--- Authentication of user --->
<CFINCLUDE TEMPLATE="../mobile_authenticate.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

		<CFINCLUDE TEMPLATE="../_includes/_head_internal_meta.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_internal_css.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_shim.cfm" />

	</head>


    <!--- create an instance of the product object --->
	<CFSET quizzesObj = CreateObject("component","quizzicallyincludes.mobile_quizzes") />
    <CFSCRIPT>
        quizzesObj.dsn = dsn;
		quizzesObj.participant_team = form.team_name;
		quizzesObj.quiz_code = form.quiz_code;
		quizzesObj.username_hash = cookie.myadmin_username_mobile;
        myresult = quizzesObj.joinQuiz();
    </CFSCRIPT>

    <CFCOOKIE NAME="myadmin_quiz_UUID" VALUE="#myresult.quiz_UUID#" EXPIRES="1">


	<body class="hold-transition register-page">

        <div class="register-box">

            <div class="register-logo">

                <img src="../_img/logo.png" width="300px"/>

            </div>

            <div class="register-box-body">

            	<CFIF #myresult.toastCode# EQ  1>

					<CFLOCATION URL="./mobile_quizzes_wait.cfm" />

				<CFELSE>

					<CFLOCATION URL="./mobile_quizzes_login.cfm?toastcode=#myresult.toastCode#&toasttitle=#myresult.toastTitle#&toastmessage=#myresult.toastMessage#" />

                </CFIF>

            </div>

        </div>

        <CFINCLUDE TEMPLATE="../_includes/_head_internal_js.cfm" />

	</body>

</html>
