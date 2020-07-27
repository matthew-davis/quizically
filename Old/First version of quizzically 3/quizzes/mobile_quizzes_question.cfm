
<!--- Authentication of user --->
<CFINCLUDE TEMPLATE="../mobile_authenticate.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  	<head>

		<CFINCLUDE TEMPLATE="../_includes/_head_internal_meta.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_internal_css.cfm" />

        <CFINCLUDE TEMPLATE="../_includes/_head_shim.cfm" />

	</head>


    <!--- Logged in user details --->
    <CFSET loginObj = CreateObject("component","quizzicallyincludes.mobile_login") />
	<CFSCRIPT>
        loginObj.dsn = dsn;
		loginObj.username = cookie.myadmin_username_mobile;
		loginObj.password = cookie.myadmin_password_mobile;
        logindetails = loginObj.getLoginDetails();
    </CFSCRIPT>

	<!--- Get question details --->
    <CFSET questionObj = CreateObject("component","quizzicallyincludes.mobile_questions") />
	<CFSCRIPT>
        questionObj.dsn = dsn;
		questionObj.question_UUID = url.question_UUID;
		questionObj.quiz_UUID = cookie.myadmin_quiz_UUID;
		questionnumberdetails = questionObj.getQuestionNumberDetails();
        questiondetails = questionObj.getQuestionDetails();
    </CFSCRIPT>


	<body class="hold-transition register-page">

        <div class="register-box">

            <div class="register-logo">

                <img src="../_img/logo.png" width="250px"/>

            </div>

            <div class="register-box-body">

				<CFOUTPUT>

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

            </div>

        </div>

        <CFINCLUDE TEMPLATE="../_includes/_head_internal_js.cfm" />

		<script type="text/javascript" language="javascript">
			$(document).ready(function() {
				$("#progressTimer").progressTimer({
					onFinish: function () {
						checkAnswer('x', 'out of time');
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
					checkAnswer(answer_UUID, answer);
				});

			});

			function checkAnswer(answer_UUID, answer) {
				$.ajax({
					type: "post",
					url: "../_cfcs/mobile_questions.cfc?method=checkAnswer&returnType=plain",
					data: {
						dsn: "<CFOUTPUT>#dsn#</CFOUTPUT>",
						quiz_UUID: "<CFOUTPUT>#cookie.myadmin_quiz_UUID#</CFOUTPUT>",
						elapsed: $('.progress-bar').attr('aria-valuenow'),
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
