
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

		<CFCOOKIE NAME="remember_username" VALUE="-99" EXPIRES="NOW">
        <CFCOOKIE NAME="remember_password" VALUE="-99" EXPIRES="NOW">
        <CFCOOKIE NAME="myadmin_username" VALUE="-99" EXPIRES="NOW">
        <CFCOOKIE NAME="myadmin_password" VALUE="-99" EXPIRES="NOW"> 
                 
	</head>

	<body>

		<CFLOCATION URL="./login.cfm" ADDTOKEN="No"> 

	</body>
 
</html>
 