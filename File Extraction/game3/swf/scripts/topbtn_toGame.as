package
{
   import hivelocity.flight.utility.mainBtn;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol518")]
   public dynamic class topbtn_toGame extends mainBtn
   {
      
      public function topbtn_toGame()
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

