package org.libspark.betweenas3.core.updaters
{
   public class AbstractUpdater implements IUpdater
   {
       
      
      protected var _isResolved:Boolean = false;
      
      public function AbstractUpdater()
      {
         super();
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
      
      public function update(param1:Number) : void
      {
         if(!this._isResolved)
         {
            this.resolveValues();
            this._isResolved = true;
         }
         this.updateObject(param1);
      }
      
      protected function resolveValues() : void
      {
      }
      
      protected function updateObject(param1:Number) : void
      {
      }
      
      public function clone() : IUpdater
      {
         var _loc1_:AbstractUpdater = this.newInstance();
         if(_loc1_ != null)
         {
            _loc1_.copyFrom(this);
         }
         return _loc1_;
      }
      
      protected function newInstance() : AbstractUpdater
      {
         return null;
      }
      
      protected function copyFrom(param1:AbstractUpdater) : void
      {
      }
   }
}
