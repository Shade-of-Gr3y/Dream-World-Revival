package
{
   import hivelocity.flight.utility.mainBtn;
   
   public dynamic class topbtn_toGame extends mainBtn
   {
       
      
      public function topbtn_toGame()
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
