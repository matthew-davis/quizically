
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

			.nav-tabs-custom > .nav-tabs > li.active {
   				border-top-color: #00C0EF;
			}

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
        <CFSET menupage = 'x' />

	</head>


	<!--- Get dropdowns --->
    <CFSET dropdownsObj = CreateObject("component","quizzicallyincludes.dropdowns") />
    <CFSCRIPT>
		dropdownsObj.dsn = dsn;
		getlocations = dropdownsObj.getLocations();
	</CFSCRIPT>

	<!--- Get quizmaster info --->
    <CFSET quizmastersObj = CreateObject("component","quizzicallyincludes.quizmasters") />
    <CFSCRIPT>
		quizmastersObj.dsn = dsn;
		quizmastersObj.logged_user = cookie.myadmin_username;
		quizmastersObj.user_details_UUID = logindetails.user_details_UUID;
        quizmasterdetails = quizmastersObj.getQuizmasterDetails();
	</CFSCRIPT>

    <!--- Get quiz details --->
	<CFSET quizzesObj = CreateObject("component","quizzicallyincludes.quizzes") />
	<CFSCRIPT>
        quizzesObj.dsn = dsn;
        if (logindetails.user_role_UUID != 'a88aaf23-0d3f-11e5-a315-38b1dbe2bc0e') {
        	quizzesObj.username_hash = logindetails.username_hash;
        }
        quizdetails = quizzesObj.getQuizDetails();
    </CFSCRIPT>


    <body class="hold-transition sidebar-mini skin-blue">

    	<div class="wrapper">

        	<CFINCLUDE TEMPLATE="../_includes/_header.cfm" />

            <CFINCLUDE TEMPLATE="../_includes/_menu.cfm" />

            <!--- Content Wrapper. Contains page content --->
      		<div class="content-wrapper">

            	<section class="content-header">
                  	<h1>
                    	Quizmaster Profile
                  	</h1>
                    <ol class="breadcrumb">
                    	<li><a href="<CFOUTPUT>#request.baseurl#</CFOUTPUT>dashboard/dashboard.cfm"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                        <li class="active"><i class="fa fa-user"></i> Quizmaster Profile</li>
                	</ol>
                </section>

                <section class="content">

          			<div class="row">

            			<div class="col-md-3">

							<!--- Basic Profile Stats --->
              				<div class="box box-info">

                				<div class="box-body">

                                	<!--- Insert logged in quizmaster avatar or default to generic avatar --->
									<CFIF #logindetails.uploadfile1# NEQ ''>
                                        <CFOUTPUT QUERY = 'logindetails'>
                                            <img src="../_img/avatars/#user_details_UUID#/#uploadfile1#" class="profile-user-img img-responsive img-circle" alt="Quizmaster Image" />
                                        </CFOUTPUT>
                                    <CFELSE>
                                        <img src="../_img/generic_avatar.png" class="profile-user-img img-responsive img-circle" alt="Quizmaster Image" />
                                    </CFIF>

                  					<h3 class="profile-username text-center"><CFOUTPUT QUERY="logindetails"><CFIF #IsDefined('logindetails.user_firstname')#>#user_firstname# #user_lastname#<CFELSE>#email_name#</CFIF></CFOUTPUT></h3>

                  					<p class="text-muted text-center"><CFOUTPUT>#logindetails.user_role#</CFOUTPUT></p>

                  					<ul class="list-group list-group-unbordered">
                    					<li class="list-group-item">
                      						<b>Quiz Credits</b> <span class="label label-success pull-right"><CFOUTPUT>#logindetails.credits#</CFOUTPUT></span>
                    					</li>
                    					<li class="list-group-item">
                      						<b>Ongoing Quizzes</b> <span class="label label-warning pull-right"><CFOUTPUT>#menunumbers.ongoing_number#</CFOUTPUT></span>
                    					</li>
                    					<li class="list-group-item">
                      						<b>Historic Quizzes</b> <span class="label label-danger pull-right"><CFOUTPUT>#menunumbers.historic_number#</CFOUTPUT></span>
                    					</li>
                                        <li class="list-group-item">
                      						<b>Total Quizzes</b> <span class="label label-primary pull-right"><CFOUTPUT>#menunumbers.ongoing_number + menunumbers.historic_number#</CFOUTPUT></span>
                    					</li>
                  					</ul>

                				</div><!--- /.box-body --->

              				</div><!--- /.box --->

            			</div><!--- /.col --->

						<!--- Quizmaster details --->
            			<div class="col-md-9">

              				<div class="nav-tabs-custom">

                				<ul class="nav nav-tabs">
                  					<li class="active"><a href="#quizzes" data-toggle="tab">Quizzes</a></li>
                  					<li><a href="#account" data-toggle="tab">Update Profile</a></li>
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
                                                <CFOUTPUT QUERY="quizdetails">
                                                    <tr id="#quiz_UUID#">
                                                        <td><span style="display: none;">#quiz_created#</span>#DateFormat(quiz_created, 'dd/mm/yyyy')#</td>
                                                        <td>#quiz_code#</td>
                                                        <td>#quiz_rounds#</td>
                                                        <td>#quiz_questions#</td>
                                                        <td>#location#</td>
                                                        <td>
                                                            <CFIF #quiz_status# EQ 'ongoing'>
																<a href="#request.baseurl#/quizzes/quizzes_question.cfm?quiz_UUID=#quiz_UUID#" class="btn btn-xs btn-success">Continue Quiz</a>
                                                                &nbsp;
                                                                <button class="btn btn-xs btn-danger cancelbutton">Cancel Quiz</button>
                                                            <CFELSEIF #quiz_status# EQ 'historic'>
																<a href="#request.baseurl#/quizzes/quizzes_quiz_finish.cfm?origin=historic&myadmin_quiz_UUID=#quiz_UUID#" class="btn btn-xs btn-info">Quiz Details</a>
                                                            </CFIF>
                                                        </td>
                                                    </tr>
                                                </CFOUTPUT>
                                            </tbody>
                                        </table>

                  					</div><!--- /.tab-pane --->

                  					<div class="tab-pane" id="account">

                                    	<div class="row">

                                            <form role="form" method="post" action="<CFOUTPUT>#request.baseurl#</CFOUTPUT>/profile/profile_process.cfm" name="myform" id="myform" enctype="multipart/form-data">

                                                <!--- Only used to circumvent the autocomplete feature of browsers --->
                                                <input style="display: none;">
                                                <input type="password" style="display: none;">
                                                <!--- Browsers are stupid --->

                                                <CFOUTPUT>
                                                	<input type="hidden" name="user_UUID" value="#logindetails.user_UUID#">
                                                    <input type="hidden" name="user_details_UUID" value="#logindetails.user_details_UUID#">
                                                </CFOUTPUT>

                                                <div class="col-md-8">

                                                	<p style="font-size: 18px;"><strong>Account:</strong> <CFOUTPUT>#quizmasterdetails.user_email#</CFOUTPUT></p>

                                                	<div class="row">

                                                        <div class="col-md-6">

                                                            <div class="form-group">
                                                                <label for="user_firstname">First Name</label> <span style="font-size: 20px;">&nbsp;</span>
                                                                <input type="text" class="form-control" name="user_firstname" id="user_firstname" placeholder="First Name" <CFOUTPUT QUERY="quizmasterdetails">value="#user_firstname#"</CFOUTPUT> />
                                                            </div>

                                                            <div class="form-group">
                                                                <label for="user_organisation">Organisation</label> <span style="font-size: 20px;">&nbsp;</span>
                                                                <input type="text" class="form-control" name="user_organisation" id="user_organisation" placeholder="Organisation"<CFOUTPUT QUERY="quizmasterdetails">value="#user_organisation#"</CFOUTPUT> />
                                                            </div>

                                                            <div class="form-group">
                                                                <label for="user_phone">Phone</label> <span style="font-size: 20px;">&nbsp;</span>
                                                                <input type="text" class="form-control" name="user_phone" id="user_phone" placeholder="Phone" <CFOUTPUT QUERY="quizmasterdetails">value="#user_phone#"</CFOUTPUT> />
                                                            </div>

                                                            <div class="form-group">
                                                                <label>Location</label> <span style="font-size: 20px;">&nbsp;</span>
                                                                <select class="form-control select2-location" name="user_location" id="user_location" style="width: 100%;">
                                                                    <option value="">&nbsp;</option>
                                                                    <CFOUTPUT QUERY="getlocations">
                                                                        <option value="#location_UUID#" <CFIF quizmasterdetails.location_UUID EQ location_UUID>selected</CFIF>>#location#</option>
                                                                    </CFOUTPUT>
                                                                </select>
                                                            </div>

                                                        </div>

                                                        <div class="col-md-6">

                                                           <div class="form-group">
                                                                <label for="user_lastname">Last Name</label> <span style="font-size: 20px;">&nbsp;</span>
                                                                <input type="text" class="form-control" name="user_lastname" id="user_lastname" placeholder="Last Name" <CFOUTPUT QUERY="quizmasterdetails">value="#user_lastname#"</CFOUTPUT> />
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

                                                </div><!--- /.col --->

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

                                                    <CFIF #quizmasterdetails.uploadfile1# NEQ ''>

                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div>
                                                                    <CFOUTPUT>
                                                                        <img src="../_img/avatars/#logindetails.user_details_UUID#/#quizmasterdetails.uploadfile1#" style="border: 1px solid ##ccc; display: block; margin: auto;" />
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
                                                                        <input type="text" class="form-control" id="currentimage1" name="currentimage1" <CFOUTPUT>value="#quizmasterdetails.uploadfile1#"</CFOUTPUT> />
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

											<div class="box-footer">
                                        		<button type="submit" class="btn btn-info">UPDATE Profile</button>
                                    		</div>

                                        </div><!--- /.row --->

                                    </div><!--- /.tab-pane --->

                                </div><!--- /.nav-tabs-custom --->

                            </form>

            			</div><!--- /.col --->

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

				$(".select2-location").select2( {
					placeholder: "Select a location..."
				});

				$(document).on('click', '.cancelbutton', function(event) {
					event.preventDefault();
					var quiz_UUID = $(this).parent().parent().attr('id');
					$.ajax({
						url: "../_cfcs/quizzes.cfc?method=cancelQuiz",
						data: {
							dsn: "<CFOUTPUT>#dsn#</CFOUTPUT>",
							quiz_UUID: quiz_UUID,
							logged_user: "<CFOUTPUT>#cookie.myadmin_username#</CFOUTPUT>"
						},
						dataType: 'text',
						success: function(result) {
							$('#quiz_number').html( parseInt($('#quiz_number').text()) - 1 );
							$('#'.concat(quiz_UUID)).remove();
						}
					});
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

		<CFINCLUDE TEMPLATE="../_includes/_toast.cfm" />

    </body>

</html>
