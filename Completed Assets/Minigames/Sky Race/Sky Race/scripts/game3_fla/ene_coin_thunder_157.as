package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class ene_coin_thunder_157 extends MovieClip
   {
       
      
      public function ene_coin_thunder_157()
      {
         super();
         addFrameScript(0,this.frame1,12,this.frame13);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame13() : *
      {
         gotoAndPlay("rot");
      }
   }
}
