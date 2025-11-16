package jp.feb19.transitions
{
   public class TweeningEasing
   {
       
      
      public function TweeningEasing()
      {
         super();
      }
      
      public static function getEasingFunction(param1:String) : Function
      {
         return TweeningEasing[param1];
      }
      
      public static function easeNone(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         return param3 * param1 / param4 + param2;
      }
      
      public static function easeInQuad(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         return param3 * (param1 = param1 / param4) * param1 + param2;
      }
      
      public static function easeOutQuad(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         return -param3 * (param1 = param1 / param4) * (param1 - 2) + param2;
      }
      
      public static function easeInOutQuad(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         if((param1 = param1 / (param4 / 2)) < 1)
         {
            return param3 / 2 * param1 * param1 + param2;
         }
         return -param3 / 2 * (--param1 * (param1 - 2) - 1) + param2;
      }
      
      public static function easeOutInQuad(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         if(param1 < param4 / 2)
         {
            return easeOutQuad(param1 * 2,param2,param3 / 2,param4,param5);
         }
         return easeInQuad(param1 * 2 - param4,param2 + param3 / 2,param3 / 2,param4,param5);
      }
      
      public static function easeInCubic(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         return param3 * (param1 = param1 / param4) * param1 * param1 + param2;
      }
      
      public static function easeOutCubic(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         return param3 * ((param1 = param1 / param4 - 1) * param1 * param1 + 1) + param2;
      }
      
      public static function easeInOutCubic(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         if((param1 = param1 / (param4 / 2)) < 1)
         {
            return param3 / 2 * param1 * param1 * param1 + param2;
         }
         return param3 / 2 * ((param1 = param1 - 2) * param1 * param1 + 2) + param2;
      }
      
      public static function easeOutInCubic(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         if(param1 < param4 / 2)
         {
            return easeOutCubic(param1 * 2,param2,param3 / 2,param4,param5);
         }
         return easeInCubic(param1 * 2 - param4,param2 + param3 / 2,param3 / 2,param4,param5);
      }
      
      public static function easeInQuart(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         return param3 * (param1 = param1 / param4) * param1 * param1 * param1 + param2;
      }
      
      public static function easeOutQuart(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         return -param3 * ((param1 = param1 / param4 - 1) * param1 * param1 * param1 - 1) + param2;
      }
      
      public static function easeInOutQuart(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         if((param1 = param1 / (param4 / 2)) < 1)
         {
            return param3 / 2 * param1 * param1 * param1 * param1 + param2;
         }
         return -param3 / 2 * ((param1 = param1 - 2) * param1 * param1 * param1 - 2) + param2;
      }
      
      public static function easeOutInQuart(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         if(param1 < param4 / 2)
         {
            return easeOutQuart(param1 * 2,param2,param3 / 2,param4,param5);
         }
         return easeInQuart(param1 * 2 - param4,param2 + param3 / 2,param3 / 2,param4,param5);
      }
      
      public static function easeInQuint(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         return param3 * (param1 = param1 / param4) * param1 * param1 * param1 * param1 + param2;
      }
      
      public static function easeOutQuint(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         return param3 * ((param1 = param1 / param4 - 1) * param1 * param1 * param1 * param1 + 1) + param2;
      }
      
      public static function easeInOutQuint(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         if((param1 = param1 / (param4 / 2)) < 1)
         {
            return param3 / 2 * param1 * param1 * param1 * param1 * param1 + param2;
         }
         return param3 / 2 * ((param1 = param1 - 2) * param1 * param1 * param1 * param1 + 2) + param2;
      }
      
      public static function easeOutInQuint(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         if(param1 < param4 / 2)
         {
            return easeOutQuint(param1 * 2,param2,param3 / 2,param4,param5);
         }
         return easeInQuint(param1 * 2 - param4,param2 + param3 / 2,param3 / 2,param4,param5);
      }
      
      public static function easeInSine(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         return -param3 * Math.cos(param1 / param4 * (Math.PI / 2)) + param3 + param2;
      }
      
      public static function easeOutSine(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         return param3 * Math.sin(param1 / param4 * (Math.PI / 2)) + param2;
      }
      
      public static function easeInOutSine(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         return -param3 / 2 * (Math.cos(Math.PI * param1 / param4) - 1) + param2;
      }
      
      public static function easeOutInSine(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         if(param1 < param4 / 2)
         {
            return easeOutSine(param1 * 2,param2,param3 / 2,param4,param5);
         }
         return easeInSine(param1 * 2 - param4,param2 + param3 / 2,param3 / 2,param4,param5);
      }
      
      public static function easeInExpo(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         return param1 == 0 ? param2 : param3 * Math.pow(2,10 * (param1 / param4 - 1)) + param2 - param3 * 0.001;
      }
      
      public static function easeOutExpo(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         return param1 == param4 ? param2 + param3 : param3 * 1.001 * (-Math.pow(2,-10 * param1 / param4) + 1) + param2;
      }
      
      public static function easeInOutExpo(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         if(param1 == 0)
         {
            return param2;
         }
         if(param1 == param4)
         {
            return param2 + param3;
         }
         if((param1 = param1 / (param4 / 2)) < 1)
         {
            return param3 / 2 * Math.pow(2,10 * (param1 - 1)) + param2 - param3 * 0.0005;
         }
         return param3 / 2 * 1.0005 * (-Math.pow(2,-10 * --param1) + 2) + param2;
      }
      
      public static function easeOutInExpo(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         if(param1 < param4 / 2)
         {
            return easeOutExpo(param1 * 2,param2,param3 / 2,param4,param5);
         }
         return easeInExpo(param1 * 2 - param4,param2 + param3 / 2,param3 / 2,param4,param5);
      }
      
      public static function easeInCirc(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         return -param3 * (Math.sqrt(1 - (param1 = param1 / param4) * param1) - 1) + param2;
      }
      
      public static function easeOutCirc(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         return param3 * Math.sqrt(1 - (param1 = param1 / param4 - 1) * param1) + param2;
      }
      
      public static function easeInOutCirc(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         if((param1 = param1 / (param4 / 2)) < 1)
         {
            return -param3 / 2 * (Math.sqrt(1 - param1 * param1) - 1) + param2;
         }
         return param3 / 2 * (Math.sqrt(1 - (param1 = param1 - 2) * param1) + 1) + param2;
      }
      
      public static function easeOutInCirc(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         if(param1 < param4 / 2)
         {
            return easeOutCirc(param1 * 2,param2,param3 / 2,param4,param5);
         }
         return easeInCirc(param1 * 2 - param4,param2 + param3 / 2,param3 / 2,param4,param5);
      }
      
      public static function easeInElastic(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         var _loc7_:Number = NaN;
         if(param1 == 0)
         {
            return param2;
         }
         if((param1 = param1 / param4) == 1)
         {
            return param2 + param3;
         }
         var _loc6_:Number = !Boolean(param5) || isNaN(param5.period) ? param4 * 0.3 : Number(param5.period);
         var _loc8_:Number = !Boolean(param5) || isNaN(param5.amplitude) ? 0 : Number(param5.amplitude);
         if(!Boolean(_loc8_) || _loc8_ < Math.abs(param3))
         {
            _loc8_ = param3;
            _loc7_ = _loc6_ / 4;
         }
         else
         {
            _loc7_ = _loc6_ / (2 * Math.PI) * Math.asin(param3 / _loc8_);
         }
         return -(_loc8_ * Math.pow(2,10 * (param1 = param1 - 1)) * Math.sin((param1 * param4 - _loc7_) * (2 * Math.PI) / _loc6_)) + param2;
      }
      
      public static function easeOutElastic(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         var _loc7_:Number = NaN;
         if(param1 == 0)
         {
            return param2;
         }
         if((param1 = param1 / param4) == 1)
         {
            return param2 + param3;
         }
         var _loc6_:Number = !Boolean(param5) || isNaN(param5.period) ? param4 * 0.3 : Number(param5.period);
         var _loc8_:Number = !Boolean(param5) || isNaN(param5.amplitude) ? 0 : Number(param5.amplitude);
         if(!Boolean(_loc8_) || _loc8_ < Math.abs(param3))
         {
            _loc8_ = param3;
            _loc7_ = _loc6_ / 4;
         }
         else
         {
            _loc7_ = _loc6_ / (2 * Math.PI) * Math.asin(param3 / _loc8_);
         }
         return _loc8_ * Math.pow(2,-10 * param1) * Math.sin((param1 * param4 - _loc7_) * (2 * Math.PI) / _loc6_) + param3 + param2;
      }
      
      public static function easeInOutElastic(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         var _loc7_:Number = NaN;
         if(param1 == 0)
         {
            return param2;
         }
         if((param1 = param1 / (param4 / 2)) == 2)
         {
            return param2 + param3;
         }
         var _loc6_:Number = !Boolean(param5) || isNaN(param5.period) ? param4 * (0.3 * 1.5) : Number(param5.period);
         var _loc8_:Number = !Boolean(param5) || isNaN(param5.amplitude) ? 0 : Number(param5.amplitude);
         if(!Boolean(_loc8_) || _loc8_ < Math.abs(param3))
         {
            _loc8_ = param3;
            _loc7_ = _loc6_ / 4;
         }
         else
         {
            _loc7_ = _loc6_ / (2 * Math.PI) * Math.asin(param3 / _loc8_);
         }
         if(param1 < 1)
         {
            return -0.5 * (_loc8_ * Math.pow(2,10 * (param1 = param1 - 1)) * Math.sin((param1 * param4 - _loc7_) * (2 * Math.PI) / _loc6_)) + param2;
         }
         return _loc8_ * Math.pow(2,-10 * (param1 = param1 - 1)) * Math.sin((param1 * param4 - _loc7_) * (2 * Math.PI) / _loc6_) * 0.5 + param3 + param2;
      }
      
      public static function easeOutInElastic(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         if(param1 < param4 / 2)
         {
            return easeOutElastic(param1 * 2,param2,param3 / 2,param4,param5);
         }
         return easeInElastic(param1 * 2 - param4,param2 + param3 / 2,param3 / 2,param4,param5);
      }
      
      public static function easeInBack(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         var _loc6_:Number = !Boolean(param5) || isNaN(param5.overshoot) ? 1.70158 : Number(param5.overshoot);
         return param3 * (param1 = param1 / param4) * param1 * ((_loc6_ + 1) * param1 - _loc6_) + param2;
      }
      
      public static function easeOutBack(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         var _loc6_:Number = !Boolean(param5) || isNaN(param5.overshoot) ? 1.70158 : Number(param5.overshoot);
         return param3 * ((param1 = param1 / param4 - 1) * param1 * ((_loc6_ + 1) * param1 + _loc6_) + 1) + param2;
      }
      
      public static function easeInOutBack(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         var _loc6_:Number = !Boolean(param5) || isNaN(param5.overshoot) ? 1.70158 : Number(param5.overshoot);
         if((param1 = param1 / (param4 / 2)) < 1)
         {
            return param3 / 2 * (param1 * param1 * (((_loc6_ = _loc6_ * 1.525) + 1) * param1 - _loc6_)) + param2;
         }
         return param3 / 2 * ((param1 = param1 - 2) * param1 * (((_loc6_ = _loc6_ * 1.525) + 1) * param1 + _loc6_) + 2) + param2;
      }
      
      public static function easeOutInBack(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         if(param1 < param4 / 2)
         {
            return easeOutBack(param1 * 2,param2,param3 / 2,param4,param5);
         }
         return easeInBack(param1 * 2 - param4,param2 + param3 / 2,param3 / 2,param4,param5);
      }
      
      public static function easeInBounce(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         return param3 - easeOutBounce(param4 - param1,0,param3,param4) + param2;
      }
      
      public static function easeOutBounce(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         if((param1 = param1 / param4) < 1 / 2.75)
         {
            return param3 * (7.5625 * param1 * param1) + param2;
         }
         if(param1 < 2 / 2.75)
         {
            return param3 * (7.5625 * (param1 = param1 - 1.5 / 2.75) * param1 + 0.75) + param2;
         }
         if(param1 < 2.5 / 2.75)
         {
            return param3 * (7.5625 * (param1 = param1 - 2.25 / 2.75) * param1 + 0.9375) + param2;
         }
         return param3 * (7.5625 * (param1 = param1 - 2.625 / 2.75) * param1 + 0.984375) + param2;
      }
      
      public static function easeInOutBounce(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         if(param1 < param4 / 2)
         {
            return easeInBounce(param1 * 2,0,param3,param4) * 0.5 + param2;
         }
         return easeOutBounce(param1 * 2 - param4,0,param3,param4) * 0.5 + param3 * 0.5 + param2;
      }
      
      public static function easeOutInBounce(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null) : Number
      {
         if(param1 < param4 / 2)
         {
            return easeOutBounce(param1 * 2,param2,param3 / 2,param4,param5);
         }
         return easeInBounce(param1 * 2 - param4,param2 + param3 / 2,param3 / 2,param4,param5);
      }
   }
}
