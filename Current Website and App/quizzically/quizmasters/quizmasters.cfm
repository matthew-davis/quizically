
<!--- Authentication of user --->
<CFINCLUDE TEMPLATE="../web_authenticate.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

		<CFINCLUDE TEMPLATE="../_includes/_head_meta.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_css.cfm" />

        <style>
			label.error {
				margin-top: 10px;
				color: #DD4B39;
			}
		</style>

        <CFINCLUDE TEMPLATE="../_includes/_head_shim.cfm" />

        <!--- Menu Bookmark Variable --->
        <CFIF #url.action# EQ 'undelete'>
        	<CFSET menupage = 'managedeletedquizmasters' />
       	<CFELSE>
        	<CFSET menupage = 'managequizmasters' />
		</CFIF>

	</head>


	<!--- Get dropdown details --->
    <CFSET dropdownsObj = CreateObject("component","quizzicallyincludes.dropdowns") />
    <CFSCRIPT>
		dropdownsObj.dsn = dsn;
		dropdownsObj.user_role_UUID = logindetails.user_role_UUID;
		getlocations = dropdownsObj.getLocations();
		getusersroles = dropdownsObj.getUserRoles();
	</CFSCRIPT>

	<!--- Get quizmaster details --->
	<CFSET quizmastersObj = CreateObject("component","quizzicallyincludes.quizmasters") />
	<CFIF #url.action# EQ 'undelete'>
        <CFSCRIPT>
			quizmastersObj.user_undelete = 'yes';
		</CFSCRIPT>
	</CFIF>
	<CFIF #url.action# NEQ 'add'>
		<CFSCRIPT>
			quizmastersObj.dsn = dsn;
			quizmastersObj.user_details_UUID = url.user_details_UUID;
			quizmastersObj.logged_user = cookie.myadmin_username;
			quizmasterdetails = quizmastersObj.getQuizmasterDetails();
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
                    	<CFOUTPUT>#UCASE(url.action)#</CFOUTPUT> Quizmaster
                  	</h1>
                    <ol class="breadcrumb">
						<li><a href="<CFOUTPUT>#request.baseurl#</CFOUTPUT>dashboard/dashboard.cfm"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                        <CFIF #url.action# EQ 'undelete'>
							<li><a href="<CFOUTPUT>#request.baseurl#</CFOUTPUT>quizmasters/manage_deleted_quizmasters.cfm"><i class="fa fa-users"></i> Manage Deleted Quizmasters</a></li>
                            <li class="active"><i class="fa fa-user"></i> Un-Delete Quizmaster</li>
                        <CFELSE>
							<li><a href="<CFOUTPUT>#request.baseurl#</CFOUTPUT>quizmasters/manage_quizmasters.cfm"><i class="fa fa-users"></i> Manage Quizmaster</a></li>
							<CFIF #url.action# EQ 'add'>
                                <li class="active"><i class="fa fa-user"></i> Add Quizmaster</li>
                            <CFELSEIF #url.action# EQ 'edit'>
                                <li class="active"><i class="fa fa-user"></i> Edit Quizmaster</li>
                            <CFELSEIF #url.action# EQ 'delete'>
                                <li class="active"><i class="fa fa-user"></i> Delete Quizmaster</li>
                            </CFIF>
                        </CFIF>
                	</ol>
                </section><!--- /.content-header --->

                <section class="content">

                    <div class="row">

                        <form role="form" method="post" action="<CFOUTPUT>#request.baseurl#</CFOUTPUT>quizmasters/quizmasters_process.cfm?action=<CFOUTPUT>#url.action#</CFOUTPUT>" id="myform" name="myform" enctype="multipart/form-data">

                            <!--- Only used to circumvent the autocomplete feature of browsers --->
                            <input style="display: none;">
                            <input type="password" style="display: none;">
                            <!--- Browsers are stupid --->

                            <CFOUTPUT>
                                <input type="hidden" name="action" value="#url.action#">
                                <input type="hidden" name="user_details_UUID" value="<CFIF #url.action# NEQ 'add'>#user_details_UUID#</CFIF>">
                            </CFOUTPUT>

                            <div class="col-md-8">

                                <div class="box <CFIF (#url.action# EQ "delete") OR (#url.action# EQ "undelete")><CFOUTPUT>box-danger</CFOUTPUT><CFELSE><CFOUTPUT>box-info</CFOUTPUT></CFIF>">

                                	<div class="box-header with-border">

                                    	<p>Fields marked with an <span class="text-red" style="font-size: 20px;">*</span> must be filled in</p>

                                    </div><!--- /.box-header --->

                                    <div class="box-body">

                                        <div class="row">

                                            <div class="col-md-6">

                                                <div class="form-group">
                                                    <label for="user_firstname">First Name</label> <span class="text-red" style="font-size: 20px;">*</span>
                                                    <input type="text" class="form-control" name="user_firstname" id="user_firstname" placeholder="First Name" <CFIF #url.action# NEQ "add"><CFOUTPUT QUERY="quizmasterdetails">value="#user_firstname#"</CFOUTPUT></CFIF> />
                                                </div>

                                                <div class="form-group">
                                                    <label for="user_lastname">Last Name</label> <span style="font-size: 20px;">&nbsp;</span>
                                                    <input type="text" class="form-control" name="user_lastname" id="user_lastname" placeholder="Last Name" <CFIF #url.action# NEQ "add"><CFOUTPUT QUERY="quizmasterdetails">value="#user_lastname#"</CFOUTPUT></CFIF> />
                                                </div>

                                                <div class="form-group">
                                                    <label for="user_phone">Phone</label> <span style="font-size: 20px;">&nbsp;</span>
                                                    <input type="text" class="form-control" name="user_phone" id="user_phone" placeholder="Phone" <CFIF #url.action# NEQ "add"><CFOUTPUT QUERY="quizmasterdetails">value="#user_phone#"</CFOUTPUT></CFIF> />
                                                </div>

                                                <div class="form-group">
                                                    <label for="user_organisation">Organisation</label> <span style="font-size: 20px;">&nbsp;</span>
                                                    <input type="text" class="form-control" name="user_organisation" id="user_organisation" placeholder="Organisation"<CFIF #url.action# NEQ "add"><CFOUTPUT QUERY="quizmasterdetails">value="#user_organisation#"</CFOUTPUT></CFIF> />
                                                </div>

                                            </div><!--- /.col --->

                                            <div class="col-md-6">

                                                <div class="form-group">
                                                    <label for="user_email">Email (Username)</label> <span class="text-red" style="font-size: 20px;">*</span>
                                                    <input type="email" class="form-control" name="user_email" id="user_email" placeholder="Email" <CFIF #url.action# NEQ "add"><CFOUTPUT QUERY="quizmasterdetails">value="#user_email#"</CFOUTPUT></CFIF> />
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
                                                    <label>Quizmaster Role</label> <span class="text-red" style="font-size: 20px;">*</span>
                                                    <select class="form-control select2-role" name="user_role" id="user_role" style="width: 100%;">
                                                        <option value="" <CFIF action EQ 'add'>selected</CFIF>>&nbsp;</option>
                                                        <CFOUTPUT QUERY="getusersroles">
                                                            <option value="#user_role_UUID#" <CFIF action NEQ 'add'><CFIF quizmasterdetails.user_role_UUID EQ user_role_UUID>selected</CFIF></CFIF>>#user_role#</option>
                                                        </CFOUTPUT>
                                                    </select>
                                                </div>

                                                <div class="form-group">
                                                    <label>Location</label> <span style="font-size: 20px;">&nbsp;</span>
                                                    <select class="form-control select2-location" name="user_location" id="user_location" style="width: 100%;">
                                                        <option value="" <CFIF action EQ 'add'>selected</CFIF>>&nbsp;</option>
                                                        <CFOUTPUT QUERY="getlocations">
                                                            <option value="#location_UUID#" <CFIF action NEQ 'add'><CFIF quizmasterdetails.location_UUID EQ location_UUID>selected</CFIF></CFIF>>#location#</option>
                                                        </CFOUTPUT>
                                                    </select>
                                                </div>

                                            </div><!--- /.col --->

                                        </div><!--- /.row --->

                                    </div><!--- /.box-body --->

                                    <div class="box-footer">
                                    	<CFIF #url.action# EQ 'undelete'>
                                        	<button type="submit" class="btn btn-danger">Un-Delete Quizmaster</button>
                                        <CFELSE>
                                        	<button type="submit" class="btn <CFIF #url.action# NEQ "delete"><CFOUTPUT>btn-info</CFOUTPUT><CFELSE><CFOUTPUT>btn-danger</CFOUTPUT></CFIF>"><CFIF #url.action# NEQ "delete"><CFOUTPUT>SAVE Quizmaster Details</CFOUTPUT><CFELSE><CFOUTPUT>DELETE Quizmaster</CFOUTPUT></CFIF></button>
                                    	</CFIF>
                                    </div>

                             	</div><!--- /.box --->

                            </div><!--- /.col --->

                            <div class="col-md-4">

                            	<!--- general form elements --->
                                <div class="box <CFIF (#url.action# EQ "delete") OR (#url.action# EQ "undelete")><CFOUTPUT>box-danger</CFOUTPUT><CFELSE><CFOUTPUT>box-info</CFOUTPUT></CFIF>">

                                    <div class="box-body">

                                        <div class="row">

                                            <div class="col-md-12">

                                            	<label>Upload Avatar</label>
                                            	<div class="input-group">
                									<span class="input-group-btn">
                    									<span class="btn btn-file <CFOUTPUT><CFIF (#url.action# EQ "delete") OR (#url.action# EQ "undelete")>btn-danger<CFELSE>btn-info</CFIF></CFOUTPUT>">
                        									Browse&hellip; <input type="file" class="form-control" name="uploadfile1" multiple>
                    									</span>
                                                    </span>
                                                    <input type="text" class="form-control" readonly>
            									</div>

                                            </div><!--- /.col --->
                                        </div><!--- /.row --->

                                        <br />

										<CFIF (#url.action# EQ 'edit') AND (#quizmasterdetails.uploadfile1# NEQ '')>

                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div>
                                                        <CFOUTPUT>
                                                            <img src="../_img/avatars/#user_details_UUID#/#quizmasterdetails.uploadfile1#" style="border: 1px solid ##ccc; display: block; margin: auto;" />
                                                        </CFOUTPUT>
                                                    </div>
                                                </div><!--- /.col --->
                                            </div><!--- /.row --->

                                            <br />

                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div>
                                                        <div class="form-group">
                                                            <label for="currentimage1">Current Image</label> (delete name to remove image)
                                                            <input type="text" class="form-control" id="currentimage1" name="currentimage1" <CFOUTPUT>value="#quizmasterdetails.uploadfile1#"</CFOUTPUT> />
                                                        </div>
                                                    </div>
                                                </div><!--- /.col --->
                                            </div><!--- /.row --->

                                        <CFELSE>

                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div>
                                                        <img src="../_img/generic_avatar.png" style="border: 1px solid #ccc; display: block; margin: auto;" />
                                                        <input type="hidden" name="currentimage1" id="currentimage1" />
                                                    </div>
                                                </div><!--- /.col --->
                                            </div><!--- /.row --->

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
                                                    <input type="text" class="form-control" name="paid_credits" id="paid_credits" placeholder="Bought Credits" <CFIF #url.action# NEQ "add"><CFOUTPUT QUERY="quizmasterdetails">value="#paid_credits#"</CFOUTPUT></CFIF> readonly />
                                                </div>

                                            </div><!--- /.col --->

                                            <div class="col-md-6">

                                                <div class="form-group">
                                                    <label for="free_credits">Gifted Credits</label>
                                                    <input type="text" class="form-control" name="free_credits" id="free_credits" placeholder="Gifted Credits" <CFIF #url.action# NEQ "add"><CFOUTPUT QUERY="quizmasterdetails">value="#free_credits#"</CFOUTPUT></CFIF> />
                                                </div>

                                        	</div><!--- /.col --->

                                        </div><!--- /.row --->

                                    </div><!--- /.box-body --->

                                </div><!--- /.box --->

                            </div><!--- /.col --->

                         </form>

                    </div><!--- /.row --->

                </section><!--- /.content --->

            </div><!--- /.content-wrapper --->

            <CFINCLUDE TEMPLATE="../_includes/_footer.cfm" />

    	</div><!--- ./wrapper --->

        <CFINCLUDE TEMPLATE="../_includes/_head_js.cfm" />

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
						user_role: "Please select a quizmaster role",
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
					$('.form-control').prop('disabled', true);
					$('.form-control').css('cursor', 'not-allowed');
					$('.select2-selection--single').css('cursor', 'not-allowed');
				});
            </script>
        </CFIF>

		<CFINCLUDE TEMPLATE="../_includes/_toast.cfm" />

    </body>

</html>
