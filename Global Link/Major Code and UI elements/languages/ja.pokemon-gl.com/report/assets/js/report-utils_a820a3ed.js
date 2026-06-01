
(function () {
  if ('IE'.substr(-1) == 'IE') {
    var s = String.prototype.substr;
    String.prototype.substr = function (f, t) {
      if (f < 0) {
        return s.call(this, this.length + f);
      } else {
        return s.apply(this, arguments);
      }
    }
  }
})();


$.fn.extend({
  // ポケモン表示関数 集約版
  pokemon: function (options) {
    var pokemon = options.pokemon || PGL.Report.getPokemonByPokedex(options.pokedex);
    if (pokemon) {
      this.find('.pokedex,.pokedex .value').filter(':last').text(PGL.Utils.zerofill(pokemon.pokedex, 3));
      var image = this.children('.image');
      if (image.length) {
        var form = parseInt(options.form || 0);
        var code = PGL.Utils.zerofill((0x159a55e5 * (pokemon.pokedex + form * 0x10000) & 0xFFFFFF).toString(16), 6);
        image.empty();
        var img = $('<img/>').appendTo(image);
        var size = parseInt(img.css('width'));
        var imagesDir = 'http://' + PGL.Report.host.getPageAssetHost() + '/src/swf/assets/global/images/';
        img.attr({ src:imagesDir + 'block.png' });
        img.css({ 'background-position':(parseInt(img.css('width')) / 2) + 'px ' + (parseInt(img.css('height')) / 2) + 'px' });
        img.css({ 'background-image':'url(' + imagesDir + 'pokemons/' + size + (options.reflect ? 'ref' : '') + '/' + code + '.png)' });
        // fix Android image size issue
        if (navigator.userAgent.indexOf('Android') != -1) {
          img.css({ border:'1px solid transparent' });
        }
      }
      this.find('.name .value').text(pokemon[PGL.language] || '');
      
      if (PGL.language == 'en') {
        var w = pokemon.lb, h = pokemon.ft;
      } else {
        var w = pokemon.kg, h = pokemon.m;
        if ({ it:true, es:true }[PGL.language]) {
          w = w.replace(/kg/, ' kg');
          h = h.replace(/m/, ' m');
        }
      }
      this.find('.height .value').text(PGL.Utils.formatNumber(h));
      this.find('.weight .value').text(PGL.Utils.formatNumber(w));
      this.find('.types').children('ol,ul').empty().append(
        $('<li></li>').addClass('type-' + pokemon.types[options.form || 0][0]),
        $('<li></li>').addClass('type-' + (pokemon.types[options.form || 0][1] || 0))
      );
    }
    if (options.level !== undefined) {
      this.find('.level .value').text(options.level || '');
    }
    if (options.sex !== undefined) {
      this.find('.sex').removeClass('sex-0 sex-1 sex-2').addClass('sex-' + options.sex).text(['♂', '♀', ''][options.sex]);
    }
    if (options.item !== undefined) {
      this.find('.item .value').text(options.item || '');
    }
    if (options.moves !== undefined) {
      var list = this.find('.moves').children('ol,ul').empty();
      $.each(options.moves, function (index, move) {
        var li = $('<li></li>').appendTo(list);
        $('<span class="type"></span>').addClass('type-' + (move.type || 0)).appendTo(li);
        $('<span class="move"></span>').text(move.name || 'なし').appendTo(li);
      });
    }
    return this;
  },
  recordResult: function (result) {
    var match = ('' + result).match(/(\D*)(\d*)(\D*)/);
    $(this).empty().append(
      $('<span></span>').text(match[1]),
      $('<span class="value"></span>').text(PGL.Utils.formatNumber(match[2])),
      $('<span></span>').text(match[3])
    );
    return this;
  },
  rotateText: function () {
    var self = this;
    this.queue(function () {
      var allIndex = 0;
      $.each(self.add(self.find('*')).not(':has(*)'), function (index, elem) {
        var text = $(elem).text();
        $(elem).empty();
        $.each(text.split(''), function (index, c) {
          var delay = (allIndex + 3) * 2;
          setTimeout(function () {
            var count = 0;
            var span = $('<span></span>').text(c).appendTo(elem);
            if (c.match(/\d/)) {
              rot('0123456789');
            } else if (c.match(/[a-z]/)) {
              rot('abcdefghijklmnopqrstuvwxyz');
            } else if (c.match(/[A-Z]/)) {
              rot('ABCDEFGHIJKLMNOPQRSTUVWXYZ');
            } else if (c.match(/[ぁ-ん]/)) {
              rot('あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよわをん');
            } else if (c.match(/[ァ-ン]/)) {
              rot('アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨワヲン');
            } else if (c.match(/[\u1100-\u11f9\u3131-\u318e\uac00-\ud7a3]/)) {
              rot(44032, 55203);
            }
            function rot(from, to) {
              if (count < delay) {
                if (to) {
                  span.text(String.fromCharCode(Math.floor(from + Math.random() * (to - from))));
                } else {
                  span.text(from.charAt(Math.floor(Math.random() * from.length)));
                }
                setTimeout(function () { rot(from, to); }, 30);
                count++;
              } else {
                span.text(c);
              }
            }
          }, 0);
          allIndex++;
        });
      });
      setTimeout(function () {
        self.dequeue();
      }, allIndex * 60);
    });
    return this;
  }
});


PGL.Report = PGL.Report || function () {};
PGL.Report.host = new PGL.Host();
PGL.Report.extendRaphael = function (paper) {
  var ip = function (a, b, p) {
    return a + (b - a) * p;
  };
  $.extend(paper.customAttributes, {
    pie:function (x, y, a1, a2, outerRadius, innerRadius) {
      var flag = (a2 - a1) > Math.PI;
      var r1 = innerRadius || 0, r2 = outerRadius, r3 = outerRadius - innerRadius;
      return {
        path:[
          ['M', Math.cos(a1) * r2 + x, Math.sin(a1) * r2 + y],
          ['A', r2, r2, 0, +flag, 1, x + r2 * Math.cos(a2), y + r2 * Math.sin(a2)],
          ['l', Math.cos(a2) * -r3, Math.sin(a2) * -r3],
          ['A', r1, r1, 0, +flag, 0, x + r1 * Math.cos(a1), y + r1 * Math.sin(a1)],
          ['z']
        ]
      };
    },
    gtsTradeLine:function (x1, y1, x2, y2, roundness, opacity, progress) {
      var cx = (x1 + x2) / 2, cy = (y1 + y2) / 2;
      if (x1 < x2) {
        cx += (y2 - y1) * roundness;
        cy -= (x2 - x1) * roundness;
      } else {
        cx -= (y2 - y1) * roundness;
        cy += (x2 - x1) * roundness;
      }
      if (progress < 1) {
        var p = progress;
        var tx = ip(x1, cx, p), ty = ip(y1, cy, p);
        var path = [
          ['M', x1, y1],
          ['Q', tx, ty, ip(tx, ip(cx, x2, p), p), ip(ty, ip(cy, y2, p), p)]
        ];
      } else {
        var p = progress - 1;
        var tx = ip(cx, x2, p), ty = ip(cy, y2, p);
        var path = [
          ['M', ip(ip(x1, cx, p), tx, p), ip(ip(y1, cy, p), ty, p)],
          ['Q', tx, ty, x2, y2]
        ];
        opacity *= Math.min(1, 2 - p * 2);
      }
      return { path:path, opacity:opacity };
    },
    gtsTradePoint:function (x1, y1, x2, y2, roundness, progress) {
      var cx = (x1 + x2) / 2, cy = (y1 + y2) / 2;
      if (x1 < x2) {
        cx += (y2 - y1) * roundness;
        cy -= (x2 - x1) * roundness;
      } else {
        cx -= (y2 - y1) * roundness;
        cy += (x2 - x1) * roundness;
      }
      var p = progress;
      return {
        x:ip(ip(x1, cx, p), ip(cx, x2, p), p),
        y:ip(ip(y1, cy, p), ip(cy, y2, p), p)
      };
    },
    gbuBattleLine:function (x1, y1, x2, y2, progress) {
      var dx = (x2 - x1) * progress / 2, dy = (y2 - y1) * progress / 2;
      return { path: [
        ['M', x1, y1],
        ['l', dx, dy],
        ['M', x2, y2],
        ['l', -dx, -dy]
      ] };
    }
  });
};



