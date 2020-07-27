/*
	Matthew Davis
	Wittin Limited
	01/09/2014
*/

$(function () {
	$("#change_form").submit(function() {
		
		//Make sure password box is not empty
		var x = document.forms["change_form"]["change_password"].value;
		if (x == null || x == "") { 
			window.alert("Password Needed To Login.", function(){}, "Password Failed", "OK");
			return false; 
		}

		//Make sure passwords match
		var x = document.forms["change_form"]["change_password"].value;
		var y = document.forms["change_form"]["change_repeat_password"].value;
		if (x != y) { 
			window.alert("Password and Repeat Password do not match.", function(){}, "Password Failed", "OK");
			return false; 
		}
		
		//sort out the data to be posted
		var postData = $(this).serialize();	
		
		//submit data to web_forgot.php and deal with returned data
		$.ajax({
			type: "POST",				
			data: postData,
			url: "http://www.quizzically.co.uk/quizzically/console/php/change_eval.php",				
			success: function(data){	
				var change_data = JSON.parse(data);
				if (change_data.change_success == "change success") {
					window.alert("Password Successfully Changed.", function(){}, "Password Success", "OK");
					window.location.replace("http://www.quizzically.co.uk/quizzically/console/index.html");
				} else {	
					window.alert("Password Change Failed, Please Try Again.", function(){}, "Change Failed", "OK");		
				}
			}				
		});			
		return false;
	});
});