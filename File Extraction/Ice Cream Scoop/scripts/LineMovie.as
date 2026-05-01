package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol438")]
   public dynamic class LineMovie extends MovieClip
   {
      
      public var figAnmMc:MovieClip;
      
      public var clearlineMc:MovieClip;
      
      public var lineMc:MovieClip;
      
      public function LineMovie()
      {
         super();
         addFrameScript(0,this.frame1,29,this.frame30,37,this.frame38);
      }
      
      internal function frame30() : *
      {
         this.figAnmMc.alpha = 1;
         this.figAnmMc.gotoAndPlay(1);
      }
      
      internal function frame1() : *
      {
         this.figAnmMc.alpha = 0;
         this.figAnmMc.stop();
         stop();
      }
      
      internal function frame38() : *
      {
         stop();
      }
   }
}

