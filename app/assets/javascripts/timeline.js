$(document).on('ready page:load', function () {
  // Actions to do
	$(document).ready(function(){
		$(".eventHeader").click(function(){
			$(this).next(".eventBody").slideToggle();
		});
	});
});