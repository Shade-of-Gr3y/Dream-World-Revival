package jp.feb19.transitions
{
   import flash.display.Shape;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class Tweening
   {
      
      private static var _tweenEngine:Shape;
      
      private static var _tweenlist:Array = [];
      
      private static var _currentTime:int = 0;
      
      private static var _isTweening:Boolean = false;
       
      
      public function Tweening()
      {
         super();
      }
      
      public static function add(param1:Object, param2:Object) : void
      {
         var _loc7_:Number = NaN;
         if(!_tweenEngine)
         {
            _tweenEngine = new Shape();
         }
         if(!_currentTime || _currentTime == 0)
         {
            _currentTime = getTimer();
         }
         var _loc3_:Object = {
            "time":true,
            "delay":true,
            "easing":true,
            "easingParams":true,
            "onComplete":true,
            "onCompleteParams":true,
            "onUpdate":true,
            "onUpdateParams":true,
            "onStart":true,
            "onStartParams":true
         };
         var _loc4_:TweeningObject;
         (_loc4_ = new TweeningObject()).target = param1;
         var _loc5_:Object = new Object();
         var _loc6_:String = "";
         for(_loc6_ in param2)
         {
            if(!_loc3_[_loc6_])
            {
               _loc5_[_loc6_] = new Object();
               _loc5_[_loc6_].valueComplete = param2[_loc6_];
            }
         }
         _loc4_.properties = _loc5_;
         _loc7_ = isNaN(param2.time) ? 0 : Number(param2.time);
         var _loc8_:Number = isNaN(param2.delay) ? 0 : Number(param2.delay);
         var _loc9_:String = !param2.easing ? "easeNone" : String(param2.easing);
         _loc4_.start = _currentTime + _loc8_ * 1000;
         _loc4_.end = _currentTime + _loc8_ * 1000 + _loc7_ * 1000;
         _loc4_.easing = TweeningEasing.getEasingFunction(_loc9_);
         _loc4_.easingParams = param2.easingParams;
         _loc4_.onComplete = param2.onComplete;
         _loc4_.onCompleteParams = param2.onCompleteParams;
         _loc4_.onUpdate = param2.onUpdate;
         _loc4_.onUpdateParams = param2.onUpdateParams;
         _loc4_.onStart = param2.onStart;
         _loc4_.onStartParams = param2.onStartParams;
         _loc4_.hasStarted = false;
         _tweenlist.push(_loc4_);
         if(!_isTweening)
         {
            _tweenEngine.addEventListener(Event.ENTER_FRAME,enterFrameHandler);
            _isTweening = true;
         }
      }
      
      public static function update() : Boolean
      {
         var _loc3_:TweeningObject = null;
         var _loc12_:Object = null;
         var _loc13_:String = null;
         var _loc14_:Object = null;
         var _loc17_:Number = NaN;
         var _loc1_:int = 0;
         var _loc2_:int = int(_tweenlist.length);
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
         var _loc8_:Number = 0;
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc11_:int = _currentTime;
         var _loc15_:Array = _tweenlist;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc9_ = false;
            if(_loc15_[_loc1_])
            {
               _loc3_ = _loc15_[_loc1_];
               _loc12_ = _loc3_.target;
               if(_loc11_ >= _loc3_.start)
               {
                  _loc10_ = _loc3_.skipUpdates < 1 || !_loc3_.skipUpdates || _loc3_.updatesSkipped >= _loc3_.skipUpdates;
                  if(_loc11_ >= _loc3_.end)
                  {
                     _loc9_ = true;
                     _loc10_ = true;
                  }
                  if(!_loc3_.hasStarted)
                  {
                     if(Boolean(_loc3_.onStart))
                     {
                        _loc3_.onStart.apply(_loc12_,_loc3_.onStartParams);
                     }
                     _loc17_ = 0;
                     for(_loc13_ in _loc3_.properties)
                     {
                        _loc17_ = Number(_loc12_[_loc13_]);
                        _loc3_.properties[_loc13_].valueStart = isNaN(_loc17_) ? _loc3_.properties[_loc17_].valueComplete : _loc17_;
                     }
                     _loc10_ = true;
                     _loc3_.hasStarted = true;
                  }
                  if(_loc10_)
                  {
                     for(_loc13_ in _loc3_.properties)
                     {
                        _loc14_ = _loc3_.properties[_loc13_];
                        if(_loc9_)
                        {
                           _loc8_ = Number(_loc14_.valueComplete);
                        }
                        else
                        {
                           _loc4_ = _loc11_ - _loc3_.start;
                           _loc5_ = Number(_loc14_.valueStart);
                           _loc6_ = _loc14_.valueComplete - _loc14_.valueStart;
                           _loc7_ = _loc3_.end - _loc3_.start;
                           _loc8_ = _loc3_.easing(_loc4_,_loc5_,_loc6_,_loc7_,_loc3_.easingParams);
                        }
                        _loc12_[_loc13_] = _loc8_;
                     }
                     if(Boolean(_loc3_.onUpdate))
                     {
                        _loc3_.onUpdate.apply(_loc12_,_loc3_.onUpdateParams);
                     }
                  }
               }
               if(_loc9_)
               {
                  if(Boolean(_loc3_.onComplete))
                  {
                     _loc3_.onComplete.apply(_loc12_,_loc3_.onCompleteParams);
                  }
                  _loc15_[_loc1_] = null;
               }
            }
            _loc1_++;
         }
         var _loc16_:Boolean = true;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc15_[_loc1_])
            {
               _loc16_ = false;
               break;
            }
            _loc1_++;
         }
         _tweenlist = _loc15_;
         if(_loc16_)
         {
            return false;
         }
         return true;
      }
      
      public static function stopEngine() : void
      {
         _tweenlist = [];
         _currentTime = 0;
         _tweenEngine.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
         _isTweening = false;
      }
      
      private static function enterFrameHandler(param1:Event) : void
      {
         _currentTime = getTimer();
         if(!update())
         {
            stopEngine();
         }
      }
   }
}
