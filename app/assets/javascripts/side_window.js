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
			showSideWindow($paragraph);
			showParagraphVariants(pid);
		});
		$("a.js-show-paragraph-notes").click(function(event){
			event.preventDefault();
			//var itemid = $(this).attr("data-itemid");
			// pid is functioning as expression id here
			var pid = $(this).attr("data-pid");
			$paragraph = $("p#" + pid);
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
			showParagraphReference(url);
		});
//note redundancy here; copying document ready functions
$(document).on("click", "a.js-show-paragraph-info", function(event){
			event.preventDefault();
			// pid stands for expression short id here
			var pid = $(this).attr("data-pid");
			$paragraph = $("p#" + pid);
			showSpinner("div#lbp-side-window-container");
			showSideWindow($paragraph)
			showParagraphInfo(pid)
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
	$("#lbp-side-window-container").load("/paragraphs/variants/" + expressionid  + "#lbp-" + expressionid + "-variant-list", function( response, status, xhr) {
		console.log(status);
  	if ( status == "error" ) {
    	var msg = "<h3>Sorry, but there are no variants for this paragraph.</h3>";
    	$("#lbp-side-window-container").html( msg);
    		console.log(xhr.status + " " + xhr.statusText);
    }
	});
}
var showParagraphNotes = function(expressionid){
	$("#lbp-side-window-container").load("/paragraphs/notes/" + expressionid + "#lbp-" + expressionid + "-notes-list", function( response, status, xhr) {
		console.log(status);
  	if ( status == "error" ) {
    	var msg = "<h3>Sorry, but there are no variants for this paragraph.</h3>";
    	$("#lbp-side-window-container").html( msg);
    		console.log(xhr.status + " " + xhr.statusText);
    }
	});
}

var showParagraphInfo = function(itemid){
	$.get("/text/info/" + itemid, function(data){
		var inbox = data.inbox
		var content = HandlebarsTemplates['textinfo'](data);
		$("#lbp-side-window-container").html(content);

		$.get(inbox, function(data){

			data["ldp:contains"].forEach(function(l){
				$.get(l["@id"], function(ldata){
					if (ldata["motivation"] == "commenting") {
						$("#ldn-comments-head").css({"display" : "block"})
						var comments_tpl = HandlebarsTemplates['ldn-comments'](ldata);
						$("#ldn-comments").append(comments_tpl);
					}
					if (ldata["motivation"] == "discussing") {
						$("#ldn-discussions-head").css({"display" : "block"})
						var discussions_tpl = HandlebarsTemplates['ldn-discussing'](ldata);
						$("#ldn-discussions").append(discussions_tpl);
					}
				});
			});
		});
	});

}
var showParagraphReference = function(url){
	$("#lbp-bottom-window-container").load("/paragraphs/show2/?url=" + url, function(response, status, xhr){
		if ( status == "error" ) {
    	var msg = "Sorry but something went wrong";
    	$("#lbp-bottom-window-container").html( msg + "(" + xhr.status + " " + xhr.statusText + ")");
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
