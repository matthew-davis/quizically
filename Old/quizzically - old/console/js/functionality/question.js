/*
	Matthew Davis
	Wittin Limited
	01/09/2014
*/
	
$(function() {
	window.onload = function () {
		document.getElementById("user_name").innerHTML = window.localStorage.getItem("stored_login_name");
		document.getElementById("quiz_code").innerHTML = window.localStorage.getItem("stored_quiz_code");
		
		var logout = document.getElementById("logout_link");
		logout.onclick = function () {
			window.localStorage.removeItem("stored_login_email");
			window.localStorage.removeItem("stored_login_password");
			window.localStorage.removeItem("stored_login_name");
			window.localStorage.removeItem("stored_quiz_credit");
			window.localStorage.removeItem("stored_quiz_status");
			window.localStorage.removeItem("rand_answer1");
			window.localStorage.removeItem("rand_answer2");
			window.localStorage.removeItem("rand_answer3");
			window.localStorage.removeItem("rand_answer4");
		}
		
		function randAnswer(one, two, three, four) {
			window.localStorage.removeItem("rand_answer1");
			window.localStorage.removeItem("rand_answer2");
			window.localStorage.removeItem("rand_answer3");
			window.localStorage.removeItem("rand_answer4");
			var answers = [one, two, three, four];
			var index = Math.floor(Math.random() * answers.length);
			var answer1 = answers[index];
			answers.splice(index, 1);
			index = Math.floor(Math.random() * answers.length);
			var answer2 = answers[index];
			answers.splice(index, 1);
			index = Math.floor(Math.random() * answers.length);
			var answer3 = answers[index];
			answers.splice(index, 1);
			index = Math.floor(Math.random() * answers.length);
			var answer4 = answers[index];
			answers.splice(index, 1);
			window.localStorage.setItem("rand_answer1", answer1);
			window.localStorage.setItem("rand_answer2", answer2);
			window.localStorage.setItem("rand_answer3", answer3);
			window.localStorage.setItem("rand_answer4", answer4);
			if (one == answer1) {
				window.localStorage.setItem("correct_answer", 1);
			} else if (one == answer2) {
				window.localStorage.setItem("correct_answer", 2);
			} else if (one == answer3) {
				window.localStorage.setItem("correct_answer", 3);
			} else if (one == answer4) {
				window.localStorage.setItem("correct_answer", 4);
			}
		}
		
		if (window.localStorage.getItem("stored_quiz_status") == "N") {
			document.getElementById("release_next_button").innerHTML = '<input class="btn btn-success btn-block" type="submit" value="Release Question" />';
			//document.getElementById("intermission_button").innerHTML = '<input class="btn btn-primary btn-block disabled" type="submit" value="Intermission" />';
		
			//sort out the data to be posted
			var postData = "question_type=question&question_status=N&quiz_code=" . concat(window.localStorage.getItem("stored_quiz_code"), "&question_email=", window.localStorage.getItem("stored_login_email"), "&question_password=", window.localStorage.getItem("stored_login_password"));
	
			$.ajax({
				type: "POST",				
				data: postData,
				url: "http://www.quizzically.co.uk/quizzically/console/php/question.php",				
				success: function(data){	
					var question_data = JSON.parse(data);
					if (question_data.question_success == "question success") {
						document.getElementById("question_category").innerHTML = question_data.question_category;
						document.getElementById("question_number").innerHTML = question_data.question_number;
						document.getElementById("question_text").innerHTML = question_data.question_text;
						randAnswer(question_data.question_correct, question_data.question_wrong1, question_data.question_wrong2, question_data.question_wrong3);
						document.getElementById("question_answer1").innerHTML = window.localStorage.getItem("rand_answer1");
						document.getElementById("question_answer2").innerHTML = window.localStorage.getItem("rand_answer2");
						document.getElementById("question_answer3").innerHTML = window.localStorage.getItem("rand_answer3");
						document.getElementById("question_answer4").innerHTML = window.localStorage.getItem("rand_answer4");
						
					} else if (question_data.question_success == "quiz finished") {
						window.localStorage.removeItem("stored_quiz_status")
						window.location.replace("http://www.quizzically.co.uk/quizzically/console/quizfinish.html");
					} else {
						window.alert("Quiz Failed. Please Try Again.", function(){}, "Quiz Failed", "OK");
						window.location.replace("http://www.quizzically.co.uk/quizzically/console/quizstart.html");
					}
				}				
			});

		} else if (window.localStorage.getItem("stored_quiz_status") == "R") {
			document.getElementById("release_next_button").innerHTML = '<input class="btn btn-success btn-block" type="submit" value="Next Question" />';
			//document.getElementById("intermission_button").innerHTML = '<input class="btn btn-primary btn-block" type="submit" value="Intermission" />';
			
			//sort out the data to be posted
			var postData = "question_type=release&question_status=R&quiz_code=" . concat(window.localStorage.getItem("stored_quiz_code"), "&question_email=", window.localStorage.getItem("stored_login_email"), "&question_password=", window.localStorage.getItem("stored_login_password"));
			
			$.ajax({
				type: "POST",				
				data: postData,
				url: "http://www.quizzically.co.uk/quizzically/console/php/question.php",				
				success: function(data){	
					var question_data = JSON.parse(data);
					if (question_data.question_success == "release success") {
						document.getElementById("question_category").innerHTML = question_data.question_category;
						document.getElementById("question_number").innerHTML = question_data.question_number;
						document.getElementById("question_text").innerHTML = question_data.question_text;
						document.getElementById("question_answer1").innerHTML = window.localStorage.getItem("rand_answer1");
						document.getElementById("question_answer2").innerHTML = window.localStorage.getItem("rand_answer2");
						document.getElementById("question_answer3").innerHTML = window.localStorage.getItem("rand_answer3");
						document.getElementById("question_answer4").innerHTML = window.localStorage.getItem("rand_answer4");
						
					} else {
						window.alert("Question Release Failed. Please Try Again.", function(){}, "Question Release Failed", "OK");
						window.location.replace("http://www.quizzically.co.uk/quizzically/console/quizstart.html");
					}
				}				
			});
		} else if (window.localStorage.getItem("stored_quiz_status") == "I") {
			document.getElementById("release_next_button").innerHTML = '<input class="btn btn-success btn-block" type="submit" value="Release Question" />';
			//document.getElementById("intermission_button").innerHTML = '<input class="btn btn-primary btn-block disabled" type="submit" value="Intermission" />';
			
			//sort out the data to be posted
			var postData = "question_type=intquestion&question_status=N&quiz_code=" . concat(window.localStorage.getItem("stored_quiz_code"), "&question_email=", window.localStorage.getItem("stored_login_email"), "&question_password=", window.localStorage.getItem("stored_login_password"));
			
			$.ajax({
				type: "POST",				
				data: postData,
				url: "http://www.quizzically.co.uk/quizzically/console/php/question.php",				
				success: function(data){	
					var question_data = JSON.parse(data);
					if (question_data.question_success == "intquestion success") {
						document.getElementById("question_category").innerHTML = question_data.question_category;
						document.getElementById("question_number").innerHTML = question_data.question_number;
						document.getElementById("question_text").innerHTML = question_data.question_text;
						document.getElementById("question_answer1").innerHTML = window.localStorage.getItem("rand_answer1");
						document.getElementById("question_answer2").innerHTML = window.localStorage.getItem("rand_answer2");
						document.getElementById("question_answer3").innerHTML = window.localStorage.getItem("rand_answer3");
						document.getElementById("question_answer4").innerHTML = window.localStorage.getItem("rand_answer4");
						
					} else if (question_data.question_success == "quiz finished") {
						window.localStorage.removeItem("stored_quiz_status")
						window.location.replace("http://www.quizzically.co.uk/quizzically/console/quizfinish.html");
					} else {
						window.alert("Quiz Failed. Please Try Again.", function(){}, "Quiz Failed", "OK");
						window.location.replace("http://www.quizzically.co.uk/quizzically/console/quizstart.html");
					}
				}				
			});
		} else {
			window.alert("Quiz Question Failed. Please Try Again.", function(){}, "Quiz Question Failed", "OK");
			window.location.replace("http://www.quizzically.co.uk/quizzically/console/quizstart.html");
		}
	};
	
	$("#release_next_form").submit(function(){
		needToConfirm = false;
		if (window.localStorage.getItem("stored_quiz_status") == "N") {
			window.localStorage.setItem("stored_quiz_status", "R");
			window.location.replace("http://www.quizzically.co.uk/quizzically/console/question.html");							
		} else {
			window.localStorage.setItem("stored_quiz_status", "N");
			window.location.replace("http://www.quizzically.co.uk/quizzically/console/question.html");
		}	
	});	
	
});
