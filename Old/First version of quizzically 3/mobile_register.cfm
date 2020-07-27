
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


  	<body class="hold-transition register-page">

    	<div class="register-box">

            <div class="register-logo">

                <img src="./_img/logo.png" width="300px"/>

            </div>

            <div class="register-box-body">

            	<CFIF IsDefined('mymessage')>
                    <p class="register-box-msg text-red"><CFOUTPUT>#mymessage#</CFOUTPUT><br />Please try again.</p>
                <CFELSE>
                	<p class="register-box-msg">Register as a new player<br />&nbsp;</p>
                </CFIF>

                <form action="./quizzes/mobile_quizzes_login.cfm" method="post">

                    <div class="form-group has-feedback">
                        <input type="text" name="player_firstname" class="form-control" placeholder="First Name">
                        <span class="glyphicon glyphicon-user form-control-feedback"></span>
                    </div>

                    <div class="form-group has-feedback">
                        <input type="email" name="player_email" class="form-control" placeholder="Email">
                        <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                    </div>

                    <div class="form-group has-feedback">
                        <input type="password" name="player_password" class="form-control" placeholder="Password">
                        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                    </div>

                    <div class="form-group has-feedback">
                        <input type="password" name="player_repeatpassword" class="form-control" placeholder="Retype Password">
                        <span class="glyphicon glyphicon-log-in form-control-feedback"></span>
                    </div>

                    <div class="row">
                        <div class="col-xs-8">
                            <div class="checkbox icheck">
                                <label>
                                    <input name="player_terms" type="checkbox" value="1">&nbsp;&nbsp;I agree to the <a href="./terms/terms_mobile.cfm">terms</a>
                                </label>
                            </div>
                        </div><!--- /.col --->
                        <div class="col-xs-4">
                            <button type="submit" class="btn btn-primary btn-block btn-flat">Register</button>
                        </div><!--- /.col --->
                    </div>

                </form>

                <br />

                <p>Once registered you can add more information to your account profile</p>

                <br />

				<!--- Link back to login screen --->
        		<a href="./mobile_login.cfm" class="text-center">I am already a player</a>

      		</div><!--- /.form-box --->

    	</div><!--- /.register-box --->

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
