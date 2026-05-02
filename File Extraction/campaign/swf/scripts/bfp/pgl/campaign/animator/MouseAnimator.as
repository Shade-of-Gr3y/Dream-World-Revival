package bfp.pgl.campaign.animator
{
   import caurina.transitions.Tweener;
   import flash.display.MovieClip;
   
   public class MouseAnimator
   {
      
      public function MouseAnimator()
      {
         super();
      }
      
      public static function over(param1:MovieClip, param2:* = 40) : *
      {
         Tweener.addTween(param1,{
            "delay":0,
            "time":0.1,
            "transition":"linear",
            "_color_redOffset":param2,
            "_color_greenOffset":param2,
            "_color_blueOffset":param2
         });
      }
      
      public static function out(param1:MovieClip) : *
      {
         Tweener.addTween(param1,{
            "delay":0,
            "time":0.2,
            "transition":"linear",
            "_color_redOffset":0,
            "_color_greenOffset":0,
            "_color_blueOffset":0
         });
      }
      
      public static function reset(param1:MovieClip) : *
      {
         Tweener.addTween(param1,{
            "delay":0,
            "time":0,
            "transition":"linear",
            "_color_redOffset":0,
            "_color_greenOffset":0,
            "_color_blueOffset":0
         });
      }
   }
}

