$(document).on('turbolinks:load', function () {
  // Actions to do
	$(document).ready(function(){
		$(".eventHeader").click(function(){
			$(this).next(".eventBody").slideToggle();
		});
	});
});
