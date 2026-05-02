package jp.co.pokemon.games.hsc
{
    import flash.utils.*;

    public class PokeMc extends Object
    {
        private static const I_NAME:int = 0;
        private static const I_PNG_H:int = 1;
        private static const I_REAL_H:int = 2;
        private static const default_PngH:Number = 100;
        private static const default_Pow06:Number = Math.pow(1, 0.6);
        private static const mcNpcTbl:Array = [["poke_chirami", 110, 40 + 5], ["poke_hiyappu", 130, 60], ["poke_kiruria", 144, 80], ["poke_kolink", 140, 50], ["poke_mariru", 100, 40 + 5], ["poke_mimirol", 144, 40 + 5], ["poke_mizugorou", 144, 40 + 5], ["poke_muchuru", 113, 40 + 5], ["poke_riolu", 128, 70], ["poke_tamazarashi", 103, 80 - 20], ["poke_urimu", 86, 40 + 5], ["poke_yukiwarashi", 125, 70]];
        private static const mcPcTbl:Array = [["poke_manene", 142, 60], ["poke_mijumaru", 116, 50], ["poke_pichu", 125, 30 + 10], ["poke_zuruggu", 130, 60]];
        private static const mcCrowdsTbl:Array = [["poke_tunbear", 208, 260], ["poke_dogom", 154, 100], ["poke_enbuoh", 177, 160], ["poke_denryu", 165, 140], ["poke_hihidaruma", 156, 130], ["poke_yarukimono", 180, 140], ["poke_tabunnne", 148, 110], ["poke_bivanilla", 168, 130], ["poke_eipam", 100, 80], ["poke_maggyo", 116, 70], ["poke_hassam", 172, 180], ["poke_usokky", 165, 120], ["poke_lishan", 72, 20], ["poke_runpappa", 167, 150], ["poke_yukikaburi", 105, 100], ["poke_cherim", 110, 50], ["poke_perappu", 100, 50 + 30 - 12], ["poke_fuwaride", 110, 120 - 75 - 7]];
        private static var nameToScaleDic:Object = new Object();

        public function PokeMc()
        {
            return;
        }// end function

        public static function init() : void
        {
            initOne(mcNpcTbl, 1.6);
            initOne(mcPcTbl, 1.6);
            initOne(mcCrowdsTbl, 1.3);
            return;
        }// end function

        public static function initOne(param1:Array, param2:Number) : void
        {
            var _loc_4:String = null;
            var _loc_5:Number = NaN;
            var _loc_6:Number = NaN;
            var _loc_7:Number = NaN;
            var _loc_8:Number = NaN;
            var _loc_3:int = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_4 = param1[_loc_3][I_NAME];
                _loc_5 = param1[_loc_3][I_REAL_H] * 0.01;
                _loc_6 = Math.pow(_loc_5, 0.6);
                _loc_7 = _loc_6 / default_Pow06 / (param1[_loc_3][I_PNG_H] / default_PngH);
                _loc_8 = _loc_7 * param2;
                nameToScaleDic[_loc_4] = _loc_8;
                _loc_3++;
            }
            return;
        }// end function

        public static function getNameToScale(param1:String) : Number
        {
            return nameToScaleDic[param1] as Number;
        }// end function

        public static function choicePcNpc() : Array
        {
            var _loc_1:int = 0;
            var _loc_2:String = null;
            var _loc_5:int = 0;
            var _loc_6:Class = null;
            var _loc_3:* = new Array();
            _loc_1 = 0;
            while (_loc_1 < mcNpcTbl.length)
            {
                
                _loc_3[_loc_1] = _loc_1;
                _loc_1++;
            }
            var _loc_4:* = new Array();
            _loc_1 = 0;
            while (_loc_1 < GameData.npcMax)
            {
                
                _loc_5 = int(Tools.tableRandomGetAndDelete(_loc_3));
                _loc_2 = mcNpcTbl[_loc_5][I_NAME];
                _loc_6 = getDefinitionByName(_loc_2) as Class;
                _loc_4[(_loc_1 + 1)] = {mc:new _loc_6, mcForStatus:new _loc_6, type:_loc_5, name:_loc_2, scale:nameToScaleDic[_loc_2]};
                _loc_1++;
            }
            _loc_5 = Tools.randomLessInt(mcPcTbl.length);
            _loc_2 = mcPcTbl[_loc_5][I_NAME];
            _loc_6 = getDefinitionByName(_loc_2) as Class;
            _loc_4[0] = {mc:new _loc_6, mcForStatus:new _loc_6, type:_loc_5, name:_loc_2, scale:nameToScaleDic[_loc_2]};
            return _loc_4;
        }// end function

    }
}
