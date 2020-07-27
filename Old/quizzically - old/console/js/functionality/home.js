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
		
		//Last quizzes call
		quizcode = "home_email=" . concat(window.localStorage.getItem("stored_login_email"));
		$.ajax({
			type: "POST",
			data: quizcode,
			url: "http://www.quizzically.co.uk/quizzically/console/php/home.php",				
			success: function(data){	
				var last_quizzes_data = JSON.parse(data);
				$.each(last_quizzes_data, function (i, item) {
					$('<tr>').append($('<td>').text(item.DATE), $('<td>').text(item.WINNER)).appendTo('#last_quizzes');
				});
			}				
		});	
	};
});
