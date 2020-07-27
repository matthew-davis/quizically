
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

                <form action="./dashboard/dashboard.cfm" method="post">
                
                	<div class="form-group has-feedback">
                    	<input type="email" class="form-control" placeholder="Email" name="admin_username">
                    	<span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                  	</div>
                  
                  	<div class="form-group has-feedback">
                    	<input type="password" class="form-control" placeholder="Password" name="admin_password">
                    	<span class="glyphicon glyphicon-lock form-control-feedback"></span>
                  	</div>
                    
                    <!--- Remember me checkbox --->
                  	<div class="row">                    
                    	<div class="col-xs-8"> 
                      		<div class="checkbox icheck">
                        		<label>
                          			<input type="checkbox" name="remember"> Remember Me     
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
                <a href="./forgot/forgot_password.cfm">I forgot my password</a><br />
                
                <!--- Link to page for self registering an account --->
                <a href="./register.cfm" class="text-center">Register as a new quizmaster</a>
    
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
        
        <!--- Runs if the details of an action are passed through displaying a toast --->
        <CFIF #IsDefined('url.statuscode')#>
			<CFOUTPUT>	
				<script type="text/javascript" language="javascript">	
                    $(document).ready(function() {
					
						 toastr.options = {
						  "closeButton": true,
						  "debug": false,
						  "newestOnTop": true,
						  "progressBar": false,
						  "positionClass": "toast-top-right",
						  "preventDuplicates": false,
						  "onclick": null,
						  "showDuration": "300",
						  "hideDuration": "1000",
						  "timeOut": "5000",
						  "extendedTimeOut": "1000",
						  "showEasing": "swing",
						  "hideEasing": "linear",
						  "showMethod": "fadeIn",
						  "hideMethod": "fadeOut"
						};

						<CFIF #url.statuscode# EQ -1>
							toastr["error"]("#statusmessage#", "#statusclass#");						
						<CFELSEIF #url.statuscode# EQ 1>
							toastr["success"]("#statusmessage#", "#statusclass#");
						<CFELSE>
							toastr["error"]("Error", "Error");
						</CFIF>
                    });
                </script>
			</CFOUTPUT>
        </CFIF>

  	</body>
    
</html>
