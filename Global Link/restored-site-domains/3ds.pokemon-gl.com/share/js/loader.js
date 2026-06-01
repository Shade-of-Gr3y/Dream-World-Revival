
(function () {
	window.PGL = { INFO:{} };
	var envname = location.hostname.replace(/(?:-sp)?\.pokemon-gl\.com$/, '');
	document.write('<script src="/3ds.pokemon-gl.com/share/js/path/' + envname + '.js"></script>');
	
	var getCdnPrefix = (function () {
		var cdnPrefix;
		var f = function () {
			if (!cdnPrefix && PGL && PGL.INFO && PGL.INFO.PATH) {
				cdnPrefix = PGL.INFO.PATH.cmsUploads;
			}
			return cdnPrefix;
		};
		f();
		return f;
	})();
	
	window.loadStyles = function (list) {
		$.each(list, function (index, item) {
			document.write('<link rel="stylesheet" type="text/css" href="' + getCdnPrefix() + item + '"/>');
		});
	};
	window.loadScripts = function (list) {
		$.each(list, function (index, item) {
			document.write('<script src="' + getCdnPrefix() + item + '"></script>');
		});
	};
})();
