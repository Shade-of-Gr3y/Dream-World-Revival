var is_loaded = false;
var is_pageload = true;
$.extend(PGL.prototype, {
  makeList: function(data) {
	var cnt1 = cnt2 = cnt3 = 0;
	$("#type1").append("<div style='display:none;' id='no_contest1' class='worldbattle_list_mini'><div class='worldbattle_mini'><span class='empty'>エントリー可能な大会はありません。</span></div></div>");
	$("#type2").append("<div style='display:none;' id='no_contest2' class='worldbattle_list_mini'><div class='worldbattle_mini'><span class='empty'>開催中（参加中）の大会はありません。</span></div></div>");
	$("#type3").append("<div style='display:none;' id='no_contest3' class='worldbattle_list_mini'><div class='worldbattle_mini'><span class='empty'>最近終了した大会はありません。</span></div></div>");
	
	for(var i = 0; i < data.length; i++)
	{
		var type = "#type1";
		if(data[i].cup_status == 4){
			cnt2 = 1; type = "#type2";
		}
		else if(data[i].is_entry == 1 || (data[i].is_open == 1 && data[i].cup_status == 2))
		{
			cnt1 = 1; type = "#type1";
		}
		else if(data[i].is_open == 1 && (data[i].cup_status == 1 || data[i].cup_status == 3 || data[i].cup_status == 4))
		{
			cnt2 = 1; type = "#type2";
		}
		else
		{
			switch(data[i].cup_status)
			{
				case 5:
				case 6:
					cnt3 = 1; type = "#type3";
			}
		}
		var w_serial_id = data[i].worldbattle_serial_id;
		$(type).append("<div class='worldbattle linkbox' style='display:none;'><div class='selector clearfix'>" +
							"<div class='banner'><img src='"+data[i].worldbattle_banner+"' width='420' height='140'/></div>" +
							"<div class='info'>" +
							"<div class='status block'><img src='assets/ja/images/bg_status_"+data[i].cup_status+".gif' /></div>" + 
							"<div class='worldbattle_name block'>"+data[i].worldbattle_name+"</div>" + 
							"<div class='term clearfix'><table><tr>" + 
							"<td class='fs12 w80'><img src='assets/ja/images/txt_contest_term.gif'/></td>" + 
							"<td class='fs11 w340'>" + 
							"<table><tr><td>"+data[i].open_date_from_jst + "(JST) - " + data[i].open_date_to_jst +"(JST)</td>" + 
							"</tr><tr><td>"+data[i].open_date_from + "(UTC) - " + data[i].open_date_to +"(UTC)</td>" + 
							"</tr></table></td></tr></table>" + 
							"<input type='hidden' name='w_serial_id' value='"+w_serial_id+"'>" + 
							"<input type='hidden' name='w_id' value='"+data[i].worldbattle_id+"'>" + 
							"</div></div></div></div>"
		);
		$(".worldbattle").show();
	}
	if(cnt1 == 0){
		$("#no_contest1").show();
	}else {$("#no_contest1").remove();}
	if(cnt2 == 0){
		$("#no_contest2").show();
	}else {$("#no_contest2").remove();}
	if(cnt3 == 0){
		$("#no_contest3").show();
	}else {$("#no_contest3").remove();}
		
	$(".loading","#type1").remove();
	$(".loading","#type2").remove();
	$(".loading","#type3").remove();
	$(".worldbattle").click(function() {
		$('#worldbattle_serial_id').val($("input[name='w_serial_id']",this).val());
		$('#worldbattle_id').val($("input[name='w_id']",this).val());
		window.location.href = ("/wifi/#entry?wsid="+$("input[name='w_serial_id']",this).val()+"&wid="+$("input[name='w_id']",this).val());
	});
	$(".worldbattle .selector").hover(
			function () {
				$(this).addClass("worldbattle_hover");
				$(this).find(".worldbattle_name").addClass("name_hover");
			},
			function () {
				$(this).removeClass("worldbattle_hover");
				$(this).find(".worldbattle_name").removeClass("name_hover");
			}
		);
  },
  makeDetail: function(data) {
		var obj = data.worldbattle;
		$("#cup_status img").attr("src","assets/ja/images/bg_status_"+obj.cup_status+".gif");
		$("#status").val(obj.cup_status);
		$("#worldbattle_name").text(obj.worldbattle_name);
		$("#worldbattle_name_rom").text(obj.worldbattle_name_rom);
		$("#worldbattle_banner").empty();
		$("#worldbattle_banner").append("<img src='http://"+location.hostname+obj.worldbattle_banner+"' width='420' height='140'/>");
		$("#summary1").text(obj.worldbattle_summary1);
		$("#summary2").text(obj.worldbattle_summary2);
		$("#public_date").text(obj.public_date_from_jst +"(JST) - "+ obj.public_date_to_jst+"(JST),"+obj.public_date_from +"(UTC) - "+ obj.public_date_to+"(UTC)");
		$("#open_date").text(obj.open_date_from_jst +"(JST) - "+ obj.open_date_to_jst+"(JST),"+obj.open_date_from +"(UTC) - "+ obj.open_date_to+"(UTC)");
		$("#regulation").val(obj.regulation);
		$("#manual_url").val(obj.manual_url);
		$("#url").val(obj.url);
		$("#target").val(obj.url_link_type);

		$(".contents").show(0);
		if(location.href.indexOf("#") < 0){
			this.showEntryForm(obj.cup_status,false);
		}else {
			var hash = location.href;
			tmp = hash.replace(/^.*#/, '');
			hashes =tmp.split("?");
			switch(hashes[0]){
				case "entry":
					this.showEntryForm(obj.cup_status,false);
					break;
				case "confirm":
					this.showEntryForm(obj.cup_status,true);
					break;
				case "complete":
					this.showEntryForm(1,true);
					break;
			}
		}
	  },
	  showEntryForm:function(status,is_entry){
		  	var params = getUrlVars();
		    var wid    = $("#wid").val();
		    var wsid   = $("#wsid").val();
		  	var that = this;
			//受付中
			var entry_0 = '<div id="form1"><div class="btn1"><ul class="clearfix">' +
								'<li><a href="javascript:void(0);" onclick="goInfo(1)"><img src="assets/ja/images/btn_infomation_off.gif" class="roll" alt="大会情報"/></a></li>' + 
								'<li><a href="javascript:void(0);" onclick="goInfo(2)"><img src="assets/ja/images/btn_regulation_off.gif" class="roll" alt="重要事項・レギュレーション"/></a></li>' + 
								'<li><a href="javascript:void(0);" onclick="goInfo(3)"><img src="assets/ja/images/btn_setting_off.gif" class="roll" alt="ゲームソフトの設定・操作"/></a></li></ul>' + 
								'</div><div class="btn2"><ul class="clearfix">' + 
								'<li><a id="go-entry" rel="entry" href="#confirm?wid='+wid+'&wsid='+wsid+'"><img src="assets/ja/images/btn_go_entry_off.gif" class="roll" alt="エントリーに進む"/></a></li></ul></div></div>';
			//エントリー中
			var entry_1 = '<div id="form1"><div class="btn1"><img src="assets/ja/images/txt_msg1.gif"/></div><div class="btn1"><ul class="clearfix">' +
								'<li><a href="javascript:void(0);" onclick="goInfo(1)"><img src="assets/ja/images/btn_infomation_off.gif" class="roll" alt="大会情報"/></a></li>' + 
								'<li><a href="javascript:void(0);" onclick="goInfo(2)"><img src="assets/ja/images/btn_regulation_off.gif" class="roll" alt="重要事項・レギュレーション"/></a></li>' + 
								'<li><a href="javascript:void(0);" onclick="goInfo(3)"><img src="assets/ja/images/btn_setting_off.gif" class="roll" alt="ゲームソフトの設定・操作"/></a></li></ul>' + 
								'</div><div class="btn3"></div>';
			//受付終了
			var entry_2 = '<div id="form2"><div class="btn1"><img src="assets/ja/images/txt_msg2.gif"/></div><div class="btn1"><ul class="clearfix">' +
								'<li><a href="javascript:void(0);" onclick="goInfo(1)"><img src="assets/ja/images/btn_infomation_off.gif" class="roll" alt="大会情報"/></a></li>' + 
								'<li><a href="javascript:void(0);" onclick="goInfo(2)"><img src="assets/ja/images/btn_regulation_off.gif" class="roll" alt="重要事項・レギュレーション"/></a></li>' + 
								'</div><div class="btn3"></div>';
			//参加中
			var entry_3 = '<div id="form1"><div class="btn1"><img src="assets/ja/images/txt_msg3.gif"/></div><div class="btn1"><ul class="clearfix">' +
								'<li><a href="javascript:void(0);" onclick="goInfo(1)"><img src="assets/ja/images/btn_infomation_off.gif" class="roll" alt="大会情報"/></a></li>' + 
								'<li><a href="javascript:void(0);" onclick="goInfo(2)"><img src="assets/ja/images/btn_regulation_off.gif" class="roll" alt="重要事項・レギュレーション"/></a></li>' + 
								'<li><a href="javascript:void(0);" onclick="goInfo(3)"><img src="assets/ja/images/btn_setting_off.gif" class="roll" alt="ゲームソフトの設定・操作"/></a></li></ul>' + 
								'</div><div class="btn3"></div>';
			//参加解除
			var entry_4 = '<div id="form2"><div class="btn1"><img src="assets/ja/images/txt_msg4.gif"/></div><div class="btn1"><ul class="clearfix">' +
								'<li><a href="javascript:void(0);" onclick="goInfo(1)"><img src="assets/ja/images/btn_infomation_off.gif" class="roll" alt="大会情報"/></a></li>' + 
								'<li><a href="javascript:void(0);" onclick="goInfo(2)"><img src="assets/ja/images/btn_regulation_off.gif" class="roll" alt="重要事項・レギュレーション"/></a></li>' + 
								'</div><div class="btn3"></div>';
			//終了
			var entry_5 = '<div id="form1"><div class="btn1"><img src="assets/ja/images/txt_msg5.gif"/></div><div class="btn1"></div><div class="btn3"></div>';
			
			//ランキング公開
			var entry_6 = '<div id="form1"><div class="btn1"><img src="assets/ja/images/txt_msg6.gif"/></div><div class="btn1">' + 
								'</div><div class="btn2"><a href="/report/#/wifi-competitions/'+wid+'"><img src="assets/ja/images/btn_show_ranking_off.gif" class="roll" /></a></div>';
			//
//			var form_1  = '<div id="form"><div class="txt"><img src="assets/ja/images/txt_conf_check.gif" alt=""/></div>' +
//								'<div class="btn1"><ul class="clearfix"><li><a href="#" onclick="goInfo(2)"><img src="assets/ja/images/btn_regulation_off.gif" alt="重要事項・レギュレーション"/></a></li></ul></div>' + 
//								'<div class="txt"><input type="checkbox" name="is_check"/>&nbsp;<img src="assets/ja/images/txt_conf_agree.gif" alt=""/></div>' + 
//								'<div class="btn2"><ul class="clearfix"><li><a href="#entry"><img src="assets/ja/images/btn_back_off.gif" alt="もどる"/></a></li>' +
//								'<li><a id="exec-entry" rel="entry" href="javascript:void(0);"><img src="assets/ja/images/btn_entry_off.gif" alt="エントリー"/></a></li></ul></div></div>';
			
			var form_1  = '<div id="form"><div class="txt"><img src="assets/ja/images/txt_conf_check.gif" alt=""/></div>' +
								'<div class="btn1"><ul class="clearfix"><li><a href="javascript:void(0);" onclick="goInfo(2)"><img src="assets/ja/images/btn_regulation_off.gif" class="roll" alt="重要事項・レギュレーション"/></a></li></ul></div>' + 
								'<div class="txt"><input type="checkbox" name="is_check" id="is_check"/>&nbsp;<img src="assets/ja/images/txt_conf_agree.gif" alt=""/></div>' + 
								'<div class="btn2"><ul class="clearfix"><li><a href="#entry?wid='+wid+'&wsid='+wsid+'"><img src="assets/ja/images/btn_back_off.gif" class="roll" alt="もどる"/></a></li>' +
								'<li><img id="btn_entry" src="assets/ja/images/btn_entry_out.gif" alt="エントリー"/></li></ul></div></div>';
			
			var form_2  = '<div id="form1"><div><img src="assets/ja/images/txt_msg0.gif" /></div><div class="btn1"><ul class="clearfix">' +
								'<li><a href="javascript:void(0);" onclick="goInfo(1)"><img src="assets/ja/images/btn_infomation_off.gif" class="roll" alt="大会情報"/></a></li>' + 
								'<li><a href="javascript:void(0);" onclick="goInfo(2)"><img src="assets/ja/images/btn_regulation_off.gif" class="roll" alt="重要事項・レギュレーション"/></a></li>' + 
								'<li><a href="javascript:void(0);" onclick="goInfo(3)"><img src="assets/ja/images/btn_setting_off.gif" class="roll" alt="ゲームソフトの設定・操作"/></a></li></ul>' + 
								'</div><div class="btn3"></div>';
			
				$("#footer-btn").hide(0,function(){
					$("#footer-btn").empty();
					if(!is_entry)
					{
						switch(status){
							case 0: $("#footer-btn").append(entry_0); break;
							case 1: $("#footer-btn").append(entry_1); break;
							case 2: $("#footer-btn").append(entry_2); break;
							case 3: $("#footer-btn").append(entry_3); break;
							case 4: $("#footer-btn").append(entry_4); break;
							case 5: $("#footer-btn").append(entry_5); break;
							case 6: $("#footer-btn").append(entry_6); break;
						}
					}
					else
					{
						if(status == 0){$("#footer-btn").append(form_1);}
						else{ $("#footer-btn").append(form_2);}
					}
					
					$("#footer-btn").show(0,function(){
						setTimeout( function () { init() } , 1000 );
						$("#go-entry").click(function(){
							
						});
					});
				});
		    	that.initRollovers();
	  },
		getDetail:function(){
		  	  var wsid = $("#wsid").val();
		  	  var wid = $("#wid").val();
			  var that = this;
			  var request = {worldbattle_id: wid,worldbattle_serial_id: wsid};
			  $("#is_check").die("change");
			  
			  this.getApi('gbu.worldbattle.get_worldbattle_detail', request, [this.makeDetail], 
			    function (error) {
				  that.showDialog(error, { ok: function() { location = '/wifi#list'; } });
			    }
			  ).complete(function() {
				  $("#is_check").live("change",function(){
					  if($("input[name='is_check']").attr('checked') !== "checked"){
						  
						  $("#exec-entry").replaceWith('<img id="btn_entry" src="assets/ja/images/btn_entry_out.gif" alt="エントリー"/>');
						  
					  }else{
						  var params = getUrlVars();

						  $("#btn_entry").attr("src",'assets/ja/images/btn_entry_off.gif');
						  $("#btn_entry").attr("hsrc",'assets/ja/images/btn_entry_on.gif');
						  $("#btn_entry").addClass("roll");
						  $("#btn_entry").wrap('<a id="exec-entry" rel="entry" href="javascript:void(0);"></a>');
						  $("#exec-entry").click(function(){
							  if($("input[name='is_check']").attr('checked') !== "checked"){
								  that.showDialog("重要事項・レギュレーションにチェックをして下さい。",{ok: function(){}});
							  }else{
								  that.executeEntry();
							  }
						  });
						  
					  }
				  });
			  });
		},
		executeEntry:function(){
			var that = this;
			var wsid  = $("#wsid").val();
			var wid  = $("#wid").val();
			var request = {worldbattle_serial_id: wsid};
			this.getApi('gbu.worldbattle.worldbattle_update', request, [this.onCompleteEntry], 
			    function (error) {
				   that.showDialog(error, { ok: function() { location = '/wifi#list'; } });
			    }
			  ).complete(function() {
			});
		},
		onCompleteEntry:function(){
			var params = getUrlVars();
			var wsid  = params['wsid'];
			var wid  = params['wid'];
			location.href = "#complete";
		},
		pageload: function(hash){
			if(hash){
				tmp = hash.replace(/^.*#/, '');
				hashes =tmp.split("?");
				if(is_loaded){
					switch(hashes[0]){
						case "entry":
							this.showEntryForm($("#status").val(),false);
							break;
						case "confirm":
							this.showEntryForm($("#status").val(),true);
							break;
						case "complete":
							this.getDetail();
							break;
						case "list":
							this.initList();
						}
				}else{
					switch(hashes[0]){
					case "complete":
						this.initList();
						break;
					case "list":
						this.initList();
					}
				}
			}
			else{
				if(is_loaded)this.showEntryForm(0,false);
			}
		  

		},
		sTempSrc: '',
		initRollovers: function() {
			var that = this;
			if (!document.getElementById) return
			
			var aPreLoad = new Array();
			var aImages = document.getElementsByTagName('img');

			for (var i = 0; i < aImages.length; i++) {		
				if (aImages[i].className == 'roll') {
					var src = aImages[i].getAttribute('src').replace("_off","");
					var ftype = src.substring(src.lastIndexOf('.'), src.length);
					var hsrc = src.replace(ftype, '_on'+ftype);

					aImages[i].setAttribute('hsrc', hsrc);
					
					aPreLoad[i] = new Image();
					aPreLoad[i].src = hsrc;
					
					$("."+aImages[i].className+"").live("mouseover",function(){
						that.sTempSrc = $(this).attr("src");
						$(this).attr("src",$(this).attr("hsrc"))
					})
					$("."+aImages[i].className+"").live("mouseout",function(){
						that.sTempSrc = $(this).attr("src").replace('_on'+ftype, '_off'+ftype);
						$(this).attr("src",that.sTempSrc);
					})
				}
			}
	},
	initList: function() {
		var that = this;
 	    $("#worldbattle_main").load("list_ja.html",null,function(){
 	    	  that.initRollovers();
			  $("#type1").append("<div class='loading'><img src='assets/ja/images/loading-01.gif'/></div>");
			  $("#type2").append("<div class='loading'><img src='assets/ja/images/loading-01.gif'/></div>");
			  $("#type3").append("<div class='loading'><img src='assets/ja/images/loading-01.gif'/></div>");
			  that.getApi('gbu.worldbattle.worldbattle_list', {type:3}, [that.makeList], 
			    function (error) {
				  that.showDialog(error, { ok: function() { location = '/'; } });
			    }
			  ).complete(function() {
			  });
		});
	},initDetail:function(sid,id){
		var that = this;
		$("#worldbattle_main").empty();
 	    $("#worldbattle_main").load("entry/entry_ja.html",null,function(){
			var params = getUrlVars();
			var wsid  = params['wsid'];
			var wid  = params['wid'];
			$("#wsid").val(wsid);
			$("#wid").val(wid);
 	    	that.getDetail();
		});
	}
});

PGL.setMain(function() {
  $('<div id="sound"></div>').appendTo(document.body);
  swfobject.embedSWF('/report/assets/swf/sound.swf', 'sound', '1', '1', '10.0.0');
  

  
  
  var that = this;
  var params = "";
  $(document).ready(function(){
	   $.history.init(function(url){
		    params = getUrlVars();
		    var type = url.split("?");
			if(url!="" && (type[0]=="entry" || type[0]=="confirm"))that.initDetail(params["wsid"],params["wid"]);
			if(url=="")that.initList();
			if(!!url)url = url;
			else url = "";
			that.pageload(url);
		});
		   is_loaded = true;
		   $("a[rel='entry']").click(function(){
			var hash = this.href;
			hash = hash.replace(/^.*#/, '');
			$.history.load(hash);
			return false;
		  });
 });
	
 $(window).load(function(){
   is_loaded = true;
 });  
});

function getUrlVars()
{
  var vars = [], hash;
  var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
  for(var i = 0; i <hashes.length; i++) {
    hash = hashes[i].replace(/#.*/g,"").split('=');
    vars.push(hash[1]);
    vars[hash[0]] = hash[1];
  }
  return vars;
}
function goInfo(type)
{
	switch(type)
	{
		case 2: window.open($("#regulation").val(), "_brank"); break;
		case 3: window.open($("#manual_url").val(), "_brank"); break;
		case 1:
			if($("#target").val() == 1)
			{
				location.href = $("#url").val();
			}
			else
			{
				window.open($("#url").val(), "_brank");
			}
		;break;
	}
	return false;
}

var fadeInTime = 300;	// msec
var fadeOutTime = 300;	// msec
var offClass = 'off';
var onClass = 'on';
var isInit = false;
/**
 * initialize
 */
function init() {

}


/**
 * mouseover event( fadein )
 */
function onMouseOver( e ) {
	
	var src = jQuery(this).children( 'img.' + offClass ).attr( 'src' );
	var gifPatern = new RegExp( /.*\.gif$/ );
	
	jQuery(this).unbind( 'mouseover', onMouseOver );
	
	if ( src.match( gifPatern ) ) {
		jQuery(this).
			children( 'img.' + offClass ).
				fadeTo( fadeInTime, 0 ).
			end().
			children( 'img.' + onClass ).
				fadeTo( fadeInTime, 1, function(){
					jQuery(this).parent().mouseover( onMouseOver );
				});
	}
	else {
		jQuery(this).
			children( 'img.' + onClass ).
				fadeTo( fadeInTime, 1, function(){
					jQuery(this).parent().mouseover( onMouseOver );
				});
	}
}

/**
 * mouseout event( fadeout )
 */
function onMouseOut( e ) {
	
	var src = jQuery(this).children( 'img.' + offClass ).attr( 'src' );
	var gifPatern = new RegExp( /.*\.gif$/ );
	
	if ( src.match( gifPatern ) ) {
		jQuery(this).
			children( 'img.' + offClass ).
				fadeTo( fadeOutTime, 1 ).
			end().
			children( 'img.' + onClass ).
				fadeTo( fadeOutTime, 0 );
	}
	else {
		jQuery(this).
			children( 'img.' + onClass ).
				fadeTo( fadeOutTime, 0 );
	}
}
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
	  
	  var music = 'gbu';
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
	    var host = new PGL.Host();
	    music = 'gbu';
	    var musics = {
	      gts:new Audio('http://' + host.getPageAssetHost() + '/src/swf/report/sounds/gts.m4a'),
	      gbu:new Audio('http://' + host.getPageAssetHost() + '/src/swf/report/sounds/gbu.m4a'),
	      pgl:new Audio('http://' + host.getPageAssetHost() + '/src/swf/report/sounds/pgl.m4a')
	    };
	    $(function () {
	      $('body').one('touchstart', function () {
	        setMusic(music);
	      });
	      $('#report-header-gts').click(function () {
	        setMusic('gbu');
	      });
	      $('#report-header-gbu').click(function () {
	        setMusic('gbu');
	      });
	      $('#report-header-wifi-competitions').click(function () {
	        setMusic('gbu');
	      });
	      $('#report-header-global-records').click(function () {
	        setMusic('gbu');
	      });
	    });
	    window.setMusic = function (value) {
	      try {
	        musics[music].pause();
	        musics[music].currentTime = 0;
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

