package jp.co.pokemon.games.hsc
{
    import flash.display.*;

    public class RouteLine extends Object
    {
        public var lineTbl:Array;
        private var lineType:int;
        public static const LINE_TYPE_REAL:int = 0;
        public static const LINE_TYPE_AIM:int = 1;
        public static const LINE_TYPE_NON_DISPLAY:int = 2;
        public static const LINE_TYPE_MAX:int = 3;
        static const SAME_POSITION_MAX:Number = 2;

        public function RouteLine(param1:int)
        {
            this.lineType = param1;
            this.lineTbl = new Array();
            return;
        }// end function

        public function setRouteLine(param1:RouteLine) : void
        {
            this.lineTbl = new Array();
            var _loc_2:* = 0;
            while (_loc_2 < param1.lineTbl.length)
            {
                
                this.lineTbl[_loc_2] = RouteOne(param1.lineTbl[_loc_2]).clone();
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function printdata() : void
        {
            var _loc_2:Pos2 = null;
            var _loc_1:* = 0;
            while (_loc_1 < this.lineTbl.length)
            {
                
                _loc_2 = this.lineTbl[_loc_1].ppos;
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        public function reset() : void
        {
            this.lineTbl.length = 0;
            return;
        }// end function

        public function addPanelPosStart(param1:Pos2) : void
        {
            this.lineTbl.length = 0;
            this.lineTbl.push(new RouteOne(param1.clone(), 0));
            return;
        }// end function

        public function getLastPPos() : Pos2
        {
            if (this.lineTbl.length == 0)
            {
                return null;
            }
            var _loc_1:* = this.lineTbl[(this.lineTbl.length - 1)] as RouteOne;
            return _loc_1.ppos;
        }// end function

        public function addPanelPos(param1:Pos2) : void
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:Pos2 = null;
            var _loc_2:* = this.lineTbl[(this.lineTbl.length - 1)];
            if (_loc_2.ppos.x == param1.x)
            {
                _loc_3 = param1.y - _loc_2.ppos.y >= 0 ? (1) : (-1);
                _loc_2.dir4 = _loc_3 > 0 ? (1) : (3);
                _loc_5 = _loc_2.ppos.clone();
                while (_loc_5.y != param1.y)
                {
                    
                    _loc_5.y = _loc_5.y + _loc_3;
                    this.lineTbl.push(new RouteOne(_loc_5, _loc_2.dir4));
                }
            }
            else
            {
                _loc_3 = param1.x - _loc_2.ppos.x >= 0 ? (1) : (-1);
                _loc_2.dir4 = _loc_3 > 0 ? (0) : (2);
                _loc_5 = _loc_2.ppos.clone();
                while (_loc_5.x != param1.x)
                {
                    
                    _loc_5.x = _loc_5.x + _loc_3;
                    this.lineTbl.push(new RouteOne(_loc_5, _loc_2.dir4));
                }
            }
            return;
        }// end function

        public function drawInit(param1:MovieClip) : void
        {
            return;
        }// end function

        public function draw(param1:MovieClip, param2:Pos2, param3:int) : void
        {
            var _loc_5:Line = null;
            var _loc_8:Pos2 = null;
            var _loc_9:Pos2 = null;
            var _loc_10:Pos2 = null;
            var _loc_11:Pos2 = null;
            if (this.lineTbl.length == 0)
            {
                return;
            }
            var _loc_4:* = new Array();
            var _loc_6:int = 0;
            while (_loc_6 < (this.lineTbl.length - 1))
            {
                
                _loc_5 = this.getLineOne(_loc_6, param2);
                _loc_9 = this.lineTbl[_loc_6].ppos;
                _loc_10 = this.lineTbl[(_loc_6 + 1)].ppos;
                if (_loc_9.y == _loc_10.y && _loc_9.y == param3)
                {
                    this.lineTblPushAndSort(_loc_4, new Line(_loc_5.tbl[0], _loc_5.tbl[1]));
                }
                else if (_loc_9.y == param3)
                {
                    _loc_8 = PanelAll.calcPanelCenterDPos_AtYMove(_loc_9.x, _loc_5.tbl[0], _loc_5.tbl[1]);
                    if (_loc_8 != null)
                    {
                        this.lineTblPushAndSort(_loc_4, new Line(_loc_8, _loc_5.tbl[0]));
                    }
                }
                else if (_loc_10.y == param3)
                {
                    _loc_8 = PanelAll.calcPanelCenterDPos_AtYMove(_loc_9.x, _loc_5.tbl[0], _loc_5.tbl[1]);
                    if (_loc_8 == null)
                    {
                        _loc_8 = _loc_5.tbl[0];
                    }
                    this.lineTblPushAndSort(_loc_4, new Line(_loc_5.tbl[1], _loc_8));
                }
                _loc_6++;
            }
            if (_loc_4.length == 0)
            {
                return;
            }
            var _loc_7:* = new MovieClip();
            new MovieClip().mouseEnabled = false;
            _loc_7.mouseChildren = false;
            _loc_7.alpha = this.lineType == LINE_TYPE_AIM ? (0.6) : (1);
            param1.addChild(_loc_7);
            _loc_7.graphics.lineStyle(10, 16766720, 1, false, LineScaleMode.NORMAL, CapsStyle.ROUND, JointStyle.ROUND, 10);
            _loc_6 = 0;
            while (_loc_6 < _loc_4.length)
            {
                
                _loc_5 = _loc_4[_loc_6];
                if (_loc_6 == 0)
                {
                    _loc_7.graphics.moveTo(Math.floor(_loc_5.tbl[0].x), Math.floor(_loc_5.tbl[0].y));
                }
                else
                {
                    _loc_11 = _loc_4[(_loc_6 - 1)].tbl[1];
                    if (_loc_11.distanceFrom(_loc_5.tbl[0]) < SAME_POSITION_MAX)
                    {
                    }
                    else
                    {
                        _loc_7.graphics.moveTo(Math.floor(_loc_5.tbl[0].x), Math.floor(_loc_5.tbl[0].y));
                    }
                }
                _loc_7.graphics.lineTo(Math.floor(_loc_5.tbl[1].x), Math.floor(_loc_5.tbl[1].y));
                _loc_6++;
            }
            return;
        }// end function

        public function lineTblPushAndSort(param1:Array, param2:Line) : void
        {
            var _loc_4:Line = null;
            var _loc_3:int = 0;
            _loc_3 = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_4 = param1[_loc_3];
                if (param2.sumX() < _loc_4.sumX())
                {
                    break;
                }
                _loc_3++;
            }
            param1.splice(_loc_3, 0, param2);
            if (param1.length == 1)
            {
                return;
            }
            if (_loc_3 != 0)
            {
                _loc_4 = param1[(_loc_3 - 1)];
                if (_loc_4.tbl[0].distanceFrom(param2.tbl[0]) < SAME_POSITION_MAX)
                {
                    _loc_4.swap01();
                }
                else if (_loc_4.tbl[1].distanceFrom(param2.tbl[1]) < SAME_POSITION_MAX)
                {
                    param2.swap01();
                }
                else if (_loc_4.tbl[0].distanceFrom(param2.tbl[1]) < SAME_POSITION_MAX)
                {
                    param2.swap01();
                    _loc_4.swap01();
                }
            }
            if (_loc_3 != (param1.length - 1))
            {
                _loc_4 = param1[(_loc_3 + 1)];
                if (param2.tbl[0].distanceFrom(_loc_4.tbl[0]) < SAME_POSITION_MAX)
                {
                    param2.swap01();
                }
                else if (param2.tbl[1].distanceFrom(_loc_4.tbl[1]) < SAME_POSITION_MAX)
                {
                    _loc_4.swap01();
                }
                else if (param2.tbl[0].distanceFrom(_loc_4.tbl[1]) < SAME_POSITION_MAX)
                {
                    _loc_4.swap01();
                    param2.swap01();
                }
            }
            return;
        }// end function

        public function getLineOne(param1:int, param2:Pos2) : Line
        {
            var _loc_3:Pos2 = null;
            var _loc_4:Pos2 = null;
            _loc_3 = PanelAll.getPPos2DPos(this.lineTbl[(param1 + 1)].ppos);
            if (param1 == 0)
            {
                _loc_4 = param2;
            }
            else
            {
                _loc_4 = PanelAll.getPPos2DPos(this.lineTbl[param1].ppos);
            }
            return new Line(_loc_3, _loc_4);
        }// end function

        public function shift() : void
        {
            this.lineTbl.shift();
            return;
        }// end function

    }
}

class Line extends Object
{
    public var tbl:Array;

    function Line(param1:Pos2, param2:Pos2)
    {
        this.tbl = new Array();
        this.tbl[0] = param2.clone();
        this.tbl[1] = param1.clone();
        return;
    }// end function

    public function sumX() : Number
    {
        return this.tbl[0].x + this.tbl[1].x;
    }// end function

    public function swap01() : void
    {
        var _loc_1:* = this.tbl[0];
        this.tbl[0] = this.tbl[1];
        this.tbl[1] = _loc_1;
        return;
    }// end function

    public function clone() : Line
    {
        return new Line(this.tbl[1], this.tbl[0]);
    }// end function

}

