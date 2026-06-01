var loc = window.location.hostname;

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

function dlk() {
	if (loc == "www.pokemon-gl.com") {
		location.href="https://www.pokemon.jp/";
	} else if(loc == "stg.pokemon-gl.com") {
		location.href="https://preview.pokemon.jp/";
	} else if(loc == "test.pokemon-gl.com") {
		location.href="https://test1.pokemon.jp/";
	} else if(loc == "pokemon-www.basementfactorysystems.com") {
		location.href="https://dev4pdc.pokemon.jp/";
	} else {
		location.href="https://www.pokemon.jp/";
	}

}

function dlk2(urlnm) {
	if (loc == "www.pokemon-gl.com") {
		urlnm2 = "https://www.pokemon.jp/" + urlnm;
		location.href=urlnm2;
	} else if(loc == "stg.pokemon-gl.com") {
		urlnm2 = "https://preview.pokemon.jp/" + urlnm;
		location.href=urlnm2;
	} else if(loc == "test.pokemon-gl.com") {
		urlnm2 = "https://test1.pokemon.jp/" + urlnm;
		location.href=urlnm2;
	} else if(loc == "pokemon-www.basementfactorysystems.com") {
		urlnm2 = "https://dev4pdc.pokemon.jp/" + urlnm;
		location.href=urlnm2;
	} else {
		urlnm2 = "https://www.pokemon.jp/" + urlnm;
		location.href=urlnm2;
	}

}