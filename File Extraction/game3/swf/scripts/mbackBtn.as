package
{
   import hivelocity.flight.utility.mainBtn;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol452")]
   public dynamic class mbackBtn extends mainBtn
   {
      
      public function mbackBtn()
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

