/*
	Matthew Davis
	Wittin Limited
	01/09/2014
*/

$(function () {
	window.onload = function() {
		if(window.localStorage.getItem("stored_login_email") != undefined && window.localStorage.getItem("stored_login_password") != undefined) {
			
			//Sort out the data to be posted (web_login_auto tells the php whether or not to use md5 on the password)
			var postData = "login_auto='y'&login_email=" . concat(window.localStorage.getItem("stored_login_email"), "&login_password=", window.localStorage.getItem("stored_login_password"));
			
			//submit data to login.php and deal with returned data
			$.ajax({
				type: "POST",				
				data: postData,
				url: "http://www.quizzically.co.uk/quizzically/console/php/index.php",				
				success: function(data){	
					var login_data = JSON.parse(data);
					if (login_data.login_success == "login success") {
						window.localStorage.setItem("stored_login_email", login_data.login_email);
						window.localStorage.setItem("stored_login_password", login_data.login_password);
						window.localStorage.setItem("stored_login_name", login_data.login_name);
						window.localStorage.setItem("stored_quiz_credit", login_data.login_credit);
						window.location.replace("http://www.quizzically.co.uk/quizzically/console/home.html");
					} else if (login_data.login_success == "no account") {
						window.localStorage.removeItem("stored_login_email");
						window.localStorage.removeItem("stored_login_password");
						window.localStorage.removeItem("stored_login_name");
						window.localStorage.removeItem("stored_quiz_credit");
						window.alert("Email Not Found. Please Register.", function(){}, "Email Failed", "OK");
					} else if (login_data.login_success == "password failed") {
						window.localStorage.removeItem("stored_login_email");
						window.localStorage.removeItem("stored_login_password");
						window.localStorage.removeItem("stored_login_name");
						window.localStorage.removeItem("stored_quiz_credit");
						window.alert("Password Failed. Please Try Again.", function(){}, "Password Failed", "OK");
					} else {
						window.localStorage.removeItem("stored_login_email");
						window.localStorage.removeItem("stored_login_password");
						window.localStorage.removeItem("stored_login_name");
						window.localStorage.removeItem("stored_quiz_credit");
						window.alert("Auto Login Failed. Please Try Again.", function(){}, "Auto Login Failed", "OK");
					}
				}				
			});			
			return false;
		}
	};
});

$(function () {
	$("#login_form").submit(function() {
		
		//Check it is a valid email
		var x = document.forms["login_form"]["login_email"].value;
		var atpos = x.indexOf("@");
		var dotpos = x.lastIndexOf(".");
		if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= x.length) { 
			window.alert("Your Email Is Invalid.", function(){}, "Email Failed", "OK");
			return false;			
		}

		//Check password is not empty
		var x = document.forms["login_form"]["login_password"].value;
		if (x == null || x == "") { 
			window.alert("Password Needed To Login.", function(){}, "Password Failed", "OK");
			return false; 
		}
		
		console.log("Inside");
		
		//Put together data to be posted
		var postData = $(this).serialize() . concat("&login_auto=n");
		
		//Submit data to web_login.php and deal with the returned data
		$.ajax({
			type: "POST",				
			data: postData,
			url: "http://www.quizzically.co.uk/quizzically/console/php/index.php",				
			success: function(data){
				console.log(data);	
				var login_data = JSON.parse(data);
				if (login_data.login_success == "login success") {
					window.localStorage.setItem("stored_login_email", login_data.login_email);
					window.localStorage.setItem("stored_login_password", login_data.login_password);
					window.localStorage.setItem("stored_login_name", login_data.login_name);
					window.localStorage.setItem("stored_quiz_credit", login_data.login_credit);
					window.location.replace("http://www.quizzically.co.uk/quizzically/console/home.html");					
				} else if (login_data.login_success == "no account") {
					window.alert("Email Not Found. Please Register For An Account.", function(){}, "Email Failed", "OK");
				} else if (login_data.login_success == "password failed") {
					window.alert("Password Failed. Please Try Again.", function(){}, "Password Failed", "OK");
				} else {	
					window.alert("Login Failed. Please Try Again.", function(){}, "Login Failed", "OK");		
				}
			}				
		});			
		return false;
	});
});