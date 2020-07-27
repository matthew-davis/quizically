
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


	<!--- Quotes --->
    <CFSET quotesObj = CreateObject("component","quizzicallyincludes.quotes") />
	<CFSCRIPT>
        quotesObj.dsn = dsn;
        quotedetails= quotesObj.getQuote();
    </CFSCRIPT>


  	<body class="hold-transition login-page">

    	<div class="login-box">

            <div class="login-logo">

                <img src="../_img/logo.png" width="300px"/>

            </div><!--- /.login-logo --->

            <div class="login-box-body">

                <CFOUTPUT QUERY="quotedetails">
					<p class="register-box-msg">"#quote#" --#quote_person#</p>
				</CFOUTPUT>

				<br />

                <form id="myform" action="./forgot_process.cfm?format=<CFOUTPUT>#url.format#</CFOUTPUT>" method="post">

					<CFOUTPUT>
						<input type="hidden" name="format" id="format" value="<CFOUTPUT>#url.format#</CFOUTPUT>" />
					</CFOUTPUT>

                    <div class="form-group has-feedback">
                        <input type="email" class="form-control" name="admin_email" placeholder="Email">
                        <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                    </div>

                    <div class="row">
                        <div class="col-xs-6 col-xs-offset-6">
                            <button type="submit" class="btn btn-primary btn-block btn-flat">Reset Password</button>
                        </div><!--- /.col --->
                    </div><!--- /.row --->

                </form>

                <hr />

				<a href="../<CFIF #url.format# EQ 'mobile'>mobile_<CFELSE>web_</CFIF>login.cfm">Return to the login screen</a>

      		</div><!--- /.login-box-body --->

    	</div><!--- /.login-box --->

        <CFINCLUDE TEMPLATE="../_includes/_head_js.cfm">

		<script type="text/javascript" language="javascript">
            $(document).ready(function() {
				/* Form validation */
				$("#myform").validate({
					rules: {
						admin_email: {
							required: true,
							email: true
						}
					},
					messages: {
						admin_email: {
							required: "An email is required",
							email: "Email format: 'name@domain.com'"
						}
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
