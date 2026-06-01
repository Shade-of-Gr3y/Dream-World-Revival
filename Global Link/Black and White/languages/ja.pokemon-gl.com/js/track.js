var TRACKER_CODE = "UA-17682532-1";

function isTrack(){
	var loc = window.location.hostname;
	var track = false;
	var r = new RegExp("^.+\.pokemon-gl\.com$");
	if(loc == "stg.pokemon-gl.com") {
	} else if(loc == "test.pokemon-gl.com") {
	} else if(r.test(loc)){
		track = true;
	}
	return track;
}

function track(){
	  var _gaq = _gaq || [];
	  _gaq.push(['_setAccount', TRACKER_CODE]);
	  _gaq.push(['_setDomainName', '.pokemon-gl.com']);
	  _gaq.push(['_trackPageview']);
	
	  (function() {
	    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
	    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
	    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	  })();
}
