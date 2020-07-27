
<!--- Authentication of user --->
<CFINCLUDE TEMPLATE="../authenticate.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

		<CFINCLUDE TEMPLATE="../_includes/_head_internal_meta.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_internal_css.cfm" />
        
        <style>
			label.error {
				margin-top: 10px;
				color: #DD4B39;	
			}
		</style>
        
        <CFINCLUDE TEMPLATE="../_includes/_head_shim.cfm" />
        
        <!--- Menu Bookmark Variable --->
        <CFIF #url.action# EQ 'undelete'>
        	<CFSET menupage = 'managedeletedusers' />
       	<CFELSE>           
        	<CFSET menupage = 'manageusers' />
		</CFIF>
        
	</head>
    
        
    <!--- Logged in user details --->
    <CFSET loginObj = CreateObject("component","quizzicallyincludes.login") />	
	<CFSCRIPT>
        loginObj.dsn = dsn;
		loginObj.username = cookie.myadmin_username;
		loginObj.password = cookie.myadmin_password;
        logindetails = loginObj.getLoginDetails();
    </CFSCRIPT>

	<!--- Get dropdown info --->
    <CFSET usersObj = CreateObject("component","quizzicallyincludes.users") />		
    <CFSCRIPT>
		usersObj.dsn = dsn;
		usersObj.user_role_UUID = logindetails.user_role_UUID;
		getlocations = usersObj.getLocations();
		getusersroles = usersObj.getUserRoles();
	</CFSCRIPT>
    
    <CFIF #url.action# EQ 'undelete'>
        <CFSCRIPT>
			usersObj.user_undelete = 'yes';
		</CFSCRIPT>
	</CFIF>
    
    <!--- Get user details is this is not an add --->
	<CFIF #url.action# NEQ 'add'>
		<CFSCRIPT>
			usersObj.user_details_UUID = url.user_details_UUID;
			getuser = usersObj.getUserDetails();
		</CFSCRIPT>
	</CFIF>
    
    <body class="hold-transition sidebar-mini skin-blue">
    
    	<div class="wrapper">
        
        	<CFINCLUDE TEMPLATE="../_includes/_header.cfm" />
            
            <CFINCLUDE TEMPLATE="../_includes/_menu.cfm" />
            
            
            <!--- Content Wrapper. Contains page content --->
      		<div class="content-wrapper"> 
            
            	<section class="content-header">
                  	<h1>
                    	<CFOUTPUT>#UCASE(url.action)#</CFOUTPUT> User
                  	</h1>
                    <ol class="breadcrumb">
                    	<li><a href="../dashboard/dashboard.cfm"><i class="fa fa-dashboard"></i> Dashboard</a></li>  
                        <CFIF #url.action# EQ 'undelete'>
							<li><a href="./manage_users.cfm"><i class="fa fa-users"></i> Manage Deleted Users</a></li>							
                            <li class="active"><i class="fa fa-user"></i> Un-Delete User</li>
                        <CFELSE>           
                            <li><a href="./manage_users.cfm"><i class="fa fa-users"></i> Manage Users</a></li>
							<CFIF #url.action# EQ 'add'>
                                <li class="active"><i class="fa fa-user"></i> Add User</li>
                            <CFELSEIF #url.action# EQ 'edit'>
                                <li class="active"><i class="fa fa-user"></i> Edit User</li>
                            <CFELSEIF #url.action# EQ 'delete'>
                                <li class="active"><i class="fa fa-user"></i> Delete User</li>
                            </CFIF> 
                        </CFIF>                      
                	</ol>
                </section>
                
                <section class="content">
                	
                    <div class="row">
                    
                    	<!-- form start -->
                        <form role="form" method="post" action="./users_process.cfm" id="myform" name="myform" enctype="multipart/form-data">
                      
                            <!--- Only used to circumvent the autocomplete feature of browsers --->
                            <input style="display: none;">
                            <input type="password" style="display: none;">  
                            <!--- Browsers are stupid --->
                            
                            <CFOUTPUT>
                                <input type="hidden" name="action" value="#url.action#">
                                <input type="hidden" name="user_details_UUID" value="<CFIF #url.action# NEQ 'add'>#user_details_UUID#</CFIF>">
                            </CFOUTPUT> 
                    
                            <!--- column width --->
                            <div class="col-md-8">
                              
                                <!--- general form elements --->
                                <div class="box <CFIF (#url.action# EQ "delete") OR (#url.action# EQ "undelete")><CFOUTPUT>box-danger</CFOUTPUT><CFELSE><CFOUTPUT>box-info</CFOUTPUT></CFIF>">
                                
                                	<div class="box-header with-border">
                                    
                                    	<p>Fields marked with an <span class="text-red" style="font-size: 20px;">*</span> must be filled in</p>
                                    
                                    </div>
                                    
                                    <div class="box-body">

                                        <div class="row">
                                    
                                            <div class="col-md-6">
                                                
                                                <div class="form-group">
                                                    <label for="user_firstname">First Name</label> <span class="text-red" style="font-size: 20px;">*</span>
                                                    <input type="text" class="form-control" name="user_firstname" id="user_firstname" placeholder="First Name" <CFIF #url.action# NEQ "add"><CFOUTPUT QUERY="getuser">value="#user_firstname#"</CFOUTPUT></CFIF> />
                                                </div>
                                                
                                                <div class="form-group">
                                                    <label for="user_lastname">Last Name</label> <span style="font-size: 20px;">&nbsp;</span>
                                                    <input type="text" class="form-control" name="user_lastname" id="user_lastname" placeholder="Last Name" <CFIF #url.action# NEQ "add"><CFOUTPUT QUERY="getuser">value="#user_lastname#"</CFOUTPUT></CFIF> />
                                                </div>
                                                
                                                <div class="form-group">
                                                    <label for="user_phone">Phone</label> <span style="font-size: 20px;">&nbsp;</span>
                                                    <input type="text" class="form-control" name="user_phone" id="user_phone" placeholder="Phone" <CFIF #url.action# NEQ "add"><CFOUTPUT QUERY="getuser">value="#user_phone#"</CFOUTPUT></CFIF> />
                                                </div>
                                                
                                                <div class="form-group">
                                                    <label for="user_organisation">Organisation</label> <span style="font-size: 20px;">&nbsp;</span>
                                                    <input type="text" class="form-control" name="user_organisation" id="user_organisation" placeholder="Organisation"<CFIF #url.action# NEQ "add"><CFOUTPUT QUERY="getuser">value="#user_organisation#"</CFOUTPUT></CFIF> />
                                                </div>
  
                                            </div>
                                            
                                            <div class="col-md-6">

                                                <div class="form-group">
                                                    <label for="user_email">Email (Username)</label> <span class="text-red" style="font-size: 20px;">*</span>
                                                    <input type="email" class="form-control" name="user_email" id="user_email" placeholder="Email" <CFIF #url.action# NEQ "add"><CFOUTPUT QUERY="getuser">value="#user_email#"</CFOUTPUT></CFIF> />
                                                </div>
                                                
                                                <CFIF #url.action# is "add">
                                                    <div class="form-group">
                                                        <label for="user_password">Password</label> <span class="text-red" style="font-size: 20px;">*</span>
                                                        <input type="password" class="form-control" name="user_password" placeholder="Password" />
                                                    </div>
                                                <CFELSE>
                                                    <div class="form-group">
                                                        <label for="user_newpassword">CHANGE Password</label> <span style="font-size: 20px;">&nbsp;</span>
                                                        <input type="password" class="form-control" name="user_newpassword" id="user_newpassword" placeholder="New Password" />
                                                    </div>
                                                </CFIF>
                                                
                                                <div class="form-group">
                                                    <label>User Role</label> <span class="text-red" style="font-size: 20px;">*</span>
                                                    <select class="form-control select2-role" name="user_role" id="user_role" style="width: 100%;">  	
                                                        <option value="" <CFIF action EQ 'add'>selected</CFIF>>&nbsp;</option>
                                                        <CFOUTPUT QUERY="getusersroles">
                                                            <option value="#user_role_UUID#" <CFIF action NEQ 'add'><CFIF getuser.user_role_UUID EQ user_role_UUID>selected</CFIF></CFIF>>#user_role#</option>
                                                        </CFOUTPUT>
                                                    </select>
                                                </div>
                                                
                                                <div class="form-group">
                                                    <label>Location</label> <span style="font-size: 20px;">&nbsp;</span>
                                                    <select class="form-control select2-location" name="user_location" id="user_location" style="width: 100%;">
                                                        <option value="" <CFIF action EQ 'add'>selected</CFIF>>&nbsp;</option>
                                                        <CFOUTPUT QUERY="getlocations">
                                                            <option value="#location_UUID#" <CFIF action NEQ 'add'><CFIF getuser.location_UUID EQ location_UUID>selected</CFIF></CFIF>>#location#</option>
                                                        </CFOUTPUT>
                                                    </select>
                                                </div>

                                            </div>
                                        
                                        </div>

                                    </div><!--- /.box-body --->
                
                                    <div class="box-footer">
                                    	<CFIF #url.action# EQ 'undelete'>
                                        	<button type="submit" class="btn btn-danger">Un-Delete User</button>
                                        <CFELSE>
                                        	<button type="submit" class="btn <CFIF #url.action# NEQ "delete"><CFOUTPUT>btn-primary</CFOUTPUT><CFELSE><CFOUTPUT>btn-danger</CFOUTPUT></CFIF>"><CFIF #url.action# NEQ "delete"><CFOUTPUT>SAVE User Details</CFOUTPUT><CFELSE><CFOUTPUT>DELETE User</CFOUTPUT></CFIF></button>
                                    	</CFIF>
                                    </div>

                             	</div><!--- /.box ---> 
                                                      
                            </div>
                            
                            
                            <div class="col-md-4">
                            
                            	<!--- general form elements --->
                                <div class="box <CFIF (#url.action# EQ "delete") OR (#url.action# EQ "undelete")><CFOUTPUT>box-danger</CFOUTPUT><CFELSE><CFOUTPUT>box-info</CFOUTPUT></CFIF>">
                                    
                                    <div class="box-body">

                                        <div class="row">
                                    
                                            <div class="col-md-12">
                                            
                                            	<label>Upload Avatar</label>
                                            	<div class="input-group">
                									<span class="input-group-btn">
                    									<span class="btn btn-info btn-file">
                        									Browse&hellip; <input type="file" name="uploadfile1" multiple>
                    									</span>
                                                    </span>
                                                    <input type="text" class="form-control" readonly>
            									</div>
                                                
                                            </div>
                                            
                                        </div>
                                        
                                        <br />
  	
										<CFIF (#url.action# EQ 'edit') AND (#getuser.uploadfile1# NEQ '')>
                                            
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div>
                                                        <CFOUTPUT>
                                                            <img src="../_img/avatars/#user_details_UUID#/#getuser.uploadfile1#" style="border: 1px solid ##ccc; display: block; margin: auto;" />
                                                        </CFOUTPUT>       
                                                    </div>             
                                                </div>          
                                            </div>
                                            
                                            <br />
                                            
                                            <div class="row">
                                                <div class="col-md-12">                                            
                                                    <div>
                                                        <div class="form-group">
                                                            <label for="currentimage1">Current Image</label> (delete name to remove image)
                                                            <input type="text" class="form-control" id="currentimage1" name="currentimage1" <CFOUTPUT>value="#getuser.uploadfile1#"</CFOUTPUT> />                                                            
                                                        </div>     
                                                    </div>
                                                </div>    
                                            </div>
                                                  
                                        <CFELSE>
                                        
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div>
                                                        <img src="../_img/generic_avatar.png" style="border: 1px solid #ccc; display: block; margin: auto;" />
                                                        <input type="hidden" name="currentimage1" id="currentimage1" /> 
                                                    </div>
                                                </div> 
                                            </div>
                                            
                                        </CFIF>
                                        
                                    </div><!--- /.box-body --->
                                    
                                </div><!--- /.box ---> 
                                
                                <!--- general form elements --->
                                <div class="box <CFIF (#url.action# EQ "delete") OR (#url.action# EQ "undelete")><CFOUTPUT>box-danger</CFOUTPUT><CFELSE><CFOUTPUT>box-info</CFOUTPUT></CFIF>">
                                    
                                    <div class="box-body">
                                    
                                    	<div class="row">
                                        	
                                            <div class="col-md-6">

                                                <div class="form-group">
                                                    <label for="paid_credits">Bought Credits</label>
                                                    <input type="text" class="form-control" name="paid_credits" id="paid_credits" placeholder="Bought Credits" <CFIF #url.action# NEQ "add"><CFOUTPUT QUERY="getuser">value="#paid_credits#"</CFOUTPUT></CFIF> readonly />
                                                </div>
                                                
                                            </div>
                                            
                                            <div class="col-md-6">
                                                
                                                <div class="form-group">
                                                    <label for="free_credits">Gifted Credits</label>
                                                    <input type="text" class="form-control" name="free_credits" id="free_credits" placeholder="Gifted Credits" <CFIF #url.action# NEQ "add"><CFOUTPUT QUERY="getuser">value="#free_credits#"</CFOUTPUT></CFIF> />
                                                </div>
                                        
                                        	</div>
                                        
                                        </div>
                                        
                                    </div><!--- /.box-body --->
                                    
                                </div><!--- /.box --->   
                            
                            </div>                            			
                                        
                         </form>
                        
                    </div>
                    
                </section>
                
            </div>          
      
            
            <CFINCLUDE TEMPLATE="../_includes/_footer.cfm" />
            
            <CFINCLUDE TEMPLATE="../_includes/_settings.cfm" />           
    
    	</div><!--- ./wrapper --->
        
        <CFINCLUDE TEMPLATE="../_includes/_head_internal_js.cfm" /> 
        
        <script type="text/javascript" language="javascript">
			$(document).ready(function() {
				$("#myform").validate({
					rules: {
						user_firstname: "required",
						user_email: {
							required: true,
							email: true
						},
						user_password: "required",
						user_role: "required",
						free_credits: {
							digits: true
						}
					},
					messages: {
						user_firstname: "Please enter your firstname",
						user_email: "Please enter a valid email address",
						user_password: "Please enter a password",
						user_role: "Please select a user role",
						free_credits: "Please only enter a number"
					},
				  	errorPlacement: function(error, element) {
						if (element.attr("name") == "user_role" ) {					  		
							var dropdown = element.parent().find('.select2');							
							error.insertAfter(dropdown);
						} else {
					  		error.insertAfter(element);
						}
				  	}
				});				
				
				$(".select2-role").select2( {
					minimumResultsForSearch: Infinity,
					placeholder: "Select a role..."
				});
				
				$(".select2-location").select2( {
					placeholder: "Select a location..."
				});
				
				$('.btn-file :file').on('fileselect', function(event, numFiles, label) {
        
        			var input = $(this).parents('.input-group').find(':text'),
            		log = numFiles > 1 ? numFiles + ' files selected' : label;
        
        			if( input.length ) {
            			input.val(log);
        			} else {
            			if( log ) alert(log);
        			}
        
   				});
			});	
			
			$(document).on('change', '.btn-file :file', function() {
  				var input = $(this),
      			numFiles = input.get(0).files ? input.get(0).files.length : 1,
      			label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
  				input.trigger('fileselect', [numFiles, label]);
			});
		</script>
        
        <CFIF (#url.action# EQ "delete") OR (#url.action# EQ "undelete")>
			<script type="text/javascript" language="javascript">
				$(document).ready(function() {
					$('#user_firstname').prop('disabled', true);
					$('#user_lastname').prop('disabled', true);
					$('#user_phone').prop('disabled', true);
					$('#user_organisation').prop('disabled', true);
					$('#user_email').prop('disabled', true);
					$('#user_newpassword').prop('disabled', true);
					$('#user_role').prop('disabled', true);					
					$('#user_location').prop('disabled', true);
					$('.select2-selection--single').css('cursor', 'not-allowed');
				});		
            </script>
        </CFIF>
    
    </body>

</html>
