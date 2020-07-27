
<!--- Authentication of user --->
<CFIF #IsDefined('cookie.remember_username_mobile')# AND #IsDefined('cookie.remember_password_mobile')#>

    <CFLOCATION URL="./quizzes/mobile_quizzes_login.cfm" ADDTOKEN="No">

<CFELSE>

	<CFCOOKIE NAME="remember_username_mobile" VALUE="-99" EXPIRES="NOW">
    <CFCOOKIE NAME="remember_password_mobile" VALUE="-99" EXPIRES="NOW">
    <CFCOOKIE NAME="myadmin_username_mobile" VALUE="-99" EXPIRES="NOW">
    <CFCOOKIE NAME="myadmin_password_mobile" VALUE="-99" EXPIRES="NOW">

</CFIF>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

  		<CFINCLUDE TEMPLATE="./_includes/_head_external_meta.cfm" />

        <CFINCLUDE TEMPLATE="./_includes/_head_external_css.cfm" />

        <CFINCLUDE TEMPLATE="./_includes/_head_shim.cfm" />

	</head>


  	<body class="hold-transition login-page">

        <div class="login-box">

          	<div class="login-logo">

                <img src="./_img/logo.png" width="300px"/>

            </div><!--- /.login-logo --->

            <div class="login-box-body">

            	<CFIF IsDefined('mymessage')>
                    <p class="login-box-msg text-red"><CFOUTPUT>#mymessage#</CFOUTPUT><br />Please try again.</p>
                <CFELSE>
                	<p class="login-box-msg">Sign in to start your session.<br />&nbsp;</p>
                </CFIF>

                <form action="./quizzes/mobile_quizzes_login.cfm" method="post">

                	<div class="form-group has-feedback">
                    	<input type="email" class="form-control" placeholder="Email" name="player_username">
                    	<span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                  	</div>

                  	<div class="form-group has-feedback">
                    	<input type="password" class="form-control" placeholder="Password" name="player_password">
                    	<span class="glyphicon glyphicon-lock form-control-feedback"></span>
                  	</div>

                    <!--- Remember me checkbox --->
                  	<div class="row">
                    	<div class="col-xs-8">
                      		<div class="checkbox icheck">
                        		<label>
                          			<input type="checkbox" name="player_remember"> Remember Me
                        		</label>
                      		</div>
                    	</div><!--- /.col --->
                        <div class="col-xs-4">
                            <button type="submit" class="btn btn-primary btn-block btn-flat">Sign In</button>
                        </div><!--- /.col --->
                    </div>

                </form>

                <br />

                <!--- Forgot password link --->
                <a href="./forgot/forgot_password.cfm?mobile=yes">I forgot my password</a><br />

                <!--- Link to page for self registering an account --->
                <a href="./mobile_register.cfm" class="text-center">Register as a new player</a>

          	</div><!--- /.login-box-body --->

        </div><!--- /.login-box --->

        <CFINCLUDE TEMPLATE="./_includes/_head_external_js.cfm" />

		<script type="text/javascript" language="javascript">
            $(function () {
                $('input').iCheck({
                    checkboxClass: 'icheckbox_square-blue',
                    radioClass: 'iradio_square-blue',
                    increaseArea: '20%' // optional
                });
            });
        </script>

  	</body>

</html>
