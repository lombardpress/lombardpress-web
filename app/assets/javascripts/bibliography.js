$(document).on('turbolinks:load', function () {
	$(document).ready(function(){
		$(".viewNotes").click(function(){

			$(this).parent().parent().next("div.bibNotes").slideToggle();
		});
	});
});
