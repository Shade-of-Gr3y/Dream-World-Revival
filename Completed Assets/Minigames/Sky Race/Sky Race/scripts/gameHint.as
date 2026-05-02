package
{
   import hivelocity.flight.utility.mainBtn;
   
   public dynamic class gameHint extends mainBtn
   {
       
      
      public function gameHint()
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
