//Before Quizwait Screen
$(document).on("pagebeforeshow", "#page6", function () {
	document.getElementById("mob_user_name2").innerHTML = window.localStorage.getItem("mob_local_login_name");	
	
	//Leader board call
	var quizcode = "mob_quizcode=" . concat(window.localStorage.getItem("mob_local_quiz_code"), "&user_email=", window.localStorage.getItem("mob_local_login_email"), "&user_password=", window.localStorage.getItem("mob_local_login_password"));
	
	$.ajax({
		type: "POST",
		data: quizcode,
		url: "http://www.quizzically.co.uk/quizzically/mobile_web/php/mob_leaderboard.php",				
		success: function(data){	
			var mob_leader_data = JSON.parse(data);
			$("#mob_leaderboard1").html("<tr><th>Name</th><th>Score</th></tr>");
			$.each(mob_leader_data, function (i, item) {
				$("#mob_leaderboard1").append('<tr><td class="'.concat(item.CLASS, '">', item.NAME, '</td><td>', item.SCORE, '</td></tr>'));
			});
		}				
	});
		
	$(function checkForQuestion() {
		//sort out the data to be posted
		var postData = "mob_quizwait_quizcode=" . concat(window.localStorage.getItem("mob_local_quiz_code"), "&mob_quizwait_email=", window.localStorage.getItem("mob_local_login_email"), "&mob_quizwait_password=", window.localStorage.getItem("mob_local_login_password"), "&mob_quizwait_questionid=", window.localStorage.getItem("mob_question_id"));
		
		$.ajax({
			type: "POST",				
			data: postData,				
			url: "http://www.quizzically.co.uk/quizzically/mobile_web/php/mob_quizwait.php",			
			success: function(data){				
				var mob_quizwait_data = JSON.parse(data);
				if (mob_quizwait_data.mob_quizwait_success == "mob quizwait go") {
					document.getElementById("mob_intermission").innerHTML = "";
					window.localStorage.setItem("mob_question_id", mob_quizwait_data.mob_quizwait_questionid);
					window.localStorage.setItem("mob_question_score", mob_quizwait_data.mob_quizwait_score);
					window.localStorage.setItem("mob_question_category", mob_quizwait_data.mob_quizwait_category);
					window.localStorage.setItem("mob_question_number", mob_quizwait_data.mob_quizwait_number);
					window.localStorage.setItem("mob_question_question", mob_quizwait_data.mob_quizwait_question);
					window.localStorage.setItem("mob_answer1", mob_quizwait_data.mob_quizwait_correct);
					window.localStorage.setItem("mob_answer2", mob_quizwait_data.mob_quizwait_wrong1);
					window.localStorage.setItem("mob_answer3", mob_quizwait_data.mob_quizwait_wrong2);
					window.localStorage.setItem("mob_answer4", mob_quizwait_data.mob_quizwait_wrong3);
					window.location.href = "http://www.quizzically.co.uk/quizzically/mobile_web/mob_question.html";
				} else if (mob_quizwait_data.mob_quizwait_success == "mob quizwait stay") {
					qtimer = setTimeout(checkForQuestion, 1000);
					return false;
				} else if (mob_quizwait_data.mob_quizwait_success == "mob quizwait intermission") {
					document.getElementById("mob_intermission").innerHTML = "Intermission";
					qtimer = setTimeout(checkForQuestion, 1000);
					return false;
				} else if (mob_quizwait_data.mob_quizwait_success == "mob quizwait finished") {
					clearTimeout(qtimer);
					window.location.href = "http://www.quizzically.co.uk/quizzically/mobile_web/mob_quizfinish.html";
				} else {
					clearTimeout(qtimer);
					window.alert("Status Check Failed. Please Try Again.", function(){}, "Alert", "OK");
				}
			},
		});			
		return false;
	});	
});
