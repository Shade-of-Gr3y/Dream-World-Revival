package caurina.transitions
{

    public class Equations extends Object
    {

        public function Equations()
        {
            return;
        }// end function

        public static function init() : void
        {
            Tweener.registerTransition("easenone", easeNone);
            Tweener.registerTransition("linear", easeNone);
            Tweener.registerTransition("easeinquad", easeInQuad);
            Tweener.registerTransition("easeoutquad", easeOutQuad);
            Tweener.registerTransition("easeinoutquad", easeInOutQuad);
            Tweener.registerTransition("easeoutinquad", easeOutInQuad);
            Tweener.registerTransition("easeincubic", easeInCubic);
            Tweener.registerTransition("easeoutcubic", easeOutCubic);
            Tweener.registerTransition("easeinoutcubic", easeInOutCubic);
            Tweener.registerTransition("easeoutincubic", easeOutInCubic);
            Tweener.registerTransition("easeinquart", easeInQuart);
            Tweener.registerTransition("easeoutquart", easeOutQuart);
            Tweener.registerTransition("easeinoutquart", easeInOutQuart);
            Tweener.registerTransition("easeoutinquart", easeOutInQuart);
            Tweener.registerTransition("easeinquint", easeInQuint);
            Tweener.registerTransition("easeoutquint", easeOutQuint);
            Tweener.registerTransition("easeinoutquint", easeInOutQuint);
            Tweener.registerTransition("easeoutinquint", easeOutInQuint);
            Tweener.registerTransition("easeinsine", easeInSine);
            Tweener.registerTransition("easeoutsine", easeOutSine);
            Tweener.registerTransition("easeinoutsine", easeInOutSine);
            Tweener.registerTransition("easeoutinsine", easeOutInSine);
            Tweener.registerTransition("easeincirc", easeInCirc);
            Tweener.registerTransition("easeoutcirc", easeOutCirc);
            Tweener.registerTransition("easeinoutcirc", easeInOutCirc);
            Tweener.registerTransition("easeoutincirc", easeOutInCirc);
            Tweener.registerTransition("easeinexpo", easeInExpo);
            Tweener.registerTransition("easeoutexpo", easeOutExpo);
            Tweener.registerTransition("easeinoutexpo", easeInOutExpo);
            Tweener.registerTransition("easeoutinexpo", easeOutInExpo);
            Tweener.registerTransition("easeinelastic", easeInElastic);
            Tweener.registerTransition("easeoutelastic", easeOutElastic);
            Tweener.registerTransition("easeinoutelastic", easeInOutElastic);
            Tweener.registerTransition("easeoutinelastic", easeOutInElastic);
            Tweener.registerTransition("easeinback", easeInBack);
            Tweener.registerTransition("easeoutback", easeOutBack);
            Tweener.registerTransition("easeinoutback", easeInOutBack);
            Tweener.registerTransition("easeoutinback", easeOutInBack);
            Tweener.registerTransition("easeinbounce", easeInBounce);
            Tweener.registerTransition("easeoutbounce", easeOutBounce);
            Tweener.registerTransition("easeinoutbounce", easeInOutBounce);
            Tweener.registerTransition("easeoutinbounce", easeOutInBounce);
            return;
        }// end function

        public static function easeNone(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            return param3 * param1 / param4 + param2;
        }// end function

        public static function easeInQuad(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            var _loc_6:* = param1 / param4;
            param1 = param1 / param4;
            return param3 * _loc_6 * param1 + param2;
        }// end function

        public static function easeOutQuad(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            var _loc_6:* = param1 / param4;
            param1 = param1 / param4;
            return (-param3) * _loc_6 * (param1 - 2) + param2;
        }// end function

        public static function easeInOutQuad(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            var _loc_6:* = param1 / (param4 / 2);
            param1 = param1 / (param4 / 2);
            if (_loc_6 < 1)
            {
                return param3 / 2 * param1 * param1 + param2;
            }
            return (-param3) / 2 * (--param1 * (--param1 - 2) - 1) + param2;
        }// end function

        public static function easeOutInQuad(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            if (param1 < param4 / 2)
            {
                return easeOutQuad(param1 * 2, param2, param3 / 2, param4, param5);
            }
            return easeInQuad(param1 * 2 - param4, param2 + param3 / 2, param3 / 2, param4, param5);
        }// end function

        public static function easeInCubic(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            var _loc_6:* = param1 / param4;
            param1 = param1 / param4;
            return param3 * _loc_6 * param1 * param1 + param2;
        }// end function

        public static function easeOutCubic(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            var _loc_6:* = param1 / param4 - 1;
            param1 = param1 / param4 - 1;
            return param3 * (_loc_6 * param1 * param1 + 1) + param2;
        }// end function

        public static function easeInOutCubic(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            var _loc_6:* = param1 / (param4 / 2);
            param1 = param1 / (param4 / 2);
            if (_loc_6 < 1)
            {
                return param3 / 2 * param1 * param1 * param1 + param2;
            }
            var _loc_6:* = param1 - 2;
            param1 = param1 - 2;
            return param3 / 2 * (_loc_6 * param1 * param1 + 2) + param2;
        }// end function

        public static function easeOutInCubic(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            if (param1 < param4 / 2)
            {
                return easeOutCubic(param1 * 2, param2, param3 / 2, param4, param5);
            }
            return easeInCubic(param1 * 2 - param4, param2 + param3 / 2, param3 / 2, param4, param5);
        }// end function

        public static function easeInQuart(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            var _loc_6:* = param1 / param4;
            param1 = param1 / param4;
            return param3 * _loc_6 * param1 * param1 * param1 + param2;
        }// end function

        public static function easeOutQuart(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            var _loc_6:* = param1 / param4 - 1;
            param1 = param1 / param4 - 1;
            return (-param3) * (_loc_6 * param1 * param1 * param1 - 1) + param2;
        }// end function

        public static function easeInOutQuart(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            var _loc_6:* = param1 / (param4 / 2);
            param1 = param1 / (param4 / 2);
            if (_loc_6 < 1)
            {
                return param3 / 2 * param1 * param1 * param1 * param1 + param2;
            }
            var _loc_6:* = param1 - 2;
            param1 = param1 - 2;
            return (-param3) / 2 * (_loc_6 * param1 * param1 * param1 - 2) + param2;
        }// end function

        public static function easeOutInQuart(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            if (param1 < param4 / 2)
            {
                return easeOutQuart(param1 * 2, param2, param3 / 2, param4, param5);
            }
            return easeInQuart(param1 * 2 - param4, param2 + param3 / 2, param3 / 2, param4, param5);
        }// end function

        public static function easeInQuint(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            var _loc_6:* = param1 / param4;
            param1 = param1 / param4;
            return param3 * _loc_6 * param1 * param1 * param1 * param1 + param2;
        }// end function

        public static function easeOutQuint(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            var _loc_6:* = param1 / param4 - 1;
            param1 = param1 / param4 - 1;
            return param3 * (_loc_6 * param1 * param1 * param1 * param1 + 1) + param2;
        }// end function

        public static function easeInOutQuint(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            var _loc_6:* = param1 / (param4 / 2);
            param1 = param1 / (param4 / 2);
            if (_loc_6 < 1)
            {
                return param3 / 2 * param1 * param1 * param1 * param1 * param1 + param2;
            }
            var _loc_6:* = param1 - 2;
            param1 = param1 - 2;
            return param3 / 2 * (_loc_6 * param1 * param1 * param1 * param1 + 2) + param2;
        }// end function

        public static function easeOutInQuint(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            if (param1 < param4 / 2)
            {
                return easeOutQuint(param1 * 2, param2, param3 / 2, param4, param5);
            }
            return easeInQuint(param1 * 2 - param4, param2 + param3 / 2, param3 / 2, param4, param5);
        }// end function

        public static function easeInSine(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            return (-param3) * Math.cos(param1 / param4 * (Math.PI / 2)) + param3 + param2;
        }// end function

        public static function easeOutSine(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            return param3 * Math.sin(param1 / param4 * (Math.PI / 2)) + param2;
        }// end function

        public static function easeInOutSine(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            return (-param3) / 2 * (Math.cos(Math.PI * param1 / param4) - 1) + param2;
        }// end function

        public static function easeOutInSine(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            if (param1 < param4 / 2)
            {
                return easeOutSine(param1 * 2, param2, param3 / 2, param4, param5);
            }
            return easeInSine(param1 * 2 - param4, param2 + param3 / 2, param3 / 2, param4, param5);
        }// end function

        public static function easeInExpo(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            return param1 == 0 ? (param2) : (param3 * Math.pow(2, 10 * (param1 / param4 - 1)) + param2 - param3 * 0.001);
        }// end function

        public static function easeOutExpo(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            return param1 == param4 ? (param2 + param3) : (param3 * 1.001 * (-Math.pow(2, -10 * param1 / param4) + 1) + param2);
        }// end function

        public static function easeInOutExpo(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            if (param1 == 0)
            {
                return param2;
            }
            if (param1 == param4)
            {
                return param2 + param3;
            }
            var _loc_6:* = param1 / (param4 / 2);
            param1 = param1 / (param4 / 2);
            if (_loc_6 < 1)
            {
                return param3 / 2 * Math.pow(2, 10 * (param1 - 1)) + param2 - param3 * 0.0005;
            }
            return param3 / 2 * 1.0005 * (-Math.pow(2, -10 * --param1) + 2) + param2;
        }// end function

        public static function easeOutInExpo(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            if (param1 < param4 / 2)
            {
                return easeOutExpo(param1 * 2, param2, param3 / 2, param4, param5);
            }
            return easeInExpo(param1 * 2 - param4, param2 + param3 / 2, param3 / 2, param4, param5);
        }// end function

        public static function easeInCirc(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            var _loc_6:* = param1 / param4;
            param1 = param1 / param4;
            return (-param3) * (Math.sqrt(1 - _loc_6 * param1) - 1) + param2;
        }// end function

        public static function easeOutCirc(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            var _loc_6:* = param1 / param4 - 1;
            param1 = param1 / param4 - 1;
            return param3 * Math.sqrt(1 - _loc_6 * param1) + param2;
        }// end function

        public static function easeInOutCirc(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            var _loc_6:* = param1 / (param4 / 2);
            param1 = param1 / (param4 / 2);
            if (_loc_6 < 1)
            {
                return (-param3) / 2 * (Math.sqrt(1 - param1 * param1) - 1) + param2;
            }
            var _loc_6:* = param1 - 2;
            param1 = param1 - 2;
            return param3 / 2 * (Math.sqrt(1 - _loc_6 * param1) + 1) + param2;
        }// end function

        public static function easeOutInCirc(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            if (param1 < param4 / 2)
            {
                return easeOutCirc(param1 * 2, param2, param3 / 2, param4, param5);
            }
            return easeInCirc(param1 * 2 - param4, param2 + param3 / 2, param3 / 2, param4, param5);
        }// end function

        public static function easeInElastic(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            var _loc_7:Number = NaN;
            if (param1 == 0)
            {
                return param2;
            }
            var _loc_9:* = param1 / param4;
            param1 = param1 / param4;
            if (_loc_9 == 1)
            {
                return param2 + param3;
            }
            var _loc_6:* = !Boolean(param5) || isNaN(param5.period) ? (param4 * 0.3) : (param5.period);
            var _loc_8:* = !Boolean(param5) || isNaN(param5.amplitude) ? (0) : (param5.amplitude);
            if (!Boolean(_loc_8) || _loc_8 < Math.abs(param3))
            {
                _loc_8 = param3;
                _loc_7 = _loc_6 / 4;
            }
            else
            {
                _loc_7 = _loc_6 / (2 * Math.PI) * Math.asin(param3 / _loc_8);
            }
            param1 = param1 - 1;
            return -_loc_8 * Math.pow(2, 10 * --param1) * Math.sin((param1 * param4 - _loc_7) * (2 * Math.PI) / _loc_6) + param2;
        }// end function

        public static function easeOutElastic(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            var _loc_7:Number = NaN;
            if (param1 == 0)
            {
                return param2;
            }
            var _loc_9:* = param1 / param4;
            param1 = param1 / param4;
            if (_loc_9 == 1)
            {
                return param2 + param3;
            }
            var _loc_6:* = !Boolean(param5) || isNaN(param5.period) ? (param4 * 0.3) : (param5.period);
            var _loc_8:* = !Boolean(param5) || isNaN(param5.amplitude) ? (0) : (param5.amplitude);
            if (!Boolean(_loc_8) || _loc_8 < Math.abs(param3))
            {
                _loc_8 = param3;
                _loc_7 = _loc_6 / 4;
            }
            else
            {
                _loc_7 = _loc_6 / (2 * Math.PI) * Math.asin(param3 / _loc_8);
            }
            return _loc_8 * Math.pow(2, -10 * param1) * Math.sin((param1 * param4 - _loc_7) * (2 * Math.PI) / _loc_6) + param3 + param2;
        }// end function

        public static function easeInOutElastic(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            var _loc_7:Number = NaN;
            if (param1 == 0)
            {
                return param2;
            }
            var _loc_9:* = param1 / (param4 / 2);
            param1 = param1 / (param4 / 2);
            if (_loc_9 == 2)
            {
                return param2 + param3;
            }
            var _loc_6:* = !Boolean(param5) || isNaN(param5.period) ? (param4 * (0.3 * 1.5)) : (param5.period);
            var _loc_8:* = !Boolean(param5) || isNaN(param5.amplitude) ? (0) : (param5.amplitude);
            if (!Boolean(_loc_8) || _loc_8 < Math.abs(param3))
            {
                _loc_8 = param3;
                _loc_7 = _loc_6 / 4;
            }
            else
            {
                _loc_7 = _loc_6 / (2 * Math.PI) * Math.asin(param3 / _loc_8);
            }
            if (param1 < 1)
            {
                param1 = param1 - 1;
                return -0.5 * (_loc_8 * Math.pow(2, 10 * --param1) * Math.sin((param1 * param4 - _loc_7) * (2 * Math.PI) / _loc_6)) + param2;
            }
            param1 = param1 - 1;
            return _loc_8 * Math.pow(2, -10 * --param1) * Math.sin((param1 * param4 - _loc_7) * (2 * Math.PI) / _loc_6) * 0.5 + param3 + param2;
        }// end function

        public static function easeOutInElastic(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            if (param1 < param4 / 2)
            {
                return easeOutElastic(param1 * 2, param2, param3 / 2, param4, param5);
            }
            return easeInElastic(param1 * 2 - param4, param2 + param3 / 2, param3 / 2, param4, param5);
        }// end function

        public static function easeInBack(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            var _loc_6:* = !Boolean(param5) || isNaN(param5.overshoot) ? (1.70158) : (param5.overshoot);
            var _loc_7:* = param1 / param4;
            param1 = param1 / param4;
            return param3 * _loc_7 * param1 * ((_loc_6 + 1) * param1 - _loc_6) + param2;
        }// end function

        public static function easeOutBack(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            var _loc_6:* = !Boolean(param5) || isNaN(param5.overshoot) ? (1.70158) : (param5.overshoot);
            var _loc_7:* = param1 / param4 - 1;
            param1 = param1 / param4 - 1;
            return param3 * (_loc_7 * param1 * ((_loc_6 + 1) * param1 + _loc_6) + 1) + param2;
        }// end function

        public static function easeInOutBack(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            var _loc_6:* = !Boolean(param5) || isNaN(param5.overshoot) ? (1.70158) : (param5.overshoot);
            var _loc_7:* = param1 / (param4 / 2);
            param1 = param1 / (param4 / 2);
            if (_loc_7 < 1)
            {
                var _loc_7:* = _loc_6 * 1.525;
                _loc_6 = _loc_6 * 1.525;
                return param3 / 2 * (param1 * param1 * ((_loc_7 + 1) * param1 - _loc_6)) + param2;
            }
            var _loc_7:* = param1 - 2;
            param1 = param1 - 2;
            var _loc_7:* = _loc_6 * 1.525;
            _loc_6 = _loc_6 * 1.525;
            return param3 / 2 * (_loc_7 * param1 * ((_loc_7 + 1) * param1 + _loc_6) + 2) + param2;
        }// end function

        public static function easeOutInBack(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            if (param1 < param4 / 2)
            {
                return easeOutBack(param1 * 2, param2, param3 / 2, param4, param5);
            }
            return easeInBack(param1 * 2 - param4, param2 + param3 / 2, param3 / 2, param4, param5);
        }// end function

        public static function easeInBounce(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            return param3 - easeOutBounce(param4 - param1, 0, param3, param4) + param2;
        }// end function

        public static function easeOutBounce(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            var _loc_6:* = param1 / param4;
            param1 = param1 / param4;
            if (_loc_6 < 1 / 2.75)
            {
                return param3 * (7.5625 * param1 * param1) + param2;
            }
            if (param1 < 2 / 2.75)
            {
                var _loc_6:* = param1 - 1.5 / 2.75;
                param1 = param1 - 1.5 / 2.75;
                return param3 * (7.5625 * _loc_6 * param1 + 0.75) + param2;
            }
            if (param1 < 2.5 / 2.75)
            {
                var _loc_6:* = param1 - 2.25 / 2.75;
                param1 = param1 - 2.25 / 2.75;
                return param3 * (7.5625 * _loc_6 * param1 + 0.9375) + param2;
            }
            var _loc_6:* = param1 - 2.625 / 2.75;
            param1 = param1 - 2.625 / 2.75;
            return param3 * (7.5625 * _loc_6 * param1 + 0.984375) + param2;
        }// end function

        public static function easeInOutBounce(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            if (param1 < param4 / 2)
            {
                return easeInBounce(param1 * 2, 0, param3, param4) * 0.5 + param2;
            }
            return easeOutBounce(param1 * 2 - param4, 0, param3, param4) * 0.5 + param3 * 0.5 + param2;
        }// end function

        public static function easeOutInBounce(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
        {
            if (param1 < param4 / 2)
            {
                return easeOutBounce(param1 * 2, param2, param3 / 2, param4, param5);
            }
            return easeInBounce(param1 * 2 - param4, param2 + param3 / 2, param3 / 2, param4, param5);
        }// end function

    }
}
