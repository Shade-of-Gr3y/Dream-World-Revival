package
{
   import hivelocity.flight.utility.mainBtn;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol498")]
   public dynamic class topbtn_toHelp extends mainBtn
   {
      
      public function topbtn_toHelp()
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

