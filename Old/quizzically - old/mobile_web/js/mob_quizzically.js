
//Login Page
$(document).on("pagecreate","#page1",function(){
	$("#mob_login_form").submit(function() {
		
		//check email for validity
		var x = document.forms["mob_login_form"]["mob_login_email"].value;
		var atpos = x.indexOf("@");
		var dotpos = x.lastIndexOf(".");
		if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= x.length) { 
			window.alert("Your Email Is Invalid.", function(){}, "Email Failed", "OK");
			return false;			
		}

		//Make sure password box isnt empty
		var x = document.forms["mob_login_form"]["mob_login_password"].value;
		if (x == null || x == "") { 
			window.alert("Password Needed To Login.", function(){}, "Password Failed", "OK");
			return false; 
		}
		
		//sort out the data to be posted
		var postData = $(this).serialize() . concat("&mob_login_auto=n");
	
		//submit data to login.php and deal with returned data
		$.ajax({
			type: "POST",				
			data: postData,
			url: "http://www.quizzically.co.uk/quizzically/mobile_web/php/mob_login.php",				
			success: function(data){	
				var mob_login_data = JSON.parse(data);
				if (mob_login_data.mob_login_success == "mob login success") {
					//window.localStorage.setItem("mob_local_login_email", mob_login_data.mob_login_email);
					//window.localStorage.setItem("mob_local_login_password", mob_login_data.mob_login_password);
					//window.localStorage.setItem("mob_local_login_name", mob_login_data.mob_login_name);
					//window.location.href = "#page4";
					$.mobile.pageContainer.pagecontainer("change", "mob_quiz.html", {transition: "slide"});
					//window.alert("Giggity Giggity Goo.", function(){}, "Auto Login Failed", "OK");
				//} else if (mob_login_data.mob_login_success == "mob no account") {
					//window.alert("Email Not Found. Please Register.", function(){}, "Email Failed", "OK");
				//} else if (mob_login_data.mob_login_success == "mob password failed") {
					//window.alert("Password Failed. Please Try Again.", function(){}, "Password Failed", "OK");
				} else {	
					window.alert("Login Failed. Please Try Again.", function(){}, "Auto Login Failed", "OK");		
				}
			}
		});							
		return false;
	});
});

	//Register Page
	$(document).on("pagecreate","#page2",function(){
		$("#mob_register_form").submit(function(){
		
			//check email for validity
			var x = document.forms["mob_register_form"]["mob_register_email"].value;
			var atpos = x.indexOf("@");
			var dotpos = x.lastIndexOf(".");
			if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= x.length) { 
				window.alert("Your Email Is Invalid.", function(){}, "Email Failed", "OK");
				return false;			
			}
		
			//Make sure password box isn't empty
			var x = document.forms["mob_register_form"]["mob_register_password"].value;
			if (x == null || x == "") { 
				window.alert("Password Needed To Register.", function(){}, "Password Failed", "OK");
				return false; 
			}
			
			//Make sure password's match
			var x = document.forms["mob_register_form"]["mob_register_password"].value;
			var y = document.forms["mob_register_form"]["mob_repeat_password"].value;
			if (x != y) { 
				window.alert("Password and Repeat Password do not match.", function(){}, "Password Failed", "OK");
				return false;
			}
			
			//sort out the data to be posted
			var postData = $(this).serialize();
			
			$.ajax({
				type: "POST",				
				data: postData,				
				url: "http://www.quizzically.co.uk/quizzically/mobile_web/php/mob_register.php",			
				success: function(data){				
					var mob_register_data = JSON.parse(data);
					if (mob_register_data.mob_register_success == "mob register success") {
						window.localStorage.setItem("mob_local_login_email", mob_register_data.mob_register_email);
						window.localStorage.setItem("mob_local_login_password", mob_register_data.mob_register_password);
						window.localStorage.setItem("mob_local_login_name", mob_register_data.mob_register_name);
						$.mobile.pageContainer.pagecontainer('change', "#page4", {transition: 'flow', reload: true});
					} else if (mob_register_data.mob_register_success == "mob already exists") {
						window.alert("Username already exists. Please Try Again.", function(){}, "Email Failed", "OK");
					} else {
						window.alert("Registration Failed. Please Try Again.", function(){}, "Email Failed", "OK");
					}
				}				
			});			
			return false;			
		});
	});

	//Forgot Password Page
	$(document).on("pagecreate","#page3",function(){
		$("#mob_forgot_form").submit(function(){
		
			//check email for validity
			var x = document.forms["mob_forgot_form"]["mob_forgot_email"].value;
			var atpos = x.indexOf("@");
			var dotpos = x.lastIndexOf(".");
			if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= x.length) { 
				window.alert("Your Email Is Invalid.", function(){}, "Email Failed", "OK");
				return false;			
			}
		
			//sort out the data to be posted
			var postData = $(this).serialize();
			
			$.ajax({
				type: "POST",				
				data: postData,				
				url: "http://www.quizzically.co.uk/quizzically/mobile_web/php/mob_forgot.php",			
				success: function(data){				
					var mob_forgot_data = JSON.parse(data);
					if (mob_forgot_data.mob_forgot_success == "mob forgot success") {
						window.alert("Reminder Email Sent.", function(){}, "Email Sent", "OK");
						$.mobile.pageContainer.pagecontainer('change', "#page1", {transition: 'slide', reload: true});	
					} else if (mob_forgot_data.mob_forgot_success == "mob no account") {
						window.alert("Email Not Found. Please Register.", function(){}, "Email Failed", "OK");
						$.mobile.pageContainer.pagecontainer('change', "#page1", {transition: 'slide', reload: true});
					} else if (mob_forgot_data.mob_forgot_success == "mob no send") {
						window.alert("Email Not Sent. Please Register Again.", function(){}, "Email Failed", "OK");
						$.mobile.pageContainer.pagecontainer('change', "#page1", {transition: 'slide', reload: true});
					} else {
						window.alert("Password Changed Failed. Please Register Again.", function(){}, "Email Failed", "OK");
						$.mobile.pageContainer.pagecontainer('change', "#page1", {transition: 'slide', reload: true});	
					}
				}
			});			
			return false;			
		});
	});

	//Before Quiz page
	$(document).on("pagebeforeshow", "#page4", function () {
		document.getElementById("mob_user_name1").innerHTML = window.localStorage.getItem("mob_local_login_name");
		window.localStorage.setItem("mob_question_id", 0);
		return false;
	});

	//Quiz page
	$(document).on("pagecreate","#page4",function(){
		$("#mob_quiz_form").submit(function(){
		
			//sort out the data to be posted
			var postData = $(this).serialize() . concat("&mob_quiz_email=", window.localStorage.getItem("mob_local_login_email"), "&mob_quiz_password=", window.localStorage.getItem("mob_local_login_password"));
			
			$.ajax({
				type: "POST",				
				data: postData,				
				url: "http://www.quizzically.co.uk/quizzically/mobile_web/php/mob_quizcode.php",			
				success: function(data){				
					var mob_quiz_data = JSON.parse(data);
					if (mob_quiz_data.mob_quiz_success == "mob quiz success") {
						window.localStorage.setItem("mob_local_quiz_code", mob_quiz_data.mob_quiz_code);
						$.mobile.pageContainer.pagecontainer('change', "#page6", {transition: 'slide', reload: true});
					} else {
						window.alert("Quiz Not Registered. Please Try Again.", function(){}, "Alert", "OK");
					}
				}
			});			
			return false;			
		});
	});
	
	//Before Profile Page
	$(document).on("pagebeforeshow", "#page5", function () {
		
		//sort out the data to be posted
		var postData = "mob_profile_type=details&mob_profile_old_email=" . concat(window.localStorage.getItem("mob_local_login_email"), "&mob_profile_old_password=", window.localStorage.getItem("mob_local_login_password"));
			
		$.ajax({
			type: "POST",				
			data: postData,				
			url: "http://www.quizzically.co.uk/quizzically/mobile_web/php/mob_update.php",			
			success: function(data){				
				var mob_profile_data = JSON.parse(data);
				if (mob_profile_data.mob_profile_success == "mob details success") {
					$("#mob_profile_email").val(mob_profile_data.mob_profile_email);
					$("#mob_profile_radiom").prop("checked", mob_profile_data.mob_profile_genderm).checkboxradio("refresh");
					$("#mob_profile_radiof").prop("checked", mob_profile_data.mob_profile_genderf).checkboxradio("refresh");
					$("#mob_profile_birthday").val(mob_profile_data.mob_profile_birthday);						
					$("#mob_profile_location").val(mob_profile_data.mob_profile_location).selectmenu("refresh");						
					$("#mob_profile_updates").prop("checked", mob_profile_data.mob_profile_updates).checkboxradio("refresh");						
				} else {
					window.alert("Update Details Failed. Please Try Again.", function(){}, "Alert", "OK");
				}
			}				
		});
	});
	
	//Profile Page
	$(document).on("pagecreate","#page5",function(){
		$("#mob_profile_form").submit(function(){
			
			//check email for validity
			var x = document.forms["mob_profile_form"]["mob_profile_email"].value;
			var atpos = x.indexOf("@");
			var dotpos = x.lastIndexOf(".");
			if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= x.length) { 
				window.alert("Your Email is Invalid.", function(){}, "Alert", "OK");
				return false;			
			}
				
			//Make sure password's match
			var x = document.forms["mob_profile_form"]["mob_profile_password"].value;
			var y = document.forms["mob_profile_form"]["mob_repeat_password"].value;
			if (x != y) { 
				window.alert("Password and Repeat Password Don't Match.", function(){}, "Alert", "OK");
				return false; 
			}
			
			//sort out the data to be posted
			var postData = $(this).serialize() . concat("&mob_profile_type=update&mob_profile_old_email=", window.localStorage.getItem("mob_local_login_email"), "&mob_profile_old_password=", window.localStorage.getItem("mob_local_login_password"));
				
			$.ajax({
				type: "POST",				
				data: postData,				
				url: "http://www.quizzically.co.uk/quizzically/mobile_web/php/mob_update.php",			
				success: function(data){				
					var mob_profile_data = JSON.parse(data);
					if (mob_profile_data.mob_profile_success == "mob update success") {
						window.localStorage.setItem("mob_local_login_email", mob_profile_data.mob_profile_email);
						window.localStorage.setItem("mob_local_login_password", mob_profile_data.mob_profile_password);
						window.localStorage.setItem("mob_local_login_name", mob_profile_data.mob_profile_name);
						$.mobile.pageContainer.pagecontainer('change', "#page4", {transition: 'slide', reload: true});
					} else {
						window.alert("Update Failed. Please Try Again.", function(){}, "Alert", "OK");
					}
				}				
			});			
			return false;			
		});
	});
	
	//Before Quizwait Screen
	$(document).on("pagebeforeshow", "#page6", function () {
		document.getElementById("mob_user_name2").innerHTML = window.localStorage.getItem("mob_local_login_name");
			
		//Leader board call
		var quizcode = "mob_quizcode=" . concat(window.localStorage.getItem("mob_local_quiz_code"));
		
		$.ajax({
			type: "POST",
			data: quizcode,
			url: "http://www.quizzically.co.uk/quizzically/mobile_web/php/mob_leaderboard.php",				
			success: function(data){	
				var mob_leader_data = JSON.parse(data);
				$("#mob_leaderboard1").html("<tr><th>Name</th><th>Score</th></tr>");
				$.each(mob_leader_data, function (i, item) {
					$('<tr>').append($('<td>').text(item.NAME), $('<td>').text(item.SCORE)).appendTo('#mob_leaderboard1');
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
						window.localStorage.setItem("mob_question_question", mob_quizwait_data.mob_quizwait_question);
						window.localStorage.setItem("mob_answer1", mob_quizwait_data.mob_quizwait_correct);
						window.localStorage.setItem("mob_answer2", mob_quizwait_data.mob_quizwait_wrong1);
						window.localStorage.setItem("mob_answer3", mob_quizwait_data.mob_quizwait_wrong2);
						window.localStorage.setItem("mob_answer4", mob_quizwait_data.mob_quizwait_wrong3);
						$.mobile.pageContainer.pagecontainer('change', "#page7", {transition: 'slide', reload: true});
					} else if (mob_quizwait_data.mob_quizwait_success == "mob quizwait stay") {
						qtimer = setTimeout(checkForQuestion, 1000);
						return false;
					} else if (mob_quizwait_data.mob_quizwait_success == "mob quizwait intermission") {
						document.getElementById("mob_intermission").innerHTML = "Intermission";
						qtimer = setTimeout(checkForQuestion, 1000);
						return false;
					} else if (mob_quizwait_data.mob_quizwait_success == "mob quizwait finished") {
						clearTimeout(qtimer);
						$.mobile.pageContainer.pagecontainer('change', "#page8", {transition: 'slide', reload: true});
					} else {
						clearTimeout(qtimer);
						window.alert("Status Check Failed. Please Try Again.", function(){}, "Alert", "OK");
					}
				},
			});			
			return false;
		});	
	});
	
	//Quizwait Screen
	$(document).on("pagecreate","#page6",function(){
	
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
							$.mobile.pageContainer.pagecontainer('change', "#page6", {transition: 'slide', reload: true});
						} else {
							window.alert("Answer Check Failed. Please Try Again.", function(){}, "Alert", "OK");
						}
					}				
				});
				return false;
			}        
		}
	});
	
	//Before Question Page
	$(document).on("pagebeforeshow", "#page7", function () {
		document.getElementById("mob_user_name3").innerHTML = window.localStorage.getItem("mob_local_login_name");
		document.getElementById("mob_question_score").innerHTML = window.localStorage.getItem("mob_question_score");
		document.getElementById("mob_question_category").innerHTML = window.localStorage.getItem("mob_question_category");
		document.getElementById("mob_question_question").innerHTML = window.localStorage.getItem("mob_question_question");
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
				
			$.ajax({
				type: "POST",				
				data: postData,				
				url: "http://www.quizzically.co.uk/quizzically/mobile_web/php/mob_checkanswer.php",			
				success: function(data){				
					var mob_checkanswer_data = JSON.parse(data);
					if (mob_checkanswer_data.mob_checkanswer_success == "mob checkanswer success") {
						$.mobile.pageContainer.pagecontainer('change', "#page6", {transition: 'slide', reload: true});
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
				
			$.ajax({
				type: "POST",				
				data: postData,				
				url: "http://www.quizzically.co.uk/quizzically/mobile_web/php/mob_checkanswer.php",			
				success: function(data){				
					var mob_checkanswer_data = JSON.parse(data);
					if (mob_checkanswer_data.mob_checkanswer_success == "mob checkanswer success") {
						$.mobile.pageContainer.pagecontainer('change', "#page6", {transition: 'slide', reload: true});
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
				
			$.ajax({
				type: "POST",				
				data: postData,				
				url: "http://www.quizzically.co.uk/quizzically/mobile_web/php/mob_checkanswer.php",			
				success: function(data){				
					var mob_checkanswer_data = JSON.parse(data);
					if (mob_checkanswer_data.mob_checkanswer_success == "mob checkanswer success") {
						$.mobile.pageContainer.pagecontainer('change', "#page6", {transition: 'slide', reload: true});
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
				
			$.ajax({
				type: "POST",				
				data: postData,				
				url: "http://www.quizzically.co.uk/quizzically/mobile_web/php/mob_checkanswer.php",			
				success: function(data){				
					var mob_checkanswer_data = JSON.parse(data);
					if (mob_checkanswer_data.mob_checkanswer_success == "mob checkanswer success") {
						$.mobile.pageContainer.pagecontainer('change', "#page6", {transition: 'slide', reload: true});
					} else {
						window.alert("Answer Check Failed. Please Try Again.", function(){}, "Alert", "OK");
					}
				}				
			});
			return false;
		});
	});
	
	//Before Quizfinish Page
	$(document).on("pagebeforeshow", "#page8", function () {
		document.getElementById("mob_user_name4").innerHTML = window.localStorage.getItem("mob_local_login_name");
		$('#mob_quiz_quizcode').val("");
		document.getElementById("mob_intermission").innerHTML = "";
		return false;
	});

