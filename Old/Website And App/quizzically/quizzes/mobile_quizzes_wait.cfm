
<!--- Authentication of user --->
<CFINCLUDE TEMPLATE="../mobile_authenticate.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

		<CFINCLUDE TEMPLATE="../_includes/_head_meta.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_css.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_shim.cfm" />

	</head>


	<body class="hold-transition login-page">

        <div class="login-box">

          	<div class="login-logo">

                <img src="<CFOUTPUT>#request.baseurl#</CFOUTPUT>_img/logo.png" width="300px" />

            </div><!--- /.login-logo --->

            <div class="login-box-body">

				<br />

				<CFIF #IsDefined('url.round')#>

					<div class="row">

						<div class="col-md-12 text-center">

							<strong><span style="font-size: 20px;">Round Complete</span></strong>
							<br /><br />

						</div><!--- /.col --->

					</div><!--- /.row --->

				<CFELSE>

					<div class="row">

						<div class="col-md-12 text-center">

							Waiting for a question.
							<br /><br /><br />

						</div><!--- /.col --->

					</div><!--- /.row --->

					<CFIF #IsDefined('url.correct')#>

						<div class="row">

							<div class="col-md-12 text-center">

								<CFIF #url.correct# EQ 1>
									<strong><span class="text-green" style="font-size: 20px;">Correct</span></strong>
								<CFELSE>
									<strong><span class="text-red" style="font-size: 20px;">Incorrect</span></strong>
								</CFIF>

								<br /><br />

							</div><!--- /.col --->

						</div><!--- /.row --->

						<div class="row">

							<div class="col-md-12 text-center">

								<strong><span style="font-size: 20px;"><CFOUTPUT>Score: #url.score#</CFOUTPUT></span></strong>

							</div><!--- /.col --->

						</div><!--- /.row --->

					<CFELSE>

						<div class="row">

							<div class="col-md-12 text-center">

								You should enjoy a cool draft beer while you wait!
								<br /><br />
								Sorry for the advertising.
								<br />
								Tip the staff!

							</div><!--- /.col --->

						</div><!--- /.row --->

					</CFIF>

				</CFIF>

            </div><!--- /.login-box-body --->

        </div><!--- /.login-box --->

        <CFINCLUDE TEMPLATE="../_includes/_head_js.cfm" />

		<script type="text/javascript" language="javascript">
			$(document).ready(function() {
				var question = setInterval(function () {
    				$.ajax({
						type: "post",
						url: "../_cfcs/mobile_questions.cfc?method=getQuestion&returnformat=plain",
						data: {
							dsn: "<CFOUTPUT>#dsn#</CFOUTPUT>",
							quiz_UUID: "<CFOUTPUT>#cookie.myadmin_quiz_UUID#</CFOUTPUT>",
							username_hash: "<CFOUTPUT>#cookie.myadmin_username_mobile#</CFOUTPUT>"
						},
						dataType: 'text',
						success: function(result) {
							if (result.trim() == 'x') {
								return false;
							} else if (result.trim() == 'roundcomplete') {
								clearInterval(question);
								window.location = "./mobile_quizzes_wait.cfm?round=over";
							} else if (result.trim() == 'quizcomplete') {
								clearInterval(question);
								window.location = "./mobile_quizzes_login.cfm?quiz=over";
							} else {
								clearInterval(question);
								window.location = "./mobile_quizzes_question.cfm?question_UUID=".concat(result.trim());
							}
						}
					});
				}, 3000 );
			});
		</script>

	</body>

</html>
