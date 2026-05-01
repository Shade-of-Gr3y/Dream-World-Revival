package
{
   import hivelocity.flight.utility.mainBtn;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol818")]
   public dynamic class gameHint extends mainBtn
   {
      
      public function gameHint()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

