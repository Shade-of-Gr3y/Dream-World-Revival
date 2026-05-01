package
{
   import as3.hivelocity.flight.events.flightEvent;
   import flash.display.MovieClip;
   import hivelocity.flight.sound.soundController;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol344")]
   public dynamic class hitThunder extends MovieClip
   {
      
      public var se:soundController;
      
      public function hitThunder()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,34,this.frame35);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         this.se = new soundController();
         this.se.playSound("elec");
      }
      
      internal function frame35() : *
      {
         stop();
         dispatchEvent(new flightEvent(flightEvent.ADD_THUNDER_REMOVE));
      }
   }
}

