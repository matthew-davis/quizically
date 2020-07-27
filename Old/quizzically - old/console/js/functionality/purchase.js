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
		
		function getUrlVars() {
			var vars = {};
			var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
				vars[key] = value;
			});
			return vars;
		}
		
		var result = getUrlVars()["result"];
		if (result == 'cancel') {
			window.alert("Order Cancelled.", function(){}, "Order Cancelled", "OK");
		} else if (result == 'one') {

			var postData = "purchase_qty=one&purchase_email=" . concat(window.localStorage.getItem("stored_login_email"), "&purchase_password=", window.localStorage.getItem("stored_login_password"));

			$.ajax({
				type: "POST",				
				data: postData,				
				url: "http://www.quizzically.co.uk/quizzically/console/php/purchase.php",			
				success: function(data){				
					var purchase_data = JSON.parse(data);
					if (purchase_data.purchase_success == "purchase success") {
						window.localStorage.setItem("stored_quiz_credit", purchase_data.quiz_credit);
						window.location.replace("http://www.quizzically.co.uk/quizzically/console/home.html");	
					}
				}				
			});			

		} else if (result == 'five') {
		
			var postData = "purchase_qty=five&purchase_email=" . concat(window.localStorage.getItem("stored_login_email"), "&purchase_password=", window.localStorage.getItem("stored_login_password"));

			$.ajax({
				type: "POST",				
				data: postData,				
				url: "http://www.quizzically.co.uk/quizzically/console/php/purchase.php",			
				success: function(data){				
					var purchase_data = JSON.parse(data);
					if (purchase_data.purchase_success == "purchase success") {
						window.localStorage.setItem("stored_quiz_credit", purchase_data.quiz_credit);
						window.location.replace("http://www.quizzically.co.uk/quizzically/console/home.html");	
					}
				}				
			});			
			return false;
		
		} else if (result == 'ten') {
		
			var postData = "purchase_qty=ten&purchase_email=" . concat(window.localStorage.getItem("stored_login_email"), "&purchase_password=", window.localStorage.getItem("stored_login_password"));

			$.ajax({
				type: "POST",				
				data: postData,				
				url: "http://www.quizzically.co.uk/quizzically/console/php/purchase.php",			
				success: function(data){				
					var purchase_data = JSON.parse(data);
					if (purchase_data.purchase_success == "purchase success") {
						window.localStorage.setItem("stored_quiz_credit", purchase_data.quiz_credit);
						window.location.replace("http://www.quizzically.co.uk/quizzically/console/home.html");	
					}
				}				
			});			
			return false;
		
		} else {
			return false;
		}		
	};
	
});
