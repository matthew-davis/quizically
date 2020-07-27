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

		//sort out the data to be posted
		var postData = "profile_type=fill&profile_email=" . concat(window.localStorage.getItem("stored_login_email"), "&profile_old_password=", window.localStorage.getItem("stored_login_password"));
		
		$.ajax({
			type: "POST",				
			data: postData,
			url: "http://www.quizzically.co.uk/quizzically/console/php/profile.php",				
			success: function(data){	
				var profile_data = JSON.parse(data);
				if (profile_data.profile_success == "profile fill success") {
					document.getElementById("profile_email").value = profile_data.profile_email;
					document.getElementById("profile_organisation").value = profile_data.profile_organisation;
					document.getElementById("profile_location").value = profile_data.profile_location;
					document.getElementById("profile_updates").checked = profile_data.profile_updates;				
				} else {
					window.alert("Auto Profile Fill Failed. Please Try Again.", function(){}, "Auto Profile Fill Failed", "OK");
					window.location.replace("http://www.quizzically.co.uk/quizzically/console/home.html");
				}
			}				
		});
	};
});

$(function () {
	$("#profile_form").submit(function(){
		
		//check email for validity
		var x = document.forms["profile_form"]["profile_email"].value;
		var atpos = x.indexOf("@");
		var dotpos = x.lastIndexOf(".");
		if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= x.length) { 
			window.alert("Your Email Is Invalid.", function(){}, "Email Failed", "OK");
			return false;			
		}
		
		//Make sure password's match
		var x = document.forms["profile_form"]["profile_password"].value;
		var y = document.forms["profile_form"]["profile_repeat_password"].value;
		if (x != y) { 
			window.alert("Password Needed To Login.", function(){}, "Password Failed", "OK");
			return false; 
		}

		//sort out the data to be posted
		var postData = "profile_type=update&" . concat($(this).serialize(), "&profile_old_email=", window.localStorage.getItem("stored_login_email"), "&profile_old_password=", window.localStorage.getItem("stored_login_password"));
		
		$.ajax({
			type: "POST",				
			data: postData,				
			url: "http://www.quizzically.co.uk/quizzically/console/php/profile.php",			
			success: function(data){				
				var profile_data = JSON.parse(data);
				if (profile_data.profile_success == "profile update success") {
					window.localStorage.setItem("stored_login_email", profile_data.profile_email);
					window.localStorage.setItem("stored_login_password", profile_data.profile_password);
					window.localStorage.setItem("stored_login_name", profile_data.profile_name);
					window.location.replace("http://www.quizzically.co.uk/quizzically/console/home.html");
				} else {
					window.alert("Update Failed. Please Try Again.", function(){}, "Update Failed", "OK");
				}
			}				
		});			
		return false;			
	});		
});