package game3_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol780")]
   public dynamic class ftr_speed_max_blink_76 extends MovieClip
   {
      
      public function ftr_speed_max_blink_76()
      {
         super();
         addFrameScript(0,this.frame1,29,this.frame30);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame30() : *
      {
         gotoAndPlay("loop");
      }
   }
}

