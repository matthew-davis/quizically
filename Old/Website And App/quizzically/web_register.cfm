

<!--- Authentication of user --->
<CFIF #IsDefined('cookie.remember_username')# AND #IsDefined('cookie.remember_password')#>

    <CFLOCATION URL="./dashboard/dashboard.cfm" ADDTOKEN="No">

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

                <img src="<CFOUTPUT>#request.baseurl#</CFOUTPUT>_img/logo.png" width="300px"/>

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
                        <input type="text" name="user_firstname" class="form-control" placeholder="First Name">
                        <span class="glyphicon glyphicon-user form-control-feedback"></span>
                    </div>

                    <div class="form-group has-feedback">
                        <input type="email" name="user_email" class="form-control" placeholder="Email">
                        <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                    </div>

                    <div class="form-group has-feedback">
                        <input type="password" name="user_password" id="user_password" class="form-control" placeholder="Password">
                        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                    </div>

                    <div class="form-group has-feedback">
                        <input type="password" name="user_repeatpassword" class="form-control" placeholder="Retype Password">
                        <span class="glyphicon glyphicon-log-in form-control-feedback"></span>
                    </div>

                    <div class="row">
                        <div class="col-xs-8">
                            <div class="checkbox icheck">
                                <input name="user_terms" class="user_terms" type="checkbox" value="1">&nbsp;&nbsp;I agree to the <a href="<CFOUTPUT>#request.baseurl#</CFOUTPUT>terms/web_terms.cfm">terms</a>
								<br />
								<span></span>
							</div>
                        </div><!--- /.col --->
                        <div class="col-xs-4">
                            <button type="submit" class="btn btn-primary btn-block btn-flat">Register</button>
                        </div><!--- /.col --->
                    </div>

                </form>

                <hr />

                <p>Once you've registered you can add more information to your profile, this just gets the ball rolling.</p>

                <br />

				<!--- Link back to login screen --->
        		<a href="./web_login.cfm" class="text-center">I already have an account</a>

      		</div><!--- /.login-box-body --->

    	</div><!--- /.login-box --->

        <CFINCLUDE TEMPLATE="./_includes/_head_js.cfm" />

		<script type="text/javascript" language="javascript">
            $(document).ready(function() {
				/* Form validation */
				var validobj = $("#myform").validate({
					rules: {
						user_firstname: "required",
						user_email: {
							required: true,
							email: true
						},
						user_password: {
							required: true,
							minlength: 5
						} ,
						user_repeatpassword: {
							required: true,
							minlength: 5,
							equalTo: "#user_password"
						},
						user_terms: "required"
					},
					messages: {
						user_firstname: "A firstname is required",
						user_email: {
							required: "An email is required",
							email: "Email format: 'name@domain.com'"
						},
						user_password: {
							required: "A password is required",
							minlength: "Must be at least 5 characters long"
						},
						user_repeatpassword: {
							required: "A repeat password is required",
							minlength: "Must be at least 5 characters long",
							equalTo: "Your password must match above"
						},
						user_terms: "You must agree to the terms"
					},
					errorPlacement: function(error, element) {
						if ($(element).hasClass('user_terms')) {
							 error.insertAfter(element.parent().parent().find('span'));
						} else {
							error.insertAfter(element.parent().find('span'));
						}
					},
					highlight: function(element) {
						if ($(element).hasClass('user_terms')) {
							$(element).closest('.checkbox').find('label').removeClass('success').addClass('error');
						} else {
							$(element).closest('.form-group').find('input').removeClass('success').addClass('error');
							$(element).closest('.form-group').find('span').removeClass('success').addClass('error');
							$(element).closest('.form-group').find('label').removeClass('success').addClass('error');
						}
					},
					unhighlight: function(element) {
						if ($(element).hasClass('user_terms')) {
							$(element).closest('.checkbox').find('label').removeClass('error').addClass('success');
						} else {
	    					$(element).closest('.form-group').find('input').removeClass('error').addClass('success');
	    					$(element).closest('.form-group').find('span').removeClass('error').addClass('success');
	    					$(element).closest('.form-group').find('label').removeClass('error').addClass('success');
						}
  					},
  					success: function(element) {
						if ($(element).attr('id') != 'user_terms-error') {
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
