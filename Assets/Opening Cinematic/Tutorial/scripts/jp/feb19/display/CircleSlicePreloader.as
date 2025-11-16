package jp.feb19.display
{
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class CircleSlicePreloader extends Sprite
   {
      
      private static const SLICE_COUNT:int = 12;
      
      private static const RADIUS:int = 6;
       
      
      private var timer:Timer;
      
      public function CircleSlicePreloader()
      {
         this.timer = new Timer(65);
         super();
         this.draw();
         this.timer.addEventListener(TimerEvent.TIMER,this.timerHandler);
         this.timer.start();
      }
      
      public function destroy() : void
      {
         this.timer.removeEventListener(TimerEvent.TIMER,this.timerHandler);
         this.timer.stop();
      }
      
      private function timerHandler(param1:TimerEvent) : void
      {
         rotation = (rotation + 360 / SLICE_COUNT) % 360;
      }
      
      private function draw() : void
      {
         var _loc3_:Shape = null;
         var _loc4_:Number = NaN;
         var _loc1_:int = SLICE_COUNT;
         var _loc2_:int = 360 / SLICE_COUNT;
         while(_loc1_--)
         {
            _loc3_ = this.getSlice();
            _loc3_.alpha = Math.max(0.2,1 - 0.1 * _loc1_);
            _loc4_ = _loc2_ * _loc1_ * Math.PI / 180;
            _loc3_.rotation = -_loc2_ * _loc1_;
            _loc3_.x = Math.sin(_loc4_) * RADIUS;
            _loc3_.y = Math.cos(_loc4_) * RADIUS;
            addChild(_loc3_);
         }
      }
      
      private function getSlice() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(6710886);
         _loc1_.graphics.drawRoundRect(-1,0,2,6,12,12);
         _loc1_.graphics.endFill();
         return _loc1_;
      }
   }
}
