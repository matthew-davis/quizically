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
					window.location.href = "http://www.quizzically.co.uk/quizzically/mobile_web/mob_quiz.html";
				} else {
					window.alert("Update Failed. Please Try Again.", function(){}, "Alert", "OK");
				}
			}				
		});			
		return false;			
	});
});