package game3_fla
{
   import flash.display.MovieClip;
   import hivelocity.flight.sound.soundController;
   
   public dynamic class ene_coins_mc_52 extends MovieClip
   {
       
      
      public var mm:MovieClip;
      
      public var coins:MovieClip;
      
      public var se:soundController;
      
      public function ene_coins_mc_52()
      {
         super();
         addFrameScript(0,this.frame1,39,this.frame40,40,this.frame41,54,this.frame55);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame40() : *
      {
         gotoAndStop(1);
      }
      
      function frame41() : *
      {
         this.se = new soundController();
         this.se.playSound("coinIn");
      }
      
      function frame55() : *
      {
         stop();
         this.se.soundReset();
      }
   }
}
