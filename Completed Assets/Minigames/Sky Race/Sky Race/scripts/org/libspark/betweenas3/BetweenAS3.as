package org.libspark.betweenas3
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import org.libspark.betweenas3.core.easing.IEasing;
   import org.libspark.betweenas3.core.easing.IPhysicalEasing;
   import org.libspark.betweenas3.core.ticker.ITicker;
   import org.libspark.betweenas3.core.tweens.IITween;
   import org.libspark.betweenas3.core.tweens.ObjectTween;
   import org.libspark.betweenas3.core.tweens.PhysicalTween;
   import org.libspark.betweenas3.core.tweens.TweenDecorator;
   import org.libspark.betweenas3.core.tweens.actions.AddChildAction;
   import org.libspark.betweenas3.core.tweens.actions.FunctionAction;
   import org.libspark.betweenas3.core.tweens.actions.RemoveFromParentAction;
   import org.libspark.betweenas3.core.tweens.decorators.DelayedTween;
   import org.libspark.betweenas3.core.tweens.decorators.RepeatedTween;
   import org.libspark.betweenas3.core.tweens.decorators.ReversedTween;
   import org.libspark.betweenas3.core.tweens.decorators.ScaledTween;
   import org.libspark.betweenas3.core.tweens.decorators.SlicedTween;
   import org.libspark.betweenas3.core.tweens.groups.ParallelTween;
   import org.libspark.betweenas3.core.tweens.groups.SerialTween;
   import org.libspark.betweenas3.core.updaters.ObjectUpdater;
   import org.libspark.betweenas3.core.updaters.UpdaterFactory;
   import org.libspark.betweenas3.core.updaters.display.DisplayObjectUpdater;
   import org.libspark.betweenas3.core.updaters.display.MovieClipUpdater;
   import org.libspark.betweenas3.core.updaters.geom.PointUpdater;
   import org.libspark.betweenas3.core.utils.ClassRegistry;
   import org.libspark.betweenas3.easing.Linear;
   import org.libspark.betweenas3.easing.Physical;
   import org.libspark.betweenas3.tickers.EnterFrameTicker;
   import org.libspark.betweenas3.tweens.IObjectTween;
   import org.libspark.betweenas3.tweens.ITween;
   import org.libspark.betweenas3.tweens.ITweenGroup;
   
   public class BetweenAS3
   {
      
      public static const VERSION:String = "0.2 (Alpha)";
      
      private static var _ticker:ITicker = new EnterFrameTicker();
      
      private static var _updaterClassRegistry:ClassRegistry = new ClassRegistry();
      
      private static var _updaterFactory:UpdaterFactory = new UpdaterFactory(_updaterClassRegistry);
      
      {
         _ticker.start();
         ObjectUpdater.register(_updaterClassRegistry);
         DisplayObjectUpdater.register(_updaterClassRegistry);
         MovieClipUpdater.register(_updaterClassRegistry);
         PointUpdater.register(_updaterClassRegistry);
      }
      
      public function BetweenAS3()
      {
         super();
      }
      
      public static function tween(param1:Object, param2:Object, param3:Object = null, param4:Number = 1.0, param5:IEasing = null) : IObjectTween
      {
         var _loc6_:ObjectTween = new ObjectTween(_ticker);
         _loc6_.updater = _updaterFactory.create(param1,param2,param3);
         _loc6_.time = param4;
         _loc6_.easing = param5 || Linear.easeNone;
         return _loc6_;
      }
      
      public static function to(param1:Object, param2:Object, param3:Number = 1.0, param4:IEasing = null) : IObjectTween
      {
         var _loc5_:ObjectTween = new ObjectTween(_ticker);
         _loc5_.updater = _updaterFactory.create(param1,param2,null);
         _loc5_.time = param3;
         _loc5_.easing = param4 || Linear.easeNone;
         return _loc5_;
      }
      
      public static function from(param1:Object, param2:Object, param3:Number = 1.0, param4:IEasing = null) : IObjectTween
      {
         var _loc5_:ObjectTween = new ObjectTween(_ticker);
         _loc5_.updater = _updaterFactory.create(param1,null,param2);
         _loc5_.time = param3;
         _loc5_.easing = param4 || Linear.easeNone;
         return _loc5_;
      }
      
      public static function apply(param1:Object, param2:Object, param3:Object = null, param4:Number = 1.0, param5:Number = 1.0, param6:IEasing = null) : void
      {
         var _loc7_:ObjectTween = new ObjectTween(_ticker);
         _loc7_.updater = _updaterFactory.create(param1,param2,param3);
         _loc7_.time = param4;
         _loc7_.easing = param6 || Linear.easeNone;
         _loc7_.update(param5);
      }
      
      public static function bezier(param1:Object, param2:Object, param3:Object = null, param4:Object = null, param5:Number = 1.0, param6:IEasing = null) : IObjectTween
      {
         var _loc7_:ObjectTween = new ObjectTween(_ticker);
         _loc7_.updater = _updaterFactory.createBezier(param1,param2,param3,param4);
         _loc7_.time = param5;
         _loc7_.easing = param6 || Linear.easeNone;
         return _loc7_;
      }
      
      public static function bezierTo(param1:Object, param2:Object, param3:Object = null, param4:Number = 1.0, param5:IEasing = null) : IObjectTween
      {
         var _loc6_:ObjectTween = new ObjectTween(_ticker);
         _loc6_.updater = _updaterFactory.createBezier(param1,param2,null,param3);
         _loc6_.time = param4;
         _loc6_.easing = param5 || Linear.easeNone;
         return _loc6_;
      }
      
      public static function bezierFrom(param1:Object, param2:Object, param3:Object = null, param4:Number = 1.0, param5:IEasing = null) : IObjectTween
      {
         var _loc6_:ObjectTween = new ObjectTween(_ticker);
         _loc6_.updater = _updaterFactory.createBezier(param1,null,param2,param3);
         _loc6_.time = param4;
         _loc6_.easing = param5 || Linear.easeNone;
         return _loc6_;
      }
      
      public static function physical(param1:Object, param2:Object, param3:Object = null, param4:IPhysicalEasing = null) : IObjectTween
      {
         var _loc5_:PhysicalTween = new PhysicalTween(_ticker);
         _loc5_.updater = _updaterFactory.createPhysical(param1,param2,param3,param4 || Physical.exponential());
         return _loc5_;
      }
      
      public static function physicalTo(param1:Object, param2:Object, param3:IPhysicalEasing = null) : IObjectTween
      {
         var _loc4_:PhysicalTween = new PhysicalTween(_ticker);
         _loc4_.updater = _updaterFactory.createPhysical(param1,param2,null,param3 || Physical.exponential());
         return _loc4_;
      }
      
      public static function physicalFrom(param1:Object, param2:Object, param3:IPhysicalEasing = null) : IObjectTween
      {
         var _loc4_:PhysicalTween = new PhysicalTween(_ticker);
         _loc4_.updater = _updaterFactory.createPhysical(param1,null,param2,param3 || Physical.exponential());
         return _loc4_;
      }
      
      public static function physicalApply(param1:Object, param2:Object, param3:Object = null, param4:Number = 1.0, param5:IPhysicalEasing = null) : void
      {
         var _loc6_:PhysicalTween = new PhysicalTween(_ticker);
         _loc6_.updater = _updaterFactory.createPhysical(param1,param2,param3,param5 || Physical.exponential());
         _loc6_.update(param4);
      }
      
      public static function parallel(... rest) : ITweenGroup
      {
         return parallelTweens(rest);
      }
      
      public static function parallelTweens(param1:Array) : ITweenGroup
      {
         return new ParallelTween(param1,_ticker,0);
      }
      
      public static function serial(... rest) : ITweenGroup
      {
         return serialTweens(rest);
      }
      
      public static function serialTweens(param1:Array) : ITweenGroup
      {
         return new SerialTween(param1,_ticker,0);
      }
      
      public static function reverse(param1:ITween, param2:Boolean = true) : ITween
      {
         var _loc3_:Number = !!param2?Number(param1.duration - param1.position):Number(0);
         if(param1 is ReversedTween)
         {
            return new TweenDecorator((param1 as ReversedTween).baseTween,_loc3_);
         }
         if((param1 as Object).constructor == TweenDecorator)
         {
            param1 = (param1 as TweenDecorator).baseTween;
         }
         return new ReversedTween(param1 as IITween,_loc3_);
      }
      
      public static function repeat(param1:ITween, param2:uint) : ITween
      {
         return new RepeatedTween(param1 as IITween,param2);
      }
      
      public static function scale(param1:ITween, param2:Number) : ITween
      {
         return new ScaledTween(param1 as IITween,param2);
      }
      
      public static function slice(param1:ITween, param2:Number, param3:Number, param4:Boolean = false) : ITween
      {
         if(param4)
         {
            param2 = param1.duration * param2;
            param3 = param1.duration * param3;
         }
         if(param2 > param3)
         {
            return new ReversedTween(new SlicedTween(param1 as IITween,param3,param2),0);
         }
         return new SlicedTween(param1 as IITween,param2,param3);
      }
      
      public static function delay(param1:ITween, param2:Number, param3:Number = 0.0) : ITween
      {
         return new DelayedTween(param1 as IITween,param2,param3);
      }
      
      public static function addChild(param1:DisplayObject, param2:DisplayObjectContainer) : ITween
      {
         return new AddChildAction(_ticker,param1,param2);
      }
      
      public static function removeFromParent(param1:DisplayObject) : ITween
      {
         return new RemoveFromParentAction(_ticker,param1);
      }
      
      public static function func(param1:Function, param2:Array = null, param3:Boolean = false, param4:Function = null, param5:Array = null) : ITween
      {
         return new FunctionAction(_ticker,param1,param2,param3,param4,param5);
      }
   }
}
