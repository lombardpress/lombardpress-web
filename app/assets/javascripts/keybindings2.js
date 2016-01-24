$(document).on('ready page:load', function (){
	// Actions to do
	$(document).ready(function(){

		//NOTE THE REDUNDANCY HERE WITH THE FUNCTION IN SIDE WINDOW
		
		Mousetrap.bind("o", function(){
			$paragraph = getCurrentViewingParagraph();
	    showSideWindow($paragraph);
	    var itemid = $(".js-show-outline").attr("data-itemid");
	    showOutline(itemid);
	  });

	  Mousetrap.bind("option i", function(){
	  	$paragraph = getCurrentViewingParagraph();
			var pid = $paragraph.attr("id");
			var itemid = $(".js-show-outline").attr("data-itemid");
	    showSideWindow($paragraph);
	    showParagraphInfo(itemid, pid);
	  });

	  Mousetrap.bind("option v", function(){
	  	$paragraph = getCurrentViewingParagraph();
			var pid = $paragraph.attr("id");
			var itemid = $(".js-show-outline").attr("data-itemid");
	    showSideWindow($paragraph);
	    showParagraphVariants(itemid, pid);
	  });

	  Mousetrap.bind("option n", function(){
	  	$paragraph = getCurrentViewingParagraph();
			var pid = $paragraph.attr("id");
			var itemid = $(".js-show-outline").attr("data-itemid");
	    showSideWindow($paragraph);
	    showParagraphNotes(itemid, pid);
	  });

	  Mousetrap.bind("option up", function(){
	  	_this = $("#lbp-previous-paragraph")
	  	var itemid = $(_this).attr("data-itemid");
			var pid = $(_this).attr("data-pid");
			$paragraph = $("p#" + pid);
			showSideWindow($paragraph)
			showParagraphInfo(itemid, pid)
		});

		Mousetrap.bind("option down", function(){
			_this = $("#lbp-next-paragraph")
	  	var itemid = $(_this).attr("data-itemid");
			var pid = $(_this).attr("data-pid");
			$paragraph = $("p#" + pid);
			showSideWindow($paragraph)
			showParagraphInfo(itemid, pid)
		});

		Mousetrap.bind("option m", function(){
			$paragraph = getCurrentViewingParagraph();
			var $imagelink = $paragraph.parent("div").find(".js-show-para-image-zoom-window");
			var itemid = $imagelink.attr("data-itemid");
			var msslug = $imagelink.attr("data-msslug");
			var pid = $imagelink.attr("data-pid");
			showSpinner("#lbp-bottom-window-container");
			showBottomWindow();
			halfSizeBottomWindow();
			showParaZoomImage(itemid, msslug, pid);
		});

  });
});