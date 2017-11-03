
function State(){
  this.focus = "test";
  this.info = "notset";
  this.comments = "notset";
}
State.prototype = {
  setFocus: function(focus) {
    this.focus = focus;
    this.info = this.getInfo();
    this.inboxData = this.getInboxData();
  },
  getInfo: function(){
    var itemid = this.focus;
    return promise = new Promise(function(resolve, reject){
      $.get("/text/info/" + itemid, function(data){
        resolve(data);
    	});
    })
  },
  getInboxData: function(){
    var _this = this;
    return promise = new Promise(function(resolve, reject){
      _this.info.then(function(result){
        var inbox = result.inbox;
        $.get(inbox, function(data){
          resolve(data);
  		  });
      });
    });
  }
}

var state = new State();
