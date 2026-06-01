// JavaScript Document

//GBUシーズンマッチ・手持ちポケモン取得
var errorApiHandler = function(data)
{
	var params = 
	{ 
		"type"    : "noClose",
		"id"      : "DIALOG_ERROR",
		"title"   : "",
		"detail"  : "",
		"buttons" : {}
	};
	
	switch(data.error.code)
	{
		// 画面系エラー	
		case "0004":
		case "0005":
		case "0006":
		case "0008":
		case "0009":
		case "0010":
		case "0011":
		case "0015":
		case "0020":
		case "0021":
		case "0025":
		case "0031":
		case "0032":
		case "0033":
		case "0034":
		case "0035":
		case "0036":
		case "0037":
		case "0048":
		case "0049":
		case "0055":
			return data.error.code;
		break;
		
		//メンバーIDが未入力
		case "001":
			params.detail = PGL.INFO.ERROR_MESSAGE[data.error.code][PGL.INFO.LOCATE];
			params.buttons = {
				"閉じる":{"color": "", "action": function(){PGL.dialog.hide()}}
			}
			
			PGL.dialog.init(params);	
			PGL.dialog.show();
		break;
		
		//未ログイン或いはゲームソフト未選択場合
		case "0002":			
			params.detail = PGL.UTIL.getLocale("GLOSSARY_ERROR_CODE_0002");
			params.buttons = {
				"OK":{"color": "", "action": function(){ PGL.UTIL.logout();}}
			}
		
			PGL.dialog.init(params);	
			PGL.dialog.show();
		break;
		
		//年齢制限がある
		case "0003":
			params.detail =PGL.UTIL.getLocale("GLOSSARY_ERROR_CODE_0003");
			params.buttons = {
				"OK":{"color": "", "action": function(){ PGL.UTIL.logout();}}
			}
		
			PGL.dialog.init(params);	
			PGL.dialog.show();
		break;
		
		//未ログイン或いは有効なアカウントが存在しない
		case "0007":
			params.detail = PGL.UTIL.getLocale("GLOSSARY_ERROR_CODE_0007");
			params.buttons = {
				"トップへ戻る":{"color": "", "action": function(){ location.href = "/3ds.pokemon-gl.com/"}}
			}
			if(location.href.indexOf("settings") != -1){
				PGL.dialog.change(params)
			}else{
				PGL.dialog.init(params);	
			}
			PGL.dialog.show();
		break;
		
		//セーブデータIDが存在しない場合
		//メンバーIDが存在しない場合
		case "0012":
		case "0013":
			// issue:0001808,0000820
			// エラーメッセージ等の表示は行わず、トップページへ遷移する
			location = '/';
		break;
		
		//写真が存在しません
		case "0016":
			params.detail = PGL.UTIL.getLocale("GLOSSARY_ERROR_CODE_0016");
			params.buttons = {
				"閉じる":{"color": "", "action": function(){ 
					if($("#pictureDetail").length != 0){
						location.href = '/3ds.pokemon-gl.com/';
					}else{
						location.reload();
					}
				}}
			}
			
			if($("#pictureDetail").length != 0){
				PGL.dialog.init(params);
				PGL.dialog.show();
			}else{
				PGL.dialog.showSub(params);
			}
			//return data.error.code;
		break;
		
		//ロック写真数は写真最大保持枚数以上
		case "0017":
			params.detail = PGL.UTIL.getLocale("GLOSSARY_ERROR_CODE_0017");
			params.buttons = {
				"閉じる":{"color": "", "action": function(){
					($("#pictureDetail").length != 0)? PGL.dialog.hide():PGL.dialog.hideSub();
				}}
			}
			
			if($("#pictureDetail").length != 0){
				PGL.dialog.init(params);
				PGL.dialog.show();
			}else{
				PGL.dialog.showSub(params);
			}
			return data.error.code;
		break;
		
		//ロックされている
		case "0018":
			params.detail = PGL.UTIL.getLocale("GLOSSARY_ERROR_CODE_0018");
			params.buttons = {
				"閉じる":{"color": "", "action": function(){
					($("#pictureDetail").length != 0)? PGL.dialog.hide():PGL.dialog.hideSub();	
				}}
			}
			
			if($("#pictureDetail").length != 0){
				PGL.dialog.init(params);
				PGL.dialog.show();
			}else{
				PGL.dialog.showSub(params);
			}
		break;
		
		//移動先のセーブデータIDが無効の場合
		case "0019":
			params.detail = PGL.UTIL.getLocale("GLOSSARY_ERROR_CODE_0019");
			params.buttons = {
				"トップへ戻る":{"color": "", "action": function(){ location.href = "/3ds.pokemon-gl.com/"}}
			}
		
			PGL.dialog.init(params);	
			PGL.dialog.show();
		break;
		
		//選択されたソフトが有効ではない場合
		case "0022":
			params.detail = PGL.UTIL.getLocale("GLOSSARY_ERROR_CODE_0022");
			params.buttons = {
				"トップへ戻る":{"color": "", "action": function(){ location.href = "/3ds.pokemon-gl.com/"}}
			}
		
			PGL.dialog.change(params);
			//PGL.dialog.show();
		break;
		
		//ゲームシンクIDコードは既に解除された場合
		case "0023":
			params.detail = PGL.UTIL.getLocale("GLOSSARY_ERROR_CODE_0023");
			params.buttons = {				
				"閉じる":{"color": "", "action": function(){PGL.dialog.hide()}}
			}
		
			PGL.dialog.change(params);	
			//PGL.dialog.show();
		break;
		
		//ゲームシンクIDコードは既に解除された場合
		case "0024":
			params.detail = PGL.UTIL.getLocale("GLOSSARY_ERROR_CODE_0024");
			params.buttons = {
				"閉じる":{"color": "", "action": function(){PGL.dialog.hide()}}
			}
		
			PGL.dialog.change(params);	
			//PGL.dialog.show();
		break;
		
		//未送信の獲得アイテムはありません
		case "0026":
			params.detail = PGL.UTIL.getLocale("GLOSSARY_ERROR_CODE_0026");
			params.buttons = {
				"ポケマイルクラブへ戻る":{"color": "", "action": function(){location.href="/3ds.pokemon-gl.com/mileage/";}}
			}
		
			PGL.dialog.init(params);	
			PGL.dialog.show();
		break;
		
		//未送信の獲得アイテムが20件を超えています
		case "0027":
			params.detail = PGL.UTIL.getLocale("GLOSSARY_ERROR_CODE_0027");
			params.buttons = {
				"ポケマイルクラブへ戻る":{"color": "", "action": function(){location.href="/3ds.pokemon-gl.com/mileage/";}},
				"マイページへ":{"color": "", "action": function(){
					location.href="/3ds.pokemon-gl.com/user/"+PGL.DATA.SD.memberSavedataIdCode+"/mileage/";
				}}
			}
		
			PGL.dialog.init(params);	
			PGL.dialog.show();
		break;
		
		case "0028":
			params.detail = PGL.UTIL.getLocale("GLOSSARY_ERROR_CODE_0028");
			params.buttons = {
				"ポケマイルクラブへ戻る":{"color": "", "action": function(){location.href="/3ds.pokemon-gl.com/mileage/";}}
			}
		
			PGL.dialog.init(params);	
			PGL.dialog.show();
		break;
		
		//必要メダル数が足りない場合
		case "0029":
			params.detail = PGL.UTIL.getLocale("GLOSSARY_ERROR_CODE_0029");
			params.buttons = {
				"トップへ戻る":{"color": "", "action": function(){location.href="/3ds.pokemon-gl.com/";}}
			}
		
			PGL.dialog.init(params);	
			PGL.dialog.show();
		break;
		
		//ポイント不足の場合
		case "0030":
			params.detail = PGL.UTIL.getLocale("GLOSSARY_ERROR_CODE_0030");
			params.buttons = {
				"トップへ戻る":{"color": "", "action": function(){location.href="/3ds.pokemon-gl.com/";}}
			}
		
			PGL.dialog.init(params);	
			PGL.dialog.show();
		break;
		
		//自分の写真ではない
		case "0039":
			params.detail = PGL.UTIL.getLocale("GLOSSARY_ERROR_CODE_0039");
			params.buttons = {
				"閉じる":{"color": "", "action": function(){PGL.dialog.hide()}}
			}
		
			PGL.dialog.init(params);	
			PGL.dialog.show();
		break;
		
		//該当アカウントが存在しない
		case "0041":
			params.detail = PGL.UTIL.getLocale("GLOSSARY_ERROR_CODE_0041");
			params.buttons = {
				"閉じる":{"color": "", "action": function(){PGL.dialog.hide()}}
			}
		
			PGL.dialog.init(params);	
			PGL.dialog.show();
		break;
		
		//解除理由は未入力の場合
		case "0043":
			params.detail = PGL.UTIL.getLocale("GLOSSARY_ERROR_CODE_0043");
			params.buttons = {
				"戻る":{"color": "", "action": function(){PGL.dialog.hideSub()}}
			}
		
			PGL.dialog.showSub(params);
		break;
		
		//解除理由はその他を選択した場合、その他の解除理由は未入力の場合
		case "0044":
			params.detail = PGL.UTIL.getLocale("GLOSSARY_ERROR_CODE_0044");
			params.buttons = {
				"戻る":{"color": "", "action": function(){PGL.dialog.hideSub()}}
			}
		
			PGL.dialog.showSub(params);
		break;
		
		//解除理由はその他を選択した場合、その他の解除理由は256文字超えた場合
		case "0045":
			params.detail = PGL.UTIL.getLocale("GLOSSARY_ERROR_CODE_0045");
			params.buttons = {
				"戻る":{"color": "", "action": function(){PGL.dialog.hideSub()}}
			}
		
			PGL.dialog.showSub(params);
		break;
		
		//解除申請中の場合
		case "0046":
			params.detail = PGL.UTIL.getLocale("GLOSSARY_ERROR_CODE_0046");
			params.buttons = {
				"戻る":{"color": "", "action": function(){PGL.dialog.prev()}}
			}
		
			PGL.dialog.change(params);
		break;
		
		//解除申請中のゲームシンクIDコードではない場合
		case "0047":
			params.detail = PGL.UTIL.getLocale("GLOSSARY_ERROR_CODE_0047");
			params.buttons = {
				"戻る":{"color": "", "action": function(){PGL.dialog.prev()}}
			}
		
			PGL.dialog.change(params);
		break;
		
		//該当登録でアイテム種類が20種に達した又は、1アイテムが上限99に達した場合
		case "0051":
			params.detail = PGL.UTIL.getLocale("GLOSSARY_ERROR_CODE_0051");
			params.buttons = {
				"戻る":{"color": "", "action": function(){PGL.dialog.prev()}}
			}
		
			PGL.dialog.change(params);
		break;
		
		//ロックされている
		case "0053":
			params.detail = PGL.UTIL.getLocale("GLOSSARY_ERROR_CODE_0053");
			params.buttons = {
				"閉じる":{"color": "", "action": function(){ location.reload();}}
			}
			
			PGL.dialog.showSub(params);
		break;
	}
				
	return false;
}