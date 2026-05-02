package bfp.pdw.farm.objects
{
   import bfp.common.FukidashiAnimator;
   import caurina.transitions.Tweener;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   
   public class FarmFukidashiAnimator extends FukidashiAnimator
   {
      
      public static const POSITION_TYPE_SIDE:String = "side";
      
      public function FarmFukidashiAnimator(param1:DisplayObject, param2:Number = 0, param3:Number = 0)
      {
         super(param1,param2,param3);
         param1.blendMode = BlendMode.LAYER;
      }
      
      override public function show(param1:* = "top") : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         switch(param1)
         {
            case POSITION_TYPE_TOP:
               _loc3_ = -16;
               _targetObject.visible = true;
               Tweener.removeTweens(_targetObject,"y");
               _targetObject.x = _defaultX;
               _targetObject.y = _defaultY;
               Tweener.addTween(_targetObject,{
                  "delay":0,
                  "time":0.1,
                  "transition":"easeOutQuad",
                  "y":_defaultY + _loc3_
               });
               Tweener.addTween(_targetObject,{
                  "delay":0.1,
                  "time":0.2,
                  "transition":"easeInQuad",
                  "y":_defaultY,
                  "onComplete":showFinish
               });
               break;
            case POSITION_TYPE_BOTTOM:
               _loc3_ = 16;
               Tweener.removeTweens(_targetObject,"y");
               _targetObject.visible = true;
               _targetObject.x = _defaultX;
               _targetObject.y = _defaultY;
               Tweener.addTween(_targetObject,{
                  "delay":0,
                  "time":0.1,
                  "transition":"easeOutQuad",
                  "y":_defaultY + _loc3_
               });
               Tweener.addTween(_targetObject,{
                  "delay":0.1,
                  "time":0.2,
                  "transition":"easeInQuad",
                  "y":_defaultY,
                  "onComplete":showFinish
               });
               break;
            case POSITION_TYPE_SIDE:
               Tweener.removeTweens(_targetObject,"y","alpha","x");
               _targetObject.visible = true;
               _targetObject.alpha = 0;
               _targetObject.x = _defaultX;
               _targetObject.y = _defaultY;
               Tweener.addTween(_targetObject,{
                  "delay":0,
                  "time":0.1,
                  "transition":"linear",
                  "alpha":1,
                  "onComplete":showFinish
               });
         }
      }
   }
}

