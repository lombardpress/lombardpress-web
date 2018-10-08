$(document).on('turbolinks:load', function () {
  // Actions to do
	$(document).ready(function(){

		$("p.plaoulparagraph").click(function(){
			var focus = $(this).attr("id");
			state.setFocus(focus);
			state.info.then(function(result){
				console.log(result);
			}, function(err){
				console.log(err);
			});
		});



		if ($("[data-search]").length && $("[data-searchid]").length) {
			var search = $('[data-search]').attr("data-search");
			var searchid = $('[data-searchid]').attr("data-searchid");
			highlight(search, searchid);
		}

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
			var pid = $(this).attr("data-pid");
			var $paragraph = $("p#" + pid);
			showBottomWindow($paragraph);
			halfSizeBottomWindow();
			var msslug = $(this).attr("data-msslug");
			var itemid = $(this).attr("data-itemid");
			showParaImage(itemid, msslug, pid);
		});

		$("a.js-show-para-image-zoom-window").click(function(event){
			event.preventDefault();
			var expressionid = $(this).attr("data-expressionid");
			var msslug = $(this).attr("data-msslug");
			var $paragraph = $("p#" + expressionid);
			showSpinner("#lbp-bottom-window-container");

			showBottomWindow($paragraph);
			halfSizeBottomWindow();

			showParaZoomImage(expressionid, msslug);
		});
    /* commented out because this seems to be handled by the document on function
		$("a.js-show-folio-image").click(function(event){
			event.preventDefault();
			showSpinner("#lbp-bottom-window-container");
			showBottomWindow();
			halfSizeBottomWindow();
			var expressionid = $(this).attr("data-expressionid");
			var canvasid = $(this).attr("data-canvasid");
			var surfaceid = $(this).attr("data-surfaceid");

			showFolioImage(canvasid, expressionid, surfaceid);

		});
    */

		$("a.js-view-comments").click(function(event){
			event.preventDefault();
			var itemid = $(this).attr("data-itemid");
			var pid = $(this).attr("data-pid");
			var $paragraph = $("p#" + pid);
			showSpinner("#lbp-bottom-window-container");
			showBottomWindow($paragraph);
			halfSizeBottomWindow();
			showComments(itemid, pid);
		});
		$("a.js-new-comment").click(function(event){
			event.preventDefault();
			var itemid = $(this).attr("data-itemid");
			var pid = $(this).attr("data-pid");
			var $paragraph = $("p#" + pid);
			showBottomWindow($paragraph);
			halfSizeBottomWindow();
			newComment(itemid, pid);
		});

		$("a.js-show-item-xml").click(function(event){
			event.preventDefault();
			showSpinner("#lbp-bottom-window-container");
			showBottomWindow();
			expandBottomWindow();
			var itemid = $(this).attr("data-itemid");
			var manifestationid = $(this).attr("data-manifestation-id"); //? $(this).attr("data-manifestation-id") : null;
			var transcriptionid = $(this).attr("data-transcription-id"); //? $(this).attr("data-transcription-id") : null;
			showItemXML(itemid, manifestationid, transcriptionid);
		});
		$("a.js-show-paragraph-xml").click(function(event){
			event.preventDefault();
			var itemid = $(this).attr("data-itemid");
			var pid = $(this).attr("data-pid");
			var msslug = $(this).attr("data-msslug");
			var $paragraph = $("p#" + pid);
			showSpinner("#lbp-bottom-window-container");
			showBottomWindow($paragraph);
			halfSizeBottomWindow();
			showParagraphXML(itemid, pid, msslug);
		});


		$("a.js-show-item-info").click(function(event){
			event.preventDefault();
			showSpinner("#lbp-bottom-window-container");
			showBottomWindow();
			expandBottomWindow();
			var itemid = $(this).attr("data-itemid");
			showItemInfo(itemid);
		});

		$("a.js-show-paragraph-collation").click(function(event){
			event.preventDefault();
			showSpinner("#lbp-bottom-window-container");
			showBottomWindow();
			halfSizeBottomWindow();
			var expressionid = $(this).attr("data-itemid");
			showParagraphCollation(expressionid, "", "");
		});
		$("a.js-show-paragraph-comparison").click(function(event){
			event.preventDefault();
			showSpinner("#lbp-bottom-window-container");
			var pid = $(this).attr("data-itemid");
			$paragraph = $("p#" + pid);
			showBottomWindow($paragraph);
			halfSizeBottomWindow();
			var expressionid = $(this).attr("data-itemid");
			changeFocus(expressionid, "bottomWindow");
			//showComparison(expressionid);
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
		var expressionid = $(this).attr("data-expressionid");
		//showParaImage(fs, msslug, pid);
		showParaZoomImage(expressionid, msslug);
});



$(document).on("submit", "#lbp-new-comment-form", function(event){
	 event.preventDefault();
	 postComment();
});

$(document).on("submit", "#lbp-collation-selector-form", function(event){
	 event.preventDefault();
	 var form = $('#lbp-collation-selector-form');
	 var expressionid = form.attr("data-expressionid");
	 var base = form.find("#base").val();
   var comp = form.find("#comp").val();
   showParagraphCollation(expressionid, base, comp);
});

$(document).on("click", ".js-show-folio-image", function(event){
	event.preventDefault();
	var expressionid = $(this).attr("data-expressionid");
	var canvasid = $(this).attr("data-canvasid");
	var surfaceid = $(this).attr("data-surfaceid");
	var isurfaceid = $(this).attr("data-isurfaceid");
	showSpinner("#lbp-bottom-window-container");
	showBottomWindow();
	//halfSizeBottomWindow();

	showFolioImage(canvasid, expressionid, surfaceid, isurfaceid);
});

//TODO: consider making this a generic .js-close that can be resued for any close function
$(document).on("click", ".close", function(event){
	event.preventDefault();
	$(this).parent().css({"display": "none"});

});
$(document).on("click", ".js-show-comparison-text", function(event){
	event.preventDefault();
	var url = $(this).attr("data-url");
	var slot = $(this).closest(".lbp-text-col").attr("id");
	console.log(slot);
	showComparisonText(url, slot);
});

$(document).on("click", ".js-show-slot", function(event){
	event.preventDefault();
	var url = $(this).attr("data-url");
	var slot = $(this).closest(".lbp-text-col").attr("id");
	showSlot(url, slot);
});

$(document).on("click", ".js-toggle-scroll-lock", function(event){
	event.preventDefault();
	if ($(this).hasClass("locked")){
		unlockBodyScroll();
		$(this).html("Lock Scroll");
		$(this).toggleClass("locked");
	}
	else{
		lockBodyScroll();
		$(this).html("Unlock Scroll");
		$(this).toggleClass("locked");

	}
});
$(document).on("click", ".js-toggle-sync", function(event){
	event.preventDefault();
	state.panelSync = !state.panelSync;
	if (state.panelSync){
		$("a.js-toggle-sync").html("Unsync Panels");
	}
	else{
		$("a.js-toggle-sync").html("Sync Panels");
	}
});
//end of event bindings

// begin functions

var showParagraphMenu = function(){
	$(this).parent().parent().next('nav.paradiv').toggle("slow");
};

var showBottomWindow = function(element){
	//event.preventDefault();
	state.bottomWindowVisible = true;
	$("div#lbp-bottom-window").show("slow");
	if (element){
		scrollToParagraph(element);
	}
};

var lockBodyScroll = function(){
	$("body").addClass("noScroll");
};
var unlockBodyScroll = function(){
	$("body").removeClass("noScroll");
};

var hideBottomWindow = function(){
	//event.preventDefault();
	state.bottomWindowVisible = false;
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
};
var showParaZoomImage = function(expressionid, msslug){
	$("#lbp-bottom-window-container").html("<div id='lbp-para-zoom-container'>");
	var $zoomcontainer = $("div#lbp-para-zoom-container");

	//create windows
	var $para_zoom_navbar = $("<div>", {id: 'lbp-para-zoom-navbar'});
	var $para_picture_window = $("<div>", {id: 'lbp-para-picture-window'});
	var $para_text_window = $("<div>", {id: 'lbp-para-text-window'});

	//arrange append order
	$para_zoom_navbar.appendTo($zoomcontainer);
	$para_picture_window.appendTo($zoomcontainer);
	$para_text_window.appendTo($zoomcontainer);

	// get text and navbar info
	$.get("/paragraphs/json/" + expressionid + "/" + msslug, function(data){
		//create navbar
		$("<span>", {text: "Paragraph no. " + data.paragraph_number, style: "margin-right: 3px;"}).appendTo($para_zoom_navbar);
		$("<span>", {text: " | Navigate:", style: "margin-right: 3px;"}).appendTo($para_zoom_navbar);

		if (data.previous_para !== null){
			$("<a>", {text: "Previous", style: "margin-right: 3px;", class: "js-show-alt-para-image", "data-msslug": msslug, "data-expressionid": data.previous_para}).appendTo($para_zoom_navbar);
		}

		if (data.next_para !== null){
			$("<a>", {text: "Next",  style: "margin-right: 3px;", class: "js-show-alt-para-image", "data-msslug": msslug, "data-expressionid": data.next_para}).appendTo($para_zoom_navbar);
		}

		if (data.ms_slugs.length > 1){
			$("<span>", {text: " | Select Another Witness: ", style: "margin-right: 3px;"}).appendTo($para_zoom_navbar);
			$.each(data.ms_slugs, function(k, new_slug){
				$("<a>", {text: new_slug, style: "margin-right: 3px;", class: "js-show-alt-para-image", "data-msslug": new_slug, "data-expressionid": expressionid}).appendTo($para_zoom_navbar);
			});
		}

		//second add paragraph text
		$para_text_window.append("<p id='lbp-paragraph-ms-text'>" + data.paragraph_text + "</p>");

	});

	// third: get image
		$.get("/paragraphimage/showzoom/" + expressionid + "/" + msslug, function(data){
			if (data.length === 0){
        $("#lbp-para-picture-window").append("<div style='width: 300px; margin: auto; padding: 5px; background-color: #d8d6d6; '><p>Apologies for the inconvenice. This image is not yet available either because it is not yet <a href='http://iiif.io'>IIIF</a> compliant or we have not yet collected coordinates for this text region.</p></div>");
      }
      var i = 1;
			data.forEach(function(zone){
                console.log("test", zone);
				id = Math.random();
				if (i == 1){
					$("#lbp-para-picture-window").append("<div id='openseadragon-" + id + "' style='width: " + zone.width + "px; height: " + zone.height + "px; margin: auto; padding-bottom: 5px;'></div>");
				}
				else{
					$("#lbp-para-picture-window").append("<div id='openseadragon-" + id + "' style='width: " + zone.width + "px; height: " + zone.height + "px; margin: auto; padding-bottom: 5px;'></div>");
				}
				showOpenseadragon(id, zone);
				i = i + 1;
			});
		});
};
var showFolioImage = function(canvasid, expressionid, surfaceid, isurfaceid){
	$.ajax({
    url: "/paragraphimage/showfoliozoom?canvasid="+ canvasid + "&expressionid=" + expressionid + "&surfaceid=" + surfaceid,
    type: 'get',
    error: function(XMLHttpRequest, textStatus, errorThrown){
      $("#lbp-bottom-window-container").html("<div><p>Apologies for the inconvenience. This image is not yet <a href='http://iiif.io'>IIIF</a> compliant. When it becomes available via <a href='http://iiif.io'>IIIF</a>, it will be visible here.</div>");
        console.log('status:' + XMLHttpRequest.status + ', status text: ' + XMLHttpRequest.statusText);
    },
    success: function(data){
			console.log(isurfaceid);
			var index = 0
			if (isurfaceid){
				index = data.findIndex(function(entry){
					console.log(entry.isurface_shortid === isurfaceid)
					return entry.isurface_shortid === isurfaceid
				});
			}
			else {
				index = 0
			}

			function insertNext(data){
				if (data.next_shortid !== null){
				return	"<a class='js-show-folio-image' data-surfaceid='" + data[0].next_shortid + "'>Next</a>";
				}
				else {
					return "";
				}
			}
			function insertPrev(data){
				if (data.previous_shortid !== null){
					return	"<a class='js-show-folio-image' data-surfaceid='" + data[0].previous_shortid + "'>Previous</a>";
				}
				else {
					return "";
				}
			}

			$("#lbp-bottom-window-container").html("<div id='folio-nav' style='text-align: center;'>" + insertPrev(data) + " | " + data[0].surfaceTitle + " | " + insertNext(data) + "<div id='isurfaces'></div></div>");
			if (data.length > 1){
				for (i = 0; i < data.length; i++){
					$("#isurfaces").append("<a class='js-show-folio-image' data-surfaceid='" + data[i].current_shortid + "' data-isurfaceid='" + data[i].isurface_shortid + "'>" + data[i].icodexTitle + ":" + data[i].isurfaceTitle + "</a> ");
				}
			}
			loadOpenSeaDragonFolio(data[index])

    }
	});

};

var loadOpenSeaDragonFolio = function(data){
		id = Math.random();
		var height = data.c_height;
		var width = data.c_width;
		var newHeight = 1170 / width * height;
		$("#lbp-bottom-window-container").append("<div id='openseadragon-" + id + "' style='width: 1170;  height: " + newHeight + "px; margin: auto;'></div>");
		showOpenseadragonFolio(id, data);
};



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
};

// end image functions


// comment functions
var showComments = function(itemid, pid){
	$("#lbp-bottom-window-container").load("/comments/list/" + itemid + "/" + pid + " #lbp-comments-list-container", function( response, status, xhr) {
  	if ( status == "error" ) {
    	var msg = "Sorry, but comments for this paragraph are not presently available. Make sure you've created and account and have logged in.";
    	$("#lbp-bottom-window-container").html( msg + "(" + xhr.status + " " + xhr.statusText + ")");
    }
  });
};
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
    	var msg = "Sorry, you need to be logged in to leave a comment.";
    	$("#lbp-bottom-window-container").html( msg + "(" + xhr.status + " " + xhr.statusText + ")");
    }
  });
};

var postComment = function(itemid, pid){
	var form = $("form#lbp-new-comment-form");

	var comment_text = form.find("#comment_comment").val(),
	user_id = form.find("#comment_user_id").val(),
	commentaryid = form.find("#comment_commentaryid").val(),
	itemid = form.find("#comment_itemid").val(),
	access_type = form.find("#comment_access_type").val(),
	pid = form.find("#comment_pid").val();

	var comment = {comment: comment_text, user_id: user_id, pid: pid, itemid: itemid, commentaryid: commentaryid, access_type: access_type};
	$.ajax({
      type: "POST",
      url: "/comments",
      data: { "comment":
      	{ "comment": comment_text, "user_id": user_id, "pid": pid, "itemid": itemid, "commentaryid": commentaryid, "access_type": access_type}
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
var showItemXML = function(itemid, manifestationid, transcriptionid){

	var parameters = itemid;
	if (manifestationid){
		parameters = parameters + "/" + manifestationid;
	}
	if (transcriptionid){
		parameters = parameters + "/" + transcriptionid
	}
	$("#lbp-bottom-window-container").load("/text/xml/" + parameters + " #lbp-xml-container", function(response, status, xhr) {
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
var showParagraphCollation = function(expressionid, base, comp){
	$("#lbp-bottom-window-container").load("/paragraphs/collation/" + expressionid + "?base=" + base + "&comp=" + comp, function(response, status, xhr) {

		if ( status == "error" ) {
    	var msg = "Sorry but collation comparison is not currently available for this paragraph";
    	$("#lbp-bottom-window-container").html( msg + "(" + xhr.status + " " + xhr.statusText + ")");
    }
  });
}
//paragraph comparision
var showComparison = function(){
	state.info.then(function(result){
		state.getRecommended().then((result2) => {

		result["recommended"] = result2

		var content = HandlebarsTemplates['manifestation_transcription_list'](result);
		var slot = HandlebarsTemplates['slot'](result);
		$("#lbp-bottom-window-container").html(content);
		$("#lbp-text-col-left").html(slot);
		$("#lbp-text-col-right").html(slot);
		});
	});
	//
	// $.get("/text/info/" + expressionid, function(data, status, xhr) {
	// 	if ( status == "error" ) {
  //   	var msg = "Sorry but this view is not currently available for this paragraph";
  //   	$("#lbp-bottom-window-container").html( msg + "(" + xhr.status + " " + xhr.statusText + ")");
  //   }
	// 	else{
	// 		var content = HandlebarsTemplates['manifestation_transcription_list']();
	// 		var slot = HandlebarsTemplates['slot'](data);
	// 		$("#lbp-bottom-window-container").html(content);
	// 		$("#lbp-text-col-left").html(slot);
	// 		$("#lbp-text-col-right").html(slot);
	// 	}
  // });
};

var showSlot = function(url, slot){
	var expressionid = url.split("/resource/")[1];
	showSpinner("#" + slot);

	$.get("/text/info/" + expressionid, function(data, status, xhr) {
		if ( status == "error" ) {
    	var msg = "Sorry but this view is not currently available for this paragraph";
    	$("#lbp-bottom-window-container").html( msg + "(" + xhr.status + " " + xhr.statusText + ")");
    }
		else{
			$.get("http://localhost:3737/view/" + expressionid + "/5/json", (data2) =>{
				data["recommended"] = data2
				var slotTpl = HandlebarsTemplates['slot'](data);
				$("#" + slot).html(slotTpl);
			});
		}
  });

};

var showComparisonText = function(url, slot){
	var $textWindowWrapper = $("#" + slot).find(".lbp-compare-text-wrapper");
	var $textWindow = $textWindowWrapper.find(".lbp-compare-text");
	showSpinner("#" + slot + " .lbp-compare-text-wrapper .lbp-compare-text");
	$textWindowWrapper.css({"display": "block"});
	$.get("/paragraphs/show2/?url=" + url, function(data, status, xhr){

		if ( status == "error" ) {
			var msg = "Sorry but something went wrong";
			$textWindow.html( msg + "(" + xhr.status + " " + xhr.statusText + ")");
		}
		else{
			$textWindow.html(data);
		}
	});
};


//index search funciton
var highlight = function(search, id){
	$("[data-" + search + "='" + id + "']").css({"background-color": "yellow"});
};

//UTILITY FUNCTIONS

var showSpinner = function(target){
	$(target).html("<img style='margin: auto;' src='/spiffygif_150x150.gif'><img>");
};
