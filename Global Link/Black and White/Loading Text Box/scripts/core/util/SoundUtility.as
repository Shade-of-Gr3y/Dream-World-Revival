package core.util
{
   import flash.media.SoundTransform;
   
   public class SoundUtility
   {
      
      private var _src:*;
      
      public function SoundUtility(param1:*)
      {
         super();
         this._src = param1;
      }
      
      private function getSoundTransForm() : SoundTransform
      {
         return this._src.soundTransform;
      }
      
      public function set volume(param1:Number) : void
      {
         var _loc2_:SoundTransform = new SoundTransform(param1,0);
         this.setSoundTransForm(_loc2_);
      }
      
      public function get volume() : Number
      {
         var _loc1_:SoundTransform = this.getSoundTransForm();
         return _loc1_.volume;
      }
      
      private function setSoundTransForm(param1:SoundTransform) : void
      {
         this._src.soundTransform = param1;
      }
   }
}

