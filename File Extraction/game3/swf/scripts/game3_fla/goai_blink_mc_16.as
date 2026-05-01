package game3_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol538")]
   public dynamic class goai_blink_mc_16 extends MovieClip
   {
      
      public function goai_blink_mc_16()
      {
         super();
         addFrameScript(0,this.frame1,72,this.frame73);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame73() : *
      {
         gotoAndStop(1);
      }
   }
}

