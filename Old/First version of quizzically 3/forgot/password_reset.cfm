
<!--- Authentication of user --->
<CFIF #IsDefined('cookie.remember_username')# AND #IsDefined('cookie.remember_password')#>

    <CFLOCATION URL="./dashboard/dashboard.cfm" ADDTOKEN="No"> 
    
<CFELSE>

	<CFCOOKIE NAME="remember_username" VALUE="-99" EXPIRES="NOW">
    <CFCOOKIE NAME="remember_password" VALUE="-99" EXPIRES="NOW">
    <CFCOOKIE NAME="myadmin_username" VALUE="-99" EXPIRES="NOW">
    <CFCOOKIE NAME="myadmin_password" VALUE="-99" EXPIRES="NOW"> 
    
</CFIF>

<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>PharmaBuyer</title>
		
		<link type="text/css"  rel="stylesheet" href="../_css/login.css" />
		<link type="text/css"  rel="stylesheet" href="../_css/messages.css" />
		<link type="text/css"  rel="stylesheet" href="./_css/bootstrap.min.css" />
		
		<script type="text/javascript" language="javascript" src="./_scripts/jquery-2.1.3.min.js"></script>
		<script type="text/javascript" language="javascript" src="./_scripts/bootstrap.min.js"></script>
        <script type="text/javascript" language="javascript" src="./_scripts/qforms.js"></script>    
        <script type="text/javascript" language="javascript">
            <!--//
            // set the path to the qForms directory
            qFormAPI.setLibraryPath("./_scripts/");
            // this loads all the default libraries
            qFormAPI.include("*");
            qFormAPI.include("validation");
            qFormAPI.include("functions", null, "12");
            //-->
        </script>	
	</head>
    
	<body>
    
		<div id="login-wrapper">
			<div id="login-header">
				<img src="../images/logo.png" width="300">
			</div>
			
			<br>
            
           	<CFIF ((isdefined('url.username_hash')) AND (url.username_hash is not "") AND (isdefined('url.email')) AND (url.email is not ""))>
            
				<!--- Check if ID matches --->
                <CFSET mysalt = 'wat3r' />
				<CFSET myID = '#mysalt#' & '#url.email#' & '#mysalt#' />
                <CFSET test_username_hash = #hash(myID)#>
                
                <CFIF #url.username_hash# EQ #test_username_hash#> 
                    
                    <CFIF IsDefined("mymessage")>
						<CFOUTPUT>
                        <p align="center"  class="#messageclass#">
                            #mymessage#
                        </p>
                        </CFOUTPUT>
                    <CFELSE>
                        <p align="center">&nbsp;</p>
                    </CFIF> 
                    
                    <div id="login-box">
                        <form method="post" action="password_reset_process.cfm" name="myform">
                        
                            <CFOUTPUT>
                                <input type="hidden" name="username_hash" id="username_hash" value="#url.username_hash#">
                            </CFOUTPUT>
                        
                            <div class="input-group">
                                <span class="input-group-addon"><strong>P:</strong></span>
                                <input class="form-control" type="text" placeholder="Password" name="password1" id="password1">
                            </div>
                            
                            <br> 
                            
                            <div class="input-group">
                                <span class="input-group-addon"><strong>C:</strong></span>
                                <input class="form-control" type="text" placeholder="Confirm Password" name="password2" id="password2">
                            </div>
                            
                            <br>
                            
                            <input class="btn btn-danger" type="submit" value="&nbsp;&nbsp;Reset Password&nbsp;">
                        
                        </form>
                    </div>
                
                    <script type="text/javascript" language="javascript">
                        <!--//
                        // initialize the qForm object
                        objForm = new qForm("myform");
                        // set error colour
                        qFormAPI.errorColor = "#FF9B9B";
                        // make these fields required
                        objForm.required("password1, password2");
                        objForm.password1.description = "Password";
                        objForm.password2.description = "Confirm Password";
                        //-->
                    </script>
                    
                <CFELSE>
                
                	<p align="center" class="error">Hack Attempt</p>

				</CFIF>                

        	<CFELSE>
        
        	 	<CFLOCATION URL="../login.cfm">
            
        	</CFIF>
            
    	</div>

	</body>

</html>
