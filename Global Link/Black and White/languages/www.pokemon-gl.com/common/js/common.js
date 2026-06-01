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
