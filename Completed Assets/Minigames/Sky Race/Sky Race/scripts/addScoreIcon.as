package
{
   import flash.display.MovieClip;
   
   public dynamic class addScoreIcon extends hivelocity.flight.object.addScoreIcon
   {
       
      
      public function addScoreIcon()
      {
         super();
         addFrameScript(0,this.frame1,3,this.frame4,5,this.frame6,8,this.frame9);
      }
      
      function frame1() : *
      {
         stop();
         MovieClip(root).moveLangFrame(this["ptt_1"]);
      }
      
      function frame4() : *
      {
         stop();
         MovieClip(root).moveLangFrame(this["ptt_2"]);
      }
      
      function frame6() : *
      {
         stop();
         MovieClip(root).moveLangFrame(this["ptt_3"]);
      }
      
      function frame9() : *
      {
         stop();
         MovieClip(root).moveLangFrame(this["ptt_4"]);
      }
   }
}
