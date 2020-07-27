
//Leader board call
$(document).ready(function() {
	$(function checkForLeader() {
		$("td").remove();
		quizcode = "quiz_code=" . concat(window.localStorage.getItem("stored_quiz_code"));			
		$.ajax({
			type: "POST",
			data: quizcode,
			url: "http://www.quizzically.co.uk/quizzically/console/php/leaderboard.php",				
			success: function(data){
				$('#leader_board').empty();	
				$('#leader_board').append('<tr><th style="width: 60%">Name&nbsp;&nbsp;</th><th style="width: 40%">Score&nbsp;&nbsp;</th></tr>');	
				var leader_data = JSON.parse(data);
				$.each(leader_data, function (i, item) {
					$('#leader_board').append('<tr><td style="padding: 0px 10px 10px 0px; vertical-align: top;" class="'.concat(item.ANSWERED, ' ', item.CLASS, '">', item.NAME, '<td style="padding: 0px 10px 10px 0px; vertical-align: top;">', item.SCORE, '</tr>'));
				});
				lTimer = setTimeout(checkForLeader, 1000);
			}				
		});
		return false;
	});
});
