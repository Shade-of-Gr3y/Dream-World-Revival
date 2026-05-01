package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol438")]
   public dynamic class charaSpeedAnime extends MovieClip
   {
      
      public function charaSpeedAnime()
      {
         super();
         addFrameScript(0,this.frame1,32,this.frame33,94,this.frame95);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame33() : *
      {
         gotoAndPlay("step1");
      }
      
      internal function frame95() : *
      {
         gotoAndPlay("step2");
      }
   }
}

