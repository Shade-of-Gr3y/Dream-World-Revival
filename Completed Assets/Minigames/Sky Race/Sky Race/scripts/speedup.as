package
{
   import as3.hivelocity.flight.events.flightEvent;
   import flash.display.MovieClip;
   import hivelocity.flight.sound.soundController;
   
   public dynamic class speedup extends MovieClip
   {
       
      
      public var se:soundController;
      
      public function speedup()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,34,this.frame35);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame2() : *
      {
         this.se = new soundController();
         this.se.playSound("speedUp");
      }
      
      function frame35() : *
      {
         stop();
         dispatchEvent(new flightEvent(flightEvent.SPEED_UP_ANIME_FIN));
      }
   }
}
