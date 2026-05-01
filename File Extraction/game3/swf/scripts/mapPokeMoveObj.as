package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol149")]
   public dynamic class mapPokeMoveObj extends MovieClip
   {
      
      public var addBase_mc:MovieClip;
      
      public function mapPokeMoveObj()
      {
         super();
         addFrameScript(39,this.frame40);
      }
      
      internal function frame40() : *
      {
         gotoAndPlay("loop");
      }
   }
}

