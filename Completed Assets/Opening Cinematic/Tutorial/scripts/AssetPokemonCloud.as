package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="AssetPokemonCloud")]
   public dynamic class AssetPokemonCloud extends MovieClip
   {
       
      
      public var cloudmc2:MovieClip;
      
      public var cloudmc0:MovieClip;
      
      public var cloudmc1:MovieClip;
      
      public function AssetPokemonCloud()
      {
         super();
         addFrameScript(30,this.frame31);
      }
      
      internal function frame31() : *
      {
         stop();
      }
   }
}
