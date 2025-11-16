package pdw_main_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="pdw_main_fla.hitarea_5")]
   public dynamic class hitarea_5 extends MovieClip
   {
       
      
      public function hitarea_5()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         this.mouseChildren = false;
         this.visible = false;
      }
   }
}
