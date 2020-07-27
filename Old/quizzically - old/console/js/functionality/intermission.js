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
		}

		//Leader board call
		quizcode = "quiz_code=" . concat(window.localStorage.getItem("stored_quiz_code"));
		$.ajax({
			type: "POST",
			data: quizcode,
			url: "http://www.quizzically.co.uk/quizzically/console/php/leaderboard.php",				
			success: function(data){	
				var leader_data = JSON.parse(data);
				$.each(leader_data, function (i, item) {
					$('<tr>').append($('<td style="padding: 0px 10px 10px 0px; vertical-align: top;">').text(item.NAME),$('<td style="padding: 0px 10px 10px 0px; vertical-align: top;">').text(item.SCORE)).appendTo('#leader_board');
				});
			}				
		});
		
		//Set quiz status to intermission
		status = "quiz_status=I&quiz_code=" . concat(window.localStorage.getItem("stored_quiz_code"));
		$.ajax({
			type: "POST",
			data: status,
			url: "http://www.quizzically.co.uk/quizzically/console/php/intermission.php",
			success: function() {
				window.localStorage.setItem("stored_quiz_status", "I");
			}
		});

	};
});


