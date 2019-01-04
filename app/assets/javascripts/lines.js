$(document).on('turbolinks:load', function () {
  // Actions to do
  $(document).ready(function(){
    $(".lbp-line-number").click(function(){

      if ($(this).hasClass("remove")){
        $(this).children("div").remove();
        $(this).removeClass("remove")
      }
      else{
      var lineNumber = $(this).attr("data-ln")
      console.log("lineNumber", lineNumber);
      var targetSurface = "L" + $(this).attr("data-pb").replace(/-/ig, "");
      var targetCodex = "lon"
      showLine(this, lineNumber, targetSurface, targetCodex)
      $(this).addClass("remove")
    }
    });
    $("#lbp-show-all-lines").click(function(){
      $(".lbp-line-number").each(function(line){
        var lineNumber = $(this).attr("data-ln")
        console.log("lineNumber", lineNumber);
        var targetSurface = "L" + $(this).attr("data-pb").replace(/-/ig, "");
        var targetCodex = "lon"
        showLine(this, lineNumber, targetSurface, targetCodex)
        $(this).addClass("remove")
      });
    });
  });
});

function showLine(target, line, surface, codex){
  $.getJSON( "http://127.0.0.1:8080/converted/" + surface + ".json" , function( data ){
    console.log(data)
    const item  = data.find(function(i) {
      console.log("i", i)
      if (i.id === "r1l" + line){
      return i
    }
    });
    $(target).append("<div><img src='https://loris2.scta.info/" + codex + "/" + surface  + ".jpg/" + item["iiif-adjusted"] + "/pct:50/0/default.jpg'/></div>")
  });
}
