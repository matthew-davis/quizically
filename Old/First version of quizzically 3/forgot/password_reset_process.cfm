
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
				registerOBj.username_hash = form.username_hash;
				registerObj.password = form.password1;
				registerObj.confirm_password = form.password2;
				// execute the add method (function) and pass in the dsn value
				myresult = registerOBj.password_reset();
			</CFSCRIPT>	
            
            <CFCOOKIE NAME="myadmin_username" VALUE="-99" EXPIRES="NOW">
            <CFCOOKIE NAME="myadmin_password" VALUE="-99" EXPIRES="NOW"> 
            <CFCOOKIE NAME="myadmin_role" VALUE="-99" EXPIRES="NOW"> 
            <CFCOOKIE NAME="myadmin_name" VALUE="-99" EXPIRES="NOW">
            <CFCOOKIE NAME="myadmin_usercode" VALUE="-99" EXPIRES="NOW">            
            
            <CFOUTPUT>
				<CFIF #myresult.statusCode# EQ 1>
                    <CFSET messageclass = "success" />
                    <CFSET mymessage = "#myresult.statusMessage#">
                <CFELSEIF #myresult.statusCode# EQ -2>
                    <CFSET messageclass = "error" />
                    <CFSET mymessage = "#myresult.statusMessage#">
                <CFELSEIF #myresult.statusCode# EQ -1>
                    <CFSET messageclass = "error" />
                    <CFSET mymessage = "#myresult.statusMessage#">
                </CFIF>
            </CFOUTPUT>
            
            <CFOUTPUT>
            	<CFLOCATION URL="../login.cfm?messageclass=#messageclass#&mymessage=#mymessage#">
            </CFOUTPUT>
            <CFABORT>
			
		</div>
	
	</body>
    
</html>







		




