// JavaScript Document

PGL.setUserStatus = function(code)
{
	PGL.DATA.options = [
		PGL.UTIL.getLocale("GLOSSARY_PRIVACY_SETTING_NOBODY"),
		PGL.UTIL.getLocale("GLOSSARY_PRIVACY_SETTING_FRIENDS"),
		PGL.UTIL.getLocale("GLOSSARY_PRIVACY_SETTING_MEMBERS"),
		PGL.UTIL.getLocale("GLOSSARY_PRIVACY_SETTING_EVERYONE")
	]
	
	PGL.DATA.categories = {
		profile:PGL.UTIL.getLocale("GLOSSARY_ACCOUNT_OPENRANGE_SET"),
		gameSoft:PGL.UTIL.getLocale("GLOSSARY_CONTENT_USER_PROFILE"),
		friend:PGL.UTIL.getLocale("GLOSSARY_CONTENT_USER_FRIENDLIST"),
		timeline:PGL.UTIL.getLocale("GLOSSARY_CONTENT_USER_TIMELINE"),
		medal:PGL.UTIL.getLocale("GLOSSARY_CONTENT_USER_MEDAL"),
		gbu:PGL.UTIL.getLocale("GLOSSARY_CONTENT_BATTLE"),
		internetMatchup:PGL.UTIL.getLocale("GLOSSARY_CONTENT_USER_COMPETITIONS"),
		gts:PGL.UTIL.getLocale("GLOSSARY_CONTENT_USER_GTS"),
		photo:PGL.UTIL.getLocale("GLOSSARY_CONTENT_USER_PHOTO")
	};
	
	// GUSヘッダー
	PGL.createGusHeader();
		
	// フッター生成
	PGL.createFooterModel();
	$("body").on("click",".logout",PGL.UTIL.logout);
	
	if(location.pathname.indexOf("regulation")!=-1){
		var markup = 
		[
			'<div id="headerIn" class="regulation">',
			'<h1><a><img src="/3ds.pokemon-gl.com/under_maintenance/pc/common/images/templates/logo_regulation.png" /></a></h1>',
			'<p><a class="btnGrSmall　close">閉じる</a></p>',
			'</div>'
		]
		$("header").html(markup.join(''));
	}
	else{
		code = code||0;
		var logo = "";
		switch(PGL.INFO.LANGUAGE_ID){
			case 1: logo = "ja"; break;
			case 3: logo = "fr"; break;
			default: logo = "default"; break;
		}

		switch(PGL.DATA.GET_LOGIN_STATUS.loginStatus){
			case "0":
			case "1":
				var logoName =  "logo_";
			break;
			default: var logoName = "logo_xy_"; break;
		}

		var $builder = $('<div id="headerIn"></div>');
		var $logo = $('<h1/>').append($($('<a/>').attr({"href": '/'})).append($('<img/>').attr({"src": '/under_maintenance/share/images/'+logoName+logo+'.png'}))).appendTo($builder);
		switch(code)
		{
			case 0:
				var listArr = [3,5,6,7];//4がインターネット大会
				PGL.setMenuList(listArr).appendTo($builder);//メニュー追加
				$builder.appendTo("header");
			break;
			
			case 1:
				$builder.find('a>img').unwrap();
				$builder.appendTo("header");
			break;
			
			case 2:
				PGL.setHeaderProfile().appendTo($builder);//プロフィール追加
				var listArr = [0,2,3,5,6,7,8,9]; //4がインターネット大会
				PGL.setMenuList(listArr).appendTo($builder);//メニュー追加
				$builder.appendTo("header");		
			break;
			
			default:
			break;
		}
	}
	
	$('#headerNavigation>p').on('click', function () {
		$('#headerNavigation').toggleClass('open', !$(this).next().is(':visible'));
	});
	$('body').on('mousedown', function (e) {
		if (!$(e.target).parents().andSelf().is('#headerNavigation')) {
			$('#headerNavigation').removeClass('open');
		}
	});
	
	// issue:0002877,0001549
	if (PGL.UTIL.isDeviceMust3DS()) { // 確実に3DSなら3DSサイトへ
		location = PGL.INFO.PATH.sp.replace(/3ds-sp/, '3ds-3ds') + location.pathname + location.search + location.hash;
	} else if (PGL.UTIL.isDeviceMustSP()) { // 確実にspならspサイトへ
		location = PGL.INFO.PATH.sp + location.pathname + location.search + location.hash;
	} else if (PGL.UTIL.isDeviceMaySP()) { // spと思われる場合は提案
		if ($.cookie('skip-device-nav') != 'true') {
			$('<div id="device-specific-site-nav"></div>').prependTo('body');
			$('<a></a>').text('スマートフォン向けのサイトに切り替える')
				.attr({ href:PGL.INFO.PATH.sp + location.pathname + location.search + location.hash }).appendTo('#device-specific-site-nav');
			$('<a class="close">×</a>').appendTo('#device-specific-site-nav').on('click', function () {
				$('body').animate({ 'margin-top':0 }, 150);
				$.cookie('skip-device-nav', 'true');
			});
			$('body').animate({ 'margin-top':33 }, 150);
		}
	}
}

//Menu生成
PGL.setMenuList = function(listArr){
	var navigationObj = [
		{title:PGL.UTIL.getLocale("GLOSSARY_CONTENT_MYPAGE"),category:"user"},
		{title:PGL.UTIL.getLocale("GLOSSARY_CONTENT_JOURNAL"),category:"journal"},
		{title:PGL.UTIL.getLocale("GLOSSARY_CONTENT_MILEAGE"),category:"mileage"},
		{title:PGL.UTIL.getLocale("GLOSSARY_CONTENT_BATTLE"),category:"battle"},
		{title:PGL.UTIL.getLocale("GLOSSARY_CONTENT_COMPETITIONS"),category:"competitions"},
		{title:PGL.UTIL.getLocale("GLOSSARY_CONTENT_INFORMATION"),category:"information"},
		{title:PGL.UTIL.getLocale("GLOSSARY_CONTENT_CALENDER"),category:"calendar"},
		{title:PGL.UTIL.getLocale("GLOSSARY_CONTENT_SUPPORT"),category:"support"},
		{title:PGL.UTIL.getLocale("GLOSSARY_CONTENT_SETTINGS"),category:"settings",className:"account"},
		{title:PGL.UTIL.getLocale("GLOSSARY_LOGOUT"),category:"javascript:void(0)",className:"logout"}
	];
	var $nav = $("<nav/>").attr("id","headerNavigation").append($('<p/>').text(PGL.UTIL.getLocale('GLOSSARY_TOP_MENU')));
	var $ul = $("<ul/>");
	$.each(listArr,function(i,v){
		var $li = $("<li/>").append("<a/>");
		var linkPass;
		if(navigationObj[v].category=="user"){
			linkPass = "/"+navigationObj[v].category+"/"+PGL.DATA.SD.memberSavedataIdCode+"/profile/";
		}else{
			linkPass = "/"+navigationObj[v].category+"/";
		}		
		if(navigationObj[v].className != null){
			$li.addClass(navigationObj[v].className);
			if(navigationObj[v].className =="logout"){
				linkPass = navigationObj[v].category;
			}
		}
		var $a = $("a",$li).attr("href",linkPass);
		$a.text(navigationObj[v].title);
		$ul.append($li);
	});
	
	$ul.appendTo($nav);
	return $nav;	
}

//ヘッダー表示プロフィール生成
PGL.setHeaderProfile = function () {
	var logo = PGL.INFO.PATH.logo + 'logo_' + PGL.DATA.SD.romId + '_' + PGL.INFO.LANGUAGE_ID + '.png';
	var $box = $('<div></div>').trainerBox(PGL.DATA.SD).css({ 'background-image':'url(' + logo + ')' });
	$('<div class="lastGameSyncDate"></div>').append(
		$('<div class="value"></div>').text(PGL.UTIL.getDateTime(PGL.DATA.SD.lastGameSyncDate))
	).appendTo($box);
	return $box;
	
	
	var data = PGL.DATA.GET_LOGIN_STATUS.selectedSavedata;
	var $profile = $("<div/>").attr("id","profile").append($("<p/>").addClass("logo")).append($("<p/>").addClass("trainerIcon")).append($("<dl/>").append("<dt/>").append("<dd/>").append("<dd/>")).append($("<p/>").addClass("countryCode"));
	$(PGL.UTIL.logoImg(data.romId)).appendTo($(".logo",$profile));
	$(PGL.UTIL.tranerImg(data.savedataId)).appendTo($(".trainerIcon",$profile));
	$("dt",$profile).text(data.trainerName);
	$($("dd",$profile).get(0)).text(data.memberSavedataIdCode);
	$($("dd",$profile).get(1)).text(PGL.UTIL.getDateTime(data.lastGameSyncDate));
	$(".countryCode",$profile).text(data.countryCode);
	return $profile;
}

PGL.selectGameId = function(data){
	PGL.DIALOG.selectGameId(data);
}

PGL.createGusHeader = function () {
	if (PGL.INFO.REGION != PGL.ENUM.REGION.JP && PGL.INFO.REGION != PGL.ENUM.REGION.KR) {
		// issue:0002896
		var lang = PGL.DATA.GET_LOGIN_STATUS.loginStatus == 0 ? PGL.UTIL.getSelectedLanguage() : PGL.UTIL.getSiteRelatedLanguage();
		var langCode = { '2':'en', '3':'fr', '4':'it', '5':'de', '7':'es' }[ lang ];
		if (langCode == 'en' && PGL.INFO.REGION != PGL.ENUM.REGION.US) {
			langCode += '-uk';
		} else if (langCode == 'fr' && PGL.INFO.REGION == PGL.ENUM.REGION.US) {
			langCode += '-ca';
		} else if (langCode == 'es' && PGL.INFO.REGION == PGL.ENUM.REGION.US) {
			langCode += '-la';
		}
		var gus_src = '/gus.pokemon.com/' + langCode + '/';
		$('body').addClass('gus-embedded').prepend($('<iframe id="gus" border="0" frameborder="0" allowtransparency="true" scrolling="no" marginwidth="0" marginheight="0"></iframe>').attr({ src:gus_src }));
	}
};

PGL.createFooterModel = function () {
	var footer = PGL.UTIL.getFooter();
	var $section = $('<section></section>').appendTo('footer');
	$('<p/>').text(footer.copyright).appendTo($section);
	
	function isSameDomain(url) {
		return url.charAt(0) == '/';
	}
};

PGL.UTIL.getUrlSlice = function (category, index) {
	var p = location.pathname.split('/');
	var i = p.indexOf(category);
	return i != -1 ? p[i + index] : '';
};

PGL.UTIL.getSeasonSummary = function (season) {
	var l1 = PGL.UTIL.getDateTimeS(season.seasonStartDate);
	var l2 = PGL.UTIL.getDateTimeS(season.seasonEndDate);
	var u1 = PGL.UTIL.getDateTimeS(season.seasonStartDateUtc);
	var u2 = PGL.UTIL.getDateTimeS(season.seasonEndDateUtc);
	return [
		season.seasonName,
		PGL.UTIL.concatDateAndTZ(dateSpan(l1, l2), season.timezoneName),
		PGL.UTIL.concatDateAndTZ(dateSpan(u1, u2), 'UTC')
	].join('　');
	function dateSpan(a, b) {
		return a + ' - ' + b;
	}
};


$.fn.extend({
	// issue:0001120,0001215,0001605,0001580
	gsidcInput: function () {
		var forwardFocus = function ($input) {
			if ($input.nextAll('input').length) {
				var v = $input.nextAll('input:first').val();
				$input.nextAll('input:first').val($input.val()).insertBefore($input);
				$input.nextAll('span:first').insertBefore($input);
				$input.val(v).focus();
			}
		};
		var backwardFocus = function ($input) {
			if ($input.prevAll('input').length) {
				var v = $input.prevAll('input:first').val();
				$input.prevAll('input:first').val($input.val()).insertAfter($input);
				$input.prevAll('span:first').insertAfter($input);
				$input.val(v).focus();
			}
		};
		
		var lastInput;
		this.on('input', 'input', function (event) {
			lastInput = $(this).val().replace(/[Ａ-Ｚａ-ｚ０-９]/g, function (s) { return String.fromCharCode(s.charCodeAt() - 0xFEE0); }).replace(/\W/g, '').toUpperCase();
			var component = lastInput.substr(0, 4);
			if ($(this).val() != component) {
				$(this).val(component);
			}
			if (component.length == 4) {
				forwardFocus($(this));
			}
		});
		this.on('keydown', 'input', function (event) {
			if (event.keyCode == 39) {
				if (this.selectionStart >= 4) {
					forwardFocus($(this));
					return false;
				}
			} else if (event.keyCode == 37 || event.keyCode == 8) {
				if (this.selectionStart == 0 && this.selectionEnd == 0) {
					backwardFocus($(this));
					return false;
				}
			}
		});
		this.on('paste', 'input', function (event) {
			var $self = $(this).attr({ maxlength:'' });
			var index = $self.parent().children('input').index($self);
			setTimeout(function () {
				$self.attr({ maxlength:4 });
				$self = $self.parent().children('input').eq(index);
				var remains = lastInput;
				while (remains.length && $self.length) {
					$self.val(remains.substr(0, 4));
					remains = remains.substr(4);
					$self = $self.nextAll('input:first');
					$self.focus();
				}
			}, 1);
		});
		return this;
	},
	
	// issue:0001300
	// ご利用登録、登録解除申請、ポイント移動等で使う
	// ソフトロゴや最終ゲームシンク日時を含むボックスです
	// 該当箇所では必ずこの関数を呼び出すようにしてください
	// 表示上のバリエーション（ご利用登録のSTEP4では地域無し、
	// ポイント移動ではボーダーに色がつく等）は、
	// ページ固有のCSSで行います
	savedataBox: function (savedata, options) {
		options = options || {};
		var logo = PGL.INFO.PATH.logo + 'logo_' + savedata.romId + '_' + savedata.languageId + '.png';
		this.addClass('savedataBox rom-' + savedata.romId).addClass(options.vertical ? 'vertical' : 'horizontal').empty().css({ 'background-image':'url(' + logo + ')' });
		var $gameInfo = $('<div class="gameInfo"></div>').appendTo(this);
		$('<div class="gameSyncIdCode"></div>').append(
			$('<div class="label"></div>').text(PGL.UTIL.getLocale('GLOSSARY_GAME_SYNC_ID_CODE')),
			$('<div class="value"></div>').text(savedata.gameSyncIdCode)
		).appendTo($gameInfo);
		$('<div class="lastGameSyncDate"></div>').append(
			$('<div class="label"></div>').text(PGL.UTIL.getLocale('GLOSSARY_LAST_SYNCED_DATETIME')),
			$('<div class="value"></div>').text(PGL.UTIL.getDateTime(savedata.lastGameSyncDate))
		).appendTo($gameInfo);
		$('<div></div>').trainerBox(savedata).appendTo(this);
		return this;
	},
	
	// savedataBoxやランキング等で使われるトレーナー情報です
	// 該当箇所では必ずこの関数を呼び出すようにしてください
	// 表示上のバリエーションが多いため、
	// CSSは最低限の共通化だけを行いますが
	// HTML構造は共通のものを使います
	trainerBox: function (savedata) {
		return this.each(function (index, element) {
			$(element).addClass('trainerBox').toggleClass('trainerBoxLinked', !!savedata.memberSavedataIdCode).empty();
			$(PGL.UTIL.tranerImg(savedata.savedataId)).addClass('trainerIcon').appendTo(this);
			if (savedata.countryCode) {
				$('<div class="countryCode"></div>').text(savedata.countryCode).appendTo(this);
			}
			if (savedata.trainerNameRuby && savedata.trainerNameRuby != savedata.trainerName) {
				$('<div class="trainerNameRuby"></div>').text(savedata.trainerNameRuby).appendTo(this);
			}
			$('<div class="trainerName"></div>').text(savedata.trainerName).appendTo(this);
			if (savedata.memberSavedataIdCode) {
				$('<div class="savedataIdCode"></div>').text(savedata.memberSavedataIdCode).appendTo(this);
			}
		});
	},
	
	/**
	 * ご利用登録などで使うStepリスト
	 */
	stepList: function (labels, activeIndex, inline) {
		var labelBase = inline ? 'GLOSSARY_STEP' : 'GLOSSARY_ACCOUNT_STEP0';
		return this.each(function (index, element) {
			$(element).addClass('steps').toggleClass('steps-inline', !!inline);
			$.each(labels, function (index2, summary) {
				$('<li></li>').toggleClass('active', index2 == activeIndex).append(
					$('<span class="name"/>').text(PGL.UTIL.getLocale(labelBase + (index2 + 1))),
					$('<span class="summary"/>').squeeze(PGL.UTIL.getLocale(summary))
				).appendTo(element);
			});
		});
	},
	
	/**
	 * ポケマイルポイント等の桁ごとの表示
	 * @param  {Number}  point      ポケマイルポイント
	 * @param  {Number}  length     表示する桁数（デフォルトは11）
	 * @param  {Boolean} isCurrency 通貨かどうか（デフォルトはtrue）
	 */
	digits: function (point, length, isCurrency) {
		if (length == undefined) {
			length = 11;
		}
		if (isCurrency == undefined) {
			isCurrency = true;
		}
		return this.each(function (index, element) {
			$(element).empty();
			var chars = ('\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0\xA0' + PGL.UTIL.addComma(point, isCurrency)).substr(-length);
			$.each(chars.split(''), function (index, char) {
				$('<span/>').text(char.replace(' ', '\xA0')).toggleClass('section', /[ \.,]/.test(char)).appendTo(element);
			});
		});
	},
	
	/**
	 * ポケマイルポイント等の桁ごとの表示（暫定）
	 * @param  {String} text 表示文字列
	 */
	digits2: function (text) {
		return this.each(function (index, element) {
			$(element).empty();
			$.each(text.split(''), function (index, char) {
				var className = /[ \.,]/.test(char) ? 'delimiter' : 'digit';
				$('<span/>').text(char.replace(' ', '\xA0')).addClass(className).appendTo(element);
			});
		});
	},
	
	/**
	 * $('#target').dialog(options)
	 * $('#target').dialog('resize')
	 * $('#target').dialog('remove')
	 * 
	 * 現状のダイアログとの互換性を優先したため、show/hideは無く、使い捨てです。
	 */
	dialog: function (option) {
		// issue:0001970
		$('body').off('focusin').on('focusin', function (e) {
			var $dialog = $('.dialog');
			if ($dialog.length) {
				if (!$(e.target).parents().andSelf().is('.dialog')) {
					$dialog.last().focus();
				}
			}
		});
		
		return this.each(function (index, element) {
			var $this = $(this);
			if (typeof option == 'string') {
				if (option == 'resize') {
					var y = (window.pageYOffset !== undefined) ? window.pageYOffset : (document.documentElement || document.body.parentNode || document.body).scrollTop;
					$this.css({ 'margin-left':$this.data('dialog').width * -0.5, top:Math.max(10, y + (window.innerHeight - $this.height()) / 2) });
				} else if (option == 'remove') {
					$this.parents('.overlay').remove();
				}
			} else if (typeof option == 'object') {
				var options;
				if ($this.data('dialog')) {
					// update
					options = option;
					$this.data('dialog', $.extend({}, $this.data('dialog'), option));
					$this.css({
						'transition-property':'width,top,margin-left',
						'transition-duration':'0.4s',
						'transition-timing-function':'ease-in-out'
					});
				} else {
					// create
					options = $.extend({}, { title:'', content:'<div></div>', width:840, closable:true, buttons:null }, option);
					$this.data('dialog', options);
					
					$this.addClass('dialog');
					$this.children().is('.headBox') || $('<div class="headBox"><span class="title"></span><button class="close"></button></div>').prependTo($this);
					$this.children().is('.bodyBox') || $('<div class="bodyBox"></div>').appendTo($this);
					$this.children().is('.footerBox') || $('<div class="footerBox"></div>').appendTo($this);
					$this.find('.close').on('click', function () {
						$this.dialog('remove');
					});
					if (!$this.parent().is('.overlay')) {
						var $overlay = $('<div class="overlay"></div>').append($this).appendTo('body');
						// Chromeの表示不具合対策
						$overlay.css({ visibility:'hidden' });
						setTimeout(function () {
							$overlay.css({ visibility:'' });
							$this.attr('tabindex', -1).focus();
						}, 1);
					}
				}
				
				if (options.width != null) {
					$this.css({ width:options.width });
				}
				if (options.title != null) {
					$this.find('.headBox .title').text(options.title);
				}
				if (options.content != null) {
					$(options.content).appendTo($this.find('.bodyBox').empty());
				}
				if (options.buttons != null) {
					$this.children('.footerBox').empty();
					$.each(options.buttons, function (index, button) {
						$('<a></a>')
							.attr({ 'class':button.className })
							.addClass(button.primary ? 'btnCrLarge' : 'btnGrLarge')
							.text(button.text)
							.click(function () { button.click.apply($this, arguments); })
							.appendTo($this.children('.footerBox'));
					});
				}
				if (options.closable != null) {
					$this.toggleClass('closable', options.closable);
				}
				
				$this.dialog('resize');
			}
		});
	},
	
	/**
	 * SNSボタンを表示する
	 * @param  {Array} availableSnsList 有効なSNSのリスト（getMypageCommonなどで取得できるsns配列）
	 * @param  {Object} data            SNSに渡るメッセージ等を格納した構造体
	 */
	showSnsButtons: function (availableSnsList, data) {
		var $this = $(this).empty();
		$.each(availableSnsList || [], function (index, sns) {
			var $li = $('<li><a></a></li>').addClass('sns-' + sns.snsType).appendTo($this);
			if (sns.snsType == 0) {
				$li.find('a').on('click', function () {
					alert('Facebookへ渡すパラメータは、サーバサイドで埋め込みを行います');
				});
			} else if (sns.snsType == 1) {
				$li.find('a').on('click', function () {
					prompt('以下の内容がTwitterに渡されます', data.description + ' ' + data.url + ' #pgl');
				});
			}
		});
	},
	
	/**
	 * 写真をsrcに設定する。読み込みが失敗した場合、photo-errorで自身を置き換える
	 * @param  {String} photoId 写真のID
	 */
	photo: function (photoId) {
		return this.each(function (index, element) {
			$(element).addClass('photo').attr({ src:PGL.INFO.PATH.photo + photoId + '.jpeg' }).on('error', function () {
				$(this).wrap('<div class="photo-error"></div>').parent().text(PGL.UTIL.getLocale('GLOSSARY_PHOTO_NOT_EXISTS'));
			});
		});
	}
});

