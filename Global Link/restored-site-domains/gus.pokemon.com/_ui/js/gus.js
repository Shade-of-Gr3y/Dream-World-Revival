var ExitWarning = {
        init:function() {
                // VARS
                this.url = undefined;
                
                // ELEMENT REFERENCES
                this.elWindow = $('div#exitWarning');
                this.elContinueBtn = $('a:eq(0)',this.elWindow);
                this.elCancelBtn = $('a:eq(1)',this.elWindow);
                
                // SETUP
                this.elContinueBtn.attr('target', '_blank');
                this.elCancelBtn.removeAttr('href');
                
                // EVENT HANDLERS
                this.elCancelBtn.click(function() { ExitWarning.hide(); });
                this.elContinueBtn.click(function() { ExitWarning.hide(); });
        },
        show:function() {
                $('#gus').addClass('bumper');
                this.elWindow.parent().show();
        },
        hide:function() {
                this.elWindow.parent().hide();
                $('#gus').removeClass('bumper');
        },
        setURL:function(url) {
                this.url = url;
                this.elContinueBtn.attr('href', this.url);
        }
};


$(document).ready( function(){

    ExitWarning.init();
    $('a').each(function(index, elem) {
        if (this.hostname && (this.hostname != window.location.hostname)) {
            var found = false;
            for (var i=0; i < whitelist.length; i++) {
                if (this.hostname.indexOf(whitelist[i],this.hostname.length-whitelist[i].length) !== -1) {
                    found = true;
                    break;
                }
            }
            if (!found) {
                $(this).addClass('external');
            }
        }
    });
    $('a.external').click(function(ev) {
        ev.preventDefault();
        var href = this.getAttribute('href');
        ExitWarning.setURL(href);
        ExitWarning.show();
    });

} );
