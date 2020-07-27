//Change
//
//Matthew Davis
//01/05/2014
//
$(function () {
	$("#mob_change_form").submit(function() {
		
		//Make sure password box is not empty
		var x = document.forms["mob_change_form"]["mob_change_password"].value;
		if (x == null || x == "") { 
			window.alert("Password Needed To Login.", function(){}, "Alert", "OK");
			return false; 
		}

		//Make sure passwords match
		var x = document.forms["mob_change_form"]["mob_change_password"].value;
		var y = document.forms["mob_change_form"]["mob_change_repeat_password"].value;
		if (x != y) { 
			window.alert("Password and Repeat Password do not match.", function(){}, "Alert", "OK");
			return false; 
		}
		
		//sort out the data to be posted
		var postData = $(this).serialize();	
		
		//submit data to web_forgot.php and deal with returned data
		$.ajax({
			type: "POST",				
			data: postData,
			url: "http://www.quizzically.co.uk/quizzically/mobile/mob_change_win.php",				
			success: function(data){	
				var mob_change_data = JSON.parse(data);
				if (mob_change_data.mob_change_success == "mob change success") {
					document.getElementById("mob_change_content").innerHTML = "Password Changed";
				} else {	
					document.getElementById("mob_change_content").innerHTML = "Error - Password Not Changed";		
				}
			}				
		});			
		return false;
	});
});