
<!--- Authentication of user --->
<CFINCLUDE TEMPLATE="../authenticate.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

		<CFINCLUDE TEMPLATE="../_includes/_head_internal_meta.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_internal_css.cfm" />
        
        <CFINCLUDE TEMPLATE="../_includes/_head_shim.cfm" />
        
        <!--- Menu Bookmark Variable --->
        <CFSET menupage = 'purchasequiz' />

	</head>
    
        
    <!--- Logged in user details --->
    <CFSET loginObj = CreateObject("component","quizzicallyincludes.login") />	
	<CFSCRIPT>
        loginObj.dsn = dsn;
		loginObj.username = cookie.myadmin_username;
		loginObj.password = cookie.myadmin_password;
        logindetails = loginObj.getLoginDetails();
    </CFSCRIPT> 
         
    
    <body class="hold-transition sidebar-mini skin-blue">
    
    	<div class="wrapper">
        
        	<CFINCLUDE TEMPLATE="../_includes/_header.cfm" />
            
            <CFINCLUDE TEMPLATE="../_includes/_menu.cfm" />
            
            
            <!--- Content Wrapper. Contains page content --->
      		<div class="content-wrapper"> 
            
            	<section class="content-header">
                  	<h1>
                    	PURCHASE Quizzes
                    </h1>
                	<ol class="breadcrumb">
                    	<li><a href="../dashboard/dashboard.cfm"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                        <li class="active"><i class="fa fa-money"></i> Purchase Quizzes</li>
                	</ol>
                </section>
                
                <section class="content">
                	
                    <div class="row">

						<!--- column width --->
                        <div class="col-md-9">
                          
                            <!--- general form elements --->
                            <div class="box box-success">
                                
                                <div class="box-body">
                                
                                	<p>This is where the payment gateway goes.</p>

                                </div><!--- /.box-body --->

                            </div><!--- /.box ---> 
                                                  
                        </div>
                        
                        <!--- column width --->
                        <div class="col-md-3">
                        
                        	<div class="small-box bg-green">
                            
                            	<div class="inner">
                                	<h3><CFOUTPUT>#logindetails.credits#</CFOUTPUT></h3>
                                    <p><strong>Quiz Credits</strong></p>
                                </div>
                                
                                <div class="icon">
                                	<i class="ion ion-stats-bars"></i>
                                </div>
                            
                            </div>
                        
                        </div>
                        
                    </div>
                    
                </section>
                
            </div>
             
             
            <CFINCLUDE TEMPLATE="../_includes/_footer.cfm" />
            
            <CFINCLUDE TEMPLATE="../_includes/_settings.cfm" />           
    
    	</div><!--- ./wrapper --->
        
        <CFINCLUDE TEMPLATE="../_includes/_head_internal_js.cfm" /> 

        
	</body>

</html>     
         
         
             
 
