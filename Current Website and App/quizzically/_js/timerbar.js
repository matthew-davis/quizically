
(function ($) {
	
	$.fn.progressTimer = function (options) {
		
		var settings = $.extend({}, $.fn.progressTimer.defaults, options);

        this.each(function () {
            
        	$(this).empty();
            var barContainer = $("<div>").addClass("progress active progress-striped");
            var bar = $("<div>").addClass("progress-bar").addClass(settings.baseStyle)
                .attr("role", "progressbar")
                .attr("aria-valuenow", "0")
                .attr("aria-valuemin", "0")
                .attr("aria-valuemax", settings.timeLimit);

            bar.appendTo(barContainer);
            barContainer.appendTo($(this));
            
            var start = new Date();
            var limit = settings.timeLimit * 1000;
            var interval = window.setInterval(function () {
               
			   var elapsed = new Date() - start;
                bar.width(((elapsed / limit) * 100) + "%")
                   .attr("aria-valuenow", elapsed);

                if (elapsed >= limit) {
                    window.clearInterval(interval);
                    settings.onFinish.call(this);
                }

            }, 125);
            
            if (settings.stopTimer) {
            	clearInterval(interval);
            }

        });

        return this;
    };

    $.fn.progressTimer.defaults = {
        timeLimit: 30,  //total number of seconds
        onFinish: function () {},  //invoked once the timer expires
        stopTimer: false, //invoked to stop timer
		baseStyle: 'progress-bar-primary', //bootstrap progress bar style at the beginning of the timer
    };
}(jQuery));
