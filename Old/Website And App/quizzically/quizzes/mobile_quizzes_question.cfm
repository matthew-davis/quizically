
<!--- Authentication of user --->
<CFINCLUDE TEMPLATE="../mobile_authenticate.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

		<CFINCLUDE TEMPLATE="../_includes/_head_meta.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_css.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_shim.cfm" />

	</head>


	<!--- Get question details --->
    <CFSET questionObj = CreateObject("component","quizzicallyincludes.mobile_questions") />
	<CFSCRIPT>
        questionObj.dsn = dsn;
        questionObj.username_hash = cookie.myadmin_username_mobile;
		questionObj.question_UUID = url.question_UUID;
		questionObj.quiz_UUID = cookie.myadmin_quiz_UUID;
		questionnumberdetails = questionObj.getQuestionNumberDetails();
        questiondetails = questionObj.getQuestionDetails();
    </CFSCRIPT>


	<body class="hold-transition login-page">

        <div class="login-box">

          	<div class="login-logo">

                <img src="<CFOUTPUT>#request.baseurl#</CFOUTPUT>_img/logo.png" width="300px" />

            </div><!--- /.login-logo --->

            <div class="login-box-body">

				<CFIF #IsDefined('questiondetails.interaction_answer')#>

					<CFLOCATION URL="./mobile_quizzes_wait.cfm" />

				<CFELSE>

					<CFOUTPUT>

						<br />

						R: #questionnumberdetails.round_number# Q: #questionnumberdetails.question_number# <span class="pull-right" style="font-weight: bold;">#questiondetails.category#</span><br>

						<br>

						<div id="progressTimer"></div>

	                    #questiondetails.question#<br>

						<br>

						<button id="answer_1" class="btn btn-block btn-flat btn-primary answerbutton"></button><br />
	                    <button id="answer_2" class="btn btn-block btn-flat btn-primary answerbutton"></button><br />
	                    <button id="answer_3" class="btn btn-block btn-flat btn-primary answerbutton"></button><br />
	                    <button id="answer_4" class="btn btn-block btn-flat btn-primary answerbutton"></button><br />

					</CFOUTPUT>

				</CFIF>

            </div><!--- /.login-box-body --->

        </div><!--- /.login-box --->

        <CFINCLUDE TEMPLATE="../_includes/_head_js.cfm" />

		<script type="text/javascript" language="javascript">
			$(document).ready(function() {
				$("#progressTimer").progressTimer({
					onFinish: function () {
						checkAnswer('x', 'out of time', $('.progress-bar').attr('aria-valuenow'));
					}
				});

				var arr_answer = [];
				arr_answer.push("<CFOUTPUT QUERY="questiondetails"><span id='#answer1_UUID#'>#answer_correct#</span></CFOUTPUT>");
				arr_answer.push("<CFOUTPUT QUERY="questiondetails"><span id='#answer2_UUID#'>#answer_wrong_1#</span></CFOUTPUT>");
				arr_answer.push("<CFOUTPUT QUERY="questiondetails"><span id='#answer3_UUID#'>#answer_wrong_2#</span></CFOUTPUT>");
				arr_answer.push("<CFOUTPUT QUERY="questiondetails"><span id='#answer4_UUID#'>#answer_wrong_3#</span></CFOUTPUT>");
				var count_answer = 1;
				while (arr_answer.length) {
					var rand_answer = arr_answer.splice( Math.floor( Math.random() * arr_answer.length ), 1 )[0];
					$('#answer_'.concat(count_answer)).html(rand_answer);
					count_answer += 1;
				}

				$(document).on('click', '.answerbutton', function() {
					var answer_UUID = $(this).find('span').attr('id');
					var answer = $(this).find('span').html();
					var elapsed = $('.progress-bar').attr('aria-valuenow');
					checkAnswer(answer_UUID, answer, elapsed);
				});

			});

			function checkAnswer(answer_UUID, answer, elapsed) {

				$("#progressTimer").progressTimer({
					stopTimer: "True"
				});

				$.ajax({
					type: "post",
					url: "../_cfcs/mobile_questions.cfc?method=checkAnswer&returnType=plain",
					data: {
						dsn: "<CFOUTPUT>#dsn#</CFOUTPUT>",
						quiz_UUID: "<CFOUTPUT>#cookie.myadmin_quiz_UUID#</CFOUTPUT>",
						elapsed: elapsed,
						question_UUID: "<CFOUTPUT>#url.question_UUID#</CFOUTPUT>",
						answer_UUID: answer_UUID,
						answer: answer,
						username_hash: "<CFOUTPUT>#cookie.myadmin_username_mobile#</CFOUTPUT>"
					},
					dataType: 'text',
					success: function(result) {
						var url = "./mobile_quizzes_wait.cfm?".concat(result.trim());
						window.location = url;
					}
				});
			}
		</script>

	</body>

</html>
