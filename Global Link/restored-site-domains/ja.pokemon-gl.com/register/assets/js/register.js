

(function () {
  var squeezeTextQueue = $();
  setInterval(function () {
    squeezeTextQueue.filter(':visible').each(function () {
      squeezeTextQueue = squeezeTextQueue.not(this);
      $(this).squeezeText();
    });
  }, 200);
  $.fn.extend({
    squeezeText: function (text) {
      if (this.length > 1) {
        $.each(this, function () {
          $(this).squeezeText(text);
        });
      } else if (this.parent().length) {
        if (arguments.length > 0) {
          this.text(text);
        }
        if (this.is(':hidden')) {
          squeezeTextQueue = squeezeTextQueue.add(this);
        } else {
          var targetWidth = this.width();
          var span = this.children('.squeeze-text');
          if (span.length == 0) {
            span = this.wrapInner($('<span class="squeeze-text"></span>')).children('.squeeze-text');
          }
          span.css({ 'white-space':'nowrap', 'letter-spacing':0 });
          var size = parseInt(this.css('font-size')) || 12;
          for (var i=size; i>=10 && targetWidth < span.width(); i--) {
            span.css({ 'font-size':i, 'letter-spacing':-1 });
          }
        }
      }
      return this;
    }
  });
})();


$.extend(PGL.prototype, {
  completeRegister: function() {
		var match = location.search.match(/prev_url=([^&]+)/);
		location = match ? decodeURIComponent(match[1]) : '/';
  }
});

PGL.setMain(function() {
	var that = this;

	if (this.level != PGL.NOT_SIGNED_UP) {
		this.completeRegister();
		return;
	}
  
  $('#header-logout').show();
  $('#header-back-to-top').hide();
  
	$('input[name=gscd]').each(function () {
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
	
	$('#step1-next-button').click(function () {
		var pgl_name = $('input[name=pgl_name]').val();
		var gscd = $('input[name=gscd]').val();
		that.getApi('pgl.member.profile.init_create_confirm', { pgl_name:pgl_name, gscd:gscd }, function (data) {
			
			var uodateView = function () {
				$('.overlay').remove();
				$('#name_preview').squeezeText(pgl_name);
				$('#gscd_preview').text(gscd);
				$('#step1').fadeOut(300, function () { $('#step2').fadeIn(300); });
			};
			if (gscd) {
				that.getApi('pgl.member.profile.rom_check', { gscd:gscd }, function (data) {
					uodateView();
					var src = '/en.pokemon-gl.com/top/assets/' + PGL.language + '/images/rom-image-' + { 20:'w', 21:'b', 22:'w2', 23:'b2' }[data.rom_id] + '.png';
					$('#logo_preview').empty().append($('<img/>').attr({ src:src }));
					$('#logo_preview').removeClass('rom20 rom21 rom22 rom23').addClass('rom' + (data.rom_id || '23'));
				}, function (error) {
					$('.overlay').remove();
					that.showDialog(error, { ok:true });
				})
			} else {
				$('#logo_preview').removeClass('rom20 rom21 rom22 rom23');
				$('#logo_preview').empty();
				uodateView();
			}
		}, function (error) {
			$('.overlay').remove();
			that.showDialog(error, { ok:true });
		});
		$('<div class="overlay"></div>').appendTo(document.body);
	});
	$('#step2-next-button').click(function () {
		var pgl_name = $('input[name=pgl_name]').val();
		var gscd = $('input[name=gscd]').val();
		that.postApi('pgl.member.profile.init_create', { pgl_name:pgl_name, gscd:gscd }, function (data) {
			$('.overlay').remove();
			var level = data.flg;
			$('.for-level-0').hide();
			$('.for-level-1').hide();
			$('.for-level-2').hide();
			$('.for-level-' + level).show();
			$('#step2').fadeOut(300, function () { $('#step3').fadeIn(300); });
			$('.your-gscd').text(gscd);
		}, function (error) {
			$('.overlay').remove();
			that.showDialog(error, { ok:true });
		});
		$('<div class="overlay"></div>').appendTo(document.body);
	});
	$('#step2-prev-button').click(function () {
		$('#step2').fadeOut(300, function () { $('#step1').fadeIn(300); });
	});
	$('#step3-next-button').click(function () { that.completeRegister() });
});


