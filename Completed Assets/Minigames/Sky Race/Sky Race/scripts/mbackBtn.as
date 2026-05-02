package
{
   import hivelocity.flight.utility.mainBtn;
   
   public dynamic class mbackBtn extends mainBtn
   {
       
      
      public function mbackBtn()
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
