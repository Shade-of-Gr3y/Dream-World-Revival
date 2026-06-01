

$(window).load(function() {
    $("#stretch").ezBgResize();
	
});
$(window).resize(function() {
    $("#stretch").ezBgResize(true);
   // setContentMargin();
    //resizeGalleryItems();
    //$.fancybox.center()
});
/*$(window).scroll(function() {
    var b = $(window).scrollTop();
    var d = $("#stretch").height();
    if (b < d) {
        var f = d - b;
        var a = 100 - (Math.ceil((f / d) * 100));
        a = a * 2;
        $("#stretch img").css("margin-top", "-" + a + "px")
    }
    if ((b + d) >= $(".vimeo").offset().top) {
        f = (($(".vimeo").offset().top) - (b + d));
        if (f <= ($(window).height() + $(".vimeo").height())) {
            var e = 100 - ((f / ($(window).height() + $(".vimeo").height())) * 100);
            e = e * 2;
            e += 600;
            $(".vimeo").css("background-position", "center -" + e + "px")
        }
    }
    if ((b + d) >= $(".contact").offset().top) {
        f = (($(".contact").offset().top) - (b + d));
        if (f <= ($(window).height() + $(".contact").outerHeight())) {
            var c = 100 - ((f / ($(window).height() + $(".contact").outerHeight())) * 100);
            c = c * 2;
            c -= 200;
            $(".contact").css("background-position", "center -" + c + "px")
        }
    }
});
*/
/*$(function() {
    var a = 1000;
    $("body").removeClass("no-js");
    setContentMargin();
    resizeGalleryItems();
    bgInterval = setInterval(function() {
        loadBackgrounds()
    },
    3000);
    bgRotateInterval = setInterval(function() {
        rotateBackgrounds()
    },
    7500);
    $("#head").bind("click",
    function() {
        $(window).scrollTo(0, a);
        return false
    });
    $(".nav a[href=#photos]").bind("click",
    function() {
        $(window).scrollTo(".photos", a);
        return false
    });
    $(".nav a[href=#showreel]").bind("click",
    function() {
        $(window).scrollTo(".vimeo", a);
        return false
    });
    $(".nav a[href=#reviews]").bind("click",
    function() {
        $(window).scrollTo(".reviews", a);
        return false
    });
    $(".nav a[href=#contact]").bind("click",
    function() {
        $(window).scrollTo(".contact", a);
        return false
    });
    $(".photos a").hover(function() {
        var b = $(this);
        $("<span></span>", {
            "class": "hover-top-down"
        }).appendTo(b);
        $("<span></span>", {
            "class": "hover-left-right"
        }).appendTo(b)
    },
    function() {
        $(this).find("span").each(function() {
            $(this).remove()
        })
    });
    $(".photos a").fancybox({
        overlayOpacity: 0.85,
        overlayColor: "#000",
        padding: 0,
        margin: 0
    });
    $(".contact form").bind("submit",
    function() {
        $.ajax({
            type: "POST",
            data: "contact=" + $(".contact form textarea").val(),
            dataType: "json",
            url: "contact.php",
            success: function(b) {
                console.log(b);
                if (b.success) {
                    $(".contact button").stop().css("visibility", "hidden").attr("disabled", "disabled");
                    $(".contact textarea").val("Sent! Thank you").attr("disabled", "disabled").addClass("disabled")
                } else {
                    if (b.email_error) {
                        $(".contact button").stop().css("visibility", "hidden").attr("disabled", "disabled");
                        $(".contact textarea").val("Email service is temporarily down, please use the address below.").attr("disabled", "disabled").addClass("disabled")
                    } else {
                        if (b.form_errors.contact) {
                            $(".contact textarea").addClass("error")
                        }
                    }
                }
            },
            error: function(b) {
                $(".contact button").stop().css("visibility", "hidden").attr("disabled", "disabled");
                $(".contact textarea").val("Email service is temporarily down, please use the address below.").attr("disabled", "disabled").addClass("disabled")
            }
        });
        return false
    });
    $(".contact form textarea").bind("keydown",
    function(b) {
        if ($(this).val() != "" && $(this).hasClass("error")) {
            $(this).removeClass("error")
        }
    })
});
*/
function resizeGalleryItems() {
    var a = 250;
    var c = 3;
    var d = $(window).width() - 259;
    var b = Math.floor(d / c);
    while (b > a) {
        c++;
        b = Math.floor(d / c)
    }
    $(".photos ul li a img").css("width", b + "px").css("height", b + "px");
    $(".photos ul li a").css("width", b + "px").css("height", b + "px")
}
function setContentMargin() {
    $("#content").css("margin-top", $(window).height() + "px");
    $(".contact").css("height", ($(window).height() - 50) + "px")
}
var bgInterval = null;
var bgRotateInterval = null;
function loadBackgrounds() {
    var b = $("#stretch");
    var a = b.find("img").length;
    a++;
    if (a > 4) {
        clearInterval(bgInterval)
    } else {
        $("<img></img>", {
            src: "images/backgrounds/" + a + ".jpg",
            rel: a
        }).appendTo(b).load(function() {
            $(this).addClass("loaded");
            $("#stretch").ezBgResize(true)
        })
    }
}
function rotateBackgrounds() {
    var c = $("#stretch");
    var d = c.find(".current");
    var b = parseInt(d.attr("rel")) + 1;
    if (b > 4) {
        b = 1
    }
    var a = c.find("img[rel=" + b + "]");
    if (a.length && a.hasClass("loaded")) {
        d.removeClass("current").stop().fadeOut(2000);
        c.find("img[rel=" + b + "]").addClass("current").stop().fadeIn(2000,
        function() {
            if ($(this).css("opacity") == 0) {
                $(this).css("opacity", 1)
            }
        })
    }
};