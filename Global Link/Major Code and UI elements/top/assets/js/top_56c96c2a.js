$.extend(PGL.prototype, {
  makeLoginPanel: function() {
    var that = this;
    var data = this.data;
    if (this.level >= PGL.NOT_SIGNED_UP) {
      // logged in
      if (this.level >= PGL.TRIAL) {
        PGL.Utils.packText($('#login-control .member-info-pglname').text(data.member.pgl_name));
        $('#login-control .member-info-avatar').append(PGL.Utils.getAvatarImage(data.member.avator_id, 36));

        var unread = this.data.member.unread_mail_count;
        if (unread > 9) unread = '9+';
        if (parseInt(unread)) {
          $('<span></span>').addClass('unread')
            .text(unread)
            .appendTo($('#login-control .login-menu-mailer'));
        }

        var romlink =  $('<a></a>').appendTo($('#login-control .member-info-rom'));
        if (that.data.member.gsid_count <= 1) {
          romlink.attr('href', 'profile/#/register-gsid/')
            .addClass('member-info-rom-register');
        } else {
          romlink.attr('href', 'profile/#/change-rom/')
            .addClass('member-info-rom-change');
        }
        $('#login-control').show();

        var pdw = this.pdw = new PGL.PDW(this.data.member, this.level);
        var pdwStates = pdw.getStates();
        var pdwStatusText = pdwStates.status_top;

        PGL.Utils.packText($('#login-control .member-info-pdw-pokemon').text(pdwStates.pokemon_top));

        if (pdwStates.wakeup_visibility) {
          if (pdwStates.wakeup_enabled) {
            $('#login-control .member-info-pdw-wakeup').click(function() {
              that.wakeup();
              return false;
            });
          } else {
            $('#login-control .member-info-pdw-wakeup').removeAttr('href').addClass('disabled');
          }
        } else {
          $('#login-control .member-info-pdw-wakeup').removeAttr('href').addClass('disabled');

        }
        if (data.member.last_up_time) {
          $('#login-control .member-info-pdw-slepttime').text(data.member.last_up_time);
        }

        $('#pdw-link-message .text').text(pdwStatusText).show();

        this.updatePDWBusyStatus();


//        if (location.host.indexOf('pokemon-gl') == -1) {
//          $('#right-buttons .login-menu-logout').attr({ href:'/index3?p=logout' });
//        }

        var trafficId = data.member.world_id * 12345 - 6789;
        var trafficType = this.level == PGL.TRIAL ? 'trial' : 'product';
        $('#inline-footer-map area:not(area[href])').attr({ href:'/traffic/' + trafficType + '_' + trafficId + '/' });
        
        if (this.level == PGL.TRIAL) {
          $('#login-control .login-menu-mailer, #login-control .login-menu-customize')
            .addClass('disabled')
            .removeAttr('href');
          
          $('.signup-prompt').wrapInner('<span></span>');
          for (var fs=12; $('.signup-prompt span').height() > 190 && fs>=11; fs-=1) {
            $('.signup-prompt').css({ 'font-size':fs });
          }
          for (var lh=150; $('.signup-prompt span').height() > 190; lh-=2) {
            $('.signup-prompt').css({ 'line-height':lh + '%' });
          }
          
          var pt = Math.floor(($('.signup-prompt').height() - $('.signup-prompt span').height()) / 2);
          $('.signup-prompt').css({ 'padding-top':pt, height:$('.signup-prompt').height() - pt });
        }
      }
    } else {
      // not logged in
      var loginUrl;
      if (PGL.language == 'ja') {
        loginUrl = this.host.getPdcLoginUrl();
      } else if (PGL.language == 'ko') {
        loginUrl = this.host.getPkiLoginUrl();
      } else {
        loginUrl= this.host.getComLoginUrl();
      }

      $('#login-control .member-info').empty();
      validateLogin(loginUrl.check).then(function () {
        $('<iframe class="login-frame" border="0" frameborder="0" allowtransparency="true" scrolling="no" marginwidth="0" marginheight="0"></iframe>')
        .attr({ src: loginUrl.form })
        .appendTo($('#login-control'));
      }, function () {
        $('<iframe class="login-frame" border="0" frameborder="0" allowtransparency="true" scrolling="no" marginwidth="0" marginheight="0"></iframe>')
        .attr({ src: 'http://' + that.host.getPageAssetHost() + '/src/swf/top/' + PGL.language + '/images/login-unavailable.png' })
        .appendTo($('#login-control'));
      });
      
      if (document.cookie.match(/was_login_failed=(\w+)/)) {
        this.showDialog(PGL.Text.get('pgltop.membership.processing'), { ok:true, auto_link:true });
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
    
    function validateLogin(checkUrl) {
      checkUrl = $.makeArray(checkUrl);
      var dfd = $.Deferred();
      loadNext();
      return dfd.promise();
      function loadNext() {
        if (checkUrl.length) {
          $('<img/>').attr({ src: checkUrl.shift() + '?now=' + new Date().getTime() }).load(loadNext).error(function () {
            dfd.reject();
          });
        } else {
          dfd.resolve();
        }
      }
    }
  },
  handleTopIndex: function(data) {
    var that = this;
    if (typeof data != 'object') return;
    
    $('#pgl-member-count .value').text(this.formatNumber(data.stats.pgl_population));
    
    var member = this.data.member;
    if (data.information && member) {
      var showBox = function () {
        var box = that.showInfoBox(8, '', PGL.Text.get('pgltop.personal_message.title'), false, '/top/assets/images/info-default/message.png', '#', true);
        box.children('a').click(function () {
          that.showInfoDialog(8, PGL.Text.get('pgltop.personal_message.title'), data.information.information);
        });
        that.triggerAdjustNewsGrid();
      };
      var hash = this.host.getHash(data.information.information, 0x1000000);
      var match = document.cookie.match(new RegExp('personal-info-hash-' + member.member_id + '=(\\d+)'));
      if (match && match[1] == hash) {
        showBox();
      } else {
        var cookie = 'personal-info-hash-' + member.member_id + '=' + hash + ';';
        cookie += 'path=/;'
        var domain = location.hostname.replace(/^[-\w]+\.([-\w]+\.[-\w]+)$/, '$1');
        if (domain != location.hostname) {
          cookie += 'domain=' + domain + ';';
        }
        var expires = new Date(); expires.setTime(expires.getTime() + 365 * 24 * 60 * 60 * 1000);
        cookie += 'expires=' + expires.toGMTString() + ';';
        document.cookie = cookie;
        that.showInfoDialog(8, PGL.Text.get('pgltop.personal_message.title'), data.information.information, null, null).then(showBox, showBox);
      }
    }
  },
  formatNumber: function (num) {
    var r = '' + num;
    var separator = { ja:',', en:',', fr:' ', it:'.', de:' ', es:' ', ko:',' }[PGL.language];
    return r.replace(/([0-9]+?)(?=(?:[0-9]{3})+(?:$|\.))/g, '$1' + separator);
  },
  makeContentsLink: function () {
    // insert PDW button + Campaign button
    if (this.level < PGL.TRIAL) {
      $('.content-link').not('#support').remove();
    }
    
    $('.content-link').each(function (index, clink) {
      $('<li></li>').addClass('box').append($(clink)).appendTo('#information ul');
      
      var cap = $(this).find('.caption');
      if (cap.length == 0) {
        return;
      }
      var text = cap.text();
      var sep = PGL.language == 'ja' || PGL.language == 'ko' ? /(?=[^。ー])/ : ' ';
      var sep2 = PGL.language == 'ja' || PGL.language == 'ko' ? '' : ' ';
      
      var styles = [
        { 'font-size':11 },
        { 'font-size':10 },
        //{ 'font-size':9, '-webkit-text-size-adjust':'none' },
        { 'letter-spacing':-1 },
        { 'line-height':'100%' },
        { 'line-height':'90%' }
      ];
      $.each(styles, function (index, style) {
        var t = text.split(sep);
        cap.empty().css(style);
        for (var j=0; j<10 && t.length; j++) {
          var line = $('<span>a</span>').css({ 'white-space':'nowrap' }).appendTo(cap);
          var y = line.offset().top - $(clink).offset().top - 90;
          var w = Math.sqrt(Math.pow(76, 2) - Math.pow(y, 2)) * 2;
          for (var i=t.length; i>=0; i--) {
            if (i == 0) {
              return;
            }
            line.text(t.slice(0, i).join(sep2));
            if (line.width() < w) {
              line.css({ display:'block', width:w, margin:'0 auto' });
              t = t.slice(i);
              break;
            }
          }
        }
        return false;
      })
      
    });
  },
  makeNewsGrid: function(data) {
    var that = this;
    that.newsLoading = false;
    $('#information .loading').fadeOut(200);
    
    var ul = $('#information ul');
    var first = ul.find('li').length == 0;
    if (!data.length || data.length < PGL.NEWS_COUNT) this.newsLoadedAll = true;
    
    $.each(data, function(index, news) {
      if (news.filename_top) {
        var image = 'http://' + that.host.getCmsImageHost() + '/src/swf/information/assets/' + PGL.language + '/img' + news.filename_top;
      } else {
        var image = '/top/assets/images/info-default/' + news.news_category_id + '.png';
      }
      var box = that.showInfoBox(news.news_category_id, news.date, news.title, news.new_flag, image, '/#/information/' + news.news_id);
      var link = box.children('a');
      link.addClass('news-' + news.news_id);
      if (news.url_flag == 1 && news.description == '') {
        link.attr({ href:news.url, target:news.url_link_type == 2 ? '_blank' : '_self' });
      } else {
        link.click(function() {
          location.hash = '#/information/' + news.news_id;
          var linkOptions = null;
          if (news.url_flag == 1) {
            linkOptions = { url:news.url, target:news.url_link_type == 2 ? '_blank' : '_self' };
          }
          that.showInfoDialog(news.news_category_id, news.title, news.description, linkOptions, news.filename, function() {
            location.hash = '#/';
          });
          return false;
        });
      }
    });
    
    this.adjustNewsGrid();
    $(window).resize($.proxy(this.triggerAdjustNewsGrid, this));
    $(window).scroll($.proxy(this.triggerCheckNewsOverflow, this));
    $(window).resize(function () {
      $('#map-container').css({ width:Math.max(1003, $(window).width()) + 1600 });
    }).resize();
    
    
    // DEBUG:
    if (navigator.userAgent.indexOf('SonyEricssonSO-01B') != -1) {
      var ary = [];
      ary.push('width=' + $(window).width());
      ary.push('innerWidth=' + window.innerWidth);
      if (document.documentElement) {
        ary.push('documentElement.clientWidth=' + document.documentElement.clientWidth);
      }
      if (document.body) {
        ary.push('body.clientWidth=' + document.body.clientWidth);
      }
      alert(ary.join(', '));
      prompt('', ary.join(', '));
    }
    
    
    var match = /^#\/information\/(\d+)/.exec(location.hash);
    if (match) {
      if (!$('.dialog-information').is(':visible')) {
        $('.news-' + match[1]).trigger('click');
      }
    }
  },
  showInfoBox: function (category, date, title, newFlag, image, url, top) {
    var link = $('<a></a>').attr({ href:url })
      .addClass('information-category-' + category)
      .css({ display:'block', 'background-image':'url(' + image + ')' })
      .append($('<span class="information-icon"></span>'));
    if (newFlag) {
      $('<span class="information-icon-new"></span>').appendTo(link);
    }
    $('<span class="date"></span>').text(date).appendTo(link);
    $('<span class="title"></span>').text(title).appendTo(link);
    var box = $('<li></li>').addClass('box information').append(link);
    if (top) {
      box.insertAfter($('#information .box:not(.information):last'));
    } else {
      box.appendTo('#information ul');
    }
    
    link.find('.title').wrapInner('<span></span>');
    for (var lh=1.2; lh > 0.9 && link.find('.title span').height() > 42; lh-=0.1) {
      link.find('.title').css({ 'line-height':lh });
    }
    return box;
  },
  showInfoDialog: function (category, title, body, linkOptions, image) {
    var that = this;
    var dialog = $('<div class="dialog-information"></div>').css({ width:765 }).addClass('information-category-' + category);
    var dialogHead = $('<div class="dialog-information-head"></div>').appendTo(dialog);
    var dialogBody = $('<div class="dialog-information-body"></div>').appendTo(dialog);
    
    var catName = 'pgltop.info.types.' + { 8:2, 9:3, 10:4, 11:6, 12:5, 13:7, 14:8, 15:9, 16:10, 17:11 }[category];
    
    $('<h3 class="title"></h3>').text(title).appendTo(dialogHead);
    $('<div class="category"></div>').text(PGL.Text.get(catName || '')).appendTo(dialogHead).squeezeText();
    $('<div class="close"></div>').click(function () {
      that.hidePopup();
    }).appendTo(dialogHead);
    var desc = $('<div class="description"></div>').appendTo(dialogBody);
    $.each(body.split('\n'), function (index, line) {
      if (line.match(/^\s*$/)) {
        $('<p>　</p>').appendTo(desc);
      } else {
        $('<p></p>').text(line).appendTo(desc);
      }
    });
    
    if (linkOptions) {
      var link = $('<a class="dialog-buttons-details"></a>')
        //.text(PGL.Text.get('pgltop.information.detail_link'))
        .attr({ href:linkOptions.url, target:linkOptions.target })
        .appendTo($('<div class="dialog-buttons"></div>').appendTo(dialog));
    }
    if (image) {
      dialog.addClass('has-image');
      var dialogImage = $('<div class="dialog-information-image"></div>').insertBefore(dialogBody);
      $('<img/>').attr({ src:'http://' + that.host.getCmsImageHost() + '/src/swf/information/assets/' + PGL.language + '/img' + image }).appendTo(dialogImage);
    }
    return that.showPopup(dialog, { html:true }, { left:240, 'margin-left':0 });
  },
  triggerAdjustNewsGrid: function() {
    var that = this;
    if (this.timer) {
      clearTimeout(this.timer);
    }
    this.timer = setTimeout($.proxy(this.adjustNewsGrid, this), 200);
  },
  triggerCheckNewsOverflow: function() {
    var that = this;
    if (this.timer2) {
      clearTimeout(this.timer2);
    }
    this.timer2 = setTimeout($.proxy(this.checkNewsOverflow, this), 200);
  },
  adjustNewsGrid: function() {
    var that = this;
    this.newsOffset = this.newsOffset || 0;
    var leftMargin = 90;
    var grid = 190;
    var rowcount = Math.floor(($(window).width() - leftMargin) / grid);
    if (rowcount < 5) rowcount = 5;
    var speed = 190;

    $('#right-buttons').css({ top:0 }).transition({ left:grid * (rowcount - 1) + leftMargin }, speed);
    
    var positions = [];
    (function () {
      var blanks = that.level < PGL.TRIAL ? [ [4, 1], [4, 0], [4, 0] ] : [ [1, 1], [4, 0], [4, 0], [4, 0] ];
      var x = blanks[0][0], y = 0;
      $('#information li.box').each(function (index, box) {
        if (x >= rowcount - (blanks[y] ? blanks[y][1] : 0)) {
          y++;
          x = blanks[y] ? blanks[y][0] : 0;
        }
        positions.push({ x:x, y:y });
        x++;
      });
      // create row2 for report
      if (y == 0) {
        y++;
        x = blanks[y] ? blanks[y][0] : 0;
        positions.push({ x:x, y:y });
      }
    })();
    
    var pos, delay = 0;
    $('#information li.box').each(function (index, box) {
      if ($(box).children('#report-link').length) {
        for (var i=0; i<positions.length; i++) {
          if (positions[i].x <= 4 && positions[i].y > 0) {
            pos = positions.splice(i, 1)[0];
            break;
          }
        }
      } else {
        pos = positions.shift();
      }
      var left = grid * pos.x + leftMargin;
      var top = grid * pos.y + 10;
      
      if (parseInt($(box).css('left')) != left || parseInt($(box).css('top')) != top) {
        $(box).stop(true, false).delay(delay).transition({ top:top }, speed).animate({ left:left }, speed);
        delay += 80;
      }
    });
    
    var minHeight = Math.max(grid * pos.y + 15 + 210, $('#login-control').height() + 30, this.isLoggedIn() ? 795 : 605);
    $('#main').stop(true, true).delay(delay).transition({ height:minHeight }, speed);
    this.checkNewsOverflow();
  },
  checkNewsOverflow: function() {
    if (this.newsLoadedAll || this.newsLoading) {
      return true;
    }
    var that = this;
    var winBottom = $(window).height() + $(window).scrollTop();
    var lastelem = $('#information li.box').last();
    lastelem.queue(function () {
      if (lastelem.offset().top < winBottom - 170) {
        $('#information .loading').fadeIn(200);
        setTimeout(function () {
          that.getApi('pgl.news.news_list', {type: 1, offset: that.newsOffset, rowcount: PGL.NEWS_COUNT}, $.proxy(that.makeNewsGrid, that));
          that.newsOffset += PGL.NEWS_COUNT;
          that.newsLoading = true;
        }, 1000);
      }
      $(this).dequeue();
    });
  },
  updatePDWBusyStatus: function() {
    this.pdw.getBusyStatus(function(data) {
      $('#pdw-link-badge')
        .removeClass('busy-status-0')
        .removeClass('busy-status-1')
        .removeClass('busy-status-2')
        .addClass('busy-status-' + data.condition)
        .show();
      }
    );
    this.pdw.updateLinkMessage(this.data.member.nextstart_remaintime);
    setTimeout($.proxy(this.updatePDWBusyStatus, this), 60 * 1000);
  },
  onPDWClick: function() {
    if (this.level == PGL.NOT_SIGNED_UP) {
      this.showDialog(PGL.Text.get('new_pdwstart_1'), { ok:true }); // 非会員
      return false;
    } else if (this.level == PGL.INTERIM_REGISTERED) {
      this.show_dialog(PGL.Text.get('dialog_29'), { ok:true }); // 仮登録
      return false;
    } else {
      var that = this;
      var memberdata  = this.data.member;
      var remains      = memberdata.nextstart_remaintime - this.pdw.getElapsed();
      var can_re_enter = remains > PGL.PDW.INTERMISSION - PGL.PDW.RE_ENTER_DURATION;
      var can_enter    = remains <= 0;
      
      if (can_re_enter) {
        return true;
      } else if (can_enter) {
        this.pdw.getBusyStatus(function (data) {
          if (data.is_over_capacity == '1') {
            that.showDialog(PGL.Text.get('pgltop.pdw.busy'), { ok: true });
          } else {
            location = '/pdw/';
          }
        });
      } else {
        var text;
        if (remains <= 60) {
          text = PGL.Text.get('pgltop.pdw.denied.3');
        } else if (remains <= 3600) {
          text = PGL.Text.get('pgltop.pdw.denied.2').replace(/\[mm2\]/, Math.ceil(remains / 60));
        } else {
          text = PGL.Text.get('pgltop.pdw.denied.1').replace(/\[hh2\]/, Math.ceil(remains / 3600));
        }
        
        var date = new Date();
        date.setTime((parseInt(memberdata.last_started_at_timezone) + 9 * 60 * 60) * 1000);
        var repl = {
          MM: date.getUTCMonth() + 1,
          DD: date.getUTCDate(),
          hh: PGL.Utils.zerofill(date.getUTCHours(), 2),
          mm: PGL.Utils.zerofill(date.getUTCMinutes(), 2)
        };
        text = text.replace(/\[(MM|DD|hh|mm)\]/g, function (match, code) {
          return repl[code];
        });
        
        var dialogOptions = { ok:true };
        if (this.pdw.getStates().wakeup_enabled) {
          dialogOptions.wakeup = $.proxy(this.wakeup, this); // ポケモンを起こせるなら「起こす」ボタンを出して
        }
        this.showDialog(text, dialogOptions); // アクセス受付時間前ダイアログを表示
      }
    }
    return false;
  }
});

$.extend(PGL.PDW.prototype, {
  updateLinkMessage: function(remaintime) {
    var remains = remaintime - this.getElapsed();
    var can_re_enter = remains > PGL.PDW.INTERMISSION - PGL.PDW.RE_ENTER_DURATION;
    var can_enter    = remains <= 0;
    if (can_enter || can_re_enter) {
//      $('#pdw-link-message .text').text(PGL.Text.get('pgltop.accept_time.4')).show();
    } else {
      var text;
      if (remains <= 60) {
        text = PGL.Text.get('pgltop.accept_time.3');
      } else if (remains <= 3600) {
        text = PGL.Text.get('pgltop.accept_time.2').replace(/\[MM\]/, Math.ceil(remains / 60));
      } else {
        text = PGL.Text.get('pgltop.accept_time.1').replace(/\[HH\]/, Math.ceil(remains / 3600));
      }
//      $('#pdw-link-message .text').text(text).show();
    }


  },
  getBusyStatus: function(callback) {
    if (this.level >= PGL.TRIAL) {
      var url;
      var id = this.member.world_id * 12345 - 6789;
      if (this.level == PGL.TRIAL) {
        url = '/traffic/trial_' + id + '/status.json';
      } else {
        url = '/traffic/product_' + id + '/status.json';
      }
      $.getJSON(url, { time:new Date().getTime() }, callback);
      return true;
    }
    return false;
  }
});


// -----------------------------------------------------
PGL.setMain(function() {
  var self = this;
  
  if (!$.support.transition) {
    $.fn.transition = $.fn.animate;
  }
  
  this.makeLoginPanel();
  $('#information ul').empty();
  this.makeContentsLink();
  // TODO: make getApi deferred + insert private news into the top of list
  this.getApi('pgl.top.index',{}, $.proxy(this.handleTopIndex, this));
  this.newsOffset = this.newsOffset || 0;
  this.getApi('pgl.news.news_list', {type: 1, offset: this.newsOffset, rowcount: PGL.NEWS_COUNT}, $.proxy(this.makeNewsGrid, this));
  // wifi status
  if (this.level >= PGL.TRIAL) {
    this.getApi('pgl.member.profile.my_gbu_profile', {}, function(data) {
      $('#wifi-link-message .text').text(PGL.Utils.getWordlbattleStatusText(data.worldbattle_status));
      
      // ticker
      $('.ticker').each(function() {
        var t = $(this);
        var text = $('.text', this);
        var text2 = $('.text', this).clone().appendTo(t);
        var len = text.text().length * 14;
        t.css({position: 'relative'});
        text.css({position: 'absolute', width: len, top: 0, left: 0});
        text2.css({position: 'absolute', width: len, top: 0, left: len + 50});
        var move = function() {
          $.each([text, text2], function(idx, tx) {
            var c = parseInt(tx.css('left')) || 0;
            if (c < - len) c = 50 + len + 50;
            tx.css('left',  (c - 1) + 'px');
          });
          t.data({ iid:setTimeout(move, 20) });
        };
        move();
      });
    });
  }
  this.newsOffset += PGL.NEWS_COUNT;
  this.newsLoading = true;
  
  
  $('#pdw a').click($.proxy(this.onPDWClick, this));
  
  if (navigator.userAgent.match(/iPad|iPhone|iPod|Android/)) {
    //
  } else if (swfobject.hasFlashPlayerVersion('9')) {
    $('<div id="sound"></div>').appendTo(document.body);
    swfobject.embedSWF('/top/assets/swf/sound.swf', 'sound', '1', '1', '9.0.0');
  } else if (window.Audio) {
    /*
    try {
      var audio = new Audio('http://' + this.host.getPageAssetHost() + '/src/swf/report/sounds/pgl.m4a');
      var playAudio = function () {
        try {
          audio.loop = true;
          audio.play();
        } catch (e) {
        }
      };
      playAudio();
    } catch (e) {
    }
    $(function () {
      $('body').one('touchstart', function () {
        playAudio();
      });
    });
    */
  }
  
  
  
  // report
  (function () {
    // 時間に応じた世界地図
    var utcHours = (new Date()).getUTCHours();
    var host = new PGL.Host();
    $('#map').css({ 'background-image':'url(http://' + host.getPageAssetHost() + '/src/swf/report/images/earth/' + utcHours + '.jpg)' });
    $('#map-container').css({ 'background-position':utcHours / 24 * -1600 });
  })();
  
  var paper = Raphael($('#map-canvas').get(0), 1600 + 670 * 2 + 10, 800);
  $('#map-canvas').data({ paper:paper });
  PGL.Report.extendRaphael(paper);
  $.extend(paper.customAttributes, {
    recordsCircle: function (x, y, r, c, l, aa) {
      var p = [];
      for (var i=0; i<c; i++) {
        var a = Math.PI * 2 * i / c + aa;
        p.push(['M', x + Math.cos(a) * r, y + Math.sin(a)* r]);
        p.push(['l', Math.cos(a) * -l, Math.sin(a)* -l]);
      }
      return { path:p };
    },
    gbuBattleLine2: function (x1, y1, x2, y2, prog, mask) {
      var dx = (x2 - x1) / 2, dy = (y2 - y1) / 2;
      if (mask) {
        var d = Math.sqrt(dx * dx + dy * dy);
        if (d <= mask) {
          dx = dy = 0;
        } else {
          dx *= 1 - mask / d;
          dy *= 1 - mask / d;
        }
      }
      return { path:[
        ['M', x1, y1],
        ['l', dx * prog, dy * prog]
      ] };
    }
  });
  
  var reportAnimations = [];
  var reportLoadDelayList = (function (ary) {
    for (var i=ary.length; i; i--) {
        var j = Math.floor(Math.random() * i);
        var t = ary[i - 1];
        ary[i - 1] = ary[j];
        ary[j] = t;
    }
    return ary;
  })([0, 5000, 10000]);
  
  // GTSここから
  setTimeout(function () {
    self.getApi('gts.journal.trade_list', {}, function (data) {
      data.trade_list = $.grep(data.trade_list, function (trade) {
        var c1 = getScrollMapCoords(PGL.Report.areasByGTS[trade.trade1.country_id]);
        var c2 = getScrollMapCoords(PGL.Report.areasByGTS[trade.trade2.country_id]);
        return c1 && c2 && true;
      });
      
      var tradeIndex = Math.floor(Math.random() * data.trade_list.length);
      var animCount;
      
      if (data.trade_list.length) {
        registerReportAnimation(function () {
          animCount = 0;
          $('#report-gts').slideDown(300, showTradeChain);
        });
      }
      function showTradeChain() {
        showTrade().then(function () {
          if (animCount >= 5) {
            $('#report-gts').slideUp(300, switchReportAnimation);
          } else {
            setTimeout(showTradeChain, 500);
          }
        });
        animCount++;
      }
      
      function showTrade() {
        var dfd = $.Deferred();
        var trade = data.trade_list[tradeIndex];
        tradeIndex = (tradeIndex + 1) % data.trade_list.length;
        
        // 出す順番をランダムに決定
        var deposits = Math.random() < 0.5 ? [ trade.trade1, trade.trade2 ] : [ trade.trade2, trade.trade1 ];
        var pos1 = getScrollMapCoords(PGL.Report.areasByGTS[deposits[0].country_id]); // 先
        var pos2 = getScrollMapCoords(PGL.Report.areasByGTS[deposits[1].country_id]); // 後
        
        $('#map .gts-area').remove();
        var area1 = $('<div class="gts-area"></div>').appendTo('#map').css({ left:pos1.x - 100, top:pos1.y + 10 }).text(deposits[0].country_name);
        var area2 = $('<div class="gts-area"></div>').appendTo('#map').css({ left:pos2.x - 100, top:pos2.y + 10 }).text(deposits[1].country_name);
        
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
        
        if (pos1.x < pos2.x) {
          // 左から右
          var elem1 = $('#trade-deposit-1'), elem2 = $('#trade-deposit-2');
        } else {
          // 右から左
          var elem1 = $('#trade-deposit-2'), elem2 = $('#trade-deposit-1');
        }
        
        paper.clear();
        var pathObj = paper.path('').attr({ stroke: '#78E82C', 'stroke-width':4, 'stroke-dasharray':['-'] });
        var ball = paper.image('/report/assets/images/gts-trade-ball.png', 0, 0, 24, 24).attr({ opacity:0 });
        var mainDuration = Math.abs(pos1.x - pos2.x) * 0.5 + 1300;
        
        var mapTop = 80 - (self.level > PGL.NOT_LOGGED_IN ? 0 : 190);
        elem1.hide();
        elem2.hide();
        
        $('#map-container')
          .stop(true, true)
          .transition({ left:-pos1.x + (pos1.x < pos2.x ? 370 : 750), top:mapTop - pos1.y }, 700) // 第一の場所へ
          .queue(function () {
            area1.fadeIn(300);
            area2.fadeIn(300);
            elem1.show();
            showDeposit(elem1.find('.pokemon'), deposits[0]);
            elem1.hide().slideDown(200);
            $(this).dequeue();
          })
          .delay(200)
          .queue(function () {
            pathObj.attr({ gtsTradeLine:[pos1.x, pos1.y, pos2.x, pos2.y, 0.2, 1, 0] })
              .animate({ gtsTradeLine:[pos1.x, pos1.y, pos2.x, pos2.y, 0.2, 1, 2] }, mainDuration * 2);
            ball.attr({ gtsTradePoint:[pos1.x - 12, pos1.y - 12, pos2.x - 12, pos2.y - 12, 0.2, 0], opacity:1 })
              .animate({ gtsTradePoint:[pos1.x - 12, pos1.y - 12, pos2.x - 12, pos2.y - 12, 0.2, 1] }, mainDuration);
            $(this).dequeue();
          })
          .transition({ left:-pos2.x + (pos1.x < pos2.x ? 750 : 370), top:mapTop - pos2.y }, mainDuration)
          .queue(function () {
            ball.animate({ opacity:0 }, 400);
            $(this).dequeue();
          })
          .delay(mainDuration + 200)
          .queue(function () {
            elem2.show();
            showDeposit(elem2.find('.pokemon'), deposits[1]);
            elem2.hide().slideDown(200);
            $(this).dequeue();
          })
          .delay(200)
          .queue(function () {
            pathObj.attr({ gtsTradeLine:[pos2.x, pos2.y, pos1.x, pos1.y, 0.2, 1, 0] })
              .animate({ gtsTradeLine:[pos2.x, pos2.y, pos1.x, pos1.y, 0.2, 1, 2] }, mainDuration * 2);
            ball.attr({ gtsTradePoint:[pos2.x - 12, pos2.y - 12, pos1.x - 12, pos1.y - 12, 0.2, 0], opacity:1 })
              .animate({ gtsTradePoint:[pos2.x - 12, pos2.y - 12, pos1.x - 12, pos1.y - 12, 0.2, 1] }, mainDuration);
            $(this).dequeue();
          })
          .transition({ left:-pos1.x + (pos2.x < pos1.x ? 750 : 370), top:mapTop - pos1.y }, mainDuration)
          .queue(function () {
            ball.animate({ opacity:0 }, 400);
            $(this).dequeue();
          })
          .delay(mainDuration + 200)
          .queue(function () {
            area1.fadeOut(300);
            area2.fadeOut(300);
            $('#report-gts .trade-deposit').fadeOut(400);
            $(this).dequeue();
            dfd.resolve();
          });
        return dfd.promise();
      }
      function showDeposit(target, deposit) {
        target.pokemon({ pokedex:deposit.monsno, form:deposit.form_no, level:deposit.poke_level, sex:deposit.sex });
        target.find('.name .value').text(deposit.pokename);
        target.find('.iso-3166-1 .value').text(PGL.Report.areasByGTS[deposit.country_id].iso3166);
      }
    });
  }, reportLoadDelayList.pop());
  // GTSここまで
  
  // GBUここから
  setTimeout(function () {
    $.getJSON('/swf/json/' + (PGL.language == 'ja' ? 'battledata.json' : 'battledata_' + PGL.language + '.json'), { r:new Date().getTime() }).then(function (data) {
      // uniform API responce format
      if (data.battle_history_list === undefined) {
        data = { battle_history_list:data };
      }
      data.battle_history_list = $.grep(data.battle_history_list, function (battle) {
        var c1 = getScrollMapCoords(PGL.Report.areasByPGL[battle.player1.country_id]);
        var c2 = getScrollMapCoords(PGL.Report.areasByPGL[battle.player2.country_id]);
        return c1 && c2 && true;
      });
      if (data.battle_history_list.length == 0) {
        return;
      }
      
      var battleIndex = Math.floor(Math.random() * data.battle_history_list.length);
      var animCount;
      
      registerReportAnimation(function () {
        animCount = 0;
        $('#report-gbu').slideDown(300, showBattleChain);
      });
      function showBattleChain() {
        showBattle().then(function () {
          if (animCount >= 5) {
            $('#report-gbu').slideUp(300, switchReportAnimation);
          } else {
            setTimeout(showBattleChain, 500);
          }
        });
        animCount++;
      }
      
      function showBattle() {
        var dfd = $.Deferred();
        var battle = data.battle_history_list[battleIndex];
        battleIndex = (battleIndex + 1) % data.battle_history_list.length;
        
        // 勝敗
        battle.player1.result = ['lose', 'win', 'draw'][battle.result % 3];
        battle.player2.result = ['win', 'lose', 'draw'][battle.result % 3];
        
        if (battle.shooter_flag == '1') {
          $('#report-gbu-format .name').text(PGL.Text.get('global.gbu.shooter_battle'));
        } else {
          var t = ['single', 'double', 'triple', 'rotation'][battle.regulation];
          $('#report-gbu-format .name').text(PGL.Text.get('global.gbu.' + t + '_battle'));
        }
        $('#report-gbu-format').hide();
        
        // 出す順番をランダムに決定
        var players = Math.random() < 0.5 ? [ battle.player1, battle.player2 ] : [ battle.player2, battle.player1 ];
        var pos1 = getScrollMapCoords(PGL.Report.areasByPGL[players[0].country_id]); // 先
        var pos2 = getScrollMapCoords(PGL.Report.areasByPGL[players[1].country_id]); // 後
        
        paper.clear();
        var pathObj = paper.path('').attr({ stroke: '#78E82C', 'stroke-width':4, 'stroke-dasharray':['-'] });
        var mainDuration = Math.abs(pos1.x - pos2.x) * 0.75 + 600;
        var circle1 = paper.circle(pos1.x, pos1.y, 0).attr({ fill:'#FF2905', stroke:'none' });
        var circle2 = paper.circle(pos2.x, pos2.y, 0).attr({ fill:'#00E9FE', stroke:'none' });
        var line1, line2;
        
        var mapTop = 80 - (self.level > PGL.NOT_LOGGED_IN ? 0 : 190);
        $('#battle-user').hide();
        
        $('#map-container')
          .stopAll()
          .transition({ left:560 - (pos1.x + pos2.x) / 2, top:mapTop - (pos1.y + pos2.y) / 2 }, mainDuration)
          .queue(function () {
            $('#report-gbu-format').slideDown(200);
            circle1.animate({ r:10 }, 400, 'backOut');
            circle2.animate({ r:10 }, 400, 'backOut');
            var dx = (pos2.x - pos1.x) / 2, dy = (pos2.y - pos1.y) / 2;
            line1 = paper.path('').attr({ stroke:'#FF2905', 'stroke-width':2, gbuBattleLine2:[pos1.x, pos1.y, pos2.x, pos2.y, 0, 0] })
              .animate({ gbuBattleLine2:[pos1.x, pos1.y, pos2.x, pos2.y, 1, 0] }, 700, 'easeIn');
            line2 = paper.path('').attr({ stroke:'#00E9FE', 'stroke-width':2, gbuBattleLine2:[pos2.x, pos2.y, pos1.x, pos1.y, 0, 0] })
              .animate({ gbuBattleLine2:[pos2.x, pos2.y, pos1.x, pos1.y, 1, 0] }, 700, 'easeIn');
            $(this).dequeue();
          })
          .delay(700)
          .queue(function () {
            var cx = (pos2.x + pos1.x) / 2, cy = (pos2.y + pos1.y) / 2;
            var r = Math.atan2(pos2.y - pos1.y, pos2.x - pos1.x);
            var pi = Math.PI;
            line1.animate({ gbuBattleLine2:[pos1.x, pos1.y, pos2.x, pos2.y, 1, 75] }, 700, 'backOut');
            line2.animate({ gbuBattleLine2:[pos2.x, pos2.y, pos1.x, pos1.y, 1, 75] }, 700, 'backOut');
            paper.path('').attr({ fill:'#FF2905', stroke:'none' })
              .attr({ pie:[cx, cy, r + pi * -2.5, r + pi * -0.5, 0, 0] })
              .animate({ pie:[cx, cy, r + pi * 0.5, r + pi * 1.5, 75, 74] }, 700, 'backOut');
            paper.path('').attr({ fill:'#00E9FE', stroke:'none' })
              .attr({ pie:[cx, cy, r + pi * -0.5, r + pi * 0.5, 0, 0] })
              .animate({ pie:[cx, cy, r + pi * 1.5, r + pi * 2.5, 75, 74] }, 700, 'backOut');
            paper.path('').attr({ fill:'#FF2905', stroke:'none' })
              .attr({ pie:[cx, cy, r + pi * -1.5, r + pi * -0.5, 0, 0] })
              .animate({ pie:[cx, cy, r + pi * 0.5, r + pi * 1.5, 72.5, 64] }, 700, 'backOut');
            paper.path('').attr({ fill:'#00E9FE', stroke:'none' })
              .attr({ pie:[cx, cy, r + pi * -0.5, r + pi * 0.5, 0, 0] })
              .animate({ pie:[cx, cy, r + pi * 1.5, r + pi * 2.5, 72.5, 64] }, 700, 'backOut');
            paper.circle(cx, cy, 0).attr({ fill:'#000', stroke:'none', opacity:0.8 })
              .animate({ r:64 }, 700, 'backOut');
            paper.text(cx, cy - 3, 'VS.').attr({ fill:'#FF2905', stroke:'none', 'font-size':50 });
            paper.text(cx, cy + 27, PGL.Utils.formatTime(battle.battleDateTime)).attr({ fill:'#FF2905', stroke:'none', 'font-size':11 });
            $(this).dequeue();
          })
          .delay(1000)
          .transition({ left:-pos1.x + (pos1.x < pos2.x ? 370 : 750), top:mapTop - pos1.y }, 700) // 第一の場所へ
          .queue(function () {
            circle1.animate({ r:18 }, 300, 'easeOut').animate();
            setTimeout(function () {
              circle1.animate({ r:10 }, 300, 'easeIn').animate();
            }, 3200);
            $('#battle-user').show();
            showBattleUser($('#battle-user'), players[0]);
            $('#battle-user').hide().slideDown(200).delay(3000).slideUp(200);
            $(this).dequeue();
          })
          .delay(3400)
          .transition({ left:-pos2.x + (pos1.x < pos2.x ? 750 : 370), top:mapTop - pos2.y }, mainDuration)
          .queue(function () {
            circle2.animate({ r:18 }, 300, 'easeOut').animate();
            setTimeout(function () {
              circle2.animate({ r:10 }, 300, 'easeIn').animate();
            }, 3200);
            $('#battle-user').show();
            showBattleUser($('#battle-user'), players[1]);
            $('#battle-user').hide().slideDown(200).delay(3000).slideUp(200);
            $(this).dequeue();
          })
          .delay(3400)
          .queue(function () {
            $('#report-gbu-format').slideUp(200);
            $('#report-gts .trade-deposit').fadeOut(400);
            $(this).dequeue();
            dfd.resolve();
          });
        return dfd.promise();
      }
      function showBattleUser(target, user) {
        target.attr({ 'class':user.result });
        target.find('.result').squeezeText(PGL.Text.get('global.gbu.' + user.result));
        target.find('.avatar').empty().append($('<img/>').attr({ src:'/profile/assets/images/avatar/' + user.avator_id + '.png' }));
        target.find('.pglname').text(user.nickName);
        target.find('.country').text(PGL.Report.areasByPGL[user.country_id].iso3166);
        target.find('.rating .value').text(user.rating);
        target.find('.ranking .value').text(user.rank || '-');
        target.find('.trainername .value').html(PGL.Utils.renderDSFont('ds-font-5', user.trainerName));
      }
    });
  }, reportLoadDelayList.pop());
  // GBUここまで
  
  // 調査隊ここから
  setTimeout(function () {
    self.getApi('pgl.journal.census', {}, function (data) {
      if (data.census_list.length == 0) {
        return;
      }
      
      var censusIndex = Math.floor(Math.random() * data.census_list.length);
      var census;
      var recordIndex = 0;
      var animCount;
      
      registerReportAnimation(function () {
        animCount = 0;
        census = data.census_list[censusIndex];
        censusIndex = (censusIndex + 1) % data.census_list.length;
        recordIndex = 0;
        $('#report-records').slideDown(300, showRecordChain);
        $('#report-records-title .name').squeezeText(census.lead);
      });
      function showRecordChain() {
        showRecord().then(function () {
          if (animCount >= 5) {
            $('#report-records').slideUp(300, switchReportAnimation);
          } else {
            setTimeout(showRecordChain, 500);
          }
        });
        animCount++;
      }
      
      function showRecord() {
        var dfd = $.Deferred();
        var record = census.ranking_list[recordIndex];
        recordIndex = (recordIndex + 1) % census.ranking_list.length;
        
        var area = PGL.Report.areasByPGL[record.country_id];
        var pos = getScrollMapCoords(area);
        var mostSlept = PGL.Report.getPokemonByPokedex(record.pokemon_no);
        
        paper.clear();
        //var circle1 = paper.circle(pos1.x, pos1.y, 0).attr({ fill:'#FF2905', stroke:'none' });
        //var circle2 = paper.circle(pos2.x, pos2.y, 0).attr({ fill:'#00E9FE', stroke:'none' });
        
        var mapTop = 80 - (self.level > PGL.NOT_LOGGED_IN ? 0 : 190);
        //$('#battle-user').hide();
        
        $('#report-records .census-result').recordResult(record.label || '');
        $('#report-records .area').show();
        $('#report-records .area .name').text(area.names[PGL.language] || '').squeezeText();
        $('#report-records .area .iso-3166-1').text(area.iso3166);
        $('#report-records .area').hide();
        $('#report-records .most-slept-pokemon').pokemon({ pokedex:mostSlept.pokedex });
        $('#report-records .most-slept-pokemon .footprint img').attr({ src:'/report/assets/images/footprint/' + ('00' + mostSlept.pokedex).substr(-3) + '.png' });
        
        var d = new Date();
        d.setTime(d.getTime() + area.tz.offset * 60 * 60 * 1000);
        $('#report-records .area .tzname').text(area.tz.name);
        $('#report-records .area .time').text(PGL.Utils.zerofill(d.getUTCHours(), 2) + ':' + PGL.Utils.zerofill(d.getUTCMinutes(), 2));
        //$('#report-records .area .clock').clock(d);
        
        var c1, c2, c3, c4, c5, c6, t1;
        
        $('#map-container')
          .stopAll()
          .transition({ left:560 - pos.x, top:mapTop - pos.y }, 1000)
          .queue(function () {
            c1 = paper.circle(pos.x, pos.y, 0).attr({ stroke:'#FF1E1E', 'stroke-width':2.1 }).animate(Raphael.animation({ r:90 }, 500, 'backOut').delay(40));
            c2 = paper.circle(pos.x, pos.y, 0).attr({ stroke:'#FF1E1E', 'stroke-width':1.2 }).animate(Raphael.animation({ r:86 }, 500, 'backOut'));
            c3 = paper.circle(pos.x, pos.y, 0).attr({ stroke:'#FF1E1E', 'stroke-width':2.3 }).animate(Raphael.animation({ r:79 }, 500, 'backOut').delay(200));
            c4 = paper.path('').attr({ stroke:'#FF1E1E', 'stroke-width':2.3, recordsCircle:[pos.x, pos.y, 0, 24, 0, 0] }).animate(Raphael.animation({ recordsCircle:[pos.x, pos.y, 79, 24, 4, Math.PI] }, 500, 'backOut').delay(200));
            c5 = paper.path('').attr({ stroke:'#FF1E1E', 'stroke-width':1.3, recordsCircle:[pos.x, pos.y, 0, 48, 0, 0] }).animate(Raphael.animation({ recordsCircle:[pos.x, pos.y, 49, 48, 3, -Math.PI] }, 500, 'backOut').delay(300));
            c6 = paper.circle(pos.x, pos.y, 0).attr({ stroke:null, fill:'#FF1E1E' }).animate(Raphael.animation({ r:15 }, 300, 'backOut').delay(800));
            t1 = paper.text(pos.x, pos.y, record.ranking).attr({ stroke:null, fill:'#FFF', 'font-size':16, 'font-weight':'bold', opacity:0 }).animate(Raphael.animation({ opacity:1 }, 300, 'easeOut').delay(800));
            $('#report-records .area').delay(70).fadeIn(250);
            $('#report-records .most-slept-pokemon').delay(270).fadeIn(250);
            $(this).dequeue();
          })
          .delay(6400)
          .queue(function () {
            c1.animate(Raphael.animation({ r:0 }, 500, 'backIn').delay(560));
            c2.animate(Raphael.animation({ r:0 }, 500, 'backIn').delay(600));
            c3.animate(Raphael.animation({ r:0 }, 500, 'backIn').delay(400));
            c4.animate(Raphael.animation({ recordsCircle:[pos.x, pos.y, 0, 24, 0, Math.PI * 2] }, 500, 'backIn').delay(400));
            c5.animate(Raphael.animation({ recordsCircle:[pos.x, pos.y, 0, 48, 0, Math.PI * -2] }, 500, 'backIn').delay(300));
            c6.animate(Raphael.animation({ r:0 }, 800, 'backIn'));
            t1.animate(Raphael.animation({ opacity:0 }, 800, 'easeIn'));
            $(this).dequeue();
          })
          .delay(750)
          .queue(function () {
            $('#report-records .area').fadeOut(250);
            $('#report-records .most-slept-pokemon').delay(200).fadeOut(250);
            $(this).dequeue();
            dfd.resolve();
          });
        return dfd.promise();
      }
      function showBattleUser(target, user) {
        target.attr({ 'class':user.result });
        target.find('.result').text(PGL.Text.get('global.gbu.' + user.result));
        target.find('.avatar').empty().append($('<img/>').attr({ src:'/profile/assets/images/avatar/' + user.avator_id + '.png' }));
        target.find('.pglname').text(user.nickName);
        target.find('.country').text(PGL.Report.areasByPGL[user.country_id].iso3166);
        target.find('.rating .value').text(user.rating);
        target.find('.ranking .value').text(user.rank);
        target.find('.trainername .value').text(user.trainerName);
      }
    });
  }, reportLoadDelayList.pop());
  // 調査隊ここまで
  
  function registerReportAnimation(func) {
    reportAnimations.push(func);
    if (reportAnimations.length == 1) {
      func();
    }
  }
  function switchReportAnimation() {
    reportAnimations.push(reportAnimations.shift());
    setTimeout(reportAnimations[0], 1000);
  }
  function getScrollMapCoords(area) {
    if (area && area.coords) {
      var r = { x:+area.coords[1] / Math.PI * 800 + 800, y:-area.coords[0] / Math.PI * 800 + 400 };
      if (r.x < 670) { r.x += 1600; }
      return r;
    }
  }
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
})();

