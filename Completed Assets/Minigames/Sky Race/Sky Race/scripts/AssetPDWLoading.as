package
{
   import bfp.tpc.pdw.loading.PDWLoading;
   import flash.display.MovieClip;
   
   public dynamic class AssetPDWLoading extends PDWLoading
   {
       
      
      public function AssetPDWLoading()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         MovieClip(root).moveLangFrame(this.loadingTxt);
      }
   }
}
