package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol413")]
   public dynamic class exMarkMc extends MovieClip
   {
      
      public var グラグラ1:MovieClip;
      
      public function exMarkMc()
      {
         super();
         addFrameScript(10,this.frame11);
      }
      
      internal function frame11() : *
      {
         parent.removeChild(this);
         stop();
      }
   }
}

