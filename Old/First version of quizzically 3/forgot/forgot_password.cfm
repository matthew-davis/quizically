
<!--- Authentication of user --->
<CFIF #IsDefined('cookie.remember_username')# AND #IsDefined('cookie.remember_password')#>

    <CFLOCATION URL="./dashboard/dashboard.cfm" ADDTOKEN="No">

<CFELSE>

	<CFCOOKIE NAME="remember_username" VALUE="-99" EXPIRES="NOW">
    <CFCOOKIE NAME="remember_password" VALUE="-99" EXPIRES="NOW">
    <CFCOOKIE NAME="myadmin_username" VALUE="-99" EXPIRES="NOW">
    <CFCOOKIE NAME="myadmin_password" VALUE="-99" EXPIRES="NOW">

</CFIF>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

  		<CFINCLUDE TEMPLATE="../_includes/_head_internal_meta.cfm">

        <CFINCLUDE TEMPLATE="../_includes/_head_internal_css.cfm">

        <CFINCLUDE TEMPLATE="../_includes/_head_shim.cfm">

	</head>


  	<body class="hold-transition register-page">

    	<div class="register-box">

            <div class="register-logo">

                <img src="../_img/logo.png" width="300px"/>

            </div>

            <div class="register-box-body">

                <CFIF IsDefined('mymessage')>
                    <p class="register-box-msg text-red"><CFOUTPUT>#mymessage#</CFOUTPUT><br />Please try again.</p>
                <CFELSE>
                	<p class="register-box-msg">Enter your account email.<br />&nbsp;</p>
                </CFIF>

                <form action="./forgot_process.cfm" method="post">

                    <div class="form-group has-feedback">
                        <input type="email" class="form-control" name="email" placeholder="Email">
                        <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                    </div>

                    <div class="row">
                        <div class="col-xs-6 col-xs-offset-6">
                            <button type="submit" class="btn btn-primary btn-block btn-flat">Reset Password</button>
                        </div><!-- /.col -->
                    </div>

                </form>

                <br />

				<CFIF #IsDefined('url.mobile')#>

					<a href="../mobile_login.cfm" class="text-center">Return to the login screen</a>

				<CFELSE>

                	<a href="../login.cfm" class="text-center">Return to the login screen</a>

				</CFIF>

      		</div><!-- /.form-box -->

    	</div><!-- /.register-box -->

        <CFINCLUDE TEMPLATE="../_includes/_head_internal_js.cfm">

  	</body>

</html>
