package jp.co.pokemon.games.hsc
{
    import flash.display.*;
    import flash.system.*;
    import flash.text.*;

    public class Tools extends Object
    {
        public static const alphaMax:uint = 26;
        public static const alphaCode_0:uint = 48;
        public static const alphaCode_A:uint = 65;
        public static const alphaCode_a:uint = 97;
        public static const textCode_Enter:uint = 13;
        public static const textCode_BS:uint = 8;
        public static var lang:String = "";
        public static const dir4Max:int = 4;
        public static const dirMax:Number = Math.PI * 2;
        public static const dir4OneDir:Number = Math.PI / 2;
        public static const dir4OneDirH:Number = dir4OneDir / 2;

        public function Tools()
        {
            return;
        }// end function

        public static function randomThanLessFloat(param1, param2) : Number
        {
            return Math.random() * (param2 - param1) + param1;
        }// end function

        public static function randomThanLessInt(param1, param2) : int
        {
            return int(Math.floor(randomThanLessFloat(param1, param2)));
        }// end function

        public static function randomLessInt(param1) : int
        {
            return int(Math.floor(Math.random() * param1));
        }// end function

        public static function random100() : int
        {
            return randomLessInt(100);
        }// end function

        public static function randopmRateTblToIndex(param1:Array) : int
        {
            var _loc_2:* = Tools.random100();
            var _loc_3:* = 0;
            var _loc_4:int = 0;
            while (_loc_4 < param1.length)
            {
                
                _loc_3 = _loc_3 + param1[_loc_4];
                if (_loc_2 < _loc_3)
                {
                    break;
                }
                _loc_4++;
            }
            return _loc_4;
        }// end function

        public static function tableRandomGet(param1:Array) : Object
        {
            if (param1.length == 0)
            {
                return null;
            }
            return param1[randomLessInt(param1.length)];
        }// end function

        public static function tableRandomGetAndDelete(param1:Array) : Object
        {
            var _loc_2:* = randomLessInt(param1.length);
            var _loc_3:* = param1[_loc_2];
            param1.splice(_loc_2, 1);
            return _loc_3;
        }// end function

        public static function tblSearchIt(param1:Array, param2:Object) : int
        {
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                if (param1[_loc_3] == param2)
                {
                    return _loc_3;
                }
                _loc_3 = _loc_3 + 1;
            }
            return -1;
        }// end function

        public static function arrayClone(param1:Array) : Array
        {
            var _loc_2:* = new Array();
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_2.push(param1[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        public static function numberToKeta(param1:Number, param2:Number, param3:Boolean) : Number
        {
            var _loc_5:* = undefined;
            var _loc_4:* = Math.pow(10, param2);
            if (param2 == 0)
            {
                _loc_5 = param1;
            }
            else
            {
                _loc_5 = Math.floor(param1 / _loc_4);
            }
            var _loc_6:* = _loc_5 % 10;
            var _loc_7:* = Math.floor(_loc_5 / 10);
            if (Math.floor(_loc_5 / 10) == 0 && _loc_6 == 0 && param2 != 0)
            {
                if (param3)
                {
                    return 1;
                }
                return 11;
            }
            return (_loc_6 + 1);
        }// end function

        public static function numbersMcSetting(param1:MovieClip, param2:String, param3:Number, param4:Boolean) : void
        {
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_5:* = 0;
            while (true)
            {
                
                _loc_6 = numberToKeta(param3, _loc_5, param4);
                _loc_7 = param1[param2 + _loc_5];
                if (_loc_7 == undefined)
                {
                    break;
                }
                _loc_7.gotoAndStop(_loc_6);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

        public static function formatNumber(param1:int, param2:String) : String
        {
            var _loc_3:* = {ja:",", en:",", fr:" ", it:".", de:" ", es:param1 < 10000 ? ("") : (" "), ko:","}[param2];
            return ("" + param1).replace(/([0-9]+?)(?=(?:[0-9]{3})+(?:$|\.))/g, "$1" + _loc_3);
        }// end function

        public static function textFieldSetNumber(param1:TextField, param2:int) : void
        {
            param1.text = formatNumber(param2, lang);
            param1.embedFonts = true;
            return;
        }// end function

        public static function textFieldSetString(param1:TextField, param2:String) : void
        {
            param1.text = param2;
            param1.embedFonts = true;
            return;
        }// end function

        public static function toZenkakuNumber(param1:int) : String
        {
            if (param1 == 0)
            {
                return "0";
            }
            var _loc_2:Array = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
            var _loc_3:String = "";
            while (param1 != 0)
            {
                
                _loc_3 = String(_loc_2[param1 % 10]) + _loc_3;
                param1 = param1 / 10;
            }
            return _loc_3;
        }// end function

        public static function positionKeep(param1:Object) : void
        {
            if (param1.hasOwnProperty("posKeep"))
            {
                return;
            }
            param1.posKeep = new Object();
            param1.posKeep.x = param1.x;
            param1.posKeep.y = param1.y;
            return;
        }// end function

        public static function positionRecover(param1:Object) : void
        {
            param1.x = param1.posKeep.x;
            param1.y = param1.posKeep.y;
            return;
        }// end function

        public static function imeOff() : void
        {
            if (IME.enabled)
            {
                IME.enabled = false;
            }
            return;
        }// end function

        public static function toSmallAlpha(param1:uint) : uint
        {
            if (isLargeAlpha(param1))
            {
                param1 = param1 - alphaCode_A + alphaCode_a;
            }
            return param1;
        }// end function

        public static function toLargeAlpha(param1:uint) : uint
        {
            if (isSmallAlpha(param1))
            {
                param1 = param1 - alphaCode_a + alphaCode_A;
            }
            return param1;
        }// end function

        public static function isLargeAlpha(param1:uint) : Boolean
        {
            return alphaCode_A <= param1 && param1 < alphaCode_A + alphaMax;
        }// end function

        public static function isSmallAlpha(param1:uint) : Boolean
        {
            return alphaCode_a <= param1 && param1 < alphaCode_a + alphaMax;
        }// end function

        public static function isZenkaku(param1:uint) : Boolean
        {
            return param1 >= 256;
        }// end function

        public static function isHankaku(param1:uint) : Boolean
        {
            return param1 < 256;
        }// end function

        public static function isNumber(param1:uint) : Boolean
        {
            return alphaCode_0 <= param1 && param1 < alphaCode_0 + 10;
        }// end function

        public static function removeChildrenAll(param1:MovieClip) : void
        {
            while (param1.numChildren > 0)
            {
                
                param1.removeChildAt(0);
            }
            return;
        }// end function

        public static function rootUrl(param1:String, param2:int) : String
        {
            var _loc_3:* = param1.split("/");
            var _loc_4:* = _loc_3.length - param2;
            if (_loc_3.length - param2 < 0)
            {
                _loc_4 = 0;
            }
            _loc_3.splice(_loc_4);
            _loc_3 = _loc_3.join("/");
            return _loc_3;
        }// end function

        public static function dir4Quantize(param1:int) : int
        {
            if (param1 < 0)
            {
                return param1 % dir4Max + dir4Max;
            }
            return param1 % dir4Max;
        }// end function

        public static function dirQuantize(param1:Number) : Number
        {
            if (param1 < 0)
            {
                return param1 % dirMax + dirMax;
            }
            return param1 % dirMax;
        }// end function

        public static function dir4ToDir(param1:int) : Number
        {
            return dir4Quantize(param1) * dir4OneDir;
        }// end function

        public static function dirToDir4(param1:Number) : int
        {
            return (dirQuantize(param1) + dir4OneDirH) % dir4OneDir;
        }// end function

        public static function dirToMPI2PPI(param1:Number) : Number
        {
            param1 = dirQuantize(param1);
            if (param1 > Math.PI)
            {
                return param1 - Math.PI * 2;
            }
            return param1;
        }// end function

        public static function dir4MP(param1:int) : int
        {
            param1 = dir4Quantize(param1);
            if (param1 > dir4Max / 2)
            {
                return param1 - dir4Max;
            }
            return param1;
        }// end function

        public static function posToDir4JustOnly(param1:Pos2, param2:Pos2)
        {
            if (param1.x == param2.x && param1.y == param2.y)
            {
                return -1;
            }
            if (param1.y == param2.y)
            {
                return param1.x > param2.x ? (0) : (2);
            }
            else if (param1.x == param2.x)
            {
                return param1.y > param2.y ? (1) : (3);
            }
            return -1;
        }// end function

        public static function xyToDistance(param1:Number, param2:Number) : Number
        {
            return Math.sqrt(param1 * param1 + param2 * param2);
        }// end function

        public static function xyToDir(param1:Number, param2:Number) : Number
        {
            return Math.atan2(param2, param1);
        }// end function

        public static function iabs(param1:int) : int
        {
            return param1 < 0 ? (-param1) : (param1);
        }// end function

        public static function alert(param1:Boolean, param2:String) : void
        {
            if (!param1)
            {
            }
            return;
        }// end function

        public static function shadowScaleAlphaSetting(param1:MovieClip, param2:Number, param3:Number, param4:Pos2) : Boolean
        {
            var _loc_5:Number = 100;
            if (param3 >= _loc_5)
            {
                return false;
            }
            var _loc_6:* = (_loc_5 - param3) / _loc_5;
            var _loc_7:* = param2 * PanelAll.dposy2Scale(param4.y) * _loc_6;
            param1.scaleY = param2 * PanelAll.dposy2Scale(param4.y) * _loc_6;
            param1.scaleX = _loc_7;
            param1.x = param4.x;
            param1.y = param4.y;
            param1.mouseEnabled = false;
            param1.mouseChildren = false;
            return true;
        }// end function

        public static function shadowScaleAlphaSettingNew(param1:MovieClip, param2:Number, param3:Number, param4:Pos2) : Boolean
        {
            var _loc_5:Number = 100;
            if (param3 >= _loc_5)
            {
                return false;
            }
            var _loc_6:* = (_loc_5 - param3) / _loc_5;
            param1.x = param4.x;
            param1.y = param4.y;
            return true;
        }// end function

        public static function shadowInit(param1:MovieClip) : void
        {
            param1.cacheAsBitmap = true;
            param1.mouseEnabled = false;
            param1.mouseChildren = false;
            param1.alpha = 0.5;
            return;
        }// end function

        public static function calcDim2FastToSlow(param1:Number) : Number
        {
            return 1 - Math.pow(1 - param1, 1.3);
        }// end function

        public static function calcDim2Slow2Fast(param1:Number) : Number
        {
            return Math.pow(param1, 1.3);
        }// end function

        public static function calcJumpParabola(param1:Pos2, param2:Pos2, param3:int, param4:int, param5:int) : Object
        {
            var _loc_10:Number = NaN;
            var _loc_11:Number = NaN;
            var _loc_6:* = PanelAll.getPPos2DPos(param1);
            var _loc_7:* = PanelAll.getPPos2DPos(param1).subFrom(param2);
            var _loc_8:* = Number(param5) / Number(param4);
            var _loc_9:* = calcDim2FastToSlow(_loc_8);
            if (_loc_8 <= 0.5)
            {
                _loc_11 = _loc_8 * 2;
                _loc_11 = calcDim2FastToSlow(_loc_11);
                _loc_10 = _loc_11 * 0.5;
            }
            else
            {
                _loc_11 = (_loc_8 - 0.5) * 2;
                _loc_11 = calcDim2Slow2Fast(_loc_11);
                _loc_10 = _loc_11 * 0.5 + 0.5;
            }
            var _loc_12:* = (_loc_10 - 0.5) * 2;
            var _loc_13:* = (-(_loc_10 - 0.5) * 2 * ((_loc_10 - 0.5) * 2) + 1) * (-param3);
            _loc_7 = _loc_7.mul(_loc_9);
            var _loc_14:* = new Object();
            new Object().dpos = param2.add(_loc_7);
            _loc_14.dpos.y = _loc_14.dpos.y + _loc_13;
            _loc_14.yHeight = -_loc_13;
            _loc_14.isEnd = param5 >= param4;
            _loc_14.isNeedShadow = _loc_10 >= 0.5;
            return _loc_14;
        }// end function

        public static function mcIsEnd(param1:MovieClip) : Boolean
        {
            return param1.currentFrame >= param1.totalFrames;
        }// end function

        public static function mcPlayNext(param1:MovieClip) : void
        {
            param1.gotoAndStop((param1.currentFrame + 1));
            return;
        }// end function

    }
}
