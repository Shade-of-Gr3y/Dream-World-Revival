package jp.co.pokemon.games.hsc
{
    import flash.media.*;

    public class ZSound extends Object
    {
        private static const soundTbl:Array = [[new soundl_click_big(), "click_big", 0.5], [new soundl_click_small(), "click_small", 0.6], [new soundl_count(), "count", 0.5], [new soundl_count_start(), "count_start", 0.5], [new soundl_fall_falling(), "fall_falling", 0.5], [new soundl_fall_splash(), "fall_splash", 0.5], [new soundl_slam(), "slam", 0.5], [new soundl_get_back(), "get_back", 0.99], [new soundl_get_sweet_0(), "get_sweet_0", 0.5 * 1.1], [new soundl_get_sweet_1(), "get_sweet_1", 0.5 * 1.4], [new soundl_get_sweet_2(), "get_sweet_2", 0.5 * 1.85], [new soundl_get_sweet_3(), "get_sweet_3", 0.5 * 1.6], [new soundl_jump_in(), "jump_in", 0.8], [new soundl_put_sweet(), "put_sweet", 0.2], [new soundl_rollOver(), "rollOver", 0.99], [new soundl_throw_in(), "throw_in", 0.99], [new soundl_timeup(), "timeup", 0.6]];
        private static var testStep:int = 0;

        public function ZSound()
        {
            return;
        }// end function

        public static function play(param1:String) : void
        {
            var _loc_3:Array = null;
            var _loc_2:int = 0;
            while (_loc_2 < soundTbl.length)
            {
                
                _loc_3 = soundTbl[_loc_2];
                if (_loc_3[1] as String == param1)
                {
                    (_loc_3[0] as Sound).play(0, 1, new SoundTransform(_loc_3[2] as Number, 0));
                    return;
                }
                _loc_2++;
            }
            Tools.alert(false, "error!!");
            return;
        }// end function

        public static function testStart()
        {
            testStep = 0;
            return;
        }// end function

        public static function testOne()
        {
            var _loc_1:* = soundTbl[testStep++ % soundTbl.length];
            var _loc_2:* = _loc_1[0] as Sound;
            var _loc_3:* = _loc_1[2] as Number;
            _loc_3 = _loc_3 * 1.5;
            if (_loc_3 > 1)
            {
                _loc_3 = 1;
            }
            _loc_2.play(0, 1, new SoundTransform(_loc_3, 0));
            return;
        }// end function

    }
}
