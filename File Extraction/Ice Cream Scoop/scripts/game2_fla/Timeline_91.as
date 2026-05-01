package game2_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol304")]
   public dynamic class Timeline_91 extends MovieClip
   {
      
      public var exitMes:MovieClip;
      
      public function Timeline_91()
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

