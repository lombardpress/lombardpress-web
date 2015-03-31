
$(document).on('ready page:load', function () {
  // Actions to do

	$(document).ready(function(){
	  
	 //events
	  $("a.paragraphmenu").click(showParagraphMenu);
		$("a.js-show-para-comment").click(showBottomWindow);
		$("a.js-expand-para-comment").click(expandBottomWindow);
		$("a.js-minimize-para-comment").click(minimizeBottomWindow);
		$("a.js-halfsize-para-comment").click(halfSizeBottomWindow);
		$("a.js-close-para-comment").click(hideBottomWindow);
		
		

		$("a.js-show-para-image-window").click(function(){
			halfSizeBottomWindow();
			var msslug = $(this).attr("data-msslug");
			var itemid = $(this).attr("data-itemid");
			var pid = $(this).attr("data-pid");
			showParaImage(itemid, msslug, pid);	
		});

		$("a.js-view-comments").click(function(){
			halfSizeBottomWindow();
			var itemid = $(this).attr("data-itemid");
			var pid = $(this).attr("data-pid");
			showComments(itemid, pid);	
		});
		$("a.js-new-comment").click(function(){
			halfSizeBottomWindow();
			var itemid = $(this).attr("data-itemid");
			var pid = $(this).attr("data-pid");
			newComment(itemid, pid);	
		});


	});
});

//document binds required for events triggered after ajax load 
$(document).on("click", ".js-show-para-image", function(event){
		event.preventDefault();
		var msslug = $(this).attr("data-msslug");
		var fs = $(this).attr("data-itemid");
		var pid = $(this).attr("data-pid");
		showParaImage(fs, msslug, pid);	
});
$(document).on("click", ".js-show-alt-para-image", function(event){
		event.preventDefault();
		var msslug = $(this).attr("data-msslug");
		var fs = $(this).attr("data-itemid");
		var pid = $(this).attr("data-alt-pid");
		console.log(msslug, fs, pid)
		showParaImage(fs, msslug, pid);	
});
$(document).on("submit", "#lbp-new-comment-form", function(event){
	alert("TEST")
    event.preventDefault();
    postComment();
});

//end of event bindings

// begin functions


var showParagraphMenu = function(){
	$(this).parent().parent().next('nav.paradiv').toggle("slow");
};

var showBottomWindow = function(){
	event.preventDefault();
	$("div#lbp-bottom-window").show("slow");
};

var hideBottomWindow = function(){
	event.preventDefault();
	$("div#lbp-bottom-window").hide("slow");
};

var expandBottomWindow = function(){
	$("div#lbp-bottom-window").animate({"top": 50, "height": "100%"});
};

var minimizeBottomWindow = function(){
	$("div#lbp-bottom-window").animate({"top": "80%", "height": "20%", "min-height": "20%"});
};

var halfSizeBottomWindow = function(){
	$("div#lbp-bottom-window").animate({"top": "50%", "height": "50%"});
};

//image functions

var showParaImage = function(itemid, msslug, pid){
	showBottomWindow();
	showSpinner("#lbp-bottom-window-container");
	$("#lbp-bottom-window-container").load("/paragraphimage/" + itemid + "/" + msslug + "/" + pid + " #lbp-image-container", function( response, status, xhr) {
  	if ( status == "error" ) {
    	var msg = "Sorry but images for this paragraph are not presently available ";
    	$("#lbp-bottom-window-container").html( msg + "(" + xhr.status + " " + xhr.statusText + ")");
    }
  });
}
// end image functions


// comment functions
var showComments = function(itemid, pid){
	showBottomWindow();
	showSpinner("#lbp-bottom-window-container");
	$("#lbp-bottom-window-container").load("/comments/list/" + itemid + "/" + pid + " #lbp-comments-list-container", function( response, status, xhr) {
  	if ( status == "error" ) {
    	var msg = "Sorry but images for this paragraph are not presently available ";
    	$("#lbp-bottom-window-container").html( msg + "(" + xhr.status + " " + xhr.statusText + ")");
    }
  });
}
var newComment = function(itemid, pid){
	showBottomWindow();
	showSpinner("#lbp-bottom-window-container");
	$("#lbp-bottom-window-container").load("/comments/new/" + itemid + "/" + pid + " #lbp-comment-new-container", function( response, status, xhr) {
  	if ( status == "error" ) {
    	var msg = "Sorry but images for this paragraph are not presently available ";
    	$("#lbp-bottom-window-container").html( msg + "(" + xhr.status + " " + xhr.statusText + ")");
    }
  });
}

var postComment = function(itemid, pid){
	showBottomWindow();

	var form = $("form#lbp-new-comment-form");
	
	var comment_text = form.find("#comment_comment").val(),
	user_id = form.find("#comment_user_id").val(),
	commentaryid = form.find("#comment_commentaryid").val(),
	itemid = form.find("#comment_itemid").val(),
	pid = form.find("#comment_pid").val();
	
	var comment = {comment: comment_text, user_id: user_id, pid: pid, itemid: itemid, commentaryid: commentaryid,}
	$.ajax({
      type: "POST",
      url: "/comments",
      data: { "comment": 
      	{ "comment": comment_text, "user_id": user_id, "pid": pid, "itemid": itemid, "commentaryid": commentaryid} 
      },
      success:function(data, status, xhr){
      	showSpinner("#lbp-bottom-window-container");
        showComments(itemid, pid)
      },
      error:function(data, status, xhr){
      	//I want this error work when a user is not signed in.
      	alert('error');
      	console.log(status);
      	var msg = "Sorry, you need to be logged in to post a comment. <a href='/users/sign_in'>Create one here.</a>";
    	$("#lbp-bottom-window-container").html( msg + "(" + data.status + " " + xhr.statusText + ")");
      }
    });
	}




var showSpinner = function(target){
	$(target).html("<img src='/spiffygif_150x150.gif'><img>");
}