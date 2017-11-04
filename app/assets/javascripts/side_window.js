/////////event bindings related to side window /////////

$(document).on('turbolinks:load', function () {
  // Actions to do

	$(document).ready(function(){

		$("a.js-show-outline").click(function(event){
			event.preventDefault();
			$paragraph = getCurrentViewingParagraph();
			showSideWindow($paragraph);
			var itemid = $(this).attr("data-itemid");
			showOutline(itemid);
		});
		$("a.js-close-side-window").click(function(event){
			event.preventDefault();
			$paragraph = getCurrentViewingParagraph();
			hideSideWindow($paragraph);
		});
		$("a.js-minimize-side-window").click(function(event){
			event.preventDefault();
			$paragraph = getCurrentViewingParagraph();
			minimizeSideWindow($paragraph);
		});
		$("a.js-maximize-side-window").click(function(event){
			event.preventDefault();
			$paragraph = getCurrentViewingParagraph();
			maximizeSideWindow($paragraph);
		});
		$("a.js-show-paragraph-variants").click(function(event){
			event.preventDefault();
			//var itemid = $(this).attr("data-itemid");
			// pid is functioning as expression id here
			var pid = $(this).attr("data-pid");
			$paragraph = $("p#" + pid);
			state.sideWindowContent = "variants";
			showSideWindow($paragraph);
			showParagraphVariants(pid);
		});
		$("a.js-show-paragraph-notes").click(function(event){
			event.preventDefault();
			//var itemid = $(this).attr("data-itemid");
			// pid is functioning as expression id here
			var pid = $(this).attr("data-pid");
			$paragraph = $("p#" + pid);
			state.sideWindowContent = "notes";
			showSideWindow($paragraph);
			showParagraphNotes(pid);
		});
//this biding is redundant because it is bound to the document below
// if uncommented, the function will be called twice producing repeated results
// this could be a problem with above functions as well
		// $("a.js-show-paragraph-info").click(function(event){
		// 	event.preventDefault();
		// 	// var pid here stands for the expression id
		// 	var pid = $(this).attr("data-pid");
		// 	$paragraph = $("p#" + pid);
		// 	showSideWindow($paragraph)
		// 	showParagraphInfo(pid)
		// });

	});
});

///////document event bindings //////////////
$(document).on("mouseover", ".lbp-side-window-variant", function(event){
			event.preventDefault();
			var lem_ref = $(this).attr("data-lem-ref");
			$(this).css({backgroundColor: "yellow"});
			$("span#" + lem_ref).css({backgroundColor: "yellow"});
		});
$(document).on("mouseout", ".lbp-side-window-variant", function(event){
			event.preventDefault();
			var lem_ref = $(this).attr("data-lem-ref");
			$(this).css({backgroundColor: "transparent"});
			$("span#" + lem_ref).css({backgroundColor: "transparent"});
		});
$(document).on("mouseover", ".lbp-side-window-note", function(event){
			event.preventDefault();
			var note = $(this).attr("data-note");
			$(this).css({backgroundColor: "yellow"});
			$("span#" + note).css({backgroundColor: "yellow"});
      $("span[data-corresp=" + note + "]").css({backgroundColor: "yellow"});
		});
$(document).on("mouseout", ".lbp-side-window-note", function(event){
			event.preventDefault();
			var note = $(this).attr("data-note");
			$(this).css({backgroundColor: "transparent"});
			$("span#" + note).css({backgroundColor: "transparent"});
      $("span[data-corresp=" + note + "]").css({backgroundColor: "transparent"});
		});

$(document).on("click", ".js-side-bar-scroll-to-paragraph", function(event){
			event.preventDefault();
			var pid = $(this).attr("data-pid");
			$paragraph = $("p#" + pid);
			scrollToParagraph($paragraph);
		});
$(document).on("click", ".js-show-reference-paragraph", function(event){
			event.preventDefault();
			showSpinner("#lbp-bottom-window-container");
			showBottomWindow();
			halfSizeBottomWindow();
			var url = $(this).attr("data-url");
			var splitArray = url.split("/");
			var shortId = splitArray[splitArray.length-1];
			showParagraphReference(url);

		});
	$(document).on("click", ".js-show-reference-in-compare", function(event){
			event.preventDefault();
			showSpinner("#lbp-bottom-window-container");
			showBottomWindow();
			halfSizeBottomWindow();
			var url = $(this).attr("data-url");
			var splitArray = url.split("/");
			var shortId = splitArray[splitArray.length-1];
			showComparison();
			showSlot(url, 'lbp-text-col-left');
		});
//note redundancy here; copying document ready functions
$(document).on("click", "a.js-show-paragraph-info", function(event){
			event.preventDefault();

			// pid stands for expression short id here
			var pid = $(this).attr("data-pid");
			var view = $(this).attr("data-view");
			var panelSource = "sideWindow";
			//state.setFocus(pid);
			$paragraph = $("p#" + pid);
			if (view === "notes"){
				state.sideWindowContent = view;
				// showSpinner("div#lbp-side-window-container");
				// showSideWindow($paragraph)
				// showParagraphNotes(pid)
			}
			else if (view === "variants"){
				state.sideWindowContent = view;
				// showSpinner("div#lbp-side-window-container");
				// showSideWindow($paragraph)
				// showParagraphVariants(pid)
			}
			else if (view === "compare"){
				panelSource = "bottomWindow";
				// showSpinner("#lbp-bottom-window-container");
				// scrollToParagraph($paragraph);
				// showComparison(pid);
				// if (state.sideWindowVisible){
				// 	if (state.sideWindowContent === "notes"){
				// 		showSpinner("div#lbp-side-window-container");
				// 		showSideWindow($paragraph)
				// 		showParagraphNotes(pid)
				// 	}
				// 	else if (state.sideWindowContent === "variants"){
				// 		console.log("test");
				// 		showSpinner("div#lbp-side-window-container");
				// 		//showSideWindow($paragraph)
				// 		showParagraphVariants(pid)
				// 	}
				// 	else if (state.sideWindowContent === "info"){
				// 		showSpinner("div#lbp-side-window-container");
				// 		showSideWindow($paragraph)
				// 		showParagraphInfo(pid)
				// 	}
				// 	else{
				// 		showSpinner("div#lbp-side-window-container");
				// 		showSideWindow($paragraph)
				// 		showParagraphInfo(pid)
				// 	}
				// }
			}
			else if (view === "info"){
				state.sideWindowVisible = true;
				state.sideWindowContent = "info";
				// showSpinner("div#lbp-side-window-container");
				// showSideWindow($paragraph)
				// showParagraphInfo(pid)
			}
			else{
				state.sideWindowVisible = true;
				state.sideWindowContent = "info";
				// showSpinner("div#lbp-side-window-container");
				// showSideWindow($paragraph)
				// showParagraphInfo(pid)
			}
			var updateTarget = state.panelSync ? "sync" : panelSource;
			changeFocus(pid, updateTarget);
		});
//table of contents onclick scroll to section
$(document).on("click", "div.tocdiv > :first-child", function(event){
			event.preventDefault();
      console.log(this)
			var element_id = $(this).attr("id");
			$element = $("#" + element_id);
			//showSpinner("div#lbp-side-window-container");
			//showSideWindow($element)
			scrollToParagraph($element, true)
      //adjustAnchor(element_id)
		});


///////////FUNCTIONS////////////////////

var scrollToParagraph = function(element, highlight){
  // this is the way of making a default parameter before es6/es2015
  // when this becomes es 6 es2015
  highlight = (typeof highlight !== 'undefined') ?  highlight : false;

  if (highlight){
    element.css({backgroundColor: "yellow"});
    element.animate({backgroundColor: "none"}, 5000);
  }
	if (element.length > 0) {
	    $('html, body')
            .stop()
            .animate({
                scrollTop: element.offset().top - 100
            }, 1000);
   }

}

var getCurrentViewingParagraph = function(){
	var $paragraphs = $('p.plaoulparagraph');
	var viewerMidPoint = $(window).height()/4;
	$paragraph = ($paragraphs.nearest({y: $(window).scrollTop() + viewerMidPoint, x: 0}));
	return $paragraph;
}

var showSideWindow = function(element){
	state.sideWindowVisible = true;
  // this condition helps prevent resizing when the side window is already open
  if ($("div#lbp-side-window").css('display') === 'none'){
    $("div#lbp-text-body").animate({"width": "50%", "margin-left": "45%"}, function(){
  		$("div#lbp-side-window").css("display", "block").promise().done(function(){
  			$("div#lbp-side-window").animate({"width": "40%"}, scrollToParagraph(element));
  		});
  	});
  }
  else {
    $("div#lbp-side-window").css("display", "block").promise().done(function(){
      $("div#lbp-side-window").animate({"width": "40%"}, scrollToParagraph(element));
    });
  }
};

var hideSideWindow = function(element){
	state.sideWindowVisible = false;
	$("li#lbp-max-side-window").css("display", "none").promise().done(function(){
		$("li#lbp-min-side-window").css("display", "block").promise().done(function(){
			$("div#lbp-side-window").animate({"width": "0"}, function(){
				$("div#lbp-side-window").css("display", "none").promise().done(function(){
					$("div#lbp-text-body").css({"margin-left": "auto"}).promise().done(function(){
						$("div#lbp-text-body").css({"width": "60%"}).promise().done(scrollToParagraph(element));
					});
				});
			});
		});
	});
};

var minimizeSideWindow = function(element){

	$("li#lbp-max-side-window").css("display", "block").promise().done(function(){
		$("li#lbp-min-side-window").css("display", "none").promise().done(function(){
			$("div#lbp-side-window").animate({"width": "100px"}, function(){
				$("div#lbp-text-body").css({"margin-left": "auto"}).promise().done(function(){
					$("div#lbp-text-body").css({"width": "60%"}).promise().done(scrollToParagraph(element));
				});
			});
		});
	});
};
var maximizeSideWindow = function(element){
	$("li#lbp-min-side-window").css("display", "block").promise().done(function(){
			$("li#lbp-max-side-window").css("display", "none").removeClass("js-maximize-side-window").promise().done(showSideWindow(element));
		});
};

var showOutline = function(itemid){
	$("#lbp-side-window-container").load("/text/toc/" + itemid + " #lbp-toc-container", function( response, status, xhr) {
		console.log(status);
  	if ( status == "error" ) {
    	var msg = "<h3>Sorry but an outline for this text is not yet available.</h3>";
    	$("#lbp-side-window-container").html( msg);
    		console.log(xhr.status + " " + xhr.statusText);
    }

	});
}

var showParagraphVariants = function(expressionid){
	state.info.then(function(result){
		var content = HandlebarsTemplates['variants'](result);
		$("#lbp-side-window-container").html(content);

		$("#lbp-variants").load("/paragraphs/variants/" + expressionid  + "#lbp-" + expressionid + "-variant-list", function( response, status, xhr) {
		if ( status == "error" ) {
    	var msg = "<h3>Sorry, but there are no variants for this paragraph.</h3>";
    	$("#lbp-variants").html( msg);
    		console.log(xhr.status + " " + xhr.statusText);
    	}
		});
	});
}
var showParagraphNotes = function(expressionid){
	state.info.then(function(result){
		var content = HandlebarsTemplates['notes'](result);
		$("#lbp-side-window-container").html(content);

		$("#lbp-notes").load("/paragraphs/notes/" + expressionid + "#lbp-" + expressionid + "-notes-list", function( response, status, xhr) {
			if ( status == "error" ) {
	    	var msg = "<h3>Sorry, but there are no variants for this paragraph.</h3>";
	    	$("#lbp-notes").html( msg);
	    		console.log(xhr.status + " " + xhr.statusText);
	    }
		});
	});
}

var showParagraphInfo = function(itemid){
	state.info.then(function(result){
		var content = HandlebarsTemplates['textinfo'](result);
		$("#lbp-side-window-container").html(content);
		state.inboxData.then(function(result){
			result["ldp:contains"].forEach(function(r){
				getInboxComment(r["@id"]).then(function(data){
					var comments_tpl = HandlebarsTemplates['ldn-comments'](data);
					$("#ldn-comments").append(comments_tpl);
				});
				getInboxDiscussing(r["@id"]).then(function(data){
					var comments_tpl = HandlebarsTemplates['ldn-discussing'](data);
					$("#ldn-discussions").append(comments_tpl);
				});

		}, function(err){
			console.log(err);
		});

	}, function(err){
		console.log(err);
	});

});
}

var getInboxComment = function(url){
	return promise = new Promise(function(resolve, reject){
		$.get(url, function(ldata){
			if (ldata["motivation"] == "commenting") {
				resolve(ldata);
			}
		});
	});
}
var getInboxDiscussing = function(url){
	return promise = new Promise(function(resolve, reject){
		$.get(url, function(ldata){
			if (ldata["motivation"] == "discussing") {
				resolve(ldata);
			}
		});
	});
}

	//$.get("/text/info/" + itemid, function(data){
		//var inbox = data.inbox
		//var content = HandlebarsTemplates['textinfo'](data);




		// $.get(inbox, function(data){
		//
		// 	data["ldp:contains"].forEach(function(l){
		// 		$.get(l["@id"], function(ldata){
		// 			if (ldata["motivation"] == "commenting") {
		// 				$("#ldn-comments-head").css({"display" : "block"})
		// 				var comments_tpl = HandlebarsTemplates['ldn-comments'](ldata);
		// 				$("#ldn-comments").append(comments_tpl);
		// 			}
		// 			if (ldata["motivation"] == "discussing") {
		// 				$("#ldn-discussions-head").css({"display" : "block"})
		// 				var discussions_tpl = HandlebarsTemplates['ldn-discussing'](ldata);
		// 				$("#ldn-discussions").append(discussions_tpl);
		// 			}
		// 		});
		// 	});
		// });
	//});


var showParagraphReference = function(url){
	$.get("/paragraphs/show2/?url=" + url, function(response, status, xhr){
		if ( status == "error" ) {
    	var msg = "Sorry but something went wrong";
    	$("#lbp-bottom-window-container").html( msg + "(" + xhr.status + " " + xhr.statusText + ")");
    }
		else{
			$("#lbp-bottom-window-container").html("<p><a class='js-show-reference-in-compare' data-url='" + url + "'>View in Compare Mode</a></p>")
			$("#lbp-bottom-window-container").append(response)
		}
  });
}

var getParagraphIdFromNumber = function(n){
	pid = $("span#pn" + n).parent("p").attr("id");
	console.log(pid);
	return pid;
}

var getNextParagraph = function(pid){
	$nextparagraph = $("p#" + pid).next("p")
	return $nextparagraph;
}

var getPreviousParagraph = function(pid){
	$previousparagraph = $("p#" + pid).prev("p")
	return $previousparagraph;
}

var updateSidePanel = function(){
	var content = state.sideWindowContent;
	var eid = state.focus;
	if (state.sideWindowVisible){
		showSpinner("div#lbp-side-window-container");
		$paragraph = $("p#" + eid);
		showSideWindow($paragraph)
		if (content === "variants"){
			showParagraphVariants(eid)
		}
		else if (content === "notes"){
			showParagraphNotes(eid)
		}
		else if (content === "info"){
			showParagraphInfo(eid)
		}
		else
			showParagraphInfo(eid)
		}

}
var updateBottomPanel = function(){
	var content = state.sideWindowContent;
	var eid = state.focus;
	if (state.bottomWindowVisible){
		showSpinner("#lbp-bottom-window-container");
		$paragraph = $("p#" + eid);
		scrollToParagraph($paragraph);
		if (content === "compare"){
			showComparison(eid);
		}
		else{
			showComparison(eid);
		}
	}
}
var changeFocus = function(pid, panelSource){
	state.setFocus(pid);
	if (panelSource === "sync"){
		updateBottomPanel();
		updateSidePanel();
	}
	else if (panelSource === "sideWindow"){
		updateSidePanel();
	}
	else if (panelSource === "bottomWindow"){
		updateBottomPanel();
	}
}
