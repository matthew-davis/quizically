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
					window.location.href = "http://www.quizzically.co.uk/quizzically/mobile_web/mob_quiz.html";
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