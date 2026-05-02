package core.effect
{
   import caurina.transitions.Tweener;
   import caurina.transitions.properties.ColorShortcuts;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   
   public class MaskEffectManager
   {
      
      public function MaskEffectManager()
      {
         super();
      }
      
      public static function MaskOutImage(target:*, obj:Object = null) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Deobfuscate code" option in Settings
          * Error type: ClassCastException (class com.jpexs.decompiler.graph.model.CommaExpressionItem cannot be cast to class com.jpexs.decompiler.flash.abc.avm2.model.NewFunctionAVM2Item (com.jpexs.decompiler.graph.model.CommaExpressionItem and com.jpexs.decompiler.flash.abc.avm2.model.NewFunctionAVM2Item are in unnamed module of loader 'app'))
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public static function MaskIn(target:*, obj:Object = null) : void
      {
         var easing:String;
         var dt:Number;
         var sec:Number;
         var i:* = undefined;
         var rect:Rectangle = null;
         var child:MovieClip = null;
         var mom:MovieClip = null;
         ColorShortcuts.init();
         sec = 1;
         dt = 0;
         easing = "easeOutSine";
         for(i in obj)
         {
            if(i == "time")
            {
               sec = Number(obj[i]);
            }
            else if(i == "delay")
            {
               dt = Number(obj[i]);
            }
            else if(i == "transition")
            {
               easing = String(obj[i]);
            }
         }
         rect = target.getRect(target);
         child = new MovieClip();
         child.graphics.beginFill(0,0);
         child.graphics.drawRect(0,0,rect.width,rect.height);
         child.graphics.endFill();
         child.mouseEnabled = false;
         child.x = target.x;
         child.y = target.y;
         child.scaleX = 0;
         target.mask = null;
         target.mask = child;
         target.visible = true;
         mom = MovieClip(target.parent);
         mom.addChild(child);
         mom.mouseEnabled = false;
         Tweener.addTween(child,{
            "scaleX":1,
            "time":sec,
            "delay":dt,
            "transition":easing,
            "onComplete":function():*
            {
               if(target.mask == child)
               {
                  target.mask = null;
               }
               mom.removeChild(child);
               child = null;
            }
         });
      }
      
      public static function MaskInImage(target:*, obj:Object = null) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Deobfuscate code" option in Settings
          * Error type: ClassCastException (class com.jpexs.decompiler.graph.model.CommaExpressionItem cannot be cast to class com.jpexs.decompiler.flash.abc.avm2.model.NewFunctionAVM2Item (com.jpexs.decompiler.graph.model.CommaExpressionItem and com.jpexs.decompiler.flash.abc.avm2.model.NewFunctionAVM2Item are in unnamed module of loader 'app'))
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public static function MaskSlideIn(target:*, obj:Object = null) : void
      {
         var easing:String;
         var dt:Number;
         var sec:Number;
         var dx:Number;
         var i:* = undefined;
         var rect:Rectangle = null;
         var child:MovieClip = null;
         var mom:MovieClip = null;
         ColorShortcuts.init();
         sec = 1;
         dt = 0;
         dx = Number(target.width);
         easing = "easeOutSine";
         for(i in obj)
         {
            if(i == "time")
            {
               sec = Number(obj[i]);
            }
            else if(i == "delay")
            {
               dt = Number(obj[i]);
            }
            else if(i == "transition")
            {
               easing = String(obj[i]);
            }
            else if(i == "dx")
            {
               dx = Number(obj[i]);
            }
         }
         rect = target.getRect(target);
         child = new MovieClip();
         child.graphics.beginFill(0,0);
         child.graphics.drawRect(0,0,rect.width,rect.height);
         child.graphics.endFill();
         child.x = target.x;
         child.y = target.y;
         child.mouseEnabled = false;
         target.mask = null;
         target.mask = child;
         mom = MovieClip(target.parent);
         mom.addChild(child);
         mom.mouseEnabled = false;
         target.x += dx;
         Tweener.addTween(target,{
            "visible":true,
            "time":0,
            "delay":dt,
            "transition":easing
         });
         Tweener.addTween(target,{
            "x":child.x,
            "time":sec,
            "delay":dt,
            "transition":easing,
            "onComplete":function():*
            {
               if(target.mask == child)
               {
                  target.mask = null;
               }
               mom.removeChild(child);
               child = null;
            }
         });
      }
      
      public static function MaskOut(target:*, obj:Object = null) : void
      {
         var i:* = undefined;
         var rect:Rectangle = null;
         var child:MovieClip = null;
         var mom:MovieClip = null;
         var sec:Number = 1;
         var dt:Number = 0;
         var easing:String = "easeOutSine";
         for(i in obj)
         {
            if(i == "time")
            {
               sec = Number(obj[i]);
            }
            else if(i == "delay")
            {
               dt = Number(obj[i]);
            }
            else if(i == "transition")
            {
               easing = String(obj[i]);
            }
         }
         rect = target.getRect(target);
         child = new MovieClip();
         child.graphics.beginFill(0,0);
         child.graphics.drawRect(0,0,rect.width,rect.height);
         child.graphics.endFill();
         child.x = target.x;
         child.y = target.y;
         child.mouseEnabled = false;
         target.mask = null;
         target.mask = child;
         target.visible = true;
         mom = MovieClip(target.parent);
         mom.addChild(child);
         mom.mouseEnabled = false;
         Tweener.addTween(child,{
            "x":target.width + target.x,
            "time":sec,
            "delay":dt,
            "transition":easing,
            "onComplete":function():*
            {
               if(target.mask == child)
               {
                  target.mask = null;
               }
               mom.removeChild(child);
               child = null;
               target.visible = false;
            }
         });
      }
   }
}

