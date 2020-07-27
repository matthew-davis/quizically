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
		
		$(function checkForLeader() {
			$(".leaderboard-data").remove();
			quizcode = "quiz_code=" . concat(window.localStorage.getItem("stored_quiz_code"));
			$.ajax({
				type: "POST",
				data: quizcode,
				url: "http://www.quizzically.co.uk/quizzically/console/php/leaderboard.php",				
				success: function(data){	
					var leader_data = JSON.parse(data);
					$.each(leader_data, function (i, item) {
						$('<tr>').append($('<td style="padding: 0px 10px 10px 0px; vertical-align: top;" class="leaderboard-data">').text(item.NAME), $('<td style="padding: 0px 10px 10px 0px; vertical-align: top;" class="leaderboard-data">').text(item.SCORE)).appendTo('#leader_board');
					});
					lTimer = setTimeout(checkForLeader, 5000);
				}				
			});
			return false;
		});
		
		quizcode = "quiz_code=" . concat(window.localStorage.getItem("stored_quiz_code"));
		$.ajax({
			type: "POST",
			data: quizcode,
			url: "http://www.quizzically.co.uk/quizzically/console/php/quizfinish.php",				
			success: function(data){	
				var correct_data = JSON.parse(data);
				$.each(correct_data, function (i, item) {
					$('<tr>').append($('<td style="padding: 0px 10px 10px 0px; vertical-align: top;">').text(item.QUESTION), $('<td style="padding: 0px 0px 10px 0px; vertical-align: top;">').text(item.CORRECT_ANSWER)).appendTo('#correct_questions');
				});
			}				
		});	
	};
});