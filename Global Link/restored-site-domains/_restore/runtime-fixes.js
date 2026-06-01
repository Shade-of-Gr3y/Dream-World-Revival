/* pgl-restore runtime fixes */
(function (win) {
  "use strict";
  if (win.__pglRuntimeFixesLoaded) return;
  win.__pglRuntimeFixesLoaded = true;

  function ensureArray(value) {
    return Array.isArray(value) ? value : [];
  }

  function ensureObject(value) {
    return value && typeof value === "object" ? value : {};
  }

  var DISCLOSURE_STORAGE_KEY = "__pgl_restore_disclosure_v1";

  function clampDisclosureValue(value, fallback) {
    var parsed = parseInt(value, 10);
    if (!isFinite(parsed)) parsed = parseInt(fallback, 10);
    if (!isFinite(parsed)) parsed = 0;
    if (parsed < 0) parsed = 0;
    if (parsed > 2) parsed = 2;
    return parsed;
  }

  function readStoredDisclosure() {
    try {
      if (!win.localStorage) return null;
      var raw = win.localStorage.getItem(DISCLOSURE_STORAGE_KEY);
      if (!raw) return null;
      var parsed = JSON.parse(raw);
      return {
        disclosure_flag: clampDisclosureValue(parsed.disclosure_flag, 0),
        list_disclosure_flag: clampDisclosureValue(parsed.list_disclosure_flag, parsed.disclosure_flag)
      };
    } catch (e) {
      return null;
    }
  }

  function writeStoredDisclosure(disclosureFlag, listDisclosureFlag) {
    var profileValue = clampDisclosureValue(disclosureFlag, 0);
    var friendValue = clampDisclosureValue(listDisclosureFlag, profileValue);
    if (friendValue < profileValue) friendValue = profileValue;
    try {
      if (!win.localStorage) return;
      win.localStorage.setItem(
        DISCLOSURE_STORAGE_KEY,
        JSON.stringify({
          disclosure_flag: profileValue,
          list_disclosure_flag: friendValue
        })
      );
    } catch (e) {}
  }

  function getLogicalPathname() {
    var path = (win.location && typeof win.location.pathname === "string") ? win.location.pathname : "/";
    var match = /^\/(?:[a-z0-9-]+(?:\.[a-z0-9-]+)+)(\/.*)?$/i.exec(path);
    if (match) {
      return match[1] || "/";
    }
    return path || "/";
  }

  function getPathHostPrefix() {
    var path = (win.location && typeof win.location.pathname === "string") ? win.location.pathname : "/";
    var match = /^\/([a-z0-9-]+(?:\.[a-z0-9-]+)+)(?:\/|$)/i.exec(path);
    return match ? String(match[1]).toLowerCase() : "";
  }

  function detectLogicalLanguage() {
    var hostPrefix = getPathHostPrefix();
    var match = /^(ja|en|fr|it|de|es|ko)\./i.exec(hostPrefix);
    if (match) return match[1].toLowerCase();
    var host = (win.location && typeof win.location.hostname === "string") ? win.location.hostname : "";
    match = /^(ja|en|fr|it|de|es|ko)\./i.exec(host);
    if (match) return match[1].toLowerCase();
    return "en";
  }

  function withPathHostPrefix(url) {
    if (typeof url !== "string" || !url || url.charAt(0) !== "/") return url;
    var prefix = getPathHostPrefix();
    if (!prefix) return url;
    return "/" + prefix + url;
  }

  function canonicalizeRuntimeSwfPath(pathOnly) {
    if (typeof pathOnly !== "string" || !pathOnly) return pathOnly;
    var canonical = pathOnly;
    canonical = canonical.replace(/^\/(?:[a-z0-9-]+(?:\.[a-z0-9-]+)+)\//i, "/");
    canonical = canonical.replace(/^\/(?:www\.)?cdn2?\.pokemon-gl\.com\//i, "/");
    return canonical;
  }

  function normalizeRuntimeSwfUrl(url) {
    if (typeof url !== "string" || !url) return url;
    var hashIndex = url.indexOf("#");
    var hash = hashIndex >= 0 ? url.slice(hashIndex) : "";
    var withoutHash = hashIndex >= 0 ? url.slice(0, hashIndex) : url;
    var queryIndex = withoutHash.indexOf("?");
    var query = queryIndex >= 0 ? withoutHash.slice(queryIndex) : "";
    var pathOnly = queryIndex >= 0 ? withoutHash.slice(0, queryIndex) : withoutHash;
    var canonical = canonicalizeRuntimeSwfPath(pathOnly);
    var lower = canonical.toLowerCase();
    var remap = {
      "/src/swf/assets/global/swf/volume.swf": "/src/swf/assets/global/swf/volume.swf",
      "/src/swf/assets/global/swf/mute.swf": "/src/swf/assets/global/swf/mute.swf",
      "/src/swf/theme/assets/swf/volume.swf": "/src/swf/theme/assets/swf/volume.swf",
      "/src/swf/theme/assets/swf/mute.swf": "/src/swf/theme/assets/swf/mute.swf",
      "/src/swf/theme/assets/common/sound.swf": "/src/swf/theme/assets/common/sound.swf"
    };
    if (Object.prototype.hasOwnProperty.call(remap, lower)) {
      return remap[lower] + query + hash;
    }
    return url;
  }

  function shouldUsePglHeaderSound(pathname) {
    return /^\/(pdw|campaign|mailer|customize|wifi|report)(?:\/|$)/.test(pathname) || pathname === "/";
  }

  function shouldUseThemeHeaderSound(pathname) {
    return /^\/(pdw|gbu|campaign|mailer|customize|information)(?:\/|$)/.test(pathname);
  }

  function hasEmbeddedFlash(target) {
    if (!target || typeof target.querySelector !== "function") return false;
    return !!target.querySelector("object, embed, ruffle-player");
  }

  function normalizeLoginMember(member) {
    var m = ensureObject(member);
    m.pgl_name = m.pgl_name || "Offline Trainer";
    m.avator_id = m.avator_id || 1;
    m.rom_id = m.rom_id || "21";
    m.rom_name = m.rom_name || "Pokemon Black";
    m.trial_flag = m.trial_flag != null ? String(m.trial_flag) : "0";
    m.first_flag = m.first_flag != null ? String(m.first_flag) : "1";
    m.play_status = m.play_status != null ? String(m.play_status) : "2";
    m.sleeping_flag = m.sleeping_flag != null ? String(m.sleeping_flag) : "1";
    m.pokemon_name = m.pokemon_name || "Musharna";
    m.pokemon_no = m.pokemon_no != null ? m.pokemon_no : 518;
    m.form_no = m.form_no != null ? m.form_no : 0;
    m.nextstart_remaintime = m.nextstart_remaintime != null ? m.nextstart_remaintime : 0;
    var storedDisclosure = readStoredDisclosure();
    m.disclosure_flag = clampDisclosureValue(
      m.disclosure_flag,
      storedDisclosure ? storedDisclosure.disclosure_flag : 0
    );
    m.list_disclosure_flag = clampDisclosureValue(
      m.list_disclosure_flag,
      storedDisclosure ? storedDisclosure.list_disclosure_flag : m.disclosure_flag
    );
    if (m.list_disclosure_flag < m.disclosure_flag) {
      m.list_disclosure_flag = m.disclosure_flag;
    }
    writeStoredDisclosure(m.disclosure_flag, m.list_disclosure_flag);
    return m;
  }

  function normalizeProfileApi(api, data) {
    if (!api || typeof api !== "string") return data;
    if (api === "gbu.journal.season_list") {
      return ensureArray(data);
    }

    var d = ensureObject(data);
    if (api === "pgl.top.init") {
      d.member = normalizeLoginMember(d.member);
      d.medals = ensureArray(d.medals);
      d.token = d.token || "offline-token";
      return d;
    }

    var friendTemplate = {
      avator_id: 1,
      pgl_name: "Offline Friend",
      member_savedata_id: "100000001",
      disable_flag: "0",
      is_ds: true,
      country_code: "US",
      is_blocked: "0"
    };

    if (api === "pgl.top.index") {
      d.stats = ensureObject(d.stats);
      if (d.stats.pgl_population == null || d.stats.pgl_population === "") {
        d.stats.pgl_population = 0;
      }
      if (d.information == null) {
        d.information = null;
      } else {
        var topInfo = ensureObject(d.information);
        topInfo.information = topInfo.information != null ? String(topInfo.information) : "";
        d.information = topInfo;
      }
      return d;
    }

    if (api === "pgl.news.news_list") {
      var newsList = [];
      if (Array.isArray(data)) {
        newsList = data;
      } else if (Array.isArray(d.list)) {
        newsList = d.list;
      } else if (Array.isArray(d.news_list)) {
        newsList = d.news_list;
      }
      var normalizedNews = [];
      for (var newsIndex = 0; newsIndex < newsList.length; newsIndex += 1) {
        var news = ensureObject(newsList[newsIndex]);
        normalizedNews.push({
          news_id: news.news_id != null ? news.news_id : ("offline-" + (newsIndex + 1)),
          news_category_id: news.news_category_id != null ? news.news_category_id : 16,
          date: news.date != null ? String(news.date) : "",
          title: news.title != null ? String(news.title) : "Offline notice",
          new_flag: news.new_flag != null ? news.new_flag : 0,
          description: news.description != null ? String(news.description) : "",
          filename_top: news.filename_top || "",
          filename: news.filename || "",
          url_flag: news.url_flag != null ? news.url_flag : 0,
          url: news.url || "#",
          url_link_type: news.url_link_type != null ? news.url_link_type : 1
        });
      }
      return normalizedNews;
    }

    if (api === "gts.journal.trade_list") {
      d.trade_list = ensureArray(d.trade_list);
      return d;
    }

    if (api === "pgl.journal.census") {
      d.census_list = ensureArray(d.census_list);
      for (var censusIndex = 0; censusIndex < d.census_list.length; censusIndex += 1) {
        var census = ensureObject(d.census_list[censusIndex]);
        census.ranking_list = ensureArray(census.ranking_list);
        d.census_list[censusIndex] = census;
      }
      return d;
    }

    if (api === "pgl.member.profile.my_profile" || api === "pgl.member.profile.friend_profile") {
      d.avator_id = d.avator_id || 1;
      d.pgl_name = d.pgl_name || "Offline Trainer";
      d.country_name = d.country_name || "Offline";
      d.rom_name = d.rom_name || "Pokemon Black";
      d.rom_id = d.rom_id || "21";
      d.trial_flag = d.trial_flag || "0";
      d.player_badge_num = d.player_badge_num || 0;
      d.langcode = d.langcode || 2;
      d.trainer_name = d.trainer_name || "OFFLINE";
      d.playtime = d.playtime || "00:00";
      var storedDisclosure = readStoredDisclosure();
      d.disclosure_flag = clampDisclosureValue(
        d.disclosure_flag,
        storedDisclosure ? storedDisclosure.disclosure_flag : 0
      );
      d.list_disclosure_flag = clampDisclosureValue(
        d.list_disclosure_flag,
        storedDisclosure ? storedDisclosure.list_disclosure_flag : d.disclosure_flag
      );
      if (d.list_disclosure_flag < d.disclosure_flag) {
        d.list_disclosure_flag = d.disclosure_flag;
      }
      writeStoredDisclosure(d.disclosure_flag, d.list_disclosure_flag);
      d.friends = ensureArray(d.friends);
      d.friends_count = d.friends_count != null ? d.friends_count : d.friends.length;
      d.medals = ensureArray(d.medals);
      if (!d.friends.length) d.friends.push(friendTemplate);
      if (!d.friends_count) d.friends_count = d.friends.length;
      return d;
    }

    if (
      api === "pgl.member.profile.friend_list" ||
      api === "pgl.member.profile.friend_friend_list" ||
      api === "pgl.member.profile.pdw_friend_list" ||
      api === "pgl.member.profile.friend_pdw_friend_list"
    ) {
      d.list = ensureArray(d.list);
      if (!d.list.length) d.list.push(friendTemplate);
      d.cnt = d.cnt != null ? d.cnt : d.list.length;
      return d;
    }

    if (api === "pgl.member.profile.my_pdw_profile_by_pgl" || api === "pgl.member.profile.friend_pdw_profile_by_pgl") {
      d.island_id = d.island_id || 1;
      d.experiment_point = d.experiment_point || 0;
      d.pokemon_name = d.pokemon_name || "Musharna";
      d.pokemon_nickname = d.pokemon_nickname || "Musharna";
      d.level = d.level || 10;
      d.sex_id = d.sex_id != null ? d.sex_id : 1;
      d.pokemon_no = d.pokemon_no || 518;
      d.form_no = d.form_no || 0;
      d.oyaname = d.oyaname || "Offline Trainer";
      d.type1 = d.type1 || "psychic";
      d.type2 = d.type2 || "";
      d.personality = d.personality || "Serious";
      d.encount_pokemons = ensureArray(d.encount_pokemons);
      return d;
    }

    if (api === "pgl.member.profile.my_gbu_profile" || api === "pgl.member.profile.friend_gbu_profile") {
      d.ranking = ensureArray(d.ranking);
      if (!d.ranking.length) {
        d.ranking.push({ gsid: "0000-0000", rank: "-", rating: "-" });
      } else if (!d.ranking[0] || typeof d.ranking[0] !== "object") {
        d.ranking[0] = { gsid: "0000-0000", rank: "-", rating: "-" };
      } else if (!d.ranking[0].gsid) {
        d.ranking[0].gsid = "0000-0000";
      }
      d.worldbattle_history = ensureArray(d.worldbattle_history);
      d.worldbattle_status = ensureObject(d.worldbattle_status);
      d.worldbattle_status.condition = d.worldbattle_status.condition != null ? d.worldbattle_status.condition : "0";
      d.worldbattle_status.is_over_capacity = d.worldbattle_status.is_over_capacity != null ? d.worldbattle_status.is_over_capacity : "0";
      d.video_code = ensureArray(d.video_code);
      return d;
    }

    if (api === "gbu.worldbattle.get_battle_history") {
      d.my_profile = d.my_profile || null;
      d.opponent_profile_list = ensureArray(d.opponent_profile_list);
      return d;
    }

    if (api === "gts.profile.gts_history") {
      d.last_batchtime = d.last_batchtime || { yyyy: "2014", mm: "01", dd: "01", hh: "00", mi: "00" };
      d.gts_pokemon = d.gts_pokemon || null;
      d.want_pokemon = d.want_pokemon || null;
      d.trade_history = ensureArray(d.trade_history);
      d.bookmark_list = ensureArray(d.bookmark_list);
      return d;
    }

    if (api === "pgl.member.profile.gsid_list") {
      d.gsid_list = ensureArray(d.gsid_list);
      return d;
    }

    if (api === "pgl.member.profile.avator_list") {
      d.avator_list = ensureArray(d.avator_list);
      if (!d.avator_list.length) {
        d.avator_list.push({ avator_id: 1, avator_name: "Offline Trainer" });
      }
      return d;
    }

    if (api === "pgl.member.profile.video_regist" || api === "pgl.member.profile.video_delete") {
      d.video_code = ensureArray(d.video_code);
      return d;
    }

    return d;
  }

  function patchApiCalls() {
    if (!win.PGL || !win.PGL.prototype || win.PGL.prototype.__pglRuntimeApiPatched) return;
    var proto = win.PGL.prototype;
    if (typeof proto.getApi !== "function") return;

    var originalGetApi = proto.getApi;
    proto.getApi = function (api, param, callbacks, reloadOnError) {
      function wrapCallback(fn) {
        if (typeof fn !== "function") return fn;
        return function (data) {
          return fn.call(this, normalizeProfileApi(api, data));
        };
      }
      var wrappedCallbacks = callbacks;
      if (Array.isArray(callbacks)) {
        wrappedCallbacks = callbacks.map(wrapCallback);
      } else {
        wrappedCallbacks = wrapCallback(callbacks);
      }
      return originalGetApi.call(this, api, param, wrappedCallbacks, reloadOnError);
    };

    if (typeof proto.postApi === "function") {
      var originalPostApi = proto.postApi;
      var offlineWritableApiMap = {
        "pgl.member.profile.disclosure_switch": "disclosure_flag",
        "pgl.member.profile.list_disclosure_switch": "list_disclosure_flag"
      };
      function resolvedRequest(payload) {
        if (win.jQuery && typeof win.jQuery.Deferred === "function") {
          var dfd = win.jQuery.Deferred();
          dfd.resolve(payload);
          return dfd.promise();
        }
        return {
          done: function (fn) { if (typeof fn === "function") fn(payload); return this; },
          fail: function () { return this; },
          always: function (fn) { if (typeof fn === "function") fn(payload); return this; },
          complete: function (fn) { if (typeof fn === "function") fn(payload); return this; }
        };
      }
      proto.postApi = function (api, param, callback, reloadOnError) {
        if (offlineWritableApiMap[api]) {
          var key = offlineWritableApiMap[api];
          var nextValue = parseInt(param && param[key], 10);
          if (!isFinite(nextValue) || nextValue < 0) nextValue = 0;
          if (nextValue > 2) nextValue = 2;
          if (this.data && this.data.member) {
            this.data.member[key] = nextValue;
            if (key === "disclosure_flag") {
              var friendValue = parseInt(this.data.member.list_disclosure_flag, 10);
              if (!isFinite(friendValue) || friendValue < nextValue) {
                this.data.member.list_disclosure_flag = nextValue;
              }
            }
            writeStoredDisclosure(this.data.member.disclosure_flag, this.data.member.list_disclosure_flag);
          } else if (key === "disclosure_flag") {
            writeStoredDisclosure(nextValue, nextValue);
          } else {
            var storedDisclosure = readStoredDisclosure();
            writeStoredDisclosure(
              storedDisclosure ? storedDisclosure.disclosure_flag : 0,
              nextValue
            );
          }
          try {
            if (typeof callback === "function") callback.call(this, {});
          } catch (e) {}
          return resolvedRequest({});
        }
        return originalPostApi.call(this, api, param, callback, reloadOnError);
      };
    }

    win.PGL.prototype.__pglRuntimeApiPatched = true;
  }

  function patchSetState() {
    if (!win.PGL || !win.PGL.prototype || win.PGL.prototype.__pglSetStatePatched) return;
    if (typeof win.PGL.prototype._setState !== "function") return;
    var originalSetState = win.PGL.prototype._setState;
    win.PGL.prototype._setState = function (data) {
      return originalSetState.call(this, normalizeProfileApi("pgl.top.init", data));
    };
    win.PGL.prototype.__pglSetStatePatched = true;
  }

  function patchSwfObjectFlashCheck() {
    if (!win.swfobject) return;

    if (!win.swfobject.__pglFlashVersionPatched && typeof win.swfobject.hasFlashPlayerVersion === "function") {
      var originalHasFlash = win.swfobject.hasFlashPlayerVersion;
      win.swfobject.hasFlashPlayerVersion = function (version) {
        try {
          if (originalHasFlash.call(this, version)) return true;
        } catch (e) {}
        try {
          if (
            win.RufflePlayer ||
            win.__ruffle__ ||
            (win.customElements && typeof win.customElements.get === "function" && win.customElements.get("ruffle-player"))
          ) {
            return true;
          }
        } catch (e) {}
        return false;
      };
      win.swfobject.__pglFlashVersionPatched = true;
    }

    if (!win.swfobject.__pglEmbedSwfPatched && typeof win.swfobject.embedSWF === "function") {
      var originalEmbedSwf = win.swfobject.embedSWF;
      win.swfobject.embedSWF = function (url) {
        arguments[0] = normalizeRuntimeSwfUrl(url);
        var flashvars = arguments.length > 6 ? arguments[6] : null;
        if (flashvars && typeof flashvars === "object") {
          try {
            var langValue = flashvars.lang != null ? String(flashvars.lang) : "";
            if (!langValue || /127\.0\.0\.1|localhost|::1/i.test(langValue) || /\[object\s+Location\]/i.test(langValue)) {
              flashvars.lang = "/" + detectLogicalLanguage() + ".pokemon-gl.com/";
            }
          } catch (e) {}
        }
        return originalEmbedSwf.apply(this, arguments);
      };
      win.swfobject.__pglEmbedSwfPatched = true;
    }
  }

  function embedPglHeaderVolume(instance) {
    var target = win.document.getElementById("header-volume-swf");
    if (!target || hasEmbeddedFlash(target)) return;
    if (target.__pglVolumeEmbedAttempted || win.__pglHeaderVolumeEmbedAttempted) return;
    if (!win.swfobject || typeof win.swfobject.embedSWF !== "function") return;
    var logicalPath = getLogicalPathname();
    if (!shouldUsePglHeaderSound(logicalPath)) return;
    target.__pglVolumeEmbedAttempted = true;
    win.__pglHeaderVolumeEmbedAttempted = true;

    var flashvars = { color1: 0x000000, color2: 0x000000 };
    var level = instance && instance.level;
    var member = instance && instance.data && instance.data.member;
    if (level === 0) {
      flashvars.color1 = flashvars.color2 = 0xFFFFFF;
    } else if (member && (member.rom_id == "21" || member.rom_id == "23")) {
      flashvars.color1 = flashvars.color2 = 0xFFFFFF;
    }
    if (logicalPath === "/") flashvars.color1 = flashvars.color2 = 0xFFFFFF;

    try {
      win.swfobject.embedSWF(
        normalizeRuntimeSwfUrl(withPathHostPrefix("/src/swf/assets/global/swf/volume.swf")),
        "header-volume-swf",
        56,
        20,
        "10.0.0",
        null,
        flashvars,
        { wmode: "transparent", allowScriptAccess: "always" }
      );
    } catch (e) {}
  }

  function patchPglHeaderSound() {
    if (!win.PGL || !win.PGL.prototype || win.PGL.prototype.__pglHeaderSoundPatched) return;
    if (typeof win.PGL.prototype._initHtml2 !== "function") return;
    var originalInitHtml2 = win.PGL.prototype._initHtml2;
    win.PGL.prototype._initHtml2 = function () {
      this.pageHasSound = shouldUsePglHeaderSound(getLogicalPathname());
      var result = originalInitHtml2.apply(this, arguments);
      embedPglHeaderVolume(this);
      return result;
    };
    win.PGL.prototype.__pglHeaderSoundPatched = true;
  }

  function getThemeFlashVars(state) {
    switch (state) {
      case "logged-in-white":
        return { color1: "0x575757", color2: "0xA7A7A7" };
      case "logged-in-black":
        return { color1: "0xE9E9E9", color2: "0x575757" };
      default:
        return { color1: "0xA4C5DD", color2: "0x667281" };
    }
  }

  function patchThemePathFlags() {
    if (!win.theme) return;
    win.theme.page_has_flash = shouldUseThemeHeaderSound(getLogicalPathname());
  }

  function embedThemeHeaderVolume() {
    var target = win.document.getElementById("header-volume");
    if (!target || hasEmbeddedFlash(target)) return;
    if (win.document.getElementById("header-volume-swf")) return;
    if (target.__pglVolumeEmbedAttempted || win.__pglThemeVolumeEmbedAttempted) return;
    if (!win.swfobject || typeof win.swfobject.embedSWF !== "function") return;
    if (!shouldUseThemeHeaderSound(getLogicalPathname())) return;
    target.__pglVolumeEmbedAttempted = true;
    win.__pglThemeVolumeEmbedAttempted = true;
    var state = win.theme && win.theme.state ? String(win.theme.state) : "";
    try {
      win.swfobject.embedSWF(
        normalizeRuntimeSwfUrl(withPathHostPrefix("/src/swf/theme/assets/swf/volume.swf")),
        "header-volume",
        "56",
        "12",
        "9.0.0",
        null,
        getThemeFlashVars(state),
        { wmode: "transparent", allowScriptAccess: "always" }
      );
    } catch (e) {}
  }

  function installAudioUnlock() {
    if (win.__pglAudioUnlockInstalled) return;
    win.__pglAudioUnlockInstalled = true;

    var events = ["pointerdown", "mousedown", "touchstart", "keydown", "click"];
    var started = false;
    var timer = null;
    var attempts = 0;

    function tryResumeContext(candidate) {
      if (!candidate || typeof candidate.resume !== "function") return false;
      try {
        var result = candidate.resume();
        if (result && typeof result.then === "function") {
          result.catch(function () {});
        }
        return true;
      } catch (e) {
        return false;
      }
    }

    function attemptUnlock() {
      var touched = false;
      try {
        var nodes = win.document.querySelectorAll("ruffle-player, object, embed");
        for (var i = 0; i < nodes.length; i += 1) {
          var node = nodes[i];
          if (!node) continue;
          var keys = ["audioContext", "_audioContext", "context", "ctx"];
          for (var j = 0; j < keys.length; j += 1) {
            touched = tryResumeContext(node[keys[j]]) || touched;
          }
          if (typeof node.play === "function") {
            try { node.play(); touched = true; } catch (e) {}
          }
          if (typeof node.unmute === "function") {
            try { node.unmute(); touched = true; } catch (e) {}
          }
        }
      } catch (e) {}
      return touched;
    }

    function removeListeners() {
      for (var i = 0; i < events.length; i += 1) {
        win.document.removeEventListener(events[i], onGesture, true);
      }
    }

    function onGesture() {
      if (!started) {
        started = true;
        attempts = 0;
        attemptUnlock();
        timer = win.setInterval(function () {
          attempts += 1;
          attemptUnlock();
          if (attempts > 20) {
            win.clearInterval(timer);
            timer = null;
          }
        }, 500);
      }
      removeListeners();
    }

    for (var i = 0; i < events.length; i += 1) {
      win.document.addEventListener(events[i], onGesture, true);
    }
  }

  function patchTimeUtils() {
    if (!win.PGL || !win.PGL.Utils || win.PGL.Utils.__pglFormatTimePatched) return;
    if (typeof win.PGL.Utils.formatTime !== "function") return;
    var original = win.PGL.Utils.formatTime;
    win.PGL.Utils.formatTime = function (time, options) {
      if (time == null || time === "" || time === "null" || time === "undefined") {
        return "-";
      }
      if (typeof time === "string") {
        var match = /(\d+)\D(\d+)\D(\d+)(?:\D(\d+))?(?:\D(\d+))?(?:\D(\d+))?/.exec(time);
        if (!match) {
          return "-";
        }
      }
      try {
        return original.call(this, time, options);
      } catch (e) {
        return "-";
      }
    };
    win.PGL.Utils.__pglFormatTimePatched = true;
  }

  function patchAvatarUtils() {
    if (!win.PGL || !win.PGL.Utils || win.PGL.Utils.__pglAvatarUtilsPatched) return;
    if (typeof win.PGL.Utils.getAvatarImage !== "function") return;
    var original = win.PGL.Utils.getAvatarImage;
    win.PGL.Utils.getAvatarImage = function (id, size) {
      var parsed = parseInt(id, 10);
      if (!parsed || parsed < 1) parsed = 1;
      var img = original.call(this, parsed, size);
      if (img && typeof img.on === "function") {
        img.on("error", function () {
          if (this.__pglAvatarFallbackApplied) return;
          this.__pglAvatarFallbackApplied = true;
          this.src = "/profile/assets/images/avatar/1.png";
        });
      }
      return img;
    };
    win.PGL.Utils.__pglAvatarUtilsPatched = true;
  }

  function patchDisclosureDialog() {
    if (win.__pglDisclosureDialogPatched) return;
    win.__pglDisclosureDialogPatched = true;

    function nodeMatches(node, selector) {
      if (!node || !selector) return false;
      var fn = node.matches || node.msMatchesSelector || node.webkitMatchesSelector;
      if (!fn) return false;
      try {
        return fn.call(node, selector);
      } catch (e) {
        return false;
      }
    }

    function closestBySelector(node, selector) {
      var current = node;
      while (current && current !== win.document) {
        if (nodeMatches(current, selector)) return current;
        current = current.parentNode;
      }
      return null;
    }

    function toArray(nodeList) {
      var out = [];
      if (!nodeList) return out;
      for (var i = 0; i < nodeList.length; i += 1) out.push(nodeList[i]);
      return out;
    }

    function selectedIndex(items) {
      for (var i = 0; i < items.length; i += 1) {
        if (items[i] && items[i].classList && items[i].classList.contains("selected")) return i;
      }
      return -1;
    }

    function setSelected(items, index) {
      if (!items.length) return;
      var safeIndex = index;
      if (!isFinite(safeIndex) || safeIndex < 0) safeIndex = 0;
      if (safeIndex >= items.length) safeIndex = items.length - 1;
      for (var i = 0; i < items.length; i += 1) {
        if (!items[i] || !items[i].classList) continue;
        items[i].classList.toggle("selected", i === safeIndex);
      }
    }

    function normalizeDisclosureSelection() {
      var profileItems = toArray(win.document.querySelectorAll("#dialog-disclosure-profile li"));
      var friendItems = toArray(win.document.querySelectorAll("#dialog-disclosure-friend li"));
      if (!profileItems.length || !friendItems.length) return;

      for (var i = 0; i < profileItems.length; i += 1) {
        if (profileItems[i] && profileItems[i].classList) profileItems[i].classList.remove("disabled");
      }

      var profileIndex = selectedIndex(profileItems);
      if (profileIndex < 0) profileIndex = 0;
      setSelected(profileItems, profileIndex);

      var friendIndex = selectedIndex(friendItems);
      if (friendIndex < 0 || friendIndex < profileIndex) friendIndex = profileIndex;
      setSelected(friendItems, friendIndex);

      for (var j = 0; j < friendItems.length; j += 1) {
        if (!friendItems[j] || !friendItems[j].classList) continue;
        friendItems[j].classList.toggle("disabled", j < profileIndex);
      }
    }

    function bindDisclosureItems() {
      var profileItems = toArray(win.document.querySelectorAll("#dialog-disclosure-profile li"));
      var friendItems = toArray(win.document.querySelectorAll("#dialog-disclosure-friend li"));

      function bindItem(item, isFriend) {
        if (!item || item.__pglDisclosurePatched) return;
        item.__pglDisclosurePatched = true;
        item.addEventListener("click", function (evt) {
          if (isFriend && item.classList && item.classList.contains("disabled")) return;
          var siblings = item.parentNode ? item.parentNode.querySelectorAll("li") : [];
          for (var s = 0; s < siblings.length; s += 1) {
            if (siblings[s] && siblings[s].classList) siblings[s].classList.remove("selected");
          }
          if (item.classList) item.classList.add("selected");
          normalizeDisclosureSelection();
          if (evt && typeof evt.preventDefault === "function") evt.preventDefault();
          if (evt && typeof evt.stopPropagation === "function") evt.stopPropagation();
        }, true);
      }

      for (var i = 0; i < profileItems.length; i += 1) bindItem(profileItems[i], false);
      for (var j = 0; j < friendItems.length; j += 1) bindItem(friendItems[j], true);
    }

    function armDisclosureDialog() {
      bindDisclosureItems();
      normalizeDisclosureSelection();
    }

    win.document.addEventListener("click", function (evt) {
      var target = evt && evt.target;
      if (!target) return;
      if (closestBySelector(target, "#disclosure-change-button")) {
        win.setTimeout(armDisclosureDialog, 25);
        win.setTimeout(armDisclosureDialog, 180);
        return;
      }
      if (closestBySelector(target, "#dialog-disclosure")) {
        win.setTimeout(armDisclosureDialog, 0);
      }
    }, true);

    armDisclosureDialog();
  }

  function bypassIntroductionGate() {
    var logicalPath = getLogicalPathname();
    if (!/^\/introduction(?:\/|\/index\.html)?$/i.test(logicalPath)) return;
    var search = (win.location && typeof win.location.search === "string") ? win.location.search : "";
    if (/(?:^|[?&])keep_intro=1(?:&|$)/i.test(search)) return;
    var target = withPathHostPrefix("/");
    try {
      if (win.location && typeof win.location.replace === "function") {
        win.location.replace(target);
      }
    } catch (e) {}
  }

  function apply() {
    bypassIntroductionGate();
    patchSwfObjectFlashCheck();
    patchSetState();
    patchApiCalls();
    patchPglHeaderSound();
    patchThemePathFlags();
    embedPglHeaderVolume(null);
    embedThemeHeaderVolume();
    patchTimeUtils();
    patchAvatarUtils();
    patchDisclosureDialog();
    installAudioUnlock();
  }

  var tries = 0;
  var timer = win.setInterval(function () {
    tries += 1;
    apply();
    if (tries > 40) win.clearInterval(timer);
  }, 250);
  apply();
})(window);
