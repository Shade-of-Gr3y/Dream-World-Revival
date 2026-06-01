function m_footer(){
	sel = "";
	sel += '<table border="0" cellpadding="0" cellspacing="0">';
	sel += '<tr>';
	sel += '<td><img src="/ja.pokemon-gl.com/portal/shareimgs/footer200801.gif" width="783" height="61" border="0" alt="" usemap="#footer"><map name="footer"><area';
	sel += ' shape="rect" coords="119,10,273,25" href="/ja.pokemon-gl.com/portal/member/privacy.cfm" alt="�v���C�o�V�[�ɂ���"><area';
	sel += ' shape="rect" coords="281,10,350,25" href="/ja.pokemon-gl.com/portal/member/copyright.cfm" alt="�R�s�[���C�g"><area';
	sel += ' shape="rect" coords="358,10,463,25" href="/ja.pokemon-gl.com/portal/member/browser.cfm" alt="�p�\�R���̂����Ă�"><area';
	sel += ' shape="rect" coords="471,10,563,25" href="/ja.pokemon-gl.com/portal/member/faq/faq.cfm" alt="�悭���邵����"><area';
	sel += ' shape="rect" coords="570,10,629,25" href="/ja.pokemon-gl.com/portal/member/oyakusoku.cfm" alt="���₭����"></map></td>';
	sel += '</tr>';
	sel += '</table>';
	document.write(sel);
}

function h_footer(){
	sel = "";
	sel += '<table border="0" cellpadding="0" cellspacing="0">';
	sel += '<tr>';
	sel += '<td><img src="/ja.pokemon-gl.com/portal/shareimgs/footer200801.gif" width="783" height="61" border="0" alt="" usemap="#footer"><map name="footer"><area';
	sel += ' shape="rect" coords="119,10,273,25" href="/ja.pokemon-gl.com/portal/html/privacy.html" alt="�v���C�o�V�[�ɂ���"><area';
	sel += ' shape="rect" coords="281,10,350,25" href="/ja.pokemon-gl.com/portal/html/copyright.html" alt="�R�s�[���C�g"><area';
	sel += ' shape="rect" coords="358,10,463,25" href="/ja.pokemon-gl.com/portal/html/browser.html" alt="�p�\�R���̂����Ă�"><area';
	sel += ' shape="rect" coords="471,10,563,25" href="/ja.pokemon-gl.com/portal/html/faq/faq.cfm" alt="�悭���邵����"><area';
	sel += ' shape="rect" coords="570,10,629,25" href="/ja.pokemon-gl.com/portal/html/oyakusoku.html" alt="���₭����"></map></td>';
	sel += '</tr>';
	sel += '</table>';
	document.write(sel);
}

function s_footer(IPADDSERV,isForce){
	IPADDTOP      = IPADDSERV + "portal/top.cfm";
	IPADDPRI      = IPADDSERV + "portal/member/privacy.cfm";
	IPADDCOPY     = IPADDSERV + "portal/member/copyright.cfm";
	IPADDBRO      = IPADDSERV + "portal/member/browser.cfm";
	IPADDYAK      = IPADDSERV + "portal/member/oyakusoku.cfm";	
	
	if(isForce == 1){
		IPADDFAQ      = IPADDSERV + "portal/html/faq/faq.cfm";
	}else{
		IPADDFAQ      = IPADDSERV + "portal/member/faq/faq.cfm";				
	}

	sel = "";
	sel += '<table border="0" cellpadding="0" cellspacing="0">';
	sel += '<tr>';
	sel += '<td><img src="/ja.pokemon-gl.com/portal/shareimgs/footer200801.gif" width="783" height="61" border="0" alt="" usemap="#footer"><map name="footer"><area';
	sel += ' shape="rect" coords="119,10,273,25" href="' + IPADDPRI + '" alt="�v���C�o�V�[�ɂ���"><area';
	sel += ' shape="rect" coords="281,10,350,25" href="' + IPADDCOPY + '" alt="�R�s�[���C�g"><area';
	sel += ' shape="rect" coords="358,10,463,25" href="' + IPADDBRO + '" alt="�p�\�R���̂����Ă�"><area';
	sel += ' shape="rect" coords="471,10,563,25" href="' + IPADDFAQ + '" alt="�悭���邵����"><area';
	sel += ' shape="rect" coords="570,10,629,25" href="' + IPADDYAK + '" alt="���₭����"></map></td>';
	sel += '</tr>';
	sel += '</table>';
	document.write(sel);
}