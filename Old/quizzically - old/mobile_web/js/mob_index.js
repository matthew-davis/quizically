//Login Page

//$(document).on("pagecreate","#page1",function(){
	
$(document).ready(function() {
	$("#mob_login_form").submit(function() {
		
		console.log("hello");
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
				console.log(data);
				var mob_login_data = JSON.parse(data);
				if (mob_login_data.mob_login_success == "mob login success") {
					window.localStorage.setItem("mob_local_login_email", mob_login_data.mob_login_email);
					window.localStorage.setItem("mob_local_login_password", mob_login_data.mob_login_password);
					window.localStorage.setItem("mob_local_login_name", mob_login_data.mob_login_name);
					window.location.href = "http://www.quizzically.co.uk/quizzically/mobile_web/mob_quiz.html";
				} else if (mob_login_data.mob_login_success == "mob no account") {
					window.alert("Email Not Found. Please Register.", function(){}, "Email Failed", "OK");
				} else if (mob_login_data.mob_login_success == "mob password failed") {
					window.alert("Password Failed. Please Try Again.", function(){}, "Password Failed", "OK");
				} else {	
					window.alert("Login Failed. Please Try Again.", function(){}, "Auto Login Failed", "OK");		
				}
			}
		});							
		return false;
	});
	
	$("#mob_register_button").submit(function() {
		window.location.href = "http://www.quizzically.co.uk/quizzically/mobile_web/mob_register.html";
		return false;
	});
	
	
	$("#mob_forgot_button").submit(function() {
		window.location.href = "http://www.quizzically.co.uk/quizzically/mobile_web/mob_forgot.html";
		return false;
	});
});