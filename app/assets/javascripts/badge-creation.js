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
  });
});
