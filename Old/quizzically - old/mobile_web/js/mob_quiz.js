//Before Quiz page
$(document).on("pagebeforeshow", "#page4", function () {
	document.getElementById("mob_user_name1").innerHTML = window.localStorage.getItem("mob_local_login_name");
	window.localStorage.setItem("mob_question_id", 0);
	return false;
});

//Quiz page
$(document).on("pagecreate", "#page4", function(){
	$("#mob_quiz_form").submit(function(){
	
		//sort out the data to be posted
		var postData = $(this).serialize() . concat("&mob_quiz_email=", window.localStorage.getItem("mob_local_login_email"), "&mob_quiz_password=", window.localStorage.getItem("mob_local_login_password"));
		
		$.ajax({
			type: "POST",				
			data: postData,				
			url: "http://www.quizzically.co.uk/quizzically/mobile_web/php/mob_quizcode.php",			
			success: function(data){	
				console.log(data);			
				var mob_quiz_data = JSON.parse(data);
				if (mob_quiz_data.mob_quiz_success == "mob quiz success") {
					window.localStorage.setItem("mob_local_quiz_code", mob_quiz_data.mob_quiz_code);
					window.location.href = "http://www.quizzically.co.uk/quizzically/mobile_web/mob_quizwait.html";
				} else {
					window.alert("Quiz Not Registered. Please Try Again.", function(){}, "Alert", "OK");
				}
			}
		});			
		return false;			
	});
	
	$("#mob_profile_button").submit(function() {
		window.location.href = "http://www.quizzically.co.uk/quizzically/mobile_web/mob_profile.html";
		return false;
	});
	
});