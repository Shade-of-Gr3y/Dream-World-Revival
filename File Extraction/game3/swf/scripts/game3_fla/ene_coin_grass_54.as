package game3_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol696")]
   public dynamic class ene_coin_grass_54 extends MovieClip
   {
      
      public function ene_coin_grass_54()
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

