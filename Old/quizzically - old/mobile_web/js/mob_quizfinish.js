//Before Quizfinish Page
$(document).on("pagebeforeshow", "#page8", function () {
	document.getElementById("mob_user_name4").innerHTML = window.localStorage.getItem("mob_local_login_name");
	return false;
});

//Quizfinish Page
$(document).on("pagecreate", "#page8", function(){	
	$("#mob_quiz_button").submit(function() {
		window.location.href = "http://www.quizzically.co.uk/quizzically/mobile_web/mob_quiz.html";
		return false;
	});
});