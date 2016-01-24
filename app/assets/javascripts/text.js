
$(document).on('ready page:load', function () {
  // Actions to do

	$(document).ready(function(){
		
		if ($("[data-search]").length && $("[data-searchid]").length) {
			var search = $('[data-search]').attr("data-search");
			var searchid = $('[data-searchid]').attr("data-searchid");
			highlight(search, searchid);
		};

		//events

	  $("span.lbp-paragraphmenu span").click(showParagraphMenu);
		$("a.js-show-para-comment").click(showBottomWindow);
		$("a.js-expand-para-comment").click(expandBottomWindow);
		$("a.js-minimize-para-comment").click(minimizeBottomWindow);
		$("a.js-halfsize-para-comment").click(halfSizeBottomWindow);
		$("a.js-close-para-comment").click(hideBottomWindow);
		
		

		$("a.js-show-para-image-window").click(function(event){
			event.preventDefault();
			showSpinner("#lbp-bottom-window-container");
			showBottomWindow();
			halfSizeBottomWindow();
			
			var msslug = $(this).attr("data-msslug");
			var itemid = $(this).attr("data-itemid");
			var pid = $(this).attr("data-pid");
			showParaImage(itemid, msslug, pid);	
		});

		$("a.js-show-para-image-zoom-window").click(function(event){
			event.preventDefault();
			showSpinner("#lbp-bottom-window-container");
			showBottomWindow();
			halfSizeBottomWindow();
			var itemid = $(this).attr("data-itemid");
			var msslug = $(this).attr("data-msslug");
			var pid = $(this).attr("data-pid");
			showParaZoomImage(itemid, msslug, pid);
		});
		$("a.js-show-folio-image").click(function(event){
			event.preventDefault();
			showSpinner("#lbp-bottom-window-container");
			showBottomWindow();
			halfSizeBottomWindow();
			//var msslug = $(this).attr("data-msslug");
			var canvasid = $(this).attr("data-canvasid");
			
			showFolioImage(canvasid);
		
		});

		$("a.js-view-comments").click(function(event){
			event.preventDefault();
			showSpinner("#lbp-bottom-window-container");
			showBottomWindow();
			halfSizeBottomWindow();
			
			var itemid = $(this).attr("data-itemid");
			var pid = $(this).attr("data-pid");
			showComments(itemid, pid);	
		});
		$("a.js-new-comment").click(function(event){
			event.preventDefault();
			showBottomWindow();
			halfSizeBottomWindow();
			
			var itemid = $(this).attr("data-itemid");
			var pid = $(this).attr("data-pid");
			newComment(itemid, pid);	
		});

		$("a.js-show-item-xml").click(function(event){
			event.preventDefault();
			showSpinner("#lbp-bottom-window-container");
			showBottomWindow();
			expandBottomWindow();
			var itemid = $(this).attr("data-itemid");
			showItemXML(itemid);
		});
		$("a.js-show-paragraph-xml").click(function(event){
			event.preventDefault();
			showSpinner("#lbp-bottom-window-container");
			showBottomWindow();
			halfSizeBottomWindow();
			var itemid = $(this).attr("data-itemid");
			var pid = $(this).attr("data-pid");
			var msslug = $(this).attr("data-msslug");
			showParagraphXML(itemid, pid, msslug);
		});

		
		$("a.js-show-item-info").click(function(event){
			event.preventDefault();
			showSpinner("#lbp-bottom-window-container");
			showBottomWindow();
			expandBottomWindow();
			var itemid = $(this).attr("data-itemid");
			showItemInfo(itemid)
		});

		$("a.js-show-paragraph-collation").click(function(event){
			event.preventDefault();
			showSpinner("#lbp-bottom-window-container");
			showBottomWindow();
			halfSizeBottomWindow();
			var itemid = $(this).attr("data-itemid");
			var pid = $(this).attr("data-pid");
			showParagraphCollation(itemid, pid, "", "");
		});


	});
});

//document binds required for events triggered after ajax load 
$(document).on("click", ".js-show-para-image", function(event){
		event.preventDefault();
		showSpinner("#lbp-bottom-window-container");
		var msslug = $(this).attr("data-msslug");
		var fs = $(this).attr("data-itemid");
		var pid = $(this).attr("data-pid");
		showParaImage(fs, msslug, pid);	
});

$(document).on("click", ".js-show-alt-para-image", function(event){
		event.preventDefault();
		showSpinner("#lbp-bottom-window-container");
		var msslug = $(this).attr("data-msslug");
		var fs = $(this).attr("data-itemid");
		var pid = $(this).attr("data-pid");
		//showParaImage(fs, msslug, pid);	
		showParaZoomImage(fs, msslug, pid)
});



$(document).on("submit", "#lbp-new-comment-form", function(event){
	 event.preventDefault();
    postComment();
});

$(document).on("submit", "#lbp-collation-selector-form", function(event){
	 event.preventDefault();
	 var form = $('#lbp-collation-selector-form');
	 var itemid = form.attr("data-itemid");
	 var pid = form.attr("data-pid");
	 var base = form.find("#base").val();
   var comp = form.find("#comp").val(); 
   showParagraphCollation(itemid, pid, base, comp);
});


//end of event bindings

// begin functions


var showParagraphMenu = function(){
	$(this).parent().parent().next('nav.paradiv').toggle("slow");
};

var showBottomWindow = function(){
	//event.preventDefault();
	$("div#lbp-bottom-window").show("slow");
};

var hideBottomWindow = function(){
	//event.preventDefault();
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
	$("#lbp-bottom-window-container").load("/paragraphimage/" + itemid + "/" + msslug + "/" + pid + " #lbp-image-container", function( response, status, xhr) {
  	if ( status == "error" ) {
    	var msg = "Sorry but images for this paragraph are not presently available ";
    	$("#lbp-bottom-window-container").html( msg + "(" + xhr.status + " " + xhr.statusText + ")");
    }
  });
}
var showParaZoomImage = function(itemid, msslug, pid){
	$("#lbp-bottom-window-container").html("<div id='lbp-para-zoom-container'>");
	var $zoomcontainer = $("div#lbp-para-zoom-container");
	
	//create windows
	var $para_zoom_navbar = $("<div>", {id: 'lbp-para-zoom-navbar'});
	var $para_picture_window = $("<div>", {id: 'lbp-para-picture-window'})
	var $para_text_window = $("<div>", {id: 'lbp-para-text-window'});

	//arrange append order
	$para_zoom_navbar.appendTo($zoomcontainer);
	$para_picture_window.appendTo($zoomcontainer);
	$para_text_window.appendTo($zoomcontainer);
	
	// get text and navbar info
	$.get("/paragraphs/json/" + itemid + "/" + pid + "/" + msslug, function(data){
		//create navbar
		$("<span>", {text: "Paragraph no. " + data.paragraph_number, style: "margin-right: 3px;"}).appendTo($para_zoom_navbar);
		$("<span>", {text: " | Navigate:", style: "margin-right: 3px;"}).appendTo($para_zoom_navbar);
		
		if (data.previous_para != null){
			$("<a>", {text: "Previous", style: "margin-right: 3px;", class: "js-show-alt-para-image", "data-msslug": msslug, "data-pid": data.previous_para, "data-itemid": itemid}).appendTo($para_zoom_navbar);
		}
		
		if (data.next_para != null){
			$("<a>", {text: "Next",  style: "margin-right: 3px;", class: "js-show-alt-para-image", "data-msslug": msslug, "data-pid": data.next_para, "data-itemid": itemid}).appendTo($para_zoom_navbar);
		}
		
		if (data.ms_slugs.length > 1){
			$("<span>", {text: " | Select Another Witness: ", style: "margin-right: 3px;"}).appendTo($para_zoom_navbar);
			$.each(data.ms_slugs, function(k, new_slug){
				$("<a>", {text: new_slug, style: "margin-right: 3px;", class: "js-show-alt-para-image", "data-msslug": new_slug, "data-pid": pid, "data-itemid": itemid}).appendTo($para_zoom_navbar);
			});
		}
		
		//second add paragraph text
		$para_text_window.append("<p id='lbp-paragraph-ms-text'>" + data.paragraph_text + "</p>");
		
	});

	// third: get image
		$.get("/paragraphimage/showzoom/" + itemid + "/" + msslug + "/" + pid, function(data){
			console.log(data);
            var i = 1;
			data.forEach(function(zone){
                console.log("test", zone);
				id = Math.random()
				if (i == 1){
					$("#lbp-para-picture-window").append("<div id='openseadragon-" + id + "' style='width: " + zone.width + "px; height: " + zone.height + "px; margin: auto; padding-bottom: 5px;'></div>")
				}
				else{
					$("#lbp-para-picture-window").append("<div id='openseadragon-" + id + "' style='width: " + zone.width + "px; height: " + zone.height + "px; margin: auto; padding-bottom: 5px;'></div>") 
				}
				showOpenseadragon(id, zone);
				i = i + 1
			});
		});
}
var showFolioImage = function(canvasid){
	$.get("/paragraphimage/showfoliozoom?canvasid="+ canvasid, function(data){
		id = Math.random();
		$("#lbp-bottom-window-container").html("<div id='openseadragon-" + id + "' style='width: 1000px; height: 1400px; margin: auto;'></div>");
		showOpenseadragonFolio(id, data)
	});

}

var showParaAltImage = function(itemid, msslug, pid){
	$.get("/paragraphimage/" + itemid + "/" + msslug + "/" + pid + " #lbp-image-text-container", function(data, status, xhr) {
		if ( status == "error" ) {
    	var msg = "Sorry but images for this paragraph are not presently available ";
    	$("#lbp-bottom-window-container").html( msg + "(" + xhr.status + " " + xhr.statusText + ")");
    }
    else{
     $("#lbp-image-text-container").replaceWith(data);
   	}
	});
}

// end image functions


// comment functions
var showComments = function(itemid, pid){
	$("#lbp-bottom-window-container").load("/comments/list/" + itemid + "/" + pid + " #lbp-comments-list-container", function( response, status, xhr) {
  	if ( status == "error" ) {
    	var msg = "Sorry, but comments for this paragraph are not presently available ";
    	$("#lbp-bottom-window-container").html( msg + "(" + xhr.status + " " + xhr.statusText + ")");
    }
  });
}
var newComment = function(itemid, pid){
	$("#lbp-bottom-window-container").load("/comments/new/" + itemid + "/" + pid + " #lbp-comment-new-container", function( response, status, xhr) {
		
		//apply rich text editor to ajax loaded text_area
		$('.ckeditor').ckeditor({
				height: 200,
				toolbarGroups: [
				{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
 				{ name: 'links' }
				]
			});
  	
  	if ( status == "error" ) {
    	var msg = "Sorry, but posting comments for this paragraph is not presently possible";
    	$("#lbp-bottom-window-container").html( msg + "(" + xhr.status + " " + xhr.statusText + ")");
    }
  });
}

var postComment = function(itemid, pid){
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

//show xml functions for Item and paragraph
var showItemXML = function(itemid){
	$("#lbp-bottom-window-container").load("/text/xml/" + itemid + " #lbp-xml-container", function(response, status, xhr) {
		// this is required to apply style after ajax load
		$("pre.xmlCode").snippet("xml", {style: "bright"});
  	
  	if ( status == "error" ) {
    	var msg = "Sorry but XML for this text is not presently available";
    	$("#lbp-bottom-window-container").html( msg + "(" + xhr.status + " " + xhr.statusText + ")");
    }
  });
}
var showParagraphXML = function(itemid, pid, msslug){
	$("#lbp-bottom-window-container").load("/paragraphs/xml/" + itemid + "/" + pid + "/" + msslug + " #lbp-xml-container", function(response, status, xhr) {
		// this is required to apply style after ajax load
		$("pre.xmlCode").snippet("xml", {style: "bright"});
  	
  	if ( status == "error" ) {
    	var msg = "Sorry but XML for this paragraph is not presently available";
    	$("#lbp-bottom-window-container").html( msg + "(" + xhr.status + " " + xhr.statusText + ")");
    }
  });
}
/// end show xml functions for Item and paragraph

//begin show Info/Statistics
var showItemInfo = function(itemid){
	$("#lbp-bottom-window-container").load("/text/info/" + itemid + " #lbp-info-container", function(response, status, xhr) {
		if ( status == "error" ) {
    	var msg = "Sorry but info and stats for this text is not presently available";
    	$("#lbp-bottom-window-container").html( msg + "(" + xhr.status + " " + xhr.statusText + ")");
    }
  });
}
// paragraph collation functions 
var showParagraphCollation = function(itemid, pid, base, comp){
	$("#lbp-bottom-window-container").load("/paragraphs/collation/" + itemid + "/" + pid + "?base=" + base + "&comp=" + comp, function(response, status, xhr) {

		if ( status == "error" ) {
    	var msg = "Sorry but collation comparison is not currently available for this paragraph";
    	$("#lbp-bottom-window-container").html( msg + "(" + xhr.status + " " + xhr.statusText + ")");
    }
  });
}


//index search funciton
var highlight = function(search, id){
	$("[data-" + search + "='" + id + "']").css({"background-color": "yellow"});
}

//UTILITY FUNCTIONS

var showSpinner = function(target){
	$(target).html("<img style='margin: auto;' src='/spiffygif_150x150.gif'><img>");
}


