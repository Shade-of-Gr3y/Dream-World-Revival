
/**
 * Flash Player 10,1,53,64 以降入場可
 * Flash Player 6,0,65 以降 ExpressIntall 表示
 * それ以外は Flash Player 表示
 */

function embedSWF(swfDomain, api_host_name, appversion, locale)
{
	 if (swfobject.hasFlashPlayerVersion("10.1.53.64"))
	 {
		 // 通常
		 var vars1;
		 var vars2;
		 var vars3;
		 
		 var para = location.search;
		 var s = para.split("&");
		 
		 for( var i=0; i < s.length; i++ ) {
			 var v = s[i].split("=");
			 
			 if( v[0] == "?shortcut" || v[0] == "shortcut" ) {
				 vars2 = v[1];
			 }
		 }
		 
		 
		 var flashvars = { shortcut:vars2, v:appversion, locale:locale, api_host_name:api_host_name };
		 var param = {
			 allowFullScreen:"true",
			 allowScriptAccess:"always",
			 menu:"false",
			 transparent:"opaque",
			 scale:"noscale"
		 };
		 var attributes = {id:"content_flash", name:"content_flash"};
		swfobject.embedSWF(
			 "/swf/main.swf?v=" + appversion,
			 "content_flash",
			 "1003",
			 "570",
			 "10.0.2",
			 "/swf/expressInstall.swf",
			 flashvars,
			 param,
			 attributes
		 );
		/*
		var u = navigator.userAgent.toLowerCase();
		var p = navigator.platform.toLowerCase();
		var mac = p ? /mac/.test(p) : /mac/.test(u);
		
		if( mac ){
			swfmacmousewheel.registerObject(attributes.id);
		}
		*/
		$("#console").show();
	 }
	 else if (swfobject.hasFlashPlayerVersion("6.0.65"))
	 {
		 // expressinstall
		 
		 var isIE  = (navigator.appVersion.indexOf("MSIE") != -1) ? true : false;
		 var playerType = (isIE == true) ? "ActiveX" : "PlugIn";
		 var redirectURL = window.location;
		 document.title = document.title.slice(0, 47) + " - Flash Player Installation";
		 var doctitle = document.title;
		 var flashvars = {		
			 MMredirectURL:redirectURL,
			 MMplayerType:playerType,
			 MMdoctitle:doctitle
		 };
		 var param = {
			 allowFullScreen:"true",
			 allowScriptAccess:"always",
			 menu:"false",
			 transparent:"opaque",
			 scale:"noscale"
		 };
		 var attributes = { id:"content_flash", name:"content_flash" };
		 swfobject.embedSWF(
			 "/swf/playerinstall.swf",
			 "content_flash",
			 "1003",
			 "570",
			 "6.0.65",
			 "/swf/expressInstall.swf",
			 flashvars,
			 param,
			 attributes
		 );
	 }
	 else
	 {
		// install flash player
		var alternateContent = '';
		alternateContent += '<div id="flash-download-01"></div>';
		alternateContent += '<div id="flash-download-02"></div>';
		alternateContent += '<div id="flash-download-03">';
		alternateContent += '<a href="http://www.adobe.com/go/getflashplayer_jp" title="Download Flash Player" target="_blank">Flash Player をダウンロード</a>';
		alternateContent += '</div>';
		alternateContent += '<div id="flash-download-04"></div>';
		alternateContent += '<div id="flash-download-05"></div>';
		
		document.getElementById("content_flash").innerHTML = alternateContent;
	}
};