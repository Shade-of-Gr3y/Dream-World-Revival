package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol409")]
   public dynamic class snow_l extends MovieClip
   {
      
      public function snow_l()
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

