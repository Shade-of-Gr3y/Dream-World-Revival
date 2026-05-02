package jp.co.pokemon.games.hsc
{

    public class GameData extends Object
    {
        public var sweetsGetTbl:Array;
        public var timerMax:Number = 60;
        public var timerSecond:Number;
        public var drop:int = 0;
        public var isFirstMessageKick:Boolean = false;
        public static const BonusPoint:int = 5000;
        public static const npcMax:int = 2;
        public static const pokemonMax:int = 3;

        public function GameData()
        {
            var _loc_2:int = 0;
            this.sweetsGetTbl = new Array();
            this.timerSecond = this.timerMax;
            var _loc_1:int = 0;
            while (_loc_1 < pokemonMax)
            {
                
                this.sweetsGetTbl[_loc_1] = new Array();
                _loc_2 = 0;
                while (_loc_2 < Sweets.TYPE_MAX)
                {
                    
                    this.sweetsGetTbl[_loc_1][_loc_2] = 0;
                    _loc_2++;
                }
                _loc_1++;
            }
            if (Setting.isDebugScore)
            {
                this.timerSecond = 1;
            }
            if (Setting.isDebugTimeRemainBar)
            {
                this.timerSecond = 11;
            }
            return;
        }// end function

        public function getScoreTotal(param1:int = 0) : int
        {
            var _loc_4:int = 0;
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            while (_loc_3 < Sweets.TYPE_MAX)
            {
                
                _loc_4 = this.sweetsGetTbl[param1][_loc_3];
                _loc_2 = _loc_2 + Sweets.scoreTbl[_loc_3] * _loc_4;
                _loc_3++;
            }
            return _loc_2;
        }// end function

        public function getOrderMe() : int
        {
            return this.getOrderIt(0);
        }// end function

        public function getOrderIt(param1:int) : int
        {
            var _loc_2:* = this.getOrderTbl();
            var _loc_3:int = 0;
            while (_loc_3 < pokemonMax)
            {
                
                if (_loc_2[_loc_3].pi == param1)
                {
                    return _loc_2[_loc_3].order;
                }
                _loc_3++;
            }
            Tools.alert(false, "err");
            return 123;
        }// end function

        public function getOrderTbl() : Array
        {
            var _loc_2:Object = null;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_6:int = 0;
            var _loc_1:* = new Array();
            _loc_3 = 0;
            while (_loc_3 < pokemonMax)
            {
                
                _loc_2 = new Object();
                _loc_1.push(_loc_2);
                _loc_2.score = this.getScoreTotal(_loc_3);
                _loc_2.pi = _loc_3;
                _loc_2.order = 0;
                _loc_3++;
            }
            var _loc_5:int = 0;
            while (_loc_5 < (pokemonMax - 1))
            {
                
                _loc_6 = _loc_5 + 1;
                while (_loc_6 < pokemonMax)
                {
                    
                    if (_loc_1[_loc_5].score < _loc_1[_loc_6].score)
                    {
                        _loc_2 = _loc_1[_loc_5];
                        _loc_1[_loc_5] = _loc_1[_loc_6];
                        _loc_1[_loc_6] = _loc_2;
                    }
                    _loc_6++;
                }
                _loc_5++;
            }
            _loc_4 = 0;
            while (_loc_4 < pokemonMax)
            {
                
                if (_loc_4 == 0)
                {
                    _loc_1[_loc_4].order = 0;
                }
                else if (_loc_1[_loc_4].score == _loc_1[(_loc_4 - 1)].score)
                {
                    _loc_1[_loc_4].order = _loc_1[(_loc_4 - 1)].order;
                }
                else
                {
                    _loc_1[_loc_4].order = _loc_1[(_loc_4 - 1)].order + 1;
                }
                _loc_4++;
            }
            return _loc_1;
        }// end function

    }
}
