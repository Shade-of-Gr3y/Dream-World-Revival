package core.effect
{
   import caurina.transitions.Tweener;
   import caurina.transitions.properties.ColorShortcuts;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public class MaskEffectManager
   {
      
      public function MaskEffectManager()
      {
         super();
      }
      
      public static function MaskOutImage(param1:*, param2:Object = null) : void
      {
         var i:* = undefined;
         var w:Number = NaN;
         var h:Number = NaN;
         var child:MovieClip = null;
         var mom:MovieClip = null;
         var target:* = param1;
         var obj:Object = param2;
         var sec:Number = 1;
         var dt:Number = 0;
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
         }
         w = Math.floor(target.width);
         h = Math.floor(target.height);
         child = new MovieClip();
         child.x = target.x;
         child.y = target.y;
         child.graphics.beginFill(0,0);
         child.graphics.moveTo(w,h);
         child.graphics.lineTo(0,h);
         child.graphics.lineTo(0,h * child.cnt3);
         child.graphics.lineTo(w * child.cnt1,h * child.cnt2);
         child.graphics.lineTo(w,h * child.cnt2);
         child.graphics.lineTo(w,h);
         child.graphics.endFill();
         child.mouseEnabled = false;
         target.mask = null;
         target.mask = child;
         target.visible = true;
         mom = MovieClip(target.parent);
         mom.addChild(child);
         mom.mouseEnabled = false;
         child.cnt1 = 0;
         child.cnt2 = 0;
         child.cnt3 = 0;
         Tweener.addTween(child,{
            "cnt1":1,
            "time":sec / 2,
            "delay":dt,
            "transition":"easeInSine"
         });
         Tweener.addTween(child,{
            "cnt2":1,
            "time":sec / 2,
            "delay":dt + sec / 2,
            "transition":"easeOutSine"
         });
         Tweener.addTween(child,{
            "cnt3":1,
            "time":sec,
            "delay":dt,
            "transition":"easeInOutCubic",
            "onComplete":function():*
            {
               if(target.mask == child)
               {
                  target.mask = null;
               }
               mom.removeChild(child);
               target.visible = false;
            }
         });
         child.addEventListener(Event.ENTER_FRAME,function enterFrameHandler():*
         {
            child.graphics.clear();
            child.graphics.beginFill(0,0);
            child.graphics.moveTo(w,h);
            child.graphics.lineTo(0,h);
            child.graphics.lineTo(0,h * child.cnt3);
            child.graphics.lineTo(w * child.cnt1,h * child.cnt2);
            child.graphics.lineTo(w,h * child.cnt2);
            child.graphics.lineTo(w,h);
            child.graphics.endFill();
            if(child.cnt3 == 1)
            {
               child.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
               child = null;
            }
         });
      }
      
      public static function MaskIn(param1:*, param2:Object = null) : void
      {
         var easing:String;
         var dt:Number;
         var sec:Number;
         var i:* = undefined;
         var rect:Rectangle = null;
         var child:MovieClip = null;
         var mom:MovieClip = null;
         var target:* = param1;
         var obj:Object = param2;
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
      
      public static function MaskInImage(param1:*, param2:Object = null) : void
      {
         var dt:Number;
         var sec:Number;
         var i:* = undefined;
         var rect:Rectangle = null;
         var child:MovieClip = null;
         var mom:MovieClip = null;
         var w:Number = NaN;
         var h:Number = NaN;
         var target:* = param1;
         var obj:Object = param2;
         ColorShortcuts.init();
         sec = 1;
         dt = 0;
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
         }
         rect = target.getRect(target);
         child = new MovieClip();
         child.x = target.x;
         child.y = target.y;
         child.mouseEnabled = false;
         target.mask = null;
         target.mask = child;
         target.visible = true;
         mom = MovieClip(target.parent);
         w = Math.floor(target.width);
         h = Math.floor(target.height);
         mom.addChild(child);
         mom.mouseEnabled = false;
         child.cnt1 = 0;
         child.cnt2 = 0;
         child.cnt3 = 0;
         Tweener.addTween(child,{
            "cnt1":1,
            "time":sec / 2,
            "delay":dt,
            "transition":"easeInSine"
         });
         Tweener.addTween(child,{
            "cnt2":1,
            "time":sec / 2,
            "delay":dt + sec / 2,
            "transition":"easeOutSine"
         });
         Tweener.addTween(child,{
            "cnt3":1,
            "time":sec,
            "delay":dt,
            "transition":"easeInOutCubic",
            "onComplete":function():*
            {
               if(target.mask == child)
               {
                  target.mask = null;
               }
               mom.removeChild(child);
            }
         });
         child.addEventListener(Event.ENTER_FRAME,function enterFrameHandler():*
         {
            child.graphics.clear();
            child.graphics.beginFill(0,0);
            child.graphics.moveTo(0,0);
            child.graphics.lineTo(w * child.cnt1,0);
            child.graphics.lineTo(w * child.cnt1,h * child.cnt2);
            child.graphics.lineTo(0,h * child.cnt3);
            child.graphics.lineTo(0,0);
            child.graphics.endFill();
            if(child.cnt3 == 1)
            {
               child.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
               child = null;
            }
         });
      }
      
      public static function MaskSlideIn(param1:*, param2:Object = null) : void
      {
         var easing:String;
         var dt:Number;
         var sec:Number;
         var dx:Number;
         var i:* = undefined;
         var rect:Rectangle = null;
         var child:MovieClip = null;
         var mom:MovieClip = null;
         var target:* = param1;
         var obj:Object = param2;
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
      
      public static function MaskOut(param1:*, param2:Object = null) : void
      {
         var i:* = undefined;
         var rect:Rectangle = null;
         var child:MovieClip = null;
         var mom:MovieClip = null;
         var target:* = param1;
         var obj:Object = param2;
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

