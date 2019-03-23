$(document).on('turbolinks:load', function () {
  $(document).ready(function(){
    $("#version-wrapper-title").click(function(){
      $("#version-list").slideToggle();
    });
  });
});
