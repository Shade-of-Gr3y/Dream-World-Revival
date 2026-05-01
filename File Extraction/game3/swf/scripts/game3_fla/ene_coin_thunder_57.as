package game3_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol704")]
   public dynamic class ene_coin_thunder_57 extends MovieClip
   {
      
      public function ene_coin_thunder_57()
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

