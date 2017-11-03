$(document).on('turbolinks:load', function () {
	$(document).ready(function(){
    //var url = "https://dll-review-registry.herokuapp.com/reviews/c9f73c2c-1c1f-4e91-abb5-2e08c961cb4a.json"
    $("td[data-review-url]").each(function(index){
      var url = $(this).attr("data-review-url")
      var html_url = url.replace(".json", ".html")
      if (url){
        $.get(url, function(data){
          var img_url = data["review-metadata"]["badge-url"]
          $("td[data-review-url='" + url + "']").append("<a class='badge-img' href='"+ html_url +"' target='_blank'><img src='" + img_url + "'/></a>");
          $("td[data-review-url='" + url + "']").children("a").hide().show("slow");
        });
      }

    });
		$("div#lbp-review-display").each(function(index){
      var fileUrl = $(this).attr("data-file-url")
			var reviewUrl = "http://localhost:4567/api/v1/reviews/?url=" + fileUrl + "?society=MAA"

			$.get(reviewUrl, function(data){
				if (data.length > 0){
	        var img_url = data[0]["badge-url"];
					var reviewid = data[0]["id"];
					var html_link = "http://localhost:4567/reviews/" + reviewid + ".html";
					var rubric_link = data[0]["badge-rubric"];
					var summary = data[0]["review-summary"];
	        $("div#lbp-review-display").append("<p>Reviews:</p> <div><a class='badge-img' href='"+ html_link +"' target='_blank'><img src='" + img_url + "'/></a></div>");
				}
			});


    });

  });
});
