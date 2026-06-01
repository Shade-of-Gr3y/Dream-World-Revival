

$.fn.extend({
  isLooking: function () {
    var centerY = $(window).scrollTop() + $(window).innerHeight() / 2;
    var top = $(this).offset().top;
    return centerY >= top && centerY <= top + $(this).height();
  },
  pokemonRankingItem: function (ranking, pokedex) {
    this.addClass('ranking-entry');
    this.addClass('pokemon-ranking-item-' + ranking);
    this.addClass('pokemon-ranking-item-' + (['xl', 'l', 'l', 'l', 'l', 'm', 'm', 'm', 'm', 'm'][ranking - 1] || 's'));
    $('<div class="ranking"></div>').text(('0' + ranking).substr(-2)).appendTo(this);
    if (ranking == 1) {
      $('.pokemon-spec:first').clone().appendTo(this);
    }
    $('<div class="image"></div>').appendTo(this);
    this.pokemon({ pokedex:pokedex });
    this.hide().delay(ranking * 20).fadeIn(150);
    this.remove('.surface').append('<div class="surface"></div>');
    return this;
  },
  rankingChange: function (oldValue, newValue) {
    var value = parseInt(oldValue) - parseInt(newValue);
    if (isNaN(value)) {
      $(this).addClass('ranking-change ranking-keep').text('-');
    } else if (value >= 30) {
      $(this).addClass('ranking-change ranking-jump').text('+' + value);
    } else if (value > 0) {
      $(this).addClass('ranking-change ranking-up').text('+' + value);
    } else if (value == 0) {
      $(this).addClass('ranking-change ranking-keep').text('+0');
    } else {
      $(this).addClass('ranking-change ranking-down').text(value);
    }
    return this;
  },
  showBalloon: function (className, pokemon, other) {
    var offset = $(this).offset();
    var balloon = $('.' + className);
    if (balloon.length == 0) {
      balloon = $('<div class="balloon"></div>').addClass(className);
    }
    var balloonLeft = offset.left + ($(this).width() - balloon.width()) / 2;
    balloon.appendTo(document.body).css({
      left:Math.max(Math.min($(window).width() - 123, balloonLeft), balloonLeft - 30),
      top:offset.top - balloon.height() + 30
    }).html('<div class="name"><span class="value"></span></div><div class="types"><ol></ol></div>').pokemon({ pokemon:pokemon });
    if (other && other.ranking) {
      $('<div class="ranking"></div>').text(('0' + other.ranking).substr(-2)).appendTo(balloon);
    }
    if (other && other.rankingChange !== undefined) {
      $('<div class="ranking-change"></div>').rankingChange(other.rankingChange[0], other.rankingChange[1]).appendTo(balloon);
    }
    balloon.hide().fadeIn(200).animate({ opacity:1, top:offset.top - balloon.height() + 20 }, { duration:200, queue:false });
    return this;
  },
  showGBUUserBalloon: function (record) {
    var offset = $(this).offset();
    var balloon = $('.gbu-user-balloon').appendTo(document.body);
    balloon.css({
      left:offset.left + ($(this).width() - balloon.width()) / 2,
      top:offset.top - balloon.height() + 31
    });
    balloon.find('.trainername .value').html(PGL.Utils.renderDSFont('ds-font-6', record.player_name));
    balloon.find('.rating .value').text(record.rating);
    balloon.hide().fadeIn(200).animate({ opacity:1, top:'-=10' }, { duration:200, queue:false });
    return this;
  },
  hideBalloon: function () {
    $('.balloon').stop(true, true).hide();
    return this;
  },
  clock: function (date) {
    var radius = 20;
    var paper = this.data('paper');
    if (!paper) {
      paper = Raphael(this.get(0), radius * 2, radius * 2);
      this.data('paper', paper);
      for (var i=0; i<12; i++) {
        paper.rect(radius + 14, radius - 1.5, 4, 3).attr({ stroke:null, fill:'#FFF' }).rotate(i * 30, radius, radius);
      }
      paper.rect(radius - 2, radius - 1.5, 10, 3).attr({ stroke:null, fill:'#FFF' }).id = 'handH';
      paper.rect(radius - 2, radius - 1.2, 14, 2.4).attr({ stroke:null, fill:'#FFF' }).id = 'handM';
    }
    var hour = date.getTime() / 1000 / 60 / 60;
    paper.getById('handH').transform('t-3,0r' + (hour / 12 * 360 + 270) + 't3,0');
    paper.getById('handM').transform('t-5,0r' + (hour * 360 + 270) + 't5,0');
  }
});




(function () {
  var BLOCK_PARAMS = { message:null, fadeIn:300, fadeOut:300, overlayCSS:{ 'z-index':800, opacity:0.3 } };
  var disableAutoNavigation = false;
  
  $.extend(PGL.prototype, {
    init: function () {
      var self = this;
      
      if (!$.support.transition) {
        $.fn.transition = $.fn.animate;
      }
      
      if (this.level < PGL.TRIAL) {
        location = '/introduction/';
        return;
      }
      
      this.reportData = {};
      this.hideAll();
      
      // 文字詰め込み
      $('.squeeze').squeezeText();
      
      // 時間別表示
      $('#report').addClass('hour-' + (new Date()).getUTCHours());
      
      // GTSナビゲーションの初期化
      $(['top', 'ranking', 'pokemon', 'area']).each(function (index, name) {
        $('.gts-nav-' + name).click(function () {
          self.navigateToCurrent(true);
        });
      });
      $('.gts-nav-pokemon-select').click(function () {
        self.showPokemonSelector().then(function (pokemon) {
          location.hash = '#/gts/pokemon/' + pokemon.pokedex;
          self.navigateToCurrent(true);
        });
        return false;
      });
      $('.gts-nav-area-select').click(function () {
        self.showAreaSelector(false).then(function (area) {
          location.hash = '#/gts/area/' + area.gts;
          self.navigateToCurrent(true);
        });
        return false;
      });
      
      // GBUナビゲーションの初期化
      $(['ranking', 'trend']).each(function (index, name) {
        $('.gbu-nav-' + name).click(function () {
          setTimeout(function () {
            self.navigateToCurrent(true);
          }, 0);
        });
      });
      $('#gbu-season-ranking .gbu-season-selector select').change(function () {
        location.hash = '#/gbu/ranking/' + $(this).val();
      });
      $('#gbu-season-trend .gbu-season-selector select').change(function () {
        location.hash = '#/gbu/trend/' + $(this).val();
      });
      
      // 調査隊ナビゲーションの初期化
      $('.global-records-nav-area').click(function () {
        self.showAreaSelector(false).then(function (area) {
          location.hash = '#/global-records/' + area.pgl;
          self.navigateToCurrent(true);
        });
      });
      
      // ポケモン選択ダイアログの初期化
      (function (dialog) {
        var list;
        var idx = dialog.find('.index'), ul = dialog.find('.scroller ul'), scroller = dialog.find('.scroller');
        
        // スクロール位置に応じてポケモンをロード
        (function () {
          var iid;
          scroller.scroll(function (event) {
            clearTimeout(iid);
            iid = setTimeout(load, 200);
          });
          function load() {
            var scrollTop = scroller.offset().top - scroller.children(':first').offset().top; // pseudo scroll
            var rowIndex = Math.floor(scrollTop / 111);
            var min = rowIndex * 7, max = min + 4 * 7;
            $(list.slice(ul.find('li').length, max)).each(function (index, pokemon) {
              var pokedex = isNaN(pokemon) ? pokemon.pokedex : pokemon;
              $('<li></li>').bind('click touchstart', function () {
                dialog.trigger('select', [ pokedex ]);
              }).appendTo(ul);
            });
            $(list.slice(min, max)).each(function (index, pokemon) {
              pokemon = isNaN(pokemon) ? pokemon : PGL.Report.getPokemonByPokedex(pokemon);
              var li = ul.children().eq(min + index);
              if (li.is(':empty')) {
                li.html('<div class="pokedex"></div><div class="image"></div><div class="name"><span class="value"></span></div>').pokemon({ pokemon:pokemon, reflect:true });
              }
            });
          }
        })();
        
        dialog.find('.tabs a').bind('click touchstart', function () {
          $(this).addClass('selected').siblings().removeClass('selected');
          var source;
          var index = dialog.find('.tabs a').index(this);
          idx.empty();
          if (index == 0) {
            source = PGL.Report.sortedPokemons;
            $.each(PGL.Report.pokemonIndices, function (index, item) {
              $('<li></li>').bind('click touchstart', function () {
                scroller.scrollTop(Math.floor(item.index / 7) * 111);
              }).text(item.label).appendTo(idx);
            });
          } else if (index == 1) {
            source = PGL.Report.pokemons;
            var pokedex_max = PGL.Report.pokemons[PGL.Report.pokemons.length - 1].pokedex;
            $.each(new Array(Math.ceil(pokedex_max / 50)), function (index) {
              $('<li></li>').bind('click touchstart', function () {
                scroller.scrollTop(Math.floor(index * 50 / 7) * 111);
              }).text((index * 50 + 1) + ' - ' + Math.min(pokedex_max, index * 50 + 50)).appendTo(idx);
            });
          } else {
            source = self.loadBookmarks();
          }
          scroller.block(BLOCK_PARAMS);
          $.when(source).done(function (data) {
            scroller.find('.empty').toggle(data.length == 0);
            list = data;
            ul.empty().css({ height:Math.ceil(list.length / 7) * 111 });
            scroller.scrollTop(0).trigger('scroll');
            scroller.unblock();
          });
        });
      })($('#dialog-pokemon-selector'));
      
      // 地域選択ダイアログの初期化
      (function (dialog) {
        var ul = dialog.find('ul'), scroller = dialog.find('.scroller');
        $('<li class="show-all"></li>').hover(function () {
            $(this).addClass('active');
          }, function () {
            $(this).removeClass('active');
          }).text(PGL.Text.get('report.area.showall')).data({ id:null }).appendTo(ul);
        var areas = PGL.Report.areasWithPGL;
        $(areas).each(function (index, area) {
          area.sortKey = (area.names[PGL.language] || '').replace(/[ぁ-ん]/g, function (m) {
            return String.fromCharCode(m.charCodeAt() + 0x60);
          });
        });
        areas.sort(function (a, b) {
          return a.sortKey < b.sortKey ? -1 : 1;
        });
        $(areas).each(function (index, area) {
          var marker = $('<div class="marker"></div>').css({
            left:188 + area.coords[1] * 61,
            top:121 - area.coords[0] * 66
          }).hover(function () {
            li.addClass('active');
            marker.addClass('active');
            var lo = li.offset(), so = scroller.offset();
            lo.bottom = lo.top + li.height();
            so.bottom = so.top + scroller.height();
            if (lo.top < so.top || lo.bottom > so.bottom) {
              scroller.scrollTop(scroller.scrollTop() + lo.top - so.top);
            }
          }, function () {
            li.removeClass('active');
            marker.removeClass('active');
          }).data({ area:area }).appendTo(dialog.find('.map'));
          var li = $('<li></li>').hover(function () {
            li.addClass('active');
            marker.addClass('active');
          }, function () {
            li.removeClass('active');
            marker.removeClass('active');
          }).text((area.names[PGL.language] || '') + ' (' + area.iso3166 + ')').data({ area:area }).appendTo(ul);
          if (area.has_detail) {
            marker.addClass('has-detail');
            li.addClass('has-detail');
          }
        });
      })($('#dialog-area-selector'));
      
      
      // 画面マウスダウンで調査隊ドロップダウン閉じる
      $(window).mousedown(function () {
        if ($('#global-records-control .dropdown').is(':visible')) {
          $('#global-records-control .label').show();
          $('#global-records-control .dropdown').slideUp(100);
        }
      });
      
      // サウンド再生
      $('<div id="sound"></div>').appendTo(document.body);
      swfobject.embedSWF('/report/assets/swf/sound.swf', 'sound', '1', '1', '10.0.0');
      
      // 必須APIの呼び出し
      var seasons_list_call = this.getApiWithCache('gbu.journal.season_list');
      $.when(seasons_list_call).done(function (seasons_list) {
        self.seasons = seasons_list;
        self.season_table = {};
        $.each(seasons_list, function (index, season) {
          self.season_table[season.season_id] = season;
        });
        
        $('.gbu-season-selector select').empty();
        $.each(seasons_list, function (index, season) {
          var label = season.season_name + '　'
            + PGL.Utils.formatTime(season.start_datetime, { format:'SHORT', tzoffset:9, appendTZ:true }) + ' - '
            + PGL.Utils.formatTime(season.end_datetime, { format:'SHORT', tzoffset:9, appendTZ:true });
          $('<option></option>').attr({ value:season.season_id }).text(label).appendTo('.gbu-season-selector select');
        });
        
        self.init2();
      });
    },
    /* 初期化2  必須APIを呼び出し、ナビゲーション解決ができるようになった後 */
    init2: function () {
      var self = this;
      
      // ハッシュの変化に対応
      $(window).hashchange(function () {
        self.reload();
      });
      self.reload();
      self.navigateToCurrent(false);
      
      if (navigator.userAgent.indexOf('Android') != -1) {
        $('body').addClass('android');
      }
      
      // スクロール位置に応じてハッシュを変更
      $(window).scroll(function (event) {
        // DEBUG:
        if (navigator.userAgent.indexOf('SonyEricssonSO-01B') != -1) {
          if (!window.so01b) {
            window.so01b = true;
            var ary = [];
            ary.push('scrollTop=' + $(window).scrollTop());
            ary.push('innerHeight=' + window.innerHeight);
            ary.push('innerHeight=' + $(window).innerHeight());
            alert(ary.join(', '));
            prompt('', ary.join(', '));
          }
        }
        
        if (!disableAutoNavigation) {
          var states = self.unpackStates(location.hash);
          var centerY = $(window).scrollTop() + $(window).innerHeight() / 2;
          if (states.type == 'gts') {
            if ($('#gts-top').isLooking()) {
              if (states.subtype != '') {
                location.hash = '#/gts/';
              }
            } else if ($('#gts-ranking').isLooking()) {
              if (states.subtype != 'ranking') {
                location.hash = '#/gts/ranking/';
              }
            } else if ($('#gts-pokemon').isLooking()) {
              if (states.subtype != 'pokemon') {
                location.hash = '#/gts/pokemon/';
              }
            } else if ($('#gts-area').isLooking()) {
              if (states.subtype != 'area') {
                location.hash = '#/gts/area/';
              }
            }
          } else if (states.type == 'gbu') {
            if ($('#gbu-top').isLooking()) {
              if (states.subtype != '') {
                location.hash = '#/gbu/';
              }
            } else if ($('#gbu-season-ranking').isLooking()) {
              if (states.subtype != 'ranking') {
                location.hash = '#/gbu/ranking/';
              }
            } else if ($('#gbu-season-trend').isLooking()) {
              if (states.subtype != 'trend') {
                location.hash = '#/gbu/trend/';
              }
            }
          } else if (states.type == 'wifi-competitions') {
            if ($('#wifi-comp-list').isLooking()) {
              if (states.id != null) {
                location.hash = '#/wifi-competitions/';
              }
            } else if ($('#wifi-comp-detail').isLooking()) {
              if (self.last_wifi_comp && states.id != self.last_wifi_comp) {
                location.hash = '#/wifi-competitions/' + self.last_wifi_comp;
              }
            }
          }
        }
      });
    },
    reload:function (recur) {
      var states = this.unpackStates(location.hash);
      var canonHash = this.packStates(states);
      if (location.hash != canonHash) {
        location.replace(canonHash);
        if (!recur) {
          this.reload(true); // for IE9 hashchange issue
        }
      } else {
        this.hideAll();
        $('#report-header a').removeClass('selected').filter('#report-header-' + states.type).addClass('selected');
        ({
          gts:this.showGTS,
          gbu:this.showGBU,
          'wifi-competitions':this.showWiFiCompetitions,
          'global-records':this.showGlobalRecords
        }[states.type]).call(this, states);
      }
    },
    navigateToCurrent:function (animate, always) {
      var self = this;
      setTimeout(function () {
        var states = self.unpackStates(location.hash);
        if (states.type == 'gts') {
          var target = $('#gts-' + (states.subtype || 'top'));
        } else if (states.type == 'gbu') {
          var target = $('#gbu-' + (states.subtype ? 'season-' + states.subtype : 'top'));
        } else if (states.type == 'wifi-competitions') {
          var target = $(states.id ? '#wifi-comp-detail' : '#wifi-comp-list');
        } else if (states.type == 'global-records') {
          var target = $('#global-records');
          always = true;
        } else {
          return;
        }
        if (always || !target.isLooking()) {
          var top = target.offset().top - 50;
          if (animate) {
            disableAutoNavigation = true;
            $($.browser.safari ? 'body' : 'html').stop().animate({ scrollTop:top }, 250, 'swing', function () {
              disableAutoNavigation = false;
            });
          } else {
            $(window).scrollTop(top);
          }
        }
      }, 100);
    },
    packStates:function (states) {
      if (states.type == 'gts') {
        if (states.subtype == 'ranking') {
          return ['#', states.type, states.subtype, states.subsubtype].join('/');
        } else if (states.subtype == 'pokemon') {
          return ['#', states.type, states.subtype, states.id].join('/');
        } else if (states.subtype == 'area') {
          return ['#', states.type, states.subtype, states.id].join('/');
        } else {
          return ['#', states.type, states.subtype].join('/');
        }
      } else if (states.type == 'gbu') {
        if (states.subtype == '') {
          return ['#', states.type, states.subtype].join('/');
        } else {
          return ['#', states.type, states.subtype, states.season].join('/');
        }
      } else if (states.type == 'wifi-competitions') {
        if (states.id !== null) {
          return ['#', states.type, states.id].join('/');
        } else {
          return ['#', states.type].join('/');
        }
      } else if (states.type == 'global-records') {
        if (states.id !== null) {
          return ['#', states.type, states.id].join('/');
        } else {
          return ['#', states.type].join('/');
        }
      } else {
        return ['#', states.type].join('/');
      }
    },
    unpackStates:function (code) {
      var states = {}, path = ('' + code).split('/');
      states.type = validate(path[1], ['gts', 'gbu', 'wifi-competitions', 'global-records']);
      if (states.type == 'gts') {
        states.subtype = validate(path[2], ['', 'ranking', 'pokemon', 'area']);
        if (states.subtype == 'ranking') {
          states.subsubtype = validate(path[3] || this.last_trade_type, ['traded', 'wanted', 'deposited']);
          this.last_trade_type = states.subsubtype;
        } else if (states.subtype == 'pokemon') {
          states.id = parseInt(path[3]);
          if (!PGL.Report.getPokemonByPokedex(states.id)) {
            states.id = this.last_pokemon_id || PGL.Report.pokemons[Math.floor(Math.random() * PGL.Report.pokemons.length)].pokedex;
          }
          this.last_pokemon_id = states.id;
        } else if (states.subtype == 'area') {
          states.id = parseInt(path[3]);
          var area = PGL.Report.areasByGTS[states.id];
          if (!area || !area.has_detail) {
            states.id = this.last_area_id || PGL.Report.areasWithDetail[Math.floor(Math.random() * PGL.Report.areasWithDetail.length)].gts;
          }
          this.last_area_id = states.id;
        }
      } else if (states.type == 'gbu') {
        states.subtype = validate(path[2], ['', 'ranking', 'trend']);
        var ids = $.map(this.seasons, function (season) { return parseInt(season.season_id); });
        if (states.subtype == 'ranking') {
          states.season = validate(parseInt(path[3]), ids, this.last_ranking_season);
          this.last_ranking_season = states.season;
        } else if (states.subtype == 'trend') {
          states.season = validate(parseInt(path[3]), ids, this.last_trend_season);
          this.last_trend_season = states.season;
        }
      } else if (states.type == 'wifi-competitions') {
        states.id = parseInt(path[2]);
        if (isNaN(states.id)) {
          states.id = null;
        }
        if (states.id) {
          this.last_wifi_comp = states.id;
        }
      } else if (states.type == 'global-records') {
        states.id = parseInt(path[2]);
        var area = PGL.Report.areasByPGL[states.id];
        if (!area || !area.has_detail) {
          states.id = null;
        }
      }
      return states;
      
      function validate(value, choices, def) {
        def = arguments.length > 2 ? validate(def, choices) : choices[0];
        if (choices.indexOf) {
          return choices.indexOf(value) == -1 ? def : value;
        }
        // IE7
        for (var i=0; i<choices.length; i++) {
          if (choices[i] == value) {
            return value;
          }
        }
        return def;
      }
    },
    hideAll:function () {
      $('#gts-top .scroll-map').stopAll();
      $('#gbu-top .scroll-map').stopAll();
      $('#gbu-top .gbu-battle-record').stopAll();
      $('#gbu-season-trend').unblock();
      $('#gbu-season-ranking').unblock();
      clearInterval(this.gts_top_iid);
      clearInterval(this.gts_top_iid2);
      clearInterval(this.gts_top_iid3);
      clearInterval(this.gbu_iid);
      clearInterval(this.global_records_iid);
      $('#report-contents>div').hide();
    },
    showGTS:function (states) {
      setMusic('gts');
      var self = this;
      
      $('#gts').show();
      ({
        '':this.showGTSTop,
        ranking:this.showGTSRanking,
        pokemon:this.showGTSPokemon,
        area:this.showGTSArea
      }[states.subtype]).call(this, states);
      
      $('#gts .nav-back').unbind('click').click(function () {
        location.hash = '#/gts/';
        self.navigateToCurrent(true);
      });
    },
    showGTSTop:function (states) {
      var self = this;
      $('#gts-top').show();
      $('#gts-top-trade').block(BLOCK_PARAMS);
      $('#gts-top-stats').block(BLOCK_PARAMS);
      
      if (!self.reportData.gtsTop) {
        self.reportData.gtsTop = {};
        self.reportData.gtsTop.paper = Raphael($('#gts-top .map').get(0), 1600 + 1003, 800);
        PGL.Report.extendRaphael(self.reportData.gtsTop.paper);
      }
      var paper = self.reportData.gtsTop.paper;
      
      this.getApiWithCache('gts.journal.trade_list').then(function (data) {
        // どちらかのcountry_idが0のレコードと、一致しているレコードを除去
        data.trade_list = $.grep(data.trade_list, function (trade) {
          var p1 = PGL.Report.getPokemonByPokedex(trade.trade1.monsno), p2 = PGL.Report.getPokemonByPokedex(trade.trade2.monsno);
          return p1 && p2 && trade.trade1.country_id != '0' && trade.trade2.country_id != '0' && trade.trade1.country_id != trade.trade2.country_id;
        });
        
        $('#gts-top-trade').unblock();
        
        // アニメーションの初期化
        paper.clear();
        $('#gts-top .scroll-map .area').remove();
        var dummyPathObj1 = paper.path('').attr({ stroke: '#FFFFFF', 'stroke-width':2, 'stroke-dasharray':['-'] });
        var dummyPathObj2 = paper.path('').attr({ stroke: '#FFFFFF', 'stroke-width':2, 'stroke-dasharray':['-'] });
        var pathObj1 = paper.path('').attr({ stroke: '#78E82C', 'stroke-width':4, 'stroke-dasharray':['-'] });
        var pathObj2 = paper.path('').attr({ stroke: '#78E82C', 'stroke-width':4, 'stroke-dasharray':['-'] });
        var ball1 = paper.image('assets/images/gts-trade-ball.png', 0, 0, 24, 24).attr({ opacity:0 });
        var ball2 = paper.image('assets/images/gts-trade-ball.png', 0, 0, 24, 24).attr({ opacity:0 });
        //var symbol = paper.image('assets/images/gts-top-trade-symbol.png', 0, 0, 48, 46);
        var area1 = $('<div class="area"></div>').appendTo('#gts-top .scroll-map');
        var area2 = $('<div class="area"></div>').appendTo('#gts-top .scroll-map');
        
        var tradeIndex = Math.floor(Math.random() * data.trade_list.length);
        updateGtsTopTrade();
        
        showDummyTrade(dummyPathObj1, 'gts_top_iid2');
        showDummyTrade(dummyPathObj2, 'gts_top_iid3');
        
        function showDummyTrade(dummyPathObj, iid) {
          var trade = data.trade_list[Math.floor(Math.random() * data.trade_list.length)];
          
          // 出す順番をランダムに決定
          var deposits = Math.random() < 0.5 ? [ trade.trade1, trade.trade2 ] : [ trade.trade2, trade.trade1 ];
          var pos1 = self.getScrollMapCoords(PGL.Report.areasByGTS[deposits[0].country_id]); // 先
          var pos2 = self.getScrollMapCoords(PGL.Report.areasByGTS[deposits[1].country_id]); // 後
          
          var path = [['M', pos1.x, pos1.y], ['Q', (pos1.x + pos2.x) / 2, (pos1.y + pos2.y) / 2 - 100, pos2.x, pos2.y]];
          var mainDuration = Math.abs(pos1.x - pos2.x) * 2.0 + 600;
          
          dummyPathObj.stop()
            .attr({ gtsTradeLine:[pos1.x, pos1.y, pos2.x, pos2.y, 0.2, 0.25, 0] })
            .animate({ gtsTradeLine:[pos1.x, pos1.y, pos2.x, pos2.y, 0.2, 0.25, 2] }, mainDuration, 'linear', function () {
              self[iid] = setTimeout(function () {
                showDummyTrade(dummyPathObj, iid);
              }, 300);
            });
        }
        
        
        function updateGtsTopTrade() {
          clearTimeout(self.gts_top_iid);
          
          var trade = data.trade_list[tradeIndex];
          tradeIndex = (tradeIndex + 1) % data.trade_list.length;
          
          // 出す順番をランダムに決定
          var deposits = Math.random() < 0.5 ? [ trade.trade1, trade.trade2 ] : [ trade.trade2, trade.trade1 ];
          var pos1 = self.getScrollMapCoords(PGL.Report.areasByGTS[deposits[0].country_id]); // 先
          var pos2 = self.getScrollMapCoords(PGL.Report.areasByGTS[deposits[1].country_id]); // 後
          
          if (pos1.x < pos2.x) {
            // 左から右
            var elem1 = $('#gts-top-trade-deposit-1'), elem2 = $('#gts-top-trade-deposit-2');
          } else {
            // 右から左
            var elem1 = $('#gts-top-trade-deposit-2'), elem2 = $('#gts-top-trade-deposit-1');
          }
          
          
          $('.gts-top-trade-deposit').show();
          updateGtsTopTradeDeposit(elem1, deposits[0]);
          updateGtsTopTradeDeposit(elem2, deposits[1]);
          $('.gts-top-trade-deposit').fixPng().hide();
          
          var xd = Math.abs(pos1.x - pos2.x);
          var path1 = [['M', pos1.x, pos1.y], ['Q', (pos1.x + pos2.x) / 2, (pos1.y + pos2.y) / 2 - xd * 0.15, pos2.x, pos2.y]];
          var path2 = [['M', pos2.x, pos2.y], ['Q', (pos1.x + pos2.x) / 2, (pos1.y + pos2.y) / 2 - xd * 0.21, pos1.x, pos1.y]];
          var mainDuration = Math.abs(pos1.x - pos2.x) * 0.5 + 1300;
          
          
          pathObj1.attr({ path:'' });
          pathObj2.attr({ path:'' });
          ball1.attr({ x:pos1.x - 12, y:pos1.y - 12, opacity:0 });
          ball2.attr({ x:pos2.x - 12, y:pos2.y - 12, opacity:0 });
          area1.show().css({ left:pos1.x-100, top:pos1.y+10 }).text(deposits[0].country_name);
          area2.show().css({ left:pos2.x-100, top:pos2.y+10 }).text(deposits[1].country_name);
          
          // ぶつからないよう調整
          (function (a1, a2) {
            var p1 = p(a1, 10), p2 = p(a2, 10);
            if (p1.t < p2.b && p1.b > p2.t && p1.l < p2.r && p1.r > p2.l) {
              var diff = pos1.x < pos2.x ? (p2.l - p1.r) / 2 : (p2.r - p1.l) / 2;
              a1.css({ left:pos1.x - 100 + diff });
              a2.css({ left:pos2.x - 100 - diff });
            }
            function p(target, pad) {
              var span = target.wrapInner('<span></span>').children('span'), t = span.offset();
              return { l:t.left - pad, t:t.top - pad, r:t.left + span.width() + pad, b:t.top + span.height() + pad };
            }
          })(area1, area2);
          
          area1.hide();
          area2.hide();
          
          
          //symbol.attr({ opacity:0 });
          
          // GTS交換アニメーション
          $('#gts-top .scroll-map').show();
          $('#gts-top .scroll-map')
            .stopAll()
            .transition({ left:-pos1.x + 1003 / 2 }, 700) // 第一の場所へ
            .queue(function () {
              ball1.animate({ opacity:1 }, 400, 'backOut');
              ball2.animate({ opacity:1 }, 400, 'backOut');
              elem1.show().css({ opacity:0 }).transition({ opacity:1 }, 400);
              area1.show().css({ opacity:0 }).transition({ opacity:1 }, 400);
              area2.show().css({ opacity:0 }).transition({ opacity:1 }, 400);
              $(this).dequeue();
            })
            .delay(500)
            .queue(function () {
              elem2.show().css({ opacity:0 }).delay(400).transition({ opacity:1 }, 400);
              var pathAnim1 = Raphael.animation({ gtsTradeLine:[ pos1.x, pos1.y, pos2.x, pos2.y, 0.15, 1, 2 ] }, mainDuration * 2, 'linear');
              var pathAnim2 = Raphael.animation({ gtsTradeLine:[ pos2.x, pos2.y, pos1.x, pos1.y, 0.21, 1, 2 ] }, mainDuration * 2, 'linear');
              var ballAnim1 = Raphael.animation({ gtsTradePoint:[ pos1.x - 12, pos1.y - 12, pos2.x - 12, pos2.y - 12, 0.15, 1 ] }, mainDuration, 'linear');
              var ballAnim2 = Raphael.animation({ gtsTradePoint:[ pos2.x - 12, pos2.y - 12, pos1.x - 12, pos1.y - 12, 0.21, 1 ] }, mainDuration, 'linear');
              pathObj1
                .attr({ gtsTradeLine:[ pos1.x, pos1.y, pos2.x, pos2.y, 0.15, 1, 0 ] })
                .animate(pathAnim1);
              pathObj2
                .attr({ gtsTradeLine:[ pos2.x, pos2.y, pos1.x, pos1.y, 0.21, 1, 0 ] })
                .animate(pathAnim2);
              ball1
                .attr({ gtsTradePoint:[ pos1.x - 12, pos1.y - 12, pos2.x - 12, pos2.y - 12, 0.15, 0 ] })
                .animateWith(pathObj1, pathAnim1, ballAnim1);
              ball2
                .attr({ gtsTradePoint:[ pos2.x - 12, pos2.y - 12, pos1.x - 12, pos1.y - 12, 0.21, 0 ] })
                .animateWith(pathObj2, pathAnim2, ballAnim2);
              $(this).dequeue();
            })
            .transition({ left:-pos2.x + 1003 / 2 }, mainDuration) // 第二の場所へ
            .delay(mainDuration + 1000)
            .queue(function () {
              area1.transition({ opacity:0 }, 500);
              area2.transition({ opacity:0 }, 500);
              ball1.animate({ opacity:0 }, 500);
              ball2.animate({ opacity:0 }, 500);
              $('.gts-top-trade-deposit').fadeOut(500);
              self.gts_top_iid = setTimeout(updateGtsTopTrade, 1200);
              $(this).dequeue();
            });
        }
        function updateGtsTopTradeDeposit(target, deposit) {
          var pokemon = PGL.Report.getPokemonByPokedex(deposit.monsno);
          target.children('.pokemon').pokemon({ pokemon:pokemon, form:deposit.form_no, reflect:true, level:deposit.poke_level, sex:deposit.sex });
          target.find('.pokemon .name').text(deposit.pokename).squeezeText();
          target.find('.pokemon .moves').empty();
          $.each(Array(4), function (index) {
            var li = $('<li></li>').appendTo(target.find('.pokemon .moves'));
            $('<span class="type"></span>').addClass('type-' + (deposit['waza_type' + (index + 1)] || 0)).appendTo(li);
            $('<span class="move"></span>').text(deposit['waza' + (index + 1)] || PGL.Text.get('report.gts.trade.item.empty')).appendTo(li);
          });
          target.find('.pokemon .nature .value').text(deposit.seikaku);
          target.find('.pokemon .nickname .value').html(PGL.Utils.renderDSFont('ds-font-6', deposit.nickname)).squeezeText();
          target.find('.pokemon .item .value').text(deposit.pokeitem || PGL.Text.get('report.gts.trade.item.empty'));
          target.find('.user .name .value').html(PGL.Utils.renderDSFont('ds-font-6', deposit.player_name));
          target.find('.user .area .value:eq(0)').text(deposit.country_name).squeezeText();
          target.find('.user .area .value:eq(1)').text(deposit.area_name || '').squeezeText();
          target.find('.deposited-at .value').text(PGL.Utils.formatTime(deposit.trade_date || deposit.post_date, { format:'LONG', appendTZ:true }));
        }
      });
      this.getApiWithCache('gts.journal.get_trade_data').then(function (data) {
        $('#gts-top .updated-at .value').text(PGL.Utils.formatTime(data.updated_at, { tzoffset:9, appendTZ:true }));
        t($('#gts-top-stats-travel'), PGL.Utils.formatNumber(Math.round(data.distance * (PGL.language == 'en' ? 0.621371192 : 1))));
        t($('#gts-top-stats-travel-earth'), PGL.Utils.formatNumber(Math.round(data.earth_lap * 100) / 100));
        t($('#gts-top-stats-deposited'), PGL.Utils.formatNumber(data.gts_current_count));
        t($('#gts-top-stats-traded'), PGL.Utils.formatNumber(data.traded_all_count));
        var dateFrom = PGL.Text.get('report.gts.count_started_at')
          .replace(/YYYY/, data.reporting_from.utc.yyyy)
          .replace(/MM/, data.reporting_from.utc.mm)
          .replace(/DD/, data.reporting_from.utc.dd);
        $('#gts-top-stats .date-from').text(dateFrom);
        $('#gts-top-stats').unblock();
        function t(target, value) {
          var w = 295;
          target.children('.unit').each(function () { w -= $(this).width(); });
          target.children('.value').squeezeText(value, w).rotateText();
        }
      });
    },
    /* GTSランキング */
    showGTSRanking:function (states) {
      var self = this;
      if ($('#gts-ranking').data('subsubtype') == states.subsubtype) {
        return;
      }
      $('#gts-ranking').data('subsubtype', states.subsubtype);
      
      var typecode = { traded:1, wanted:2, deposited:3 }[states.subsubtype];
      $('#gts-ranking-selector a').removeClass('selected');
      $('#gts-ranking-selector-' + states.subsubtype).addClass('selected');
      $('#gts-ranking ol').block(BLOCK_PARAMS);
      this.getApiWithCache('gts.journal.trade_ranking', { type:typecode, rowcount:30, offset:0 }).then(function (data) {
        $('#gts-ranking ol').unblock().empty();
        $.each(data, function (index, record) {
          var li = $('<li></li>').click(function () {
            location.hash = '#/gts/pokemon/' + record.monsno;
            self.navigateToCurrent(true);
          }).hover(function () {
            $(this).showBalloon('gts-ranking-balloon', PGL.Report.getPokemonByPokedex(record.monsno), {
              ranking:parseInt(record.rank), rankingChange:[record.old_rank, record.rank]
            });
          }, function () {
            $(this).hideBalloon();
          }).appendTo('#gts-ranking>ol');
          $('<div class="ranking-change"></div>').rankingChange(record.old_rank, record.rank).appendTo(li);
          li.pokemonRankingItem(index + 1, record.monsno);
        });
      });
    },
    /** ポケモン情報 */
    showGTSPokemon:function (states) {
      var self = this;
      if ($('#gts-pokemon').data('id') == states.id) {
        return;
      }
      $('#gts-pokemon').data('id', states.id);
      
      // 左側預けリスト
      $('#gts-pokemon-deposited-list').children('.deposits,.pager,.map').empty();
      
      $('#gts-pokemon').show().block(BLOCK_PARAMS);
      this.getApiWithCache('gts.journal.poke_detail_data', { pokename_id:states.id }).then(function (data) {
        var pokedex = parseInt(data.monsno);
        var pokemon = PGL.Report.getPokemonByPokedex(pokedex);
        $('#gts-pokemon').unblock();
        $('#gts-pokemon-pokemon').show().pokemon({ pokemon:pokemon, reflect:true });
        $('#gts-pokemon-pokemon .pokedex-nav').show();
        
        var prev = pokemon.prev || {}, next = pokemon.next || {};
        $('#gts-pokemon-pokemon .pokedex-nav .prev').text(PGL.Utils.zerofill(prev.pokedex, 3)).attr({ href:'#/gts/pokemon/' + (pokemon.prev || {}).pokedex }).toggle(!!pokemon.prev);
        $('#gts-pokemon-pokemon .pokedex-nav .next').text(PGL.Utils.zerofill(next.pokedex, 3)).attr({ href:'#/gts/pokemon/' + (pokemon.next || {}).pokedex }).toggle(!!pokemon.next);
        $('#gts-pokemon-pokemon .pokedex-nav .current').text(PGL.Utils.zerofill(data.monsno, 3));
        
        $('#gts-pokemon-deposited-count').show();
        $('#gts-pokemon-deposited-count .label .name').text(pokemon[PGL.language]);
        $('#gts-pokemon-deposited-count .label').squeezeText();
        $('#gts-pokemon-deposited-count .value').text(PGL.Utils.formatNumber(data.gts_keep_count));
        
        $('#gts-pokemon-deposited-list').show();
        setTimeout(function () {
          self.updateDepositeList($('#gts-pokemon-deposited-list'), data.gts_keep_list, data.monsno);
        }, 600);
        
        
        $('#gts-pokemon-ranking').show();
        $('#gts-pokemon-ranking-traded').hide();
        $('#gts-pokemon-ranking-wanted').hide();
        updateRanking($('#gts-pokemon-ranking-traded ol'), data.traded_ranking_data);
        updateRanking($('#gts-pokemon-ranking-wanted ol'), data.want_ranking_data);
        $('.gts-pokemon-ranking-switch').unbind('click').click(function () {
          if ($('#gts-pokemon-ranking-traded').is(':visible')) {
            var a = $('#gts-pokemon-ranking-traded'), b = $('#gts-pokemon-ranking-wanted');
          } else {
            var a = $('#gts-pokemon-ranking-wanted'), b = $('#gts-pokemon-ranking-traded');
          }
          b.find('.pokemon-ranking').hide();
          var dur = 170;
          $(this).hide().css({ top:75-5 }).fadeIn(dur * 2).animate({ top:75 }, { duration:dur * 2, queue:false });
          a.fadeOut(dur);
          b.delay(dur).fadeIn(dur);
          b.find('.pokemon-ranking').delay(dur * 2).slideDown(dur);
        }).click();
        
        // ブックマーク表示状態
        updateBookmarkUI();
        
        // アニメーション
        $('#gts-pokemon-deposited-count').hide().delay(200).slideDown(100);
        $('#gts-pokemon-deposited-list .leadline').hide().animate({ width:'show' }, 300, 'easeInQuint');
        $('#gts-pokemon-deposited-list .map').hide().delay(300).slideDown(300);
        $('#gts-pokemon-ranking h3').hide().delay(200).slideDown(100);
        $('#gts-pokemon-ranking .leadline').hide().animate({ width:'show' }, 300, 'easeInQuint');
        
        function updateRanking(target, ranking) {
          target.empty();
          $.each(ranking, function (index, pokemon) {
            var li = $('<li class="ranking-entry"><div class="image"></div><div class="name"><span class="value"></span></div><div class="types"><ol></ol></div></li>').click(function () {
              location.hash = '#/gts/pokemon/' + pokemon.monsno;
              self.navigateToCurrent(true);
            }).appendTo(target).pokemon({ pokedex:pokemon.monsno });
            $('<div class="ranking"></div>').text(index + 1).appendTo(li);
            $('<div class="ratio"></div>').css({ width:pokemon.ratio / ranking[0].ratio * 193 }).appendTo(li);
          });
        }
        
        function updateBookmarkUI() {
          $('#gts-pokemon-bookmark').show();
          $('#gts-pokemon-bookmark-add,#gts-pokemon-bookmark-remove').hide();
          self.loadBookmarks().then(function (bookmarks) {
            if ($.inArray(states.id, bookmarks) != -1) {
              $('#gts-pokemon-bookmark-remove').show().unbind('click').click(function () {
                $(this).unbind('click');
                self.getApi('gts.journal.delete_bookmark', { pokename_id:states.id }, function () {
                  bookmarks.splice($.inArray(states.id, bookmarks), 1);
                  updateBookmarkUI();
                });
              });
            } else {
              $('#gts-pokemon-bookmark-add').show().unbind('click').click(function () {
                $(this).unbind('click');
                self.getApi('gts.journal.add_bookmark', { pokename_id:states.id }, function () {
                  bookmarks.push(states.id);
                  bookmarks.sort(function (a, b) { return (a - b); });
                  updateBookmarkUI();
                });
              });
            }
          });
        }
      });
    },
    // 地域情報
    showGTSArea:function (states) {
      var self = this;
      if ($('#gts-area').data('id') == states.id) {
        return;
      }
      $('#gts-area').data('id', states.id);
      
      $('#gts-area').show().block(BLOCK_PARAMS);
      this.updateLocalInfo($('#gts-area .local-info').show(), PGL.Report.areasByGTS[states.id], false).then(function () {
        $('#gts-area').unblock();
      });
    },
    // GBU
    showGBU:function (states) {
      setMusic('gbu');
      var self = this;
      
      $('#gbu').show();
      ({
        '':this.showGBUTop,
        ranking:this.showGBURanking,
        trend:this.showGBUTrend
      }[states.subtype]).call(this, states);
      
      $('#gbu .nav-back').unblock('click').click(function () {
        location.hash = '#/gbu/';
        self.navigateToCurrent(true);
      });
    },
    /** GBUトップ */
    showGBUTop:function (states) {
      var self = this;
      if (!self.reportData.gbuTop) {
        self.reportData.gbuTop = {};
        self.reportData.gbuTop.paper = Raphael($('#gbu-top .map').get(0), 1600 + 1003, 707);
        PGL.Report.extendRaphael(self.reportData.gbuTop.paper);
      }
      var paper = self.reportData.gbuTop.paper;
      
      $('#gbu-top').block(BLOCK_PARAMS);
      var url = '/swf/json/' + (PGL.language == 'ja' ? 'battledata.json' : 'battledata_' + PGL.language + '.json');
      this.getJsonWithCache(url).then(function (data) {
        // uniform API responce format
        if (data.battle_history_list === undefined) {
          data = { battle_history_list:data };
        }
        // どちらかのcountry_idが0のレコードと、一致しているレコードを除去
        data.battle_history_list = $.grep(data.battle_history_list || [], function (trade) {
          return trade.player1.country_id != '0' && trade.player2.country_id != '0' && trade.player1.country_id != trade.player2.country_id;
        });
        
        $('#gbu-top').unblock();
        if (data.battle_history_list.length) {
          var battleIndex = Math.floor(Math.random() * data.battle_history_list.length);
          updateGbuTopBattle();
        }
        
        function updateGbuTopBattle() {
          clearTimeout(self.gbu_iid);
          paper.clear();
          var battle = data.battle_history_list[battleIndex];
          battleIndex = (battleIndex + 1) % data.battle_history_list.length;
          
          // 勝敗
          battle.player1.result = ['lose', 'win', 'draw'][battle.result % 3];
          battle.player2.result = ['win', 'lose', 'draw'][battle.result % 3];
          
          // 出す順番をランダムに決定
          var players = Math.random() < 0.5 ? [ battle.player1, battle.player2 ] : [ battle.player2, battle.player1 ];
          var pos1 = self.getScrollMapCoords(PGL.Report.areasByPGL[players[0].country_id]); // 先
          var pos2 = self.getScrollMapCoords(PGL.Report.areasByPGL[players[1].country_id]); // 後
          
          if (pos1.x < pos2.x) {
            // 左から右
            var elem1 = $('#gbu-battle-record-1'), effect1 = $('#gbu-battle-result-effect-1');
            var elem2 = $('#gbu-battle-record-2'), effect2 = $('#gbu-battle-result-effect-2');
          } else {
            // 右から左
            var elem1 = $('#gbu-battle-record-2'), effect1 = $('#gbu-battle-result-effect-2');
            var elem2 = $('#gbu-battle-record-1'), effect2 = $('#gbu-battle-result-effect-1');
          }
          
          $('.gbu-battle-record').show();
          updateUser(elem1, effect1, players[0]);
          updateUser(elem2, effect2, players[1]);
          $('.gbu-battle-record').fixPng().hide();
          $('.gbu-battle-record .battle-result').stopAll().hide();
          $('.gbu-battle-result-effect .value').hide();
          
          $('#gbu-battle-summary').removeClass('east-is-north east-is-south').addClass((pos1.x > pos2.x == pos1.y > pos2.y) ? 'east-is-south' : 'east-is-north');
          $('#gbu-battle-summary .date').text(PGL.Utils.formatTime(battle.battleDateTime, { format:'SHORT', tzoffset:9, appendTZ:true }));
          $('#gbu-battle-summary .areas').text($('#gbu-battle-record-1 .country').text() + '<>' + $('#gbu-battle-record-2 .country').text());
          $('#gbu-battle-summary').css({ left:(pos1.x + pos2.x) / 2 - 41, top:(pos1.y + pos2.y) / 2 - 41 }).hide();
          if (battle.shooter_flag == '1') {
            $('#gbu-battle-summary .regulation').text(PGL.Text.get('global.gbu.shooter_battle'));
          } else {
            var t = ['single', 'double', 'triple', 'rotation'][battle.regulation];
            $('#gbu-battle-summary .regulation').text(PGL.Text.get('global.gbu.' + t + '_battle'));
          }
           
          var pathObj = paper.path('').attr({ stroke: '#FF7313', 'stroke-width':4, 'stroke-dasharray':['-'] });
          var mainDuration = Math.abs(pos1.x - pos2.x) * 0.66 + 600;
          
          var mapCenter = -(pos1.x + pos2.x) / 2 + 1003 / 2;
          var r = function (n) {
            return (Math.random() - 0.5) * n;
          };
          
          // GBUバトルアニメーション
          $('#gbu-top .scroll-map>*').show();
          $('#gbu-top .scroll-map')
            .stopAll()
            .hide()
            .css({ left:mapCenter }) // 中央へ
            .fadeIn(900)
            .queue(function () {
              paper.circle(pos1.x, pos1.y).attr({ fill:'#FF7313', stroke:'none' }).animate({ r:10 }, 400, 'backOut');
              paper.circle(pos2.x, pos2.y).attr({ fill:'#FF7313', stroke:'none' }).animate({ r:10 }, 400, 'backOut');
              pathObj.attr({ gbuBattleLine:[ pos1.x, pos1.y, pos2.x, pos2.y, 0 ] })
                .animate({ gbuBattleLine:[ pos1.x, pos1.y, pos2.x, pos2.y, 1 ] }, mainDuration, 'easeIn');
              $(this).dequeue();
            })
            .delay(mainDuration)
            .queue(function () {
              $('#gbu-battle-summary').fadeIn(100);
              var anim = Raphael.animation({ r:110, opacity:0 }, 500);
              for (var i=0; i<3; i++) {
                paper.circle((pos1.x + pos2.x) / 2, (pos1.y + pos2.y) / 2, 20)
                  .attr({ fill:'#FF7313', stroke:'none' }).animate(anim.delay(i * 120));
              }
              $(this).dequeue();
            })
            .delay(550)
            .queue(function () {
              var move = 100, duration = 1200, easing = 'easeOutExpo';
              $('.gbu-battle-record .battle-user').hide();
              $('#gbu-battle-record-1').css({ top:'', left:50 + move }).animate({ left:50, opacity:'show' }, duration, easing);
              $('#gbu-battle-record-2').css({ top:'', right:50 + move }).animate({ right:50, opacity:'show' }, duration, easing);
              $(this).dequeue();
            })
            .delay(600)
            .queue(function () {
              $('.gbu-battle-record').each(function (index, elem) {
                $(elem).find('.battle-user').slideDown({ duration:1000, easing:'easeInOutExpo' });
              });
              $(this).dequeue();
            })
            .delay(600)
            .queue(function () {
              var move = 250, duration = 1200, easing = 'easeInQuint';
              var move2 = 0, duration2 = 1000, easing2 = 'easeOutQuint';
              $('#gbu-battle-record-1').animate({ left:50 + move }, duration, easing).animate({ left:50 + move2 }, duration2, easing2);
              $('#gbu-battle-record-2').animate({ right:50 + move }, duration, easing, shake).animate({ right:50 + move2 }, duration2, easing2);
              $(this).dequeue();
            })
            .delay(2200)
            .queue(function () {
              $('#gbu-battle-result-effect-1 .value').hide().css({ left:300 }).animate({ opacity:'show', left:-150 }, 800, 'easeOutExpo');
              $('#gbu-battle-result-effect-2 .value').hide().css({ right:300 }).animate({ opacity:'show', right:-150 }, 800, 'easeOutExpo');
              $(this).dequeue();
            })
            .delay(1800)
            .queue(function () {
              $('#gbu-battle-result-effect-1 .value').animate({ opacity:'hide', left:'-=200' }, 800, 'easeInExpo');
              $('#gbu-battle-result-effect-2 .value').animate({ opacity:'hide', right:'-=200' }, 800, 'easeInExpo');
              $('.gbu-battle-record .battle-result').delay(800).fadeIn(200);
              $(this).dequeue();
            })
            .delay(400)
            .queue(function () {
              $('.gbu-battle-record:has(.battle-result-lose)').animate({ top:'+=50', opacity:'hide' }, 1400, 'easeInQuint');
              $(this).dequeue();
            })
            .delay(3600)
            .queue(function () {
              $('.gbu-battle-record').fadeOut(400);
              $('#gbu-battle-summary').fadeOut(400);
              $('#gbu-top .scroll-map').fadeOut(900);
              $(this).dequeue();
              clearTimeout(self.gbu_iid);
              self.gbu_iid = setTimeout(updateGbuTopBattle, 1000);
            });
          
          function shake() {
            var amountX = 25, amountY = 15;
            var top = $('#gbu-top').css({ position:'relative' }).stop(true, true);
            for (var i=0; i<5; i++) {
              top.animate({ left:r(amountX), top:r(amountY) }, 30, 'linear');
            }
            top.animate({ left:0, top:0 }, 30);
          }
        }
        
        function updateUser(elem, effect, data) {
          elem.find('.battle-result')
            .removeClass('battle-result-win battle-result-lose battle-result-draw')
            .addClass('battle-result-' + data.result)
            .text(PGL.Text.get('global.gbu.' + data.result)).show().squeezeText().hide();
          effect
            .removeClass('battle-result-win battle-result-lose battle-result-draw')
            .addClass('battle-result-' + data.result)
            .children('.value').show().squeezeText(PGL.Text.get('global.gbu.' + data.result)).hide();
          elem.find('.ranking .value').text(data.rank || '-');
          elem.find('.avatar img').attr({ src:'/profile/assets/images/avatar/' + data.avator_id + '.png' });
          elem.find('.pglname').squeezeText(data.nickName);
          elem.find('.trainername .value').html(PGL.Utils.renderDSFont('ds-font-6', data.trainerName));
          elem.find('.rating .value').text(data.rating || '-');
          elem.find('.country').text(PGL.Report.areasByPGL[data.country_id].iso3166);
        }
      });
    },
    // 対戦ルールごとのランキング
    showGBURanking:function (states) {
      var self = this;
      
      if ($('#gbu-season-ranking').data('season') == states.season) {
        return;
      }
      $('#gbu-season-ranking').data('season', states.season);
      
      $('#gbu-season-ranking .gbu-season-selector select').val([ states.season ]);
      var lastFormat = $('#gbu-season-ranking').data('format') || 'overall';
      
      var params = { rowcount:10, offset:0, type:0 };
      params.season_id = states.season;
      
      // ランキング操作UI
      
      // 地域で絞り込む
      $('#gbu-ranking-area-filter').unbind('click').click(function () {
        self.showAreaSelector(true).then(function (area) {
          if (area) {
            params.country_id = area.pgl;
          } else {
            delete params.country_id;
          }
          params.offset = 0;
          load();
        });
      });
      // 対戦ルール
      $('#gbu-season-ranking .gbu-regulation-selector div').unbind('click').click(function () {
        $(this).addClass('selected').siblings().removeClass('selected');
        var format = $(this).data('value');
        params.type = { overall:5, single:0, 'double':1, triple:2, shooter:4, rotation:3 }[format];
        params.offset = 0;
        load();
        $('#gbu-season-ranking').data('format', format)
      }).filter('.regulation-' + lastFormat).click();
      // ページめくり
      $('#gbu-season-ranking .prev').unbind('click').click(function () {
        if ($(this).is(':visible')) {
          params.offset = Math.max(0, params.offset - 10);
          load();
          $(':focus').blur();
        }
      });
      $('#gbu-season-ranking .next').unbind('click').click(function () {
        if ($(this).is(':visible')) {
          params.offset += 10;
          load();
          $(':focus').blur();
        }
      });
      
      
      function load() {
        $('#gbu-season-ranking').block(BLOCK_PARAMS);
        $('#gbu-season-ranking .prev').toggle(params.offset > 0);
        
        var filterdArea = PGL.Report.areasByPGL[params.country_id];
        if (filterdArea) {
          $('#gbu-ranking-area-filter .value').show().text(filterdArea.names[PGL.language]).squeezeText();
        } else {
          $('#gbu-ranking-area-filter .value').hide();
        }
        
        self.getApiWithCache('gbu.worldbattle.worldbattle_regulation_ranking', params).then(function (data) {
          $('#gbu-season-ranking').unblock();
          if (data[0]) {
            $('#gbu-season-ranking .next').toggle(params.offset + 10 < data[0].cnt);
            $('#gbu-season-ranking .updated-at .value').text(PGL.Utils.formatTime(data[0].updated_at, { tzoffset:9, appendTZ:true })).parent().show();
            self.updateGBURanking($('#gbu-season-ranking .gbu-ranking'), data[0], params.season_id == self.seasons[0].season_id, params.season_id);
            $('#gbu-season-ranking .myranking').show().unbind('click').addClass('disabled');
            if (data[0].myrank_order) {
              if (params.country_id == undefined) {
                // 国で絞り込んでいないので、必ずマイランキング有効
                enableMyrankButton();
              } else if (data[0].myrank_order > data[0].cnt) {
                // myrank_orderが総件数を超えているので、マイランキング無効
              } else {
                // myrank_orderが自分のものか確かめる
                var params2 = $.extend({}, params, { offset:data[0].myrank_order - 1, rowcount:1 });
                self.getApiWithCache('gbu.worldbattle.worldbattle_regulation_ranking', params2).then(function (data2) {
                  // 自分のものなら
                  if ((data2[0].ranking_list[0] || {}).pgl_name == self.data.member.pgl_name) {
                    enableMyrankButton();
                  }
                });
              }
            }
          } else {
            $('#gbu-season-ranking .next').hide();
            $('#gbu-season-ranking .updated-at').hide();
            self.updateGBURanking($('#gbu-season-ranking .gbu-ranking'), { ranking_list:[] });
            $('#gbu-season-ranking .myranking').show().unbind('click').addClass('disabled');
          }
          function enableMyrankButton() {
            $('#gbu-season-ranking .myranking').click(function () {
              params.offset = Math.max(0, data[0].myrank_order - 6);
              load();
            }).removeClass('disabled');
          }
        }, function () {
          $('#gbu-season-ranking').unblock();
        });
      }
    },
    /* よく手持ちに入れられているポケモン */
    showGBUTrend:function (states) {
      var self = this;
      if ($('#gbu-season-trend').data('season') == states.season) {
        return;
      }
      $('#gbu-season-trend').data('season', states.season);
      
      $('#gbu-season-trend').block(BLOCK_PARAMS);
      $('#gbu-season-trend .gbu-season-selector select').val([ states.season ]);
      var lastFormat = $('#gbu-season-trend').data('format') || 'single';
      
      var json = ['/swf/json/used_pokemon_', null, states.season, '.json'];
      
      // 対戦ルール
      $('#gbu-season-trend .gbu-regulation-selector div').unbind('click').click(function () {
        $(this).addClass('selected').siblings().removeClass('selected');
        json[1] = $(this).data('value');
        load();
        $('#gbu-season-trend').data('format', json[1]);
      }).filter('.regulation-' + lastFormat).click();
      
      function load() {
        self.getJsonWithCache(json.join('')).then(function (data) {
          $('#gbu-season-trend').unblock();
          $('#gbu-season-trend .pokemon-ranking').empty();
          $.each(data.used_pokemon_list, function (index, pokedex) {
            var li = $('<li class="ranking-entry"></li>').click(function () {
              showOverlay(PGL.Report.getPokemonByPokedex(pokedex), data.used_pokemon_all_list[pokedex]);
            }).hover(function () {
              $(this).showBalloon('gbu-ranking-balloon', PGL.Report.getPokemonByPokedex(pokedex));
            }, function () {
              $(this).hideBalloon();
            }).appendTo('#gbu-season-trend .pokemon-ranking').pokemonRankingItem(Math.floor(index), pokedex);
          });
          $('#gbu-season-trend-combinations ol ul li:first').click();
        
          $('#gbu-season-trend-pokemon-select').unbind('click').click(function () {
            self.showPokemonSelector().then(function (pokemon) {
              showOverlay(pokemon, data.used_pokemon_all_list[pokemon.pokedex]);
            });
          });
          
          // ～と一緒によく手持ちに入れられている
          function showOverlay(pokemon, combinations) {
            var overlay = $('#gbu-season-trend-pokemon');
            if (overlay.is(':hidden')) {
              $('#gbu-season-trend').block({
                message:overlay,
                css:{ width:671, height:552, 'border-style':'none', background:'transparent', cursor:'default' },
                overlayCSS:{ cursor:'default' }
              });
            }
            
            var prev = pokemon.prev || {}, next = pokemon.next || {};
            overlay.find('.pokemon').pokemon({ pokemon:pokemon, reflect:true });
            overlay.find('.pokedex-nav .current').text(PGL.Utils.zerofill(pokemon.pokedex, 3));
            overlay.find('.pokedex-nav .prev').text(PGL.Utils.zerofill(prev.pokedex, 3)).toggle(!!pokemon.prev);
            overlay.find('.pokedex-nav .next').text(PGL.Utils.zerofill(next.pokedex, 3)).toggle(!!pokemon.next);
            overlay.find('.pokedex-nav .prev, .pokedex-nav .next').unbind('click').click(function () {
              var pokedex = parseInt($(this).text(), 10);
              showOverlay(PGL.Report.getPokemonByPokedex(pokedex), data.used_pokemon_all_list[pokedex]);
              return false;
            });
            
            overlay.find('h3 .value').text(pokemon[PGL.language]);
            overlay.find('.close').unbind('click').click(function () {
              $('#gbu-season-trend').unblock();
            });
            var ol = overlay.find('.gbu-combination-ranking ol').empty();
            $.each(combinations, function (index, pokedex) {
              $('<li><div class="image"></div><div class="name"><span class="value"></span></div></li>').appendTo(ol).pokemon({ pokedex:pokedex, reflect:true });
            });
          }
        });
      }
    },
    // Wi-Fi大会
    showWiFiCompetitions:function (states) {
      setMusic('gbu');
      var self = this;
      if (!self.reportData.wifi) {
        self.reportData.wifi = { page:0 };
      }
      
      $('#wifi-competitions .nav-back').unblock('click').click(function () {
        location.hash = '#/wifi-competitions/';
        self.navigateToCurrent(true);
      });
      
      $('#wifi-competitions').show().block(BLOCK_PARAMS);
      this.getApiWithCache('gbu.journal.worldbattle_list').then(function (data) {
        $('#wifi-competitions').unblock();
        
        if (!self.last_wifi_comp) {
          self.last_wifi_comp = data[0].worldbattle_id;
        }
        
        $('#wifi-comp-list .prev').unbind('click').click(function () {
          self.reportData.wifi.page--;
          updateList();
        });
        $('#wifi-comp-list .next').unbind('click').click(function () {
          self.reportData.wifi.page++;
          updateList();
        });
        
        var currentComp = null;
        $.each(data, function (index, comp) {
          if (states.id == comp.worldbattle_id) {
            self.reportData.wifi.page = Math.floor(index / 6);
            currentComp = comp;
          }
        });
        
        updateList();
        
        if (currentComp != null) {
          if ($('#wifi-comp-detail').data('currentComp') == currentComp) {
            return;
          }
          
          $('#wifi-comp-detail').data({ currentComp:currentComp });
          $('#wifi-comp-detail td:eq(0)').text(currentComp.worldbattle_rule);
          $('#wifi-comp-detail td:eq(1)').text(currentComp.worldbattle_summary);
          $('#wifi-comp-detail td:eq(2)').html(PGL.Text.get('report.gbuc.competition.regulation.' + currentComp.rom_type));
          $('#wifi-comp-detail td:eq(3)').text(currentComp.participant_count);
          $('#wifi-comp-detail .comp-spec .pdf').attr({ href:currentComp.regulation_pdf });
          $('#wifi-comp-detail .comp-spec .name').squeezeText(currentComp.worldbattle_name);
          $('#wifi-comp-detail .comp-spec .span .value:eq(0)').text(PGL.Utils.formatTime(currentComp.open_date_from, { format:'DATE' }));
          $('#wifi-comp-detail .comp-spec .span .value:eq(1)').text(PGL.Utils.formatTime(currentComp.open_date_to, { format:'DATE' }));
            
          $('#wifi-comp-detail .areas ul').empty();
          $.each(currentComp.country_list, function (index, pgl_id) {
            var area = PGL.Report.areasByPGL[pgl_id];
            $('<li class="marker"></li>').text(area.iso3166).css({
              left:148 + area.coords[1] * 31,
              top:74 - area.coords[0] * 38
            }).appendTo('#wifi-comp-detail .areas ul');
          });
          
          
          var params = { cup_no:states.id, rowcount:10, offset:0 };
          
          $('#wifi-comp-detail-ranking .prev').unbind('click').click(function () {
            if ($(this).is(':visible')) {
              params.offset = Math.max(0, params.offset - 10);
              loadRanking();
              $(':focus').blur();
            }
          });
          $('#wifi-comp-detail-ranking .next').unbind('click').click(function () {
            if ($(this).is(':visible')) {
              params.offset += 10;
              loadRanking();
              $(':focus').blur();
            }
          });
          
          var loadRanking = function () {
            $('#wifi-comp-detail').block(BLOCK_PARAMS);
            $('#wifi-comp-detail-ranking .prev').toggle(params.offset > 0);
            self.getApiWithCache('gbu.worldbattle.worldbattle_cup_ranking', params).then(function (data) {
              $('#wifi-comp-detail').unblock();
              if (data[0]) {
                $('#wifi-comp-detail-ranking .next').toggle(params.offset + 10 < data[0].cnt);
                self.updateGBURanking($('#wifi-comp-detail-ranking .gbu-ranking'), data[0]);
                $('#wifi-comp-detail-ranking .myranking').show().unbind('click').addClass('disabled');
                if (data[0].myrank_order) {
                  $('#wifi-comp-detail-ranking .myranking').click(function () {
                    params.offset = Math.max(0, data[0].myrank_order - 6);
                    loadRanking();
                  }).removeClass('disabled');
                }
              } else {
                $('#wifi-comp-detail-ranking .next').hide();
                self.updateGBURanking($('#wifi-comp-detail-ranking .gbu-ranking'), { ranking_list:[] });
                $('#wifi-comp-detail-ranking .myranking').unbind('click').addClass('disabled');
              }
            });
          };
          loadRanking();
          
          if (PGL.language == 'ja') {
            var json = '/swf/json/used_pokemon_' + states.id + '.json';
          } else {
            var json = '/swf/json/used_pokemon_' + states.id + '_' + PGL.language + '.json';
          }
          self.getJsonWithCache(json).then(function (data) {
            $('#wifi-comp-detail-pokemons .pokemon-ranking').empty();
            data = data || {};
            $.each(data.used_wifi_pokemon_list || [], function (index, record) {
              var li = $('<li></li>').click(function () {
                showOverlay(record);
              }).hover(function () {
                $(this).showBalloon('gbu-ranking-balloon', PGL.Report.getPokemonByPokedex(record.monsno));
              }, function () {
                $(this).hideBalloon();
              }).appendTo('#wifi-comp-detail-pokemons .pokemon-ranking').pokemonRankingItem(parseInt(index), record.monsno);
            });
            if ((data.used_wifi_pokemon_list || []).length == 0) {
              self.showDialog(PGL.Text.get('report.gbuc.competition.trend.empty'), { ok:true });
            }
          }, function () {
            $('#wifi-comp-detail-pokemons .pokemon-ranking').empty();
          });
        }
        
        
        function updateList() {
          var itemPerPage = 6;
          $('#wifi-comp-list .prev').toggle(self.reportData.wifi.page > 0);
          $('#wifi-comp-list .next').toggle(self.reportData.wifi.page < Math.ceil(data.length / itemPerPage) - 1);
          $('#wifi-comp-list ul').empty();
          $.each(data.slice(self.reportData.wifi.page * itemPerPage, (self.reportData.wifi.page + 1) * itemPerPage), function (index, comp) {
            var li = $('<li></li>').appendTo('#wifi-comp-list ul').addClass('column-' + Math.floor(index / 3));
            $('<img/>').attr({ src:comp.worldbattle_banner }).appendTo(li);
            li.bind('click touchstart', function () {
              location.hash = '#/wifi-competitions/' + comp.worldbattle_id;
              self.navigateToCurrent(true);
            });
            if (comp.worldbattle_id == self.last_wifi_comp) {
              li.addClass('selected');
            }
          });
        }
      });
      function showOverlay(record) {
        var pokemon = PGL.Report.getPokemonByPokedex(record.monsno);
        var overlay = $('#wifi-comp-detail-pokemon');
        if (overlay.is(':hidden')) {
          $('#wifi-competitions').block({
            centerY:false,
            message:overlay,
            css:{ top:1010, width:878, height:552, 'border-style':'none', background:'transparent', cursor:'default' },
            overlayCSS:{ cursor:'default' }
          });
        }
        overlay.find('.pokedex-nav .current').text(('00' + pokemon.pokedex).substr(-3));
        overlay.find('.pokemon').pokemon({ pokemon:pokemon, reflect:true });
        overlay.find('h3 .value').text(pokemon[PGL.language]);
        overlay.find('.close').unbind('click').click(function () {
          $('#wifi-competitions').unblock();
        });
        var ol = overlay.find('.gbu-combination-ranking ol').empty();
        $.each(record.used_list_list, function (index, pokedex) {
          $('<li><div class="image"></div><div class="name"><span class="value"></span></div></li>').appendTo(ol).pokemon({ pokedex:pokedex, reflect:true });
        });
        $.each(['waza', 'speabi', 'seikaku', 'item'], function (index, prop) {
          var trend = overlay.find('.wifi-pokemon-trend').eq(index);
          if (index) {
            trend.removeClass('selected');
          } else {
            trend.addClass('selected');
          }
          trend.find('.label').unbind('click').click(function () {
            if (!trend.is('.selected')) {
              overlay.find('.selected').removeClass('selected');
              trend.addClass('selected');
              updatePanes(250);
            }
          });
          var paper = Raphael(trend.find('.graph').empty().get(0), 200, 105);
          PGL.Report.extendRaphael(paper);
          
          updatePanes(0);
          
          function updatePanes(duration) {
            var top = 0;
            overlay.find('.wifi-pokemon-trend').each(function (index, pane) {
              var h = $(pane).is('.selected') ? 328 : 24;
              $(pane).animate({ top:top, height:h }, duration, 'linear');
              top += h;
            });
          }
          
          var canonList = (function (lists) {
            var canonList = [];
            $.each(lists.name, function (index, name) {
              if (index < 10) {
                canonList.push({ name:name, ratio:lists.ratio[index] / 100 });
              }
            });
            return canonList;
          })(record.trend_list[prop]);
          
          var list = trend.find('ol').empty();
          var start = Math.PI * -0.5;
          var cx = 100, cy = 52;
          $.each(canonList, function (index, record) {
            var val = record.ratio * Math.PI * 2;
            var color = ['#666', '#999', '#CCC'][index % 3];
            if (index == canonList.length - 1 && index % 3 == 0) {
              color = '#999';
            }
            (function (start, val) {
              // グラフ
              var pie = paper.path().attr({ pie:[cx, cy, start, start + val - 0.0001, 50, 35], stroke:'none', fill:color });
              pie.mouseover(over).mouseout(out);
              
              var li = $('<li></li>').appendTo(list)
                .append($('<span class="index"></span>').text(index + 1))
                .append($('<span class="name"></span>').text(record.name || '-'))
                .append(
                  $('<span class="ratio"><span class="unit">%</span></span>').prepend(
                    $('<span class="value"></span>').text(perc(record.ratio))
                  )
                ).hover(over, out);
              function perc(value) {
                var t = Math.floor(record.ratio * (prop == 'waza' ? 400 : 100) * 10) / 10 + '';
                if (t != '100' && t.indexOf('.') == -1) {
                  t += '.0';
                }
                return PGL.Utils.formatNumber(t);
              }
              function over() {
                li.addClass('active');
                pie.animate({ pie:[cx, cy, start, start + val - 0.0001, 50, 0], fill:'#F8F8F8' }, 100);
              }
              function out() {
                li.removeClass('active');
                pie.animate({ pie:[cx, cy, start, start + val - 0.0001, 50, 35], fill:color }, 100);
              }
            })(start, val);
            start += val;
          });
          // 残り
          paper.path().attr({ pie:[cx, cy, start, Math.PI * 1.5, 50, 35], stroke:'none', fill:'#000', opacity:0.2 });
        });
      }
    },
    // ゲームシンク調査隊
    showGlobalRecords:function (states) {
      setMusic('pgl');
      $('#global-records').show();
      if (states.id == null) {
        this.showGlobalRecordsTop(states);
      } else {
        this.showGlobalRecordsDetail(states);
      }
    },
    // ゲームシンク調査隊トップ
    showGlobalRecordsTop:function (states) {
      var self = this;
      
      if (self.global_records_map_paper == undefined) {
        self.global_records_map_paper = Raphael($('#global-records>.map').get(0), 3000, 800);
      }
      
      $('#global-records').block(BLOCK_PARAMS);
      $('#global-records .nav-back a').unbind('click').click(function () {
        self.navigateToCurrent(true, true);
        return false;
      });
      this.getApiWithCache('pgl.journal.census').then(function (data) {
        // PGLコード別の地域レコード
        var area_records_by_pgl = {};
        $.each(data.country_list, function (index, record) {
          area_records_by_pgl[record.country_id] = record;
        });
        
        $('#global-records').unblock();
        $('#global-records .updated-at').show();
        $('#global-records .updated-at .value').text(PGL.Utils.formatTime(data.updated_at));
        
        // 地図上のポイント更新
        $('#global-records .scroll-map .point').remove();
        $.each(PGL.Report.areasWithDetail, function (index, area) {
          var c = self.getScrollMapCoords(area);
          c.x %= 1600;
          $.each([0, 1600], function (index, offset) {
            $('<div class="point"><a></a></div>').css({ left:c.x - 11 + offset, top:c.y - 9 }).click(function () {
              var area_record = area_records_by_pgl[area.pgl];
              var census = $.grep(area_record.census_list, function (census) {
                return census.title == $('#global-records-control .label').text();
              })[0] || {};
              showAreaInfo(area, census, PGL.Report.getPokemonByPokedex(area_record.pokemon_list[0].pokemon_no));
            }).attr({ title:area.names[PGL.language] }).prependTo('#global-records .scroll-map');
          });
        });
        
        // レコードセレクタの初期化
        $('#global-records-control .dropdown ul').empty();
        $.each(data.census_list, function (index, census) {
          census.index = index;
          $('<li></li>').mousedown(function (event) {
            $('#global-records-control .label').show();
            $('#global-records-control .dropdown').slideUp(100);
            showRecord(census.ranking_list[0]);
            if (event.stopPropagation) {
              event.stopPropagation();
            }
          }).text(census.lead).appendTo('#global-records-control .dropdown ul');
        });
        $('#global-records-control .dropdown-button').unbind('mousedown').mousedown(function (event) {
          if ($('#global-records-control .dropdown').is(':visible')) {
            $('#global-records-control .label').show();
            $('#global-records-control .dropdown').slideUp(100);
          } else {
            $('#global-records-control .label').hide();
            $('#global-records-control .dropdown').slideDown(100);
          }
          event.stopPropagation();
        });
        
        // 調査リストの初期化（初回だけ）
        if ($('#global-records-list').is(':empty')) {
          // APIの値から構築
          $.each(data.census_list, function (index, census) {
            var e = $('<div class="census"></div>').appendTo('#global-records-list');
            $('<h3></h3>').text(census.lead).appendTo(e);
            var ol = $('<ol></ol>').appendTo(e);
            $.each(census.ranking_list.slice(0, 5), function (index, record) {
              record.census = census;
              var li = record.element = $('<li></li>').appendTo(ol).click(function (event, suppressNavigate) {
                showRecord(record);
                if (!suppressNavigate) {
                  self.navigateToCurrent(true, true);
                }
              });
              $('<div class="area"></div>').text(record.country_name).appendTo(li);
              $('<div class="result"></div>').recordResult(record.label).appendTo(li);
            });
          });
          // 最初のアイテムを選択
          $('#global-records-list .census li:first').trigger('click', [true]);
        }
        
        rescheduleRotateCensus();
        
        
        // 選択されたレコードを表示
        function showRecord(record) {
          var area = PGL.Report.areasByPGL[record.country_id];
          
          // ドロップダウン更新
          $($('#global-records-control .dropdown li').get(record.census.index))
            .addClass('selected').siblings().removeClass('selected');
          // レコードコントロール更新
          $('#global-records-control .label').squeezeText(record.title);
          var rs = $('#global-records-control .record-selector').empty();
          $.each(record.census.ranking_list, function (index, r) {
            var li = $('<li></li>').click(function () {
              showRecord(r);
            }).text(r.ranking).addClass('ranking-' + r.ranking).appendTo(rs);
            if (r == record) {
              li.addClass('selected');
            }
          });
          
          // 地域情報更新
          showAreaInfo(area, record, PGL.Report.getPokemonByPokedex(record.pokemon_no));
          
          // 調査リスト更新
          $('#global-records-list .census li').removeClass('selected');
          record.element.addClass('selected');
        }
        
        // 地域の情報を表示
        function showAreaInfo(area, record, mostSlept) {
          rescheduleRotateCensus();
          
          $('#global-records-general').show();
          // 調査結果表示
          $('#global-records-general .census-result').recordResult(record.label || '');
          
          $('#global-records-general .area .name').text(area.names[PGL.language] || '').squeezeText();
          $('#global-records-general .area .iso-3166-1').text(area.iso3166);
          $('#global-records-general .most-slept-pokemon').pokemon({ pokedex:mostSlept.pokedex });
          $('#global-records-general .most-slept-pokemon .footprint img').attr({ src:'assets/images/footprint/' + ('00' + mostSlept.pokedex).substr(-3) + '.png' });
          
          var d = new Date();
          d.setTime(d.getTime() + area.tz.offset * 60 * 60 * 1000);
          $('#global-records-general .area .tzname').text(area.tz.name);
          $('#global-records-general .area .time').text(PGL.Utils.zerofill(d.getUTCHours(), 2) + ':' + PGL.Utils.zerofill(d.getUTCMinutes(), 2));
          $('#global-records-general .area .clock').clock(d);
          
          // もっと見るボタン
          $('#global-records-general-more').toggle(area.has_detail).unbind('click').click(function () {
            location.hash = '#/global-records/' + area.pgl;
            self.navigateToCurrent(true);
          });
          
          // アニメーション
          var c = self.getScrollMapCoords(area);
          
          // 座標の調整
          var left = parseInt($('#global-records .scroll-map').css('left'));
          var dest = 1003 / 2 - c.x;
          if (!isNaN(left)) {
            if (left - dest > 800) {
              dest += 1600;
            } else if (dest - left > 800) {
              dest -= 1600;
            }
            if (dest > 0) {
              dest -= 1600;
              left -= 1600;
              $('#global-records .scroll-map').css({ left:left });
            } else if (dest < 1003 - 3200) {
              dest += 1600;
              left += 1600;
              $('#global-records .scroll-map').css({ left:left });
            }
          }
          c = $.extend({}, c, { x:1003 / 2 - dest });
          
          var set;
          (function (r) {
            r.clear();
            set = r.set();
            set.push(r.circle(c.x, c.y, 0).attr({ stroke:'#00479d', 'stroke-opacity':0.60, fill:'#00baff', 'fill-opacity':0.30 }));
            set.push(r.circle(c.x, c.y, 0).attr({ stroke:'#00479d', 'stroke-opacity':0.40, fill:'#00baff', 'fill-opacity':0.25 }));
            set.push(r.circle(c.x, c.y, 0).attr({ stroke:'#00479d', 'stroke-opacity':0.30, fill:'#3393cc', 'fill-opacity':0.20 }));
            set.push(r.path(['M', c.x, c.y, 'L', c.x, c.y]).attr({ stroke:'#FFF', 'stroke-width':1 }));
            set.push(r.circle(c.x, c.y, 0).attr({ stroke:'#00479d', 'stroke-opacity':0.60, fill:'#ffbc00' }));
            set.push(r.text(c.x - 0.5, c.y + 0.5, record.ranking || '').attr({ fill:'#c45d00', 'font-size':record.ranking > 99 ? 11 : 15, opacity:0 }));
          })(self.global_records_map_paper);
          
          $('#global-records-general').hide();
          $('#global-records .scroll-map')
            .stopAll()
            .animate({ left:-c.x + 1003 / 2 }, 300)
            .queue(function () {
              setTimeout(function () {
                set[2].attr({ r:0 }).animate({ r:84 * 1.000 }, 450, '<>');
              }, 0);
              setTimeout(function () {
                set[1].attr({ r:0 }).animate({ r:84 * 0.595 }, 450 * 1.3, '<>');
              }, 100);
              setTimeout(function () {
                set[0].attr({ r:0 }).animate({ r:84 * 0.333 }, 450 * 1.6, '<>');
              }, 200);
              setTimeout(function () {
                set[4].attr({ r:0 }).animate({ r:11 }, 450 * 1.4, 'backOut');
              }, 600);
              setTimeout(function () {
                set[3].animate({ path:['M', c.x, c.y, 'L', c.x+247-85, 251] }, 250);
              }, 1100);
              setTimeout(function () {
                set[5].attr({ r:0 }).animate({ opacity:1 }, 200);
              }, 1100);
              $(this).dequeue();
            })
            .delay(1100 + 250)
            .queue(function () {
              $('#global-records-general').slideDown(300);
              $(this).dequeue();
            });
        }
      });
      
      function rescheduleRotateCensus() {
        clearTimeout(self.global_records_iid);
        self.global_records_iid = setTimeout(function () {
          var targets = $('#global-records-list li');
          var index = targets.index(targets.filter('.selected'));
          $(targets.get((index + 1) % targets.length)).trigger('click', [true]);
        }, 6000);
      }
    },
    /** ゲームシンク調査隊詳細 */
    showGlobalRecordsDetail:function (states) {
      var self = this;
      var area = PGL.Report.areasByPGL[states.id];
      
      this.getApiWithCache('pgl.journal.census').then(function (data) {
        // PGLコード別の地域レコード
        var area_records_by_pgl = {};
        $.each(data.country_list, function (index, record) {
          area_records_by_pgl[record.country_id] = record;
        });
        
        var area_records = area_records_by_pgl[area.pgl];
        
        $('#global-records-detail .close').unbind().click(function () {
          $('#global-records').unblock();
          location.hash = '#/global-records';
        });
        
        // オーバーレイ
        $('#global-records').block({
          message: $('#global-records-detail'),
          centerX: false,
          centerY: false,
          css:{ left:39, top:28, width:964, height:600, 'border-style':'none', background:'transparent', cursor:'default' },
          overlayCSS:{ cursor:'default' }
        });
        // オーバーレイ更新
        self.updateLocalInfo($('#global-records-detail .local-info'), area, true);
      });
    },
    /** 地域情報を更新 */
    updateLocalInfo: function (target, area, showRecord) {
      var dfd = $.Deferred();
      var self = this;
      
      target.children('.map').css({ 'background-image':'' });
      setTimeout(function () {
        var url = 'http://' + self.host.getPageAssetHost() + '/src/swf/report/images/areas/' + area.gts + '/' + (new Date()).getUTCHours() + '.jpg';
        target.children('.map').css({ 'background-image':'url(' + url + ')' });
      }, 1);
      target.find(':animated').stop(true, true);
      
      var gts_call = this.getApiWithCache('gts.journal.area_detail_data', { country_id:area.gts });
      var record_call = this.getApiWithCache('pgl.journal.census');
      
      target.find('.map-center .time').hide();
      target.find('.map-center .area .country-name').text('');
      target.find('.map-center .area .capital-name').text('');
      target.find('.area .name').hide();
      target.find('.area .iso-3166-1').hide();
      target.find('.area .spec').hide();
      target.find('.area .gamesoft').hide();
      target.find('.gts-record-switcher').hide();
      target.find('.gts-area-info').hide();
      target.find('.global-records-info').hide();
      
      (function () {
          var canvas = target.find('.map-center .canvas');
          var paper = canvas.data('paper');
          if (paper == undefined) {
            paper = Raphael(canvas.get(0), 380, 380);
            canvas.data('paper', paper);
          }
          paper.clear();
      })();
      
      gts_call.then(function (data) {
        // 切り替え
        target.find('.gts-record-switcher a').unbind('click').click(function () {
          $(this).addClass('selected').siblings().removeClass('selected');
          if ($(this).hasClass('gts-record-switcher-gts')) {
            target.find('.global-records-info').stopAll().slideUp(250);
            target.find('.gts-area-info').stopAll().delay(200).slideDown(250);
          } else {
            target.find('.gts-area-info').stopAll().slideUp(250);
            target.find('.global-records-info').stopAll().delay(200).slideDown(250);
          }
          return false;
        });
        
        // 中心
        var date = new Date();
        date.setTime(date.getTime() + area.tz.offset * 60 * 60 * 1000);
        var dateStr = $.map([date.getUTCHours(), date.getUTCMinutes()], function (val) {
          return PGL.Utils.zerofill(val, 2);
        }).join(':');
        dateStr += ' UTC' + (area.tz.offset < 0 ? '-' : '+') + PGL.Utils.zerofill(Math.abs(area.tz.offset), 2) + ':00';
        target.find('.map-center .area .country-name').show().squeezeText(data.country_name).hide().delay(1100).fadeIn(300);
        target.find('.map-center .area .capital-name').show().squeezeText(data.capital).hide().delay(1200).fadeIn(300);
        target.find('.map-center .time').text(dateStr).hide().stop(true, true).delay(1300).show(0).rotateText();
        (function () {
          var canvas = target.find('.map-center .canvas');
          var paper = canvas.data('paper');
          if (paper == undefined) {
            paper = Raphael(canvas.get(0), 380, 380);
            canvas.data('paper', paper);
          }
          paper.clear();
          var anim = Raphael.animation({ r:187, opacity:1 }, 400, 'backOut');
          paper.circle(190, 190, 500).attr({ stroke: '#78E82C', 'stroke-width':5, 'stroke-dasharray':['.'], opacity:0 }).animate(anim.delay(1200));
          // 時計
          (function (cx, cy) {
            for (var i=0; i<12; i++) {
              paper.rect(cx + 23, cy - 2, 7, 4).attr({ stroke:null, fill:'#78E82C' }).rotate(i * 30, cx, cy);
            }
            paper.rect(cx - 4, cy - 2.5, 16, 5).attr({ stroke:null, fill:'#78E82C' }).id = 'handH';
            paper.rect(cx - 4, cy - 1.5, 24, 3).attr({ stroke:null, fill:'#78E82C' }).id = 'handM';
            var hour = date.getTime() / 1000 / 60 / 60;
            paper.getById('handH').transform('t-4,0r' + (hour / 12 * 360 + 270) + 't4,0');
            paper.getById('handM').transform('t-8,0r' + (hour * 360 + 270) + 't8,0');
          })(190, 136);
        })();
        
        // 左側共通
        target.find('.area').attr({ 'class':'area' }).addClass('area-' + area.iso3166);
        target.find('.area .name').text(data.country_name);
        target.find('.area .iso-3166-1').text(area.iso3166);
        
        (function () {
          var spec = [];
          spec.push(data.capital);
          spec.push(data.area_size); // area_size: localized string
          spec.push(PGL.Utils.formatNumber(data.population));
          spec.push(PGL.Utils.formatNumber(data.netuser));
          spec.push(PGL.Utils.formatNumber(data.visitor));
          $.each(spec, function (index, value) {
            target.find('.spec dt').eq(index).squeezeText();
            // koでKORを見たときの値
            if (PGL.language == 'ko' && area.iso3166 == 'KOR') {
              if (index == 1) {
                var value = PGL.Text.get('report.gts.country.area.kor');
                value = value.replace(/^(.*?)$/mg, "<div>$1</div>");
                target.find('.spec dd').eq(index).children('.value').html(value).delay(550).rotateText();
                target.find('.spec dd').eq(index).children('.unit').hide();
                target.find('.spec dd').eq(index).find('.value div').css({ width:120 });
                return;
              }
              if (index == 2) {
                var value = PGL.Text.get('report.gts.country.population.kor');
                target.find('.spec dd').eq(index).children('.value').text(value).delay(550).rotateText();
                target.find('.spec dd').eq(index).children('.unit').hide();
                return;
              }
            }
            target.find('.spec dd').eq(index).children('.unit').show();
            target.find('.spec dd').eq(index).children('.value').text(value).delay(550).rotateText();
          });
          target.find('.spec dd:eq(0) .value').squeezeText();
        })();
        
        
        var total = 0, rate_by_id = {};
        /*
        var hide_b2w2 = false;
        var is_ko = area.gts == 170;
        var except_jp = area.gts != 105;
        if (is_ko) {
          data.total_rate[20] += data.total_rate[22] || 0;
          data.total_rate[21] += data.total_rate[23] || 0;
          delete data.total_rate[22];
          delete data.total_rate[23];
        }
        */
        $.each(data.total_rate, function (key, value) {
          value = parseInt(value);
          rate_by_id[key] = value;
          total += value;
        });
        if (total) {
          var paper = target.data('paper');
          if (paper == undefined) {
            paper = Raphael(target.find('.gamesoft').get(0), 200, 200);
            PGL.Report.extendRaphael(paper);
            target.data('paper', paper);
          }
          target.find('.gamesoft .label').remove();
          paper.clear();
          var layer1 = paper.circle();
          var cards = [
            { id:22, color:'90-#FF8A00-#CB904B', label:PGL.Text.get('global.white2'), top:30, left:118, cy:52, cx:163 },
            { id:20, color:'90-#DCDCDC-#BABABA', label:PGL.Text.get('global.white'), top:145, left:118, cy:143, cx:163 },
            { id:21, color:'90-#373737-#676767', label:PGL.Text.get('global.black'), top:145, left:0, cy:143, cx:45 },
            { id:23, color:'90-#0FE6FF-#53BECB', label:PGL.Text.get('global.black2'), top:30, left:0, cy:52, cx:45 }
          ];
          var start = Math.PI * -0.5;
          var cx = 100, cy = 98, delay = 700;
          $.each(cards, function (index, card) {
            if (rate_by_id[card.id]) {
              var val = rate_by_id[card.id] / total * Math.PI * 2;
              var c = start + val * 0.5;
              var duration = val * 60;
              // グラフ
              paper.path()
                .attr({ pie:[cx, cy, start, start, 50, 0], stroke:'none', fill:card.color })
                .animate(Raphael.animation({ pie:[cx, cy, start, start + val, 50, 0] }, duration).delay(delay))
                .insertAfter(layer1);
              delay += duration;
              
              // テキスト
              var text = $('<div class="label"></div>').css({ left:card.left, top:card.top }).text(card.label).appendTo(target.find('.gamesoft'));
              // 引き出し線
              paper.path().attr({ path:[
                [ 'M', cx + Math.cos(c) * 30, cy + Math.sin(c) * 30 ],
                [ 'L', card.cx, card.cy ]
              ], stroke:'#EEE' });
              
              start += val;
            }
          });
        }
        
        // GTS
        target.find('.number-of-users .value').text(data.total_count);
        target.find('.deposited-count .value').text(data.gts_keep_count);
        target.find('.trade-ranking ol').empty();
        $.each(data.traded_ranking_data, function (index, pokedex) {
          $('<li><div class="image"></div></li>').appendTo(target.find('.trade-ranking ol')).bind('click touchstart', function () {
            location.hash = '#/gts/pokemon/' + pokedex;
            self.navigateToCurrent(true);
          }).pokemon({ pokedex:pokedex });
        });
        self.updateDepositeList(target.find('.deposited-list'), data.gts_keep_pokemon_list, null, area.gts);
        
        // アニメーション
        target.find('.area .name').hide().delay(200).animate({ width:'show' }, 250);
        target.find('.area .iso-3166-1').hide().delay(300).fadeIn(250);
        target.find('.area .spec').hide().delay(400).slideDown(300);
        target.find('.area .gamesoft').hide().delay(600).fadeIn(300);
        target.find('.gts-record-switcher').hide().delay(800).animate({ width:'show' }, 300);
        
        if (showRecord) {
          target.find('.gts-area-info').hide();
          target.find('.global-records-info').hide().delay(1000).slideDown(300);
          target.find('.gts-record-switcher-gts').removeClass('selected');
          target.find('.gts-record-switcher-record').addClass('selected');
        } else {
          target.find('.global-records-info').hide();
          target.find('.gts-area-info').hide().delay(1000).slideDown(300);
          target.find('.gts-record-switcher-gts').addClass('selected');
          target.find('.gts-record-switcher-record').removeClass('selected');
        }
      });
      
      record_call.then(function (data) {
        var area_records = $.grep(data.country_list, function (a) {
          return a.country_id == area.pgl;
        })[0];
        target.find('.census-list').toggle(area_records != undefined);
        target.find('.most-slept-pokemon').toggle(area_records != undefined);
        if (area_records) {
          // 右側レコードリスト
          var list = target.find('.census-list');
          list.find('.census').not(':first').remove();
          $.each(area_records.census_list, function (index, census) {
            var item = list.find('.census:first').clone().appendTo(list);
            item.find('h3').text(census.lead);
            item.find('.ranking .value').text(census.ranking);
            item.find('.result').recordResult(census.label);
          });
          list.find('.census:first').remove();
          // 右側ポケモンリスト
          target.find('.most-slept-pokemon ol').empty();
          $.each(area_records.pokemon_list, function (index, pokemon) {
            var li = $('<li><div class="image"></div></li>')
              .appendTo(target.find('.most-slept-pokemon ol')).pokemon({ pokedex:pokemon.pokemon_no });
            $('<div class="ranking"></div>').text('0' + (index + 1)).prependTo(li);
          });
        }
      });
      
      $.when(gts_call, record_call).done(function () {
        dfd.resolve();
      });
      
      return dfd.promise();
    },
    /**/
    updateDepositeList: function (target, deposits, pokedex, area_gts_id) {
      var self = this;
      var list = target.children('.deposits'), pager = target.children('.pager'), map = target.children('.map');
      var page = Math.min(10, Math.ceil(deposits.length / 6));
      list.empty();
      pager.empty();
      map.empty();
      $.each(new Array(page), function (index) {
        var li = $('<li>●</li>').click(function () {
          $(this).addClass('selected').siblings().removeClass('selected');
          list.empty();
          map.empty();
          $.each(deposits.slice(index * 6, index * 6 + 6), function (index, pokemon) {
            var area = PGL.Report.areasByGTS[pokemon.country_id || area_gts_id || 0];
            var li = $('<li><div class="image"></div><div class="sex"></div></li>').appendTo(list);
            $('<div class="level"></div>').append(
              $('<span class="label"></span>').text(PGL.Text.get('global.level')),
              $('<span class="value"></span>').text(pokemon.poke_level)
            ).appendTo(li);
            var areaLink = $('<div class="iso-3166-1"></div>').text(area.iso3166).appendTo(li);
            if (area.has_detail) {
              areaLink.click(function () {
                location.hash = '#/gts/area/' + area.gts;
                self.navigateToCurrent(true);
              }).css({ cursor:'pointer' });
            }
            li.pokemon({ pokedex:pokemon.monsno || pokedex, form:pokemon.form_no, reflect:true, sex:pokemon.sex });
            $('<div class="name"></div>').text(pokemon.pokename).appendTo(li);
            li.hide().delay(index * 80).show(80);
            
            if (map.length && area.coords) {
              if (map.children('.area-' + area.iso3166).length == 0) {
                $('<div class="marker"></div>').text(area.iso3166).css({
                  left:145 + area.coords[1] * 49,
                  top:123 - area.coords[0] * 60
                }).addClass('area-' + area.iso3166).appendTo(map);
              }
              li.hover(function () {
                map.children('.area-' + area.iso3166).addClass('active');
              }, function () {
                map.children('.area-' + area.iso3166).removeClass('active');
              });
            }
          });
        }).appendTo(pager);
      });
      pager.children('li:first').click();
      pager.toggle(page > 1);
    },
    updateGBURanking: function (elem, data, showRankChange, battleRecordsSeason) {
      var self = this;
      
      elem.empty();
      $.each(data.ranking_list || [], function (index, record) {
        var li = $('<li></li>').appendTo(elem).hover(function () {
          $(this).showGBUUserBalloon(record);
        }, function () {
          $(this).hideBalloon();
        }).addClass('column-' + Math.floor(index / 5)).addClass('ranking-' + record.rank);
        
        if (battleRecordsSeason !== undefined) {
          li.click(function () {
            $('#gbu-season-ranking').block(BLOCK_PARAMS);
            self.getApiWithCache('gbu.worldbattle.get_battle_history', { member_savedata_id:record.member_savedata_id, season_id:battleRecordsSeason }).then(function (data) {
              var mp = data.my_profile;
              if (mp) {
                $('#dialog-gbu-records h3 .value').text(mp.pgl_name);
                // fix
                mp.rotate_rank = mp.rotation_rank;
                var hyphenIfZero = function (val) {
                  return val == '0' ? '-' : val;
                };
                $.each(['total', 'single', 'double', 'triple', 'shooter', 'rotate'], function (index, format) {
                  $('#dialog-gbu-records .rating .value').eq(index).text(hyphenIfZero(mp['arena_elo_rating_1v1_' + format]));
                  $('#dialog-gbu-records .ranking .value').eq(index).text(hyphenIfZero(mp[format + '_rank']));
                  if (mp['num_' + format + '_win_counter'] != '0' || mp['num_' + format + '_lose_counter'] != '0') {
                    $('#dialog-gbu-records .win .value').eq(index).text(mp['num_' + format + '_win_counter']);
                    $('#dialog-gbu-records .lose .value').eq(index).text(mp['num_' + format + '_lose_counter']);
                  } else {
                    $('#dialog-gbu-records .win .value').eq(index).text('-');
                    $('#dialog-gbu-records .lose .value').eq(index).text('-');
                  }
                });
                $('#dialog-gbu-records td').each(function (index, td) {
                  $(td).rotateText();
                });
                $('#dialog-gbu-records .close').unbind('click').click(function () {
                  $('#gbu-season-ranking').unblock();
                });
                $('#gbu-season-ranking').block({
                  message:$('#dialog-gbu-records'),
                  centerX:false,
                  centerY:false,
                  css:{ left:160, top:113, width:789, height:232, 'border-style':'none', background:'transparent', cursor:'default' },
                  overlayCSS:{ cursor:'default' }
                });
              } else {
                $('#gbu-season-ranking').unblock();
                self.showDialog(PGL.Text.get('pg_rq_1'), { ok:true });
              }
            }, function () {
              $('#gbu-season-ranking').unblock();
            });
          });
        }
        
        if (record.member_savedata_id == self.data.member.member_savedata_id) {
          li.addClass('myrank');
        }
        $('<div class="ranking"></div>').appendTo(li).squeezeText(record.rank);
        if (showRankChange && record.rank_type !== undefined) {
          $('<div class="ranking-change"></div>').appendTo(li).addClass('ranking-change-' + ['keep', 'up', 'down'][record.rank_type]);
        }
        $('<div class="avatar"></div>').append($('<img/>').attr({ src:'/profile/assets/images/avatar/' + record.avator_id + '.png' })).appendTo(li);
        $('<div class="pglname"></div>').appendTo(li).squeezeText(record.pgl_name || '?');
        $('<div class="country"></div>').text((PGL.Report.areasByPGL[record.country_id] || {}).iso3166 || '').appendTo(li);
        $('<div class="hitarea"></div>').appendTo(li);
        li.hide().delay(index * 20).animate({ width:'show' }, 150);
      });
    },
    loadBookmarks: function () {
      var dfd = $.Deferred();
      if (self.bookmarks) {
        dfd.resolve(self.bookmarks);
      } else {
        this.getApiWithCache('gts.profile.gts_history', { member_savedata_id:this.data.member.member_savedata_id }).then(function (data) {
          self.bookmarks = $.map(data.bookmark_list, function (a) {
            return parseInt(a);
          });
          dfd.resolve(self.bookmarks);
        }, function () {
          dfd.reject();
        });
      }
      return dfd.promise();
    },
    showPokemonSelector: function () {
      var self = this;
      var dfd = $.Deferred();
      var dialog = $('#dialog-pokemon-selector');
      var unblockCompleteHandler = function () {};
      
      // タブを押して内容更新（ブックマーク再取得のため・およびIEでhoverをリセットするため）
      $('#dialog-pokemon-selector .selected').click();
      
      dialog.find('.scroller').css({ overflow:'hidden' });
      if (!dialog.find('.tabs a').is('.selected')) {
        dialog.find('.tabs a:first').click();
      }
      dialog.find('.close').unbind('click').one('click', function () {
        dialog.find('.scroller').css({ overflow:'hidden' });
        unblockCompleteHandler = function () { dfd.reject(); };
        $('#report').unblock();
      });
      dialog.unbind('select').bind('select', function (event, pokedex) {
        dialog.unbind('select');
        dialog.find('.scroller').css({ overflow:'hidden' });
        var pokemon = PGL.Report.getPokemonByPokedex(pokedex);
        unblockCompleteHandler = function () { dfd.resolve(pokemon); };
        $('#report').unblock();
      });
      
      self.blockMouseWheel(dialog.find('.scroller'));
      $('#report').block({
        message:dialog,
        centerX:false,
        centerY:false,
        css:{
          position:'fixed',
          top: '50%',
          left: '50%',
          width:dialog.width(),
          'margin-top':dialog.outerHeight() * -0.5,
          'margin-left':dialog.outerWidth() * -0.5,
          cursor:'auto',
          'border-style':'none',
          background: 'transparent'
        },
        overlayCSS:{
          cursor:'auto'
        },
        onBlock: function () {
          dialog.find('.scroller').css({ overflow:'auto' });
        },
        onUnblock: function () {
          self.unblockMouseWheel();
          unblockCompleteHandler();
        }
      });
      return dfd.promise();
    },
    showAreaSelector: function (pglMode) {
      var self = this;
      var dfd = $.Deferred();
      var dialog = $('#dialog-area-selector');
      var unblockCompleteHandler = function () {};
      
      dialog.find('.active').removeClass('active');
      
      if (pglMode) {
        dialog.addClass('pgl-mode');
      } else {
        dialog.removeClass('pgl-mode');
      }
      dialog.find('.scroller').css({ overflow:'hidden' });
      dialog.find('.close').unbind('click').one('click', function () {
        dialog.find('.scroller').css({ overflow:'hidden' });
        unblockCompleteHandler = function () { dfd.reject(); };
        $('#report').unblock();
      });
      dialog.find('li').unbind('click touchstart').one('click touchstart', function () {
        dialog.find('.scroller').css({ overflow:'hidden' });
        var area = $(this).is(':first-child') ? null : $(this).data('area');
        unblockCompleteHandler = function () { dfd.resolve(area); };
        $('#report').unblock();
      });
      dialog.find('.marker').unbind('click touchstart').one('click touchstart', function () {
        dialog.find('.scroller').css({ overflow:'hidden' });
        var area = $(this).data('area');
        unblockCompleteHandler = function () { dfd.resolve(area); };
        $('#report').unblock();
      });
      
      $('#report').block({
        message:dialog,
        centerX:false,
        centerY:false,
        css:{
          position:'fixed',
          top: '50%',
          left: '50%',
          width:dialog.width(),
          'margin-top':dialog.outerHeight() * -0.5,
          'margin-left':dialog.outerWidth() * -0.5,
          cursor:'auto',
          'border-style':'none',
          background: 'transparent'
        },
        overlayCSS:{
          cursor:'auto'
        },
        onBlock: function () {
          dialog.find('.scroller').css({ overflow:'auto' });
        },
        onUnblock: function () {
          self.unblockMouseWheel();
          unblockCompleteHandler();
        }
      });
      self.blockMouseWheel(dialog.find('.scroller'));
      return dfd.promise();
    },
    getScrollMapCoords: function (area) {
      if (area && area.coords) {
        var r = { x:+area.coords[1] / Math.PI * 800 + 800, y:-area.coords[0] / Math.PI * 800 + 400 };
        if (r.x < 1003 / 2) { r.x += 1600; }
        return r;
      } else {
        // ダミー
        return { x:Math.random() * 1600 + 1003 / 2, y:(Math.random() - 0.5) * 200 + 380 };
      }
    },
    getJsonWithCache: function (url) {
      var self = this;
      var cache_key = url;
      if (this._api_cache === undefined) {
        this._api_cache = {};
      }
      var dfd = $.Deferred();
      if (this._api_cache[cache_key]) {
        setTimeout(function () {
          dfd.resolve(self._api_cache[cache_key]);
        }, 0);
      } else {
        $.getJSON(url, { r:new Date().getTime() }).then(function (data) {
          self._api_cache[cache_key] = data;
          dfd.resolve(data);
        }, function (req) {
          self.showDialog(PGL.Text.get('global.error.data_not_exists'), { ok:true });
          dfd.reject(req);
        });
      }
      return dfd.promise();
    },
    getApiWithCache: function (api, params) {
      params = params || {};
      var self = this;
      var cache_key = api + '&' + packParams(params);
      if (this._api_cache === undefined) {
        this._api_cache = {};
      }
      var dfd = $.Deferred();
      if (this._api_cache[cache_key]) {
        setTimeout(function () {
          dfd.resolve(self._api_cache[cache_key]);
        }, 0);
      } else {
        this.getApi(api, params, function (data) {
          self._api_cache[cache_key] = data;
          dfd.resolve(data);
        }, function (req) {
          self.showDialog(PGL.Text.get('global.error.data_not_exists'), { ok:true });
          dfd.reject(req);
        });
      }
      return dfd.promise();
      
      function packParams(params) {
        var keys = [];
        $.each(params, function (key) {
          keys.push(key);
        });
        return $.map(keys.sort(), function (key) {
          return key + '=' + encodeURIComponent(params[key]);
        }).join('&');
      }
    },
    blockMouseWheel: function (scroller) {
      var ty, sy = 0, fc = scroller.children(':first').css({ top:0 });
      if (!window.touchmoveHandler) {
        window.touchmoveHandler = function (event) {
          event.preventDefault();
        };
      }
      if (document.body && document.body.addEventListener) {
        document.body.addEventListener('touchmove', window.touchmoveHandler, true);
      }
      scroller.unbind('touchstart').bind('touchstart', function (e) {
        var touch = e.originalEvent.touches[0];
        ty = touch.pageY;
        fc.css({ position:'absolute' });
      }).unbind('touchmove').bind('touchmove', function (e) {
        var touch = e.originalEvent.touches[0];
        sy += touch.pageY - ty;
        sy = Math.min(0, Math.max(scroller.height() - fc.height(), sy));
        fc.css({ top:sy });
        ty = touch.pageY;
        e.preventDefault();
        scroller.scroll();
      });
      
      // Scroll blocking
      if (true || $.browser.msie) {
        $('body').css({ overflow:'hidden' }); // IE
      }
      /*
      $(window).unbind('mousewheel').mousewheel(function (e) {
        var offset = scroller.offset();
        if (e.pageX > offset.left && e.pageY > offset.top) {
          offset.right = offset.left + scroller.width();
          offset.bottom = offset.top + scroller.height();
          if (e.pageX < offset.right && e.pageY < offset.bottom) {
            var st = scroller.scrollTop();
            var delta = e.wheelDelta || -e.originalEvent.detail;
            if (delta > 0 && st == 0) {
              e.preventDefault(); // Firefox
              return false; // Chrome
            }
            if (delta < 0 && st + scroller.height() >= scroller.children().height()) {
              e.preventDefault();
              return false;
            }
            return true;
          }
        }
        e.preventDefault();
        return false;
      });
      */
      
      $(document.body).unbind('keydown').keydown(function (event) {
        event.preventDefault();
      });
    },
    unblockMouseWheel: function () {
      if (document.body && document.body.removeEventListener) {
        document.body.removeEventListener('touchmove', window.touchmoveHandler, true);
      }
      $('body').css({ overflow:'' });
      //$(window).unbind('mousewheel');
      $(document.body).unbind('keydown');
    }
  });
  
  
})();


PGL.setMain(function () {
  this.init();
});

(function () {
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
  
  var music = '';
  if (navigator.userAgent.match(/iPad|iPhone|iPod|Android/)) {
    //
    window.setMusic = function () {
    };
  } else if (swfobject.hasFlashPlayerVersion('10')) {
    window.setMusic = function (value) {
      if (music != value) {
        music = value;
        var swf = window.sound || document.sound;
        if (swf) {
          try {
            swf.setMusic(value);
          } catch (e) {
          }
        }
      }
    };
  } else {
    try {
      var host = new PGL.Host();
      music = 'gts';
      var musics = {
        gts:new Audio('http://' + host.getPageAssetHost() + '/src/swf/report/sounds/gts.m4a'),
        gbu:new Audio('http://' + host.getPageAssetHost() + '/src/swf/report/sounds/gbu.m4a'),
        pgl:new Audio('http://' + host.getPageAssetHost() + '/src/swf/report/sounds/pgl.m4a')
      };
    } catch (e) {
    }
    $(function () {
      $('body').one('touchstart', function () {
        setMusic(music);
      });
      $('#report-header-gts').click(function () {
        setMusic('gts');
      });
      $('#report-header-gbu').click(function () {
        setMusic('gbu');
      });
      $('#report-header-wifi-competitions').click(function () {
        setMusic('gbu');
      });
      $('#report-header-global-records').click(function () {
        setMusic('pgl');
      });
    });
    window.setMusic = function (value) {
      try {
        //musics[music].pause();
        //musics[music].currentTime = 0;
      } catch (e) {
      }
      music = value;
      try {
        musics[music].loop = true;
        musics[music].play();
      } catch (e) {
      }
    };
  }
  window.getMusic = function () {
    return music;
  };
})();




