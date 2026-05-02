package bfp.pdw.farm.core.objects
{
   import flash.display.MovieClip;
   
   public class Container3D extends Object3D
   {
      
      protected var _targetMC:MovieClip;
      
      public function Container3D(param1:MovieClip, param2:* = 0, param3:* = 0, param4:* = 0)
      {
         this._targetMC = param1;
         super(param2,param3,param4);
      }
      
      override public function render() : *
      {
         super.render();
         this._targetMC.x = screenX;
         this._targetMC.y = screenY;
         this._targetMC.scaleX = this.targetMC.scaleY = scale;
      }
      
      public function get targetMC() : MovieClip
      {
         return this._targetMC;
      }
   }
}

