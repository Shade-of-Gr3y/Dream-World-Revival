package jp.co.pokemon.games.hsc
{
    import flash.display.*;
    import flash.utils.*;

    public class CrowdsAll extends Object
    {
        public static const crowdsRMax:int = 5;
        public static const crowdsFMax:int = 5;
        public static const crowdsLMax:int = 3;
        public static const crowdsMax:int = 13;
        private static const crowdDataRenderSortIndexTbl:Array = new Array();
        public static var crowdsTbl:Array = new Array();
        public static var flierTbl:Array = new Array();

        public function CrowdsAll()
        {
            return;
        }// end function

        public static function init(param1:MovieClip) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:MovieClip = null;
            var _loc_5:String = null;
            var _loc_6:Boolean = false;
            param1.visible = false;
            _loc_2 = 0;
            while (_loc_2 < param1.numChildren)
            {
                
                _loc_4 = param1.getChildAt(_loc_2) as MovieClip;
                _loc_5 = getQualifiedClassName(_loc_4);
                _loc_6 = _loc_5 == "poke_tunbear" || _loc_5 == "poke_hihidaruma";
                crowdsTbl[_loc_2] = new Crowd(_loc_5, new Pos2(_loc_4.x, _loc_4.y), _loc_6);
                crowdDataRenderSortIndexTbl[_loc_2] = _loc_2;
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < Flier.TYPE_MAX)
            {
                
                flierTbl[_loc_2] = new Flier(_loc_2);
                _loc_2++;
            }
            return;
        }// end function

        public static function update() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < crowdsTbl.length)
            {
                
                crowdsTbl[_loc_1].update();
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < flierTbl.length)
            {
                
                flierTbl[_loc_1].update();
                _loc_1++;
            }
            return;
        }// end function

        public static function draw(param1:MovieClip, param2:int) : void
        {
            var _loc_4:int = 0;
            var _loc_3:int = 0;
            while (_loc_3 < crowdDataRenderSortIndexTbl.length)
            {
                
                _loc_4 = crowdDataRenderSortIndexTbl[_loc_3];
                crowdsTbl[_loc_4].draw(param1.mciPanelPokemon, param2);
                _loc_3++;
            }
            _loc_3 = 0;
            while (_loc_3 < flierTbl.length)
            {
                
                flierTbl[_loc_3].draw(param1, param2);
                _loc_3++;
            }
            return;
        }// end function

        public static function getLargeIdlePokemonRandom() : Crowd
        {
            var _loc_3:Crowd = null;
            var _loc_1:* = new Array();
            var _loc_2:int = 0;
            while (_loc_2 < crowdsTbl.length)
            {
                
                _loc_3 = crowdsTbl[_loc_2];
                if (_loc_3.isAbleFallSweets && _loc_3.isIdle())
                {
                    _loc_1.push(_loc_3);
                }
                _loc_2++;
            }
            return Tools.tableRandomGet(_loc_1) as Crowd;
        }// end function

        public static function getNonLargeIdlePokemonRandom() : Crowd
        {
            var _loc_3:Crowd = null;
            var _loc_1:* = new Array();
            var _loc_2:int = 0;
            while (_loc_2 < crowdsTbl.length)
            {
                
                _loc_3 = crowdsTbl[_loc_2];
                if (!_loc_3.isAbleFallSweets && _loc_3.isIdle())
                {
                    _loc_1.push(_loc_3);
                }
                _loc_2++;
            }
            return Tools.tableRandomGet(_loc_1) as Crowd;
        }// end function

        public static function getFlierToPutIn(param1:int) : Flier
        {
            var _loc_2:* = flierTbl[param1];
            if (!_loc_2.isIdle())
            {
                return null;
            }
            return _loc_2;
        }// end function

        public static function getCrowdByName(param1:String) : Crowd
        {
            var _loc_2:int = 0;
            while (_loc_2 < crowdsTbl.length)
            {
                
                if (crowdsTbl[_loc_2].mclName == param1)
                {
                    return crowdsTbl[_loc_2];
                }
                _loc_2++;
            }
            return null;
        }// end function

    }
}
