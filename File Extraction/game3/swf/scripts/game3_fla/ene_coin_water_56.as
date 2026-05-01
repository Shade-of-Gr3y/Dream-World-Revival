package game3_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol702")]
   public dynamic class ene_coin_water_56 extends MovieClip
   {
      
      public function ene_coin_water_56()
      {
         super();
         addFrameScript(0,this.frame1,12,this.frame13);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame13() : *
      {
         gotoAndPlay("rot");
      }
   }
}

