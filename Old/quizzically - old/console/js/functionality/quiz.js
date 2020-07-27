/*
	Matthew Davis
	Wittin Limited
	01/09/2014
*/

$(function () {
	window.onload = function() {
		document.getElementById("user_name").innerHTML = window.localStorage.getItem("stored_login_name");
		document.getElementById("quizzes_left").innerHTML = window.localStorage.getItem("stored_quiz_credit");
		
		var logout = document.getElementById("logout_link");
		logout.onclick = function () {
			window.localStorage.removeItem("stored_login_email");
			window.localStorage.removeItem("stored_login_password");
			window.localStorage.removeItem("stored_login_name");
			window.localStorage.removeItem("stored_quiz_credit");
		}
	};
});

$(function () {
	$("#quiz_form").submit(function(){
	
		//check number of questions
		var x = document.forms["quiz_form"]["quiz_questions"].value;
		if (x < 1 || x == null || x == "") { 
			window.alert("You need at least 1 question.", function(){}, "Questions Failed", "OK");
			return false;			
		} else if (x > 100) {
			window.alert("You can't have more than 100 questions.", function(){}, "Questions Failed", "OK");
			return false;
		}
		
		//check difficulty rating
		var y = document.forms["quiz_form"]["quiz_difficulty"].value;
		if (y < 1 || y == null || y == "") { 
			window.alert("You need a difficulty of at least 1.", function(){}, "Difficulty Failed", "OK");
			return false;			
		} else if (y > 5) {
			window.alert("Difficulty can not be higher than 5.", function(){}, "Difficulty Failed", "OK");
			return false;
		}

		//sort out the data to be posted
		var postData = $(this).serialize() . concat("&quiz_email=", window.localStorage.getItem("stored_login_email"), "&quiz_password=", window.localStorage.getItem("stored_login_password"));
		
		$.ajax({
			type: "POST",				
			data: postData,				
			url: "http://www.quizzically.co.uk/quizzically/console/php/quiz.php",			
			success: function(data){				
				var quiz_data = JSON.parse(data);
				if (quiz_data.quiz_success == "quiz success") {
					window.localStorage.setItem("stored_quiz_code", quiz_data.quiz_code);
					window.localStorage.setItem("stored_quiz_status", "N");
					window.localStorage.setItem("stored_quiz_credit", quiz_data.quiz_credit);
					window.location.replace("http://www.quizzically.co.uk/quizzically/console/quizstart.html");
				} else if (quiz_data.quiz_success == "no credit") {
					window.alert("You need to purchase quizzes to build a quiz.", function(){}, "No Credit", "OK");
					window.location.replace("http://www.quizzically.co.uk/quizzically/console/purchase.html");
				} else {
					window.alert("Quiz Registration Failed. Please Try Again.", function(){}, "Quiz Registration Failed", "OK");
				}
			}				
		});			
		return false;			
	});		
});