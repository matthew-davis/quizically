
<!--- Authentication of user --->
<CFIF #IsDefined('cookie.remember_username')# AND #IsDefined('cookie.remember_password')#>

    <CFLOCATION URL="./dashboard/dashboard.cfm" ADDTOKEN="No" />

<CFELSE>

	<CFCOOKIE NAME="remember_username" VALUE="-99" EXPIRES="NOW" />
    <CFCOOKIE NAME="remember_password" VALUE="-99" EXPIRES="NOW" />
    <CFCOOKIE NAME="myadmin_username" VALUE="-99" EXPIRES="NOW" />
    <CFCOOKIE NAME="myadmin_password" VALUE="-99" EXPIRES="NOW" />

</CFIF>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

  		<CFINCLUDE TEMPLATE="./_includes/_head_meta.cfm" />

        <CFINCLUDE TEMPLATE="./_includes/_head_css.cfm" />

        <CFINCLUDE TEMPLATE="./_includes/_head_shim.cfm" />

	</head>


	<!--- Quotes --->
    <CFSET quotesObj = CreateObject("component","quizzicallyincludes.quotes") />
	<CFSCRIPT>
        quotesObj.dsn = dsn;
        quotedetails= quotesObj.getQuote();
    </CFSCRIPT>


  	<body class="hold-transition login-page">

        <div class="login-box">

          	<div class="login-logo">

                <img src="<CFOUTPUT>#request.baseurl#</CFOUTPUT>_img/logo.png" width="300px" />

            </div><!--- /.login-logo --->

            <div class="login-box-body">

				<CFOUTPUT QUERY="quotedetails">
					<p class="register-box-msg">"#quote#" --#quote_person#</p>
				</CFOUTPUT>

				<br />

                <form id="myform" action="<CFOUTPUT>#request.baseurl#</CFOUTPUT>dashboard/dashboard.cfm" method="post">

					<!--- Only used to circumvent the autocomplete feature of browsers --->
					<input style="display: none;">
					<input type="password" style="display: none;">
					<!--- Browsers are stupid --->

                	<div class="form-group has-feedback">
                    	<input type="email" class="form-control" placeholder="Email" name="admin_username" id="admin_username">
                    	<span class="glyphicon glyphicon-envelope form-control-feedback" id="glyph-username"></span>
                  	</div>

                  	<div class="form-group has-feedback">
                    	<input type="password" class="form-control" placeholder="Password" name="admin_password" id="admin_password">
                    	<span class="glyphicon glyphicon-lock form-control-feedback" id="glyph-password"></span>
                  	</div>

                    <!--- Remember me checkbox --->
                  	<div class="row">
                    	<div class="col-xs-8">
                      		<div class="checkbox icheck">
                        		<label>
                          			<input type="checkbox" name="remember"> Remember Me
                        		</label>
                      		</div>
                    	</div><!--- /.col --->
                        <div class="col-xs-4">
                            <button type="submit" class="btn btn-primary btn-block btn-flat">Sign In</button>
                        </div><!--- /.col --->
                    </div><!--- /.row --->

                </form>

                <hr />

                <!--- Forgot password link --->
                <a href="<CFOUTPUT>#request.baseurl#</CFOUTPUT>forgot/forgot_password.cfm?format=web">I forgot my password</a><br />

                <!--- Link to page for self registering an account --->
                <a href="<CFOUTPUT>#request.baseurl#</CFOUTPUT>web_register.cfm" class="text-center">Register as a new quizmaster</a>

          	</div><!--- /.login-box-body --->

        </div><!--- /.login-box --->

        <CFINCLUDE TEMPLATE="./_includes/_head_js.cfm" />

		<script type="text/javascript" language="javascript">
            $(document).ready(function() {
				/* Form validation */
				$("#myform").validate({
					rules: {
						admin_username: {
							required: true,
							email: true
						},
						admin_password: "required"
					},
					messages: {
						admin_username: {
							required: "An email is required",
							email: "Email format: 'name@domain.com'"
						},
						admin_password: "A password is required"
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

                $('input').iCheck({
                    checkboxClass: 'icheckbox_square-blue',
                    increaseArea: '20%' // optional
                });
            });
        </script>

        <CFINCLUDE TEMPLATE="./_includes/_toast.cfm" />

  	</body>

</html>
