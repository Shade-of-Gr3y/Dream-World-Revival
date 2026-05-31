var _____WB$wombat$assign$function_____=function(name){return (self._wb_wombat && self._wb_wombat.local_init && self._wb_wombat.local_init(name))||self[name];};if(!self.__WB_pmw){self.__WB_pmw=function(obj){this.__WB_source=obj;return this;}}{
let window = _____WB$wombat$assign$function_____("window");
let self = _____WB$wombat$assign$function_____("self");
let document = _____WB$wombat$assign$function_____("document");
let location = _____WB$wombat$assign$function_____("location");
let top = _____WB$wombat$assign$function_____("top");
let parent = _____WB$wombat$assign$function_____("parent");
let frames = _____WB$wombat$assign$function_____("frames");
let opens = _____WB$wombat$assign$function_____("opens");
$(function(){
	
	var ua = navigator.userAgent;
	if(ua.indexOf("iPhone")!=-1||ua.indexOf("Android")!=-1){
		location.href = 'sp/';
	}
	
  var envname = location.hostname.replace(/(?:-sp)?\.pokemon-gl\.com$/, '');
	$('<script src="common/js/path/' + envname + '.js"></script>').prependTo(document.body);
	
	$('.btnLink').on('click', function () {
		var options = { expires:365, path:'/' };
		if (/\.pokemon-gl\.com$/.test(location.hostname)) {
			options.domain = 'pokemon-gl.com';
		}
		$.each($(this).data(), function (key, value) {
			$.cookie(key, value, options);
		});
		location = INFO_PATH.pc;
	});
});

}

/*
     FILE ARCHIVED ON 18:26:18 Oct 18, 2013 AND RETRIEVED FROM THE
     INTERNET ARCHIVE ON 01:25:11 May 31, 2026.
     JAVASCRIPT APPENDED BY WAYBACK MACHINE, COPYRIGHT INTERNET ARCHIVE.

     ALL OTHER CONTENT MAY ALSO BE PROTECTED BY COPYRIGHT (17 U.S.C.
     SECTION 108(a)(3)).
*/
/*
playback timings (ms):
  captures_list: 0.636
  exclusion.robots: 0.03
  exclusion.robots.policy: 0.023
  esindex: 0.005
  cdx.remote: 67.764
  LoadShardBlock: 245.253 (3)
  PetaboxLoader3.datanode: 565.595 (4)
  PetaboxLoader3.resolve: 187.662 (2)
  load_resource: 515.227
*/