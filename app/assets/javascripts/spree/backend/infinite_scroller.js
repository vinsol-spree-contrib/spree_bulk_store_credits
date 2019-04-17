function InfiniteScroller(options){
  this.$infiniteScroll = options.$infiniteScroll
  this.windowHeight = $(window).height();
  this.documentHeight = $(document).height();
}

InfiniteScroller.prototype.init = function(){
  var _this = this;
  if(this.$infiniteScroll.length > 0){
    this.enable();
  }
};

InfiniteScroller.prototype.enable = function(){
  this.timer = null,
      _this = this;

  //if no vertical scrollbar present
  if(this.windowHeight >= this.documentHeight){
    this.makeDelayedRequest();
  }

  //when scrolled
  $(window).scroll(function() {
    _this.makeDelayedRequest(); 
  });
  
};

InfiniteScroller.prototype.makeDelayedRequest = function(){
  var _this = this;

  if(this.timer) {
    window.clearTimeout(this.timer);
  }

  this.timer = window.setTimeout(function() {
    _this.fetchMoreCollections();
  }, 500);
};

InfiniteScroller.prototype.fetchMoreCollections = function(){
    var more_collections_url = this.$infiniteScroll.find('[data-pagination="on"] .pagination .next a').attr('href');
    if(more_collections_url && ($(window).scrollTop() >= (this.documentHeight - this.windowHeight))){
      $.getScript(more_collections_url);
    }
};

$(function(){
  var infiniteScrollerArguments = { $infiniteScroll: $('#infinite-scroll') },
      infiniteScroller = new InfiniteScroller(infiniteScrollerArguments);

  infiniteScroller.init();
});
