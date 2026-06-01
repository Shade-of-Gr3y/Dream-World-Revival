var ispdw = false;
var returnValue = "ポケモンを起こす場合は「ポケモンドリームワールドを終了する」を押してください。";

function setpdw(bool)
{
	ispdw = bool;
}
window.onbeforeunload = function(event)
{
	if (ispdw)
	{
		event = event || window.event;
		return event.returnValue = returnValue;
	}
}
