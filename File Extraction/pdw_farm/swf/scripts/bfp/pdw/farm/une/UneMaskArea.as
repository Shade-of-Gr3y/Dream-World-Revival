package bfp.pdw.farm.une
{
   import bfp.pdw.farm.core.objects.Container3D;
   import flash.utils.getDefinitionByName;
   
   public class UneMaskArea extends Container3D
   {
      
      protected var className:*;
      
      protected var _id:*;
      
      protected var _positionNum:Number = 0;
      
      public var defaultPositonNum:Number = 0;
      
      public var dpF:Number = 0;
      
      public var dpB:Number = 0;
      
      public function UneMaskArea(param1:*, param2:* = 0, param3:* = 0, param4:* = 0)
      {
         this.className = param1;
         var _loc5_:* = getDefinitionByName(param1);
         super(new _loc5_(),param2,param3,param4);
      }
      
      public function get positionNum() : Number
      {
         return this._positionNum;
      }
      
      public function set positionNum(param1:Number) : *
      {
         this._positionNum = param1;
      }
      
      override public function render() : *
      {
         super.render();
         if(z < -fl)
         {
            targetMC.visible = false;
         }
         else
         {
            targetMC.visible = true;
         }
      }
      
      public function stop() : *
      {
         _targetMC = null;
      }
      
      public function reset() : *
      {
      }
   }
}

