$(document).on('turbolinks:load', function () {
  $(document).ready(function(){

		$("a.js-show-toc").click(function(){
			showSpinner("#lbp-toc-window");
			console.log("test");
			var itemid = $(this).attr("data-itemid");

			showToc(itemid);
		});


	});
});



var showToc = function(itemid){
	$("#lbp-toc-window").load("/text/toc/" + itemid + " #lbp-toc-container", function( response, status, xhr) {
  	if ( status == "error" ) {
    	var msg = "<h3>Sorry but an outline for this text is not yet available.</h3>";
    	$("#lbp-toc-window").html( msg);
    	console.log(xhr.status + " " + xhr.statusText)
    }
  });
}
