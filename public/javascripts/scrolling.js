// Create scrolling variable if it doesn't exist
if (!Scrolling) var Scrolling = {};

//Scroller constructor
Scrolling.Scroller = function (o, w, h, t) {
  //get the container
  var list = o.getElementsByTagName("div");
  for (var i = 0; i < list.length; i++) {
    if (list[i].className.indexOf("Scroller-Container") > -1) {
      o = list[i];
    }
  }
  
  //private variables
  var self  = this;
  var _vwidth   = w;
  var _vheight  = h;
  var _twidth   = o.offsetWidth
  var _theight  = o.offsetHeight;
  var _hasTween = t ? true : false;
  var _timer, _x, _y;
  
  //public variables
  this.onScrollStart = function (){};
  this.onScrollStop  = function (){};
  this.onScroll      = function (){};
  this.scrollSpeed   = 30;
  
  //private functions
  function setPosition (x, y) {
    if (x < _vwidth - _twidth) 
      x = _vwidth - _twidth;
    if (x > 0) x = 0;
    if (y < _vheight - _theight) 
      y = _vheight - _theight;
    if (y > 0) y = 0;
    
    _x = x;
    _y = y;
    
    o.style.left = _x +"px";
    o.style.top  = _y +"px";
  };
  
  //public functions
  this.scrollBy = function (x, y) { 
    setPosition(_x - x, _y - y);
    this.onScroll();
  };
  
  this.scrollTo = function (x, y) { 
    setPosition(-x, -y);
    this.onScroll();
  };
  
  this.startScroll = function (x, y) {
    this.stopScroll();
    this.onScrollStart();
    _timer = window.setInterval(
      function () { self.scrollBy(x, y); }, this.scrollSpeed
    );
  };
    
  this.stopScroll  = function () { 
    if (_timer) window.clearInterval(_timer);
    this.onScrollStop();
  };
  
  this.reset = function () {
    _twidth  = o.offsetWidth
    _theight = o.offsetHeight;
    _x = 0;
    _y = 0;
    
    o.style.left = "0px";
    o.style.top  = "0px";
    
    if (_hasTween) t.apply(this);
  };
  
  this.swapContent = function (c, w, h) {
    o = c;
    var list = o.getElementsByTagName("div");
    for (var i = 0; i < list.length; i++) {
      if (list[i].className.indexOf("Scroller-Container") > -1) {
        o = list[i];
      }
    }
    
    if (w) _vwidth  = w;
    if (h) _vheight = h;
    reset();
  };
  
  this.getDimensions = function () {
    return {
      vwidth  : _vwidth,
      vheight : _vheight,
      twidth  : _twidth,
      theight : _theight,
      x : -_x, y : -_y
    };
  };
  
  this.getContent = function () {
    return o;
  };
  
  this.reset();
};


function startScroll(ver, hor) {
		if(scroller) scroller.startScroll(ver, hor);
		return true;
}

function stopScroll() {
		if(scroller) scroller.stopScroll();
		return true;
}

function startScrollR(ver, hor) {
		if(scrollerR) scrollerR.startScroll(ver, hor);
		return true;
}

function stopScrollR() {
		if(scrollerR) scrollerR.stopScroll();
		return true;
}