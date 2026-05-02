package caurina.transitions
{
   public class Equations
   {
      
      public function Equations()
      {
         super();
         trace("Equations is a static class and should not be instantiated.");
      }
      
      public static function easeOutBounce(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         t = t / d;
         if(t < 1 / 2.75)
         {
            return c * (7.5625 * t * t) + b;
         }
         if(t < 2 / 2.75)
         {
            return c * (7.5625 * (t = t - 1.5 / 2.75) * t + 0.75) + b;
         }
         if(t < 2.5 / 2.75)
         {
            return c * (7.5625 * (t = t - 2.25 / 2.75) * t + 0.9375) + b;
         }
         return c * (7.5625 * (t = t - 2.625 / 2.75) * t + 0.984375) + b;
      }
      
      public static function easeInOutElastic(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         var s:Number = NaN;
         if(t == 0)
         {
            return b;
         }
         t = t / (d / 2);
         if(t == 2)
         {
            return b + c;
         }
         var p:Number = !Boolean(p_params) || isNaN(p_params.period) ? d * (0.3 * 1.5) : Number(p_params.period);
         var a:Number = !Boolean(p_params) || isNaN(p_params.amplitude) ? 0 : Number(p_params.amplitude);
         if(!Boolean(a) || a < Math.abs(c))
         {
            a = c;
            s = p / 4;
         }
         else
         {
            s = p / (2 * Math.PI) * Math.asin(c / a);
         }
         if(t < 1)
         {
            return -0.5 * (a * Math.pow(2,10 * (t = t - 1)) * Math.sin((t * d - s) * (2 * Math.PI) / p)) + b;
         }
         return a * Math.pow(2,-10 * (t = t - 1)) * Math.sin((t * d - s) * (2 * Math.PI) / p) * 0.5 + c + b;
      }
      
      public static function easeInOutQuad(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         t = t / (d / 2);
         if(t < 1)
         {
            return c / 2 * t * t + b;
         }
         return -c / 2 * (--t * (t - 2) - 1) + b;
      }
      
      public static function easeInOutBounce(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         if(t < d / 2)
         {
            return easeInBounce(t * 2,0,c,d) * 0.5 + b;
         }
         return easeOutBounce(t * 2 - d,0,c,d) * 0.5 + c * 0.5 + b;
      }
      
      public static function easeInOutBack(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         var s:Number = !Boolean(p_params) || isNaN(p_params.overshoot) ? 1.70158 : Number(p_params.overshoot);
         t = t / (d / 2);
         if(t < 1)
         {
            return c / 2 * (t * t * (((s = s * 1.525) + 1) * t - s)) + b;
         }
         return c / 2 * ((t = t - 2) * t * (((s = s * 1.525) + 1) * t + s) + 2) + b;
      }
      
      public static function easeOutInCubic(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         if(t < d / 2)
         {
            return easeOutCubic(t * 2,b,c / 2,d,p_params);
         }
         return easeInCubic(t * 2 - d,b + c / 2,c / 2,d,p_params);
      }
      
      public static function easeNone(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         return c * t / d + b;
      }
      
      public static function easeOutBack(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         var s:Number = !Boolean(p_params) || isNaN(p_params.overshoot) ? 1.70158 : Number(p_params.overshoot);
         return c * ((t = t / d - 1) * t * ((s + 1) * t + s) + 1) + b;
      }
      
      public static function easeInOutSine(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         return -c / 2 * (Math.cos(Math.PI * t / d) - 1) + b;
      }
      
      public static function easeInBack(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         var s:Number = !Boolean(p_params) || isNaN(p_params.overshoot) ? 1.70158 : Number(p_params.overshoot);
         return c * (t = t / d) * t * ((s + 1) * t - s) + b;
      }
      
      public static function easeInQuart(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         return c * (t = t / d) * t * t * t + b;
      }
      
      public static function easeOutInQuint(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         if(t < d / 2)
         {
            return easeOutQuint(t * 2,b,c / 2,d,p_params);
         }
         return easeInQuint(t * 2 - d,b + c / 2,c / 2,d,p_params);
      }
      
      public static function easeOutInBounce(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         if(t < d / 2)
         {
            return easeOutBounce(t * 2,b,c / 2,d,p_params);
         }
         return easeInBounce(t * 2 - d,b + c / 2,c / 2,d,p_params);
      }
      
      public static function init() : void
      {
         Tweener.registerTransition("easenone",easeNone);
         Tweener.registerTransition("linear",easeNone);
         Tweener.registerTransition("easeinquad",easeInQuad);
         Tweener.registerTransition("easeoutquad",easeOutQuad);
         Tweener.registerTransition("easeinoutquad",easeInOutQuad);
         Tweener.registerTransition("easeoutinquad",easeOutInQuad);
         Tweener.registerTransition("easeincubic",easeInCubic);
         Tweener.registerTransition("easeoutcubic",easeOutCubic);
         Tweener.registerTransition("easeinoutcubic",easeInOutCubic);
         Tweener.registerTransition("easeoutincubic",easeOutInCubic);
         Tweener.registerTransition("easeinquart",easeInQuart);
         Tweener.registerTransition("easeoutquart",easeOutQuart);
         Tweener.registerTransition("easeinoutquart",easeInOutQuart);
         Tweener.registerTransition("easeoutinquart",easeOutInQuart);
         Tweener.registerTransition("easeinquint",easeInQuint);
         Tweener.registerTransition("easeoutquint",easeOutQuint);
         Tweener.registerTransition("easeinoutquint",easeInOutQuint);
         Tweener.registerTransition("easeoutinquint",easeOutInQuint);
         Tweener.registerTransition("easeinsine",easeInSine);
         Tweener.registerTransition("easeoutsine",easeOutSine);
         Tweener.registerTransition("easeinoutsine",easeInOutSine);
         Tweener.registerTransition("easeoutinsine",easeOutInSine);
         Tweener.registerTransition("easeincirc",easeInCirc);
         Tweener.registerTransition("easeoutcirc",easeOutCirc);
         Tweener.registerTransition("easeinoutcirc",easeInOutCirc);
         Tweener.registerTransition("easeoutincirc",easeOutInCirc);
         Tweener.registerTransition("easeinexpo",easeInExpo);
         Tweener.registerTransition("easeoutexpo",easeOutExpo);
         Tweener.registerTransition("easeinoutexpo",easeInOutExpo);
         Tweener.registerTransition("easeoutinexpo",easeOutInExpo);
         Tweener.registerTransition("easeinelastic",easeInElastic);
         Tweener.registerTransition("easeoutelastic",easeOutElastic);
         Tweener.registerTransition("easeinoutelastic",easeInOutElastic);
         Tweener.registerTransition("easeoutinelastic",easeOutInElastic);
         Tweener.registerTransition("easeinback",easeInBack);
         Tweener.registerTransition("easeoutback",easeOutBack);
         Tweener.registerTransition("easeinoutback",easeInOutBack);
         Tweener.registerTransition("easeoutinback",easeOutInBack);
         Tweener.registerTransition("easeinbounce",easeInBounce);
         Tweener.registerTransition("easeoutbounce",easeOutBounce);
         Tweener.registerTransition("easeinoutbounce",easeInOutBounce);
         Tweener.registerTransition("easeoutinbounce",easeOutInBounce);
      }
      
      public static function easeOutExpo(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         return t == d ? b + c : c * 1.001 * (-Math.pow(2,-10 * t / d) + 1) + b;
      }
      
      public static function easeOutInBack(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         if(t < d / 2)
         {
            return easeOutBack(t * 2,b,c / 2,d,p_params);
         }
         return easeInBack(t * 2 - d,b + c / 2,c / 2,d,p_params);
      }
      
      public static function easeInExpo(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         return t == 0 ? b : c * Math.pow(2,10 * (t / d - 1)) + b - c * 0.001;
      }
      
      public static function easeInCubic(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         return c * (t = t / d) * t * t + b;
      }
      
      public static function easeInQuint(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         return c * (t = t / d) * t * t * t * t + b;
      }
      
      public static function easeInOutCirc(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         t = t / (d / 2);
         if(t < 1)
         {
            return -c / 2 * (Math.sqrt(1 - t * t) - 1) + b;
         }
         return c / 2 * (Math.sqrt(1 - (t = t - 2) * t) + 1) + b;
      }
      
      public static function easeInQuad(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         return c * (t = t / d) * t + b;
      }
      
      public static function easeInBounce(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         return c - easeOutBounce(d - t,0,c,d) + b;
      }
      
      public static function easeOutInExpo(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         if(t < d / 2)
         {
            return easeOutExpo(t * 2,b,c / 2,d,p_params);
         }
         return easeInExpo(t * 2 - d,b + c / 2,c / 2,d,p_params);
      }
      
      public static function easeOutQuart(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         return -c * ((t = t / d - 1) * t * t * t - 1) + b;
      }
      
      public static function easeInSine(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         return -c * Math.cos(t / d * (Math.PI / 2)) + c + b;
      }
      
      public static function easeInOutQuart(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         t = t / (d / 2);
         if(t < 1)
         {
            return c / 2 * t * t * t * t + b;
         }
         return -c / 2 * ((t = t - 2) * t * t * t - 2) + b;
      }
      
      public static function easeOutQuad(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         return -c * (t = t / d) * (t - 2) + b;
      }
      
      public static function easeOutInElastic(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         if(t < d / 2)
         {
            return easeOutElastic(t * 2,b,c / 2,d,p_params);
         }
         return easeInElastic(t * 2 - d,b + c / 2,c / 2,d,p_params);
      }
      
      public static function easeInElastic(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         var s:Number = NaN;
         if(t == 0)
         {
            return b;
         }
         t = t / d;
         if(t == 1)
         {
            return b + c;
         }
         var p:Number = !Boolean(p_params) || isNaN(p_params.period) ? d * 0.3 : Number(p_params.period);
         var a:Number = !Boolean(p_params) || isNaN(p_params.amplitude) ? 0 : Number(p_params.amplitude);
         if(!Boolean(a) || a < Math.abs(c))
         {
            a = c;
            s = p / 4;
         }
         else
         {
            s = p / (2 * Math.PI) * Math.asin(c / a);
         }
         return -(a * Math.pow(2,10 * (t = t - 1)) * Math.sin((t * d - s) * (2 * Math.PI) / p)) + b;
      }
      
      public static function easeOutCubic(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         return c * ((t = t / d - 1) * t * t + 1) + b;
      }
      
      public static function easeOutQuint(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         return c * ((t = t / d - 1) * t * t * t * t + 1) + b;
      }
      
      public static function easeOutInQuad(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         if(t < d / 2)
         {
            return easeOutQuad(t * 2,b,c / 2,d,p_params);
         }
         return easeInQuad(t * 2 - d,b + c / 2,c / 2,d,p_params);
      }
      
      public static function easeOutSine(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         return c * Math.sin(t / d * (Math.PI / 2)) + b;
      }
      
      public static function easeInOutCubic(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         t = t / (d / 2);
         if(t < 1)
         {
            return c / 2 * t * t * t + b;
         }
         return c / 2 * ((t = t - 2) * t * t + 2) + b;
      }
      
      public static function easeInOutQuint(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         t = t / (d / 2);
         if(t < 1)
         {
            return c / 2 * t * t * t * t * t + b;
         }
         return c / 2 * ((t = t - 2) * t * t * t * t + 2) + b;
      }
      
      public static function easeInCirc(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         return -c * (Math.sqrt(1 - (t = t / d) * t) - 1) + b;
      }
      
      public static function easeOutInSine(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         if(t < d / 2)
         {
            return easeOutSine(t * 2,b,c / 2,d,p_params);
         }
         return easeInSine(t * 2 - d,b + c / 2,c / 2,d,p_params);
      }
      
      public static function easeInOutExpo(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         if(t == 0)
         {
            return b;
         }
         if(t == d)
         {
            return b + c;
         }
         t = t / (d / 2);
         if(t < 1)
         {
            return c / 2 * Math.pow(2,10 * (t - 1)) + b - c * 0.0005;
         }
         return c / 2 * 1.0005 * (-Math.pow(2,-10 * --t) + 2) + b;
      }
      
      public static function easeOutElastic(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         var s:Number = NaN;
         if(t == 0)
         {
            return b;
         }
         t = t / d;
         if(t == 1)
         {
            return b + c;
         }
         var p:Number = !Boolean(p_params) || isNaN(p_params.period) ? d * 0.3 : Number(p_params.period);
         var a:Number = !Boolean(p_params) || isNaN(p_params.amplitude) ? 0 : Number(p_params.amplitude);
         if(!Boolean(a) || a < Math.abs(c))
         {
            a = c;
            s = p / 4;
         }
         else
         {
            s = p / (2 * Math.PI) * Math.asin(c / a);
         }
         return a * Math.pow(2,-10 * t) * Math.sin((t * d - s) * (2 * Math.PI) / p) + c + b;
      }
      
      public static function easeOutCirc(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         return c * Math.sqrt(1 - (t = t / d - 1) * t) + b;
      }
      
      public static function easeOutInQuart(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         if(t < d / 2)
         {
            return easeOutQuart(t * 2,b,c / 2,d,p_params);
         }
         return easeInQuart(t * 2 - d,b + c / 2,c / 2,d,p_params);
      }
      
      public static function easeOutInCirc(t:Number, b:Number, c:Number, d:Number, p_params:Object = null) : Number
      {
         if(t < d / 2)
         {
            return easeOutCirc(t * 2,b,c / 2,d,p_params);
         }
         return easeInCirc(t * 2 - d,b + c / 2,c / 2,d,p_params);
      }
   }
}

