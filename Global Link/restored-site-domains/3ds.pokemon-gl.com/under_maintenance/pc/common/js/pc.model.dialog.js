

/*=====================================================
 /////////////ダイアログ：公開範囲の設定 //////////////
=====================================================*/
PGL.DIALOG.accountPublish = function()
{
	PGL.REQUEST.postAPI("GET_ACCOUNT_PUBLISH",{}).done(function(data)
	{
		var trObj = new Object();
		PGL.DATA.GET_ACCOUNT_PUBLISH = data;
		var page1Tags = function()
		{
			var data = PGL.DATA.GET_ACCOUNT_PUBLISH;
			var count = 0;
			for(var n in data.publish){
				var opt = [];
				$.each(PGL.DATA.options,function(i){
					if(parseInt(data.publish[n])==i){
						opt.push('<option value="'+i+'" selected="selected">'+this+'</option>');
					}
					else{
						opt.push('<option value="'+i+'">'+this+'</option>');
					}
				});
				var tr = [
					'<th class="centerBox">',PGL.DATA.categories[n],'</th>',
						'<td class="rightBox">',
							'<select id="range',count,'">',opt.join(""),'</select>',
						'</td>',
					'</tr>'
				];
				trObj[n] = tr.join("");
				count++;
			}
			
			var sdata = PGL.DATA.GET_LOGIN_STATUS.selectedSavedata;
			// issue:0000703
			var markup = 
			[
				'<ul class="clearFix">',
					'<li class="floatR font12 fontB"><a href="/3ds.pokemon-gl.com/support/" class="iconHelp_or">',PGL.UTIL.getLocale("GLOSSARY_ABOUT_PRIVACY_SETTINGS"),'</a></li>',
				'</ul>',
				'<div class="frameContainer noScroll borderNone pt00">',
					'<div class="publishBox">',
						'<div class="tableTypeDefault">',
							'<table width="100%" border="0" cellspacing="0" cellpadding="0">',
							'<tr>',
							'<td class="leftBox">',
								'<dl class="allPublish">',
									'<dt>',PGL.UTIL.getLocale("GLOSSARY_BASE_PRIVACY_SETTINGS"),'</dt>',
									'<dd>',PGL.UTIL.getLocale("GLOSSARY_BASE_PRIVACY_SETTINGS_NOTE"),'</dd>',
								'</dl>',
							'</td>',trObj.profile,
						'</table>',
						'</div>',
					'</div>',
					'<div class="publishBox">',
					'<div class="tableTypeDefault">',
					'<table width="100%" border="0" cellspacing="0" cellpadding="0">',
					'<tr class="userPageSettings">',
					'<td rowspan="8" class="leftBox">',
						'<dl class="allPublish mb20">',
							'<dt>',PGL.UTIL.getLocale("GLOSSARY_MYPAGE_PRIVACY_SETTINGS"),'</dt>',
							'<dd>',PGL.UTIL.getLocale("GLOSSARY_MYPAGE_PRIVACY_SETTINGS_NOTE"),'</dd>',
						'</dl>',
					'</td>',trObj.gameSoft,
					'<tr>',trObj.timeline,
					'<tr>',trObj.gbu,
					'<tr style="display:none;">',trObj.internetMatchup,
					'<tr>',trObj.gts,
					'<tr>',trObj.medal,
					'<tr>',trObj.photo,
					'<tr>',trObj.friend,
					'</table>',
					'</div>',
					'</div>',
					'</div>',
				'</div>'
			].join("");
			var $content = $(markup);
			
			$('<div></div>').savedataBox(sdata, { vertical:true }).appendTo($content.find('.userPageSettings td:first'));
			
			// issue:0001971
			if (PGL.DATA.GET_LOGIN_STATUS.account.site == 2) {
				var $target = $content.find('.rightBox:first');
				$('<span></span>').text($target.find('select option:selected').text()).appendTo($target);
				$('<div class="checkComProfile"></div>').append(
					$('<a></a>').text(PGL.UTIL.getLocale('GLOSSARY_ACTION_TO_PTC')).attr({ href:PGL.INFO.PATH.comMember })
				).appendTo($target);
				$target.find('select').hide();
			}
			
			return $content;
		}
		
		/*var pubData = data.publish;
		var saveData = data.savedata;
		var isCom = data.account.site === '2' ? true : false;
		var allAuth = pubData.profile;*/
		
		var page01Btn = {};
		page01Btn[PGL.UTIL.getLocale("GLOSSARY_ACTION_SAVE_SETTINGS")] = {"color": true, "action": function(){
					
					var selects = $.map($('select[id*="range"]','#confirmWindow'),function(item, index){
						return $(item).children(':selected').attr('value');
					});
					var currSelectStatus = {
						"profile" : selects[0],
						"gameSoft": selects[1],
						"timeline":selects[2],
						"gbu":selects[3],
						"internetMatchup":selects[4],
						"gts":selects[5],
						"medal":selects[6],
						"photo":selects[7],
						"friend": selects[8]
					};
					PGL.REQUEST.postAPI("UPDATE_PUBLISH",currSelectStatus).done(function(data){						
						if(location.href.indexOf("register")!=-1){
							location.href = "/3ds.pokemon-gl.com/";
						}else{
							location.reload();
						}
						//PGL.dialog.change(page02);
					});
				}}
				
		var page01 = {
			"type"    : "",
			"id"      : "DIALOG_PUBLISH",
			"title"   : PGL.UTIL.getLocale("GLOSSARY_PRIVACY_SETTINGS"),
			"detail"  : page1Tags,
			"buttons" : page01Btn
		};

		PGL.dialog.init(page01);
		PGL.dialog.show();

		var page02 = PGL.DIALOG.modelClose(PGL.UTIL.getLocale("GLOSSARY_PRIVACY_SETTINGS"),PGL.UTIL.getLocale("GLOSSARY_PRIVACY_SETTINGS_COMPLETED"));

		//公開範囲の設定プルダウン動作
		//$('select[id*="range"]','#confirmWindow').privateRangeUI({'list':PGL.INFO.TEXT.mypage_publish});
		
		// issue:0000760
		$('select[id*="range"]:first').on('change', function () {
			var base = $(this).val();
			$('select[id*="range"]:gt(0)').each(function (index, select) {
				$(select).val(Math.min($(select).val(), base));
				$(select).children('option').attr({ disabled:false }).filter(':gt(' + base + ')').attr({ disabled:true });
			});
		}).change();
	});
	return false;
};


/*=====================================================
 ////////// ゲームソフトの登録解除申請 ///////////////
=====================================================*/
PGL.DIALOG.releaseGame = function(data)
{
	
	var steps = ['GLOSSARY_CAUTION_TITLE', 'GLOSSARY_CHECK', 'GLOSSARY_FIN'];
	
	/*
	 * page1
	 */
	var page1Tags = function()
	{
		// issue:0001091
		var markup = 
		[
			'<div class="mb10">',
			'<ul class="steps"></ul>','</div>',
			'<ul class="clearFix">',
			'<li class="floatL iconCaution font12 fontB">',PGL.UTIL.getLocale("GLOSSARY_ACCOUNT_ANNOTATION_01"),'</li>',
			'<li class="floatR font12 fontB"><a href="javascript:void(0);" class="iconHelp_or">',PGL.UTIL.getLocale("F-AC-01-06_ABOUT_LINK"),'</a></li>',
			'</ul>',
			'<div class="frameContainer">',
			'<ul class="mb10 indent">',
			'<li>',PGL.UTIL.getLocale("F-AC-01-06_ATTENTION_TXT1"),'</li>',
			'<li>',PGL.UTIL.getLocale("F-AC-01-06_ATTENTION_TXT2"),'</li>',
			'<li>',PGL.UTIL.getLocale("F-AC-01-06_ATTENTION_TXT3"),'</li>',
			'</ul>',
			'<h4 class="important"><span>',PGL.UTIL.getLocale("F-AC-01-06_IMPORTANT_LABEL"),'</span>',PGL.UTIL.getLocale("F-AC-01-06_ATTENTION_TITLE2"),'</h4>',
			'<p class="mb20">',PGL.UTIL.getLocale("F-AC-01-06_ATTENTION_TXT4"),'</p>',
			'<div class="checkContainer">',
			'<p><input type="checkbox" name="release1" id="release1-1" /></p>',
			'<label for="release1-1"><dl>',
			'<dt>',PGL.UTIL.getLocale("F-AC-01-06_CHECK1_TITLE"),'</dt>',
			'<dd>',PGL.UTIL.getLocale("F-AC-01-06_CHECK1_TXT"),'</dd>',
			'</dl></label>','</div>',
			'<div class="checkContainer">',
			'<p><input type="checkbox" name="release1" id="release1-2" /></p>',
			'<label for="release1-2"><dl>',
			'<dt>',PGL.UTIL.getLocale("F-AC-01-06_CHECK2_TITLE"),'</dt>',
			'<dd>',PGL.UTIL.getLocale("F-AC-01-06_CHECK2_TXT"),'</dd>',
			'</dl></label>','</div>',
			'<div class="checkContainer">',
			'<p><input type="checkbox" name="release1" id="release1-3" /></p>',
			'<label for="release1-3"><dl>',
			'<dt>',PGL.UTIL.getLocale("F-AC-01-06_CHECK3_TITLE"),'</dt>',
			'<dd>',PGL.UTIL.getLocale("F-AC-01-06_CHECK3_TXT"),'</dd>',
			'</dl></label>','</div>','</div>','</div>'
		].join("");
		
		var $markup = $(markup);
		$markup.find('.steps').stepList(steps, 0, true);
		
		$markup.on("click","input[name=release1]",function(){
			if ($("input[name=release1]:checked").length == 3) {
				$(".confButton:eq(1)").removeClass("disabled").on("click", funcPage01);
			} else {
				$(".confButton:eq(1)").addClass("disabled").off("click");
			}
		});
		
		return $markup;		
	}

	var funcPage01 = function(){
		PGL.dialog.change(page02);
		$(".confButton:eq(1)").addClass("disabled").off("click");
		
		$('input').on('change', function () {
			if ($('input[name="release2"]').is(':checked') && $('input[name="reason"]').is(':checked')) {
				$(".confButton:eq(1)").removeClass("disabled").on("click", funcPage02);
			} else {
				$(".confButton:eq(1)").addClass("disabled").off("click");
			}
			$('.reasonText>textarea').attr({ disabled:$('input[name=reason]:checked').val() != 99 });
		});
	}
	
	var page01Btn = {};
	page01Btn[PGL.UTIL.getLocale('GLOSSARY_ACTION_PREV')] = {color:false,action:function(){ PGL.dialog.hide()}};
	page01Btn[PGL.UTIL.getLocale('F-AC-01-06_BTN_APPLY')] = {color:true,action:funcPage01};
	
	var page01 = {
		"type"    : "",
		"id"      : "DIALOG_RELEASE",
		"title"   : PGL.UTIL.getLocale("GLOSSARY_REGISTRATION_RELEASE"),
		"detail"  : page1Tags,
		"buttons" : page01Btn
	};
	
	/*
	 * page2
	 */
	var page2Tags = function()
	{
		// issue:0001292,0001324,0001325
		var markup = 
		[
			'<div class="mb10">',
			'<ul class="steps"></ul>','</div>',
			'<ul class="clearFix">',
			'<li class="iconCaution font12 fontB">',PGL.UTIL.getLocale("F-AC-01-06_ATTENTION_TXT"),'</li>',
			'</ul>',
			'<div class="frameContainer noScroll">',
			'<ul class="mb10 indent">',
			'<li>',PGL.UTIL.getLocale("F-AC-01-06_UNREGISTER_ATTENTION_TXT"),'</li>',
			'</ul>',
			'<div class="pointChangeBox">',
			'<div>',
			'<p class="currentPointTitle">',PGL.UTIL.getLocale("GLOSSARY_CURRENT_PMP"),'</p>',
			'<p class="currentPointDate">',PGL.UTIL.getDateTime(data.mileLastUpdateDate),'</p>',
			'<p class="movePoint colorText02 font-face-1">',PGL.UTIL.addComma(data.mile),'</p>',
			
			'</div>',
			'</div>',
			'<div class="releaseContainer">',
			'<div class="grayBox">',
			'<p class="font13"><input type="checkbox" name="release2" id="release" /><label for="release">',PGL.UTIL.getLocale("F-AC-01-06_CHECK_UNREGISTER_LABEL"),'</label></p>',
			'</div>',
			'<div class="grayBox">',
			'<dl>',
			'<dt>',PGL.UTIL.getLocale("F-AC-01-06_REASON_LABEL"),'</dt>',
			'<dd><label><input type="radio" name="reason" value="1" />',PGL.UTIL.getLocale("F-AC-01-06_REASON1_TXT"),'</label></dd>',
			'<dd><label><input type="radio" name="reason" value="2" />',PGL.UTIL.getLocale("F-AC-01-06_REASON2_TXT"),'</label></dd>',
			'<dd><label><input type="radio" name="reason" value="3" />',PGL.UTIL.getLocale("F-AC-01-06_REASON3_TXT"),'</label></dd>',
			'<dd><label><input type="radio" name="reason" value="99" />',PGL.UTIL.getLocale("F-AC-01-06_REASON4_TXT"),'</label></dd>',
			'<dd class="reasonText"><textarea rows="4" disabled="disabled"></textarea></dd>',
			'</dl>','</div>','</div>','</div>'
		].join("");
		
		var $markup = $(markup);
		$markup.find('.steps').stepList(steps, 1, true);
		$('<div></div>').savedataBox(data, { vertical:true }).appendTo($markup.find('.pointChangeBox>div'));
		
		return $markup;
	}
	
	
	var funcPage02 = function(){
		var $checked = $("input[name=reason]:checked");
		var sr = $checked.val();
		var rt = (sr==99)? $(".reasonText>textarea").val():"";
		PGL.REQUEST.postAPI("RELEASE_GAME_SYNC_ID",{"savedataId":data.savedataId,reason:sr,reasonText:rt})
			.done(function(){
				PGL.dialog.change(page03);
			});
		return false;
	}
	var page02Btn = {};
	page02Btn[PGL.UTIL.getLocale("GLOSSARY_ACTION_PREV")] = {color:false,action:function(){ PGL.dialog.prev();$("input[name=release1]").val(['on']) }};
	page02Btn[PGL.UTIL.getLocale("F-AC-01-06_BTN_APPLY")] = {color:true,action:funcPage02};
	
	var page02 = {
		"type"    : "",
		"id"      : "DIALOG_RELEASE",
		"title"   : PGL.UTIL.getLocale("GLOSSARY_REGISTRATION_RELEASE"),
		"detail"  : page2Tags,
		"buttons" : page02Btn
	};
	
	/*
	 * page3
	 */
	var page3Tags = function()
	{
		// issue:0001292,0001325
		var markup = 
		[
			'<div class="mb10">',
			'<ul class="steps"></ul>',
			'</div>',
			'<ul class="clearFix">',
			'<li class="iconCaution font12 fontB">',PGL.UTIL.getLocale("F-AC-01-06_ATTENTION_TXT"),'</li>',
			'</ul>',
			'<div class="frameContainer noScroll">',
			'<ul class="mb10 indent">',
			'<li>&nbsp;</li>',
			'</ul>',
			'<div class="pointChangeBox">',
			'<div>',
			'<p class="currentPointTitle">',PGL.UTIL.getLocale("F-AC-01-06_POKEMILE_DELPOINT_LABEL"),'</p>',
			'<p class="currentPointDate">',PGL.UTIL.getDateTime(data.mileLastUpdateDate),'</p>',
			'<p class="movePoint colorText02 font-face-1">',PGL.UTIL.addComma(data.mile),'</p>',
			
			
			'</div>','</div>',
			'<div class="releaseContainer">',
			'<p class="cancelTitle">',PGL.UTIL.getLocale("F-AC-01-06_COMPLETE_TXT"),'</p>',
			'<div class="cancelBox">',
			'<dl>',
			'<dt>',PGL.UTIL.getLocale("F-AC-01-06_ABOUT_UNREGISTER_LABEL"),'</dt>',
			'<dd>',PGL.UTIL.getLocale("F-AC-01-06_ABOUT_UNREGISTER1_TXT"),'</dd>',
			'<dd>',PGL.UTIL.getLocale("F-AC-01-06_ABOUT_UNREGISTER2_TXT"),'</dd>',
			'</dl>','</div>','</div>','</div>'
		].join("");
		
		var $markup = $(markup);
		$markup.find('.steps').stepList(steps, 2, true);
		$('<div></div>').savedataBox(data, { vertical:true }).appendTo($markup.find('.pointChangeBox>div'));
		
		return $markup;		
	}
	
	var page03Btn = {}
	page03Btn[PGL.UTIL.getLocale("GLOSSARY_ACTION_RETURN_TO_SETTINGS")] = {color:false,action:function(){location.reload()}}
	var page03 = {
		"type"    : "noClose",
		"id"      : "DIALOG_RELEASE",
		"title"   : PGL.UTIL.getLocale("GLOSSARY_REGISTRATION_RELEASE"),
		"detail"  : page3Tags,
		"buttons" : page03Btn
	};

	PGL.dialog.init(page01);
	PGL.dialog.show();
	$(".confButton:eq(1)").addClass("disabled").off('click');
	
	return false;
};



/*=====================================================
 ////////// ゲームソフトの登録解除キャンセル //////////
=====================================================*/
PGL.DIALOG.releaseCancel = function(data)
{
	var steps = ['GLOSSARY_CHECK', 'GLOSSARY_FIN'];
	
	var page1Tags = function()
	{
		var markup = 
		[
			'<div>',
			'<div class="mb10">',
			'<ul class="steps"></ul>',
			'</div>',
			'<p class="mb20 font15 alingC"><strong>',PGL.UTIL.getLocale("F-AC-01-07_ALERT_TXT1"),'</strong></p>',
			'<div class="savedataList">',
			
			
			'</div>',
			'</div>'
		].join("");
		
		var $markup = $(markup);
		$markup.find('.steps').stepList(steps, 0, true);
		$('<div></div>').savedataBox(data).appendTo($markup.find('.savedataList'));
		
		return $markup;
	}
	
	var page2Tags = function()
	{
		var markup = 
		[
			'<div>',
			'<div class="mb10">',
			'<ul class="steps"></ul>',
			'</div>',
			'<p class="mb20 font15 alingC"><strong>',PGL.UTIL.getLocale("F-AC-01-07_ALERT_TXT2"),'</strong></p>',	
			'<div class="savedataList">',
			
			
			'</div>',
			'</div>'
		].join("");
		
		var $markup = $(markup);
		$markup.find('.steps').stepList(steps, 1, true);
		$('<div></div>').savedataBox(data).appendTo($markup.find('.savedataList'));
		
		return $markup;
	}
	
	var page01Btn = {};
	page01Btn[PGL.UTIL.getLocale("F-AC-01-07_BTN_NO")] = {color:false,action:function(){PGL.dialog.hide()}}
	page01Btn[PGL.UTIL.getLocale("F-AC-01-07_BTN_YES")] = {color:true,action:function(){	
					PGL.REQUEST.postAPI("RELEASE_CANCEL",{savedataId:data.savedataId}).done(function(){
							PGL.dialog.change(page02)
						})
					}}
	
	var page01 = {
		"type"    : "",
		"id"      : "DIALOG_RELEASE_CANCEL",
		"title"   : PGL.UTIL.getLocale("F-AC-01-07_WIN_TITLE"),
		"detail"  : page1Tags,
		"buttons" : page01Btn
	};
	
	var page02Btn = {}
	page02Btn[PGL.UTIL.getLocale("GLOSSARY_ACTION_RETURN_TO_SETTINGS")] = {color:false,action:function(){location.reload()}}
	var page02 = {
		"type"    : "noClose", // issue:0000322
		"id"      : "DIALOG_RELEASE_CANCEL",
		"title"   : PGL.UTIL.getLocale("F-AC-01-07_WIN_TITLE"),
		"detail"  : page2Tags,
		"buttons" : page02Btn
	}

	PGL.dialog.init(page01);
	PGL.dialog.show();
};


/*=====================================================
 ////////// ゲームソフトの切り替え確認 ///////////////
=====================================================*/
PGL.DIALOG.selectGsidc = function(data)
{
	var page1Tags = function()
	{
		switch(data.romId){
			case "24":　var changeText = PGL.UTIL.getLocale("F-AC-01-05_CONTENTS_DESCRIPT");　break;
			case "25":　var changeText = PGL.UTIL.getLocale("F-AC-01-05_CONTENTS_DESCRIPT");　break;
		}
		
		var markup = 
		[
			'<div class="savedataList">',
			'<p class="mb30 mt30 font15"><strong>',changeText,'</strong></p>',
			'</div>'
		].join("");
		
		var $panel = $(markup).css({ 'text-align':'center' });
		$('<div></div>').savedataBox(data).appendTo($panel);
		
		return $panel;
	}	
	
	var page01Btn = {};
	page01Btn[PGL.UTIL.getLocale("F-AC-01-05_BTN_NO")] = {"color": false, "action": function(){PGL.dialog.hide();}};
	page01Btn[PGL.UTIL.getLocale("F-AC-01-05_BTN_YES")] = {"color": true, "action": function(){
							PGL.REQUEST.postAPI("SELECT_G_SIDC",{"savedataId":data.savedataId}).done(function(data){
								location.href = "/3ds.pokemon-gl.com/";
							});							
						}};

	var page01= {
		"type"    : "",
		"id"      : "DIALOG_SELECT_SOFT",
		"title"   : PGL.UTIL.getLocale("F-AC-01-05_WIN_TITLE"),
		"detail"  : page1Tags,
		"buttons" : page01Btn
	};

	PGL.dialog.init(page01);
	PGL.dialog.show();

};

/*=====================================================
 //////////////// ゲームソフトの選択 　//////////////////
=====================================================*/

PGL.DIALOG.selectGameId = function(data)
{
	var page1Tags = function()
	{
		var $builder = $('<div></div>');
		var btn = (data.savedataList.length==1)? 
			'<p class="alingC mt20"><a href="/3ds.pokemon-gl.com/register/add/" class="btnGrLarge">'+PGL.UTIL.getLocale("GLOSSARY_ACTION_ADD_GAME_CARD")+'</a></p>':"";
		$.each(data.savedataList,function(i, savedata)
		{
			var ch = (i==0)? ' selected':"";
			var rel = [
				'<dl class="releaseMessage">',
				'<dt><p>',PGL.UTIL.getLocale("F-GL-01_GS_MESSAGE_STATUS"),'</p></dt>',
				'<dd>',
				'<ul class="indent">',
				'<li>',PGL.UTIL.getLocale("F-GL-01_GS_MESSAGE"),'</li>',
				'</ul>',
				'</dd>',
				'</dl>'
			].join("");
			
			// issue:0000936,0001360
			var msg = this.applyFlg == 1 ? '<p class="releaseMessage">'+PGL.UTIL.getLocale("GLOSSARY_RELEASE_REQUESTING")+'</p>' : '';		
			var cont = 
			[
				'<div class="accountContainer">',
				'<div class="panelAccountlist clearFix',ch,'">',
				msg,
				'<div class="checkBox">',
				'<dl>','<dt>',
				'<div class="roundedOne" data-role="',this.savedataId,'" id="roundedOne',i,'">',
				//'<input type="radio" value="None" id="roundedOne',i,'" name="check" ',ch,' />',
				//'<label for="roundedOne',i,'"></label>',
				'</div>','</dt>','</dl>',
				'</div>',
				'</div>',
				'</div>'
			].join("");
			var $panel = $(cont);
			
			$('<div></div>').savedataBox(savedata).insertAfter($panel.find('.checkBox')).css({ 'margin-left':110 });
			
			$builder.append($panel);
		});
		
		$builder.prepend($('<p class="font15 fontB mb10">' + PGL.UTIL.getLocale("F-GL-01_GS_SELECT_GAME_CARD") + '</p>'));
		$builder.append(btn);
		return $builder;
	}
	
	var page01Btn = {};
	page01Btn[PGL.UTIL.getLocale("GLOSSARY_LOGOUT")] = {"color": false, "action": function(){PGL.UTIL.logout();}};
	page01Btn[PGL.UTIL.getLocale("F-GL-01_GS_BTN_GAME_PLAY")] = {"color": true, "action": function(){
							// issue:0000223
							var code = $('.selected').find('.roundedOne').data("role");
							PGL.REQUEST.postAPI("SELECT_G_SIDC",{"savedataId":code}).done(function(data){
								window.location.reload();
							});			
						}};

	var page01= {
		"type"    : "noClose",
		"id"      : "",
		"title"   : PGL.UTIL.getLocale("F-GL-01_GS_TITLE"),
		"detail"  : page1Tags,
		"buttons" : page01Btn
	};
	
	PGL.dialog.init(page01);
	PGL.dialog.show();
	
	// issue:0000223
	$('#confirmWindow').on('click', '.panelAccountlist', function () {
		$('.accountContainer .selected').removeClass('selected');
		$(this).addClass('selected');
		//PGL.DATA.SELECT_CODE = $(this).data("role")
	})
}


/*=====================================================
 /////////////////// ポイントの移動 //////////////////
=====================================================*/
PGL.DIALOG.movePoint = function(data)
{
	var steps = ['F-MY-01-10-01_STEP01', 'F-MY-01-10-01_STEP02', 'F-MY-01-10-01_STEP03'];
	
	/* STEP1
	----------------------------------------------------------------------------------------*/
	var page1Tags = function()
	{
		var selectGame,noSelectGame;
		PGL.DATA.SELECT_ROM;
		$.each(data.savedataList,function()
		{
			var tags = 
			[
				'<div class="move',this.romId,'">',
					'<p class="currentPointTitle">',PGL.UTIL.getLocale("GLOSSARY_CURRENT_PMP"),'</p>',
					'<p class="currentPointDate">',PGL.UTIL.getDateTime(this.mileLastUpdateDate),'</p>',
					'<p class="movePoint font-face-1">',PGL.UTIL.addComma(this.mile),'</p>',
					$('<div></div>').append($('<div></div>').savedataBox(this, { vertical:true })).html(),
				'</div>'
			].join("");
			if(this.selected=="1"){
				selectGame = tags
				PGL.DATA.SELECT_ROM = this.romId;
			}
			else{
				PGL.DATA.TO_SAVEDATA = this.savedataId;
				noSelectGame = tags;
			}
		});
		
		var markup = 
		[
			'<p class="alingR mb05"><a href="" class="icon-question colorText02">',PGL.UTIL.getLocale("F-MY-01-10-01_BTN_DETAIL"),'</a></p>',
			'<div class="contentBox">',
			'<div class="mb10">',
			'<ul class="steps"></ul>',
			'</div>',
			'<div class="milePointStatus clearFix">',
			'<div class="half">',
			'<p>',PGL.UTIL.getLocale("F-MY-01-10-01_INPUT_POINT"),'</p>',
			'</div>',
			'<div class="half">',
			'<input type="text" value="" name="" id="inputMilePoint">',
			'</div>','</div>',
			'<div class="pointChangeBox clearFix">',
			selectGame,noSelectGame,
			'</div>','</div>'
		].join("");
		
		var $markup = $(markup);
		$markup.find('.steps').stepList(steps, 0, true);
		return $markup;
	}
	
	var page1Btn = {}
	page1Btn[PGL.UTIL.getLocale("F-MY-01-10-01_BTN_MOVE")] = {"color": true, "action": function()
	{
		// issue:0000764
		if (!$('#confirmWindow .confButton:first').is('.disabled')) {
			PGL.DATA.POINT = parseInt($("#inputMilePoint").val());
			// issue:0001704
			if (isSendablePmpValue(PGL.DATA.POINT)) {
				PGL.dialog.change(page02);
			}
		}
	}}
	
	var page01 = {
		"type"    : "",
		"id"      : "DIALOG_POINT",
		"title"   : PGL.UTIL.getLocale("F-MY-01-10-01_WIN_TITLE"),
		"detail"  : page1Tags,
		"buttons" :	page1Btn
	}
	
	/* STEP2
	----------------------------------------------------------------------------------------*/
	
	var page2Tags = function()
	{
		var selectGame,noSelectGame;
		$.each(data.savedataList,function()
		{
			var point = (this.selected=="1")? parseInt(this.mile)-PGL.DATA.POINT:parseInt(this.mile)+PGL.DATA.POINT;
			var tags = 
			[
				'<div class="move',this.romId,'">',
				'<p class="currentPointTitle">',PGL.UTIL.getLocale("F-MY-01-10-01_STEP02_POINT_FROM"),'</p>',
				'<p class="noCurrentPointDate">&nbsp;</p>',
				'<p class="movePoint colorText02 font-face-1">',PGL.UTIL.addComma(point),'</p>',
				$('<div></div>').append($('<div></div>').savedataBox(this, { vertical:true })).html(),
				'</div>'
			].join("");
			(this.selected=="1")? selectGame = tags:noSelectGame = tags;
		});
		
		// issue:0001500
		var markup = 
		[
			'<p class="alingR mb05"><a href="" class="icon-question colorText02">',PGL.UTIL.getLocale("F-MY-01-10-01_BTN_DETAIL"),'</a></p>',
			'<div class="contentBox step2">',
			'<div class="mb10">',
			'<ul class="steps"></ul>',
			'</div>',
			'<div class="milePointStatus clearFix">',
			'<div class="half">',
			'<p>',PGL.UTIL.getLocale("F-MY-01-10-01_CONFIRM"),'</p>',
			'</div>',
			'<div class="half">',
			'<div id="inputMilePoint2">',PGL.UTIL.addComma(PGL.DATA.POINT),'</div>',
			'</div>','</div>',
			'<div class="pointChangeBox clearFix">',
			selectGame,noSelectGame,
			'</div>','</div>'
		].join("");
		
		var $markup = $(markup);
		$markup.find('.steps').stepList(steps, 1, true);
		return $markup;
	}
	
	var page2Btn = {};	
	page2Btn[PGL.UTIL.getLocale('GLOSSARY_ACTION_PREV')] = {"color": false, "action": function(){ 
		PGL.dialog.prev();
		$("#inputMilePoint2").removeClass("error");
	}}
	page2Btn[PGL.UTIL.getLocale("GLOSSARY_ACTION_APPLY")] = {"color": true, "action": function(){
		$('.milePointStatus>div>p>#errorCodeMessage').remove();
		// issue:0001558
		PGL.REQUEST.postAPI("MOVE_POINT", {point:PGL.DATA.POINT ,savedataIdTo:PGL.DATA.TO_SAVEDATA})
		.done(function(data){
			
			if(data.status_code != "1000"){
				var noSelectRom = (PGL.DATA.SELECT_ROM==25)? 24:25;
				var romName = { 24:PGL.UTIL.getLocale('GLOSSARY_TITLE_X'), 25:PGL.UTIL.getLocale('GLOSSARY_TITLE_Y') }
				
				var obj = {
					TITLE_FROM:romName[PGL.DATA.SELECT_ROM],
					TITLE_TO:romName[noSelectRom],
					PMP:'<span class="movePoint colorText02 font-face-1">'+PGL.UTIL.addComma(PGL.DATA.POINT)+'</span>'						
				}
				PGL.DATA.STEP3_MES = PGL.UTIL.replace(obj,PGL.UTIL.getLocale("F-MY-01-10-01_COMPLETE"));
				
				$("#inputMilePoint2").removeClass("error");
				PGL.dialog.change(page03);
			}else{
				PGL.ERROR_HANDLER(data)
			}			
		})
	}}
	
	var page02 = {
		"type"    : "",
		"id"      : "DIALOG_POINT",
		"title"   : PGL.UTIL.getLocale("F-MY-01-10-01_WIN_TITLE"),
		"detail"  : page2Tags,
		"buttons" :	page2Btn
	}
	
	/* STEP3
	----------------------------------------------------------------------------------------*/
	
	var page3Tags = function()
	{
		var selectGame,noSelectGame;
		$.each(data.savedataList,function()
		{
			var point = (this.selected=="1")? parseInt(this.mile)-PGL.DATA.POINT:parseInt(this.mile)+PGL.DATA.POINT;
			var tags = 
			[
				'<div class="move',this.romId,'">',
				'<p class="currentPointTitle">',PGL.UTIL.getLocale("F-MY-01-10-01_STEP03_POINT_FROM"),'</p>',
				'<p class="noCurrentPointDate">&nbsp;</p>',
				'<p class="movePoint colorText02 font-face-1">',PGL.UTIL.addComma(point),'</p>',
				$('<div></div>').append($('<div></div>').savedataBox(this, { vertical:true })).html(),
				'</div>'
			].join("");
			(this.selected=="1")? selectGame = tags:noSelectGame = tags;
		});
		
		var markup = 
		[
			'<p class="alingR mb05"><a href="" class="icon-question colorText02">',PGL.UTIL.getLocale("F-MY-01-10-01_BTN_DETAIL"),'</a></p>',
			'<div class="contentBox">',
			'<div class="mb10">',
			'<ul class="steps"></ul>',
			'</div>',
			'<div class="milePointStatus clearFix">',
           	//'<p>kujiraからkujira2へポケマイルポイント<span class="movePoint colorText02 font-face-1">',PGL.UTIL.addComma(PGL.DATA.POINT),'</span>の移動が完了しました。</p>',
           	'<p>',PGL.DATA.STEP3_MES,'</p>',
            '</div>',
			'<div class="pointChangeBox clearFix">',
			selectGame,noSelectGame,
			'</div>','</div>'].join("");
		
		var $markup = $(markup);
		$markup.find('.steps').stepList(steps, 2, true);
		return $markup;
	}
	
	var page3Btn = {}
	page3Btn[PGL.UTIL.getLocale("GLOSSARY_ACTION_CLOSE")] = {"color": false, "action": function(){ location.reload()}}
	
	var page03 = {
		"type"    : "noClose",
		"id"      : "DIALOG_POINT",
		"title"   : PGL.UTIL.getLocale("F-MY-01-10-01_WIN_TITLE"),
		"detail"  : page3Tags,
		"buttons" :	page3Btn
	}

	PGL.dialog.init(page01);
	PGL.dialog.show();
	
	// issue:0000764,0001704
	var isSendablePmpValue = (function (currentPmp) {
		return function (value) {
			return /^[1-9]\d*$/.test(value) && parseInt(value) <= currentPmp;
		};
	})($.grep(data.savedataList, function (s) { return s.selected == '1'; })[0].mile);
	
	$('.confButton:eq(0)').addClass('disabled');
	$('#inputMilePoint').on('change keydown keyup', function () {
		$('.confButton:eq(0)').toggleClass('disabled', !isSendablePmpValue($(this).val()));
	});
}

/*=====================================================
 //////////////// ダイアログを閉じる //////////////////
=====================================================*/
PGL.DIALOG.modelClose = function(title,message)
{
	var pageBtn = {}
	pageBtn[PGL.UTIL.getLocale("GLOSSARY_ACTION_CLOSE")] = function(){
		PGL.dialog.hide()
	}
	
	return {
		"type"    : "",
		"title"   : title,
		"detail"  : message,
		"buttons" : pageBtn
	}
}


/*=====================================================
 //////////////// ダイアログ（更新） //////////////////
=====================================================*/
PGL.DIALOG.modelReload = function(title,message)
{
	var pageBtn = {}
	pageBtn[PGL.UTIL.getLocale("GLOSSARY_ACTION_CLOSE")] = function(){
		location.reload()
	}
	return {
		"type"    : "",
		"title"   : title,
		"detail"  : message,
		"buttons" : pageBtn
	}
}


/*=====================================================
 //////////////// エラー分岐処理　　 //////////////////
=====================================================*/

PGL.ERROR_HANDLER = function(data){
	
	switch(data.error.code){
			
		case "0020":
		case "0021":
			// issue:0001558
			$('.milePointStatus>div>p>#errorCodeMessage').remove();
			var message = [
				'<span id="errorCodeMessage">',
					PGL.UTIL.getModelTextObj("error_code",data.error.code),
				'</span>'
			].join("")
			// issue:0001838
			$(".step2 .milePointStatus>div>p").append(message);
			$("#inputMilePoint2").addClass("error");
		break;
	}	
}

