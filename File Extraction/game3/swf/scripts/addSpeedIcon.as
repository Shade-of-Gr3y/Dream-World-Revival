package
{
   import as3.hivelocity.flight.events.flightEvent;
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol381")]
   public dynamic class addSpeedIcon extends MovieClip
   {
      
      public function addSpeedIcon()
      {
         super();
         addFrameScript(0,this.frame1,24,this.frame25);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame25() : *
      {
         gotoAndStop(1);
         dispatchEvent(new flightEvent(flightEvent.ADD_SPEED_REMOVE));
      }
   }
}

