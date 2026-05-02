package jp.co.pokemon.games.hsc
{
    import flash.display.*;

    public class PanelAll extends Object
    {
        public static const whMax:int = 5;
        public static const startX:int = 0;
        public static const startY:int = 0;
        public static var panelTbl:Array;
        private static const vLineX:Array = [[394, 451, 501, 546, 597, 649], [162, 307, 449, 598, 745, 895]];
        private static const hLineY:Array = [212, 240, 273, 311, 360, 422];

        public function PanelAll()
        {
            return;
        }// end function

        public static function init(param1:MovieClip)
        {
            var _loc_2:Panel = null;
            var _loc_4:int = 0;
            var _loc_5:Pos2 = null;
            var _loc_6:MovieClip = null;
            var _loc_7:RectI5 = null;
            var _loc_8:Number = NaN;
            panelTbl = new Array();
            var _loc_3:int = 0;
            while (_loc_3 < whMax)
            {
                
                panelTbl[_loc_3] = new Array();
                _loc_4 = 0;
                while (_loc_4 < whMax)
                {
                    
                    _loc_5 = new Pos2(_loc_3, _loc_4);
                    _loc_6 = param1["mciIce" + _loc_3 + _loc_4];
                    _loc_7 = makeIRect(_loc_5);
                    _loc_8 = dposy2Scale(_loc_7.center.y);
                    _loc_2 = new Panel(_loc_5, _loc_6, _loc_7, _loc_8);
                    panelTbl[_loc_3][_loc_4] = _loc_2;
                    _loc_2.meltLevel = 0;
                    _loc_4++;
                }
                _loc_3++;
            }
            return;
        }// end function

        public static function update() : void
        {
            var _loc_2:int = 0;
            var _loc_3:Panel = null;
            var _loc_1:int = 0;
            while (_loc_1 < whMax)
            {
                
                _loc_2 = 0;
                while (_loc_2 < whMax)
                {
                    
                    _loc_3 = panelTbl[_loc_1][_loc_2];
                    _loc_3.update();
                    _loc_2++;
                }
                _loc_1++;
            }
            return;
        }// end function

        public static function setRouteTargetPPos(param1:Pos2) : void
        {
            var _loc_3:Panel = null;
            var _loc_2:* = new Pos2();
            _loc_2.x = 0;
            while (_loc_2.x < whMax)
            {
                
                _loc_2.y = 0;
                while (_loc_2.y < whMax)
                {
                    
                    _loc_3 = panelTbl[_loc_2.x][_loc_2.y];
                    if (_loc_2.isEq(param1))
                    {
                    }
                    _loc_3.setRouteTarget(_loc_2.isEq(param1));
                    var _loc_4:* = _loc_2;
                    var _loc_5:* = _loc_2.y + 1;
                    _loc_4.y = _loc_5;
                }
                var _loc_4:* = _loc_2;
                var _loc_5:* = _loc_2.x + 1;
                _loc_4.x = _loc_5;
            }
            return;
        }// end function

        public static function draw(param1:MovieClip, param2:int) : void
        {
            var _loc_4:int = 0;
            if (param2 < 0 || param2 >= whMax)
            {
                return;
            }
            var _loc_3:* = whMax / 2;
            _loc_4 = 0;
            while (_loc_4 < _loc_3)
            {
                
                panelTbl[_loc_4][param2].draw(param1);
                _loc_4++;
            }
            _loc_4 = whMax - 1;
            while (_loc_4 >= _loc_3)
            {
                
                panelTbl[_loc_4][param2].draw(param1);
                _loc_4 = _loc_4 - 1;
            }
            return;
        }// end function

        public static function getDPos2PanelObj(param1:Pos2) : Panel
        {
            var _loc_2:* = getDPos2PanelPos(param1);
            if (!isDPositionValid(_loc_2))
            {
                return null;
            }
            return panelTbl[_loc_2.x][_loc_2.y];
        }// end function

        public static function getPPos2PanelObj(param1:Pos2) : Panel
        {
            if (!isDPositionValid(param1))
            {
                return null;
            }
            return panelTbl[param1.x][param1.y];
        }// end function

        public static function getPPos2DPos(param1:Pos2) : Pos2
        {
            var _loc_2:* = getPPos2PanelObj(param1);
            return _loc_2.centerDPos;
        }// end function

        public static function isDPositionValid(param1:Pos2) : Boolean
        {
            return !(param1.x < 0 || param1.y < 0 || param1.x >= whMax || param1.y >= whMax);
        }// end function

        public static function createMoveAblePanelTbl(param1:Pos2) : Array
        {
            var _loc_3:Pos2 = null;
            var _loc_5:int = 0;
            var _loc_6:Panel = null;
            var _loc_2:* = new Array();
            var _loc_4:int = -1;
            while (_loc_4 <= 1)
            {
                
                _loc_5 = -1;
                while (_loc_5 <= 1)
                {
                    
                    if (_loc_4 == 0 && _loc_5 == 0)
                    {
                    }
                    else
                    {
                        _loc_3 = param1.clone();
                        _loc_3.x = _loc_3.x + _loc_4;
                        _loc_3.y = _loc_3.y + _loc_5;
                        _loc_6 = getPPos2PanelObj(_loc_3);
                        if (_loc_6 != null && !_loc_6.isMelted())
                        {
                            _loc_2.push(_loc_6);
                        }
                    }
                    _loc_5++;
                }
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public static function getWH() : Pos2
        {
            return new Pos2(Panel.wh * whMax, Panel.wh * whMax);
        }// end function

        public static function getPanelTopLineY() : int
        {
            return hLineY[0];
        }// end function

        private static function makeIRect(param1:Pos2) : RectI5
        {
            var _loc_2:* = new RectI5(getLineCrossPos(new Pos2(param1.x, param1.y)), getLineCrossPos(new Pos2((param1.x + 1), param1.y)), getLineCrossPos(new Pos2((param1.x + 1), (param1.y + 1))), getLineCrossPos(new Pos2(param1.x, (param1.y + 1))));
            return _loc_2;
        }// end function

        private static function getLineCrossPos(param1:Pos2) : Pos2
        {
            var _loc_2:* = xPositionOnVLine(param1.x, hLineY[param1.y]);
            var _loc_3:* = new Pos2(_loc_2, hLineY[param1.y]);
            return _loc_3;
        }// end function

        private static function xPositionOnVLine(param1:int, param2:int) : int
        {
            var _loc_3:* = vLineX[1][param1] - vLineX[0][param1];
            var _loc_4:* = hLineY[whMax] - hLineY[0];
            var _loc_5:* = Math.floor(vLineX[0][param1] + _loc_3 * (param2 - hLineY[0]) / _loc_4);
            return Math.floor(vLineX[0][param1] + _loc_3 * (param2 - hLineY[0]) / _loc_4);
        }// end function

        public static function dposy2Scale(param1:int) : Number
        {
            var _loc_2:* = (hLineY[0] + hLineY[1]) / 2;
            var _loc_3:* = (hLineY[(hLineY.length - 1)] + hLineY[hLineY.length - 2]) / 2;
            var _loc_4:* = (_loc_3 - param1) / (_loc_3 - _loc_2);
            var _loc_5:* = (vLineX[0][4] - vLineX[0][1]) * 1.4;
            var _loc_6:* = (vLineX[1][4] - vLineX[1][1]) / 1.2;
            var _loc_7:* = ((vLineX[1][4] - vLineX[1][1]) / 1.2 - _loc_4 * (_loc_6 - _loc_5)) / _loc_6;
            return ((vLineX[1][4] - vLineX[1][1]) / 1.2 - _loc_4 * (_loc_6 - _loc_5)) / _loc_6;
        }// end function

        public static function getDPos2PanelPosForPokemon(param1:Pos2) : Pos2
        {
            var _loc_2:* = getDPos2PanelPos(param1);
            if (_loc_2.x < 0)
            {
                _loc_2.x = 0;
            }
            if (_loc_2.x >= (whMax - 1))
            {
                _loc_2.x = whMax - 1;
            }
            if (_loc_2.y < 0)
            {
                _loc_2.y = 0;
            }
            if (_loc_2.y >= (whMax - 1))
            {
                _loc_2.y = whMax - 1;
            }
            return _loc_2;
        }// end function

        public static function getDPos2PanelPos(param1:Pos2) : Pos2
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            _loc_2 = 0;
            while (_loc_2 <= whMax)
            {
                
                if (param1.y <= hLineY[_loc_2])
                {
                    break;
                }
                _loc_2++;
            }
            _loc_2 = _loc_2 - 1;
            _loc_3 = 0;
            while (_loc_3 <= whMax)
            {
                
                _loc_4 = xPositionOnVLine(_loc_3, param1.y);
                if (param1.x <= _loc_4)
                {
                    break;
                }
                _loc_3++;
            }
            _loc_3 = _loc_3 - 1;
            return new Pos2(_loc_3, _loc_2);
        }// end function

        public static function calcPanelCenterDPos_AtYMove(param1:int, param2:Pos2, param3:Pos2) : Pos2
        {
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            if (param2.y < param3.y)
            {
                _loc_4 = param2.y;
                _loc_5 = param3.y;
            }
            else
            {
                _loc_4 = param3.y;
                _loc_5 = param2.y;
            }
            var _loc_6:* = dposY2pposY(_loc_4);
            var _loc_7:* = dposY2pposY(_loc_5);
            if (_loc_6 == _loc_7)
            {
                return null;
            }
            var _loc_8:* = hLineY[(_loc_6 + 1)];
            var _loc_9:* = param2.x;
            var _loc_10:* = param3.subFrom(param2);
            var _loc_11:* = _loc_8 - param2.y;
            var _loc_12:* = _loc_9;
            _loc_12 = _loc_9 + _loc_10.x * Math.abs(_loc_11) / Math.abs(_loc_10.y);
            return new Pos2(_loc_12, _loc_8);
        }// end function

        public static function dposY2pposY(param1:int) : int
        {
            var _loc_2:int = 1;
            while (_loc_2 < hLineY.length)
            {
                
                if (param1 < hLineY[_loc_2])
                {
                    return (_loc_2 - 1);
                }
                _loc_2++;
            }
            return _loc_2 - 2;
        }// end function

        public static function makeAllPositionTbl() : Array
        {
            var _loc_1:* = new Array();
            var _loc_2:* = new Pos2(0, 0);
            _loc_2.x = 0;
            while (_loc_2.x < PanelAll.whMax)
            {
                
                _loc_2.y = 0;
                while (_loc_2.y < PanelAll.whMax)
                {
                    
                    _loc_1.push(_loc_2.clone());
                    var _loc_3:* = _loc_2;
                    var _loc_4:* = _loc_2.y + 1;
                    _loc_3.y = _loc_4;
                }
                var _loc_3:* = _loc_2;
                var _loc_4:* = _loc_2.x + 1;
                _loc_3.x = _loc_4;
            }
            return _loc_1;
        }// end function

    }
}
