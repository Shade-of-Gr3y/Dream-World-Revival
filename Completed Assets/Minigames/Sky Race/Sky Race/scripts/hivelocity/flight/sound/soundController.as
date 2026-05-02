package hivelocity.flight.sound
{
   public class soundController
   {
      
      public static const SCENE_TOP:uint = 1;
      
      public static const SCENE_GAME:uint = 2;
      
      public static const SCENE_RESULT:uint = 3;
       
      
      private var flsnd:flightgameSoundLoader;
      
      public function soundController()
      {
         super();
         this.flsnd = new flightgameSoundLoader();
      }
      
      public function playSound(param1:String) : void
      {
         this.flsnd.playSound(param1);
      }
      
      public function playBGM(param1:String, param2:Number = 1) : void
      {
         this.flsnd.playBGM(param1,param2);
      }
      
      public function playSilentBGM(param1:String, param2:Number = 1) : void
      {
         this.flsnd.playSilentBGM(param1,param2);
      }
      
      public function stopBGM() : void
      {
         this.flsnd.stopBGM();
      }
      
      public function closeBGM() : void
      {
         this.flsnd.closeBGM();
      }
      
      public function bgmFadeIn(param1:int) : void
      {
         this.flsnd.bgmFadeIn(param1);
      }
      
      public function bgmFadeOut(param1:int, param2:Boolean = false) : void
      {
         this.flsnd.bgmFadeOut(param1,param2);
      }
      
      public function soundReset() : void
      {
         this.flsnd.soundReset();
      }
   }
}
