
<!--- Authentication of user --->
<CFINCLUDE TEMPLATE="../mobile_authenticate.cfm">

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

	</head>


	<!--- Get dropdowns --->
    <CFSET dropdownsObj = CreateObject("component","quizzicallyincludes.dropdowns") />
    <CFSCRIPT>
		dropdownsObj.dsn = dsn;
		getlocations = dropdownsObj.getLocations();
	</CFSCRIPT>

	<!--- Get player details --->
    <CFSET playerObj = CreateObject("component","quizzicallyincludes.players") />
	<CFSCRIPT>
        playerObj.dsn = dsn;
        playerObj.player_details_UUID = loginplayer.player_details_UUID;
        getplayer = playerObj.getPlayerDetails();
    </CFSCRIPT>

	<!--- Quotes --->
    <CFSET quotesObj = CreateObject("component","quizzicallyincludes.quotes") />
	<CFSCRIPT>
        quotesObj.dsn = dsn;
        quotedetails= quotesObj.getQuote();
    </CFSCRIPT>


  	<body class="hold-transition login-page">

        <div class="login-box">

          	<div class="login-logo">

                <img src="<CFOUTPUT>#request.baseurl#</CFOUTPUT>_img/logo.png" width="300px" />

            </div><!--- /.login-logo --->

            <div class="login-box-body">

				<CFOUTPUT QUERY="quotedetails">
					<p class="register-box-msg">"#quote#" --#quote_person#</p>
				</CFOUTPUT>

				<br />

                <form action="<CFOUTPUT>#request.baseurl#</CFOUTPUT>quizzes/mobile_quizzes_login.cfm" method="post">

					<CFOUTPUT>
						<input type="hidden" name="player_details_UUID" id="player_details_UUID" value="#loginplayer.player_details_UUID#" />
					</CFOUTPUT>

                    <div class="form-group has-feedback">
                        <input type="text" name="player_firstname" class="form-control" placeholder="First Name" <CFIF IsDefined('getplayer.player_firstname')>value="<CFOUTPUT>#getplayer.player_firstname#</CFOUTPUT>"<CFELSE>value=""</CFIF> />
                        <span class="glyphicon glyphicon-user form-control-feedback"></span>
                    </div>

					<div class="form-group has-feedback">
                        <input type="text" name="player_lastname" class="form-control" placeholder="Last Name" <CFIF IsDefined('getplayer.player_lastname')>value="<CFOUTPUT>#getplayer.player_lastname#</CFOUTPUT>"<CFELSE>value=""</CFIF> />
                        <span class="glyphicon glyphicon-user form-control-feedback"></span>
                    </div>

					<div class="form-group">
                        <select class="form-control select2-location" name="player_location" id="uplayer_location" style="width: 100%;">
                            <option value="">&nbsp;</option>
                            <CFOUTPUT QUERY="getlocations">
                                <option value="#location_UUID#" <CFIF getplayer.location_UUID EQ location_UUID>selected</CFIF>>#location#</option>
                            </CFOUTPUT>
                        </select>
                    </div>

					<div class="form-group">
                        <select class="form-control select2-gender" name="player_gender" id="user_location" style="width: 100%;">
                            <option value="">&nbsp;</option>
                            <option value="male" <CFIF getplayer.player_gender EQ 'male'>selected</CFIF>>Male</option>
							<option value="female" <CFIF getplayer.player_gender EQ 'female'>selected</CFIF>>Female</option>
                        </select>
                    </div>

					<div class="form-group has-feedback">
                        <input type="text" name="player_occupation" class="form-control" placeholder="Occupation" <CFIF IsDefined('getplayer.player_occupation')>value="<CFOUTPUT>#getplayer.player_occupation#</CFOUTPUT>"<CFELSE>value=""</CFIF> />
                        <span class="glyphicon glyphicon-briefcase form-control-feedback"></span>
                    </div>

					<div class="form-group has-feedback">
                        <input type="text" name="player_birthday" class="form-control datepicker" placeholder="Birthday" <CFIF IsDefined('getplayer.player_birthday')>value="<CFOUTPUT>#DateFormat(getplayer.player_birthday, 'dd/mm/yyyy')#</CFOUTPUT>"<CFELSE>value=""</CFIF> />
                        <span class="glyphicon glyphicon-gift form-control-feedback"></span>
                    </div>

                    <div class="row">
                        <div class="col-xs-8">

                        </div><!--- /.col --->
                        <div class="col-xs-4">
                            <button type="submit" class="btn btn-primary btn-block btn-flat">Update</button>
                        </div><!--- /.col --->
                    </div>

                </form>

                <br />

				<!--- Link back to quiz login screen --->
        		<a href="<CFOUTPUT>#request.baseurl#</CFOUTPUT>quizzes/mobile_quizzes_login.cfm" class="text-center">Nothing to change</a>

      		</div><!--- /.form-box --->

    	</div><!--- /.login-box --->

        <CFINCLUDE TEMPLATE="../_includes/_head_js.cfm" />

		<script type="text/javascript" language="javascript">
            $(document).ready(function () {
            	$("#myform").validate({
					rules: {
						player_firstname: "required"
					},
					messages: {
						player_firstname: "A firstname is required"
					},
					errorPlacement: function(error, element) {
						error.insertAfter(element.parent().find('span'));
					},
					highlight: function(element) {
						$(element).closest('.form-group').find('input').removeClass('success').addClass('error');
						$(element).closest('.form-group').find('span').removeClass('success').addClass('error');
						$(element).closest('.form-group').find('label').removeClass('success').addClass('error');
					},
					success: function(element) {
    					$(element).closest('.form-group').find('input').removeClass('error').addClass('success');
    					$(element).closest('.form-group').find('span').removeClass('error').addClass('success');
    					$(element).closest('.form-group').find('label').removeClass('error').addClass('success');
  					},
  					onkeyup: false
				});

                $(".select2-location").select2( {
					placeholder: "Select a location..."
				});

				$(".select2-gender").select2( {
					placeholder: "Select a gender..."
				});

				$(".datepicker").datepicker({
					format: 'dd/mm/yyyy'
				});
            });
        </script>

		<CFINCLUDE TEMPLATE="../_includes/_toast.cfm" />

  	</body>

</html>
