package
{
   import flash.display.MovieClip;
   
   public dynamic class mapPokeMoveObj extends MovieClip
   {
       
      
      public var addBase_mc:MovieClip;
      
      public function mapPokeMoveObj()
      {
         super();
         addFrameScript(39,this.frame40);
      }
      
      function frame40() : *
      {
         gotoAndPlay("loop");
      }
   }
}
