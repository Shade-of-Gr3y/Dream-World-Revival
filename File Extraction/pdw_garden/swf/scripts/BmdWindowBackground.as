package
{
   import flash.display.BitmapData;
   
   [Embed(source="/_assets/9_BmdWindowBackground.png")]
   public dynamic class BmdWindowBackground extends BitmapData
   {
      
      public function BmdWindowBackground(w:int = 480, h:int = 300)
      {
         super(w,h);
      }
   }
}

