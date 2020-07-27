
<!--- Authentication of user --->
<CFINCLUDE TEMPLATE="../mobile_authenticate.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

		<CFINCLUDE TEMPLATE="../_includes/_head_meta.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_css.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_shim.cfm" />

	</head>


	<CFIF #IsDefined('cookie.myadmin_quiz_UUID_mobile')#>

		<!--- Get player score --->
	    <CFSET playerObj = CreateObject("component","quizzicallyincludes.mobile_quizzes") />
		<CFSCRIPT>
	        playerObj.dsn = dsn;
			playerObj.username_hash = cookie.myadmin_username_mobile;
			playerObj.quiz_UUID = cookie.myadmin_quiz_UUID_mobile;
	        playerscore = playerObj.getPlayerScore();
	    </CFSCRIPT>

	    <CFCOOKIE NAME="myadmin_quiz_UUID_mobile" VALUE="-99" EXPIRES="NOW">

	</CFIF>

	<!--- Quotes --->
    <CFSET quotesObj = CreateObject("component","quizzicallyincludes.quotes") />
	<CFSCRIPT>
        quotesObj.dsn = dsn;
        quotedetails= quotesObj.getQuote();
    </CFSCRIPT>


	<body class="hold-transition login-page">

    	<div class="login-box">

            <div class="login-logo">

                <img src="<CFOUTPUT>#request.baseurl#</CFOUTPUT>_img/logo.png" width="300px"/>

            </div><!--- /.login-logo --->

            <div class="login-box-body">

                <CFOUTPUT QUERY="quotedetails">
					<p class="register-box-msg">"#quote#" --#quote_person#</p>
				</CFOUTPUT>

				<br />

				<CFIF IsDefined('url.quiz') AND IsDefined('playerscore.participant_name')>

					<p class="text-center">Last quiz details:</p>

					<p style="font-size: 20px" class="text-center"><strong><CFOUTPUT QUERY="playerscore">#participant_name#: #participant_score#</CFOUTPUT></strong></p>

					<hr />

                </CFIF>

                <form action="<CFOUTPUT>#request.baseurl#</CFOUTPUT>quizzes/mobile_quizzes_process.cfm" method="post">

					<div class="form-group has-feedback">
                    	<input type="text" class="form-control" placeholder="Team Name" name="team_name" id="team_name">
                    	<span class="glyphicon glyphicon-bullhorn form-control-feedback" id="glyph-teamname"></span>
                  	</div>

					<div class="form-group has-feedback">
                    	<input type="text" class="form-control" placeholder="Quiz Code" name="quiz_code" id="quiz_code">
                    	<span class="glyphicon glyphicon-pencil form-control-feedback" id="glyph-quizcode"></span>
                  	</div>

                    <div class="row">
                    	<div class="col-xs-6 col-xs-offset-6">
                    		<button type="submit" class="btn btn-primary btn-block btn-flat">Join Quiz</button>
                    	</div><!--- /.col --->
                    </div><!--- /.row --->

                </form>

                <hr />

    			<!--- Link to profile --->
                <a href="<CFOUTPUT>#request.baseurl#</CFOUTPUT>profile/mobile_profile.cfm" class="text-center">Profile</a>

                <br />

                <!--- Link back to login screen --->
                <a href="<CFOUTPUT>#request.baseurl#</CFOUTPUT>mobile_logout.cfm" class="text-center">Logout</a>

            </div>

        </div>

        <CFINCLUDE TEMPLATE="../_includes/_head_js.cfm" />

		<script type="text/javascript" language="javascript">
            $(document).ready(function() {
				/* Form validation */
				$("#myform").validate({
					rules: {
						quizcode: "required"
					},
					messages: {
						quiz_code: "A quiz code is required"
					},
					errorPlacement: function(error, element) {
						error.insertAfter(element.parent().find('span'));
					},
					highlight: function(element) {
						$(element).closest('.form-group').find('input').removeClass('success').addClass('error');
						$(element).closest('.form-group').find('span').removeClass('success').addClass('error');
						$(element).closest('.form-group').find('label').removeClass('success').addClass('error');
					},
					success: function(element) {
    					$(element).closest('.form-group').find('input').removeClass('error').addClass('success');
    					$(element).closest('.form-group').find('span').removeClass('error').addClass('success');
    					$(element).closest('.form-group').find('label').removeClass('error').addClass('success');
  					},
  					onkeyup: false
				});
            });
		</script>

		<CFINCLUDE TEMPLATE="../_includes/_toast.cfm" />

	</body>

</html>
