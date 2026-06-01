/* pgl-restore mock api interceptor */
(function (win) {
  "use strict";
  if (win.__pglMockApiInterceptorLoaded) return;
  win.__pglMockApiInterceptorLoaded = true;

  var endpointMap = {"/3ds.pokemon-gl.com/support/1/ja/xmlrpc.php":"/_restore/mock-api/3ds.pokemon-gl.com_support_1_ja_xmlrpc.php_96fad513.json","/3ds.pokemon-gl.com/support/2/de/xmlrpc.php":"/_restore/mock-api/3ds.pokemon-gl.com_support_2_de_xmlrpc.php_7e6788a5.json","/3ds.pokemon-gl.com/support/2/en/xmlrpc.php":"/_restore/mock-api/3ds.pokemon-gl.com_support_2_en_xmlrpc.php_d263f52e.json","/3ds.pokemon-gl.com/support/2/es/xmlrpc.php":"/_restore/mock-api/3ds.pokemon-gl.com_support_2_es_xmlrpc.php_40d4193c.json","/3ds.pokemon-gl.com/support/2/fr/xmlrpc.php":"/_restore/mock-api/3ds.pokemon-gl.com_support_2_fr_xmlrpc.php_66bb399d.json","/3ds.pokemon-gl.com/support/2/it/xmlrpc.php":"/_restore/mock-api/3ds.pokemon-gl.com_support_2_it_xmlrpc.php_aef64948.json","/api/":"/_restore/mock-api/api_4d365a49.json","/api/?p=account.com.monitor":"/_restore/mock-api/api_p_account.com.monitor_24056c2a.json","/api/?p=account.pdc.monitor":"/_restore/mock-api/api_p_account.pdc.monitor_2333ee85.json","/api/?p=pgl.news.news_list&news_category_id=16":"/_restore/mock-api/api_p_pgl.news.news_list_news_category_id_16_51aa348b.json","/api/?p=pgl.news.news_list&news_category_id=17":"/_restore/mock-api/api_p_pgl.news.news_list_news_category_id_17_26ad041d.json","/api/?p=pgl.top.init&ping=":"/_restore/mock-api/api_p_pgl.top.init_ping_4aa26cb1.json","/debug/api/account/com/footer.html":"/_restore/mock-api/debug_api_account_com_footer.html_4e2a672c.json","/status.json":"/_restore/mock-api/status.json_ed4472a4.json","/swf/json/":"/_restore/mock-api/swf_json_95d70e7d.json","/swf/json/used_pokemon_":"/_restore/mock-api/swf_json_used_pokemon_d232b800.json"};
  var apiParamMap = {};
  var genericMock = "/_restore/mock-api/generic.json";

  function serializeData(data) {
    if (!data) return "";
    if (typeof data === "string") return data;
    if (typeof data !== "object") return "";
    var out = [];
    for (var key in data) {
      if (!Object.prototype.hasOwnProperty.call(data, key)) continue;
      out.push(encodeURIComponent(key) + "=" + encodeURIComponent(data[key]));
    }
    return out.join("&");
  }

  function normalize(url, data) {
    try {
      var anchor = document.createElement("a");
      anchor.href = url;
      var isAbsolute = /^[a-z]+:\/\//i.test(url);
      var sameOrigin = !anchor.host || anchor.host === win.location.host;
      if (isAbsolute && !sameOrigin) {
        return url;
      }
      var path = anchor.pathname || "";
      path = path.replace(/\/{2,}/g, "/");
      if (/^\/(?:www\.)?cdn2?\.pokemon-gl\.com\/src\//i.test(path)) {
        path = path.replace(/^\/(?:www\.)?cdn2?\.pokemon-gl\.com\//i, "/");
      }
      var query = anchor.search || "";
      var dataQuery = serializeData(data);
      if (dataQuery) {
        if (query) {
          query += (query.indexOf("?") === -1 ? "?" : "&") + dataQuery;
        } else {
          query = "?" + dataQuery;
        }
      }
      return path + query;
    } catch (e) {
      return url;
    }
  }

  function extractApiName(url, data) {
    var normalized = normalize(url, data);
    var question = normalized.indexOf("?");
    if (question < 0) return "";
    var query = normalized.slice(question + 1);
    if (!query) return "";
    var pairs = query.split("&");
    for (var i = 0; i < pairs.length; i += 1) {
      var pair = pairs[i];
      if (!pair) continue;
      var eq = pair.indexOf("=");
      var rawKey = eq >= 0 ? pair.slice(0, eq) : pair;
      var rawValue = eq >= 0 ? pair.slice(eq + 1) : "";
      var key = decodeURIComponent(rawKey || "");
      if (key === "p") {
        return decodeURIComponent(rawValue || "");
      }
    }
    return "";
  }

  function resolve(url, data) {
    if (!url || typeof url !== "string") return url;
    var apiName = extractApiName(url, data);
    if (apiName) {
      if (apiParamMap[apiName]) return apiParamMap[apiName];
      var apiLower = apiName.toLowerCase();
      if (apiParamMap[apiLower]) return apiParamMap[apiLower];
    }

    var normalized = normalize(url, data);
    if (endpointMap[normalized]) return endpointMap[normalized];
    var pathOnly = normalized.split("?", 1)[0];
    if (endpointMap[pathOnly]) return endpointMap[pathOnly];
    if (/\/(api|ajax|service|services|json|rpc|ws)\b/i.test(pathOnly)) {
      return genericMock;
    }
    if (normalized && normalized.charAt(0) === "/") return normalized;
    return url;
  }

  if (typeof win.fetch === "function") {
    var originalFetch = win.fetch.bind(win);
    win.fetch = function (input, init) {
      if (typeof input === "string") {
        return originalFetch(resolve(input, init && init.body), init);
      }
      if (win.Request && input instanceof win.Request) {
        var rewrittenUrl = resolve(input.url, init && init.body);
        if (rewrittenUrl !== input.url) {
          return originalFetch(new win.Request(rewrittenUrl, input), init);
        }
      }
      return originalFetch(input, init);
    };
  }

  if (win.XMLHttpRequest && win.XMLHttpRequest.prototype) {
    var originalOpen = win.XMLHttpRequest.prototype.open;
    var originalSend = win.XMLHttpRequest.prototype.send;
    win.XMLHttpRequest.prototype.open = function (method, url) {
      this.__pglMockOriginalMethod = method;
      this.__pglMockOriginalUrl = url;
      this.__pglMockOpenAsync = arguments.length > 2 ? arguments[2] : true;
      var resolvedUrl = resolve(url, null);
      this.__pglMockResolvedUrl = resolvedUrl;
      arguments[1] = resolvedUrl;
      return originalOpen.apply(this, arguments);
    };
    win.XMLHttpRequest.prototype.send = function (body) {
      try {
        if (typeof this.__pglMockOriginalUrl === "string") {
          var resolvedWithBody = resolve(this.__pglMockOriginalUrl, body);
          if (resolvedWithBody && resolvedWithBody !== this.__pglMockResolvedUrl) {
            originalOpen.call(this, "GET", resolvedWithBody, this.__pglMockOpenAsync);
            this.__pglMockResolvedUrl = resolvedWithBody;
            body = null;
          }
        }
      } catch (e) {}
      return originalSend.call(this, body);
    };
  }

  function patchJQuery() {
    var $ = win.jQuery;
    if (!$ || !$.ajaxPrefilter || win.__pglMockApiJqueryPatched) return;
    win.__pglMockApiJqueryPatched = true;
    $.ajaxPrefilter(function (options) {
      if (options && typeof options.url === "string") {
        var resolved = resolve(options.url, options.data);
        if (resolved !== options.url) {
          options.url = resolved;
          options.type = "GET";
          options.data = undefined;
          options.processData = false;
        }
      }
    });
  }

  var tries = 0;
  var timer = win.setInterval(function () {
    tries += 1;
    patchJQuery();
    if (tries > 20) win.clearInterval(timer);
  }, 300);
  patchJQuery();
})(window);
