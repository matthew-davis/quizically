
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

			.box-purple {
				border-top-color: #605CA8;
			}
		</style>

        <CFINCLUDE TEMPLATE="../_includes/_head_shim.cfm" />

        <!--- Menu Bookmark Variable --->
        <CFIF #url.action# EQ 'undelete'>
        	<CFSET menupage = 'managedeletedplayers' />
       	<CFELSE>
        	<CFSET menupage = 'manageplayers' />
		</CFIF>

	</head>


	<!--- Get dropdown details --->
    <CFSET dropdownsObj = CreateObject("component","quizzicallyincludes.dropdowns") />
    <CFSCRIPT>
		dropdownsObj.dsn = dsn;
		dropdownsObj.user_role_UUID = logindetails.user_role_UUID;
		getlocations = dropdownsObj.getLocations();
	</CFSCRIPT>

	<!--- Get player details --->
	<CFSET playersObj = CreateObject("component","quizzicallyincludes.players") />
	<CFIF #url.action# EQ 'undelete'>
        <CFSCRIPT>
			playersObj.player_undelete = 'yes';
		</CFSCRIPT>
	</CFIF>
	<CFIF #url.action# NEQ 'add'>
		<CFSCRIPT>
			playersObj.dsn = dsn;
			playersObj.player_details_UUID = url.player_details_UUID;
			playersObj.logged_user = cookie.myadmin_username;
			playerdetails = playersObj.getPlayerDetails();
		</CFSCRIPT>
	</CFIF>


    <body class="hold-transition sidebar-mini skin-blue">

    	<div class="wrapper">

        	<CFINCLUDE TEMPLATE="../_includes/_header.cfm" />

            <CFINCLUDE TEMPLATE="../_includes/_menu.cfm" />

      		<div class="content-wrapper">

            	<section class="content-header">
                  	<h1>
                    	<CFOUTPUT>#UCASE(url.action)#</CFOUTPUT> Player
                  	</h1>
                    <ol class="breadcrumb">
                    	<li><a href="<CFOUTPUT>#request.baseurl#</CFOUTPUT>dashboard/dashboard.cfm"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                        <CFIF #url.action# EQ 'undelete'>
							<li><a href="<CFOUTPUT>#request.baseurl#</CFOUTPUT>players/manage_deleted_players.cfm"><i class="fa fa-users"></i> Manage Deleted Players</a></li>
                            <li class="active"><i class="fa fa-user"></i> Un-Delete Player</li>
                        <CFELSE>
							<li><a href="<CFOUTPUT>#request.baseurl#</CFOUTPUT>players/manage_players.cfm"><i class="fa fa-users"></i> Manage Players</a></li>
                            <CFIF #url.action# EQ 'add'>
                                <li class="active"><i class="fa fa-user"></i> Add Player</li>
                            <CFELSEIF #url.action# EQ 'edit'>
                                <li class="active"><i class="fa fa-user"></i> Edit Player</li>
                            <CFELSEIF #url.action# EQ 'delete'>
                                <li class="active"><i class="fa fa-user"></i> Delete Player</li>
                            </CFIF>
                        </CFIF>
                	</ol>
                </section><!--- /.content-header --->

                <section class="content">

                    <div class="row">

                        <form role="form" method="post" action="<CFOUTPUT>#request.baseurl#</CFOUTPUT>players/players_process.cfm?action=<CFOUTPUT>#url.action#</CFOUTPUT>" id="myform" name="myform" enctype="multipart/form-data">

                            <!--- Only used to circumvent the autocomplete feature of browsers --->
                            <input style="display: none;">
                            <input type="password" style="display: none;">
                            <!--- Browsers are stupid --->

                            <CFOUTPUT>
                                <input type="hidden" name="action" value="#url.action#">
                                <input type="hidden" name="player_details_UUID" value="<CFIF #url.action# NEQ 'add'>#player_details_UUID#</CFIF>">
                            </CFOUTPUT>

                            <div class="col-md-12">

                                <div class="box <CFIF (#url.action# EQ "delete") OR (#url.action# EQ "undelete")><CFOUTPUT>box-danger</CFOUTPUT><CFELSE><CFOUTPUT>box-purple</CFOUTPUT></CFIF>">

                                	<div class="box-header with-border">

                                    	<p>Fields marked with an <span class="text-red" style="font-size: 20px;">*</span> must be filled in</p>

                                    </div>

                                    <div class="box-body">

                                        <div class="row">

                                            <div class="col-md-4">

                                                <div class="form-group">
                                                    <label for="player_firstname">First Name</label> <span style="font-size: 20px;">&nbsp;</span>
                                                    <input type="text" class="form-control" name="player_firstname" id="player_firstname" placeholder="First Name" <CFIF #url.action# NEQ "add"><CFOUTPUT QUERY="playerdetails">value="#player_firstname#"</CFOUTPUT></CFIF> />
                                                </div>

                                                <div class="form-group">
                                                    <label for="player_birthday">Birthday</label> <span style="font-size: 20px;">&nbsp;</span>
                                                    <input type="text" class="form-control" name="player_birthday" id="player_birthday" placeholder="Birthday" <CFIF #url.action# NEQ "add"><CFOUTPUT QUERY="playerdetails">value="#DateFormat(player_birthday, 'dd/mm/yyyy')#"</CFOUTPUT></CFIF> />
                                                </div>

												<div class="form-group">
                                                    <label for="player_occupation">Occupation</label> <span style="font-size: 20px;">&nbsp;</span>
                                                    <input type="text" class="form-control" name="player_occupation" id="player_occupation" placeholder="Occupation" <CFIF #url.action# NEQ "add"><CFOUTPUT QUERY="playerdetails">value="#player_occupation#"</CFOUTPUT></CFIF> />
                                                </div>

                                            </div><!--- /.col --->

											<div class="col-md-4">

												<div class="form-group">
                                                    <label for="player_lastname">Last Name</label> <span style="font-size: 20px;">&nbsp;</span>
                                                    <input type="text" class="form-control" name="player_lastname" id="player_lastname" placeholder="Last Name" <CFIF #url.action# NEQ "add"><CFOUTPUT QUERY="playerdetails">value="#player_lastname#"</CFOUTPUT></CFIF> />
                                                </div>

												<div class="form-group">
                                                    <label>Gender</label> <span style="font-size: 20px;">&nbsp;</span>
                                                    <select class="form-control select2-gender" name="player_gender" id="player_gender" style="width: 100%;">
                                                    	<option value="">&nbsp;</option>
                                                        <option value="male" <CFIF action NEQ 'add'><CFIF playerdetails.player_gender EQ 'male'>selected</CFIF></CFIF>>Male</option>
                                                        <option value="female" <CFIF action NEQ 'add'><CFIF playerdetails.player_gender EQ 'female'>selected</CFIF></CFIF>>Female</option>
                                                        <option value="other" <CFIF action NEQ 'add'><CFIF playerdetails.player_gender EQ 'other'>selected</CFIF></CFIF>>Other</option>
                                                    </select>
                                                </div>

												<div class="form-group">
                                                    <label>Location</label> <span style="font-size: 20px;">&nbsp;</span>
                                                    <select class="form-control select2-location" name="player_location" id="player_location" style="width: 100%;">
                                                        <option value="" <CFIF action EQ 'add'>selected</CFIF>>&nbsp;</option>
                                                        <CFOUTPUT QUERY="getlocations">
                                                            <option value="#location_UUID#" <CFIF action NEQ 'add'><CFIF playerdetails.location_UUID EQ location_UUID>selected</CFIF></CFIF>>#location#</option>
                                                        </CFOUTPUT>
                                                    </select>
                                                </div>

											</div><!--- /.col --->

                                            <div class="col-md-4">

                                                <div class="form-group">
                                                    <label for="player_email">Email (Username)</label> <span class="text-red" style="font-size: 20px;">*</span>
                                                    <input type="email" class="form-control" name="player_email" id="player_email" placeholder="Email" <CFIF #url.action# NEQ "add"><CFOUTPUT QUERY="playerdetails">value="#player_email#"</CFOUTPUT></CFIF> />
                                                </div>

                                                <CFIF #url.action# is "add">
                                                    <div class="form-group">
                                                        <label for="player_password">Password</label> <span class="text-red" style="font-size: 20px;">*</span>
                                                        <input type="password" class="form-control" name="player_password" placeholder="Password" />
                                                    </div>
                                                <CFELSE>
                                                    <div class="form-group">
                                                        <label for="player_newpassword">CHANGE Password</label> <span style="font-size: 20px;">&nbsp;</span>
                                                        <input type="password" class="form-control" name="player_newpassword" id="player_newpassword" placeholder="New Password" />
                                                    </div>
                                                </CFIF>

                                            </div><!--- /.col --->

                                        </div><!--- /.row --->

                                    </div><!--- /.box-body --->

                                    <div class="box-footer">
                                    	<CFIF #url.action# EQ 'undelete'>
                                        	<button type="submit" class="btn btn-danger">Un-Delete Player</button>
                                        <CFELSE>
                                        	<button type="submit" class="btn <CFIF #url.action# NEQ "delete"><CFOUTPUT>bg-purple</CFOUTPUT><CFELSE><CFOUTPUT>btn-danger</CFOUTPUT></CFIF>"><CFIF #url.action# NEQ "delete"><CFOUTPUT>SAVE Player Details</CFOUTPUT><CFELSE><CFOUTPUT>DELETE Player</CFOUTPUT></CFIF></button>
                                    	</CFIF>
                                    </div><!--- /.box-footer --->

                             	</div><!--- /.box --->

                            </div><!--- /.col --->

                         </form>

                    </div><!--- /.row --->

                </section><!--- /.content --->

            </div><!--- /.content -wrapper --->

            <CFINCLUDE TEMPLATE="../_includes/_footer.cfm" />

    	</div><!--- ./wrapper --->

        <CFINCLUDE TEMPLATE="../_includes/_head_js.cfm" />

        <script type="text/javascript" language="javascript">
			$(document).ready(function() {
				$("#myform").validate({
					rules: {
						player_email: {
							required: true,
							email: true
						},
						player_password: "required"
					},
					messages: {
						player_email: "Please enter a valid email address",
						player_password: "Please enter a password"
					}
				});


				$(".select2-gender").select2( {
					minimumResultsForSearch: Infinity,
					placeholder: "Select a gender..."
				});

				$(".select2-location").select2( {
					placeholder: "Select a location..."
				});

				$('#player_birthday').datepicker({
					format: 'dd/mm/yyyy'
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
