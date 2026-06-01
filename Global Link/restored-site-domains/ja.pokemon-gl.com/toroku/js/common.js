var os = (navigator.appVersion.indexOf ("Win", 0) != -1) ? "w" : "m";
var br = (navigator.appName.indexOf ("Mic", 0) != -1) ? "e" : "n";

if (navigator.appVersion.indexOf("Safari") > -1) {
os = "m";
br = "sf";
}

document.write ('<link rel="STYLESHEET" type="text/css" href="' + __path + 'toroku/common/css/' + os + '_' + br + '.css">');

function notes(eve){
if(document.all){
  if(event.button == 2){
  alert("右クリック禁止になっています。\n画像のコピーはしないでね！");
  return false;
  }
}
if(document.layers){
  if(eve.which == 3){
  alert("右クリック禁止になっています。\n画像のコピーはしないでね！");
  return false;
  }
}
}

if(document.layers)document.captureEvents(Event.MOUSEDOWN);
document.onmousedown=notes;

//タイトル画像をランダムに表示

function Random_ImageView()
	{
	//var max_imagenum =29 ;
	var max_imagenum =30 ;
	var image_array =new Array(max_imagenum ) ; 
	var ram_number ;
	var expd =".gif" ; 
	var judge_num = 1.0/max_imagenum ;

	for(var i=0 ;i <max_imagenum ;i++ )
	{
	image_array[i] = "/portal/shareimgs/" + (i+1) ;".gif" ;
	}
	ram_number = Math.random() ;
	image_number = Math.floor( ram_number/judge_num );
	document.write("<img src=\"" + image_array[image_number] + expd +"\" ALT =\"ポケモン\" >") ;
	}
	
	
	
//あいことばをポップアップ
function openWin(url)
{
	window.open(url,"sub1","width=400,height=350,menubar=no,toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizeable=yes");
}

//ポップアップ
function guest(url,w,h) {
	sealWin=window.open(url,"win","toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=1,width=" + w + ",height=" + h);
	self.name = "mainWin";
}