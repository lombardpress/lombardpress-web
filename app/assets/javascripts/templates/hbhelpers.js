Handlebars.registerHelper("date", function(){
  var date = moment().format("LL");
  console.log("date", date);
  return date
});
