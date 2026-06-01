
$(function () {
	$('#inline-footer a[href=/www.pokemon-gl.com/languages/]')
		.attr('href', '/es.pokemon-gl.com/languages/');
	
	if ({ en:1, fr:1, it:1, de:1, es:1 }[theme.language]) {
		var gus_src = theme.host_code == 2918 ? '/gus.pokemon.com/' + theme.language + '/' : '/pgl-363/' + theme.language + '/';
		$('body').css({ 'margin-top':56 }).prepend($('<iframe id="gus" border="0" frameborder="0" allowtransparency="true" scrolling="no" marginwidth="0" marginheight="0"></iframe>').attr({ src:gus_src }));
	}
});

theme.bind('initialize', function (event) {
	var volume = 0;
	window.setVolume = function (value) {
		volume = value;
		var swf = window.sound || document.sound;
		if (swf) {
			try {
				swf.setVolume(value);
			} catch (e) {
			}
		}
	};
	window.getVolume = function () {
		return volume;
	};
	
	if (theme.level != theme.NOT_SIGNED_UP) {
		$('<div id="sound"></div>').appendTo($('#wrapper'));
		swfobject.embedSWF('/top-assets/swf/sound.swf', 'sound', '1', '1', '9.0.0');
		swfobject.embedSWF('/src/swf/theme/assets/swf/volume.swf', 'top-volume', '56', '12', '9.0.0', null, { color1:'0x575757', color2:'0xA7A7A7' }, { wmode:'transparent', allowScriptAccess:'always' });
	}
	
	
	var census_list;
	var current_census = 0;
	var current_ranking = 0;
	var rotate_census_timer;
	var pokemon_window_load_check_interval_id;
	
	var chart = createLocalChart($('#pgl-area-info').get(0));
	var pokemon_table = createPokemonTable();
	
	var data = theme.pgl_top_init_result;
	if (theme.level >= theme.NOT_SIGNED_UP) {
		// ログイン済み
		
		// 色に応じたスタイル
		if (data.member.rom_id == '20') {
			$('#inline-footer img').attr({ src:'/es.pokemon-gl.com/src/swf/top-assets/' + theme.language + '/images/footer-white.png' });
		} else if (data.member.rom_id == '21') {
			$('#inline-footer img').attr({ src:'/es.pokemon-gl.com/src/swf/top-assets/' + theme.language + '/images/footer-black.png' });
		} else if (theme.level >= theme.TRIAL) {
			$('#inline-footer img').attr({ src:'/es.pokemon-gl.com/src/swf/top-assets/' + theme.language + '/images/footer-trial.png' });
		} else {
			$('#inline-footer img').attr({ src:'/es.pokemon-gl.com/src/swf/top-assets/' + theme.language + '/images/footer-logout.png' });
		}
		
		if (theme.level >= theme.TRIAL) {
			// ご利用登録済みなら
			
			$('<div class="member-info"><dl></dl></div>').appendTo($('#login-control'));
			$.each(['pglname', 'romname', 'sleptname', 'pdwstatus'], function () {
				$('#login-control .member-info dl')
					.append($('<dt></dt>').attr('class', 'member-info-' + this))
					.append($('<dd></dd>').attr('class', 'member-info-' + this))
			});
			theme.pack_text($('#login-control dd.member-info-pglname').text(data.member.pgl_name));
			
			var pdw = theme.get_pdw_states();
			theme.pack_text($('#login-control dd.member-info-pdwstatus').text(pdw.status));
			theme.pack_text($('#login-control dd.member-info-sleptname').text(pdw.pokemon));
			
			if (pdw.wakeup_visibility) {
				if (pdw.wakeup_enabled) {
					$('<div class="member-info-wakeup swap"><a class="sidebar-ui"></a></div>')
						.click(wakeup)
						.appendTo($('#login-control'));
				} else {
					$('<div class="member-info-wakeup"><span class="sidebar-ui"></span></div>')
						.appendTo($('#login-control'));
				}
			}
			if (data.member.last_up_time) {
				var match = data.member.last_up_time.match(/(\d+)\D+(\d+)\D+(\d+)\D+(\d+)\D*$/);
				if (theme.language == 'ja' || theme.language == 'en' || theme.language == 'ko') {
					var month = match[1];
					var date = match[2];
				} else {
					var month = match[2];
					var date = match[1];
				}
				$('<p class="updated-at"></p>')
					.text(getString('pgltop.member.last_upload').replace('MM', month).replace('DD', date).replace('hh', match[3]).replace('mm', match[4]))
					.appendTo($('#login-control .member-info'));
				if ($('#login-control .updated-at').height() > 19) {
					$('#login-control .updated-at').css({ top:221 });
				}
			}
			
			var update_pdw_link_message = function () {
				var remains = data.member.nextstart_remaintime - theme.get_elapsed();
				var can_re_enter = remains > theme.PDW_INTERMISSION - theme.PDW_RE_ENTER_DURATION;
				var can_enter    = remains <= 0;
				if (can_enter || can_re_enter) {
					$('#pdw-link-message').text(getString('pgltop.accept_time.4')).show();
				} else {
					if (remains <= 60) {
						var text = getString('pgltop.accept_time.3');
					} else if (remains <= 3600) {
						var text = getString('pgltop.accept_time.2').replace(/\[MM\]/, Math.ceil(remains / 60));
					} else {
						var text = getString('pgltop.accept_time.1').replace(/\[HH\]/, Math.ceil(remains / 3600));
					}
					$('#pdw-link-message').text(text).show();
				}
			};
			update_pdw_link_message();
			setInterval(update_pdw_link_message, 5 * 1000);
			
			
			$('<img width="36" height="36" class="member-info-avatar"/>')
				.attr({ src:'/es.pokemon-gl.com/src/swf/top-assets/images/avatar/' + data.member.avator_id + '.png', alt:data.member.avator_name })
				.appendTo($('#login-control .member-info'));
			
			$('<div id="login-menu"></div>')
				.append($('<div class="login-menu-profile swap"><a class="sidebar-ui" href="profile/"></a></div>'))
				.append($('<div class="login-menu-logout swap"><a class="sidebar-ui" href="/es.pokemon-gl.com/?p=logout"></a></div>'))
				.appendTo($('#login-control .member-info'));
			if (location.host.indexOf('pokemon-gl') == -1) {
				$('#login-menu .login-menu-logout a').attr({ href:'/es.pokemon-gl.com/index3?p=logout' });
			}
			
			
			
			// 混雑状況
			var traffic_id = theme.pgl_top_init_result.member.world_id * 12345 - 6789;
			var traffic_type = theme.level == theme.TRIAL ? 'trial' : 'product';
			$('#inline-footer-map area:not(area[href])').attr({ href:'/es.pokemon-gl.com/traffic/' + traffic_type + '_' + traffic_id + '/' });
		} else {
			// ご利用登録前ならregisterに移動するので何もしない
		}
	} else {
		// 未ログインなら
		if (theme.language == 'ja') {
			var login_url = theme.get_pdc_login_url();
		} else if (theme.language == 'ko') {
			var login_url = theme.get_pki_login_url();
		} else {
			var login_url = theme.get_com_login_url();
		}
		
		$('<img/>').attr({ src:login_url.check + '?now=' + new Date().getTime() }).load(function () {
			$('<iframe class="login-frame" border="0" frameborder="0" allowtransparency="true" scrolling="no" marginwidth="0" marginheight="0"></iframe>')
				.attr({ src: login_url.form })
				.appendTo($('#login-control'));
		}).error(function () {
			$('<iframe class="login-frame" border="0" frameborder="0" allowtransparency="true" scrolling="no" marginwidth="0" marginheight="0"></iframe>')
				.attr({ src: '/es.pokemon-gl.com/src/swf/top-assets/' + theme.language + '/images/login-unavailable.png' })
				.appendTo($('#login-control'));
		});
		
		$('#inline-footer img').attr({ src:'/es.pokemon-gl.com/src/swf/top-assets/' + theme.language + '/images/footer-logout.png' });
		$('#inline-footer-map area:not(area[href])').removeAttr('alt');
		
		
		if (document.cookie.match(/was_login_failed=(\w+)/)) {
			theme.show_dialog(getString('pgltop.membership.processing'), { ok:true, auto_link:true });
		}
	}
	
	// ログイン失敗クッキーを削除
	var cookie = 'was_login_failed=;path=/;'
	var domain = location.hostname.replace(/^[-\w]+\.([-\w]+\.[-\w]+)$/, '$1');
	if (domain != location.hostname) {
		cookie += 'domain=' + domain + ';';
	}
	var expires = new Date(); expires.setTime(0);
	cookie += 'expires=' + expires.toGMTString() + ';';
	document.cookie = cookie;
	
	
	update_info();
	
	if (theme.level <= theme.NOT_SIGNED_UP) {
		$('#gbu a, #pdw a, #safemail a, #customize a').attr({ href:'/es.pokemon-gl.com/introduction/' });
	} else {
		$('.contents-link2,#gbu').click(function () {
			if (theme.level == theme.INTERIM_REGISTERED) {
				theme.show_dialog(getString('dialog_29'), { ok:true }); // 仮登録
				return false;
			} else {
				return true;
			}
		});
		
		$('#pdw').click(function () {
			if (theme.level == theme.NOT_SIGNED_UP) {
				theme.show_dialog(getString('new_pdwstart_1'), { ok:true }); // 非会員
				return false;
			} else if (theme.level == theme.INTERIM_REGISTERED) {
				theme.show_dialog(getString('dialog_29'), { ok:true }); // 仮登録
				return false;
			} else {
				var member_data  = theme.pgl_top_init_result.member;
				var remains      = member_data.nextstart_remaintime - theme.get_elapsed();
				var can_re_enter = remains > theme.PDW_INTERMISSION - theme.PDW_RE_ENTER_DURATION;
				var can_enter    = remains <= 0;
				
				if (can_re_enter) {
					return true;
				} else if (can_enter) {
					get_busy_status(function (data) {
						if (data.is_over_capacity == '1') {
							theme.show_dialog(getString('pg_ag_8'), { ok:true });
						} else {
							location = '/pdw/';
						}
					});
				} else {
					if (remains <= 60) {
						var text = getString('pg_af_3');
					} else if (remains <= 3600) {
						var text = getString('pg_af_2').replace(/\[mm2\]/, Math.ceil(remains / 60));
					} else {
						var text = getString('pg_af_1').replace(/\[hh2\]/, Math.ceil(remains / 3600));
					}
					
					var date = new Date();
					date.setTime((parseInt(member_data.last_started_at_timezone) + 9 * 60 * 60) * 1000);
					var repl = {
						MM:date.getUTCMonth() + 1,
						DD:date.getUTCDate(),
						hh:zerofill(date.getUTCHours(), 2),
						mm:zerofill(date.getUTCMinutes(), 2)
					};
					text = text.replace(/\[(MM|DD|hh|mm)\]/g, function (match, code) {
						return repl[code];
					});
					
					var dialog_options = { ok:true };
					if (theme.get_pdw_states().wakeup_enabled) {
						dialog_options.wakeup = wakeup; // ポケモンを起こせるなら「起こす」ボタンを出して
					}
					theme.show_dialog(text, dialog_options); // アクセス受付時間前ダイアログを表示
				}
				return false;
			}
		});
	}
	
	
	createMap();
	
	function wakeup() {
		theme.show_dialog(getString('pgltop.wakeup.confirm'), { ok:function () {
			theme.get_api('pgl.member.profile.pdw_end_by_pgl', function () {
				theme.show_dialog(getString('pgltop.wakeup.complete'), { ok:function () {
					location.reload();
				} });
			}, true);
		}, back:true });
	}
	
	function update_info() {
		theme.get_api('pgl.top.index', function (data) {
			if (typeof data != 'object') {
				return;
			}
			
			$('#information ul').empty();
			$.each(data.news_list, function (index) {
				var link = $('<a></a>').attr({ href:'/es.pokemon-gl.com/information/?infoto=' + this.news_id })
					.css({ display:'block' })
					.append($('<span class="information-icon"></span>').addClass('information-category-' + this.news_category_id));
				if (this.new_flag) {
					link.append($('<span class="information-icon information-icon-new"></span>'));
				}
				link.append($('<span class="date"></span>').text(this.date))
					.append($('<span class="title"></span>').text(this.title));
				
				$('<li></li>').append(link).appendTo($('#information ul'));
				if (this.filename_top) {
					$('<img width="58" height="58" align="left" style="margin-right:4px;"/>').attr({ src:'/es.pokemon-gl.com/src/swf/information/assets/' + theme.language + '/img' + this.filename_top }).prependTo($('.title', link));
					$('<br clear="left"/>').appendTo($('.title', link));
					$('<div style="height:1px;font-size:1px;">&nbsp;</div>').appendTo($('.title', link));
				}
			});
			update_scroller();
			
			census_list = data.census_list;
			
			
			update_census();
			rotate_census_timer = setInterval(rotate_census, 8000);
			
			var color1 = '#3E4447';
			var color2 = '#FFFFFF';
			createGlobalChart($('dd.pgl-stats-chart1').get(0), [
				{ value:data.stats.black, text:color2, fill:color1 },
				{ value:data.stats.white, text:color1, fill:color2 }
			], '/src/swf/top-assets/' + theme.language + '/images/pgl-stats-chart1-label.png');
			createGlobalChart($('dd.pgl-stats-chart2').get(0), [
				{ value:data.stats.male,   text:color2, fill:color1 },
				{ value:data.stats.female, text:color1, fill:color2 }
			], '/src/swf/top-assets/' + theme.language + '/images/pgl-stats-chart2-label.png');
			
			if (theme.language == 'fr') {
				var p = zerofill(data.stats.pgl_population, 9).replace(/(\d{3})(\d{3})(\d{3})/, '$1 $2 $3');
			} else if (theme.language == 'it') {
				var p = zerofill(data.stats.pgl_population, 9).replace(/(\d{3})(\d{3})(\d{3})/, '$1.$2.$3');
			} else if (theme.language == 'es') {
				if (data.stats.pgl_population < 10000) {
					var p = zerofill(data.stats.pgl_population, 9);
				} else {
					var p = zerofill(data.stats.pgl_population, 9).replace(/(\d{3})(\d{3})(\d{3})/, '$1 $2 $3');
				}
			} else {
				var p = zerofill(data.stats.pgl_population, 9).replace(/(\d{3})(\d{3})(\d{3})/, '$1,$2,$3');
			}
			var d = format_time(data.updated_at);
			applyImageFont($('dd.pgl-stats-member').text(p));
			applyImageFont($('#pgl-ranking-updated-at').text(d));
			
			var member = theme.pgl_top_init_result.member;
			if (data.information && member) {
				var show_personal_info_bar = function () {
					$('<div id="personal-information"></div>').text(data.information.information).click(function () {
						theme.show_dialog(data.information.information, { ok:true });
					}).appendTo($('#content').css({ height:'677px' })); // 656+21
				};
				
				var hash = theme.get_hash(data.information.information, 0x1000000);
				var match = document.cookie.match(new RegExp('personal-info-hash-' + member.member_id + '=(\\d+)'));
				if (match && match[1] == hash) {
					// 既読
					show_personal_info_bar();
				} else {
					// 未読
					var cookie = 'personal-info-hash-' + member.member_id + '=' + hash + ';';
					cookie += 'path=/;'
					var domain = location.hostname.replace(/^[-\w]+\.([-\w]+\.[-\w]+)$/, '$1');
					if (domain != location.hostname) {
						cookie += 'domain=' + domain + ';';
					}
					var expires = new Date(); expires.setTime(expires.getTime() + 365 * 24 * 60 * 60 * 1000);
					cookie += 'expires=' + expires.toGMTString() + ';';
					document.cookie = cookie;
					
					theme.show_dialog(data.information.information, { ok:show_personal_info_bar });
				}
			}
		});
	}
	
	$('#information .scroller-down').click(function () {
		var amount = +100000;
		$('#information .scroll-target li').each(function () {
			var top = $(this).position().top;
			if (top > 1) {
				amount = Math.min(amount, top);
			}
		});
		if (amount < 1000) {
			$('#information .scroll-target').animate({ scrollTop: '+=' + amount + 'px' }, 200 + Math.abs(amount) * 3, 'easeInOutCubic', update_scroller);
		}
	});
	$('#information .scroller-up').click(function () {
		var amount = -100000;
		$('#information .scroll-target li').each(function () {
			var top = $(this).position().top;
			if (top < -1) {
				amount = Math.max(amount, top);
			}
		});
		if (amount > -1000) {
			$('#information .scroll-target').animate({ scrollTop: '+=' + amount + 'px' }, 200 + Math.abs(amount) * 3, 'easeInOutCubic', update_scroller);
		}
	});
	
	$('#pgl-ranking-selector a').each(function (index) {
		$(this).click(function () {
			if (index < census_list[current_census].ranking_list.length - 1) {
				current_ranking = index;
				update_census();
				clearInterval(rotate_census_timer);
				rotate_census_timer = setInterval(rotate_census, 8000);
			}
		});
	});
	
	window.stop_rotate_census = function () {
		clearInterval(rotate_census_timer);
		stop_pokemon_window_load_check();
	};
	
	//www.pokemon-gl.com/
	
	
	update_pdw_busy_status();
	setInterval(update_pdw_busy_status, 60 * 1000);
	
	
	function get_busy_status(callback) {
		if (theme.level >= theme.TRIAL) {
			var id = theme.pgl_top_init_result.member.world_id * 12345 - 6789;
			if (theme.level == theme.TRIAL) {
				var url = '/traffic/trial_' + id + '/status.json';
			} else {
				var url = '/traffic/product_' + id + '/status.json';
			}
			$.getJSON(url, { time:new Date().getTime() }, callback);
			return true;
		}
		return false;
	}
	
	
	function update_pdw_busy_status() {
		get_busy_status(function (data) {
			$('#pdw-link-badge')
				.removeClass('busy-status-0')
				.removeClass('busy-status-1')
				.removeClass('busy-status-2')
				.addClass('busy-status-' + data.condition)
				.show();
		});
	}
	
	
	function rotate_census() {
		current_ranking++;
		if (current_ranking >= Math.min(5, census_list[current_census].ranking_list.length)) {
			current_ranking = 0;
			current_census++;
			if (current_census >= census_list.length) {
				current_census = 0;
			}
		}
		update_census();
	}
	
	window.show_pokemon_info = function (pokedex, pokename) {
		var pokedex3 = zerofill(pokedex, 3);
		var pokemon = pokemon_table[pokedex3] || {};
		
		if (theme.language == 'en') {
			var height = pokemon.ft;
			var weight = pokemon.lb;
		} else if (theme.language == 'fr' || theme.language == 'it' || theme.language == 'es') {
			var height = pokemon.m.replace(/^(\d+)\.(\d+)m$/, '$1,$2 m');
			var weight = pokemon.kg.replace(/^(\d+)\.(\d+)kg$/, '$1,$2 kg');
		} else {
			var height = pokemon.m;
			var weight = pokemon.kg;
		}
		
		$('#pokemon-window .pokemon-window-info .pokemon-name').text(pokename);
		$('#pokemon-window .pokemon-window-info .pokemon-number').text(pokedex3);
		theme.pack_text($('#pokemon-window .pokemon-window-info .pokemon-height').text(height || ''));
		theme.pack_text($('#pokemon-window .pokemon-window-info .pokemon-weight').text(weight || ''));
		$('#pokemon-window .pokemon-window-image').empty().append($('<img width="92" height="92"/>').attr('src', '/es.pokemon-gl.com/src/swf/top-assets/images/pokemon/' + theme.get_pokecode(pokedex) + '.png'));
		$('#pokemon-window .pokemon-window-info .pokemon-footstamp').empty().append($('<img/>').attr('src', '/es.pokemon-gl.com/src/swf/top-assets/images/footprint/' + pokedex3 + '.png'));
		$('#pokemon-window-type1').attr('class', 'pokemon-type').addClass('pokemon-type-' + (pokemon.t1 || 'none'));
		$('#pokemon-window-type2').attr('class', 'pokemon-type').addClass('pokemon-type-' + (pokemon.t2 || 'none'));
		
		
		stop_pokemon_window_load_check();
		pokemon_window_load_check_interval_id = setInterval(function () {
			var images = $('#pokemon-window img');
			if (images.length >= 2) {
				if (images.get(0).complete && images.get(1).complete) {
					stop_pokemon_window_load_check();
					// $('#pokemon-window').slideDown();
					$('#pokemon-window').show();
				}
			}
		}, 200);
	};
	
	var show_area_info_time_origin = (function () {
		var t = 1000 * 60 * 60 * 24;
		return Math.round(new Date().getTime() / t) * t;
	})();
	
	window.show_area_info = function (area_id, area_name, census) {
		var coord = areas[area_id];
		var d = new Date();
		d.setTime(d.getTime() + coord.tzoffset * 60 * 60 * 1000);
		$('#pgl-area-info-name').text(area_name);
		$('#pgl-area-info-text3').html(census.replace(/\d+/, '<span id="pgl-area-info-value">$&</span>'));
		$('#pgl-area-info-text-tzname').text(coord.tzname.toUpperCase());
		$('#pgl-area-info-text-time').text(zerofill(d.getUTCHours(), 2) + ':' + zerofill(d.getUTCMinutes(), 2));
		
		// 地図スライド
		if (coord.latitude == undefined) {
			var match = coord.coords.match(/([\d\.]+)([NS]),([\d\.]+)([EW])/);
			coord.latitude  = parseFloat(match[1]) * (match[2] == 'S' ? -1 : 1) * Math.PI / 180;
			coord.longitude = parseFloat(match[3]) * (match[4] == 'W' ? -1 : 1) * Math.PI / 180;
		}
		
		var x = (coord.longitude / Math.PI / 2 * 2665 + 2950) % 2665;
		var sy = Math.sin(coord.latitude * 0.8);
		var y = Math.log((1 + sy) / (1 - sy)) * -295 + 940;
		
		x = (x + 2928) % 2928;
		y = (y + 1960) % 1960;
		x *= -1;
		y *= -1;
		x += 335;
		y += 240;
		
		if (navigator.userAgent.indexOf('AppleWebKit') != -1) {
			$('#pgl-map-canvas').css({ '-webkit-transform': 'translate(' + x + 'px, ' + y + 'px)', '-webkit-transition': 'all 0.6s ease-in-out' });
		} else {
			$('#pgl-map-canvas').animate({ left:x + 'px', top:y + 'px' }, 600, 'easeInOutCubic');
		}
		
		// チャートを出す
		chart[0].attr({ r:0 });
		chart[1].attr({ r:0 });
		chart[2].attr({ r:0 });
		chart[3].attr({ path:'M85 148 L85 148' });
		chart[4].attr({ r:0 });
		chart[5].attr({ width:0 });
		chart[6].attr({ opacity:0 });
		chart[7].attr({ opacity:0 });
		chart[8].attr({ opacity:0 });
		chart[9].attr({ r:0 });
		chart[10].attr({ opacity:0, text:current_ranking + 1 });
			
		setTimeout(function () {
			chart[2].attr({ r:0 }).animate({ r:84 * 1.000 }, 450, '<>');
		}, 500);
		setTimeout(function () {
			chart[1].attr({ r:0 }).animate({ r:84 * 0.595 }, 450 * 1.3, '<>');
		}, 600);
		setTimeout(function () {
			chart[0].attr({ r:0 }).animate({ r:84 * 0.333 }, 450 * 1.6, '<>');
		}, 700);
		setTimeout(function () {
			chart[9].attr({ r:0 }).animate({ r:11 }, 450 * 1.4, 'backOut');
		}, 1100);
		setTimeout(function () {
			chart[10].attr({ r:0 }).animate({ opacity:1 }, 200);
		}, 1600);
		
		setTimeout(function () {
			chart[3].animate({ path:'M85 148 L247 47' }, 250);
		}, 1600);
		setTimeout(function () {
			chart[4].animate({ r:3.5 }, 150, 'backOut');
		}, 1850);
		setTimeout(function () {
			chart[5].animate({ width:266 }, 200, '<');
		}, 1850);
		setTimeout(function () {
			var hour = (d.getTime() - show_area_info_time_origin) / 1000 / 60 / 60;
			chart[7].attr(get_clock_rotation_attrs(503 - 5, 24 - 1.5, 4, (hour / 12 * 360 + 270)));
			chart[8].attr(get_clock_rotation_attrs(503 - 7, 24 - 1,   6, (hour * 360 + 270)));
			chart[6].animate({ opacity:1 }, 600);
			chart[7].animate({ opacity:1 }, 600);
			chart[8].animate({ opacity:1 }, 600);
		}, 2450);
	};
	
	function update_census() {
		var item = census_list[current_census].ranking_list[current_ranking];
		// 国勢調査ラベル幅調整
		var w = $('#pgl-ranking-label').css({ display:'inline' }).text(item.title).width() + 20;
		$('#pgl-ranking-label').css({ display:'block' }).animate({ width:w + 'px' }, 300);
		// 国勢調査切り替えボタン更新
		$('#pgl-ranking-selector').attr('class', 'selected' + (current_ranking + 1));
		// 古い情報を隠して
		$('#pgl-area-info-text').hide();
		$('#pokemon-window').hide();
		stop_pokemon_window_load_check();
		// 更新
		window.show_area_info(item.country_id, item.country_name, item.label);
		setTimeout(function () {
			$('#pgl-area-info-text').show();
			window.show_pokemon_info(item.pokemon_no || getString('census.default.pokedex'), item.pokemon_name || getString('census.default.name'));
		}, 2150);
	}
	
	function applyImageFont(target) {
		var table = { '.':'dot', ',':'comma', ':':'colon', ' ':'space', '/':'slash' };
		var text = target.text();
		target.empty();
		$.each(text.split(''), function (i, c) {
			$('<span/>').addClass('font-' + (table[c] || c)).text(c).appendTo(target);
		})
	}
	
	function get_clock_rotation_attrs(x, y, radius, angle) {
		return { rotation: angle, x:x+Math.cos(Raphael.rad(angle)) * radius, y:y+Math.sin(Raphael.rad(angle)) * radius };
	}
	
	function createLocalChart(target) {
		var r = Raphael(target, 530, 233);
		r.customAttributes.customRotation = get_clock_rotation_attrs;
		var set = r.set();
		set.push(r.circle(85, 148).attr({ stroke:'#00479d', 'stroke-opacity':0.60, fill:'#00baff', 'fill-opacity':0.30 }));
		set.push(r.circle(85, 148).attr({ stroke:'#00479d', 'stroke-opacity':0.40, fill:'#00baff', 'fill-opacity':0.25 }));
		set.push(r.circle(85, 148).attr({ stroke:'#00479d', 'stroke-opacity':0.30, fill:'#3393cc', 'fill-opacity':0.20 }));
		set.push(r.path('M85 148 L85 148').attr({ stroke:'#000', 'stroke-width':1 }));
		set.push(r.circle(247, 47, 3.5).attr({ stroke:null, 'stroke-width':0, fill:'#000' }));
		set.push(r.rect(247+7, 47, 266, 1).attr({ stroke:null, 'stroke-width':0, fill:'#797C7E' }));
		var board = r.set();
		set.push(board);
		for (var i=0; i<12; i++) {
			board.push(r.rect(516, 24 - 1.5, 4, 3).attr({ stroke:null, 'stroke-width':0, fill:'#000' }).rotate(i * 30, 503, 24));
		}
		set.push(r.rect(501, 24 - 1.5, 10, 3).attr({ customRotation:[503 - 5, 24 - 1.5, 4, 0], stroke:null, 'stroke-width':0, fill:'#000' }));
		set.push(r.rect(501, 24 - 1,   14, 2).attr({ customRotation:[503 - 7, 24 - 1,   6, 0], stroke:null, 'stroke-width':0, fill:'#000' }));
		
		set.push(r.circle(85, 148, 11).attr({ stroke:'#00479d', 'stroke-opacity':0.60, fill:'#ffbc00' }));
		set.push(r.text(85-0.5, 148, 1).attr({ fill:'#c45d00', 'font-size':17 }));
		//set.push(r).;
		
		return set;
	}
	
	function createGlobalChart(target, items, label_src) {
		var radius = 49;
		var r = Raphael(target);
		r.circle(radius + 15, radius + 2, radius + 1).attr({ stroke:null, 'stroke-width':0, fill:'#3E4447', 'fill-opacity':0.2 });
		
		
		r.customAttributes.segment = function (a1, a2) {
			var x = radius + 15, y = radius + 2, r = radius - 1;
			var flag = (a2 - a1) > Math.PI;
			return {
				path: [
					['M', x, y],
					['l', r * Math.cos(a1), r * Math.sin(a1)],
					['A', r, r, 0, +flag, 1, x + r * Math.cos(a2), y + r * Math.sin(a2)],
					['z']
				]
			};
		};
		
		var start = Math.PI * -0.5;
		var paths = r.set();
		var total = 0;
		for (var i = 0; i < items.length; i++) {
			total += items[i].value;
			paths.push(r.path().attr({ segment: [start, start], fill:items[i].fill, stroke:null, 'stroke-width':0 }));
		}
		for (var i = 0; i < items.length; i++) {
			var val = Math.PI * 2 * items[i].value / total;
			var tr = start + val * 0.5;
			paths[i].animate({ segment: [start, start += val] }, 1000, '<>');
		}
		
		r.image(label_src, -1, 1, 130, 130);
	}
	
	
	function update_scroller() {
		if ($('#information .scroll-target li').length) {
			if ($('#information .scroll-target li:first').position().top < 0) {
				$('#information .scroller-up a').removeClass('disabled');
			} else {
				$('#information .scroller-up a').addClass('disabled');
			}
			if ($('#information .scroll-target li:last').position().top + $('#information .scroll-target li:last').outerHeight() > 226) {
				$('#information .scroller-down a').removeClass('disabled');
			} else {
				$('#information .scroller-down a').addClass('disabled');
			}
		} else {
			$('#information .scroller-up a').addClass('disabled');
			$('#information .scroller-down a').addClass('disabled');
		}
	}
	
	function stop_pokemon_window_load_check() {
		if (pokemon_window_load_check_interval_id) {
			clearInterval(pokemon_window_load_check_interval_id);
			pokemon_window_load_check_interval_id = 0;
		}
	}
	
	
	
	/**
	 * 地図を作成
	 */
	function createMap() {
		var table = $('<table border="0" cellpadding="0" cellspacing="0"></table>').prependTo($('#pgl-map-canvas'));
		for (var i=0; i<4; i++) {
			var tr = $('<tr></tr>').appendTo(table);
			for (var j=0; j<8; j++) {
				var r = i;
				var c = j % 6;
				var src = '/es.pokemon-gl.com/src/swf/top-assets/images/map/map_r' + (r + 1) + '_c' + (c + 1) + '.png';
				$('<td></td>')
					.append($('<img border="0" alt="" />').attr({ src:src, width:488, height:490 }))
					.appendTo(tr);
			}
		}
	}
	
	function format_time(time, format) {
		var date = new Date();
		date.setTime((parseInt(time) + 9 * 60 * 60) * 1000);
		if (!format) {
			if (theme.language == 'en') {
				format = 'MM.DD.YYYY hh:mm';
			} else if (theme.language == 'es') {
				format = 'DD/MM/YYYY hh:mm';
			} else if (theme.language == 'ja' || theme.language == 'ko') {
				format = 'YYYY.MM.DD hh:mm';
			} else {
				format = 'DD.MM.YYYY hh:mm';
			}
		}
		return format
			.replace('YYYY', date.getUTCFullYear())
			.replace('MM', zerofill(date.getUTCMonth() + 1, 2))
			.replace('DD', zerofill(date.getUTCDate(), 2))
			.replace('hh', zerofill(date.getUTCHours(), 2))
			.replace('mm', zerofill(date.getUTCMinutes(), 2))
	}
	
	// IE fix
	function zerofill(str, len) {
		str = '0000000000000000' + str;
		return str.substr(str.length - len);
	}
	
	function createPokemonTable() {
		return {
			'001':{m:'0.7m',kg:'6.9kg',ft:'2\'04\"',lb:'15.2 lbs.',t1:'grass',t2:'poison'},
			'002':{m:'1.0m',kg:'13.0kg',ft:'3\'03\"',lb:'28.7 lbs.',t1:'grass',t2:'poison'},
			'003':{m:'2.0m',kg:'100.0kg',ft:'6\'07\"',lb:'220.5 lbs.',t1:'grass',t2:'poison'},
			'004':{m:'0.6m',kg:'8.5kg',ft:'2\'00\"',lb:'18.7 lbs.',t1:'fire'},
			'005':{m:'1.1m',kg:'19.0kg',ft:'3\'07\"',lb:'41.9 lbs.',t1:'fire'},
			'006':{m:'1.7m',kg:'90.5kg',ft:'5\'07\"',lb:'199.5 lbs.',t1:'fire',t2:'flying'},
			'007':{m:'0.5m',kg:'9.0kg',ft:'1\'08\"',lb:'19.8 lbs.',t1:'water'},
			'008':{m:'1.0m',kg:'22.5kg',ft:'3\'03\"',lb:'49.6 lbs.',t1:'water'},
			'009':{m:'1.6m',kg:'85.5kg',ft:'5\'03\"',lb:'188.5 lbs.',t1:'water'},
			'010':{m:'0.3m',kg:'2.9kg',ft:'1\'00\"',lb:'6.4 lbs.',t1:'bug'},
			'011':{m:'0.7m',kg:'9.9kg',ft:'2\'04\"',lb:'21.8 lbs.',t1:'bug'},
			'012':{m:'1.1m',kg:'32.0kg',ft:'3\'07\"',lb:'70.5 lbs.',t1:'bug',t2:'flying'},
			'013':{m:'0.3m',kg:'3.2kg',ft:'1\'00\"',lb:'7.1 lbs.',t1:'bug',t2:'poison'},
			'014':{m:'0.6m',kg:'10.0kg',ft:'2\'00\"',lb:'22.0 lbs.',t1:'bug',t2:'poison'},
			'015':{m:'1.0m',kg:'29.5kg',ft:'3\'03\"',lb:'65.0 lbs.',t1:'bug',t2:'poison'},
			'016':{m:'0.3m',kg:'1.8kg',ft:'1\'00\"',lb:'4.0 lbs.',t1:'normal',t2:'flying'},
			'017':{m:'1.1m',kg:'30.0kg',ft:'3\'07\"',lb:'66.1 lbs.',t1:'normal',t2:'flying'},
			'018':{m:'1.5m',kg:'39.5kg',ft:'4\'11\"',lb:'87.1 lbs.',t1:'normal',t2:'flying'},
			'019':{m:'0.3m',kg:'3.5kg',ft:'1\'00\"',lb:'7.7 lbs.',t1:'normal'},
			'020':{m:'0.7m',kg:'18.5kg',ft:'2\'04\"',lb:'40.8 lbs.',t1:'normal'},
			'021':{m:'0.3m',kg:'2.0kg',ft:'1\'00\"',lb:'4.4 lbs.',t1:'normal',t2:'flying'},
			'022':{m:'1.2m',kg:'38.0kg',ft:'3\'11\"',lb:'83.8 lbs.',t1:'normal',t2:'flying'},
			'023':{m:'2.0m',kg:'6.9kg',ft:'6\'07\"',lb:'15.2 lbs.',t1:'poison'},
			'024':{m:'3.5m',kg:'65.0kg',ft:'11\'06\"',lb:'143.3 lbs.',t1:'poison'},
			'025':{m:'0.4m',kg:'6.0kg',ft:'1\'04\"',lb:'13.2 lbs.',t1:'electric'},
			'026':{m:'0.8m',kg:'30.0kg',ft:'2\'07\"',lb:'66.1 lbs.',t1:'electric'},
			'027':{m:'0.6m',kg:'12.0kg',ft:'2\'00\"',lb:'26.5 lbs.',t1:'ground'},
			'028':{m:'1.0m',kg:'29.5kg',ft:'3\'03\"',lb:'65.0 lbs.',t1:'ground'},
			'029':{m:'0.4m',kg:'7.0kg',ft:'1\'04\"',lb:'15.4 lbs.',t1:'poison'},
			'030':{m:'0.8m',kg:'20.0kg',ft:'2\'07\"',lb:'44.1 lbs.',t1:'poison'},
			'031':{m:'1.3m',kg:'60.0kg',ft:'4\'03\"',lb:'132.3 lbs.',t1:'poison',t2:'ground'},
			'032':{m:'0.5m',kg:'9.0kg',ft:'1\'08\"',lb:'19.8 lbs.',t1:'poison'},
			'033':{m:'0.9m',kg:'19.5kg',ft:'2\'11\"',lb:'43.0 lbs.',t1:'poison'},
			'034':{m:'1.4m',kg:'62.0kg',ft:'4\'07\"',lb:'136.7 lbs.',t1:'poison',t2:'ground'},
			'035':{m:'0.6m',kg:'7.5kg',ft:'2\'00\"',lb:'16.5 lbs.',t1:'normal'},
			'036':{m:'1.3m',kg:'40.0kg',ft:'4\'03\"',lb:'88.2 lbs.',t1:'normal'},
			'037':{m:'0.6m',kg:'9.9kg',ft:'2\'00\"',lb:'21.8 lbs.',t1:'fire'},
			'038':{m:'1.1m',kg:'19.9kg',ft:'3\'07\"',lb:'43.9 lbs.',t1:'fire'},
			'039':{m:'0.5m',kg:'5.5kg',ft:'1\'08\"',lb:'12.1 lbs.',t1:'normal'},
			'040':{m:'1.0m',kg:'12.0kg',ft:'3\'03\"',lb:'26.5 lbs.',t1:'normal'},
			'041':{m:'0.8m',kg:'7.5kg',ft:'2\'07\"',lb:'16.5 lbs.',t1:'poison',t2:'flying'},
			'042':{m:'1.6m',kg:'55.0kg',ft:'5\'03\"',lb:'121.3 lbs.',t1:'poison',t2:'flying'},
			'043':{m:'0.5m',kg:'5.4kg',ft:'1\'08\"',lb:'11.9 lbs.',t1:'grass',t2:'poison'},
			'044':{m:'0.8m',kg:'8.6kg',ft:'2\'07\"',lb:'19.0 lbs.',t1:'grass',t2:'poison'},
			'045':{m:'1.2m',kg:'18.6kg',ft:'3\'11\"',lb:'41.0 lbs.',t1:'grass',t2:'poison'},
			'046':{m:'0.3m',kg:'5.4kg',ft:'1\'00\"',lb:'11.9 lbs.',t1:'bug',t2:'grass'},
			'047':{m:'1.0m',kg:'29.5kg',ft:'3\'03\"',lb:'65.0 lbs.',t1:'bug',t2:'grass'},
			'048':{m:'1.0m',kg:'30.0kg',ft:'3\'03\"',lb:'66.1 lbs.',t1:'bug',t2:'poison'},
			'049':{m:'1.5m',kg:'12.5kg',ft:'4\'11\"',lb:'27.6 lbs.',t1:'bug',t2:'poison'},
			'050':{m:'0.2m',kg:'0.8kg',ft:'0\'08\"',lb:'1.8 lbs.',t1:'ground'},
			'051':{m:'0.7m',kg:'33.3kg',ft:'2\'04\"',lb:'73.4 lbs.',t1:'ground'},
			'052':{m:'0.4m',kg:'4.2kg',ft:'1\'04\"',lb:'9.3 lbs.',t1:'normal'},
			'053':{m:'1.0m',kg:'32.0kg',ft:'3\'03\"',lb:'70.5 lbs.',t1:'normal'},
			'054':{m:'0.8m',kg:'19.6kg',ft:'2\'07\"',lb:'43.2 lbs.',t1:'water'},
			'055':{m:'1.7m',kg:'76.6kg',ft:'5\'07\"',lb:'168.9 lbs.',t1:'water'},
			'056':{m:'0.5m',kg:'28.0kg',ft:'1\'08\"',lb:'61.7 lbs.',t1:'fighting'},
			'057':{m:'1.0m',kg:'32.0kg',ft:'3\'03\"',lb:'70.5 lbs.',t1:'fighting'},
			'058':{m:'0.7m',kg:'19.0kg',ft:'2\'04\"',lb:'41.9 lbs.',t1:'fire'},
			'059':{m:'1.9m',kg:'155.0kg',ft:'6\'03\"',lb:'341.7 lbs.',t1:'fire'},
			'060':{m:'0.6m',kg:'12.4kg',ft:'2\'00\"',lb:'27.3 lbs.',t1:'water'},
			'061':{m:'1.0m',kg:'20.0kg',ft:'3\'03\"',lb:'44.1 lbs.',t1:'water'},
			'062':{m:'1.3m',kg:'54.0kg',ft:'4\'03\"',lb:'119.0 lbs.',t1:'water',t2:'fighting'},
			'063':{m:'0.9m',kg:'19.5kg',ft:'2\'11\"',lb:'43.0 lbs.',t1:'psychic'},
			'064':{m:'1.3m',kg:'56.5kg',ft:'4\'03\"',lb:'124.6 lbs.',t1:'psychic'},
			'065':{m:'1.5m',kg:'48.0kg',ft:'4\'11\"',lb:'105.8 lbs.',t1:'psychic'},
			'066':{m:'0.8m',kg:'19.5kg',ft:'2\'07\"',lb:'43.0 lbs.',t1:'fighting'},
			'067':{m:'1.5m',kg:'70.5kg',ft:'4\'11\"',lb:'155.4 lbs.',t1:'fighting'},
			'068':{m:'1.6m',kg:'130.0kg',ft:'5\'03\"',lb:'286.6 lbs.',t1:'fighting'},
			'069':{m:'0.7m',kg:'4.0kg',ft:'2\'04\"',lb:'8.8 lbs.',t1:'grass',t2:'poison'},
			'070':{m:'1.0m',kg:'6.4kg',ft:'3\'03\"',lb:'14.1 lbs.',t1:'grass',t2:'poison'},
			'071':{m:'1.7m',kg:'15.5kg',ft:'5\'07\"',lb:'34.2 lbs.',t1:'grass',t2:'poison'},
			'072':{m:'0.9m',kg:'45.5kg',ft:'2\'11\"',lb:'100.3 lbs.',t1:'water',t2:'poison'},
			'073':{m:'1.6m',kg:'55.0kg',ft:'5\'03\"',lb:'121.3 lbs.',t1:'water',t2:'poison'},
			'074':{m:'0.4m',kg:'20.0kg',ft:'1\'04\"',lb:'44.1 lbs.',t1:'rock',t2:'ground'},
			'075':{m:'1.0m',kg:'105.0kg',ft:'3\'03\"',lb:'231.5 lbs.',t1:'rock',t2:'ground'},
			'076':{m:'1.4m',kg:'300.0kg',ft:'4\'07\"',lb:'661.4 lbs.',t1:'rock',t2:'ground'},
			'077':{m:'1.0m',kg:'30.0kg',ft:'3\'03\"',lb:'66.1 lbs.',t1:'fire'},
			'078':{m:'1.7m',kg:'95.0kg',ft:'5\'07\"',lb:'209.4 lbs.',t1:'fire'},
			'079':{m:'1.2m',kg:'36.0kg',ft:'3\'11\"',lb:'79.4 lbs.',t1:'water',t2:'psychic'},
			'080':{m:'1.6m',kg:'78.5kg',ft:'5\'03\"',lb:'173.1 lbs.',t1:'water',t2:'psychic'},
			'081':{m:'0.3m',kg:'6.0kg',ft:'1\'00\"',lb:'13.2 lbs.',t1:'electric',t2:'steel'},
			'082':{m:'1.0m',kg:'60.0kg',ft:'3\'03\"',lb:'132.3 lbs.',t1:'electric',t2:'steel'},
			'083':{m:'0.8m',kg:'15.0kg',ft:'2\'07\"',lb:'33.1 lbs.',t1:'normal',t2:'flying'},
			'084':{m:'1.4m',kg:'39.2kg',ft:'4\'07\"',lb:'86.4 lbs.',t1:'normal',t2:'flying'},
			'085':{m:'1.8m',kg:'85.2kg',ft:'5\'11\"',lb:'187.8 lbs.',t1:'normal',t2:'flying'},
			'086':{m:'1.1m',kg:'90.0kg',ft:'3\'07\"',lb:'198.4 lbs.',t1:'water'},
			'087':{m:'1.7m',kg:'120.0kg',ft:'5\'07\"',lb:'264.6 lbs.',t1:'water',t2:'ice'},
			'088':{m:'0.9m',kg:'30.0kg',ft:'2\'11\"',lb:'66.1 lbs.',t1:'poison'},
			'089':{m:'1.2m',kg:'30.0kg',ft:'3\'11\"',lb:'66.1 lbs.',t1:'poison'},
			'090':{m:'0.3m',kg:'4.0kg',ft:'1\'00\"',lb:'8.8 lbs.',t1:'water'},
			'091':{m:'1.5m',kg:'132.5kg',ft:'4\'11\"',lb:'292.1 lbs.',t1:'water',t2:'ice'},
			'092':{m:'1.3m',kg:'0.1kg',ft:'4\'03\"',lb:'0.2 lbs.',t1:'ghost',t2:'poison'},
			'093':{m:'1.6m',kg:'0.1kg',ft:'5\'03\"',lb:'0.2 lbs.',t1:'ghost',t2:'poison'},
			'094':{m:'1.5m',kg:'40.5kg',ft:'4\'11\"',lb:'89.3 lbs.',t1:'ghost',t2:'poison'},
			'095':{m:'8.8m',kg:'210.0kg',ft:'28\'10\"',lb:'463.0 lbs.',t1:'rock',t2:'ground'},
			'096':{m:'1.0m',kg:'32.4kg',ft:'3\'03\"',lb:'71.4 lbs.',t1:'psychic'},
			'097':{m:'1.6m',kg:'75.6kg',ft:'5\'03\"',lb:'166.7 lbs.',t1:'psychic'},
			'098':{m:'0.4m',kg:'6.5kg',ft:'1\'04\"',lb:'14.3 lbs.',t1:'water'},
			'099':{m:'1.3m',kg:'60.0kg',ft:'4\'03\"',lb:'132.3 lbs.',t1:'water'},
			'100':{m:'0.5m',kg:'10.4kg',ft:'1\'08\"',lb:'22.9 lbs.',t1:'electric'},
			'101':{m:'1.2m',kg:'66.6kg',ft:'3\'11\"',lb:'146.8 lbs.',t1:'electric'},
			'102':{m:'0.4m',kg:'2.5kg',ft:'1\'04\"',lb:'5.5 lbs.',t1:'grass',t2:'psychic'},
			'103':{m:'2.0m',kg:'120.0kg',ft:'6\'07\"',lb:'264.6 lbs.',t1:'grass',t2:'psychic'},
			'104':{m:'0.4m',kg:'6.5kg',ft:'1\'04\"',lb:'14.3 lbs.',t1:'ground'},
			'105':{m:'1.0m',kg:'45.0kg',ft:'3\'03\"',lb:'99.2 lbs.',t1:'ground'},
			'106':{m:'1.5m',kg:'49.8kg',ft:'4\'11\"',lb:'109.8 lbs.',t1:'fighting'},
			'107':{m:'1.4m',kg:'50.2kg',ft:'4\'07\"',lb:'110.7 lbs.',t1:'fighting'},
			'108':{m:'1.2m',kg:'65.5kg',ft:'3\'11\"',lb:'144.4 lbs.',t1:'normal'},
			'109':{m:'0.6m',kg:'1.0kg',ft:'2\'00\"',lb:'2.2 lbs.',t1:'poison'},
			'110':{m:'1.2m',kg:'9.5kg',ft:'3\'11\"',lb:'20.9 lbs.',t1:'poison'},
			'111':{m:'1.0m',kg:'115.0kg',ft:'3\'03\"',lb:'253.5 lbs.',t1:'ground',t2:'rock'},
			'112':{m:'1.9m',kg:'120.0kg',ft:'6\'03\"',lb:'264.6 lbs.',t1:'ground',t2:'rock'},
			'113':{m:'1.1m',kg:'34.6kg',ft:'3\'07\"',lb:'76.3 lbs.',t1:'normal'},
			'114':{m:'1.0m',kg:'35.0kg',ft:'3\'03\"',lb:'77.2 lbs.',t1:'grass'},
			'115':{m:'2.2m',kg:'80.0kg',ft:'7\'03\"',lb:'176.4 lbs.',t1:'normal'},
			'116':{m:'0.4m',kg:'8.0kg',ft:'1\'04\"',lb:'17.6 lbs.',t1:'water'},
			'117':{m:'1.2m',kg:'25.0kg',ft:'3\'11\"',lb:'55.1 lbs.',t1:'water'},
			'118':{m:'0.6m',kg:'15.0kg',ft:'2\'00\"',lb:'33.1 lbs.',t1:'water'},
			'119':{m:'1.3m',kg:'39.0kg',ft:'4\'03\"',lb:'86.0 lbs.',t1:'water'},
			'120':{m:'0.8m',kg:'34.5kg',ft:'2\'07\"',lb:'76.1 lbs.',t1:'water'},
			'121':{m:'1.1m',kg:'80.0kg',ft:'3\'07\"',lb:'176.4 lbs.',t1:'water',t2:'psychic'},
			'122':{m:'1.3m',kg:'54.5kg',ft:'4\'03\"',lb:'120.1 lbs.',t1:'psychic'},
			'123':{m:'1.5m',kg:'56.0kg',ft:'4\'11\"',lb:'123.5 lbs.',t1:'bug',t2:'flying'},
			'124':{m:'1.4m',kg:'40.6kg',ft:'4\'07\"',lb:'89.5 lbs.',t1:'ice',t2:'psychic'},
			'125':{m:'1.1m',kg:'30.0kg',ft:'3\'07\"',lb:'66.1 lbs.',t1:'electric'},
			'126':{m:'1.3m',kg:'44.5kg',ft:'4\'03\"',lb:'98.1 lbs.',t1:'fire'},
			'127':{m:'1.5m',kg:'55.0kg',ft:'4\'11\"',lb:'121.3 lbs.',t1:'bug'},
			'128':{m:'1.4m',kg:'88.4kg',ft:'4\'07\"',lb:'194.9 lbs.',t1:'normal'},
			'129':{m:'0.9m',kg:'10.0kg',ft:'2\'11\"',lb:'22.0 lbs.',t1:'water'},
			'130':{m:'6.5m',kg:'235.0kg',ft:'21\'04\"',lb:'518.1 lbs.',t1:'water',t2:'flying'},
			'131':{m:'2.5m',kg:'220.0kg',ft:'8\'02\"',lb:'485.0 lbs.',t1:'water',t2:'ice'},
			'132':{m:'0.3m',kg:'4.0kg',ft:'1\'00\"',lb:'8.8 lbs.',t1:'normal'},
			'133':{m:'0.3m',kg:'6.5kg',ft:'1\'00\"',lb:'14.3 lbs.',t1:'normal'},
			'134':{m:'1.0m',kg:'29.0kg',ft:'3\'03\"',lb:'63.9 lbs.',t1:'water'},
			'135':{m:'0.8m',kg:'24.5kg',ft:'2\'07\"',lb:'54.0 lbs.',t1:'electric'},
			'136':{m:'0.9m',kg:'25.0kg',ft:'2\'11\"',lb:'55.1 lbs.',t1:'fire'},
			'137':{m:'0.8m',kg:'36.5kg',ft:'2\'07\"',lb:'80.5 lbs.',t1:'normal'},
			'138':{m:'0.4m',kg:'7.5kg',ft:'1\'04\"',lb:'16.5 lbs.',t1:'rock',t2:'water'},
			'139':{m:'1.0m',kg:'35.0kg',ft:'3\'03\"',lb:'77.2 lbs.',t1:'rock',t2:'water'},
			'140':{m:'0.5m',kg:'11.5kg',ft:'1\'08\"',lb:'25.4 lbs.',t1:'rock',t2:'water'},
			'141':{m:'1.3m',kg:'40.5kg',ft:'4\'03\"',lb:'89.3 lbs.',t1:'rock',t2:'water'},
			'142':{m:'1.8m',kg:'59.0kg',ft:'5\'11\"',lb:'130.1 lbs.',t1:'rock',t2:'flying'},
			'143':{m:'2.1m',kg:'460.0kg',ft:'6\'11\"',lb:'1014.1 lbs.',t1:'normal'},
			'144':{m:'1.7m',kg:'55.4kg',ft:'5\'07\"',lb:'122.1 lbs.',t1:'ice',t2:'flying'},
			'145':{m:'1.6m',kg:'52.6kg',ft:'5\'03\"',lb:'116.0 lbs.',t1:'electric',t2:'flying'},
			'146':{m:'2.0m',kg:'60.0kg',ft:'6\'07\"',lb:'132.3 lbs.',t1:'fire',t2:'flying'},
			'147':{m:'1.8m',kg:'3.3kg',ft:'5\'11\"',lb:'7.3 lbs.',t1:'dragon'},
			'148':{m:'4.0m',kg:'16.5kg',ft:'13\'01\"',lb:'36.4 lbs.',t1:'dragon'},
			'149':{m:'2.2m',kg:'210.0kg',ft:'7\'03\"',lb:'463.0 lbs.',t1:'dragon',t2:'flying'},
			'150':{m:'2.0m',kg:'122.0kg',ft:'6\'07\"',lb:'269.0 lbs.',t1:'psychic'},
			'151':{m:'0.4m',kg:'4.0kg',ft:'1\'04\"',lb:'8.8 lbs.',t1:'psychic'},
			'152':{m:'0.9m',kg:'6.4kg',ft:'2\'11\"',lb:'14.1 lbs.',t1:'grass'},
			'153':{m:'1.2m',kg:'15.8kg',ft:'3\'11\"',lb:'34.8 lbs.',t1:'grass'},
			'154':{m:'1.8m',kg:'100.5kg',ft:'5\'11\"',lb:'221.6 lbs.',t1:'grass'},
			'155':{m:'0.5m',kg:'7.9kg',ft:'1\'08\"',lb:'17.4 lbs.',t1:'fire'},
			'156':{m:'0.9m',kg:'19.0kg',ft:'2\'11\"',lb:'41.9 lbs.',t1:'fire'},
			'157':{m:'1.7m',kg:'79.5kg',ft:'5\'07\"',lb:'175.3 lbs.',t1:'fire'},
			'158':{m:'0.6m',kg:'9.5kg',ft:'2\'00\"',lb:'20.9 lbs.',t1:'water'},
			'159':{m:'1.1m',kg:'25.0kg',ft:'3\'07\"',lb:'55.1 lbs.',t1:'water'},
			'160':{m:'2.3m',kg:'88.8kg',ft:'7\'07\"',lb:'195.8 lbs.',t1:'water'},
			'161':{m:'0.8m',kg:'6.0kg',ft:'2\'07\"',lb:'13.2 lbs.',t1:'normal'},
			'162':{m:'1.8m',kg:'32.5kg',ft:'5\'11\"',lb:'71.6 lbs.',t1:'normal'},
			'163':{m:'0.7m',kg:'21.2kg',ft:'2\'04\"',lb:'46.7 lbs.',t1:'normal',t2:'flying'},
			'164':{m:'1.6m',kg:'40.8kg',ft:'5\'03\"',lb:'89.9 lbs.',t1:'normal',t2:'flying'},
			'165':{m:'1.0m',kg:'10.8kg',ft:'3\'03\"',lb:'23.8 lbs.',t1:'bug',t2:'flying'},
			'166':{m:'1.4m',kg:'35.6kg',ft:'4\'07\"',lb:'78.5 lbs.',t1:'bug',t2:'flying'},
			'167':{m:'0.5m',kg:'8.5kg',ft:'1\'08\"',lb:'18.7 lbs.',t1:'bug',t2:'poison'},
			'168':{m:'1.1m',kg:'33.5kg',ft:'3\'07\"',lb:'73.9 lbs.',t1:'bug',t2:'poison'},
			'169':{m:'1.8m',kg:'75.0kg',ft:'5\'11\"',lb:'165.3 lbs.',t1:'poison',t2:'flying'},
			'170':{m:'0.5m',kg:'12.0kg',ft:'1\'08\"',lb:'26.5 lbs.',t1:'water',t2:'electric'},
			'171':{m:'1.2m',kg:'22.5kg',ft:'3\'11\"',lb:'49.6 lbs.',t1:'water',t2:'electric'},
			'172':{m:'0.3m',kg:'2.0kg',ft:'1\'00\"',lb:'4.4 lbs.',t1:'electric'},
			'173':{m:'0.3m',kg:'3.0kg',ft:'1\'00\"',lb:'6.6 lbs.',t1:'normal'},
			'174':{m:'0.3m',kg:'1.0kg',ft:'1\'00\"',lb:'2.2 lbs.',t1:'normal'},
			'175':{m:'0.3m',kg:'1.5kg',ft:'1\'00\"',lb:'3.3 lbs.',t1:'normal'},
			'176':{m:'0.6m',kg:'3.2kg',ft:'2\'00\"',lb:'7.1 lbs.',t1:'normal',t2:'flying'},
			'177':{m:'0.2m',kg:'2.0kg',ft:'0\'08\"',lb:'4.4 lbs.',t1:'psychic',t2:'flying'},
			'178':{m:'1.5m',kg:'15.0kg',ft:'4\'11\"',lb:'33.1 lbs.',t1:'psychic',t2:'flying'},
			'179':{m:'0.6m',kg:'7.8kg',ft:'2\'00\"',lb:'17.2 lbs.',t1:'electric'},
			'180':{m:'0.8m',kg:'13.3kg',ft:'2\'07\"',lb:'29.3 lbs.',t1:'electric'},
			'181':{m:'1.4m',kg:'61.5kg',ft:'4\'07\"',lb:'135.6 lbs.',t1:'electric'},
			'182':{m:'0.4m',kg:'5.8kg',ft:'1\'04\"',lb:'12.8 lbs.',t1:'grass'},
			'183':{m:'0.4m',kg:'8.5kg',ft:'1\'04\"',lb:'18.7 lbs.',t1:'water'},
			'184':{m:'0.8m',kg:'28.5kg',ft:'2\'07\"',lb:'62.8 lbs.',t1:'water'},
			'185':{m:'1.2m',kg:'38.0kg',ft:'3\'11\"',lb:'83.8 lbs.',t1:'rock'},
			'186':{m:'1.1m',kg:'33.9kg',ft:'3\'07\"',lb:'74.7 lbs.',t1:'water'},
			'187':{m:'0.4m',kg:'0.5kg',ft:'1\'04\"',lb:'1.1 lbs.',t1:'grass',t2:'flying'},
			'188':{m:'0.6m',kg:'1.0kg',ft:'2\'00\"',lb:'2.2 lbs.',t1:'grass',t2:'flying'},
			'189':{m:'0.8m',kg:'3.0kg',ft:'2\'07\"',lb:'6.6 lbs.',t1:'grass',t2:'flying'},
			'190':{m:'0.8m',kg:'11.5kg',ft:'2\'07\"',lb:'25.4 lbs.',t1:'normal'},
			'191':{m:'0.3m',kg:'1.8kg',ft:'1\'00\"',lb:'4.0 lbs.',t1:'grass'},
			'192':{m:'0.8m',kg:'8.5kg',ft:'2\'07\"',lb:'18.7 lbs.',t1:'grass'},
			'193':{m:'1.2m',kg:'38.0kg',ft:'3\'11\"',lb:'83.8 lbs.',t1:'bug',t2:'flying'},
			'194':{m:'0.4m',kg:'8.5kg',ft:'1\'04\"',lb:'18.7 lbs.',t1:'water',t2:'ground'},
			'195':{m:'1.4m',kg:'75.0kg',ft:'4\'07\"',lb:'165.3 lbs.',t1:'water',t2:'ground'},
			'196':{m:'0.9m',kg:'26.5kg',ft:'2\'11\"',lb:'58.4 lbs.',t1:'psychic'},
			'197':{m:'1.0m',kg:'27.0kg',ft:'3\'03\"',lb:'59.5 lbs.',t1:'dark'},
			'198':{m:'0.5m',kg:'2.1kg',ft:'1\'08\"',lb:'4.6 lbs.',t1:'dark',t2:'flying'},
			'199':{m:'2.0m',kg:'79.5kg',ft:'6\'07\"',lb:'175.3 lbs.',t1:'water',t2:'psychic'},
			'200':{m:'0.7m',kg:'1.0kg',ft:'2\'04\"',lb:'2.2 lbs.',t1:'ghost'},
			'201':{m:'0.5m',kg:'5.0kg',ft:'1\'08\"',lb:'11.0 lbs.',t1:'psychic'},
			'202':{m:'1.3m',kg:'28.5kg',ft:'4\'03\"',lb:'62.8 lbs.',t1:'psychic'},
			'203':{m:'1.5m',kg:'41.5kg',ft:'4\'11\"',lb:'91.5 lbs.',t1:'normal',t2:'psychic'},
			'204':{m:'0.6m',kg:'7.2kg',ft:'2\'00\"',lb:'15.9 lbs.',t1:'bug'},
			'205':{m:'1.2m',kg:'125.8kg',ft:'3\'11\"',lb:'277.3 lbs.',t1:'bug',t2:'steel'},
			'206':{m:'1.5m',kg:'14.0kg',ft:'4\'11\"',lb:'30.9 lbs.',t1:'normal'},
			'207':{m:'1.1m',kg:'64.8kg',ft:'3\'07\"',lb:'142.9 lbs.',t1:'ground',t2:'flying'},
			'208':{m:'9.2m',kg:'400.0kg',ft:'30\'02\"',lb:'881.8 lbs.',t1:'steel',t2:'ground'},
			'209':{m:'0.6m',kg:'7.8kg',ft:'2\'00\"',lb:'17.2 lbs.',t1:'normal'},
			'210':{m:'1.4m',kg:'48.7kg',ft:'4\'07\"',lb:'107.4 lbs.',t1:'normal'},
			'211':{m:'0.5m',kg:'3.9kg',ft:'1\'08\"',lb:'8.6 lbs.',t1:'water',t2:'poison'},
			'212':{m:'1.8m',kg:'118.0kg',ft:'5\'11\"',lb:'260.1 lbs.',t1:'bug',t2:'steel'},
			'213':{m:'0.6m',kg:'20.5kg',ft:'2\'00\"',lb:'45.2 lbs.',t1:'bug',t2:'rock'},
			'214':{m:'1.5m',kg:'54.0kg',ft:'4\'11\"',lb:'119.0 lbs.',t1:'bug',t2:'fighting'},
			'215':{m:'0.9m',kg:'28.0kg',ft:'2\'11\"',lb:'61.7 lbs.',t1:'dark',t2:'ice'},
			'216':{m:'0.6m',kg:'8.8kg',ft:'2\'00\"',lb:'19.4 lbs.',t1:'normal'},
			'217':{m:'1.8m',kg:'125.8kg',ft:'5\'11\"',lb:'277.3 lbs.',t1:'normal'},
			'218':{m:'0.7m',kg:'35.0kg',ft:'2\'04\"',lb:'77.2 lbs.',t1:'fire'},
			'219':{m:'0.8m',kg:'55.0kg',ft:'2\'07\"',lb:'121.3 lbs.',t1:'fire',t2:'rock'},
			'220':{m:'0.4m',kg:'6.5kg',ft:'1\'04\"',lb:'14.3 lbs.',t1:'ice',t2:'ground'},
			'221':{m:'1.1m',kg:'55.8kg',ft:'3\'07\"',lb:'123.0 lbs.',t1:'ice',t2:'ground'},
			'222':{m:'0.6m',kg:'5.0kg',ft:'2\'00\"',lb:'11.0 lbs.',t1:'water',t2:'rock'},
			'223':{m:'0.6m',kg:'12.0kg',ft:'2\'00\"',lb:'26.5 lbs.',t1:'water'},
			'224':{m:'0.9m',kg:'28.5kg',ft:'2\'11\"',lb:'62.8 lbs.',t1:'water'},
			'225':{m:'0.9m',kg:'16.0kg',ft:'2\'11\"',lb:'35.3 lbs.',t1:'ice',t2:'flying'},
			'226':{m:'2.1m',kg:'220.0kg',ft:'6\'11\"',lb:'485.0 lbs.',t1:'water',t2:'flying'},
			'227':{m:'1.7m',kg:'50.5kg',ft:'5\'07\"',lb:'111.3 lbs.',t1:'steel',t2:'flying'},
			'228':{m:'0.6m',kg:'10.8kg',ft:'2\'00\"',lb:'23.8 lbs.',t1:'dark',t2:'fire'},
			'229':{m:'1.4m',kg:'35.0kg',ft:'4\'07\"',lb:'77.2 lbs.',t1:'dark',t2:'fire'},
			'230':{m:'1.8m',kg:'152.0kg',ft:'5\'11\"',lb:'335.1 lbs.',t1:'water',t2:'dragon'},
			'231':{m:'0.5m',kg:'33.5kg',ft:'1\'08\"',lb:'73.9 lbs.',t1:'ground'},
			'232':{m:'1.1m',kg:'120.0kg',ft:'3\'07\"',lb:'264.6 lbs.',t1:'ground'},
			'233':{m:'0.6m',kg:'32.5kg',ft:'2\'00\"',lb:'71.6 lbs.',t1:'normal'},
			'234':{m:'1.4m',kg:'71.2kg',ft:'4\'07\"',lb:'157.0 lbs.',t1:'normal'},
			'235':{m:'1.2m',kg:'58.0kg',ft:'3\'11\"',lb:'127.9 lbs.',t1:'normal'},
			'236':{m:'0.7m',kg:'21.0kg',ft:'2\'04\"',lb:'46.3 lbs.',t1:'fighting'},
			'237':{m:'1.4m',kg:'48.0kg',ft:'4\'07\"',lb:'105.8 lbs.',t1:'fighting'},
			'238':{m:'0.4m',kg:'6.0kg',ft:'1\'04\"',lb:'13.2 lbs.',t1:'ice',t2:'psychic'},
			'239':{m:'0.6m',kg:'23.5kg',ft:'2\'00\"',lb:'51.8 lbs.',t1:'electric'},
			'240':{m:'0.7m',kg:'21.4kg',ft:'2\'04\"',lb:'47.2 lbs.',t1:'fire'},
			'241':{m:'1.2m',kg:'75.5kg',ft:'3\'11\"',lb:'166.4 lbs.',t1:'normal'},
			'242':{m:'1.5m',kg:'46.8kg',ft:'4\'11\"',lb:'103.2 lbs.',t1:'normal'},
			'243':{m:'1.9m',kg:'178.0kg',ft:'6\'03\"',lb:'392.4 lbs.',t1:'electric'},
			'244':{m:'2.1m',kg:'198.0kg',ft:'6\'11\"',lb:'436.5 lbs.',t1:'fire'},
			'245':{m:'2.0m',kg:'187.0kg',ft:'6\'07\"',lb:'412.3 lbs.',t1:'water'},
			'246':{m:'0.6m',kg:'72.0kg',ft:'2\'00\"',lb:'158.7 lbs.',t1:'rock',t2:'ground'},
			'247':{m:'1.2m',kg:'152.0kg',ft:'3\'11\"',lb:'335.1 lbs.',t1:'rock',t2:'ground'},
			'248':{m:'2.0m',kg:'202.0kg',ft:'6\'07\"',lb:'445.3 lbs.',t1:'rock',t2:'dark'},
			'249':{m:'5.2m',kg:'216.0kg',ft:'17\'01\"',lb:'476.2 lbs.',t1:'psychic',t2:'flying'},
			'250':{m:'3.8m',kg:'199.0kg',ft:'12\'06\"',lb:'438.7 lbs.',t1:'fire',t2:'flying'},
			'251':{m:'0.6m',kg:'5.0kg',ft:'2\'00\"',lb:'11.0 lbs.',t1:'psychic',t2:'grass'},
			'252':{m:'0.5m',kg:'5.0kg',ft:'1\'08\"',lb:'11.0 lbs.',t1:'grass'},
			'253':{m:'0.9m',kg:'21.6kg',ft:'2\'11\"',lb:'47.6 lbs.',t1:'grass'},
			'254':{m:'1.7m',kg:'52.2kg',ft:'5\'07\"',lb:'115.1 lbs.',t1:'grass'},
			'255':{m:'0.4m',kg:'2.5kg',ft:'1\'04\"',lb:'5.5 lbs.',t1:'fire'},
			'256':{m:'0.9m',kg:'19.5kg',ft:'2\'11\"',lb:'43.0 lbs.',t1:'fire',t2:'fighting'},
			'257':{m:'1.9m',kg:'52.0kg',ft:'6\'03\"',lb:'114.6 lbs.',t1:'fire',t2:'fighting'},
			'258':{m:'0.4m',kg:'7.6kg',ft:'1\'04\"',lb:'16.8 lbs.',t1:'water'},
			'259':{m:'0.7m',kg:'28.0kg',ft:'2\'04\"',lb:'61.7 lbs.',t1:'water',t2:'ground'},
			'260':{m:'1.5m',kg:'81.9kg',ft:'4\'11\"',lb:'180.6 lbs.',t1:'water',t2:'ground'},
			'261':{m:'0.5m',kg:'13.6kg',ft:'1\'08\"',lb:'30.0 lbs.',t1:'dark'},
			'262':{m:'1.0m',kg:'37.0kg',ft:'3\'03\"',lb:'81.6 lbs.',t1:'dark'},
			'263':{m:'0.4m',kg:'17.5kg',ft:'1\'04\"',lb:'38.6 lbs.',t1:'normal'},
			'264':{m:'0.5m',kg:'32.5kg',ft:'1\'08\"',lb:'71.6 lbs.',t1:'normal'},
			'265':{m:'0.3m',kg:'3.6kg',ft:'1\'00\"',lb:'7.9 lbs.',t1:'bug'},
			'266':{m:'0.6m',kg:'10.0kg',ft:'2\'00\"',lb:'22.0 lbs.',t1:'bug'},
			'267':{m:'1.0m',kg:'28.4kg',ft:'3\'03\"',lb:'62.6 lbs.',t1:'bug',t2:'flying'},
			'268':{m:'0.7m',kg:'11.5kg',ft:'2\'04\"',lb:'25.4 lbs.',t1:'bug'},
			'269':{m:'1.2m',kg:'31.6kg',ft:'3\'11\"',lb:'69.7 lbs.',t1:'bug',t2:'poison'},
			'270':{m:'0.5m',kg:'2.6kg',ft:'1\'08\"',lb:'5.7 lbs.',t1:'water',t2:'grass'},
			'271':{m:'1.2m',kg:'32.5kg',ft:'3\'11\"',lb:'71.6 lbs.',t1:'water',t2:'grass'},
			'272':{m:'1.5m',kg:'55.0kg',ft:'4\'11\"',lb:'121.3 lbs.',t1:'water',t2:'grass'},
			'273':{m:'0.5m',kg:'4.0kg',ft:'1\'08\"',lb:'8.8 lbs.',t1:'grass'},
			'274':{m:'1.0m',kg:'28.0kg',ft:'3\'03\"',lb:'61.7 lbs.',t1:'grass',t2:'dark'},
			'275':{m:'1.3m',kg:'59.6kg',ft:'4\'03\"',lb:'131.4 lbs.',t1:'grass',t2:'dark'},
			'276':{m:'0.3m',kg:'2.3kg',ft:'1\'00\"',lb:'5.1 lbs.',t1:'normal',t2:'flying'},
			'277':{m:'0.7m',kg:'19.8kg',ft:'2\'04\"',lb:'43.7 lbs.',t1:'normal',t2:'flying'},
			'278':{m:'0.6m',kg:'9.5kg',ft:'2\'00\"',lb:'20.9 lbs.',t1:'water',t2:'flying'},
			'279':{m:'1.2m',kg:'28.0kg',ft:'3\'11\"',lb:'61.7 lbs.',t1:'water',t2:'flying'},
			'280':{m:'0.4m',kg:'6.6kg',ft:'1\'04\"',lb:'14.6 lbs.',t1:'psychic'},
			'281':{m:'0.8m',kg:'20.2kg',ft:'2\'07\"',lb:'44.5 lbs.',t1:'psychic'},
			'282':{m:'1.6m',kg:'48.4kg',ft:'5\'03\"',lb:'106.7 lbs.',t1:'psychic'},
			'283':{m:'0.5m',kg:'1.7kg',ft:'1\'08\"',lb:'3.7 lbs.',t1:'bug',t2:'water'},
			'284':{m:'0.8m',kg:'3.6kg',ft:'2\'07\"',lb:'7.9 lbs.',t1:'bug',t2:'flying'},
			'285':{m:'0.4m',kg:'4.5kg',ft:'1\'04\"',lb:'9.9 lbs.',t1:'grass'},
			'286':{m:'1.2m',kg:'39.2kg',ft:'3\'11\"',lb:'86.4 lbs.',t1:'grass',t2:'fighting'},
			'287':{m:'0.8m',kg:'24.0kg',ft:'2\'07\"',lb:'52.9 lbs.',t1:'normal'},
			'288':{m:'1.4m',kg:'46.5kg',ft:'4\'07\"',lb:'102.5 lbs.',t1:'normal'},
			'289':{m:'2.0m',kg:'130.5kg',ft:'6\'07\"',lb:'287.7 lbs.',t1:'normal'},
			'290':{m:'0.5m',kg:'5.5kg',ft:'1\'08\"',lb:'12.1 lbs.',t1:'bug',t2:'ground'},
			'291':{m:'0.8m',kg:'12.0kg',ft:'2\'07\"',lb:'26.5 lbs.',t1:'bug',t2:'flying'},
			'292':{m:'0.8m',kg:'1.2kg',ft:'2\'07\"',lb:'2.6 lbs.',t1:'bug',t2:'ghost'},
			'293':{m:'0.6m',kg:'16.3kg',ft:'2\'00\"',lb:'35.9 lbs.',t1:'normal'},
			'294':{m:'1.0m',kg:'40.5kg',ft:'3\'03\"',lb:'89.3 lbs.',t1:'normal'},
			'295':{m:'1.5m',kg:'84.0kg',ft:'4\'11\"',lb:'185.2 lbs.',t1:'normal'},
			'296':{m:'1.0m',kg:'86.4kg',ft:'3\'03\"',lb:'190.5 lbs.',t1:'fighting'},
			'297':{m:'2.3m',kg:'253.8kg',ft:'7\'07\"',lb:'559.5 lbs.',t1:'fighting'},
			'298':{m:'0.2m',kg:'2.0kg',ft:'0\'08\"',lb:'4.4 lbs.',t1:'normal'},
			'299':{m:'1.0m',kg:'97.0kg',ft:'3\'03\"',lb:'213.8 lbs.',t1:'rock'},
			'300':{m:'0.6m',kg:'11.0kg',ft:'2\'00\"',lb:'24.3 lbs.',t1:'normal'},
			'301':{m:'1.1m',kg:'32.6kg',ft:'3\'07\"',lb:'71.9 lbs.',t1:'normal'},
			'302':{m:'0.5m',kg:'11.0kg',ft:'1\'08\"',lb:'24.3 lbs.',t1:'dark',t2:'ghost'},
			'303':{m:'0.6m',kg:'11.5kg',ft:'2\'00\"',lb:'25.4 lbs.',t1:'steel'},
			'304':{m:'0.4m',kg:'60.0kg',ft:'1\'04\"',lb:'132.3 lbs.',t1:'steel',t2:'rock'},
			'305':{m:'0.9m',kg:'120.0kg',ft:'2\'11\"',lb:'264.6 lbs.',t1:'steel',t2:'rock'},
			'306':{m:'2.1m',kg:'360.0kg',ft:'6\'11\"',lb:'793.7 lbs.',t1:'steel',t2:'rock'},
			'307':{m:'0.6m',kg:'11.2kg',ft:'2\'00\"',lb:'24.7 lbs.',t1:'fighting',t2:'psychic'},
			'308':{m:'1.3m',kg:'31.5kg',ft:'4\'03\"',lb:'69.4 lbs.',t1:'fighting',t2:'psychic'},
			'309':{m:'0.6m',kg:'15.2kg',ft:'2\'00\"',lb:'33.5 lbs.',t1:'electric'},
			'310':{m:'1.5m',kg:'40.2kg',ft:'4\'11\"',lb:'88.6 lbs.',t1:'electric'},
			'311':{m:'0.4m',kg:'4.2kg',ft:'1\'04\"',lb:'9.3 lbs.',t1:'electric'},
			'312':{m:'0.4m',kg:'4.2kg',ft:'1\'04\"',lb:'9.3 lbs.',t1:'electric'},
			'313':{m:'0.7m',kg:'17.7kg',ft:'2\'04\"',lb:'39.0 lbs.',t1:'bug'},
			'314':{m:'0.6m',kg:'17.7kg',ft:'2\'00\"',lb:'39.0 lbs.',t1:'bug'},
			'315':{m:'0.3m',kg:'2.0kg',ft:'1\'00\"',lb:'4.4 lbs.',t1:'grass',t2:'poison'},
			'316':{m:'0.4m',kg:'10.3kg',ft:'1\'04\"',lb:'22.7 lbs.',t1:'poison'},
			'317':{m:'1.7m',kg:'80.0kg',ft:'5\'07\"',lb:'176.4 lbs.',t1:'poison'},
			'318':{m:'0.8m',kg:'20.8kg',ft:'2\'07\"',lb:'45.9 lbs.',t1:'water',t2:'dark'},
			'319':{m:'1.8m',kg:'88.8kg',ft:'5\'11\"',lb:'195.8 lbs.',t1:'water',t2:'dark'},
			'320':{m:'2.0m',kg:'130.0kg',ft:'6\'07\"',lb:'286.6 lbs.',t1:'water'},
			'321':{m:'14.5m',kg:'398.0kg',ft:'47\'07\"',lb:'877.4 lbs.',t1:'water'},
			'322':{m:'0.7m',kg:'24.0kg',ft:'2\'04\"',lb:'52.9 lbs.',t1:'fire',t2:'ground'},
			'323':{m:'1.9m',kg:'220.0kg',ft:'6\'03\"',lb:'485.0 lbs.',t1:'fire',t2:'ground'},
			'324':{m:'0.5m',kg:'80.4kg',ft:'1\'08\"',lb:'177.2 lbs.',t1:'fire'},
			'325':{m:'0.7m',kg:'30.6kg',ft:'2\'04\"',lb:'67.5 lbs.',t1:'psychic'},
			'326':{m:'0.9m',kg:'71.5kg',ft:'2\'11\"',lb:'157.6 lbs.',t1:'psychic'},
			'327':{m:'1.1m',kg:'5.0kg',ft:'3\'07\"',lb:'11.0 lbs.',t1:'normal'},
			'328':{m:'0.7m',kg:'15.0kg',ft:'2\'04\"',lb:'33.1 lbs.',t1:'ground'},
			'329':{m:'1.1m',kg:'15.3kg',ft:'3\'07\"',lb:'33.7 lbs.',t1:'ground',t2:'dragon'},
			'330':{m:'2.0m',kg:'82.0kg',ft:'6\'07\"',lb:'180.8 lbs.',t1:'ground',t2:'dragon'},
			'331':{m:'0.4m',kg:'51.3kg',ft:'1\'04\"',lb:'113.1 lbs.',t1:'grass'},
			'332':{m:'1.3m',kg:'77.4kg',ft:'4\'03\"',lb:'170.6 lbs.',t1:'grass',t2:'dark'},
			'333':{m:'0.4m',kg:'1.2kg',ft:'1\'04\"',lb:'2.6 lbs.',t1:'normal',t2:'flying'},
			'334':{m:'1.1m',kg:'20.6kg',ft:'3\'07\"',lb:'45.4 lbs.',t1:'dragon',t2:'flying'},
			'335':{m:'1.3m',kg:'40.3kg',ft:'4\'03\"',lb:'88.8 lbs.',t1:'normal'},
			'336':{m:'2.7m',kg:'52.5kg',ft:'8\'10\"',lb:'115.7 lbs.',t1:'poison'},
			'337':{m:'1.0m',kg:'168.0kg',ft:'3\'03\"',lb:'370.4 lbs.',t1:'rock',t2:'psychic'},
			'338':{m:'1.2m',kg:'154.0kg',ft:'3\'11\"',lb:'339.5 lbs.',t1:'rock',t2:'psychic'},
			'339':{m:'0.4m',kg:'1.9kg',ft:'1\'04\"',lb:'4.2 lbs.',t1:'water',t2:'ground'},
			'340':{m:'0.9m',kg:'23.6kg',ft:'2\'11\"',lb:'52.0 lbs.',t1:'water',t2:'ground'},
			'341':{m:'0.6m',kg:'11.5kg',ft:'2\'00\"',lb:'25.4 lbs.',t1:'water'},
			'342':{m:'1.1m',kg:'32.8kg',ft:'3\'07\"',lb:'72.3 lbs.',t1:'water',t2:'dark'},
			'343':{m:'0.5m',kg:'21.5kg',ft:'1\'08\"',lb:'47.4 lbs.',t1:'ground',t2:'psychic'},
			'344':{m:'1.5m',kg:'108.0kg',ft:'4\'11\"',lb:'238.1 lbs.',t1:'ground',t2:'psychic'},
			'345':{m:'1.0m',kg:'23.8kg',ft:'3\'03\"',lb:'52.5 lbs.',t1:'rock',t2:'grass'},
			'346':{m:'1.5m',kg:'60.4kg',ft:'4\'11\"',lb:'133.2 lbs.',t1:'rock',t2:'grass'},
			'347':{m:'0.7m',kg:'12.5kg',ft:'2\'04\"',lb:'27.6 lbs.',t1:'rock',t2:'bug'},
			'348':{m:'1.5m',kg:'68.2kg',ft:'4\'11\"',lb:'150.4 lbs.',t1:'rock',t2:'bug'},
			'349':{m:'0.6m',kg:'7.4kg',ft:'2\'00\"',lb:'16.3 lbs.',t1:'water'},
			'350':{m:'6.2m',kg:'162.0kg',ft:'20\'04\"',lb:'357.1 lbs.',t1:'water'},
			'351':{m:'0.3m',kg:'0.8kg',ft:'1\'00\"',lb:'1.8 lbs.',t1:'normal'},
			'352':{m:'1.0m',kg:'22.0kg',ft:'3\'03\"',lb:'48.5 lbs.',t1:'normal'},
			'353':{m:'0.6m',kg:'2.3kg',ft:'2\'00\"',lb:'5.1 lbs.',t1:'ghost'},
			'354':{m:'1.1m',kg:'12.5kg',ft:'3\'07\"',lb:'27.6 lbs.',t1:'ghost'},
			'355':{m:'0.8m',kg:'15.0kg',ft:'2\'07\"',lb:'33.1 lbs.',t1:'ghost'},
			'356':{m:'1.6m',kg:'30.6kg',ft:'5\'03\"',lb:'67.5 lbs.',t1:'ghost'},
			'357':{m:'2.0m',kg:'100.0kg',ft:'6\'07\"',lb:'220.5 lbs.',t1:'grass',t2:'flying'},
			'358':{m:'0.6m',kg:'1.0kg',ft:'2\'00\"',lb:'2.2 lbs.',t1:'psychic'},
			'359':{m:'1.2m',kg:'47.0kg',ft:'3\'11\"',lb:'103.6 lbs.',t1:'dark'},
			'360':{m:'0.6m',kg:'14.0kg',ft:'2\'00\"',lb:'30.9 lbs.',t1:'psychic'},
			'361':{m:'0.7m',kg:'16.8kg',ft:'2\'04\"',lb:'37.0 lbs.',t1:'ice'},
			'362':{m:'1.5m',kg:'256.5kg',ft:'4\'11\"',lb:'565.5 lbs.',t1:'ice'},
			'363':{m:'0.8m',kg:'39.5kg',ft:'2\'07\"',lb:'87.1 lbs.',t1:'ice',t2:'water'},
			'364':{m:'1.1m',kg:'87.6kg',ft:'3\'07\"',lb:'193.1 lbs.',t1:'ice',t2:'water'},
			'365':{m:'1.4m',kg:'150.6kg',ft:'4\'07\"',lb:'332.0 lbs.',t1:'ice',t2:'water'},
			'366':{m:'0.4m',kg:'52.5kg',ft:'1\'04\"',lb:'115.7 lbs.',t1:'water'},
			'367':{m:'1.7m',kg:'27.0kg',ft:'5\'07\"',lb:'59.5 lbs.',t1:'water'},
			'368':{m:'1.8m',kg:'22.6kg',ft:'5\'11\"',lb:'49.8 lbs.',t1:'water'},
			'369':{m:'1.0m',kg:'23.4kg',ft:'3\'03\"',lb:'51.6 lbs.',t1:'water',t2:'rock'},
			'370':{m:'0.6m',kg:'8.7kg',ft:'2\'00\"',lb:'19.2 lbs.',t1:'water'},
			'371':{m:'0.6m',kg:'42.1kg',ft:'2\'00\"',lb:'92.8 lbs.',t1:'dragon'},
			'372':{m:'1.1m',kg:'110.5kg',ft:'3\'07\"',lb:'243.6 lbs.',t1:'dragon'},
			'373':{m:'1.5m',kg:'102.6kg',ft:'4\'11\"',lb:'226.2 lbs.',t1:'dragon',t2:'flying'},
			'374':{m:'0.6m',kg:'95.2kg',ft:'2\'00\"',lb:'209.9 lbs.',t1:'steel',t2:'psychic'},
			'375':{m:'1.2m',kg:'202.5kg',ft:'3\'11\"',lb:'446.4 lbs.',t1:'steel',t2:'psychic'},
			'376':{m:'1.6m',kg:'550.0kg',ft:'5\'03\"',lb:'1212.5 lbs.',t1:'steel',t2:'psychic'},
			'377':{m:'1.7m',kg:'230.0kg',ft:'5\'07\"',lb:'507.1 lbs.',t1:'rock'},
			'378':{m:'1.8m',kg:'175.0kg',ft:'5\'11\"',lb:'385.8 lbs.',t1:'ice'},
			'379':{m:'1.9m',kg:'205.0kg',ft:'6\'03\"',lb:'451.9 lbs.',t1:'steel'},
			'380':{m:'1.4m',kg:'40.0kg',ft:'4\'07\"',lb:'88.2 lbs.',t1:'dragon',t2:'psychic'},
			'381':{m:'2.0m',kg:'60.0kg',ft:'6\'07\"',lb:'132.3 lbs.',t1:'dragon',t2:'psychic'},
			'382':{m:'4.5m',kg:'352.0kg',ft:'14\'09\"',lb:'776.0 lbs.',t1:'water'},
			'383':{m:'3.5m',kg:'950.0kg',ft:'11\'06\"',lb:'2094.4 lbs.',t1:'ground'},
			'384':{m:'7.0m',kg:'206.5kg',ft:'23\'00\"',lb:'455.2 lbs.',t1:'dragon',t2:'flying'},
			'385':{m:'0.3m',kg:'1.1kg',ft:'1\'00\"',lb:'2.4 lbs.',t1:'steel',t2:'psychic'},
			'386':{m:'1.7m',kg:'60.8kg',ft:'5\'07\"',lb:'134.0 lbs.',t1:'psychic'},
			'387':{m:'0.4m',kg:'10.2kg',ft:'1\'04\"',lb:'22.5 lbs.',t1:'grass'},
			'388':{m:'1.1m',kg:'97.0kg',ft:'3\'07\"',lb:'213.8 lbs.',t1:'grass'},
			'389':{m:'2.2m',kg:'310.0kg',ft:'7\'03\"',lb:'683.4 lbs.',t1:'grass',t2:'ground'},
			'390':{m:'0.5m',kg:'6.2kg',ft:'1\'08\"',lb:'13.7 lbs.',t1:'fire'},
			'391':{m:'0.9m',kg:'22.0kg',ft:'2\'11\"',lb:'48.5 lbs.',t1:'fire',t2:'fighting'},
			'392':{m:'1.2m',kg:'55.0kg',ft:'3\'11\"',lb:'121.3 lbs.',t1:'fire',t2:'fighting'},
			'393':{m:'0.4m',kg:'5.2kg',ft:'1\'04\"',lb:'11.5 lbs.',t1:'water'},
			'394':{m:'0.8m',kg:'23.0kg',ft:'2\'07\"',lb:'50.7 lbs.',t1:'water'},
			'395':{m:'1.7m',kg:'84.5kg',ft:'5\'07\"',lb:'186.3 lbs.',t1:'water',t2:'steel'},
			'396':{m:'0.3m',kg:'2.0kg',ft:'1\'00\"',lb:'4.4 lbs.',t1:'normal',t2:'flying'},
			'397':{m:'0.6m',kg:'15.5kg',ft:'2\'00\"',lb:'34.2 lbs.',t1:'normal',t2:'flying'},
			'398':{m:'1.2m',kg:'24.9kg',ft:'3\'11\"',lb:'54.9 lbs.',t1:'normal',t2:'flying'},
			'399':{m:'0.5m',kg:'20.0kg',ft:'1\'08\"',lb:'44.1 lbs.',t1:'normal'},
			'400':{m:'1.0m',kg:'31.5kg',ft:'3\'03\"',lb:'69.4 lbs.',t1:'normal',t2:'water'},
			'401':{m:'0.3m',kg:'2.2kg',ft:'1\'00\"',lb:'4.9 lbs.',t1:'bug'},
			'402':{m:'1.0m',kg:'25.5kg',ft:'3\'03\"',lb:'56.2 lbs.',t1:'bug'},
			'403':{m:'0.5m',kg:'9.5kg',ft:'1\'08\"',lb:'20.9 lbs.',t1:'electric'},
			'404':{m:'0.9m',kg:'30.5kg',ft:'2\'11\"',lb:'67.2 lbs.',t1:'electric'},
			'405':{m:'1.4m',kg:'42.0kg',ft:'4\'07\"',lb:'92.6 lbs.',t1:'electric'},
			'406':{m:'0.2m',kg:'1.2kg',ft:'0\'08\"',lb:'2.6 lbs.',t1:'grass',t2:'poison'},
			'407':{m:'0.9m',kg:'14.5kg',ft:'2\'11\"',lb:'32.0 lbs.',t1:'grass',t2:'poison'},
			'408':{m:'0.9m',kg:'31.5kg',ft:'2\'11\"',lb:'69.4 lbs.',t1:'rock'},
			'409':{m:'1.6m',kg:'102.5kg',ft:'5\'03\"',lb:'226.0 lbs.',t1:'rock'},
			'410':{m:'0.5m',kg:'57.0kg',ft:'1\'08\"',lb:'125.7 lbs.',t1:'rock',t2:'steel'},
			'411':{m:'1.3m',kg:'149.5kg',ft:'4\'03\"',lb:'329.6 lbs.',t1:'rock',t2:'steel'},
			'412':{m:'0.2m',kg:'3.4kg',ft:'0\'08\"',lb:'7.5 lbs.',t1:'bug'},
			'413':{m:'0.5m',kg:'6.5kg',ft:'1\'08\"',lb:'14.3 lbs.',t1:'bug',t2:'grass'},
			'414':{m:'0.9m',kg:'23.3kg',ft:'2\'11\"',lb:'51.4 lbs.',t1:'bug',t2:'flying'},
			'415':{m:'0.3m',kg:'5.5kg',ft:'1\'00\"',lb:'12.1 lbs.',t1:'bug',t2:'flying'},
			'416':{m:'1.2m',kg:'38.5kg',ft:'3\'11\"',lb:'84.9 lbs.',t1:'bug',t2:'flying'},
			'417':{m:'0.4m',kg:'3.9kg',ft:'1\'04\"',lb:'8.6 lbs.',t1:'electric'},
			'418':{m:'0.7m',kg:'29.5kg',ft:'2\'04\"',lb:'65.0 lbs.',t1:'water'},
			'419':{m:'1.1m',kg:'33.5kg',ft:'3\'07\"',lb:'73.9 lbs.',t1:'water'},
			'420':{m:'0.4m',kg:'3.3kg',ft:'1\'04\"',lb:'7.3 lbs.',t1:'grass'},
			'421':{m:'0.5m',kg:'9.3kg',ft:'1\'08\"',lb:'20.5 lbs.',t1:'grass'},
			'422':{m:'0.3m',kg:'6.3kg',ft:'1\'00\"',lb:'13.9 lbs.',t1:'water'},
			'423':{m:'0.9m',kg:'29.9kg',ft:'2\'11\"',lb:'65.9 lbs.',t1:'water',t2:'ground'},
			'424':{m:'1.2m',kg:'20.3kg',ft:'3\'11\"',lb:'44.8 lbs.',t1:'normal'},
			'425':{m:'0.4m',kg:'1.2kg',ft:'1\'04\"',lb:'2.6 lbs.',t1:'ghost',t2:'flying'},
			'426':{m:'1.2m',kg:'15.0kg',ft:'3\'11\"',lb:'33.1 lbs.',t1:'ghost',t2:'flying'},
			'427':{m:'0.4m',kg:'5.5kg',ft:'1\'04\"',lb:'12.1 lbs.',t1:'normal'},
			'428':{m:'1.2m',kg:'33.3kg',ft:'3\'11\"',lb:'73.4 lbs.',t1:'normal'},
			'429':{m:'0.9m',kg:'4.4kg',ft:'2\'11\"',lb:'9.7 lbs.',t1:'ghost'},
			'430':{m:'0.9m',kg:'27.3kg',ft:'2\'11\"',lb:'60.2 lbs.',t1:'dark',t2:'flying'},
			'431':{m:'0.5m',kg:'3.9kg',ft:'1\'08\"',lb:'8.6 lbs.',t1:'normal'},
			'432':{m:'1.0m',kg:'43.8kg',ft:'3\'03\"',lb:'96.6 lbs.',t1:'normal'},
			'433':{m:'0.2m',kg:'0.6kg',ft:'0\'08\"',lb:'1.3 lbs.',t1:'psychic'},
			'434':{m:'0.4m',kg:'19.2kg',ft:'1\'04\"',lb:'42.3 lbs.',t1:'poison',t2:'dark'},
			'435':{m:'1.0m',kg:'38.0kg',ft:'3\'03\"',lb:'83.8 lbs.',t1:'poison',t2:'dark'},
			'436':{m:'0.5m',kg:'60.5kg',ft:'1\'08\"',lb:'133.4 lbs.',t1:'steel',t2:'psychic'},
			'437':{m:'1.3m',kg:'187.0kg',ft:'4\'03\"',lb:'412.3 lbs.',t1:'steel',t2:'psychic'},
			'438':{m:'0.5m',kg:'15.0kg',ft:'1\'08\"',lb:'33.1 lbs.',t1:'rock'},
			'439':{m:'0.6m',kg:'13.0kg',ft:'2\'00\"',lb:'28.7 lbs.',t1:'psychic'},
			'440':{m:'0.6m',kg:'24.4kg',ft:'2\'00\"',lb:'53.8 lbs.',t1:'normal'},
			'441':{m:'0.5m',kg:'1.9kg',ft:'1\'08\"',lb:'4.2 lbs.',t1:'normal',t2:'flying'},
			'442':{m:'1.0m',kg:'108.0kg',ft:'3\'03\"',lb:'238.1 lbs.',t1:'ghost',t2:'dark'},
			'443':{m:'0.7m',kg:'20.5kg',ft:'2\'04\"',lb:'45.2 lbs.',t1:'dragon',t2:'ground'},
			'444':{m:'1.4m',kg:'56.0kg',ft:'4\'07\"',lb:'123.5 lbs.',t1:'dragon',t2:'ground'},
			'445':{m:'1.9m',kg:'95.0kg',ft:'6\'03\"',lb:'209.4 lbs.',t1:'dragon',t2:'ground'},
			'446':{m:'0.6m',kg:'105.0kg',ft:'2\'00\"',lb:'231.5 lbs.',t1:'normal'},
			'447':{m:'0.7m',kg:'20.2kg',ft:'2\'04\"',lb:'44.5 lbs.',t1:'fighting'},
			'448':{m:'1.2m',kg:'54.0kg',ft:'3\'11\"',lb:'119.0 lbs.',t1:'fighting',t2:'steel'},
			'449':{m:'0.8m',kg:'49.5kg',ft:'2\'07\"',lb:'109.1 lbs.',t1:'ground'},
			'450':{m:'2.0m',kg:'300.0kg',ft:'6\'07\"',lb:'661.4 lbs.',t1:'ground'},
			'451':{m:'0.8m',kg:'12.0kg',ft:'2\'07\"',lb:'26.5 lbs.',t1:'poison',t2:'bug'},
			'452':{m:'1.3m',kg:'61.5kg',ft:'4\'03\"',lb:'135.6 lbs.',t1:'poison',t2:'dark'},
			'453':{m:'0.7m',kg:'23.0kg',ft:'2\'04\"',lb:'50.7 lbs.',t1:'poison',t2:'fighting'},
			'454':{m:'1.3m',kg:'44.4kg',ft:'4\'03\"',lb:'97.9 lbs.',t1:'poison',t2:'fighting'},
			'455':{m:'1.4m',kg:'27.0kg',ft:'4\'07\"',lb:'59.5 lbs.',t1:'grass'},
			'456':{m:'0.4m',kg:'7.0kg',ft:'1\'04\"',lb:'15.4 lbs.',t1:'water'},
			'457':{m:'1.2m',kg:'24.0kg',ft:'3\'11\"',lb:'52.9 lbs.',t1:'water'},
			'458':{m:'1.0m',kg:'65.0kg',ft:'3\'03\"',lb:'143.3 lbs.',t1:'water',t2:'flying'},
			'459':{m:'1.0m',kg:'50.5kg',ft:'3\'03\"',lb:'111.3 lbs.',t1:'grass',t2:'ice'},
			'460':{m:'2.2m',kg:'135.5kg',ft:'7\'03\"',lb:'298.7 lbs.',t1:'grass',t2:'ice'},
			'461':{m:'1.1m',kg:'34.0kg',ft:'3\'07\"',lb:'75.0 lbs.',t1:'dark',t2:'ice'},
			'462':{m:'1.2m',kg:'180.0kg',ft:'3\'11\"',lb:'396.8 lbs.',t1:'electric',t2:'steel'},
			'463':{m:'1.7m',kg:'140.0kg',ft:'5\'07\"',lb:'308.6 lbs.',t1:'normal'},
			'464':{m:'2.4m',kg:'282.8kg',ft:'7\'10\"',lb:'623.5 lbs.',t1:'ground',t2:'rock'},
			'465':{m:'2.0m',kg:'128.6kg',ft:'6\'07\"',lb:'283.5 lbs.',t1:'grass'},
			'466':{m:'1.8m',kg:'138.6kg',ft:'5\'11\"',lb:'305.6 lbs.',t1:'electric'},
			'467':{m:'1.6m',kg:'68.0kg',ft:'5\'03\"',lb:'149.9 lbs.',t1:'fire'},
			'468':{m:'1.5m',kg:'38.0kg',ft:'4\'11\"',lb:'83.8 lbs.',t1:'normal',t2:'flying'},
			'469':{m:'1.9m',kg:'51.5kg',ft:'6\'03\"',lb:'113.5 lbs.',t1:'bug',t2:'flying'},
			'470':{m:'1.0m',kg:'25.5kg',ft:'3\'03\"',lb:'56.2 lbs.',t1:'grass'},
			'471':{m:'0.8m',kg:'25.9kg',ft:'2\'07\"',lb:'57.1 lbs.',t1:'ice'},
			'472':{m:'2.0m',kg:'42.5kg',ft:'6\'07\"',lb:'93.7 lbs.',t1:'ground',t2:'flying'},
			'473':{m:'2.5m',kg:'291.0kg',ft:'8\'02\"',lb:'641.5 lbs.',t1:'ice',t2:'ground'},
			'474':{m:'0.9m',kg:'34.0kg',ft:'2\'11\"',lb:'75.0 lbs.',t1:'normal'},
			'475':{m:'1.6m',kg:'52.0kg',ft:'5\'03\"',lb:'114.6 lbs.',t1:'psychic',t2:'fighting'},
			'476':{m:'1.4m',kg:'340.0kg',ft:'4\'07\"',lb:'749.6 lbs.',t1:'rock',t2:'steel'},
			'477':{m:'2.2m',kg:'106.6kg',ft:'7\'03\"',lb:'235.0 lbs.',t1:'ghost'},
			'478':{m:'1.3m',kg:'26.6kg',ft:'4\'03\"',lb:'58.6 lbs.',t1:'ice',t2:'ghost'},
			'479':{m:'0.3m',kg:'0.3kg',ft:'1\'00\"',lb:'0.7 lbs.',t1:'electric',t2:'ghost'},
			'480':{m:'0.3m',kg:'0.3kg',ft:'1\'00\"',lb:'0.7 lbs.',t1:'psychic'},
			'481':{m:'0.3m',kg:'0.3kg',ft:'1\'00\"',lb:'0.7 lbs.',t1:'psychic'},
			'482':{m:'0.3m',kg:'0.3kg',ft:'1\'00\"',lb:'0.7 lbs.',t1:'psychic'},
			'483':{m:'5.4m',kg:'683.0kg',ft:'17\'09\"',lb:'1505.8 lbs.',t1:'steel',t2:'dragon'},
			'484':{m:'4.2m',kg:'336.0kg',ft:'13\'09\"',lb:'740.8 lbs.',t1:'water',t2:'dragon'},
			'485':{m:'1.7m',kg:'430.0kg',ft:'5\'07\"',lb:'948.0 lbs.',t1:'fire',t2:'steel'},
			'486':{m:'3.7m',kg:'420.0kg',ft:'12\'02\"',lb:'925.9 lbs.',t1:'normal'},
			'487':{m:'4.5m',kg:'750.0kg',ft:'14\'09\"',lb:'1653.5 lbs.',t1:'ghost',t2:'dragon'},
			'488':{m:'1.5m',kg:'85.6kg',ft:'4\'11\"',lb:'188.7 lbs.',t1:'psychic'},
			'489':{m:'0.4m',kg:'3.1kg',ft:'1\'04\"',lb:'6.8 lbs.',t1:'water'},
			'490':{m:'0.3m',kg:'1.4kg',ft:'1\'00\"',lb:'3.1 lbs.',t1:'water'},
			'491':{m:'1.5m',kg:'50.5kg',ft:'4\'11\"',lb:'111.3 lbs.',t1:'dark'},
			'492':{m:'0.2m',kg:'2.1kg',ft:'0\'08\"',lb:'4.6 lbs.',t1:'grass'},
			'493':{m:'3.2m',kg:'320.0kg',ft:'10\'06\"',lb:'705.5 lbs.',t1:'normal'},
			'494':{m:'0.4m',kg:'4.0kg',ft:'1\'04\"',lb:'8.8 lbs.',t1:'psychic',t2:'fire'},
			'495':{m:'0.6m',kg:'8.1kg',ft:'2\'00\"',lb:'17.9 lbs.',t1:'grass'},
			'496':{m:'0.8m',kg:'16.0kg',ft:'2\'07\"',lb:'35.3 lbs.',t1:'grass'},
			'497':{m:'3.3m',kg:'63.0kg',ft:'10\'10\"',lb:'138.9 lbs.',t1:'grass'},
			'498':{m:'0.5m',kg:'9.9kg',ft:'1\'08\"',lb:'21.8 lbs.',t1:'fire'},
			'499':{m:'1.0m',kg:'55.5kg',ft:'3\'03\"',lb:'122.4 lbs.',t1:'fire',t2:'fighting'},
			'500':{m:'1.6m',kg:'150.0kg',ft:'5\'03\"',lb:'330.7 lbs.',t1:'fire',t2:'fighting'},
			'501':{m:'0.5m',kg:'5.9kg',ft:'1\'08\"',lb:'13.0 lbs.',t1:'water'},
			'502':{m:'0.8m',kg:'24.5kg',ft:'2\'07\"',lb:'54.0 lbs.',t1:'water'},
			'503':{m:'1.5m',kg:'94.6kg',ft:'4\'11\"',lb:'208.6 lbs.',t1:'water'},
			'504':{m:'0.5m',kg:'11.6kg',ft:'1\'08\"',lb:'25.6 lbs.',t1:'normal'},
			'505':{m:'1.1m',kg:'27.0kg',ft:'3\'07\"',lb:'59.5 lbs.',t1:'normal'},
			'506':{m:'0.4m',kg:'4.1kg',ft:'1\'04\"',lb:'9.0 lbs.',t1:'normal'},
			'507':{m:'0.9m',kg:'14.7kg',ft:'2\'11\"',lb:'32.4 lbs.',t1:'normal'},
			'508':{m:'1.2m',kg:'61.0kg',ft:'3\'11\"',lb:'134.5 lbs.',t1:'normal'},
			'509':{m:'0.4m',kg:'10.1kg',ft:'1\'04\"',lb:'22.3 lbs.',t1:'dark'},
			'510':{m:'1.1m',kg:'37.5kg',ft:'3\'07\"',lb:'82.7 lbs.',t1:'dark'},
			'511':{m:'0.6m',kg:'10.5kg',ft:'2\'00\"',lb:'23.1 lbs.',t1:'grass'},
			'512':{m:'1.1m',kg:'30.5kg',ft:'3\'07\"',lb:'67.2 lbs.',t1:'grass'},
			'513':{m:'0.6m',kg:'11.0kg',ft:'2\'00\"',lb:'24.3 lbs.',t1:'fire'},
			'514':{m:'1.0m',kg:'28.0kg',ft:'3\'03\"',lb:'61.7 lbs.',t1:'fire'},
			'515':{m:'0.6m',kg:'13.5kg',ft:'2\'00\"',lb:'29.8 lbs.',t1:'water'},
			'516':{m:'1.0m',kg:'29.0kg',ft:'3\'03\"',lb:'63.9 lbs.',t1:'water'},
			'517':{m:'0.6m',kg:'23.3kg',ft:'2\'00\"',lb:'51.4 lbs.',t1:'psychic'},
			'518':{m:'1.1m',kg:'60.5kg',ft:'3\'07\"',lb:'133.4 lbs.',t1:'psychic'},
			'519':{m:'0.3m',kg:'2.1kg',ft:'1\'00\"',lb:'4.6 lbs.',t1:'normal',t2:'flying'},
			'520':{m:'0.6m',kg:'15.0kg',ft:'2\'00\"',lb:'33.1 lbs.',t1:'normal',t2:'flying'},
			'521':{m:'1.2m',kg:'29.0kg',ft:'3\'11\"',lb:'63.9 lbs.',t1:'normal',t2:'flying'},
			'522':{m:'0.8m',kg:'29.8kg',ft:'2\'07\"',lb:'65.7 lbs.',t1:'electric'},
			'523':{m:'1.6m',kg:'79.5kg',ft:'5\'03\"',lb:'175.3 lbs.',t1:'electric'},
			'524':{m:'0.4m',kg:'18.0kg',ft:'1\'04\"',lb:'39.7 lbs.',t1:'rock'},
			'525':{m:'0.9m',kg:'102.0kg',ft:'2\'11\"',lb:'224.9 lbs.',t1:'rock'},
			'526':{m:'1.7m',kg:'260.0kg',ft:'5\'07\"',lb:'573.2 lbs.',t1:'rock'},
			'527':{m:'0.4m',kg:'2.1kg',ft:'1\'04\"',lb:'4.6 lbs.',t1:'psychic',t2:'flying'},
			'528':{m:'0.9m',kg:'10.5kg',ft:'2\'11\"',lb:'23.1 lbs.',t1:'psychic',t2:'flying'},
			'529':{m:'0.3m',kg:'8.5kg',ft:'1\'00\"',lb:'18.7 lbs.',t1:'ground'},
			'530':{m:'0.7m',kg:'40.4kg',ft:'2\'04\"',lb:'89.1 lbs.',t1:'ground',t2:'steel'},
			'531':{m:'1.1m',kg:'31.0kg',ft:'3\'07\"',lb:'68.3 lbs.',t1:'normal'},
			'532':{m:'0.6m',kg:'12.5kg',ft:'2\'00\"',lb:'27.6 lbs.',t1:'fighting'},
			'533':{m:'1.2m',kg:'40.0kg',ft:'3\'11\"',lb:'88.2 lbs.',t1:'fighting'},
			'534':{m:'1.4m',kg:'87.0kg',ft:'4\'07\"',lb:'191.8 lbs.',t1:'fighting'},
			'535':{m:'0.5m',kg:'4.5kg',ft:'1\'08\"',lb:'9.9 lbs.',t1:'water'},
			'536':{m:'0.8m',kg:'17.0kg',ft:'2\'07\"',lb:'37.5 lbs.',t1:'water',t2:'ground'},
			'537':{m:'1.5m',kg:'62.0kg',ft:'4\'11\"',lb:'136.7 lbs.',t1:'water',t2:'ground'},
			'538':{m:'1.3m',kg:'55.5kg',ft:'4\'03\"',lb:'122.4 lbs.',t1:'fighting'},
			'539':{m:'1.4m',kg:'51.0kg',ft:'4\'07\"',lb:'112.4 lbs.',t1:'fighting'},
			'540':{m:'0.3m',kg:'2.5kg',ft:'1\'00\"',lb:'5.5 lbs.',t1:'bug',t2:'grass'},
			'541':{m:'0.5m',kg:'7.3kg',ft:'1\'08\"',lb:'16.1 lbs.',t1:'bug',t2:'grass'},
			'542':{m:'1.2m',kg:'20.5kg',ft:'3\'11\"',lb:'45.2 lbs.',t1:'bug',t2:'grass'},
			'543':{m:'0.4m',kg:'5.3kg',ft:'1\'04\"',lb:'11.7 lbs.',t1:'bug',t2:'poison'},
			'544':{m:'1.2m',kg:'58.5kg',ft:'3\'11\"',lb:'129.0 lbs.',t1:'bug',t2:'poison'},
			'545':{m:'2.5m',kg:'200.5kg',ft:'8\'02\"',lb:'442.0 lbs.',t1:'bug',t2:'poison'},
			'546':{m:'0.3m',kg:'0.6kg',ft:'1\'00\"',lb:'1.3 lbs.',t1:'grass'},
			'547':{m:'0.7m',kg:'6.6kg',ft:'2\'04\"',lb:'14.6 lbs.',t1:'grass'},
			'548':{m:'0.5m',kg:'6.6kg',ft:'1\'08\"',lb:'14.6 lbs.',t1:'grass'},
			'549':{m:'1.1m',kg:'16.3kg',ft:'3\'07\"',lb:'35.9 lbs.',t1:'grass'},
			'550':{m:'1.0m',kg:'18.0kg',ft:'3\'03\"',lb:'39.7 lbs.',t1:'water'},
			'551':{m:'0.7m',kg:'15.2kg',ft:'2\'04\"',lb:'33.5 lbs.',t1:'ground',t2:'dark'},
			'552':{m:'1.0m',kg:'33.4kg',ft:'3\'03\"',lb:'73.6 lbs.',t1:'ground',t2:'dark'},
			'553':{m:'1.5m',kg:'96.3kg',ft:'4\'11\"',lb:'212.3 lbs.',t1:'ground',t2:'dark'},
			'554':{m:'0.6m',kg:'37.5kg',ft:'2\'00\"',lb:'82.7 lbs.',t1:'fire'},
			'555':{m:'1.3m',kg:'92.9kg',ft:'4\'03\"',lb:'204.8 lbs.',t1:'fire'},
			'556':{m:'1.0m',kg:'28.0kg',ft:'3\'03\"',lb:'61.7 lbs.',t1:'grass'},
			'557':{m:'0.3m',kg:'14.5kg',ft:'1\'00\"',lb:'32.0 lbs.',t1:'bug',t2:'rock'},
			'558':{m:'1.4m',kg:'200.0kg',ft:'4\'07\"',lb:'440.9 lbs.',t1:'bug',t2:'rock'},
			'559':{m:'0.6m',kg:'11.8kg',ft:'2\'00\"',lb:'26.0 lbs.',t1:'dark',t2:'fighting'},
			'560':{m:'1.1m',kg:'30.0kg',ft:'3\'07\"',lb:'66.1 lbs.',t1:'dark',t2:'fighting'},
			'561':{m:'1.4m',kg:'14.0kg',ft:'4\'07\"',lb:'30.9 lbs.',t1:'psychic',t2:'flying'},
			'562':{m:'0.5m',kg:'1.5kg',ft:'1\'08\"',lb:'3.3 lbs.',t1:'ghost'},
			'563':{m:'1.7m',kg:'76.5kg',ft:'5\'07\"',lb:'168.7 lbs.',t1:'ghost'},
			'564':{m:'0.7m',kg:'16.5kg',ft:'2\'04\"',lb:'36.4 lbs.',t1:'water',t2:'rock'},
			'565':{m:'1.2m',kg:'81.0kg',ft:'3\'11\"',lb:'178.6 lbs.',t1:'water',t2:'rock'},
			'566':{m:'0.5m',kg:'9.5kg',ft:'1\'08\"',lb:'20.9 lbs.',t1:'rock',t2:'flying'},
			'567':{m:'1.4m',kg:'32.0kg',ft:'4\'07\"',lb:'70.5 lbs.',t1:'rock',t2:'flying'},
			'568':{m:'0.6m',kg:'31.0kg',ft:'2\'00\"',lb:'68.3 lbs.',t1:'poison'},
			'569':{m:'1.9m',kg:'107.3kg',ft:'6\'03\"',lb:'236.6 lbs.',t1:'poison'},
			'570':{m:'0.7m',kg:'12.5kg',ft:'2\'04\"',lb:'27.6 lbs.',t1:'dark'},
			'571':{m:'1.6m',kg:'81.1kg',ft:'5\'03\"',lb:'178.8 lbs.',t1:'dark'},
			'572':{m:'0.4m',kg:'5.8kg',ft:'1\'04\"',lb:'12.8 lbs.',t1:'normal'},
			'573':{m:'0.5m',kg:'7.5kg',ft:'1\'08\"',lb:'16.5 lbs.',t1:'normal'},
			'574':{m:'0.4m',kg:'5.8kg',ft:'1\'04\"',lb:'12.8 lbs.',t1:'psychic'},
			'575':{m:'0.7m',kg:'18.0kg',ft:'2\'04\"',lb:'39.7 lbs.',t1:'psychic'},
			'576':{m:'1.5m',kg:'44.0kg',ft:'4\'11\"',lb:'97.0 lbs.',t1:'psychic'},
			'577':{m:'0.3m',kg:'1.0kg',ft:'1\'00\"',lb:'2.2 lbs.',t1:'psychic'},
			'578':{m:'0.6m',kg:'8.0kg',ft:'2\'00\"',lb:'17.6 lbs.',t1:'psychic'},
			'579':{m:'1.0m',kg:'20.1kg',ft:'3\'03\"',lb:'44.3 lbs.',t1:'psychic'},
			'580':{m:'0.5m',kg:'5.5kg',ft:'1\'08\"',lb:'12.1 lbs.',t1:'water',t2:'flying'},
			'581':{m:'1.3m',kg:'24.2kg',ft:'4\'03\"',lb:'53.4 lbs.',t1:'water',t2:'flying'},
			'582':{m:'0.4m',kg:'5.7kg',ft:'1\'04\"',lb:'12.6 lbs.',t1:'ice'},
			'583':{m:'1.1m',kg:'41.0kg',ft:'3\'07\"',lb:'90.4 lbs.',t1:'ice'},
			'584':{m:'1.3m',kg:'57.5kg',ft:'4\'03\"',lb:'126.8 lbs.',t1:'ice'},
			'585':{m:'0.6m',kg:'19.5kg',ft:'2\'00\"',lb:'43.0 lbs.',t1:'normal',t2:'grass'},
			'586':{m:'1.9m',kg:'92.5kg',ft:'6\'03\"',lb:'203.9 lbs.',t1:'normal',t2:'grass'},
			'587':{m:'0.4m',kg:'5.0kg',ft:'1\'04\"',lb:'11.0 lbs.',t1:'electric',t2:'flying'},
			'588':{m:'0.5m',kg:'5.9kg',ft:'1\'08\"',lb:'13.0 lbs.',t1:'bug'},
			'589':{m:'1.0m',kg:'33.0kg',ft:'3\'03\"',lb:'72.8 lbs.',t1:'bug',t2:'steel'},
			'590':{m:'0.2m',kg:'1.0kg',ft:'0\'08\"',lb:'2.2 lbs.',t1:'grass',t2:'poison'},
			'591':{m:'0.6m',kg:'10.5kg',ft:'2\'00\"',lb:'23.1 lbs.',t1:'grass',t2:'poison'},
			'592':{m:'1.2m',kg:'33.0kg',ft:'3\'11\"',lb:'72.8 lbs.',t1:'water',t2:'ghost'},
			'593':{m:'2.2m',kg:'135.0kg',ft:'7\'03\"',lb:'297.6 lbs.',t1:'water',t2:'ghost'},
			'594':{m:'1.2m',kg:'31.6kg',ft:'3\'11\"',lb:'69.7 lbs.',t1:'water'},
			'595':{m:'0.1m',kg:'0.6kg',ft:'0\'04\"',lb:'1.3 lbs.',t1:'bug',t2:'electric'},
			'596':{m:'0.8m',kg:'14.3kg',ft:'2\'07\"',lb:'31.5 lbs.',t1:'bug',t2:'electric'},
			'597':{m:'0.6m',kg:'18.8kg',ft:'2\'00\"',lb:'41.4 lbs.',t1:'grass',t2:'steel'},
			'598':{m:'1.0m',kg:'110.0kg',ft:'3\'03\"',lb:'242.5 lbs.',t1:'grass',t2:'steel'},
			'599':{m:'0.3m',kg:'21.0kg',ft:'1\'00\"',lb:'46.3 lbs.',t1:'steel'},
			'600':{m:'0.6m',kg:'51.0kg',ft:'2\'00\"',lb:'112.4 lbs.',t1:'steel'},
			'601':{m:'0.6m',kg:'81.0kg',ft:'2\'00\"',lb:'178.6 lbs.',t1:'steel'},
			'602':{m:'0.2m',kg:'0.3kg',ft:'0\'08\"',lb:'0.7 lbs.',t1:'electric'},
			'603':{m:'1.2m',kg:'22.0kg',ft:'3\'11\"',lb:'48.5 lbs.',t1:'electric'},
			'604':{m:'2.1m',kg:'80.5kg',ft:'6\'11\"',lb:'177.5 lbs.',t1:'electric'},
			'605':{m:'0.5m',kg:'9.0kg',ft:'1\'08\"',lb:'19.8 lbs.',t1:'psychic'},
			'606':{m:'1.0m',kg:'34.5kg',ft:'3\'03\"',lb:'76.1 lbs.',t1:'psychic'},
			'607':{m:'0.3m',kg:'3.1kg',ft:'1\'00\"',lb:'6.8 lbs.',t1:'ghost',t2:'fire'},
			'608':{m:'0.6m',kg:'13.0kg',ft:'2\'00\"',lb:'28.7 lbs.',t1:'ghost',t2:'fire'},
			'609':{m:'1.0m',kg:'34.3kg',ft:'3\'03\"',lb:'75.6 lbs.',t1:'ghost',t2:'fire'},
			'610':{m:'0.6m',kg:'18.0kg',ft:'2\'00\"',lb:'39.7 lbs.',t1:'dragon'},
			'611':{m:'1.0m',kg:'36.0kg',ft:'3\'03\"',lb:'79.4 lbs.',t1:'dragon'},
			'612':{m:'1.8m',kg:'105.5kg',ft:'5\'11\"',lb:'232.6 lbs.',t1:'dragon'},
			'613':{m:'0.5m',kg:'8.5kg',ft:'1\'08\"',lb:'18.7 lbs.',t1:'ice'},
			'614':{m:'2.6m',kg:'260.0kg',ft:'8\'06\"',lb:'573.2 lbs.',t1:'ice'},
			'615':{m:'1.1m',kg:'148.0kg',ft:'3\'07\"',lb:'326.3 lbs.',t1:'ice'},
			'616':{m:'0.4m',kg:'7.7kg',ft:'1\'04\"',lb:'17.0 lbs.',t1:'bug'},
			'617':{m:'0.8m',kg:'25.3kg',ft:'2\'07\"',lb:'55.8 lbs.',t1:'bug'},
			'618':{m:'0.7m',kg:'11.0kg',ft:'2\'04\"',lb:'24.3 lbs.',t1:'ground',t2:'electric'},
			'619':{m:'0.9m',kg:'20.0kg',ft:'2\'11\"',lb:'44.1 lbs.',t1:'fighting'},
			'620':{m:'1.4m',kg:'35.5kg',ft:'4\'07\"',lb:'78.3 lbs.',t1:'fighting'},
			'621':{m:'1.6m',kg:'139.0kg',ft:'5\'03\"',lb:'306.4 lbs.',t1:'dragon'},
			'622':{m:'1.0m',kg:'92.0kg',ft:'3\'03\"',lb:'202.8 lbs.',t1:'ground',t2:'ghost'},
			'623':{m:'2.8m',kg:'330.0kg',ft:'9\'02\"',lb:'727.5 lbs.',t1:'ground',t2:'ghost'},
			'624':{m:'0.5m',kg:'10.2kg',ft:'1\'08\"',lb:'22.5 lbs.',t1:'dark',t2:'steel'},
			'625':{m:'1.6m',kg:'70.0kg',ft:'5\'03\"',lb:'154.3 lbs.',t1:'dark',t2:'steel'},
			'626':{m:'1.6m',kg:'94.6kg',ft:'5\'03\"',lb:'208.6 lbs.',t1:'normal'},
			'627':{m:'0.5m',kg:'10.5kg',ft:'1\'08\"',lb:'23.1 lbs.',t1:'normal',t2:'flying'},
			'628':{m:'1.5m',kg:'41.0kg',ft:'4\'11\"',lb:'90.4 lbs.',t1:'normal',t2:'flying'},
			'629':{m:'0.5m',kg:'9.0kg',ft:'1\'08\"',lb:'19.8 lbs.',t1:'dark',t2:'flying'},
			'630':{m:'1.2m',kg:'39.5kg',ft:'3\'11\"',lb:'87.1 lbs.',t1:'dark',t2:'flying'},
			'631':{m:'1.4m',kg:'58.0kg',ft:'4\'07\"',lb:'127.9 lbs.',t1:'fire'},
			'632':{m:'0.3m',kg:'33.0kg',ft:'1\'00\"',lb:'72.8 lbs.',t1:'bug',t2:'steel'},
			'633':{m:'0.8m',kg:'17.3kg',ft:'2\'07\"',lb:'38.1 lbs.',t1:'dark',t2:'dragon'},
			'634':{m:'1.4m',kg:'50.0kg',ft:'4\'07\"',lb:'110.2 lbs.',t1:'dark',t2:'dragon'},
			'635':{m:'1.8m',kg:'160.0kg',ft:'5\'11\"',lb:'352.7 lbs.',t1:'dark',t2:'dragon'},
			'636':{m:'1.1m',kg:'28.8kg',ft:'3\'07\"',lb:'63.5 lbs.',t1:'bug',t2:'fire'},
			'637':{m:'1.6m',kg:'46.0kg',ft:'5\'03\"',lb:'101.4 lbs.',t1:'bug',t2:'fire'},
			'638':{m:'2.1m',kg:'250.0kg',ft:'6\'11\"',lb:'551.2 lbs.',t1:'steel',t2:'fighting'},
			'639':{m:'1.9m',kg:'260.0kg',ft:'6\'03\"',lb:'573.2 lbs.',t1:'rock',t2:'fighting'},
			'640':{m:'2.0m',kg:'200.0kg',ft:'6\'07\"',lb:'440.9 lbs.',t1:'grass',t2:'fighting'},
			'641':{m:'1.5m',kg:'63.0kg',ft:'4\'11\"',lb:'138.9 lbs.',t1:'flying'},
			'642':{m:'1.5m',kg:'61.0kg',ft:'4\'11\"',lb:'134.5 lbs.',t1:'electric',t2:'flying'},
			'643':{m:'3.2m',kg:'330.0kg',ft:'10\'06\"',lb:'727.5 lbs.',t1:'dragon',t2:'fire'},
			'644':{m:'2.9m',kg:'345.0kg',ft:'9\'06\"',lb:'760.6 lbs.',t1:'dragon',t2:'electric'},
			'645':{m:'1.5m',kg:'68.0kg',ft:'4\'11\"',lb:'149.9 lbs.',t1:'ground',t2:'flying'},
			'646':{m:'3.0m',kg:'325.0kg',ft:'9\'10\"',lb:'716.5 lbs.',t1:'dragon',t2:'ice'}
		};
	}
	
	function getString(sid) {
		return {
			"census.default.name":{
				de:"Bisasam",
				en:"Bulbasaur",
				es:"Bulbasaur",
				fr:"Bulbizarre",
				it:"Bulbasaur",
				ja:"フシギダネ",
				ko:"이상해씨"
			},
			"census.default.pokedex":{
				de:1,
				en:1,
				es:1,
				fr:1,
				it:1,
				ja:1,
				ko:1
			},
			dialog_29:{
				de:"Deine Spielsynchro ID ist nur vorläufig\nregistriert. Bitte komm wieder, wenn du\nein Pokémon schlafen gelegt hast.",
				en:"Your Game Sync ID has been temporarily\nregistered. Visit the Pokémon DW after\ntucking in a Pokémon in your Nintendo DS™ system.",
				es:"Estás usando un registro temporal de tu ID para Sincronizar. Acuesta a tu Pokémon en tu consola\nNintendo DS™ e inténtalo de nuevo.",
				fr:"Votre inscription est provisoire.\nVeuillez revenir après avoir endormi un Pokémon\ndepuis votre Nintendo DS™.",
				it:"L'ID Sincrogioco è ancora temporaneo. Per completare la registrazione, fai addormentare un Pokémon nel Sincrogioco e poi effettua nuovamente il login.",
				ja:"ゲームシンクIDコードが仮登録の状態です。「ポケットモンスターブラック・ホワイト」でポケモンをねむらせてから、もう一度アクセスしてください。",
				ko:"게임싱크 ID가 임시 등록 상태입니다. 「포켓몬스터 블랙・화이트」로 포켓몬을 재운 후 다시 한번 접속해 주십시오."
			},
			new_pdwstart_1:{
				de:"Die Registrierungsdaten werden gerade verarbeitet. Bitte versuche später erneut auf die Seite zuzugreifen.",
				en:"Processing registration data. Please wait a bit before trying again.",
				es:"Los datos del registro están siendo procesados. Intenta acceder dentro de un rato.",
				fr:"Les données d'inscription sont en train d'être modifiées. Veuillez renouveler votre connexion ultérieurement.",
				it:"Elaborazione dei dati in corso. Riprova ad accedere più tardi.",
				ja:"登録情報を反映するのに時間がかかっています。しばらく時間がたってから、もう一度アクセスしてください。",
				ko:"등록정보 반영이 지연되고 있습니다. 잠시 후 다시 한번 접속해 주십시오."
			},
			pg_af_1:{
				de:"Du hast die Pokémon DW zuletzt am [DD].[MM], [hh]:[mm] Uhr betreten.\nIn [hh2] Stunden erhältst du das nächste Mal Zugang.",
				en:"Your previous access time: [MM]-[DD] [hh]:[mm]\nNext access available: in [hh2] hours",
				es:"Te conectaste por última vez:  [DD]-[MM] [hh]:[mm]\nPodrás volver a conectarte una vez hayan transcurrido las siguientes horas: [hh2]",
				fr:"Votre accès précédent date du [DD]/[MM] à [hh]:[mm].\nVous pourrez y accéder à nouveau dans [hh2] heures.",
				it:"Hai effettuato l'ultimo accesso il [DD]/[MM] [hh]:[mm].\nAttendi ancora [hh2] h per il prossimo.",
				ja:"前回のアクセス時間は[MM]/[DD] [hh]:[mm]です。\n次回は、[hh2]時間後から受付いたします。",
				ko:"지난번 접속 시간은 [MM]-[DD] [hh]:[mm]입니다.\n다음 접속은 [hh2]시간 이후부터 할 수 있습니다."
			},
			pg_af_2:{
				de:"Du hast die Pokémon DW zuletzt am [DD].[MM], [hh]:[mm] Uhr betreten.\nIn [mm2] Minuten erhältst du das nächste Mal Zugang.",
				en:"Your previous access time: [MM]-[DD] [hh]:[mm]\nNext access available: in [mm2] minutes",
				es:"Te conectaste por última vez:  [DD]-[MM] [hh]:[mm]\nPodrás volver a conectarte una vez hayan transcurrido los siguientes minutos:  [mm2] ",
				fr:"Votre accès précédent date du [DD]/[MM] à [hh]:[mm].\nVous pourrez y accéder à nouveau dans [mm2] minutes.",
				it:"Hai effettuato l'ultimo accesso il [DD]/[MM] [hh]:[mm].\nAttendi ancora [mm2] min. per il prossimo.",
				ja:"前回のアクセス時間は[MM]/[DD] [hh]:[mm]です。\n次回は、[mm2]分後から受付いたします。",
				ko:"지난번 접속 시간은 [MM]-[DD] [hh]:[mm]입니다.\n다음 접속은 [mm2]분 이후부터 할 수 있습니다."
			},
			pg_af_3:{
				de:"Du hast die Pokémon DW zuletzt am [DD].[MM], [hh]:[mm] Uhr betreten.\nInnerhalb der nächsten Minute erhältst du das nächste Mal Zugang.",
				en:"Your previous access time: [MM]-[DD] [hh]:[mm]\nAccess available within 1 minute.",
				es:"Te conectaste por última vez:  [DD]-[MM] [hh]:[mm]\nPodrás volver a conectarte en menos de un minuto.",
				fr:"Votre accès précédent date du [DD]/[MM] à [hh]:[mm].\nVous pourrez y accéder à nouveau dans une minute.",
				it:"Hai effettuato l'ultimo accesso il [DD]/[MM] [hh]:[mm].\nPotrai accedere di nuovo tra meno di un minuto.",
				ja:"前回のアクセス時間は[MM]/[DD] [hh]:[mm]です。\n次回は、1分以内から受付いたします。",
				ko:"지난번 접속 시간은 [MM]-[DD] [hh]:[mm]입니다.\n다음 접속은 1분 이내에 할 수 있습니다."
			},
			pg_ag_8:{
				de:"Die Pokémon DW erfährt gerade ein extrem\nhohes Datenaufkommen. Bitte\nversuch es später noch einmal.",
				en:"The Pokemon DW is currently very busy. Please try again later. \nWe apologize for the inconvenience.",
				es:"El servidor de Pokémon Dream World está ocupado. Espera unos minutos y vuelve a intentarlo.",
				fr:"Le trafic est très perturbé dans le Pokémon Dream World. Nous vous prions de renouveler votre accès ultérieurement.",
				it:"In questo momento il Pokémon DW sta registrando molto traffico. Ti preghiamo di riprovare più tardi.",
				ja:"ポケモンドリームワールドは、ただいま大変混雑しています。\nしばらく時間がたってから、もう一度アクセスしてください。",
				ko:"PDW가 현재\n매우 혼잡한 상황입니다. 죄송합니다.\n잠시 후 다시 접속해 주십시오."
			},
			"pgltop.accept_time.1":{
				de:"Nächster Zugang möglich in [HH] Stunde(n)",
				en:"Access available: in [HH] hour(s)",
				es:"Acceso posible en: [HH] hora(s)",
				fr:"Prochain accès possible dans [HH] heure(s).",
				it:"Prossimo accesso tra ore: [HH]",
				ja:"アクセス受付時間　[HH]時間後",
				ko:"접속 가능 시간 [HH]시간 후"
			},
			"pgltop.accept_time.2":{
				de:"Nächster Zugang möglich in [MM] Minute(n)",
				en:"Access available: in [MM] minutes",
				es:"Acceso posible en: [MM] minuto(s)",
				fr:"Prochain accès possible dans [MM] minutes.",
				it:"Prossimo accesso tra minuti: [MM]",
				ja:"アクセス受付時間　[MM]分後",
				ko:"접속 가능 시간 [MM]분 후"
			},
			"pgltop.accept_time.3":{
				de:"Nächster Zugang möglich innerhalb einer Minute",
				en:"Access available within 1 minute",
				es:"Acceso posible en: menos de un minuto",
				fr:"Prochain accès possible dans 1 minute.",
				it:"Prossimo accesso tra meno di un minuto",
				ja:"アクセス受付時間　あと1分以内",
				ko:"접속 가능 시간 앞으로 1분 이내"
			},
			"pgltop.accept_time.4":{
				de:"Zugang zurzeit möglich",
				en:"Currently accessible",
				es:"Estás dentro del tiempo de acceso",
				fr:"Accès possible.",
				it:"Puoi effettuare l'accesso ora.",
				ja:"アクセス受付時間中",
				ko:"현재 접속 가능 "
			},
			"pgltop.member.last_upload":{
				de:"Zuletzt schlafen gelegt am: DD.MM um hh:mm Uhr",
				en:"Last tucked-in time: MM/DD hh:mm",
				es:"Último Pokémon acostado el DD/MM a las hh:mm",
				fr:"Dernier Pokémon endormi à hh:mm le DD/MM",
				it:"Ultimo sonno: DD/MM hh:mm",
				ja:"最後にねむらせた時間：MM/DD hh:mm",
				ko:"마지막으로 잠재운 시간: MM/DD hh:mm"
			},
			"pgltop.membership.processing":{
				de:"Deine Mitgliedsdaten werden bearbeitet. Bitte versuche später auf die Seite zuzugreifen.\nHinweis: Solltest du diese Nachricht in einigen Stunden weiterhin erhalten, findest du unter http://support-de.pokemon.com/ Hilfe.",
				en:"Processing your membership information.\nPlease try accessing the site later.\nNote: If you still get this message after several hours have passed, please contact http://support.pokemon.com/.",
				es:"Estamos procesando la información relativa a tu cuenta.\nIntenta acceder más tarde.\nNota: Si pasadas varias horas todavía ves este mensaje, ponte en contacto con http://support-es.pokemon.com/.",
				fr:"Traitement en cours.\nVeuillez réessayer d'accéder au site ultérieurement.\nNote : si vous continuez à recevoir ce message après que plusieurs heures se sont écoulées, veuillez contacter http://support-fr.pokemon.com.",
				it:"Stiamo processando le informazioni relative al tuo account.\nRiprova ad accedere più tardi.\nNota: se continui a visualizzare questo messaggio da diverse ore, contatta http://support-it.pokemon.com/.",
				ja:"会員情報の処理中です。しばらく経ってから再度アクセスをお試し下さい。\n数時間経ってもこのメッセージが出る場合は、ポケモンだいすきクラブまでお問い合わせ下さい。",
				ko:"회원정보를 처리 중입니다. 잠시 후 다시 접속해 주십시오. 몇 시간이 지나도 이 메시지가 나오는 경우 고객 센터로 문의부탁합니다."
			},
			"pgltop.wakeup.complete":{
				de:"Das Pokémon wurde aufgeweckt.",
				en:"The Pokémon woke up.",
				es:"El Pokémon se ha despertado.",
				fr:"Le Pokémon s'est réveillé.",
				it:"Il Pokémon si è svegliato.",
				ja:"ポケモンを起こしました。",
				ko:"포켓몬을 깨웠습니다."
			},
			"pgltop.wakeup.confirm":{
				de:"Das Pokémon aufwecken?",
				en:"Wake up the Pokémon?",
				es:"¿Quieres despertar al Pokémon?",
				fr:"Réveiller le Pokémon ?",
				it:"Vuoi svegliare il Pokémon?",
				ja:"ポケモンを起こしますか？",
				ko:"포켓몬을 깨우겠습니까?"
			}
		}[sid][theme.language];
	}
});



var areas = {
	'1':{ tzname:'Asia/Kabul', tzoffset:4.5, latitude:0.592198087, longitude:1.181220302 },
	'2':{ tzname:'Africa/Algiers', tzoffset:1, latitude:0.489161353, longitude:0.0288475 },
	'4':{ tzname:'Europe/Andorra', tzoffset:1, coords:'42.5N,1.5E' },
	'5':{ tzname:'Africa/Luanda', tzoffset:1, latitude:-0.195604879, longitude:0.312076547 },
	'6':{ tzname:'America/Antigua', tzoffset:-4, latitude:0.302435959, longitude:-1.082204423 },
	'7':{ tzname:'America/Argentina/Buenos_Aires', tzoffset:-3, latitude:-0.604089538, longitude:-1.019574382 },
	'8':{ tzname:'Asia/Yerevan', tzoffset:4, coords:'40N,45E' },
	'9':{ tzname:'America/Aruba', tzoffset:-4, coords:'12.5N,69.97W' },
	'10':{ tzname:'Australia/Sydney', tzoffset:10, latitude:-0.616972669, longitude:2.601266555 },
	'11':{ tzname:'Europe/Vienna', tzoffset:1, latitude:0.841280831, longitude:0.285615645 },
	'12':{ tzname:'Asia/Baku', tzoffset:4, coords:'40.5N,47.5E' },
	'13':{ tzname:'Asia/Bahrain', tzoffset:3, latitude:0.452257011, longitude:0.883263504 },
	'15':{ tzname:'America/Barbados', tzoffset:-4, latitude:0.230096355, longitude:-1.039075644 },
	'17':{ tzname:'Europe/Brussels', tzoffset:1, latitude:0.881411745, longitude:0.078134429 },
	'18':{ tzname:'America/Belize', tzoffset:-6, latitude:0.300073202, longitude:-1.541936767 },
	'19':{ tzname:'Africa/Porto-Novo', tzoffset:1, latitude:0.162700413, longitude:0.040371874 },
	'22':{ tzname:'America/La_Paz', tzoffset:-4, latitude:-0.284285337, longitude:-1.109146774 },
	'23':{ tzname:'Africa/Gaborone', tzoffset:2, latitude:-0.389976874, longitude:0.430750017 },
	'24':{ tzname:'America/Sao_Paulo', tzoffset:-3, latitude:-0.275624315, longitude:-0.835973459 },
	'26':{ tzname:'Europe/Sofia', tzoffset:2, latitude:0.745695955, longitude:0.444736824 },
	'27':{ tzname:'Africa/Ouagadougou', tzoffset:3, coords:'13N,2W' },
	'28':{ tzname:'Africa/Bujumbura', tzoffset:2, latitude:-0.059130324, longitude:0.522209406 },
	'30':{ tzname:'Africa/Douala', tzoffset:1, latitude:0.12854877, longitude:0.215433652 },
	'31':{ tzname:'America/Toronto', tzoffset:-4, latitude:0.8, longitude:-1.321182723 },
	'33':{ tzname:'America/Cayman', tzoffset:-5, coords:'19.5N,80.5W' },
	'34':{ tzname:'Africa/Bangui', tzoffset:1, coords:'7N,21E' },
	'35':{ tzname:'Africa/Ndjamena', tzoffset:1, latitude:0.269578634, longitude:0.327040982 },
	'36':{ tzname:'America/Santiago', tzoffset:-4, latitude:-0.583812634, longitude:-1.23336606 },
	'37':{ tzname:'Asia/Chongqing', tzoffset:8, latitude:0.625904042, longitude:1.818552743 },
	'38':{ tzname:'America/Bogota', tzoffset:-5, latitude:0.079934404, longitude:-1.29676171 },
	'39':{ tzname:'Indian/Comoro', tzoffset:3, coords:'12.17S,44.25E' },
	'40':{ tzname:'Africa/Brazzaville', tzoffset:1, latitude:-0.011564813, longitude:0.260532698 },
	'41':{ tzname:'Pacific/Rarotonga', tzoffset:-10, latitude:-0.26955036, longitude:-2.820192244 },
	'42':{ tzname:'America/Costa_Rica', tzoffset:-6, latitude:0.145873676, longitude:-1.480481141 },
	'44':{ tzname:'Europe/Zagreb', tzoffset:1, latitude:0.77608383, longitude:0.287436826 },
	'45':{ tzname:'Asia/Nicosia', tzoffset:2, latitude:0.613178218, longitude:0.583559614 },
	'46':{ tzname:'Europe/Prague', tzoffset:1, latitude:0.874040225, longitude:0.251984267 },
	'47':{ tzname:'Europe/Copenhagen', tzoffset:1, latitude:0.971734646, longitude:0.219354988 },
	'49':{ tzname:'America/Dominica', tzoffset:-4, latitude:0.26907303, longitude:-1.071006111 },
	'50':{ tzname:'America/Santo_Domingo', tzoffset:-4, latitude:0.326376134, longitude:-1.224553424 },
	'51':{ tzname:'America/Guayaquil', tzoffset:-5, latitude:-0.029095075, longitude:-1.459054746 },
	'52':{ tzname:'Africa/Cairo', tzoffset:2, latitude:0.465939502, longitude:0.53747156 },
	'53':{ tzname:'America/El_Salvador', tzoffset:-6, latitude:0.24080086, longitude:-1.551779429 },
	'54':{ tzname:'Africa/Malabo', tzoffset:0, latitude:0.173396472, longitude:-0.198333334 },
	'55':{ tzname:'Africa/Asmara', tzoffset:3, coords:'15N,39E' },
	'56':{ tzname:'Europe/Tallinn', tzoffset:2, coords:'59N,26E' },
	'57':{ tzname:'Africa/Addis_Ababa', tzoffset:3, coords:'8N,38E' },
	'59':{ tzname:'Europe/Helsinki', tzoffset:2, latitude:1.050003884, longitude:0.435504119 },
	'60':{ tzname:'Europe/Paris', tzoffset:1, latitude:0.852707798, longitude:0.041032097 },
	'61':{ tzname:'Africa/Libreville', tzoffset:1, latitude:-0.014453019, longitude:0.202439152 },
	'62':{ tzname:'Asia/Tbilisi', tzoffset:4, coords:'42N,43.5E' },
	'63':{ tzname:'Europe/Berlin', tzoffset:1, latitude:0.916707661, longitude:0.234074728 },
	'64':{ tzname:'Africa/Accra', tzoffset:0, latitude:0.138841151, longitude:-0.018008639 },
	'65':{ tzname:'Europe/Athens', tzoffset:2, latitude:0.662764698, longitude:0.413974453 },
	'67':{ tzname:'America/Grenada', tzoffset:-4, latitude:0.213991224, longitude:-1.074917062 },
	'69':{ tzname:'America/Guatemala', tzoffset:-6, latitude:0.275347681, longitude:-1.574851512 },
	'71':{ tzname:'Africa/Bissau', tzoffset:0, coords:'12N,15W' },
	'72':{ tzname:'America/Guyana', tzoffset:-4, latitude:0.084933359, longitude:-1.02866671 },
	'73':{ tzname:'America/Port-au-Prince', tzoffset:-5, latitude:0.332562488, longitude:-1.274892699 },
	'74':{ tzname:'America/Tegucigalpa', tzoffset:-6, latitude:0.265342738, longitude:-1.505400533 },
	'75':{ tzname:'Asia/Hong_Kong', tzoffset:8, latitude:0.39062755, longitude:1.992618636 },
	'76':{ tzname:'Europe/Budapest', tzoffset:1, latitude:0.823117504, longitude:0.340440154 },
	'77':{ tzname:'Atlantic/Reykjavik', tzoffset:0, latitude:1.119372815, longitude:-0.382143505 },
	'78':{ tzname:'Asia/Kolkata', tzoffset:5.5, latitude:0.368712551, longitude:1.438101317 },
	'79':{ tzname:'Asia/Jakarta', tzoffset:7, latitude:-0.044509736, longitude:2.05976023 },
	'80':{ tzname:'Europe/Dublin', tzoffset:0, latitude:0.931030251, longitude:-0.109388389 },
	'81':{ tzname:'Asia/Jerusalem', tzoffset:2, latitude:0.547894509, longitude:0.610498876 },
	'82':{ tzname:'Europe/Rome', tzoffset:1, latitude:0.74, longitude:0.25 },
	'83':{ tzname:'America/Jamaica', tzoffset:-5, latitude:0.316171019, longitude:-1.348676633 },
	'84':{ tzname:'Asia/Amman', tzoffset:2, latitude:0.545882668, longitude:0.648051031 },
	'85':{ tzname:'Asia/Qyzylorda', tzoffset:6, coords:'48N,68E' },
	'86':{ tzname:'Africa/Nairobi', tzoffset:3, latitude:0.007222888, longitude:0.661549041 },
	'88':{ tzname:'Asia/Seoul', tzoffset:9, latitude:0.626708587, longitude:2.229953464 },
	'89':{ tzname:'Asia/Kuwait', tzoffset:3, latitude:0.511560943, longitude:0.82893589 },
	'92':{ tzname:'Europe/Riga', tzoffset:2, coords:'57N,25E' },
	'93':{ tzname:'Asia/Beirut', tzoffset:2, latitude:0.59119803, longitude:0.626167063 },
	'95':{ tzname:'Europe/Vaduz', tzoffset:1, coords:'47.27N,9.533E' },
	'96':{ tzname:'Europe/Vilnius', tzoffset:1, coords:'56N,24E' },
	'97':{ tzname:'Europe/Luxembourg', tzoffset:1, latitude:0.869444319, longitude:0.107046262 },
	'98':{ tzname:'Indian/Antananarivo', tzoffset:3, coords:'20S,47E' },
	'99':{ tzname:'Africa/Blantyre', tzoffset:2, coords:'13.5S,34E' },
	'100':{ tzname:'Asia/Kuala_Lumpur', tzoffset:8, latitude:0.069712674, longitude:1.77968063 },
	'102':{ tzname:'Africa/Bamako', tzoffset:0, coords:'17N,4W' },
	'103':{ tzname:'Europe/Malta', tzoffset:1, latitude:0.627378723, longitude:0.251058701 },
	'104':{ tzname:'Africa/Nouakchott', tzoffset:0, coords:'20N,12W' },
	'105':{ tzname:'Indian/Mauritius', tzoffset:4, latitude:-0.269173142, longitude:1.04731009 },
	'106':{ tzname:'America/Mexico_City', tzoffset:-6, latitude:0.338779508, longitude:-1.73015515 },
	'108':{ tzname:'Europe/Chisinau', tzoffset:2, coords:'47N,29E' },
	'109':{ tzname:'Europe/Monaco', tzoffset:1, coords:'43.73N,7.4E' },
	'111':{ tzname:'Africa/Casablanca', tzoffset:0, latitude:0.554928588, longitude:-0.123572173 },
	'112':{ tzname:'Africa/Maputo', tzoffset:2, coords:'18.25S,35E' },
	'113':{ tzname:'Africa/Windhoek', tzoffset:1, coords:'22S,17E' },
	'116':{ tzname:'Europe/Amsterdam', tzoffset:1, latitude:0.91403996, longitude:0.085312078 },
	'117':{ tzname:'America/Curacao', tzoffset:-4, coords:'12.25N,66.75W' },
	'118':{ tzname:'Pacific/Auckland', tzoffset:12, latitude:-0.719286837, longitude:3.010054169 },
	'119':{ tzname:'America/Managua', tzoffset:-6, latitude:0.224566733, longitude:-1.485994095 },
	'120':{ tzname:'Africa/Niamey', tzoffset:1, latitude:0.307369952, longitude:0.141039114 },
	'121':{ tzname:'Africa/Lagos', tzoffset:1, latitude:0.158555745, longitude:0.151394258 },
	'122':{ tzname:'Europe/Oslo', tzoffset:1, latitude:1.045693426, longitude:0.187426388 },
	'123':{ tzname:'Asia/Muscat', tzoffset:4, latitude:0.375540104, longitude:0.975964381 },
	'126':{ tzname:'America/Panama', tzoffset:-5, latitude:0.146977108, longitude:-1.398231732 },
	'128':{ tzname:'America/Asuncion', tzoffset:-4, coords:'23S,58W' },
	'129':{ tzname:'America/Lima', tzoffset:-5, latitude:-0.160244822, longitude:-1.309038216 },
	'130':{ tzname:'Asia/Manila', tzoffset:8, latitude:0.224572056, longitude:2.125227251 },
	'131':{ tzname:'Europe/Warsaw', tzoffset:1, latitude:0.911846378, longitude:0.366726505 },
	'132':{ tzname:'Europe/Lisbon', tzoffset:0, latitude:0.7, longitude:-0.14 },
	'133':{ tzname:'Asia/Qatar', tzoffset:3, coords:'25.5N,51.25E' },
	'134':{ tzname:'Europe/Bucharest', tzoffset:2, latitude:0.801836879, longitude:0.43595328 },
	'135':{ tzname:'Europe/Moscow', tzoffset:3, latitude:0.973122043, longitude:0.656551553 },
	'136':{ tzname:'Africa/Kigali', tzoffset:2, coords:'2S,30E' },
	'137':{ tzname:'America/St_Kitts', tzoffset:-4, coords:'17.33N,62.75W' },
	'138':{ tzname:'America/St_Lucia', tzoffset:-4, coords:'13.88N,60.97W' },
	'139':{ tzname:'America/St_Vincent', tzoffset:-6, coords:'13.25N,61.2W' },
	'142':{ tzname:'Africa/Sao_Tome', tzoffset:0, coords:'1N,7E' },
	'143':{ tzname:'Asia/Riyadh', tzoffset:3, coords:'25N,45E' },
	'144':{ tzname:'Africa/Dakar', tzoffset:0, latitude:0.253063212, longitude:-0.252122602 },
	'145':{ tzname:'Europe/Belgrade', tzoffset:1, coords:'44N,21E' },
	'146':{ tzname:'Indian/Mahe', tzoffset:4, coords:'4.583S,55.67E' },
	'147':{ tzname:'Africa/Freetown', tzoffset:0, latitude:0.147734459, longitude:-0.205877887 },
	'148':{ tzname:'Asia/Singapore', tzoffset:8, latitude:0.022887218, longitude:1.812222067 },
	'149':{ tzname:'Europe/Bratislava', tzoffset:1, latitude:0.849496742, longitude:0.343824504 },
	'150':{ tzname:'Europe/Ljubljana', tzoffset:1, latitude:0.805455557, longitude:0.261677162 },
	'152':{ tzname:'Africa/Mogadishu', tzoffset:3, coords:'10N,49E' },
	'153':{ tzname:'Africa/Johannesburg', tzoffset:2, latitude:-Math.PI * 29 / 180, longitude:Math.PI * 24 / 180 },
	'154':{ tzname:'Europe/Madrid', tzoffset:1, latitude:0.705404593, longitude:-0.064634237 },
	'156':{ tzname:'America/Paramaribo', tzoffset:-3, latitude:0.068379295, longitude:-0.977943375 },
	'158':{ tzname:'Europe/Stockholm', tzoffset:1, latitude:1.035551405, longitude:0.3152842 },
	'159':{ tzname:'Europe/Zurich', tzoffset:1, latitude:0.817042484, longitude:0.143538269 },
	'160':{ tzname:'Asia/Taipei', tzoffset:8, latitude:0.41360481, longitude:2.111159252 },
	'161':{ tzname:'Asia/Dushanbe', tzoffset:5, coords:'39N,71E' },
	'162':{ tzname:'Africa/Dar_es_Salaam', tzoffset:3, latitude:-0.111146337, longitude:0.608861513 },
	'163':{ tzname:'Asia/Bangkok', tzoffset:7, latitude:0.227571038, longitude:1.77133005 },
	'164':{ tzname:'America/Nassau', tzoffset:-5, latitude:0.420171384, longitude:-1.337016717 },
	'165':{ tzname:'Africa/Banjul', tzoffset:0, coords:'13.47N,16.57W' },
	'166':{ tzname:'Africa/Lome', tzoffset:0, latitude:0.150477, longitude:0.014480718 },
	'168':{ tzname:'America/Port_of_Spain', tzoffset:-4, coords:'10.5N,61.2W' },
	'169':{ tzname:'Africa/Tunis', tzoffset:1, latitude:0.591530132, longitude:0.166880494 },
	'170':{ tzname:'Europe/Istanbul', tzoffset:2, latitude:0.696997935, longitude:0.573288038 },
	'171':{ tzname:'Asia/Ashgabat', tzoffset:5, coords:'40N,60E' },
	'172':{ tzname:'Africa/Kampala', tzoffset:3, latitude:0.023827026, longitude:0.563822506 },
	'173':{ tzname:'Europe/Kiev', tzoffset:2, coords:'49N,32E' },
	'174':{ tzname:'Asia/Dubai', tzoffset:4, latitude:0.423904801, longitude:0.9414543 },
	'175':{ tzname:'Europe/London', tzoffset:0, latitude:0.899001068, longitude:-0.002201331 },
	'176':{ tzname:'America/New_York', tzoffset:-5, latitude:0.678847751, longitude:-1.34454348 },
	'177':{ tzname:'America/Montevideo', tzoffset:-3, latitude:-0.56836792, longitude:-0.973166392 },
	'178':{ tzname:'Asia/Tashkent', tzoffset:5, coords:'41N,64E' },
	'180':{ tzname:'America/Caracas', tzoffset:-4, latitude:0.112971532, longitude:-1.162198098 },
	'182':{ tzname:'America/St_Thomas', tzoffset:-4, latitude:0.32349641, longitude:-1.126795561 },
	'183':{ tzname:'America/St_Thomas', tzoffset:-4, latitude:0.314917262, longitude:-1.131418414 },
	'184':{ tzname:'Asia/Aden', tzoffset:3, coords:'15N,48E' },
	'185':{ tzname:'Africa/Lusaka', tzoffset:2, coords:'15S,30E' },
	'186':{ tzname:'Europe/Belgrade', tzoffset:1, coords:'42.5N,19.3E' },
	'187':{ tzname:'America/Curacao', tzoffset:-4, coords:'18.4N,60W' },
	'999':{ tzname:'Asia/Tokyo', tzoffset:9, latitude:0.622834951, longitude:2.437270113 }
};

