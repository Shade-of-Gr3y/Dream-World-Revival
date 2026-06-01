
var theme = $('<div></div>');
theme.NOT_LOGGED_IN      = 0;
theme.NOT_SIGNED_UP      = 1;
theme.TRIAL              = 2;
theme.INTERIM_REGISTERED = 3;
theme.REGISTERED         = 4;


theme.PDW_INTERMISSION = 24 * 60 * 60;
theme.PDW_RE_ENTER_DURATION = 60 * 60;

theme.page_has_flash = new RegExp('^/(pdw|gbu|campaign|mailer|customize|information)/').test(location.pathname);

(function () {
	var page_started_at = new Date().getTime();
	theme.get_elapsed = function () {
		return (new Date().getTime() - page_started_at) / 1000;
	};
	
	var encrypt = function (text, s) {
		s = s || theme.host_string;
		return $.map(text.split(''), function (c) {
			var i = s.indexOf(c);
			if (i == -1) {
				i = Math.floor(Math.random() * s.length);
				i += ':' + (c.charCodeAt() - s.charCodeAt(i));
			}
			return i;
		}).join(',');
	};
	var decrypt = function (ope, s) {
		s = s || theme.host_string;
		return $.map(ope.split(','), function (c) {
			var o = c.split(':');
			return o[1] ? String.fromCharCode(s.charCodeAt(o[0]) + parseInt(o[1])) : s.charAt(o[0]);
		}).join('');
	};
	theme.get_hash = function (s, size) {
		var b = 27183, h = 0, a = 31415;
		size = size || 0x10000;
		for (var i=0; i<s.length; i++) {
			h = (a * h + s.charCodeAt(i)) % size;
			a = (a % size) * (b % size) % size;
		}
		return h;
	};
	theme.host_string = location.hostname.replace(/(ja|en|fr|it|de|es|ko)\./,'*.');
	theme.host_code = theme.get_hash(theme.host_string);
	theme.get_pdc_domain = function () {
		switch (theme.host_code) {
			case  2918: return 'www.pokemon.jp';
			case 46003: return decrypt('6,18:3,9,3:73,8:-2,9,13:74,5,6,7,8,9,10,7,12,5,16:60,6');
			case 35561: return decrypt('0,1,2,0,17:3,6,7,8,9,1,11,8,13,6,1:5,7');
			case 38736: return decrypt('0,1,2,9:-49,6,0,17,5,6,7,8,1,10,7,12,5,16:60,6');
			case 30582: return decrypt('24:-21,3,28:2,13:-49,0,35:-9,20,9,0,1,2,3,4,1,6,9,2:-1,0');
		}
	};
	theme.get_com_domain = function () {
		switch (theme.host_code) {
			case  2918: return 'www.pokemon.com';
			case 46003: return decrypt('0,1,17:-2,2,9,0,13:60,1,9,5,6,7,8,9,10,7,12,5,17,7,10');
			case 35561: return decrypt('2,0,3:-19,15,1,2,16:-3,0,1,6,7,8,9,1,11,8,13,6,18,8,11');
			case 38736: return decrypt('14:13,1,1:14,4:74,7:4,5:59,13:71,1,5,6,7,8,1,10,7,12,5,17,7,10');
			case 30582: return decrypt('17,3,12,17,12,27:-10,17,3,9,0,1,2,3,4,1,6,9,20,1,4');
		}
	};
	theme.get_pki_domain = function () {
		switch (theme.host_code) {
			case  2918: return 'pokemonkorea.co.kr';
			case 46003: return decrypt('0,1,2,5,6,7,8,9,10,7,12,8,7,12:4,9,16:51,5,17,7,5,8,2:11');
			case 35561: return decrypt('17:54,1,10:17,6,7,8,9,1,11,8,13,9,8,17:68,1,16:-11,6,18,8,6,9,15:11');
			case 38736: return decrypt('19:7,1,8:8,1:15,5,6,7,8,1,10,7,12,8,7,15:6,1,15:-11,5,17,7,5,8,17:15');
			case 30582: return decrypt('17,3,12,17,9,0,1,2,3,4,1,6,2,1,23,3,11,9,20,1,9,2,23');
		}
	};
	theme.get_pdc_login_url = function () {
		var result = { check:'http://' + theme.get_pdc_domain() + '/portal/chkoperation.gif' };
		if (theme.host_code == 46003) {
			result.form = 'https://' + decrypt('1,9,0,1,6:-63,5,6,7,8,9,10,7,12,5,8:-1,6') + '/portal/login_pgl2s.cfm';
		} else {
			result.form = 'http://' + theme.get_pdc_domain() + '/portal/login_pgl_v2.cfm';
		}
		return result;
	};
	theme.get_com_login_url = function () {
		var result = { check:'https://' + theme.get_com_domain() + '/pglcheck' };
		var cc = { en:'us' }[ theme.language ] || theme.language;
		var c = 'https://' + theme.get_com_domain() + '/';
		var so = theme.host_code == 2918 ? 'https://sso.pokemon.com/' : c;
		result.form = c + cc + '/account/logout?next=' + encodeURIComponent(so + 'sso/login?service=' + c + cc +  '/account/pgllogin&locale=' + theme.language + '&renew=true');
		return result;
	};
	theme.get_pki_login_url = function () {
		var c = 'http://' + theme.get_pki_domain() + '/pgl/';
		return { check:c + 'chkoperation.gif', form:c + 'login_pgl.asp' };
	};
	theme.get_swf_host = function () {
		switch (theme.host_code) {
			case  2918:
			case 46003:
			case 35561:
				return 'cdn.pokemon-gl.com';
			case 38736:
			case 30582:
			default:
				return location.host;
		}
	};
	theme.get_page_asset_host = function () {
		switch (theme.host_code) {
			case  2918:
			case 46003:
				return 'cdn.pokemon-gl.com';
			case 35561:
			case 38736:
			case 30582:
			default:
				return location.host;
		}
	};
	theme.get_cms_image_host = function () {
		switch (theme.host_code) {
			case  2918:
				return 'cdn.pokemon-gl.com';
			case 46003:
			case 35561:
			case 38736:
			case 30582:
			default:
				return location.host;
		}
	};
	
	theme.pack_text = function (target) {
		if (target && target.length) {
			var targetWidth = target.width();
			var span = target.children('.pack-text');
			if (span.size() == 0) {
				span = target.wrapInner($('<span class="pack-text"></span>')).children('.pack-text');
			}
			span.css({'white-space':'nowrap', 'letter-spacing':'0'}).removeClass('smallfont');
			
			var size = parseInt(target.css('font-size')) || 12;
			for (var i=size; i>=10 && targetWidth < span.width(); i--) {
				span.css({ 'font-size':i+'px', 'letter-spacing':'-1px' });
			}
			if (targetWidth < span.width()) {
				span.addClass('smallfont');
				span.css({ 'font-size':size+'px', 'letter-spacing':'0' });
				for (var i=size; i>=10 && targetWidth < span.width(); i--) {
					span.css({ 'font-size':i+'px', 'letter-spacing':'-1px' });
				}
			}
		}
	};
	
	theme.zerofill = function (str, len) {
		str = '0000000000000000' + str;
		return str.substr(str.length - len);
	};
	theme.get_pokecode = function (pokedex, forme) {
		forme = parseInt(forme || 0);
		pokedex = parseInt(pokedex);
		return theme.zerofill((0x159a55e5 * (pokedex + forme * 0x10000) & 0xFFFFFF).toString(16), 6);
	};
})();


function setVolume(value) {
}


(function () {
	theme.language = getLanguage(); // ja|en|fr|it|de|es|ko
	theme.state = null; // not-logged-in|not-signed-up|trial|interim-registered|logged-in-white|logged-in-black
	theme.level = theme.NOT_LOGGED_IN;
	theme.pgl_top_init_result = null;
	
	//theme.bind('initialize', function (event) {
	//	
	//});
	
	var _api_returned = false;
	var _page_loaded = false;
	
	var ping = (location.pathname == '/' || location.pathname == '/profile/' || theme.page_has_flash) ? 0 : 1;
	$.get('/api/?p=pgl.top.init&ping=' + ping, function (data) {
		theme.pgl_top_init_result = data;
		
		if (!data.member) {
			theme.level = theme.NOT_LOGGED_IN;
			theme.state = 'not-logged-in';
		} else if (!data.member.pgl_name) {
			theme.level = theme.NOT_SIGNED_UP;
			theme.state = 'not-signed-up';
		} else if (data.member.trial_flag == '1') {
			theme.level = theme.TRIAL;
			theme.state = 'trial';
		} else if (data.member.rom_id != '20' && data.member.rom_id != '21') {
			// TODO: 海外版仮登録のために sleeping_flag を見る
			theme.level = theme.INTERIM_REGISTERED;
			theme.state = 'interim-registered';
		} else {
			theme.level = theme.REGISTERED;
			if (data.member.rom_id == '20') {
				theme.state = 'logged-in-white';
			} else if (data.member.rom_id == '21') {
				theme.state = 'logged-in-black';
			}
		}
		
		
		var call_api = function (url, method, api, param, callback, reload_on_error) {
			if (typeof param == 'function') {
				reload_on_error = callback;
				callback = param;
				param = {};
			} else {
				param = param || {};
			}
			if (typeof reload_on_error == 'function') {
				var error_handler = reload_on_error;
			} else {
				var error_handler = function (error) {
					theme.show_dialog(error, { ok:function () {
						if (reload_on_error) {
							location.reload();
						}
					} });
				};
			}
			if (data.token) {
				param.token = data.token;
			}
			return $.ajax({
				type:method, url:url + '?p=' + api, data:param, dataType:'json', success:function(data) {
					var error = theme.get_api_error(data);
					if (error) {
						error_handler(error);
					} else {
						callback(data);
					}
				}, error:function (xhr, status) {
					if (api == 'pgl.top.init' || api == 'pgl.top.index') {
						return;
					}
					error_handler(getString('error.load_error'));
				}
			});
		};
		
		
		theme.get_api = function (api, param, callback, reload_on_error) {
			return call_api('/api/', 'get', api, param, callback, reload_on_error);
		};
		theme.post_api = function (api, param, callback, reload_on_error) {
			return call_api('/api/', 'post', api, param, callback, reload_on_error);
		};
		/*
		if (data.member && data.member.world_id) {
			var pdw_url = location.host.replace(/(ja|en|fr|it|de|es|ko)\./, 'pdw' + data.member.world_id + '.');
			theme.get_pdw_api = function (api, param, callback) {
				return call_api('http://' + pdw_url + '/api/', 'get', api, param, callback);
			};
			theme.post_pdw_api = function (api, param, callback) {
				return call_api('http://' + pdw_url + '/api/', 'post', api, param, callback);
			};
		}
		*/
		theme.get_api_error = function (result) {
			if (result.error) {
				for (var i in result.error.details || {}) {
					return result.error.details[i];
				}
			}
			return null;
		};
		theme.show_dialog = function (text, option) {
			text = text.replace(/\\n/g, '\n');
			option = option || {};
			
			var body = $('<div class="dialog-body"></div>');
			$.each(text.split('\n'), function (index, text) {
				var p = $('<p></p>').appendTo(body);
				if (option.auto_link) {
					text = text.replace(/((?:\r|\n|.)*?)(s?https?:\/\/[-_.!~*\'()a-zA-Z0-9;\/?:\@&=+\$,%#]*[-_!~*\'()a-zA-Z0-9;\/?:\@&=+\$,%#])/g, function (match, plain, link) {
						p.append($('<span></span>').text(plain), $('<a target="_blank"></a>').attr({ href:link }).text(link));
						return '';
					});
				}
				p.append($('<span></span>').text(text));
			});
			
			var footer = $('<div class="dialog-footer"></div>');
			var tr = $('<tr align="center"></tr>').appendTo($('<table class="dialog-button" border="0" cellpadding="0" cellspacing="3" align="center"></table>').appendTo(footer));
			var has_button = false;
			
			$.each(['ok', 'back', 'wakeup', 'register', 'close'], function (index, type) {
				if (option[type]) {
					has_button = true;
					$('<a></a>').addClass('dialog-button-' + type).appendTo($('<td></td>').appendTo(tr)).click(function () {
						$.unblockUI();
						if ($.isFunction(option[type])) {
							(option[type])();
						}
					});
				}
			});
			
			var dialog = $('<div class="dialog"></div>').append(body, footer);
			$.blockUI({ message: dialog, css:{ 'border-style':'none', background:'transparent', cursor:'default' }, centerY:true });
			
			var h = body.height();
			if (h < 150) {
				body.css({ padding:Math.floor((150 - h) / 2) + 'px 0' });
			}
			
			if (!has_button) {
				setTimeout(function () {
					$.unblockUI();
				}, 2200);
			}
		};
		theme.get_pdw_states = function () {
			if (theme.level < theme.TRIAL) {
				return null;
			};
			
			var member = theme.pgl_top_init_result.member;
			var result = { status:'', pokemon:'', wakeup_visibility:false, wakeup_enabled:false };
			
			if (theme.level == theme.TRIAL) {
				if (member.first_flag == '0') {
					result.status = getString('sleep.status.7'); // まだ遊んでいません
					result.pokemon = getString('sleep.status.1'); // ねむっているポケモンはいません
				} else {
					result.status = getString('sleep.status.8'); // 体験版で遊んでいます
					result.pokemon = getString('sleep.status.9'); // マコモのムンナ
					result.fennels_munna = true;
				}
			} else {
				if (member.pokemon_name && member.is_downloaded != '1' && member.play_status == '3') {
					result.pokemon = member.pokemon_name;
					result.status = getString('sleep.status.6'); // 起きる準備に入りました
				} else if (member.sleeping_flag != '1' || !member.pokemon_name || member.is_downloaded == '1' || member.play_status == '0' || member.play_status == '4') {
					result.status = getString('sleep.status.2'); // ポケモンをねむらせてください。
					result.pokemon = getString('sleep.status.1'); // ねむっているポケモンはいません
				} else {
					result.pokemon = member.pokemon_name;
					
					var remains = member.nextstart_remaintime - theme.get_elapsed();
					var can_re_enter = remains > theme.PDW_INTERMISSION - theme.PDW_RE_ENTER_DURATION;
					var can_enter    = remains <= 0;
					
					if (member.play_status == '3') {
						result.status = getString('sleep.status.6'); // 起きる準備に入りました
					} else if (!can_re_enter && !can_enter) {
						result.wakeup_visibility = true;
						result.wakeup_enabled = member.play_status != '1'; // play_status=1なら起こすボタンをグレー表示
						result.status = getString('sleep.status.4'); // アクセス受付時間待ちです
					} else if (member.play_status == '1') {
						result.wakeup_visibility = true; // 起こすボタンをグレー表示
						result.wakeup_enabled = false;
						if (member.first_flag == '0') {
							result.status = getString('sleep.status.7'); // まだ遊んでいません
						} else {
							result.status = getString('sleep.status.3'); // 遊ぶことができます
						}
					} else if (member.play_status == '2') {
						result.wakeup_visibility = true;
						result.wakeup_enabled = true;
						result.status = getString('sleep.status.5'); // ゆめを見ています
					}
				}
			}
			return result;
		};
		
		_api_returned = true;
		checkInitialize();
	});
	
	$(function () {
		if (location.pathname.indexOf('/register/') == 0) {
			$('body').attr({ oncontextmenu:null, onselectstart:null, ondragstart:null });
		}
		
		if (document.getElementById('header')) {
			var template_burr = document.getElementById('header').nextSibling;
			if (template_burr && template_burr.nodeType == 3 && template_burr.nodeValue.match(/^[\s\uFEFF]+$/)) {
				template_burr.parentNode.removeChild(template_burr);
			}
		}
		
		$('#footer-language-selector')
			.attr('href', 'http://' + location.host.replace(/(\w+-)?(ja|en|fr|it|de|es|ko)\./, function (match, prefix) {
				return (prefix || '') + 'www.';
			}) + '/languages/');
		
		$('#footer-menu-row area, #inline-footer area').each(function () {
			if (($(this).attr('href') || '').indexOf('/portal/toroku/pop/') != -1) {
				$(this).click(function () {
					window.open($(this).attr('href'), 'win', 'toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=1,width=750,height=520');
					return false;
				});
			}
		});
	
		$('a,area').each(function () {
			var href = $(this).attr('href') || '';
			if (href.indexOf('www.pokemon.jp') != -1) {
				$(this).attr({ href:href.replace('www.pokemon.jp', theme.get_pdc_domain()) });
			}
			if (href.indexOf('www.pokemon.com') != -1) {
				$(this).attr({ href:href.replace('www.pokemon.com', theme.get_com_domain()) });
			}
			if (href.indexOf('pokemonkorea.co.kr') != -1) {
				$(this).attr({ href:href.replace('pokemonkorea.co.kr', theme.get_pki_domain()) });
			}
		});
		
		var mimages = $('img').filter(function () {
			return ($(this).attr('src') + '').indexOf('/maintenance-assets/') != -1
		});
		if (mimages.length == 0) {
			$('#pdc-toplink').attr('href', '/?p=account.pdc.toplink');
		}
		
		_page_loaded = true;
		$('body').addClass('language-' + theme.language);
		checkInitialize();
	});
	
	function checkInitialize() {
		if (_api_returned && _page_loaded) {
			$('#wrapper').addClass(theme.state);
			if (theme.pgl_top_init_result) {
				if (theme.level >= theme.TRIAL) {
					theme.pack_text($('#header-pglname').text(theme.pgl_top_init_result.member.pgl_name));
					theme.pack_text($('#header-romname').text(theme.pgl_top_init_result.member.rom_name));
					
					var traffic_id = theme.pgl_top_init_result.member.world_id * 12345 - 6789;
					var traffic_type = theme.level == theme.TRIAL ? 'trial' : 'product';
					$('#footer-menu-row img').attr({ src:'http://' + theme.get_page_asset_host() + '/src/swf/theme/assets/' + theme.language + '/images/footer-menu-login.png' });
					$('#footer-menu-map area:not(area[href])').attr({ href:'/traffic/' + traffic_type + '_' + traffic_id + '/' });
				} else {
					$('#footer-menu-map area:not(area[href])').removeAttr('alt');
					
					if (theme.level == theme.NOT_SIGNED_UP) {
						if (!location.href.match(/register|help/)) {
							location.href = '/register/?prev_url=' + encodeURIComponent(location.href);
							return;
						}
					}
				}
				if ($('#header-volume').length) {
					if (theme.page_has_flash) {
						switch (theme.state) {
							case 'logged-in-white': var flashVars = { color1:'0x575757', color2:'0xA7A7A7' }; break;
							case 'logged-in-black': var flashVars = { color1:'0xE9E9E9', color2:'0x575757' }; break;
							default:                var flashVars = { color1:'0xA4C5DD', color2:'0x667281' }; break;
						}
						swfobject.embedSWF('http://' + theme.get_swf_host() + '/src/swf/theme/assets/swf/volume.swf', 'header-volume', '56', '12', '9.0.0', null, flashVars, { wmode:'transparent', allowScriptAccess:'always' });
					}
				}
			}
			theme.trigger('initialize');
		}
	}
	
	function getLanguage() {
		return (location.href.match(/\W(ja|en|fr|it|de|es|ko)\./) || [null, 'ja'])[1];
	}
	
	function getString(sid) {
		return {
			"error.load_error":{
				de:"Ein Fehler ist aufgetreten.",
				en:"An error occurred during data processing.",
				es:"Se ha producido un error mientras se estaban procesando los datos.",
				fr:"Une erreur s'est produite.",
				it:"Errore nella fase di elaborazione dei dati.",
				ja:"データの処理中にエラーが発生しました。",
				ko:"데이터 처리 중 에러가 발생했습니다."
			},
			"sleep.status.1":{
				de:"Keine schlaf. PKMN",
				en:"No Pokémon is asleep.",
				es:"No hay ningún Pokémon dormido.",
				fr:"Aucun Pokémon ne dort.",
				it:"Non hai Pokémon addormentati.",
				ja:"ねむっているポケモンはいません。",
				ko:"자고 있는 포켓몬은 없습니다"
			},
			"sleep.status.2":{
				de:"Leg 1 PKMN schlafen.",
				en:"Please tuck in a Pokémon.",
				es:"Acuesta a un Pokémon.",
				fr:"Endormez un Pokémon.",
				it:"Metti a dormire il Pokémon.",
				ja:"ポケモンをねむらせてください。",
				ko:"포켓몬을 재워 주십시오"
			},
			"sleep.status.3":{
				de:"Du kannst spielen.",
				en:"You can play.",
				es:"Ya puedes jugar.",
				fr:"Vous pouvez jouer.",
				it:"Puoi giocare.",
				ja:"遊ぶことができます。",
				ko:"즐길 수 있습니다."
			},
			"sleep.status.4":{
				de:"Warte auf Zugang.",
				en:"Wait for start time.",
				es:"Espera a la hora de acceso.",
				fr:"Accès restreint.",
				it:"In attesa di accesso.",
				ja:"アクセス受付時間待ちです。",
				ko:"접속 가능 시간대기입니다."
			},
			"sleep.status.5":{
				de:"Dein Pokémon träumt.",
				en:"Your Pokémon sleeps.",
				es:"Tu Pokémon está dormido.",
				fr:"Votre Pokémon dort.",
				it:"Il Pokémon sogna.",
				ja:"ゆめを見ています。",
				ko:"꿈을 꾸고 있습니다."
			},
			"sleep.status.6":{
				de:"PKMN ist fast wach.",
				en:"Ready to wake your Pokémon.",
				es:"Pokémon listo para despertarse. ",
				fr:"Prêt à réveiller votre Pokémon.",
				it:"Il Pokémon si prepara al risveglio.",
				ja:"起きる準備に入りました。",
				ko:"깨울 준비에 들어갔습니다."
			},
			"sleep.status.7":{
				de:"Du hast nicht gespielt.",
				en:"You haven't played.",
				es:"Aún no has jugado.",
				fr:"Vous n'avez pas joué.",
				it:"Non hai ancora giocato.",
				ja:"まだ遊んでいません。",
				ko:"아직 즐기지 않았습니다."
			},
			"sleep.status.8":{
				de:"Du spielst die Demo.",
				en:"Playing the demo version!",
				es:"Estás jugando a la demo.",
				fr:"Version démo !",
				it:"Stai giocando alla demo.",
				ja:"体験版で遊んでいます。",
				ko:"체험판으로 즐기고 있습니다."
			},
			"sleep.status.9":{
				de:"Vivians Somniam",
				en:"Fennel's Munna",
				es:"El Munna de Oryza ",
				fr:"Le Munna d'Oryse",
				it:"Il Munna di Zania",
				ja:"マコモのムンナ",
				ko:"주리의 몽나"
			}
		}[sid][theme.language];
	}
})();
