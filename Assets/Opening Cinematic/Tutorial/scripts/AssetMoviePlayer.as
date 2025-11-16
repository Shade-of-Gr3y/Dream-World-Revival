package
{
   import bfp.tpc.pdw.movieplayer.MoviePlayer;
   
   [Embed(source="/_assets/assets.swf", symbol="AssetMoviePlayer")]
   public dynamic class AssetMoviePlayer extends MoviePlayer
   {
       
      
      public function AssetMoviePlayer()
      {
         super();
      }
   }
}
