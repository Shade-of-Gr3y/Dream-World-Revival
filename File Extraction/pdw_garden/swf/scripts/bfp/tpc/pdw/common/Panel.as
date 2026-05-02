package bfp.tpc.pdw.common
{
   import caurina.transitions.Tweener;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class Panel extends Sprite
   {
      
      public function Panel()
      {
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      private function addedToStageHandler(event:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
         this.init();
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
      }
      
      private function removedFromStageHandler(event:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
         this.release();
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      public function init() : void
      {
      }
      
      public function release() : void
      {
      }
      
      public function visit(p:Point, rect:Rectangle) : void
      {
         Tweener.removeTweens(this);
         this.visible = true;
         this.x = p.x + 40;
         this.y = p.y;
         this.alpha = 0;
         Tweener.addTween(this,{
            "time":0.3,
            "alpha":1,
            "transition":"easeNone"
         });
         Tweener.addTween(this,{
            "time":0.3,
            "x":p.x,
            "transition":"easeOutQuint"
         });
      }
      
      public function away() : void
      {
         Tweener.addTween(this,{
            "time":0.3,
            "alpha":0,
            "transition":"easeNone"
         });
         Tweener.addTween(this,{
            "time":0.3,
            "x":this.x + 40,
            "transition":"easeInQuint",
            "onComplete":function():void
            {
               this.parent.removeChild(this);
            }
         });
      }
      
      public function mouseOverHandler(event:MouseEvent) : void
      {
         var target:MovieClip = MovieClip(event.currentTarget);
      }
      
      public function mouseOutHandler(event:MouseEvent) : void
      {
         var target:MovieClip = MovieClip(event.currentTarget);
      }
      
      public function clickHandler(event:MouseEvent) : void
      {
      }
   }
}

