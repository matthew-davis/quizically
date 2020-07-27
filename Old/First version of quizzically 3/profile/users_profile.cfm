
<!--- Authentication of user --->
<CFINCLUDE TEMPLATE="../authenticate.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

		<CFINCLUDE TEMPLATE="../_includes/_head_internal_meta.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_internal_css.cfm" />
        
        <style>
			.nav-tabs-custom > .nav-tabs > li.active {
				border-top-color: #00C0EF;
			}

			label.error {
				margin-top: 10px;
				color: #DD4B39;	
			}
		</style>
        
        <CFINCLUDE TEMPLATE="../_includes/_head_shim.cfm" />
        
        <!--- Menu Bookmark Variable --->
        <CFSET menupage = 'x' />

	</head>
    
        
    <!--- Logged in user details --->
    <CFSET loginObj = CreateObject("component","quizzicallyincludes.login") />	
	<CFSCRIPT>
        loginObj.dsn = dsn;
		loginObj.username = cookie.myadmin_username;
		loginObj.password = cookie.myadmin_password;
        logindetails = loginObj.getLoginDetails();
    </CFSCRIPT>

	<!--- Get user info --->
    <CFSET usersObj = CreateObject("component","quizzicallyincludes.users") />		
    <CFSCRIPT>
		usersObj.dsn = dsn;
		getlocations = usersObj.getLocations();
		usersObj.user_details_UUID = logindetails.user_details_UUID;
        getuser = usersObj.getUserDetails();		
	</CFSCRIPT>
    
    <!--- Quiz Details --->
	<CFSET quizzesObj = CreateObject("component","quizzicallyincludes.quizzes") />	
    <CFIF #logindetails.user_role_UUID# NEQ 'a88aaf23-0d3f-11e5-a315-38b1dbe2bc0e'>
		<CFSCRIPT>
            quizzesObj.username_hash = logindetails.username_hash;
        </CFSCRIPT>
    </CFIF>
	<CFSCRIPT>
        quizzesObj.dsn = dsn;
        getquizdetails = quizzesObj.getQuizDetails();
    </CFSCRIPT>
    

    <body class="hold-transition sidebar-mini skin-blue">
    
    	<div class="wrapper">
        
        	<CFINCLUDE TEMPLATE="../_includes/_header.cfm" />
            
            <CFINCLUDE TEMPLATE="../_includes/_menu.cfm" />
            
            
            <!--- Content Wrapper. Contains page content --->
      		<div class="content-wrapper"> 
            
            	<section class="content-header">
                  	<h1>
                    	User Profile
                  	</h1>
                    <ol class="breadcrumb">
                    	<li><a href="../dashboard/dashboard.cfm"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                        <li class="active"><i class="fa fa-user"></i> User Profile</li>                       
                	</ol>
                </section>

                <!-- Main content -->
                <section class="content">

          			<div class="row">
            
            			<div class="col-md-3">

              				<!-- Profile Image -->
              				<div class="box box-info">
                
                				<div class="box-body">
                                
                                	<!--- Insert logged in user avatar or default to generic avatar --->
									<CFIF #logindetails.uploadfile1# NEQ ''>
                                        <CFOUTPUT QUERY = 'logindetails'>
                                            <img src="../_img/avatars/#user_details_UUID#/#uploadfile1#" class="profile-user-img img-responsive img-circle" alt="User Image" />
                                        </CFOUTPUT>
                                    <CFELSE>
                                        <img src="../_img/generic_avatar.png" class="profile-user-img img-responsive img-circle" alt="User Image" />
                                    </CFIF>
                  
                  					<h3 class="profile-username text-center"><CFOUTPUT QUERY="logindetails"><CFIF #IsDefined('logindetails.user_firstname')#>#user_firstname# #user_lastname#<CFELSE>#email_name#</CFIF></CFOUTPUT></h3>
                  
                  					<p class="text-muted text-center"><CFOUTPUT QUERY="logindetails">#user_role#</CFOUTPUT></p>

                  					<ul class="list-group list-group-unbordered">
                    					<li class="list-group-item">
                      						<b>Quiz Credits</b> <span class="label label-success pull-right"><CFOUTPUT>#logindetails.credits#</CFOUTPUT></span>
                    					</li>
                    					<li class="list-group-item">
                      						<b>Ongoing Quizzes</b> <span class="label label-warning pull-right"><CFOUTPUT>#getquiznumbers.ongoing_number#</CFOUTPUT></span>
                    					</li>
                    					<li class="list-group-item">
                      						<b>Historic Quizzes</b> <span class="label label-danger pull-right"><CFOUTPUT>#getquiznumbers.historic_number#</CFOUTPUT></span>
                    					</li>
                                        <li class="list-group-item">
                      						<b>Total Quizzes</b> <span class="label label-primary pull-right"><CFOUTPUT>#getquiznumbers.ongoing_number + getquiznumbers.historic_number#</CFOUTPUT></span>
                    					</li>
                  					</ul>
                                    
                				</div><!-- /.box-body -->
              
              				</div><!-- /.box -->

            			</div><!-- /.col -->
                        
            			<div class="col-md-9">
                            
              				<div class="nav-tabs-custom">
                
                				<ul class="nav nav-tabs">
                  					<li class="active"><a href="#quizzes" data-toggle="tab">Quizzes</a></li>
                  					<li><a href="#account" data-toggle="tab">Account</a></li>
                				</ul>
                
                				<div class="tab-content">
                  
                  					<div class="active tab-pane" id="quizzes">
                    
                    					<table id="myTable" class="table table-bordered table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Started</th>
                                                    <th>Code</th>
                                                    <th>Rounds</th>
                                                    <th>Questions</th>
                                                    <th>Location</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <CFOUTPUT QUERY="getquizdetails">
                                                    <tr id="#quiz_UUID#">                     
                                                        <td><span style="display: none;">#quiz_created#</span>#DateFormat(quiz_created, 'dd/mm/yyyy')#</td>
                                                        <td>#quiz_code#</td>
                                                        <td>#quiz_rounds#</td>
                                                        <td>#quiz_questions#</td>
                                                        <td>#location#</td>
                                                        <td>
                                                            <CFIF #quiz_status# EQ 'ongoing'>
                                                                <form style="display: inline;" method="post" action="./quizzes_question.cfm?quiz_UUID=#quiz_UUID#">
                                                                    <input type="submit" class="btn btn-xs btn-warning" value="Continue Quiz">
                                                                </form>
                                                                &nbsp;&nbsp;
                                                                <button class="btn btn-xs btn-danger cancelbutton">Cancel Quiz</button>
                                                            <CFELSEIF #quiz_status# EQ 'historic'>
                                                                <form style="display: inline;" method="post" action="./quizzes_quiz_finish.cfm?origin=historic&myadmin_quiz_UUID=#quiz_UUID#">
                                                                    <input type="submit" class="btn btn-xs btn-danger" value="Quiz Details">
                                                                </form>
                                                            </CFIF> 
                                                        </td>
                                                    </tr>
                                                </CFOUTPUT> 
                                            </tbody>
                                        </table>
                    				
                  					</div><!-- /.tab-pane -->
                                    
                  					<div class="tab-pane" id="account">
                                    
                                    	<div class="row">
                                       						
                                            <!-- form start -->
                                            <form role="form" method="post" action="./profile_process.cfm" name="myform" id="myform" enctype="multipart/form-data">
                                          
                                                <!--- Only used to circumvent the autocomplete feature of browsers --->
                                                <input style="display: none;">
                                                <input type="password" style="display: none;">  
                                                <!--- Browsers are stupid --->
                                                
                                                <CFOUTPUT>
                                                	<input type="hidden" name="user_UUID" value="#logindetails.user_UUID#">
                                                    <input type="hidden" name="user_details_UUID" value="#logindetails.user_details_UUID#">
                                                </CFOUTPUT> 
    
                                                <!--- column width --->
                                                <div class="col-md-8">
                                                
                                                	<p style="font-size: 18px;"><strong>Account:</strong> <CFOUTPUT>#getuser.user_email#</CFOUTPUT></p>
 
                                                	<div class="row">
                                                        
                                                        <div class="col-md-6">
                                                            
                                                            <div class="form-group">
                                                                <label for="user_firstname">First Name</label> <span style="font-size: 20px;">&nbsp;</span>
                                                                <input type="text" class="form-control" name="user_firstname" id="user_firstname" placeholder="First Name" <CFOUTPUT QUERY="getuser">value="#user_firstname#"</CFOUTPUT> />
                                                            </div>
                                                            
                                                            <div class="form-group">
                                                                <label for="user_organisation">Organisation</label> <span style="font-size: 20px;">&nbsp;</span>
                                                                <input type="text" class="form-control" name="user_organisation" id="user_organisation" placeholder="Organisation"<CFOUTPUT QUERY="getuser">value="#user_organisation#"</CFOUTPUT> />
                                                            </div>
                                                            
                                                            <div class="form-group">
                                                                <label for="user_phone">Phone</label> <span style="font-size: 20px;">&nbsp;</span>
                                                                <input type="text" class="form-control" name="user_phone" id="user_phone" placeholder="Phone" <CFOUTPUT QUERY="getuser">value="#user_phone#"</CFOUTPUT> />
                                                            </div>
                                                            
                                                            <div class="form-group">
                                                                <label>Location</label> <span style="font-size: 20px;">&nbsp;</span>
                                                                <select class="form-control select2-location" name="user_location" id="user_location" style="width: 100%;">
                                                                    <option value="">&nbsp;</option>
                                                                    <CFOUTPUT QUERY="getlocations">
                                                                        <option value="#location_UUID#" <CFIF getuser.location_UUID EQ location_UUID>selected</CFIF>>#location#</option>
                                                                    </CFOUTPUT>
                                                                </select>
                                                            </div>

                                                        </div>

                                                        <div class="col-md-6">
            
                                                           <div class="form-group">
                                                                <label for="user_lastname">Last Name</label> <span style="font-size: 20px;">&nbsp;</span>
                                                                <input type="text" class="form-control" name="user_lastname" id="user_lastname" placeholder="Last Name" <CFOUTPUT QUERY="getuser">value="#user_lastname#"</CFOUTPUT> />
                                                            </div>

                                                            <div class="form-group">
                                                                <label for="new_password">New Password</label> <span style="font-size: 20px;">&nbsp;</span>
                                                                <input type="password" class="form-control" name="new_password" id="new_password"placeholder="New Password" />
                                                            </div>
                                                            
                                                            <div class="form-group">
                                                                <label for="repeat_new_password">Confirm Password</label> <span style="font-size: 20px;">&nbsp;</span>
                                                                <input type="password" class="form-control" name="repeat_new_password" id="repeat_new_password" placeholder="New Password" />
                                                            </div>

                                                        </div>
                                                    
                                                    </div>                                                  
                                                
                                                </div>
                                                
                                                <!--- column width --->
                                                <div class="col-md-4">
                                                
                                                	<p style="font-size: 18px;">&nbsp;</p>
                                                
                                                	<div class="row">
                                                        
                                                        <div class="col-md-12">
                                                        
                                                            <label>Upload Avatar</label> <span style="font-size: 20px;">&nbsp;</span>
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
                                                    
                                                    <CFIF #getuser.uploadfile1# NEQ ''>
                                                        
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div>
                                                                    <CFOUTPUT>
                                                                        <img src="../_img/avatars/#logindetails.user_details_UUID#/#getuser.uploadfile1#" style="border: 1px solid ##ccc; display: block; margin: auto;" />
                                                                    </CFOUTPUT>       
                                                                </div>             
                                                            </div>          
                                                        </div>
                                                        
                                                        <br />
                                                        
                                                        <div class="row">
                                                            <div class="col-md-12">                                            
                                                                <div>
                                                                    <div class="form-group">
                                                                        <label for="currentimage1">Current Image</label> (delete to remove)
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
                                                    
                                                </div>                                                
                                                
                                            </div>
    
                                        </div><!-- /.tab-pane -->
                                        
                                    </div>
                                    
                                    <div class="box-footer">
                                        <button type="submit" class="btn btn-primary">UPDATE Profile</button>
                                    </div>
    
                                </div><!-- /.nav-tabs-custom -->
                            
                            </form> 
            
            			</div><!-- /.col -->
          
          			</div><!-- /.row -->

        		</section><!-- /.content -->
      
      		</div><!-- /.content-wrapper -->
      
  
			<CFINCLUDE TEMPLATE="../_includes/_footer.cfm" />
            
            <CFINCLUDE TEMPLATE="../_includes/_settings.cfm" />           
    
    	</div><!--- ./wrapper --->
        
        <CFINCLUDE TEMPLATE="../_includes/_head_internal_js.cfm" /> 
        
        <script type="text/javascript" language="javascript">	
			$(document).ready(function() {
				$("#myform").validate({
					rules: {
						repeat_new_password: {
							equalTo: "#new_password"
						}
					},
					messages: {
						repeat_new_password: {
							equalTo: "Your Passwords do not match"
						}
					}
				});	

    			$('#myTable').DataTable({
					"order": [[ 0, "desc" ]],
					"bLengthChange": false,
					"info": false	
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
    
    </body>

</html>    
