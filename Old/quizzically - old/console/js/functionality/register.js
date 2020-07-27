/*
	Matthew Davis
	Wittin Limited
	01/09/2014
*/

$(function () {
	$("#register_form").submit(function(){

		//check email for validity
		var x = document.forms["register_form"]["register_email"].value;
		var atpos = x.indexOf("@");
		var dotpos = x.lastIndexOf(".");
		if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= x.length) { 
			window.alert("Your Email Is Invalid.", function(){}, "Email Failed", "OK");
			return false;			
		}
		
		//Make sure password box is not empty
		var x = document.forms["register_form"]["register_password"].value;
		if (x == null || x == "") { 
			window.alert("Password Needed To Login.", function(){}, "Password Failed", "OK");
			return false; 
		}

		//Make sure passwords match
		var x = document.forms["register_form"]["register_password"].value;
		var y = document.forms["register_form"]["register_repeat_password"].value;
		if (x != y) { 
			window.alert("Password and Repeat Password do not match.", function(){}, "Password Failed", "OK");
			return false; 
		}

		//sort out the data to be posted
		var postData = $(this).serialize();

		$.ajax({
			type: "POST",				
			data: postData,				
			url: "http://www.quizzically.co.uk/quizzically/console/php/register.php",			
			success: function(data){				
				var register_data = JSON.parse(data);
				if (register_data.register_success == "register success") {
					window.localStorage.setItem("stored_login_email", register_data.register_email);
					window.localStorage.setItem("stored_login_password", register_data.register_password);
					window.localStorage.setItem("stored_login_name", register_data.register_name);
					window.localStorage.setItem("stored_quiz_credit", register_data.register_credit);
					window.location.replace("http://www.quizzically.co.uk/quizzically/console/home.html");	
				} else if (register_data.register_success == "already exists") {
					window.alert("User Name Already Exists. Please Try Another One.", function(){}, "Already Registered", "OK");
				} else {
					window.alert("Registration Failed. Please Try Again.", function(){}, "Registration Failed", "OK");
				}
			}				
		});			
		return false;			
	});		
});