package game2_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol404")]
   public dynamic class Timeline_146 extends MovieClip
   {
      
      public var cancelMc:MovieClip;
      
      public var mesMc:MovieClip;
      
      public var okMc:MovieClip;
      
      public function Timeline_146()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
      }
      
      internal function frame2() : *
      {
         stop();
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

