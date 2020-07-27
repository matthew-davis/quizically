
<html>

	<head>
    	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>PharmaBuyer</title>

 		<link href="../_css/internal.css" rel="stylesheet" type="text/css" />
  		<link href="../_css/messages.css" rel="stylesheet" type="text/css" />
  	</head>

	<body>

 		<div class="blogbodywide">

			<!--- create an instance of the product object --->
            <CFSET registerOBj = CreateObject("component","pharmabuyerincludes.registrants") />
            <CFSCRIPT>
                // set components 'THIS' scope constructor variables
                registerObj.dsn = dsn;
                registerOBj.admin_username = form.admin_username;
                // execute the add method (function) and pass in the dsn value
                myresult = registerOBj.forgotten_password_process();
            </CFSCRIPT>

            <CFCOOKIE NAME="myadmin_username" VALUE="-99" EXPIRES="NOW">
            <CFCOOKIE NAME="myadmin_password" VALUE="-99" EXPIRES="NOW">
			<CFCOOKIE NAME="myadmin_username_mobile" VALUE="-99" EXPIRES="NOW">
            <CFCOOKIE NAME="myadmin_password_mobile" VALUE="-99" EXPIRES="NOW">


            <CFIF #myresult.statusCode# EQ 1>
            	<CFSET messageclass = "success" />
                <CFSET mymessage = "We have emailed you a link to reset your password">
            <CFELSEIF #myresult.statusCode# EQ -2>
            	<CFSET messageclass = "error" />
                <CFSET mymessage = "Sorry, the email address does not exist!">
            <CFELSEIF #myresult.statusCode# EQ -1>
            	<CFSET messageclass = "error" />
            	<CFSET mymessage = "Sorry, there was an error retrieving your details!">
            </CFIF>

            <CFOUTPUT>
            	<CFLOCATION URL="../login.cfm?messageclass=#messageclass#&mymessage=#mymessage#">
            </CFOUTPUT>
            <CFABORT>

		</div>

	</body>

</html>
