function checkFrame(locale, account_url_base){
	
	var success = function(data, dataType){
						if(data && eval("(" + data + ")").live == 1){
							//var url = "/portal/login_pgl.cfm";
							var url = "/debug/api/account/com/footer.html";
							$("#console iframe").attr("src", url);
						}
						else{
							var alterurl = "/errdoc/ja/html/accountsite_error.html";
							  $("#console iframe").attr("src", alterurl);
						}
					};
	var error = function(rslt, status, errorThrown){
		var alterurl = "/errdoc/ja/html/accountsite_error.html";
		  $("#console iframe").attr("src", alterurl);
	}
		
	$.ajax({ 
			url : "/api/?p=account.com.monitor",
			success:success,
			error:error,
			cache:false
	});

	
}


