
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

                <p>
					Terms and conditions are a pain these days, but for those six
					of you out there who feel the need to read this it would be nice
					to know that if you fancy using this service you won't go hurting
					yourself or those around you. It is after all just an application
					that allows you to easily create fun quizzes.
				</p>
				<p>
					But if you feel the need to get in touch, We're always looking to
					hear from our adoring fans: <a href="mailto:fanmail@quizzically.co.uk?subject=I%20want%20you%20to%20know...">
					fanmail@quizzically.co.uk</a>
				</p>

                <hr />

				<!--- Link back to register screen --->
        		<a href="../web_register.cfm">Back to the registration screen</a>

      		</div><!--- /.login-box-body --->

    	</div><!--- /.login-box --->

        <CFINCLUDE TEMPLATE="../_includes/_head_js.cfm" />

  	</body>

</html>
