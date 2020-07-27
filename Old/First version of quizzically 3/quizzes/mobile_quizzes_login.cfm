
<!--- Authentication of user --->
<CFINCLUDE TEMPLATE="../mobile_authenticate.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

		<CFINCLUDE TEMPLATE="../_includes/_head_internal_meta.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_internal_css.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_shim.cfm" />

	</head>


    <!--- Logged in user details --->
    <CFSET loginObj = CreateObject("component","quizzicallyincludes.mobile_login") />
	<CFSCRIPT>
        loginObj.dsn = dsn;
		loginObj.username = cookie.myadmin_username_mobile;
		loginObj.password = cookie.myadmin_password_mobile;
        logindetails = loginObj.getLoginDetails();
    </CFSCRIPT>

	<CFIF #IsDefined('cookie.myadmin_quiz_UUID_mobile')#>

		<!--- Player Score --->
	    <CFSET playerObj = CreateObject("component","quizzicallyincludes.mobile_quizzes") />
		<CFSCRIPT>
	        playerObj.dsn = dsn;
			playerObj.username_hash = cookie.myadmin_username_mobile;
			playerObj.quiz_UUID = cookie.myadmin_quiz_UUID_mobile;
	        playerscore = playerObj.getPlayerScore();
	    </CFSCRIPT>

	    <CFCOOKIE NAME="myadmin_quiz_UUID_mobile" VALUE="-99" EXPIRES="NOW">

	</CFIF>


	<body class="hold-transition register-page">

        <div class="register-box">

            <div class="register-logo">

                <img src="../_img/logo.png" width="300px"/>

            </div>

            <div class="register-box-body">

				<CFIF IsDefined('mymessage')>
                    <p class="login-box-msg text-red"><CFOUTPUT>#mymessage#</CFOUTPUT><br />Please try again.</p>
                <CFELSE>
                	<p class="register-box-msg">Welcome: <CFOUTPUT QUERY="logindetails"><CFIF #IsDefined('logindetails.player_firstname')#>#player_firstname# #player_lastname#<CFELSE>#email_name#</CFIF></CFOUTPUT><br />&nbsp;</p>
                </CFIF>


				<CFIF IsDefined('quiz') AND IsDefined('playerscore.participant_name')>

					<p class="text-center">Last quiz details:</p>

					<span style="font-size: 20px" class="text-center"><strong><CFOUTPUT QUERY="playerscore">#participant_name#: #participant_score#</CFOUTPUT></strong></span>

					<br /><br />

                </CFIF>

                <form action="./mobile_quizzes_process.cfm" method="post">

                    <div class="form-group has-feedback">
                        <input type="text" name="team_name" class="form-control" placeholder="Team Name">
                        <span class="glyphicon glyphicon-bullhorn form-control-feedback"></span>
                    </div>

                    <div class="form-group has-feedback">
                        <input type="text" name="quiz_code" class="form-control" placeholder="Quiz Code">
                        <span class="glyphicon glyphicon-pencil form-control-feedback"></span>
                    </div>

                    <div class="row">
                    	<div class="col-xs-6 col-xs-offset-6">
                    		<button type="submit" class="btn btn-primary btn-block btn-flat">Join Quiz</button>
                    	</div>
                    </div>
                </form>

                <br />

    			<!--- Link back to login screen --->
                <a href="../profile_mobile.cfm" class="text-center">Profile</a>

                <br />

                <!--- Link back to login screen --->
                <a href="../logout_mobile.cfm" class="text-center">Logout</a>

            </div>

        </div>

        <CFINCLUDE TEMPLATE="../_includes/_head_internal_js.cfm" />

		<!--- Runs if the details of an action are passed through displaying a toast --->
        <CFIF #IsDefined('url.toastcode')#>
			<CFOUTPUT>
				<script type="text/javascript" language="javascript">
                    $(document).ready(function() {

						 toastr.options = {
						  "closeButton": true,
						  "debug": false,
						  "newestOnTop": true,
						  "progressBar": false,
						  "positionClass": "toast-top-right",
						  "preventDuplicates": false,
						  "onclick": null,
						  "showDuration": "300",
						  "hideDuration": "1000",
						  "timeOut": "5000",
						  "extendedTimeOut": "1000",
						  "showEasing": "swing",
						  "hideEasing": "linear",
						  "showMethod": "fadeIn",
						  "hideMethod": "fadeOut"
						};

						<CFIF #url.toastcode# EQ -1>
							toastr["error"]("#toastmessage#", "#toasttitle#");
						<CFELSEIF #url.toastcode# EQ 1>
							toastr["success"]("#toastmessage#", "#toasttitle#");
						<CFELSE>
							toastr["error"]("Error", "Error");
						</CFIF>
                    });
                </script>
			</CFOUTPUT>
        </CFIF>

	</body>

</html>
