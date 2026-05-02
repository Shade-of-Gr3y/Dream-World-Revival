package game3_fla
{
   import flash.display.MovieClip;
   
   public dynamic class help_inside_mc_170 extends MovieClip
   {
       
      
      public var btn_next:MovieClip;
      
      public var btn_previous:MovieClip;
      
      public var help_1:MovieClip;
      
      public var help_2:MovieClip;
      
      public function help_inside_mc_170()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         stop();
         MovieClip(root).moveLangFrame(this["help_1"]);
         MovieClip(root).moveLangFrame(this["help_2"]);
      }
   }
}
