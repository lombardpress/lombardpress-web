$(document).on('turbolinks:load', function () {
  // Actions to do
	$(document).ready(function(){

		//$(".js-filter-input").on('input', function() {
			//console.log("test");
    	//console.log($(this).val()); // get the current value of the input field.
		//});
		$(document).on('input', ".js-filter-input", function() {
    	//$(this).next().stop(true, true).fadeIn(0).html('[input event fired!]: ' + $(this).val()).fadeOut(2000);
    	console.log(this.value);
    	var searchValue = this.value;
    	if (this.value === "" ){
    		$(".lbp-question-row:contains(" + searchValue + ")").removeClass("lbp-hidden");
    		}
    	else{
    		$(".lbp-question-row").addClass("lbp-hidden");
    		$(".lbp-question-row:contains(" + searchValue + ")").removeClass("lbp-hidden");
    	}

		});

	});

});
