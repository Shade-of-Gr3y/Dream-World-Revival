package com.google.analytics.data
{
   import com.google.analytics.core.Buffer;
   
   public class UTMCookie implements Cookie
   {
      
      protected var inURL:String;
      
      protected var name:String;
      
      private var _creation:Date;
      
      private var _expiration:Date;
      
      public var proxy:Buffer;
      
      private var _timespan:Number;
      
      protected var fields:Array;
      
      public function UTMCookie(param1:String, param2:String, param3:Array, param4:Number = 0)
      {
         super();
         this.name = param1;
         this.inURL = param2;
         this.fields = param3;
         _timestamp(param4);
      }
      
      public function isEmpty() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         _loc1_ = 0;
         _loc3_ = 0;
         while(_loc3_ < fields.length)
         {
            _loc2_ = fields[_loc3_];
            if(this[_loc2_] is Number && isNaN(this[_loc2_]))
            {
               _loc1_++;
            }
            else if(this[_loc2_] is String && this[_loc2_] == "")
            {
               _loc1_++;
            }
            _loc3_++;
         }
         if(_loc1_ == fields.length)
         {
            return true;
         }
         return false;
      }
      
      protected function update() : void
      {
         resetTimestamp();
         if(proxy)
         {
            proxy.update(name,toSharedObject());
         }
      }
      
      public function fromSharedObject(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc3_ = int(fields.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = fields[_loc4_];
            if(param1[_loc2_])
            {
               this[_loc2_] = param1[_loc2_];
            }
            _loc4_++;
         }
         if(param1.creation)
         {
            this.creation = param1.creation;
         }
         if(param1.expiration)
         {
            this.expiration = param1.expiration;
         }
      }
      
      private function _timestamp(param1:Number) : void
      {
         creation = new Date();
         _timespan = param1;
         if(param1 > 0)
         {
            expiration = new Date(creation.valueOf() + param1);
         }
      }
      
      public function isExpired() : Boolean
      {
         var _loc1_:Date = null;
         var _loc2_:Number = NaN;
         _loc1_ = new Date();
         _loc2_ = expiration.valueOf() - _loc1_.valueOf();
         if(_loc2_ <= 0)
         {
            return true;
         }
         return false;
      }
      
      public function set expiration(param1:Date) : void
      {
         _expiration = param1;
      }
      
      public function get creation() : Date
      {
         return _creation;
      }
      
      public function reset() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < fields.length)
         {
            _loc1_ = fields[_loc2_];
            if(this[_loc1_] is Number)
            {
               this[_loc1_] = NaN;
            }
            else if(this[_loc1_] is String)
            {
               this[_loc1_] = "";
            }
            _loc2_++;
         }
         resetTimestamp();
         update();
      }
      
      public function valueOf() : String
      {
         var _loc1_:Array = null;
         var _loc2_:String = null;
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         _loc1_ = [];
         _loc4_ = 0;
         while(_loc4_ < fields.length)
         {
            _loc2_ = fields[_loc4_];
            _loc3_ = this[_loc2_];
            if(_loc3_ is String)
            {
               if(_loc3_ == "")
               {
                  _loc3_ = "-";
                  _loc1_.push(_loc3_);
               }
               else
               {
                  _loc1_.push(_loc3_);
               }
            }
            else if(_loc3_ is Number)
            {
               if(_loc3_ == 0)
               {
                  _loc1_.push(_loc3_);
               }
               else if(isNaN(_loc3_))
               {
                  _loc3_ = "-";
                  _loc1_.push(_loc3_);
               }
               else
               {
                  _loc1_.push(_loc3_);
               }
            }
            _loc4_++;
         }
         return "" + _loc1_.join(".");
      }
      
      public function resetTimestamp(param1:Number = NaN) : void
      {
         if(!isNaN(param1))
         {
            _timespan = param1;
         }
         _creation = null;
         _expiration = null;
         _timestamp(_timespan);
      }
      
      public function get expiration() : Date
      {
         if(_expiration)
         {
            return _expiration;
         }
         return new Date(new Date().valueOf() + 1000);
      }
      
      public function toURLString() : String
      {
         return inURL + "=" + valueOf();
      }
      
      public function toSharedObject() : Object
      {
         var _loc1_:Object = null;
         var _loc2_:String = null;
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         _loc1_ = {};
         _loc4_ = 0;
         while(_loc4_ < fields.length)
         {
            _loc2_ = fields[_loc4_];
            _loc3_ = this[_loc2_];
            if(_loc3_ is String)
            {
               _loc1_[_loc2_] = _loc3_;
            }
            else if(_loc3_ == 0)
            {
               _loc1_[_loc2_] = _loc3_;
            }
            else if(!isNaN(_loc3_))
            {
               _loc1_[_loc2_] = _loc3_;
            }
            _loc4_++;
         }
         _loc1_.creation = creation;
         _loc1_.expiration = expiration;
         return _loc1_;
      }
      
      public function toString(param1:Boolean = false) : String
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         var _loc4_:* = undefined;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:* = null;
         _loc2_ = [];
         _loc5_ = int(fields.length);
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = fields[_loc6_];
            _loc4_ = this[_loc3_];
            if(_loc4_ is String)
            {
               _loc2_.push(_loc3_ + ": \"" + _loc4_ + "\"");
            }
            else if(_loc4_ == 0)
            {
               _loc2_.push(_loc3_ + ": " + _loc4_);
            }
            else if(!isNaN(_loc4_))
            {
               _loc2_.push(_loc3_ + ": " + _loc4_);
            }
            _loc6_++;
         }
         _loc7_ = name.toUpperCase() + " {" + _loc2_.join(", ") + "}";
         if(param1)
         {
            _loc7_ += " creation:" + creation + ", expiration:" + expiration;
         }
         return _loc7_;
      }
      
      public function set creation(param1:Date) : void
      {
         _creation = param1;
      }
   }
}

