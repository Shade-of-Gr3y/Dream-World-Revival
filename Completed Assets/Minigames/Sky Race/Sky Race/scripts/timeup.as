package
{
   import as3.hivelocity.flight.events.flightEvent;
   import flash.display.MovieClip;
   import hivelocity.flight.sound.soundController;
   
   public dynamic class timeup extends MovieClip
   {
       
      
      public var se:soundController;
      
      public function timeup()
      {
         super();
         addFrameScript(0,this.frame1,14,this.frame15,64,this.frame65);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame15() : *
      {
         this.se = new soundController();
         this.se.playSound("timeUp");
      }
      
      function frame65() : *
      {
         stop();
         dispatchEvent(new flightEvent(flightEvent.TIME_UP_ANIME_FIN));
      }
   }
}
