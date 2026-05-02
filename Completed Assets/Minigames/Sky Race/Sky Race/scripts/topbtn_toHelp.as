package
{
   import hivelocity.flight.utility.mainBtn;
   
   public dynamic class topbtn_toHelp extends mainBtn
   {
       
      
      public function topbtn_toHelp()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
