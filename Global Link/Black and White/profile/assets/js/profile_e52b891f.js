
(function () {
  var host = new PGL.Host();

  $.fn.extend({
    pokemonImage: function (size, pokedex, form) {
      pokedex = parseInt(pokedex);
      form = parseInt(form || 0);
      var code = PGL.Utils.zerofill((0x159a55e5 * (pokedex + form * 0x10000) & 0xFFFFFF).toString(16), 6);
      this.empty();
      var img = $('<img/>').appendTo(this);
      var size = parseInt(img.css('width'));
      var imagesDir = 'http://' + host.getPageAssetHost() + '/src/swf/assets/global/images/';
      img.attr({ src:imagesDir + 'block.png' });
      img.css({ 'background-position':(parseInt(img.css('width')) / 2) + 'px ' + (parseInt(img.css('height')) / 2) + 'px' });
      img.css({ 'background-image':'url(' + imagesDir + 'pokemons/' + size + '/' + code + '.png)' });
      // fix Android image size issue
      if (navigator.userAgent.indexOf('Android') != -1) {
        img.css({ border:'1px solid transparent' });
      }
      return this;
    }
  });
})();


$.extend(PGL.prototype, {
  makeTabs: function() {
    var selectTab = function(target) {
      $('.tab').hide();
      $('.tab-link').removeClass('selected');
      $('#tab-' + target).addClass('selected');
      $('#' + target).show();
    }
    $('.tab-link').click(function() {
      var id = $(this).attr('id').replace('tab-', '');
      selectTab(id);
      location.hash = id == 'soft' ? '#/' : '#/' + id + '/';
    });
    $('.tab').hide();
    var target = (location.hash && /^#\/.+/.test(location.hash)) ? $('#tabs').find(location.hash.replace(/\//g, '')) : [];
    if (!target.length) target = $('.tab').first();
    selectTab(target.attr('id'));

  },
  makeSidePanel: function(data) {
    if (this.isMyProfile) {
      $('#side .logged-in').show();
    } else {
      $('#back-to-mypage').show();
    }
    $('#avatar').empty().append(PGL.Utils.getAvatarImage(data.avator_id));
    PGL.Utils.packText($('#pglname').text(data.pgl_name));
    PGL.Utils.packText($('#place').text(data.country_name));
    if (this.data.member.gsid_count <= 1) {
      $('#rom-change-button').hide();
    }
    if (this.data.member.gsid_count == 4) {
      $('#gsid-change-button').hide();
    }
  },
  makeDSDataTab: function(data) {
    var that = this;
    $('#soft-synctime').toggle(this.isMyProfile);
    if (this.isMyProfile) {
      if (this.data.member && this.data.member.last_up_time) {
        $('#soft-synctime .value').text(this.data.member.last_up_time);
        (function (target) {
          var iid = setInterval(function () {
            if (target.is(':visible')) {
              clearInterval(iid);
              target.css({ top: 18 - target.height() / 2 });
            }
          }, 100);
        })($('#soft-synctime'));
      }
    }

    var gscd = (this.isMyProfile) ? this.data.member.gscd : '-   ';
    $('#soft-gsidc .value').text(gscd);

    $('#soft-romname').squeezeText(data.rom_name);
    $('#soft-package').empty();

    var romlang;
    if (this.specifiedSavedataId) {
      romlang = data.langcode;
    } else {
      romlang = this.data.member.langcode;
    }
    if (romlang) {
      romlang = [null, 'ja', 'en', 'fr', 'it', 'de', null, 'es', 'ko'][romlang];
    }
    
    $('#soft-badges .label').squeezeText().find('.squeeze-text').css({ 'white-space':'' });
    if (!this.isMyProfile 
    && (data.rom_id == 22 || data.rom_id == 23) 
    && (this.data.member.rom_id != 22 && this.data.member.rom_id != 23)) {
      $('#soft-badges').addClass('badge-count-num').find('.value').text(data.player_badge_num);
    } else {
      $('#soft-badges')
        .addClass('badge-rom-' + data.rom_id)
        .addClass('badge-count-' + data.player_badge_num)
        .find('.value').text(data.player_badge_num);
    }
    if (data.rom_id == '20') {
      $('<img/>').attr({ src:'assets/' + romlang + '/images/soft-white.png' }).appendTo($('#soft-package'));
    } else if (data.rom_id == '21') {
      $('<img/>').attr({ src:'assets/' + romlang + '/images/soft-black.png' }).appendTo($('#soft-package'));
    } else if (data.rom_id == '22') {
      $('<img/>').attr({ src:'assets/' + romlang + '/images/soft-white2.png' }).appendTo($('#soft-package'));
    } else if (data.rom_id == '23') {
      $('<img/>').attr({ src:'assets/' + romlang + '/images/soft-black2.png' }).appendTo($('#soft-package'));
    } else if (data.trial_flag == '1') {
      $('<img/>').attr({ src:'assets/' + PGL.language + '/images/soft-trial.png' }).appendTo($('#soft-package'));
    } else {
      $('<img/>').attr({ src:'assets/' + PGL.language + '/images/soft-interim.png' }).appendTo($('#soft-package'));
    }
    $('#soft-trainername .value').html(PGL.Utils.renderDSFont('ds-font-0', data.trainer_name));
    $('#soft-playtime .value').text(data.playtime);

    this.updateSoftFriendlist(data.friends, Math.ceil(data.friends_count / 5));

    if ((this.data.member.rom_id == 22 || this.data.member.rom_id == 23) 
    && (data.rom_id == 22 || data.rom_id == 23)) {
      var kind = 
        ['s1', 's2', 's3', 's4', 's5', 's6', 's7', 'b1', 'b2', 'b3', 'b4', 'b1', 'b2', 'b3', 'b4', 
         'b1', 'b1', 'b2', 'b4', 'b1', 'b2', 'b3', 'b4', 'b1', 'b2', 'b3', 'b4', 'b4', 'b4', 'b4', 
         'b4', 'b4', 'b4', 'b4', 'b4', 'b4', 'b4', 'b4', 'b4', 'b4', 'b4', 'b4', 'b4', 'b4', 'b4', 
         'b4', 'b1', 'b2', 'b3', 'b4', 'b4', 'b1', 'b4', 'b1', 'b2', 'b3', 'b4', 'b3', 'b3', 'b4', 
         'b1', 'b2', 'b3', 'b4', 'b1', 'b1', 'b3', 'b1', 'b2', 'b3', 'b4', 'b1', 'b1', 'b1', 'b2', 
         'b3', 'b4', 'b1', 'b2', 'b3', 'b4', 'b1', 'b2', 'b3', 'b4', 'b2', 'b1', 'b2', 'b3', 'b4', 
         'b4', 'b3', 'b4', 'b4', 'b4', 'b2', 'b4', 'b3', 'b1', 'b4', 'b4', 'b4', 'b4', 'b4', 'b5', 
         'x1', 'x2', 'x3', 'x4', 'x1', 'x2', 'x3', 'x4', 'x4', 'x4', 'x2', 'x2', 'x1', 'x2', 'x3', 
         'x4', 'x3', 'x3', 'x3', 'x1', 'x2', 'x3', 'x4', 'x4', 'x4', 'x2', 'x3', 'x3', 'x1', 'x2', 
         'x2', 'x3', 'x3', 'x3', 'x3', 'x3', 'x3', 'x4', 'x4', 'x4', 'x4', 'x1', 'x2', 'x1', 'x2', 
         'x3', 'x3', 'x4', 'x4', 'x3', 'x4', 'x3', 'x4', 'x3', 'x4', 'x5', 'h1', 'h2', 'h3', 'h4', 
         'h2', 'h1', 'h3', 'h1', 'h2', 'h3', 'h4', 'h4', 'h4', 'h1', 'h2', 'h3', 'h4', 'h3', 'h2', 
         'h4', 'h4', 'h1', 'h2', 'h3', 'h4', 'h1', 'h2', 'h3', 'h4', 'h1', 'h2', 'h3', 'h4', 'h4', 
         'h1', 'h2', 'h3', 'h4', 'h1', 'h2', 'h3', 'h4', 'h1', 'h3', 'h3', 'h3', 'h3', 'h3', 'h3', 
         'h3', 'h3', 'h3', 'h3', 'h3', 'h3', 'h4', 'h4', 'h4', 'h4', 'h4', 'h2', 'h4', 'h2', 'h4', 
         'h1', 'h3', 'h1', 'h3', 'h1', 'h3', 'h4', 'h4', 'h2', 'h4', 'h5', 'c3', 'c3', 'c3', 'c3', 
         'c3', 'c3', 'c3', 'c3', 'c3', 'c3', 'c3', 'c3', 'c3', 'c3', 'c3', 'c3', 'c3', 'c4', 'c5'];
      $.each(data.medals, function(index, medal) {
        var li = $($('#medals li').get(index));
        li.find('.medal-image')
          .append(
            $('<img />').attr({ src:'assets/images/medal/' + kind[medal.medal_id] + '.png', width: '33', height: '33' })
          );
        li.attr({ title: medal.medal_name });
        if (medal.is_recommend) {
          $('#recommended-medal-image').append(
            $('<img />').attr({ src:'assets/images/medal/' + kind[medal.medal_id] + '.png' })
          );
          $('#recommended-medal-name').text(medal.medal_name);
        }
      });
    } else {
      $('.medals').hide();
    }
    
    (function () {
      var page = 0;
      var paging = function (delta) {
        page += delta;
        updatePageButtonState();
        $('#medals-pages').animate({ left: -page * 460 });
      };
      updatePageButtonState();
      function updatePageButtonState() {
        $('#medals-pager-l').unbind('click').toggleClass('enabled', page > 0);
        $('#medals-pager-r').unbind('click').toggleClass('enabled', page < Math.ceil(data.medals.length / 20) - 1);
        $('#medals-pager-l.enabled').click(function() { paging(-1); });
        $('#medals-pager-r.enabled').click(function() { paging(1); });
      }
    })();
  },
  loadSoftFriendlist: function() {
    var that = this;
    this.friendlistSoft = this.friendlistSoft || { sort:2, dir:0, offset:0, rowcount:5 };
		$('#soft-friendlist')
      .removeClass('sort-by-2 sort-by-4 sort-dir-0 sort-dir-1')
      .addClass('sort-by-' + that.friendlistSoft.sort)
      .addClass('sort-dir-' + that.friendlistSoft.dir);
    var api = '';
		if (that.isMyProfile) {
			api = 'pgl.member.profile.friend_list';
		} else {
			api = 'pgl.member.profile.friend_friend_list';
			that.friendlistSoft.friend_member_savedata_id = that.specifiedSavedataId;
		}
		that.getApi(api, that.friendlistSoft, function (data) {
			that.updateSoftFriendlist(data.list, Math.ceil(data.cnt / 5));
		});
  },
  updateSoftFriendlist: function(friends, pages) {
    var that = this;
    this.friendlistSoft = this.friendlistSoft || { sort:2, dir:0, offset:0, rowcount:5 };
    var target = $('#soft-friendlist');

    var is_empty = true;
    $('tr:not(:first)', target).each(function (index) {
      var row = $(this).empty().removeClass('friend-disabled friend-disabled-1 friend-disabled-2');
      var friend = friends[index];
      if (friend) {
        if (that.isMyProfile && friend.disable_flag != '0') {
          row.addClass('friend-disabled').addClass('friend-disabled-' + friend.disable_flag);
        }

        // avatar
        $('<td></td>')
          .addClass('no-border avatar')
          .append(PGL.Utils.getAvatarImage(friend.avator_id, 32))
          .appendTo(row);

        // 名前
        var link = $('<a class="friend-link"></a>').text(friend.pgl_name);
        if (friend.member_savedata_id && (!that.isMyProfile || friend.disable_flag == '0')) {
          link.attr({ href:friend.member_savedata_id == that.data.member.member_savedata_id ? '.' : '?id=' + friend.member_savedata_id });
        }
        $('<td></td>').addClass('pglname').append(link).appendTo(row);

        var friendArea = $('<span class="friend-area"></span>')
          .addClass(friend.is_ds ? 'friend-area-friend' : 'friend-area-tradepal')
          .text(friend.country_code);
        $('<td></td>').addClass('area').append(friendArea).appendTo(row);


        // かんけい
        var friendIcon = $('<span class="friend-icon"></span>')
          .addClass(friend.is_ds ? 'friend-icon-friend' : 'friend-icon-tradepal')
          .text(PGL.Text.get(friend.is_ds ? 'pg_an_16' : 'pg_an_18'));
        $('<td></td>').addClass('relation').append(friendIcon).appendTo(row);

        // アクション
        var cell = $('<td></td>').addClass('action');
        if (that.isMyProfile) {
          var blocking = friend.is_blocked == '1';
          if (blocking) {
            $('<div class="block-icon soft-ui"></div>').appendTo(cell);
          } else if (friend.disable_flag == '0') {
            $('<a class="mailer-link">mailer</a>').attr({ href:'/mailer/?mailto=' + friend.member_savedata_id }).appendTo(cell);
          } else {
            $('<span class="mailer-link disabled">mailer</span>').appendTo(cell);
          }

          // block/unblock UI
          $('<a href="#" class="friend-block"></a>').text('> ' + PGL.Text.get(blocking ? 'pg_aq_1' : 'pg_as_7')).click(function () {
            var text = PGL.Text.get(blocking ? 'profile.unblock.confirm' : 'profile.block.confirm');
            text = text.replace(/\[[^\]]+\]/, friend.pgl_name);
            that.showDialog(text, { ok:function () {
              that.postApi('pgl.member.profile.friend_block', { friend_member_savedata_id:friend.member_savedata_id, is_block:blocking ? 0 : 1 }, function (data) {
                that.showDialog(PGL.Text.get(blocking ? 'dialog_10' : 'dialog_9'), { ok:function () {
                  location.reload();
                } });
              }, true);
            }, back:true });
            return false;
          }).appendTo(cell);
        }
        cell.appendTo(row);
        // 
        is_empty = false;
      } else {
        row.append('<td colspan="5">&nbsp;</td>');
      }
    });
    if (is_empty) {
      $('tr:eq(1)', target).empty().append($('<td colspan="5" style="font-size:12px;"></td>').text(PGL.Text.get('pg_rq_1')));
    }

    var pager = $('.friendlist-pager', target).empty();
    var index = this.friendlistSoft.offset / 5;
    for (var i = 0; i < Math.max(1, pages); i++) {
      var a = $('<a></a>').text(i + 1)
        .removeClass('selected')
        .appendTo(pager)
        .click(function () {
          var offset = ($(this).text() - 1) * 5;
          if (that.friendlistSoft.offset != offset) {
            that.friendlistSoft.offset = offset;
            that.loadSoftFriendlist();
          }
        });
      if (i == index) a.addClass('selected');
    }

  },
  makePdwTab: function(data) {
    var that = this;
    var pglpdw = new PGL.PDW(this.data.member, this.level);
    var pdw = pglpdw.getStates();
    
    if (that.isMyProfile) {
      $('#pdw-game-status .vertical-middle-body').text(pdw.status_profile);
    }
    
    if (that.isMyProfile && pdw.wakeup_visibility) {
      $('#pdw-wakeup a').show();
      if (pdw.wakeup_enabled) {
        $('#pdw-wakeup a').addClass('show-wakeup show-wakeup-enabled');
        $('#pdw-wakeup').click(function() {
          that.wakeup();
          return false;
        });
      } else {
        $('#pdw-wakeup a').addClass('show-wakeup show-wakeup-disabled');
      }
    } else {
        $('#pdw-wakeup a').hide();
    }

    // with "data"
    if (data.island_id) {
      $('#pdw-home-thumbnail').empty().show().append($('<img/>').attr({ src:'assets/images/home/' + data.island_id + '.png' }));
    }
    $('#pdw-point .label').squeezeText();
    $('#pdw-point .value').text(data.experiment_point || 0).squeezeText();

    var pokemon_name = (that.isMyProfile) ? pdw.pokemon_profile : data.pokemon_name;

    if (pdw.pokemon_profile == PGL.Text.get('global.fennels_munna')) {
      $('#pdw-slept-name').squeezeText(pdw.pokemon_profile);
      $('#pdw-pokemon-status .nickname').text(PGL.Text.get('trial.pokemon.nickname'));
      $('#pdw-pokemon-status .level .value').text('10');
      $('#pdw-pokemon-status .sex').removeClass('sex-0 sex-1 sex-2').addClass('sex-1').text('♀');
      $('#pdw-slept-image').show().pokemonImage(120, 517);
      $('#pdw-slept-parent .value').html(PGL.Text.get('trial.pokemon.ot'));
      $('#pdw-slept-types .pokemon-type:eq(0)').attr({ 'class':'pokemon-type pokemon-type1' }).addClass('pokemon-type-psychic');
      $('#pdw-slept-types .pokemon-type:eq(1)').attr({ 'class':'pokemon-type pokemon-type2' }).addClass('pokemon-type-none');
      $('#pdw-slept-nature .value').text(PGL.Text.get('trial.pokemon.nature'));
    } else if (data.pokemon_name) {
      $('#pdw-slept-name').squeezeText(pokemon_name);
      $('#pdw-pokemon-status .nickname').html(PGL.Utils.renderDSFont('ds-font-2', data.pokemon_nickname)).squeezeText();
      $('#pdw-pokemon-status .level .value').text(data.level);
      $('#pdw-pokemon-status .sex').removeClass('sex-0 sex-1 sex-2').addClass('sex-' + data.sex_id).text(['♂', '♀', ''][data.sex_id]);
      $('#pdw-slept-image').show().pokemonImage(120, data.pokemon_no, data.form_no);
      var dsfont = (this.data.member.rom_id == 22) ? 'ds-font-5' : (this.data.member.rom_id == 23) ? 'ds-font-4' : 'ds-font-6';
      $('#pdw-slept-parent .value').html(PGL.Utils.renderDSFont(dsfont, data.oyaname));
      $('#pdw-slept-types .pokemon-type:eq(0)').attr({ 'class':'pokemon-type pokemon-type1' }).addClass('pokemon-type-' + this.getCanonType(data.type1));
      $('#pdw-slept-types .pokemon-type:eq(1)').attr({ 'class':'pokemon-type pokemon-type2' }).addClass('pokemon-type-' + this.getCanonType(data.type2));
      $('#pdw-slept-nature .value').text(data.personality);
    } else {
      $('#pdw-slept').empty().text(new PGL.PDW(this.data.member, this.level).getStates().pokemon);
      $('#pdw-pokemon-status .level .label').hide();
    }

    $('#pdw-recent-mate').empty();
    $.each(data.encount_pokemons, function () {
      $('<li></li>').appendTo($('#pdw-recent-mate')).pokemonImage(64, this.pokemon_no, this.form_no);
    });
    if (data.encount_pokemons.length) {
      $('#pdw-recent-mate').show();
      $('#pdw-recent-mate-empty').hide();
    } else {
      $('#pdw-recent-mate').hide();
      $('#pdw-recent-mate-empty').show();
    }

  },
  loadPdwFriendlist: function() {
    this.friendlistPdwApi = this.friendlistPdwApi || 'pgl.member.profile.pdw_friend_list';
    this.friendlistPdwRelation = this.friendlistPdwRelation || PGL.PDW.RELATION_DREAM_PAL;
    this.friendlistPdw = this.friendlistPdw || { sort:1, dir:0, offset:0, rowcount:5 };

    $('#pdw-friendlist')
      .removeClass('sort-by-2 sort-by-4 sort-dir-0 sort-dir-1')
      .addClass('sort-by-' + this.friendlistPdw.sort)
      .addClass('sort-dir-' + this.friendlistPdw.dir);
    var api;
    if (!this.isMyProfile) {
      api = 'pgl.member.profile.friend_pdw_friend_list';
      this.friendlistPdw.friend_member_savedata_id = this.specifiedSavedataId;
    } else {
      api = this.friendlistPdwApi;
    }
    var that = this;
    this.getApi(api, this.friendlistPdw, function (data) {
      that.updatePdwFriendlist(data.list, Math.ceil(data.cnt / 5), that.friendlistPdwRelation);
    });
  },
  updatePdwFriendlist: function(friends, pages, relation) {
    var that = this;

    var relationLabel;
    var target = $('#pdw-friendlist');
    switch (relation) {
      case PGL.PDW.RELATION_DREAM_PAL:
        relationLabel = PGL.Text.get('pg_an_17');
        break;
      case PGL.PDW.RELATION_PENDING_REQUEST:
        relationLabel = PGL.Text.get('new_profile_4');
        break;
      case PGL.PDW.RELATION_RECEIVED_REQUEST:
        relationLabel = PGL.Text.get('new_profile_5');
        break;
    }

    var is_empty = true;
    $('tr:not(:first)', target).each(function (index) {
      var row = $(this).empty().removeClass('friend-disabled friend-disabled-1 friend-disabled-2');
      var friend = friends[index];
      if (friend) {
        if (that.isMyProfile && friend.disable_flag != '0') {
          row.addClass('friend-disabled').addClass('friend-disabled-' + friend.disable_flag);
        }

        // アバター
        $('<td></td>')
          .addClass('no-border avatar')
          .append(PGL.Utils.getAvatarImage(friend.avator_id, 36))
          .appendTo(row);

        // 名前
        var link = $('<a class="friend-link"></a>').text(friend.pgl_name);
        if (friend.member_savedata_id && (!that.isMyProfile || friend.disable_flag == '0')) {
          link.attr({ href:friend.member_savedata_id == that.data.member.member_savedata_id ? '.' : '?id=' + friend.member_savedata_id });
        }
        $('<td></td>').addClass('pglname').append(link).appendTo(row);
       
        var friendArea = $('<span class="friend-area"></span>')
          .addClass(friend.is_ds ? 'friend-area-friend' : 'friend-area-tradepal')
          .text(friend.country_code);
        $('<td></td>').addClass('area').append(friendArea).appendTo(row);

        // かんけい
        var friendIcon = $('<span class="friend-icon"></span>').addClass('friend-icon-dreampal').text(relationLabel);
        $('<td></td>').addClass('relation').append(friendIcon).appendTo(row);

        // アクション
        var cell = $('<td></td>').addClass('action');
        if (that.isMyProfile) {
          // メールリンク
          if (relation == PGL.PDW.RELATION_DREAM_PAL) {
            if (friend.disable_flag == '0') {
              $('<a class="mailer-link">mailer</a>').attr({ href:'/mailer/?mailto=' + friend.member_savedata_id }).appendTo(cell);
            } else {
              $('<span class="mailer-link disabled">mailer</span>').appendTo(cell);
            }
          }
          // 削除リンク
          if (relation != PGL.PDW.RELATION_RECEIVED_REQUEST) {
            $('<a href="#" class="friend-block"></a>').text('> ' + PGL.Text.get('new_profile_6')).click(function () {
              var id = relation == PGL.PDW.RELATION_DREAM_PAL ? 'pg_ro_1' : 'profile.dreampal.cancel_request.confirm';
              that.showDialog(PGL.Text.get(id).replace(/\[[^\]]*\]/, friend.pgl_name), { ok:function () {
                var api = relation == PGL.PDW.RELATION_DREAM_PAL ? 'pgl.member.profile.pdw_friend_delete' : 'pgl.member.profile.pdw_friend_requesting_discard';
                that.postApi(api, { friend_member_savedata_id: friend.member_savedata_id }, function (data) {
                  that.showDialog(PGL.Text.get('pg_rp_1'), { ok: function () { location.reload(); } });
                }, true);
              }, back:true });
              return false;
            }).appendTo(cell);
          }
        }
        cell.appendTo(row);
        // 
        is_empty = false;
      } else {
        row.append('<td colspan="5">&nbsp;</td>');
      }
    });
    if (is_empty) {
      $('tr:eq(1)', target).empty().append($('<td colspan="5" style="font-size:12px;"></td>').text(PGL.Text.get('pg_rq_1')));
    }

    var pager = $('.friendlist-pager', target).empty();
    var index = this.friendlistPdw.offset / 5;
    for (var i = 0; i < Math.max(1, pages); i++) {
      var a = $('<a></a>').text(i + 1)
        .removeClass('selected')
        .appendTo(pager)
        .click(function () {
          var offset = ($(this).text() - 1) * 5;
          if (that.friendlistPdw.offset != offset) {
            that.friendlistPdw.offset = offset;
            that.loadPdwFriendlist();
          }
        });
      if (i == index) a.addClass('selected');
    }

  },
  makeGbuTab: function(data) {
    var that = this;
    this.updateGbuRecordBattles();
    var hyphenIfZero = function (val) {
      return val == '0' ? '-' : val;
    };


    if (data.ranking && data.ranking[0].gsid) {
      $('#gbu-record-link').attr({ href:'/gbu/?rankingto=' + data.ranking[0].gsid }).parent().show();
    } else {
      $('#gbu-record-link').parent().hide();
    }

    while (data.worldbattle_history.length < 4) {
      data.worldbattle_history.push(null);
    }
    $.each(data.worldbattle_history, function (index, record) {
      var row = $('.tournament-history-template').clone().attr('class', index % 2 ? 'even' : 'odd').appendTo($('#tournament-history-table'));
      if (record) {
        row.find('.date').text(PGL.Utils.formatTime(record.entry_date, { format:'DATE' }));
        row.find('.name').text(record.worldbattle_name);
        row.find('.rating .value').text(hyphenIfZero(record.rating));
        row.find('.ranking .value').text(hyphenIfZero(record.ranking));
        row.find('.winlose').text(
          PGL.Text.get('pg_au_13').replace(/\[[^\]]*\]/, record.wificup_win_count) + ' ' +
          PGL.Text.get('pg_au_14').replace(/\[[^\]]*\]/, record.wificup_lose_count) 
        );
      } else {
        if (index == 0) {
          row.empty().append($('<td colspan="5" align="center"></tid>').addClass('').text(PGL.Text.get('pg_rq_1')));
        } else {
          row.empty().append($('<td colspan="5" align="center"></td>').html('&nbsp;'));
        }
        row.addClass('empty');
      }
    });
    $('.tournament-history-template').remove();

    if (this.isMyProfile) {
      $('#gbu-status a').text(PGL.Utils.getWordlbattleStatusText(data.worldbattle_status));
    }

    this.updateBattlevideoList(data.video_code)

  },
  updateGbuRecordBattles: function(season_id) {
    var that = this;
    var param = { member_savedata_id: (that.isMyProfile ? that.data.member.member_savedata_id : that.friendSsid) };
    if (season_id) param.season_id = season_id;
    
    var hyphenIfZero = function (val) {
      return val == '0' ? '-' : val;
    };

    this.getApi('gbu.worldbattle.get_battle_history', param, function(dx) {
      
      var mp = dx.my_profile, r = {};
      if (mp) {
        $.each(['total', 'single', 'double', 'triple', 'rotation', 'shooter'], function () {
          r[this + '_win'] = mp['num_' + this + '_win_counter'];
          r[this + '_lose'] = mp['num_' + this + '_lose_counter'];
          r[this + '_rating'] = mp['arena_elo_rating_1v1_' + this];
          r[this + '_rank'] = mp[this + '_rank'];
        });
        r['rotation_win'] = mp['num_rotate_win_counter'];
        r['rotation_lose'] = mp['num_rotate_lose_counter'];
        r['rotation_rating'] = mp['arena_elo_rating_1v1_rotate'];
        
        $('#gbu .updated-at:eq(0)').toggle(mp.rating_datetime != null);
        $('#gbu .updated-at:eq(1)').toggle(mp.ranking_datetime != null);
        $('#gbu .updated-at:eq(0) .value').text(mp.rating_datetime || '');
        $('#gbu .updated-at:eq(1) .value').text(mp.ranking_datetime || '');
      } else {
        $.each(['total', 'single', 'double', 'triple', 'rotation', 'shooter'], function () {
          r[this + '_win'] = 0;
          r[this + '_lose'] = 0;
          r[this + '_rating'] = '-';
          r[this + '_rank'] = '-';
        });
        $('#gbu .updated-at').hide();
      }
      r.total_win = r.total_lose = 0;
      $.each(['single', 'double', 'triple', 'rotation', 'shooter'], function () {
        r.total_win  += parseInt(r[this + '_win']);
        r.total_lose += parseInt(r[this + '_lose']);
      });
      $.each(['total', 'single', 'double', 'triple', 'rotation', 'shooter'], function () {
        $('#gbu-record-rating-' + this).text(hyphenIfZero(r[this + '_rating']));
        $('#gbu-record-ranking-' + this).text(hyphenIfZero(r[this + '_rank']));
        var win = '-';
        var lose = '-';
        if (r[this + '_win'] != '0' || r[this + '_lose'] != '0') {
          win = r[this + '_win'];
          lose = r[this + '_lose'];
        }
        $('#gbu-record-battles .win.' + this + ' .value').text(win);
        $('#gbu-record-battles .lose.' + this + ' .value').text(lose);
      });

      if (!dx.opponent_profile_list) dx.opponent_profile_list = [];
      while (dx.opponent_profile_list.length < 4) {
        dx.opponent_profile_list.push(null);
      }
      $.each(dx.opponent_profile_list, function (index, record) {
        var row = $('.battle-history-template').clone().attr('class', index % 2 ? 'even' : 'odd').appendTo($('#battle-history-table'));
        if (record) {
          $('.date', row).text(PGL.Utils.formatTime(record.battle_datetime));
          var regulation = '';
          if (record.cup_no != 0) regulation = PGL.Text.get('global.gbu.competition');
          else if (record.shooter_flag == 1) regulation = PGL.Text.get('global.gbu.shooter');
          else if (record.battle_type == 0) regulation = PGL.Text.get('global.gbu.single');
          else if (record.battle_type == 1) regulation = PGL.Text.get('global.gbu.double');
          else if (record.battle_type == 2) regulation = PGL.Text.get('global.gbu.triple');
          else if (record.battle_type == 3) regulation = PGL.Text.get('global.gbu.rotation');
          $('.regulation', row).text(regulation);
          $('.avatar', row).append(PGL.Utils.getAvatarImage(record.avator_id, 24));
          $('.pgl-name', row).text(record.opponent_pgl_name);
          $('.player-name', row).html(PGL.Utils.renderDSFont('ds-font-3', record.opponent_player_name));
          $('.country', row).text(record.opponent_area_code);
          $('.win-lose', row).text(PGL.Text.get('global.gbu.' + ['lose', 'win', 'draw'][record.result % 3]));
        } else {
          if (index == 0) {
            row.empty().append($('<td colspan="7" align="center"></td>').text(PGL.Text.get('pg_rq_1')));
          } else {
            row.empty().append($('<td colspan="7" align="center"></td>').html('&nbsp;'));
          }
          row.addClass('empty');
        }
      });
      $('.battle-history-template').remove();

    });
  },
  updateBattlevideoList: function(list) {
    var that = this;
    $('#gbu-favorite-video ul').empty();
    if (list.length) {
      $.each(list, function (index) {
        var video_code = this.video_code;
        var li = $('<li></li>')
        .addClass(index % 3  == 0? 'no-border' : '')
        .addClass(index % 6  < 3 ? 'odd' : 'even')
        .append($('<span class="video_code"></span>').text(this.video_code));
        if (that.isMyProfile) {
          li.append($('<a href="#">' + PGL.Text.get('new_profile_6') + '</a>').addClass('delete').click(function () {
            that.showDialog(PGL.Text.get('pg_auh_1'), { ok:function () {
              that.gbuDeleteBattlevideo(video_code);
              that.showDialog(PGL.Text.get('pg_aui_1'), { ok:true });
            }, back:true });
            return false;
          }));
        }
        li.appendTo($('#gbu-favorite-video ul'));
      });
    } else {
      $('<li></li>').addClass('none')
        .text(PGL.Text.get('pg_rq_1'))
        .appendTo($('#gbu-favorite-video ul'));
    }
    if (!that.isMyProfile) {
      $('#gbu-favorite-video .form').remove();
    }
  },
  registerBattlevideo: function(code) {
    var that = this;
    this.postApi('pgl.member.profile.video_regist', { video_code: code }, function (data) {
      that.updateBattlevideoList(data.video_code);
      $('#gbu-favorite-video-code').val('');
      that.showDialog(PGL.Text.get('pg_aug_1'), { ok:true });
    }, true);
  },
  gbuDeleteBattlevideo: function(code) {
    var that = this;
    this.postApi('pgl.member.profile.video_delete', { video_code: code }, function (data) {
      that.updateBattlevideoList(data.video_code);
    }, true);
  },
  makeGtsTab: function(data) {
    var that = this;
    
    (function (t) {
      t = [t.yyyy, '-', t.mm, '-', t.dd, ' ', t.hh, ':', t.mi].join('');
      $('#gts .updated-at .value').text(PGL.Utils.formatTime(t));
    })(data.last_batchtime);
    
    var hasUntradeLine = data.gts_pokemon || data.want_pokemon;
    if (hasUntradeLine) {
      var gp = data.gts_pokemon || {};
      var wp = data.want_pokemon || {};
      var row = $('.gts-trade-history-template').clone().removeClass('gts-trade-history-template').addClass('odd').appendTo($('#gts-trade-history-table'));
      $('.date', row).text(gp.post_date);
      $('.gts-pokemon-name', row).text(gp.pokename);
      $('.gts-pokemon-image', row).pokemonImage(100, gp.monsno, gp.form_no);
      $('.gts-pokemon-level', row).text(gp.poke_level);
      var gender = { 1:'♂', 2:'♀', 3:'' }[gp.sex_type];
      $('.gts-pokemon-gender', row).addClass('gender' + gp.sex).text(gender);
      $('.gts-pokemon-waza1', row).text(gp.waza1);
      $('.gts-pokemon-waza2', row).text(gp.waza2);
      $('.gts-pokemon-waza3', row).text(gp.waza3);
      $('.gts-pokemon-waza4', row).text(gp.waza4);
      $('.gts-pokemon-pokeitem', row).text(gp.pokeitem || '-');
      $('.want-pokemon-name', row).text(wp.pokename);
      $('.want-pokemon-image', row).pokemonImage(100, wp.monsno);
      var levels = wp.poke_level_min + '-' + wp.poke_level_max;
      if (levels == '0-0') {
        row.find('.want-pokemon-level').empty().squeezeText(PGL.Text.get('profile.gts.recent_trade.level.1'));
      } else if (levels == '0-9') {
        row.find('.want-pokemon-level').empty().squeezeText(PGL.Text.get('profile.gts.recent_trade.level.2'));
      } else if (levels == '100-100') {
        row.find('.want-pokemon-level').empty().squeezeText(100);
      } else if (wp.poke_level_max == '0') {
        var t = PGL.Text.get('profile.gts.recent_trade.level.3');
        t = t.replace(/(?:\[\d+\]|10)/, wp.poke_level_min);
        row.find('.want-pokemon-level').empty().squeezeText(t);
      } else {
        row.find('.want-pokemon-level').empty().squeezeText('-');
      }
      gender = { 1:'♂', 2:'♀', 3:PGL.Text.get('profile.gts.recent_trade.sex.1') }[wp.sex_type];
      $('.want-pokemon-gender', row).empty().addClass('gender' + wp.sex_type).text(gender);

      $('.trade-pokemon', row).remove();
      $('.trade', row).addClass('untrade');
    }

    $.each(data.trade_history, function(index, trade) {
      var oddeven = ((hasUntradeLine && index % 2 == 0) || (!hasUntradeLine && index % 2 == 1)) ? 'even' : 'odd';
      var row = $('.gts-trade-history-template').clone().removeClass('gts-trade-history-template').addClass(oddeven).appendTo($('#gts-trade-history-table'));
      $('.date', row).text(trade.trade_date);
      $('.gts-pokemon-name', row).text(trade.pokename);
      $('.gts-pokemon-image', row).pokemonImage(100, trade.monsno, trade.form_no);
      $('.gts-pokemon-level', row).text(trade.poke_level);
      var gender = (trade.sex == 0) ? '♂' : (trade.sex == 1) ? '♀' : '';
      $('.gts-pokemon-gender', row).addClass('gender' + trade.sex).text(gender);
      $('.gts-pokemon-waza1', row).text(trade.waza1);
      $('.gts-pokemon-waza2', row).text(trade.waza2);
      $('.gts-pokemon-waza3', row).text(trade.waza3);
      $('.gts-pokemon-waza4', row).text(trade.waza4);
      $('.gts-pokemon-pokeitem', row).text(trade.pokeitem || '-');
      
      if (trade.avator_id) {
        $('.trade-avatar', row).append(PGL.Utils.getAvatarImage(trade.avator_id, 50));
      } else {
        $('.trade-avatar', row).empty();
      }
      $('dd.trade-player-name', row).html(PGL.Utils.renderDSFont('ds-font-3', trade.player_name || '-'));
      $('dd.trade-country', row).squeezeText(trade.country);
      $('dd.trade-pgl-name', row).squeezeText(trade.pgl_name || '-');

      $('.trade-pokemon-name', row).text(trade.trade_pokename);
      $('.trade-pokemon-image', row).pokemonImage(100, trade.trade_monsno, trade.trade_form_no);
      $('.trade-pokemon-level', row).text(trade.trade_poke_level);
      gender = (trade.trade_sex == 0) ? '♂' : (trade.trade_sex == 1) ? '♀' : '';
      $('.trade-pokemon-gender', row).addClass('gender' + trade.trade_sex).text(gender);
      $('.trade-pokemon-waza1', row).text(trade.trade_waza1);
      $('.trade-pokemon-waza2', row).text(trade.trade_waza2);
      $('.trade-pokemon-waza3', row).text(trade.trade_waza3);
      $('.trade-pokemon-waza4', row).text(trade.trade_waza4);
      $('.trade-pokemon-pokeitem', row).text(trade.trade_pokeitem || '-');
      
      $('.want-pokemon', row).remove();
      
      if ($('#gts-trade-history-table tr').length > 6) {
        return false;
      }
    });
    
    while ($('#gts-trade-history-table tr').length < 7) {
      var oddeven = $('#gts-trade-history-table tr').length % 2 ? 'even' : 'odd';
      var row = $('.gts-trade-history-template').clone().removeClass('gts-trade-history-template').addClass(oddeven).appendTo($('#gts-trade-history-table'));
      $('.want-pokemon', row).remove();
      $('.trade', row).addClass('untrade');
    }
    
    $('.gts-trade-history-template').remove();
    
    if (data.bookmark_list.length) {
      (function () {
        var page = 0;
        $.each(data.bookmark_list, function (index, pokedex) {
          var link = $('<div class="link"></div>').bind('click touchstart', function () {
            location = '/report/#/gts/pokemon/' + pokedex;
          });
          var li = $('<li></li>').append(link).appendTo('#gts-bookmark-list ul');
          link.pokemonImage(70, pokedex);
          if (that.isMyProfile) {
            var rem = $('<div class="remove"></div>').appendTo(li).bind('click touchstart', function () {
              that.getApi('gts.journal.delete_bookmark', { pokename_id:pokedex });
              li.fadeOut('normal', function () {
                li.remove();
                updatePageButtonState();
                if ($('#gts-bookmark-list ul li').length) {
                  updateBookmarkListWidth();
                  if (page >= Math.ceil($('#gts-bookmark-list ul li').length / 6)) {
                    paging(-1);
                  }
                } else {
                  showBookmarkEmptyMessage();
                }
              });
            });
            if (navigator.userAgent.match(/Android|iPhone|iPad|iPod/i)) {
              rem.show();
            }
          }
        });
        
        var paging = function (delta) {
          page += delta;
          updatePageButtonState();
          $('#gts-bookmark-list ul').animate({ left: 14 - page * 630 });
        };
        
        updateBookmarkListWidth();
        updatePageButtonState();
        
        function updatePageButtonState() {
          $('#gts-bookmark-pager-l').unbind('click').toggleClass('enabled', page > 0);
          $('#gts-bookmark-pager-r').unbind('click').toggleClass('enabled', page < Math.ceil($('#gts-bookmark-list ul li').length / 6) - 1);
          $('#gts-bookmark-pager-l.enabled').click(function() { paging(-1); });
          $('#gts-bookmark-pager-r.enabled').click(function() { paging(1); });
        }
        function updateBookmarkListWidth() {
          $('#gts-bookmark-list ul').css({ width:$('#gts-bookmark-list li').length * 105 });
        }
      })();
    } else {
      showBookmarkEmptyMessage();
    }
    function showBookmarkEmptyMessage() {
      $('<li></li>').addClass('none').text(PGL.Text.get('pg_rq_1')).appendTo($('#gts-bookmark-list ul'));
    }

  },
  showGsidcRegisterDialog: function() {
    var that = this;
    if (this.level == PGL.INTERIM_REGISTERED) {
      this.showDialog(PGL.Text.get('dialog_29'), { ok: true });
      return;
    }
    if (this.data.member.gsid_count == 4) {
      location.hash = '#/';
      return;
    }
    this.showPopup($('#dialog-gsidc'));

    $('#dialog-gsidc-body-1').show();
    $('#dialog-gsidc-body-2').hide();
    location.hash = '#/register-gsid/';

    var rom, gscd;
    $('#dialog-gsidc-body-1 .dialog-buttons-register').unbind('click').click(function () {
      gscd = $('#dialog-gsidc-input').val();
      that.getApi('pgl.member.profile.rom_check', { gscd: gscd }, function (data) {
        if (!data.rom_id) {
          that.showDialog('不正なゲームシンクIDコード', { ok: true });
          return;
        }
        rom = data.rom_id;
        var src = '/top/assets/' + PGL.language + '/images/rom-image-' + { 20:'w', 21:'b', 22:'w2', 23:'b2' }[rom] + '.png';
        $('#dialog-gsidc-body-2 .register').removeClass('rom20 rom21 rom22 rom23').addClass('rom' + rom);
        $('#dialog-gsidc-body-2 .logo').empty().append($('<img/>').attr({ src:src }));
        $('#dialog-gsidc-body-1').fadeOut(300, function () { $('#dialog-gsidc-body-2').fadeIn(300); });
        $('#dialog-gsidc-input2').val(gscd);
      }, function(error) {
        that.hidePopup($('#dialog-gsidc'));
        that.showDialog(error, { ok: function () {
          location.hash = '#/register-gsid/';
          location.reload();
        } });
      })
    });
    $('#dialog-gsidc-body-2 .dialog-buttons-register').unbind('click').click(function () {
      that.hidePopup($('#dialog-gsidc'));
      that.postApi('pgl.member.profile.gsid_create', { gscd: gscd, rom: rom }, function (result) {
        var text = PGL.Text.get(that.level == PGL.TRIAL ? 'pg_ara_1' : 'pg_are_1');
        var romname = '';
        if (rom == 20) {
          romname = PGL.Text.get('global.white');
        } else if (rom == 21) {
          romname = PGL.Text.get('global.black');
        } else if (rom == 22) {
          romname = PGL.Text.get('global.white2');
        } else if (rom == 23) {
          romname = PGL.Text.get('global.black2');
        }
        text = text.replace(/\[[^\]]*\]/, romname);
        that.showDialog(text, { ok:function () {
          location.reload();
        } });
      }, true);
    });
    $('#dialog-gsidc-body-2 .dialog-buttons-cancel').unbind('click').click(function () {
        $('#dialog-gsidc-body-2').fadeOut(300, function () { $('#dialog-gsidc-body-1').fadeIn(300); });
    });



  },
  showRomChangeDialog: function() {
    var that = this;
    if (this.level == PGL.INTERIM_REGISTERED) {
      this.showDialog(PGL.Text.get('dialog_29'), { ok: true });
      return;
    }
    if (this.level == PGL.TRIAL) {
      location.hash = '#/';
      return;
    }
    if (location.hash != '#/change-rom/') {
      location.hash = '#/change-rom/';
      return;
    }

    $('#dialog-rom .dialog-rom-item').hide();
    $('#dialog-rom .dialog-rom-item').removeClass('registered').find('input').attr({ disabled:'disabled' });
    this.getApi('pgl.member.profile.gsid_list', {}, function(data) {
      that.gsid = data.gsid_list ? data.gsid_list : [];
    }).complete(function() {
      $.each(that.gsid, function () {
        var target = $('#dialog-rom-' + this.rom_id);
        target.addClass('registered').show().find('input[name=game]').removeAttr('disabled');
        target.unbind().click(function () {
          var radio = $(this).find('input[name=game]');
          radio.val([radio.val()]);
        });
        var delimiter = PGL.language == 'it' ? ': ' : ' : ';
        var pkg = { 20:'soft-white.png', 21:'soft-black.png', 22:'soft-white2.png', 23:'soft-black2.png' }[this.rom_id];
        var logo = { 20:'rom-image-w.png', 21:'rom-image-b.png', 22:'rom-image-w2.png', 23:'rom-image-b2.png' }[this.rom_id];
        $('<img/>').attr({ src:'/profile/assets/' + PGL.language + '/images/' + pkg }).appendTo($(target).find('.package').empty());
        $('<img/>').attr({ src:'/top/assets/' + PGL.language + '/images/' + logo }).appendTo($(target).find('.logo').empty());
        $(target).find('.dialog-gsidc-item-gsidc .value').text(this.gscd);
        $(target).find('.dialog-gsidc-item-time .value').text(this.last_up_time);
        $(target).find('input[name=game]').attr('value', this.gscd).attr({ title:this.rom_name });
        if (this.gscd == that.data.member.gscd) {
          setTimeout(function () {
            $('input[name=game]', target).attr('checked', 'checked');
          }, 1); // delay for IE7 issue
        }
      });
      $('.dialog-rom-item').each(function(idx) {
        $(this).addClass((idx % 2 == 0) ? 'even' : 'odd');
      });

      that.showPopup($('#dialog-rom'), function () {
        var gsidc = $('#dialog-rom input[name=game]:checked').val();
        if (gsidc != that.data.member.gscd) {
          var romname = $('#dialog-rom input[name=game]:checked').attr('title');
          setTimeout(function () {
            that.showDialog(PGL.Text.get('pg_arc_1').replace(/\[[^\]]*\]/, romname), { ok: function() {
              that.postApi('pgl.member.profile.gsid_switch', { gscd: gsidc }, function(data) {
                location = '/';
              }, true);
            }, back:true });
          }, 1);
        }
      });
    });
  },
  setUpdaters: function() {
    var that = this;
    // sort
    $('.soft-friendlist-select').click(function () {
      if (!$(this).hasClass('selected')) {
        $(this).addClass('selected').siblings().removeClass('selected');
        that.friendlistSoft.filter = $(this).attr('id').replace(/^.*-/, '');
        that.friendlistSoft.sort = 2;
        that.friendlistSoft.dir = 0;
        that.friendlistSoft.offset = 0;
        that.loadSoftFriendlist();
      }
    });
    $('#soft-sort-name, #soft-friendlist-sort-name').click(function () {
      if (that.friendlistSoft.sort == 2) {
        that.friendlistSoft.dir = that.friendlistSoft.dir ? 0 : 1;
      } else {
        that.friendlistSoft.sort = 2;
        that.friendlistSoft.dir = 0;
      }
      that.friendlistSoft.offset = 0;
      that.loadSoftFriendlist();
    });
    $('#soft-sort-relation, #soft-friendlist-sort-relation').click(function () {
      if (that.friendlistSoft.sort == 4) {
        that.friendlistSoft.dir = that.friendlistSoft.dir ? 0 : 1;
      } else {
        that.friendlistSoft.sort = 4;
        that.friendlistSoft.dir = 0;
      }
      that.friendlistSoft.offset = 0;
      that.loadSoftFriendlist();
    });


    $('#pdw-friendlist-select-friends').data({ api:'pgl.member.profile.pdw_friend_list', relation: PGL.PDW.RELATION_DREAM_PAL });
    $('#pdw-friendlist-select-requesting').data({ api:'pgl.member.profile.pdw_friend_requesting_list', relation: PGL.PDW.RELATION_PENDING_REQUEST });
    $('#pdw-friendlist-select-requested').data({ api:'pgl.member.profile.pdw_friend_requested_list', relation: PGL.PDW.RELATION_RECEIVED_REQUEST });
    if (!that.isMyProfile) {
      $('#pdw-friendlist-select-requesting, #pdw-friendlist-select-requested').addClass('disabled');
    }
    $('.pdw-friendlist-select').click(function () {
      if (!$(this).hasClass('selected') && !$(this).hasClass('disabled')) {
        $(this).addClass('selected').siblings().removeClass('selected');
        that.friendlistPdwApi      = $(this).data('api');
        that.friendlistPdwRelation = $(this).data('relation');
        that.friendlistPdw.sort = 1;
        that.friendlistPdw.dir = 0;
        that.friendlistPdw.offset = 0;
        that.loadPdwFriendlist();
      }
    });
    $('#pdw-sort-name').click(function () {
      if (that.friendlistPdw.sort == 2) {
        that.friendlistPdw.dir = that.friendlistPdw.dir ? 0 : 1;
      } else {
        that.friendlistPdw.sort = 2;
        that.friendlistPdw.dir = 0;
      }
      that.friendlistPdw.offset = 0;
      that.loadPdwFriendlist();
    });



    // avatar
    $('#avatar-change-button').click(function() {
      var selecting_avatar_id = that.data.member.avator_id;

      $('#dialog-avatar-selected-image').empty();
      that.showPopup($('#dialog-avatar'), function () {
        if ($('#dialog-avatar li.selected').length) {
          if (selecting_avatar_id != that.data.member.avator_id) {
            that.postApi('pgl.member.profile.avator_select', { avator_id:selecting_avatar_id }, function () {
              that.data.member.avator_id = selecting_avatar_id;
              $('#avatar').empty().append(PGL.Utils.getAvatarImage(selecting_avatar_id));
              $('#header-avatar').empty().append(PGL.Utils.getAvatarImage(selecting_avatar_id));
              that.showDialog(PGL.Text.get('dialog_11'), { ok: true });
            }, true);
          }
        } else {
          return false;
        }
      });
      PGL.Utils.packText($('#dialog-avatar-selected-label'));
      var ul = $('#dialog-avatar-list ul').empty();
      var $pager = $('#dialog-avatar-pager ul').empty();
      that.postApi('pgl.member.profile.avator_list', {}, function (data) {
        var AVATARS_PER_PAGE = 48;
        var num_page = Math.ceil(data.avator_list.length / AVATARS_PER_PAGE);
        $pager.toggle(num_page > 1);

        // ページごとに
        $.each(new Array(num_page), function (pageIndex) {
          // ページャーのリストアイテム追加
          $('<li>●</li>').click(function () {
            $(this).addClass('selected').siblings().removeClass('selected');
            ul.empty();
            $.each(data.avator_list.slice(pageIndex * AVATARS_PER_PAGE, (pageIndex + 1) * AVATARS_PER_PAGE), function (index, avatar) {
              $('<li><div class="selection"/></li>')
                .prepend(PGL.Utils.getAvatarImage(avatar.avator_id))
                .attr({ title:avatar.avator_name })
                .toggleClass('selected', selecting_avatar_id == avatar.avator_id)
                .click(function () {
                  selecting_avatar_id = avatar.avator_id;
                  $(this).addClass('selected').siblings().removeClass('selected');
                  $('#dialog-avatar-selected-image').empty().append(PGL.Utils.getAvatarImage(avatar.avator_id));
                  $('#dialog-avatar-selected-name').text(avatar.avator_name);
                }).appendTo(ul);
            });
          }).appendTo($pager);
        });
        
        // 選択中のアバター更新
        $.each(data.avator_list, function (index, avatar) {
          if (avatar.avator_id == selecting_avatar_id) {
            $('#dialog-avatar-selected-image').empty().append(PGL.Utils.getAvatarImage(avatar.avator_id));
            $('#dialog-avatar-selected-name').text(avatar.avator_name);
            return false;
          }
        });

        // 最初のページを表示
        $('#dialog-avatar-pager li:first').click();

      }, true);
    });



			if (PGL.language == 'ja' || PGL.language == 'ko') {
				$('#dialog-disclosure input[name=profile-disclosure]').change(function (event) {
					var min = $(this).val();
					if (min > $('#dialog-disclosure input[name=friend-disclosure]:checked').val()) {
						$('#dialog-disclosure input[name=friend-disclosure]').val([min]);
					}
					$('#dialog-disclosure input[name=friend-disclosure]').each(function () {
						if (min > $(this).val()) {
							$(this).attr('disabled', 'disabled').parent('label').addClass('disabled');
						} else {
							$(this).attr('disabled', null).parent('label').removeClass('disabled');
						}
					});
				});
			}
			
			var href = $('#dialog-disclosure .member-info-link-com').attr('href');
			if (href) {
				href = href.replace('www.pokemon.com', this.host.getComDomain());
				$('#dialog-disclosure .member-info-link-com').attr({ href:href });
			}
			var href = $('#dialog-disclosure .member-info-link-pki').attr('href');
			if (href) {
				href = href.replace('pokemonkorea.co.kr', this.host.getPkiDomain());
				$('#dialog-disclosure .member-info-link-pki').attr({ href:href });
			}


    // disclosure
    $('#disclosure-change-button').click(function () {
      var getSelectedIndex = function (jqo) { return $(jqo).index($(jqo).filter('.selected')) };
      
      if (that.level == PGL.TRIAL) {
        that.showPopup($('#dialog-disclosure'));
        $('#dialog-disclosure .for-synced').hide();
        $('#dialog-disclosure li.selected').removeClass('selected');
        $('#dialog-disclosure-profile li').eq(2).addClass('selected');
        $('#dialog-disclosure-friend li').eq(2).addClass('selected');
        $('#dialog-disclosure li').unbind('click').not('.selected').addClass('disabled');
      } else {
        that.showPopup($('#dialog-disclosure'), function () {
          var profile_disclosure = getSelectedIndex('#dialog-disclosure-profile li');
          var friend_disclosure  = getSelectedIndex('#dialog-disclosure-friend li');

          var member = that.data.member;
          var task = {};
          var modified = false;
          task.exec = function () {
            if (member.disclosure_flag != profile_disclosure) {
              that.postApi('pgl.member.profile.disclosure_switch', { disclosure_flag: profile_disclosure }, function (data) {
                member.disclosure_flag = profile_disclosure;
                modified = true;
                task.exec();
              }, true);
            } else if (member.list_disclosure_flag != friend_disclosure) {
              that.postApi('pgl.member.profile.list_disclosure_switch', { list_disclosure_flag: friend_disclosure }, function (data) {
                member.list_disclosure_flag = friend_disclosure;
                modified = true;
                task.exec();
              }, true);
            } else if (modified) {
              that.showDialog(PGL.Text.get('pg_apa_2'), { ok:function () { location.reload(); } });
            }
          };
          task.exec();
        });
        $('#dialog-disclosure .for-trial').hide();
        $('#dialog-disclosure li.selected').removeClass('selected');
        $('#dialog-disclosure-profile li').eq(that.data.member.disclosure_flag).addClass('selected');
        $('#dialog-disclosure-friend li').eq(that.data.member.list_disclosure_flag).addClass('selected');

        if (PGL.language == 'ja' || PGL.language == 'ko') {
          var validateDisclosure = function () {
            var profile_disclosure = getSelectedIndex('#dialog-disclosure-profile li');
            var friend_disclosure  = getSelectedIndex('#dialog-disclosure-friend li');
            if (friend_disclosure < profile_disclosure) {
              $($('#dialog-disclosure-friend li').removeClass('selected').get(profile_disclosure)).addClass('selected')
            }
            $('#dialog-disclosure-friend li').each(function (index) {
              if (index < profile_disclosure) {
                $(this).addClass('disabled');
              } else {
                $(this).removeClass('disabled');
              }
            });
          };
          validateDisclosure();
          $('#dialog-disclosure li').unbind('click').click(function () {
            $(this).siblings().removeClass('selected');
            $(this).addClass('selected');
            validateDisclosure();
          });
        } else {
          $('#dialog-disclosure li').unbind('click').not('.selected').addClass('disabled');
        }
      }
    });

    // battle video
    $('#gbu-favorite-video-submit')
      .click(function () {
        var code = $('#gbu-favorite-video-code').val();
        that.showDialog(PGL.Text.get('pg_auf_1'), { ok:function () {
          that.registerBattlevideo(code);
        }, back:true });
        return false;
      });

    $('#gbu-favorite-video-code').each(function () {
      var self = $(this);
      var fix = function (event) {
        var v = self.val();
        var v2 = v.replace(/\D/g, '').replace(/^\d{7}/, '$&-').replace(/^\d{2}/, '$&-');
        if (v2 != v) {
          self.val(v2);
        }
      };
      self.change(fix).keyup(function (event) {
        if ((event.charCode || event.which) != 8) {
          fix();
        }
      }).keydown(function (event) {
        if ((event.charCode || event.which) != 8) {
          setTimeout(fix, 1);
        }
      }).keypress(function (event) {
        if ((event.charCode || event.which) != 8) {
          setTimeout(fix, 1);
        }
      });
    });
    $('#gbu-favorite-video-code').parent().submit(function (event) {
      event.preventDefault();
      return false;
    });

    // GSID
    $('#gsid-change-button').click($.proxy(this.showGsidcRegisterDialog, this));
    $('#dialog-gsidc-input').each(function () {
      var self = $(this);
      var fix = function (event) {
        event = event || window.event || {};
        var key = event.keyCode || event.charCode || event.which;
        if (key >= 37 && key <= 40) return;
        var ov = self.val(), nv = ov.toUpperCase().replace(/[^A-Z0-9]/g, '');
        if (nv != self.val()) {
          var c = self.caret();
          self.val(nv);
          self.caret(c + nv.length - ov.length);
        }
      };
      self.change(fix).keyup(fix).keydown(function (event) {
        setTimeout(fix, 1, event);
      }).keypress(function (event) {
        setTimeout(fix, 1, event);
      });
    });

    // ROM
    $('#rom-change-button').click($.proxy(this.showRomChangeDialog, this));


  }

});

PGL.setMain(function() {
  var that = this;
  var _api = function(name) {
    switch (name) {
      case 'profile':
        return (that.isMyProfile) ? 'pgl.member.profile.my_profile' : 'pgl.member.profile.friend_profile';
      case 'pdw':
        return (that.isMyProfile) ? 'pgl.member.profile.my_pdw_profile_by_pgl' : 'pgl.member.profile.friend_pdw_profile_by_pgl';
      case 'gbu':
        return (that.isMyProfile) ? 'pgl.member.profile.my_gbu_profile' : 'pgl.member.profile.friend_gbu_profile';
    }
  }

  if (this.level < PGL.TRIAL) {
    location = '/introduction/';
    return;
  }
  this.makeTabs();
  var ssid = this.friendSsid = this.specifiedSavedataId = (location.search.match(/\Wid=(\d+)/) || [null, null])[1];
  this.isMyProfile = ssid == null;
  var param = (this.isMyProfile) ? {} : { friend_member_savedata_id: ssid };

  var failed = false;
  this.getApi(_api('profile'), param, 
    [this.makeSidePanel, this.makeDSDataTab], 
    function (error) {
      failed = true;
      that.showDialog(error, { ok: function() { location = '/profile/'; } });
    }
  ).complete(function() {
    if (failed) return;
    that.getApi(_api('pdw'), param, that.makePdwTab);
    that.loadPdwFriendlist();
    that.getApi('gbu.journal.season_list', {}, function(data) {
      $.each(data, function() {
        var sdate = PGL.Utils.formatTime(this.start_datetime, { tzoffset:9, appendTZ:true });
        var edate = PGL.Utils.formatTime(this.end_datetime, { tzoffset:9, appendTZ:true });
        $('<option></option>')
          .val(this.season_id)
          .text(this.season_name + '　' + sdate + ' - ' + edate)
          .appendTo($('#gbu-season-select'));
      });
      $('#gbu-season-select').change(function() {
        var id = $(this).val();
        that.updateGbuRecordBattles(id);
      });

    });

    that.getApi(_api('gbu'), param, that.makeGbuTab);

    var p = { member_savedata_id: (that.isMyProfile ? that.data.member.member_savedata_id : ssid) }
    that.getApi('gts.profile.gts_history', p, that.makeGtsTab);

    that.setUpdaters();
  });

  
  $(window).hashchange(function () {
    if (location.hash == '#/register-gsid/') {
      that.showGsidcRegisterDialog();
    }
    if (location.hash == '#/change-rom/') {
      that.showRomChangeDialog();
    }
  }).hashchange();

  $('.tab-link').bind('mouseup', function() {
    $(this).blur();
  });
  
  $('.dialog-header').squeezeText();



});



