/* pgl-restore plugin guards */
(function (win) {
  "use strict";
  if (win.__pglPluginGuardsLoaded) return;
  win.__pglPluginGuardsLoaded = true;

  function applyGuards() {
    var $ = win.jQuery || win.$;
    if (!$) return;
    if (!$.fn) $.fn = {};

    var noopPlugins = ["corner", "transit", "hashchange", "ezBgResize", "bgResize"];
    for (var i = 0; i < noopPlugins.length; i += 1) {
      var name = noopPlugins[i];
      if (typeof $.fn[name] !== "function") {
        $.fn[name] = function () { return this; };
      }
    }
    if (typeof $.blockUI !== "function") $.blockUI = function () {};
    if (typeof $.unblockUI !== "function") $.unblockUI = function () {};
  }

  function ensureGlobals() {
    if (!win.swfobject) {
      win.swfobject = {
        embedSWF: function () {},
        hasFlashPlayerVersion: function () { return false; }
      };
    }
  }

  ensureGlobals();
  var tries = 0;
  var timer = win.setInterval(function () {
    tries += 1;
    applyGuards();
    if (tries > 20) {
      win.clearInterval(timer);
    }
  }, 300);
  applyGuards();
})(window);
