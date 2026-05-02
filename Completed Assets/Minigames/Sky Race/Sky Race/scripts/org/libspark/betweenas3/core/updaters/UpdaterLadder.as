package org.libspark.betweenas3.core.updaters
{
   public class UpdaterLadder implements IUpdater
   {
       
      
      private var _parent:IUpdater;
      
      private var _child:IUpdater;
      
      private var _propertyName:String;
      
      public function UpdaterLadder(param1:IUpdater, param2:IUpdater, param3:String)
      {
         super();
         this._parent = param1;
         this._child = param2;
         this._propertyName = param3;
      }
      
      public function get parent() : IUpdater
      {
         return this._parent;
      }
      
      public function get child() : IUpdater
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
         return new UpdaterLadder(this._parent,this._child,this._propertyName);
      }
   }
}
