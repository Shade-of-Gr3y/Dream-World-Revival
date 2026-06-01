
///class/////////////////////////////////////////////////

/*
* userAgentとFlashPlayerを判別するクラス
*
* safari3以外のsafariのバージョンの取得はできない。
*/

function ua()
{
	var nav = navigator;
	var doc = document;
	var win = window;
	var userA = navigator.userAgent.toLowerCase();
	var app = navigator.appVersion;
	var appNM = navigator.appName;
	this.ua = {};
	this.ua.isWinNT = (userA.indexOf("windows nt 4.0") != -1);
	this.ua.isWin2000 = (userA.indexOf("windows nt 5.0") != -1);
	this.ua.isWinXP = (userA.indexOf("windows nt 5.1") != -1);
	this.ua.isWinVista = (userA.indexOf("windows nt 6.0") != -1);
	this.ua.isWin7 = (userA.indexOf("windows nt 6.1") != -1);
	this.ua.isMacX = (userA.indexOf("mac os x") != -1);
	this.ua.isMacIntel = false;
	this.ua.isMacPPC = false;
	this.ua.isWin = (app.indexOf("Win") != -1);
	this.ua.isMac = (app.indexOf("Mac") != -1);
	this.ua.isLinux = (userA.indexOf("x11") != -1);
	this.ua.isIE = (userA.indexOf("msie") != -1);
	this.ua.isGecko = (userA.indexOf("gecko") != -1);
	this.ua.isFF = (userA.indexOf("firefox") != -1);
	this.ua.isSafari = (userA.indexOf("safari") != -1);
	this.ua.isOpera = (userA.indexOf("opera") != -1);
	this.ua.isChrome = (userA.indexOf("chrome") != -1);
	this.ua.isWebKit = (userA.indexOf("webkit") != -1);
	this.ua.winVersion = 0;
	this.ua.isWinOverXP = false;
	if(this.ua.isChrome)
	{
		this.ua.isSafari = false;
	}
	
	//mac
	if(this.ua.isMacX)
	{
		if(navigator.platform == "MacIntel")
		{
			this.ua.isMacIntel = true;
		}
		else if(navigator.platform == "MacPPC")
		{
			this.ua.isMacPPC = true;
		}
	}
	
	
	//windows
	if(this.ua.isWin)
	{
		var n = userA.indexOf("windows nt");
		if(n == -1)
		{
			this.ua.isWinOverXP = false;
		}
		else
		{
			var pf = userA.substring(n, userA.indexOf(";", n));
			var version = pf.split(" ")[2];
			this.ua.winVersion = version;
			if(version >= 5.1)  //over XP
			{
				this.ua.isWinOverXP = true;
			}
			else  //2000 or NT4.0
			{
				this.ua.isWinOverXP = false;
			}
		}
	}
	
	/*
	* user agent version
	*/
	this.ua.rev = [];
	if(this.ua.isIE)
	{
		var num = userA.indexOf("msie")+1;
		var toNum = userA.indexOf(";", num);
		var str = userA.substring(userA.indexOf(" ", num) + 1, toNum);
		this.ua.rev = str.split(".");
	}
	else if(this.ua.isChrome)
	{
		var num = userA.indexOf("chrome");
		var fromNum = userA.indexOf("/", num) + 1;
		var toNum = userA.indexOf("safari");
		var str = userA.substring(fromNum, toNum);
		this.ua.rev = str.split(".");
	}
	else if(this.ua.isFF)
	{
		var num = userA.indexOf("firefox")+1;
		var str = userA.substring(userA.indexOf("/", num) + 1);
		this.ua.rev = str.split(".");
	}
	else if(this.ua.isSafari)  //ver3 UP
	{
		if(userA.indexOf("version") != -1)  //ver3 UP
		{
			var arr = userA.split("/");
			var toNum = arr[3].indexOf(" ");
			var str = arr[3].substring(0, toNum);
			this.ua.rev = str.split(".");
		}
		else
		{
			
		}
		
	}
	else if(this.ua.isOpera)
	{
		var fromNum = userA.indexOf("/") + 1;
		var toNum = userA.indexOf(" ");
		var str = userA.substring(fromNum, toNum);
		this.ua.rev = str.split(".");
	}
	
	
	/*
	* flash version
	*/
	var SHOCKWAVE_FLASH = "Shockwave Flash";
	var SHOCKWAVE_FLASE_AX  = "ShockwaveFlash.ShockwaveFlash";
	var FLASH_MIME_TYPE = "application/x-shockwave-flash";
	this.flaRev = [];
	var desc = null;
	var isCrash = false;
	var ax = null;
	if(typeof navigator.plugins != "undefined" && typeof navigator.plugins[SHOCKWAVE_FLASH] == "object")
	{
		desc = navigator.plugins[SHOCKWAVE_FLASH].description.toLowerCase();
		var plugin = navigator.mimeTypes[FLASH_MIME_TYPE].enabledPlugin;
		if(desc && plugin && plugin.description)
		{
			var p = plugin.description.toLowerCase();
			var num = p.indexOf("flash");
			var fromNum = p.indexOf(" ", num) + 1;
			var flaStr = p.substring(fromNum);
			var num4 = flaStr.indexOf(".");
			var mejor = flaStr.substring(0, num4);
			this.flaRev[0] = mejor;
			var mainor = flaStr.substring(num4+1);
			var num2 = mainor.indexOf(" ");
			this.flaRev[1] = mainor.substring(0, num2);
			var num3 = mainor.indexOf("r") + 1;
			this.flaRev[2] = mainor.substring(num3);
		}
	}
	else if(typeof window.ActiveXObject != "undefined" )  //for IE
	{
		try
		{
			ax = new ActiveXObject("ShockwaveFlash.ShockwaveFlash.7");
		}
		catch(e)
		{
			try
			{
				ax = new ActiveXObject("ShockwaveFlash.ShockwaveFlash.6");
				this.flaRev = [6,0,21];
				ax.AllowScriptAcess = "always";
			}
			catch(e)
			{
				if(this.flaRev[0] == 6)
				{
					isCrash = true;
				}
			}
			if(!isCrash)
			{
				try
				{
					ax = new ActiveXObject("ShockwaveFlash.ShockwaveFlash");
				}
				catch(e)
				{
					
				}
			}
		}
		
		if(!isCrash && ax)
		{
			try
			{
				var p = ax.GetVariable("$version");
				var str = p.substring(p.indexOf(" ") + 1);
				this.flaRev = [];
				this.flaRev = str.split(",");
				this.flaRev.pop();
			}
			catch(e)
			{
				
			}
		}
	}
	
	
	/*
	* flashplayerのバージョンを文字列で取得する　mejorversion.minorversion.revision　の順番でドット区切りで取得
	*/
	this.getPlyerVersion = function()
	{
		return this.flaRev[0] + "." + this.flaRev[1] + "." + this.flaRev[2];
	};
	
	
	/*
	* ユーザー環境を文字列で取得する　OS ブラウザ revision　の順番で取得
	*/
	this.getEnvironment = function()
	{
		if(this.ua.isWin)
		{
			var os = "windows"
		}
		else if(this.ua.isMac)
		{
			var os = "mac";
		}
		if(this.ua.isIE)
		{
			var browser = "IE";
		}
		else if(this.ua.isChrome)
		{
			var browser = "Chrome";
		}
		else if(this.ua.isFF)
		{
			var browser = "FireFox";
		}
		else if(this.ua.isSafari)
		{
			var browser = "Safari";
		}
		else if(this.ua.isOpera)
		{
			var browser = "Opera";
		}
		
		var revision = "";
		for(var i = 0; i<this.ua.rev.length; i++)
		{
			if(i == this.ua.rev.length - 1)
			{
				revision += this.ua.rev[i];
			}
			else
			{
				revision += this.ua.rev[i] + ".";
			}
		}
		var str = os + " " + browser + " " + revision;
		
		return str;
	};
	
	this.getUAName = function()
	{
		var browser = "";
		if(this.ua.isIE)
		{
			browser = "IE";
		}
		else if(this.ua.isChrome)
		{
			browser = "Chrome";
		}
		else if(this.ua.isFF)
		{
			browser = "FireFox";
		}
		else if(this.ua.isSafari)
		{
			browser = "Safari";
		}
		else if(this.ua.isOpera)
		{
			browser = "Opera";
		}
		else
		{
			browser = "other";
		}
		
		return browser;
	};
	
	this.getUAVersion = function()
	{
		if(this.ua.rev != undefined)
		{
			var n = Math.min(this.ua.rev.length, 2);
			var revision = "";
			for(var i = 0; i<n; i++)
			{
				if(i == n - 1)
				{
					revision += this.ua.rev[i];
				}
				else
				{
					revision += this.ua.rev[i] + ".";
				}
			}
			
			return Number(revision);
		}
		else
		{
			return -1;
		}
	};
	
	this.getMacPC = function()
	{
		if(this.ua.isMac)
		{
			if(this.ua.isMacIntel)
			{
				return "intelMac";
			}
			else if(this.ua.isMacPPC)
			{
				return "powerPC";
			}
			else
			{
				return "other";
			}
		}
		else
		{
			return "notMac";
		}
	};
	
}

var uaObject = new ua();

