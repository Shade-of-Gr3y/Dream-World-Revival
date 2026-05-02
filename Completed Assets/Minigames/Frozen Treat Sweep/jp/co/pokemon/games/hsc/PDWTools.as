package jp.co.pokemon.games.hsc
{
    import bfp.common.*;
    import common.*;
    import flash.text.*;

    public class PDWTools extends Object
    {

        public function PDWTools()
        {
            return;
        }// end function

        public static function setAutoFontTextIDsButton(param1:ZButton) : void
        {
            if (param1.tfTextMain)
            {
                PDWTools.setAutoFontTextIDsOne([param1.tfTextMain]);
            }
            if (param1.tfTextShadow)
            {
                PDWTools.setAutoFontTextIDsOne([param1.tfTextShadow]);
            }
            return;
        }// end function

        public static function setAutoFontTextIDs(param1:Array) : void
        {
            var _loc_2:Array = null;
            for each (_loc_2 in param1)
            {
                
                setAutoFontTextIDsOne(_loc_2);
            }
            return;
        }// end function

        public static function setAutoFontTextIDsOne(param1:Array) : void
        {
            var _loc_3:String = null;
            var _loc_2:* = TextField(param1[0]);
            if (Global.isStandalone)
            {
                if (param1[2] != null)
                {
                    _loc_2.text = String(param1[2]);
                }
                return;
            }
            if (param1[1] != null)
            {
                _loc_3 = param1[1];
            }
            else if (_loc_2.name.indexOf("texti_") == 0)
            {
                _loc_3 = _loc_2.name.substr("texti_".length);
            }
            var _loc_4:* = FontManager.getIdText(_loc_3);
            Tools.alert(_loc_4 != "", "FontManager id nothing," + _loc_3);
            _loc_2.selectable = false;
            _loc_4 = _loc_4.replace(/{BUDDY_NAME}/g, gameBridge.encountPokemonName);
            if (param1[2] != null)
            {
                _loc_4 = _loc_4.replace(/{NUM}/g, param1[2].toString());
                _loc_4 = _loc_4.replace(/{STR}/g, param1[2]);
            }
            FontManager.setTextAndFormat(_loc_2, _loc_4, _loc_3);
            var _loc_5:* = textFieldManager.createTextFormat(_loc_2, _loc_3);
            _loc_2.text = "{REPLACE_THIS}";
            _loc_2.htmlText = _loc_2.htmlText.replace(/{REPLACE_THIS}/, FontManager.markupMultilingualText(_loc_4, _loc_5.boldFlag));
            return;
        }// end function

    }
}
