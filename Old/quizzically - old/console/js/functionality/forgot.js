/*
	Matthew Davis
	Wittin Limited
	01/09/2014
*/

$(function () {
	$("#forgot_form").submit(function() {
		
		//check email for validity
		var x = document.forms["forgot_form"]["forgot_email"].value;
		var atpos = x.indexOf("@");
		var dotpos = x.lastIndexOf(".");
		if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= x.length) { 
			window.alert("Your Email Is Invalid.", function(){}, "Email Failed", "OK");
			return false;			
		}
		
		//sort out the data to be posted
		var postData = $(this).serialize();
		
		//submit data to web_forgot.php and deal with returned data
		$.ajax({
			type: "POST",				
			data: postData,
			url: "http://www.quizzically.co.uk/quizzically/console/php/forgot.php",				
			success: function(data){	
				var forgot_data = JSON.parse(data);
				if (forgot_data.forgot_success == "forgot success") {
					window.alert("Reminder Email Sent.", function(){}, "Email Sent", "OK");
					window.location.replace("http://www.quizzically.co.uk/quizzically/console/index.html");	
				} else if (forgot_data.forgot_success == "no account") {
					window.alert("Email Not Found In Database. Please Register.", function(){}, "Email Failed", "OK");
					window.location.replace("http://www.quizzically.co.uk/quizzically/console/register.html");
				} else {	
					window.alert("Email Could Not Be Sent. Please Register Again.", function(){}, "Email Failed", "OK");
					window.location.replace("http://www.quizzically.co.uk/quizzically/console/register.html");		
				}
			}				
		});			
		return false;
	});
});