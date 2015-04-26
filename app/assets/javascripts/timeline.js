$(document).ready(function(){
	$(".eventHeader").click(function(){
		$(this).next(".eventBody").slideToggle();
	});
});