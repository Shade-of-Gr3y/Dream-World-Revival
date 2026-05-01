package org.libspark.betweenas3.core.updaters
{
   import org.libspark.betweenas3.core.easing.IPhysicalEasing;
   
   public class PhysicalUpdaterLadder implements IPhysicalUpdater
   {
      
      private var _parent:IPhysicalUpdater;
      
      private var _child:IPhysicalUpdater;
      
      private var _propertyName:String;
      
      private var _duration:Number = 0;
      
      public function PhysicalUpdaterLadder(param1:IPhysicalUpdater, param2:IPhysicalUpdater, param3:String)
      {
         super();
         this._parent = param1;
         this._child = param2;
         this._propertyName = param3;
         this._duration = param2.duration;
      }
      
      public function get parent() : IPhysicalUpdater
      {
         return this._parent;
      }
      
      public function get child() : IPhysicalUpdater
      {
         return this._child;
      }
      
      public function get target() : Object
      {
         return null;
      }
      
      public function set target(param1:Object) : void
      {
      }
      
      public function get easing() : IPhysicalEasing
      {
         return null;
      }
      
      public function set easing(param1:IPhysicalEasing) : void
      {
      }
      
      public function get duration() : Number
      {
         return this._duration;
      }
      
      public function setSourceValue(param1:String, param2:Number, param3:Boolean = false) : void
      {
      }
      
      public function setDestinationValue(param1:String, param2:Number, param3:Boolean = false) : void
      {
      }
      
      public function getObject(param1:String) : Object
      {
         return null;
      }
      
      public function setObject(param1:String, param2:Object) : void
      {
      }
      
      public function resolveValues() : void
      {
      }
      
      public function update(param1:Number) : void
      {
         this._child.update(param1);
         this._parent.setObject(this._propertyName,this._child.target);
      }
      
      public function clone() : IUpdater
      {
         return new PhysicalUpdaterLadder(this._parent,this._child,this._propertyName);
      }
   }
}

