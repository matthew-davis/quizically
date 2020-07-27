
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

                <img src="<CFOUTPUT>#request.baseurl#</CFOUTPUT>_img/logo.png" width="300px"/>

            </div><!--- /.login-logo --->

            <div class="login-box-body">

                <CFOUTPUT QUERY="quotedetails">
					<p class="register-box-msg">"#quote#" --#quote_person#</p>
				</CFOUTPUT>

				<br />

                <form id="myform" action="<CFOUTPUT>#request.baseurl#</CFOUTPUT>quizzes/mobile_quizzes_login.cfm" method="post">

					<!--- Only used to circumvent the autocomplete feature of browsers --->
					<input style="display: none;">
					<input type="password" style="display: none;">
					<!--- Browsers are stupid --->

                    <div class="form-group has-feedback">
                        <input type="text" class="form-control" placeholder="First Name" name="player_firstname" id="player_firstname" />
                        <span class="glyphicon glyphicon-user form-control-feedback"></span>
                    </div>

                    <div class="form-group has-feedback">
                        <input type="email" class="form-control" placeholder="Email" name="player_email" id="player_email" />
                        <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                    </div>

                    <div class="form-group has-feedback">
                        <input type="password" class="form-control" placeholder="Password" name="player_password" id="player_password" />
                        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                    </div>

                    <div class="form-group has-feedback">
                        <input type="password" class="form-control" placeholder="Retype Password" name="player_repeatpassword" id="player_repeatpassword" />
                        <span class="glyphicon glyphicon-log-in form-control-feedback"></span>
                    </div>

                    <div class="row">
                        <div class="col-xs-8">
                            <div class="checkbox icheck">
                                <label>
                                    <input name="player_terms" type="checkbox" value="1" />&nbsp;&nbsp;I agree to the <a href="./terms/mobile_terms.cfm">terms</a>
                                </label>
                            </div>
                        </div><!--- /.col --->
                        <div class="col-xs-4">
                            <button type="submit" class="btn btn-primary btn-block btn-flat">Register</button>
                        </div><!--- /.col --->
                    </div><!--- /.row --->

                </form>

                <hr />

                <p>Once registered you can add more information to your account profile</p>

                <br />

				<!--- Link back to login screen --->
        		<a href="<CFOUTPUT>#request.baseurl#</CFOUTPUT>mobile_login.cfm" class="text-center">I am already a player</a>

      		</div><!--- /.login-box-body --->

    	</div><!--- /.login-box --->

        <CFINCLUDE TEMPLATE="./_includes/_head_js.cfm" />

		<script type="text/javascript" language="javascript">
            $(function () {
            	/* Form validation */
				var validobj = $("#myform").validate({
					rules: {
						player_firstname: "required",
						player_email: {
							required: true,
							email: true
						},
						player_password: {
							required: true,
							minlength: 5
						} ,
						player_repeatpassword: {
							required: true,
							minlength: 5,
							equalTo: "#user_password"
						},
						player_terms: "required"
					},
					messages: {
						player_firstname: "A firstname is required",
						player_email: {
							required: "An email is required",
							email: "Email format: 'name@domain.com'"
						},
						player_password: {
							required: "A password is required",
							minlength: "Must be at least 5 characters long"
						},
						player_repeatpassword: {
							required: "A repeat password is required",
							minlength: "Must be at least 5 characters long",
							equalTo: "Your password must match above"
						},
						player_terms: "You must agree to the terms"
					},
					errorPlacement: function(error, element) {
						if ($(element).hasClass('user_terms')) {
							 error.insertAfter(element.parent().parent().find('span'));
						} else {
							error.insertAfter(element.parent().find('span'));
						}
					},
					highlight: function(element) {
						if ($(element).hasClass('player_terms')) {
							$(element).closest('.checkbox').find('label').removeClass('success').addClass('error');
						} else {
							$(element).closest('.form-group').find('input').removeClass('success').addClass('error');
							$(element).closest('.form-group').find('span').removeClass('success').addClass('error');
							$(element).closest('.form-group').find('label').removeClass('success').addClass('error');
						}
					},
					unhighlight: function(element) {
						if ($(element).hasClass('player_terms')) {
							$(element).closest('.checkbox').find('label').removeClass('error').addClass('success');
						} else {
	    					$(element).closest('.form-group').find('input').removeClass('error').addClass('success');
	    					$(element).closest('.form-group').find('span').removeClass('error').addClass('success');
	    					$(element).closest('.form-group').find('label').removeClass('error').addClass('success');
						}
  					},
  					success: function(element) {
						if ($(element).attr('id') != 'player_terms-error') {
	    					$(element).closest('.form-group').find('input').removeClass('error').addClass('success');
	    					$(element).closest('.form-group').find('span').removeClass('error').addClass('success');
	    					$(element).closest('.form-group').find('label').removeClass('error').addClass('success');
						}
  					},
  					onkeyup: false
				});

				$('input').on('ifChecked', function(event){
					if (!$.isEmptyObject(validobj.submitted)) {
			            validobj.form();
			        }
				});

				$('input').on('ifUnchecked', function(event){
					if (!$.isEmptyObject(validobj.submitted)) {
			            validobj.form();
			        }
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
