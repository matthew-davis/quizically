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
			url: "http://www.quizzically.co.uk/quizzically/mobile/mob_forgot.php",			
			success: function(data){				
				var mob_forgot_data = JSON.parse(data);
				if (mob_forgot_data.mob_forgot_success == "mob forgot success") {
					window.alert("Reminder Email Sent.", function(){}, "Email Sent", "OK");
					window.location.href = "http://www.quizzically.co.uk/quizzically/mobile_web/index.html";
				} else if (mob_forgot_data.mob_forgot_success == "mob no account") {
					window.alert("Email Not Found. Please Register.", function(){}, "Email Failed", "OK");
					window.location.href = "http://www.quizzically.co.uk/quizzically/mobile_web/index.html";
				} else if (mob_forgot_data.mob_forgot_success == "mob no send") {
					window.alert("Email Not Sent. Please Register Again.", function(){}, "Email Failed", "OK");
					window.location.href = "http://www.quizzically.co.uk/quizzically/mobile_web/index.html";
				} else {
					window.alert("Password Changed Failed. Please Register Again.", function(){}, "Email Failed", "OK");
					window.location.href = "http://www.quizzically.co.uk/quizzically/mobile_web/index.html";
				}
			}
		});			
		return false;			
	});
});