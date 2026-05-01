package game3_fla
{
   import flash.display.MovieClip;
   import hivelocity.flight.sound.soundController;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol709")]
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
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame40() : *
      {
         gotoAndStop(1);
      }
      
      internal function frame41() : *
      {
         this.se = new soundController();
         this.se.playSound("coinIn");
      }
      
      internal function frame55() : *
      {
         stop();
         this.se.soundReset();
      }
   }
}

