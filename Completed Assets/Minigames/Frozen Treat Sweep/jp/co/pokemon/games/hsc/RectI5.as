package jp.co.pokemon.games.hsc
{

    public class RectI5 extends Object
    {
        public var vartexTbl:Array;
        public var center:Pos2;
        public var topLeft:Pos2;
        public var size:Pos2;
        public static const EDGE_TL:int = 0;
        public static const EDGE_TR:int = 1;
        public static const EDGE_BR:int = 2;
        public static const EDGE_BL:int = 3;

        public function RectI5(param1:Pos2, param2:Pos2, param3:Pos2, param4:Pos2)
        {
            var _loc_12:Pos2 = null;
            this.vartexTbl = new Array();
            this.vartexTbl[RectI5.EDGE_TL] = param1.clone();
            this.vartexTbl[RectI5.EDGE_TR] = param2.clone();
            this.vartexTbl[RectI5.EDGE_BR] = param3.clone();
            this.vartexTbl[RectI5.EDGE_BL] = param4.clone();
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:* = int.MAX_VALUE;
            var _loc_8:int = 0;
            var _loc_9:* = int.MAX_VALUE;
            var _loc_10:int = 0;
            var _loc_11:int = 0;
            while (_loc_11 < this.vartexTbl.length)
            {
                
                _loc_12 = this.vartexTbl[_loc_11];
                _loc_5 = _loc_5 + _loc_12.x;
                _loc_6 = _loc_6 + _loc_12.y;
                if (_loc_7 > _loc_12.x)
                {
                    _loc_7 = _loc_12.x;
                }
                else if (_loc_8 < _loc_12.x)
                {
                    _loc_8 = _loc_12.x;
                }
                if (_loc_9 > _loc_12.y)
                {
                    _loc_9 = _loc_12.y;
                }
                else if (_loc_10 < _loc_12.y)
                {
                    _loc_10 = _loc_12.y;
                }
                _loc_11++;
            }
            this.center = new Pos2(_loc_5 / 4, _loc_6 / 4);
            this.topLeft = new Pos2(_loc_7, _loc_9);
            this.size = new Pos2(_loc_8 - _loc_7, _loc_10 - _loc_9);
            return;
        }// end function

        public function getVertexFromTL(param1:int) : Pos2
        {
            param1 = param1 % 4;
            return this.vartexTbl[param1].subFrom(this.topLeft);
        }// end function

        public function clone() : RectI5
        {
            var _loc_1:* = new RectI5(this.vartexTbl[0], this.vartexTbl[1], this.vartexTbl[2], this.vartexTbl[3]);
            return _loc_1;
        }// end function

    }
}
