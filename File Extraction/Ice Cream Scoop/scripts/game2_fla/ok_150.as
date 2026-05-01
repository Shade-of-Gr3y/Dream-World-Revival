package game2_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol399")]
   public dynamic class ok_150 extends MovieClip
   {
      
      public var okbtnfont_MC:MovieClip;
      
      public function ok_150()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         stop();
      }
   }
}

