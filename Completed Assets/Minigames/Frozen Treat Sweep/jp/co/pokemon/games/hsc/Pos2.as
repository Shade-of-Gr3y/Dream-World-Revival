package jp.co.pokemon.games.hsc
{
    import flash.display.*;

    public class Pos2 extends Object
    {
        public var x:Number;
        public var y:Number;

        public function Pos2(param1:Number = 0, param2:Number = 0) : void
        {
            this.x = param1;
            this.y = param2;
            return;
        }// end function

        public function dirFrom(param1:Pos2) : Number
        {
            return Math.atan2(this.y - param1.y, this.x - param1.x);
        }// end function

        public function distanceFrom(param1:Pos2) : Number
        {
            var _loc_2:* = this.y - param1.y;
            var _loc_3:* = this.x - param1.x;
            return Math.sqrt(_loc_2 * _loc_2 + _loc_3 * _loc_3);
        }// end function

        public function subFrom(param1:Pos2) : Pos2
        {
            return new Pos2(this.x - param1.x, this.y - param1.y);
        }// end function

        public function clone() : Pos2
        {
            return new Pos2(this.x, this.y);
        }// end function

        public function add(param1:Pos2) : Pos2
        {
            return new Pos2(this.x + param1.x, this.y + param1.y);
        }// end function

        public function mul(param1:Number) : Pos2
        {
            return new Pos2(this.x * param1, this.y * param1);
        }// end function

        public function isEq(param1:Pos2) : Boolean
        {
            if (param1 == null)
            {
                return false;
            }
            return this.x == param1.x && this.y == param1.y;
        }// end function

        public function isFromUDLR_Int(param1:Pos2) : Boolean
        {
            var _loc_2:* = Tools.iabs(this.y - param1.y);
            var _loc_3:* = Tools.iabs(this.x - param1.x);
            return _loc_2 == 0 && _loc_3 == 1 || _loc_2 == 1 && _loc_3 == 0;
        }// end function

        public function setMc(param1:MovieClip) : void
        {
            param1.x = this.x;
            param1.y = this.y;
            return;
        }// end function

        public static function tblNearPositionDelete(param1:Array, param2:Pos2) : void
        {
            var _loc_4:Pos2 = null;
            var _loc_3:int = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_4 = param1[_loc_3] as Pos2;
                if (_loc_4.distanceFrom(param2) < 1.9)
                {
                    param1.splice(_loc_3, 1);
                    continue;
                }
                _loc_3++;
            }
            return;
        }// end function

        public static function tblEqualPositionDelete(param1:Array, param2:Pos2) : void
        {
            var _loc_4:Pos2 = null;
            var _loc_3:int = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_4 = param1[_loc_3] as Pos2;
                if (_loc_4.isEq(param2))
                {
                    param1.splice(_loc_3, 1);
                    continue;
                }
                _loc_3++;
            }
            return;
        }// end function

    }
}
