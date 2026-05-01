package game3_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol745")]
   public dynamic class ftr_nokori_blink_mc_65 extends MovieClip
   {
      
      public function ftr_nokori_blink_mc_65()
      {
         super();
         addFrameScript(0,this.frame1,19,this.frame20);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame20() : *
      {
         gotoAndStop(1);
      }
   }
}

