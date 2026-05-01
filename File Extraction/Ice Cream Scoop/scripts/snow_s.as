package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol410")]
   public dynamic class snow_s extends MovieClip
   {
      
      public function snow_s()
      {
         super();
         addFrameScript(24,this.frame25);
      }
      
      internal function frame25() : *
      {
         parent.removeChild(this);
         stop();
      }
   }
}

