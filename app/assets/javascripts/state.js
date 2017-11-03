
function State(){
  this.dataFileUrl = null;
  this.reviewInfo = null;
  this.itemid = null;
  this.focus = null;
  this.info = null;
  this.comments = null;
}

State.prototype = {
  setFocus: function(focus) {
    this.focus = focus;
    this.info = this.getInfo();
    this.inboxData = this.getInboxData();
  },
  setDataFileUrl(url){
    this.dataFileUrl = url;
    this.reviewInfo = this.getReviewInfo(url);
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
  },
  getReviewInfo: function(){
    var dataFileUrl = this.dataFileUrl
    var reviewUrl = "http://dll-review-registry.scta.info/api/v1/reviews/?url=" + dataFileUrl + "?society=MAA"
    return promise = new Promise(function(resolve, reject){
      $.get(reviewUrl, function(data){
        var reviewObject = {}
        if (data.length > 0){
          reviewObject = {
            img_url: data[0]["badge-url"],
            reviewid: data[0]["id"],
            ipfsHash: data[0]["ipfs-hash"],
            html_link: "http://dll-review-registry.scta.info/reviews/" + data[0]["id"] + ".html",
            rubric_link: data[0]["badge-rubric"],
            summary: data[0]["review-summary"]
          }
          resolve(reviewObject);
        }
      });
    });
  }
}

var state = new State();
