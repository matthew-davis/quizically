
var ptimer = 0, perc = 0, timeTotal = 6000, timeCount = 1;

function updateProgress(percentage) {
	var x = 100 - (percentage/timeTotal*100);
	$('#pbar_innerdiv').css("width", x + "%");
}

function animateUpdate() {
	if(perc < timeTotal) {
		perc++;
		updateProgress(perc);
		ptimer = setTimeout(animateUpdate, timeCount);
	} else {
		clearTimeout(ptimer);
		window.localStorage.setItem("mob_score", 0);
		var postData = "mob_checkanswer=N0ne&mob_checkanswer_email=" . concat(window.localStorage.getItem("mob_local_login_email"), "&mob_checkanswer_password=", window.localStorage.getItem("mob_local_login_password"), "&mob_checkanswer_quizcode=", window.localStorage.getItem("mob_local_quiz_code"), "&mob_checkanswer_questionid=", window.localStorage.getItem("mob_question_id"), "&mob_checkanswer_score=", window.localStorage.getItem("mob_score"));
				
		$.ajax({
			type: "POST",				
			data: postData,				
			url: "http://www.quizzically.co.uk/quizzically/mobile_web/php/mob_checkanswer.php",			
			success: function(data){				
				var mob_checkanswer_data = JSON.parse(data);
				if (mob_checkanswer_data.mob_checkanswer_success == "mob checkanswer success") {
					window.location.href = "http://www.quizzically.co.uk/quizzically/mobile_web/mob_quizwait.html";
				} else {
					window.alert("Answer Check Failed. Please Try Again.", function(){}, "Alert", "OK");
				}
			}				
		});
		return false;
	}        
}

//Before Question Page
$(document).on("pagebeforeshow", "#page7", function () {
	document.getElementById("mob_user_name3").innerHTML = window.localStorage.getItem("mob_local_login_name");
	document.getElementById("mob_question_score").innerHTML = window.localStorage.getItem("mob_question_score");
	document.getElementById("mob_question_category").innerHTML = window.localStorage.getItem("mob_question_category");
	document.getElementById("mob_question_question").innerHTML = window.localStorage.getItem("mob_question_question");
	document.getElementById("mob_question_number").innerHTML = window.localStorage.getItem("mob_question_number");
	randomAnswer(window.localStorage.getItem("mob_answer1"), window.localStorage.getItem("mob_answer2"), window.localStorage.getItem("mob_answer3"), window.localStorage.getItem("mob_answer4"));
		
	function randomAnswer(one, two, three, four) {
		window.localStorage.removeItem("mob_ranswer1");
		window.localStorage.removeItem("mob_ranswer2");
		window.localStorage.removeItem("mob_ranswer3");
		window.localStorage.removeItem("mob_ranswer4");
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
		window.localStorage.setItem("mob_ranswer1", answer1);
		window.localStorage.setItem("mob_ranswer2", answer2);
		window.localStorage.setItem("mob_ranswer3", answer3);
		window.localStorage.setItem("mob_ranswer4", answer4);
	}
	$("#mob_question_answer1").val(window.localStorage.getItem("mob_ranswer1")).button("refresh");
	$("#mob_question_answer2").val(window.localStorage.getItem("mob_ranswer2")).button("refresh");
	$("#mob_question_answer3").val(window.localStorage.getItem("mob_ranswer3")).button("refresh");
	$("#mob_question_answer4").val(window.localStorage.getItem("mob_ranswer4")).button("refresh");	
		
	perc = 0;
	animateUpdate();  
});

//Question Page
$(document).on("pagecreate","#page7",function(){
	
	$("#mob_question1").submit(function(){
		clearTimeout(ptimer);
		window.localStorage.setItem("mob_score", Math.round(((timeTotal - perc) / timeTotal) * 1000));
	
		var postData = "mob_checkanswer=" . concat(window.localStorage.getItem("mob_ranswer1"), "&mob_checkanswer_email=", window.localStorage.getItem("mob_local_login_email"), "&mob_checkanswer_password=", window.localStorage.getItem("mob_local_login_password"), "&mob_checkanswer_quizcode=", window.localStorage.getItem("mob_local_quiz_code"), "&mob_checkanswer_questionid=", window.localStorage.getItem("mob_question_id"), "&mob_checkanswer_score=", window.localStorage.getItem("mob_score"));
			
		console.log(postData);
			
		$.ajax({
			type: "POST",				
			data: postData,				
			url: "http://www.quizzically.co.uk/quizzically/mobile_web/php/mob_checkanswer.php",			
			success: function(data){				
				var mob_checkanswer_data = JSON.parse(data);
				if (mob_checkanswer_data.mob_checkanswer_success == "mob checkanswer success") {
					window.location.href = "http://www.quizzically.co.uk/quizzically/mobile_web/mob_quizwait.html";
				} else {
					window.alert("Answer Check Failed. Please Try Again.", function(){}, "Alert", "OK");
				}
			}				
		});
		return false;
	});

	$("#mob_question2").submit(function(){
		clearTimeout(ptimer);
		window.localStorage.setItem("mob_score", Math.round(((timeTotal - perc) / timeTotal) * 1000));
		
		var postData = "mob_checkanswer=" . concat(window.localStorage.getItem("mob_ranswer2"), "&mob_checkanswer_email=", window.localStorage.getItem("mob_local_login_email"), "&mob_checkanswer_password=", window.localStorage.getItem("mob_local_login_password"), "&mob_checkanswer_quizcode=", window.localStorage.getItem("mob_local_quiz_code"), "&mob_checkanswer_questionid=", window.localStorage.getItem("mob_question_id"), "&mob_checkanswer_score=", window.localStorage.getItem("mob_score"));
			
		console.log(postData);
		
		$.ajax({
			type: "POST",				
			data: postData,				
			url: "http://www.quizzically.co.uk/quizzically/mobile_web/php/mob_checkanswer.php",			
			success: function(data){				
				var mob_checkanswer_data = JSON.parse(data);
				if (mob_checkanswer_data.mob_checkanswer_success == "mob checkanswer success") {
					window.location.href = "http://www.quizzically.co.uk/quizzically/mobile_web/mob_quizwait.html";
				} else {
					window.alert("Answer Check Failed. Please Try Again.", function(){}, "Alert", "OK");
				}
			}				
		});
		return false;
	});

	$("#mob_question3").submit(function(){
		clearTimeout(ptimer);
		window.localStorage.setItem("mob_score", Math.round(((timeTotal - perc) / timeTotal) * 1000));
		
		var postData = "mob_checkanswer=" . concat(window.localStorage.getItem("mob_ranswer3"), "&mob_checkanswer_email=", window.localStorage.getItem("mob_local_login_email"), "&mob_checkanswer_password=", window.localStorage.getItem("mob_local_login_password"), "&mob_checkanswer_quizcode=", window.localStorage.getItem("mob_local_quiz_code"), "&mob_checkanswer_questionid=", window.localStorage.getItem("mob_question_id"), "&mob_checkanswer_score=", window.localStorage.getItem("mob_score"));
			
		console.log(postData);
		
		$.ajax({
			type: "POST",				
			data: postData,				
			url: "http://www.quizzically.co.uk/quizzically/mobile_web/php/mob_checkanswer.php",			
			success: function(data){				
				var mob_checkanswer_data = JSON.parse(data);
				if (mob_checkanswer_data.mob_checkanswer_success == "mob checkanswer success") {
					window.location.href = "http://www.quizzically.co.uk/quizzically/mobile_web/mob_quizwait.html";
				} else {
					window.alert("Answer Check Failed. Please Try Again.", function(){}, "Alert", "OK");
				}
			}				
		});
		return false;
	});	

	$("#mob_question4").submit(function(){
		clearTimeout(ptimer);
		window.localStorage.setItem("mob_score", Math.round(((timeTotal - perc) / timeTotal) * 1000));
		
		var postData = "mob_checkanswer=" . concat(window.localStorage.getItem("mob_ranswer4"), "&mob_checkanswer_email=", window.localStorage.getItem("mob_local_login_email"), "&mob_checkanswer_password=", window.localStorage.getItem("mob_local_login_password"), "&mob_checkanswer_quizcode=", window.localStorage.getItem("mob_local_quiz_code"), "&mob_checkanswer_questionid=", window.localStorage.getItem("mob_question_id"), "&mob_checkanswer_score=", window.localStorage.getItem("mob_score"));
			
		console.log(postData);
		
		$.ajax({
			type: "POST",				
			data: postData,				
			url: "http://www.quizzically.co.uk/quizzically/mobile_web/php/mob_checkanswer.php",			
			success: function(data){				
				var mob_checkanswer_data = JSON.parse(data);
				if (mob_checkanswer_data.mob_checkanswer_success == "mob checkanswer success") {
					window.location.href = "http://www.quizzically.co.uk/quizzically/mobile_web/mob_quizwait.html";
				} else {
					window.alert("Answer Check Failed. Please Try Again.", function(){}, "Alert", "OK");
				}
			}				
		});
		return false;
	});
});