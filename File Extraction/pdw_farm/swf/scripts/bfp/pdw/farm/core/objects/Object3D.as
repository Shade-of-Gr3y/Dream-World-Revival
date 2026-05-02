package bfp.pdw.farm.core.objects
{
   import flash.events.EventDispatcher;
   
   public class Object3D extends EventDispatcher
   {
      
      protected var _x:Number = 0;
      
      protected var _y:Number = 0;
      
      protected var _z:Number = 0;
      
      protected var _fl:Number = 250;
      
      protected var _vpX:Number = 0;
      
      protected var _vpY:Number = 0;
      
      protected var _screenX:Number = 0;
      
      protected var _screenY:Number = 0;
      
      protected var _scale:Number = 1;
      
      public function Object3D(param1:* = 0, param2:* = 0, param3:* = 0)
      {
         super();
         this.x = param1;
      }
      
      public function set x(param1:Number) : *
      {
         this._x = param1;
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function set y(param1:Number) : *
      {
         this._y = param1;
      }
      
      public function get y() : Number
      {
         return this._y;
      }
      
      public function set z(param1:Number) : *
      {
         this._z = param1;
      }
      
      public function get z() : Number
      {
         return this._z;
      }
      
      public function set fl(param1:Number) : *
      {
         this._fl = param1;
      }
      
      public function get fl() : Number
      {
         return this._fl;
      }
      
      public function set vpX(param1:Number) : *
      {
         this._vpX = param1;
      }
      
      public function get vpX() : Number
      {
         return this._vpX;
      }
      
      public function set vpY(param1:Number) : *
      {
         this._vpY = param1;
      }
      
      public function get vpY() : Number
      {
         return this._vpY;
      }
      
      public function set screenX(param1:Number) : *
      {
         this._screenX = param1;
      }
      
      public function get screenX() : Number
      {
         return this._screenX;
      }
      
      public function set screenY(param1:Number) : *
      {
         this._screenY = param1;
      }
      
      public function get screenY() : Number
      {
         return this._screenY;
      }
      
      public function set scale(param1:Number) : *
      {
         this._scale = param1;
      }
      
      public function get scale() : Number
      {
         return this._scale;
      }
      
      public function render() : *
      {
         this.scale = this.fl / (this.z + this.fl);
         this.screenX = this.x * this.scale + this.vpX;
         this.screenY = this.y * this.scale + this.vpY;
      }
   }
}

