
<!--- Authentication of user --->
<CFINCLUDE TEMPLATE="../authenticate.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

		<CFINCLUDE TEMPLATE="../_includes/_head_internal_meta.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_internal_css.cfm" />
        
        <style>
        	.pagination > .active > a, .pagination > .active > a:focus, .pagination > .active > a:hover, .pagination > .active > span, .pagination > .active > span:focus, .pagination > .active > span:hover {
				z-index: 2;
				color: #FFF;
				cursor: default;
				background-color: #00C0EF;
				border-color: #00C0EF;
			}
        </style>
        
        <CFINCLUDE TEMPLATE="../_includes/_head_shim.cfm" />
        
        <!--- Menu Bookmark Variable --->
        <CFSET menupage = 'manageusers' />

	</head>
    
        
    <!--- Logged in user details --->
    <CFSET loginObj = CreateObject("component","quizzicallyincludes.login") />	
	<CFSCRIPT>
        loginObj.dsn = dsn;
		loginObj.username = cookie.myadmin_username;
		loginObj.password = cookie.myadmin_password;
        logindetails = loginObj.getLoginDetails();
    </CFSCRIPT>   
    
    <!--- User Details --->   
    <CFSET usersObj = CreateObject("component","quizzicallyincludes.users") />	
	<CFIF #logindetails.user_role_UUID# NEQ 'a88aaf23-0d3f-11e5-a315-38b1dbe2bc0e'>
		<CFSCRIPT>
            usersObj.username_hash = logindetails.username_hash;
        </CFSCRIPT>
    </CFIF>	
	<CFSCRIPT>
        usersObj.dsn = dsn;		
        userdetails = usersObj.getUserDetails();
    </CFSCRIPT>
    
      
    <body class="hold-transition sidebar-mini skin-blue">
    
    	<div class="wrapper">
        
        	<CFINCLUDE TEMPLATE="../_includes/_header.cfm" />
            
            <CFINCLUDE TEMPLATE="../_includes/_menu.cfm" />
            
            
            <!--- Content Wrapper. Contains page content --->
      		<div class="content-wrapper"> 
            
            	<section class="content-header">
                  	<h1>
                    	MANAGE Users
                        &nbsp;&nbsp;
                        <span class="label label-info"><CFOUTPUT>#usersnumber.userscount#</CFOUTPUT></span>
                  		&nbsp;&nbsp;&nbsp;&nbsp;
                        <form style="display: inline;"  method="post" action="./users.cfm?action=add">
                            <input type="submit" class="btn btn-success" style="font-weight: bold;" value="Add User" />
                        </form> 
                    </h1>
                	<ol class="breadcrumb">
                    	<li><a href="../dashboard/dashboard.cfm"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                        <li class="active"><i class="fa fa-users"></i> Manage Users</li>
                	</ol>
                </section>
                
                <section class="content">
                	
                    <div class="row">
                    
                        <!--- column width --->
                        <div class="col-md-12">
                          
                            <!--- general form elements --->
                            <div class="box box-info">

                                <div class="box-body">                          

                                	<table id="myTable" class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th>User</th>
                                                <th>Email (username)</th>
                                                <th>Last Login</th>
                                                <th>Last Modified</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <CFOUTPUT QUERY="userdetails">
                                            <tr <CFIF logindetails.user_UUID EQ userdetails.user_UUID>style="background-color: ##ccc;"</CFIF>>
                                                <td><CFIF #IsDefined('user_firstname')#>#user_firstname# #user_lastname#<CFELSE>#email_name#</CFIF></td>               
                                                <td>#user_email#</td>
                                                <td>#DateFormat(last_login, 'dd/mm/yyyy')#</td>
                                                <td>#DateFormat(last_modified, 'dd/mm/yyyy')#</td>
                                                <td>
                                                	<CFIF logindetails.user_UUID NEQ userdetails.user_UUID>
                                                        <form style="display: inline;" method="post" action="./users.cfm?user_details_UUID=#user_details_UUID#&action=edit">
                                                            <input type="submit" class="btn btn-xs btn-info" value="Edit" />
                                                        </form>
                                                        &nbsp;&nbsp;
                                                        <form style="display: inline;" method="post" action="./users.cfm?user_details_UUID=#user_details_UUID#&action=delete">
                                                            <input type="submit" class="btn btn-xs btn-danger" value="Delete" />
                                                        </form>
                                                    </CFIF>
                                                </td>
                                            </tr>
                                            </CFOUTPUT> 
                                        </tbody>
                                    </table>

                            	</div><!--- /.box-body --->
                                
                            </div><!--- /.box --->
                            
                        </div>
                        
                    </div>
                    
                </section>
                
            </div>          
      
            
            <CFINCLUDE TEMPLATE="../_includes/_footer.cfm" />
            
            <CFINCLUDE TEMPLATE="../_includes/_settings.cfm" />           
    
    	</div><!--- ./wrapper --->
        
        <CFINCLUDE TEMPLATE="../_includes/_head_internal_js.cfm" /> 

        <script type="text/javascript" language="javascript">	
			$(document).ready(function() {
    			$('#myTable').DataTable({
					"bLengthChange": false,
					"info": false	
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
