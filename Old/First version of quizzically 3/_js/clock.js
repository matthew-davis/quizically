function startTime() {
	var today = new Date();
	
	var dayList = new Array();
		dayList[0] = "Sun";
		dayList[1] = "Mon";
		dayList[2] = "Tues";
		dayList[3] = "Wed";
		dayList[4] = "Thur";
		dayList[5] = "Fri";
		dayList[6] = "Sat";
	var day = dayList[today.getDay()];
	
	var d = today.getDate();
	
	var monthList = new Array();
		monthList[0] = "Jan";
		monthList[1] = "Feb";
		monthList[2] = "Mar";
		monthList[3] = "Apr";
		monthList[4] = "May";
		monthList[5] = "Jun";
		monthList[6] = "Jul";
		monthList[7] = "Aug";
		monthList[8] = "Sep";
		monthList[9] = "Oct";
		monthList[10] = "Nov";
		monthList[11] = "Dec";
	var month = monthList[today.getMonth()];
	
	var y = today.getFullYear();
	
	var h = today.getHours();
	
	var m = today.getMinutes();
	
	var s = today.getSeconds();
	
	d = checkNum(d);
	h = checkNum(h);
	m = checkNum(m);
	s = checkNum(s);
	
	clockDateFormat = day + ", " + d + " " + month + " " + y;
	clockTimeFormat = h + ":" + m + ":" + s;
	
	$('.clockdate').html(clockDateFormat);
	$('.clocktime').html(clockTimeFormat);
	
	var t = setTimeout(function(){startTime()},500);
}

function checkNum(i) {
	if (i<10) {i = "0" + i};  // add zero in front of numbers < 10
	return i;
}
