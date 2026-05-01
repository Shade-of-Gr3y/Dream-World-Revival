package as3.hivelocity.flight.utility
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class fpsMeasurement extends Sprite
   {
      
      private var draw_count:* = 0;
      
      private var old_timer:* = 0;
      
      private var _fps:uint = 30;
      
      public function fpsMeasurement()
      {
         super();
      }
      
      public function get getFps() : uint
      {
         var _loc1_:* = this._fps;
         if(this._fps > 30)
         {
            this._fps = 30;
         }
         return this._fps;
      }
      
      public function measurement() : void
      {
         this.old_timer = getTimer();
         stage.addEventListener(Event.ENTER_FRAME,this.fps,false,0,true);
      }
      
      public function reset() : void
      {
         try
         {
            stage.removeEventListener(Event.ENTER_FRAME,this.fps);
         }
         catch(e:*)
         {
         }
      }
      
      private function fps(param1:Event) : void
      {
         this.draw_count += 1;
         if(getTimer() - this.old_timer >= 1000)
         {
            this._fps = this.draw_count;
            this.old_timer = getTimer();
            this.draw_count = 0;
         }
      }
   }
}

