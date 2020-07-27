/*
	Matthew Davis
	Wittin Limited
	01/09/2014
*/

$(function () {
	window.onload = function() {
		document.getElementById("user_name").innerHTML = window.localStorage.getItem("stored_login_name");
		document.getElementById("quiz_code").innerHTML = window.localStorage.getItem("stored_quiz_code");
		
		var logout = document.getElementById("logout_link");
		logout.onclick = function () {
			window.localStorage.removeItem("stored_login_email");
			window.localStorage.removeItem("stored_login_password");
			window.localStorage.removeItem("stored_login_name");
			window.localStorage.removeItem("stored_quiz_credit");
		}
		
		$(function checkForLeader() {
			$("td").remove();
			quizcode = "quiz_code=" . concat(window.localStorage.getItem("stored_quiz_code"));			
			$.ajax({
				type: "POST",
				data: quizcode,
				url: "http://www.quizzically.co.uk/quizzically/console/php/leaderboard.php",				
				success: function(data){
					$('#leader_board').empty();	
					$('#leader_board').append('<tr><th style="width: 60%">Name&nbsp;&nbsp;</th><th style="width: 40%">Score&nbsp;&nbsp;</th></tr>');	
					var leader_data = JSON.parse(data);
					$.each(leader_data, function (i, item) {
						$('#leader_board').append('<tr><td style="padding: 0px 10px 10px 0px; vertical-align: top;" class="'.concat(item.ANSWERED, ' ', item.CLASS, '">', item.NAME, '<td style="padding: 0px 10px 10px 0px; vertical-align: top;">', item.SCORE, '</tr>'));
					});
					lTimer = setTimeout(checkForLeader, 5000);
				}				
			});
			return false;
		});
	};
});

$(function () {
	$("#quizstart_form").submit(function(){
		clearTimeout(lTimer);
		window.location.replace("http://www.quizzically.co.uk/quizzically/console/question.html");
		return false;
	});
});