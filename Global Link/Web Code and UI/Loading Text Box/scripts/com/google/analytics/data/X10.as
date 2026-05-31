package com.google.analytics.data
{
   public class X10
   {
      
      private var _delimEnd:String = ")";
      
      private var _delimSet:String = "*";
      
      private var _escapeChar:String = "\'";
      
      private var _delimBegin:String = "(";
      
      private var _delimNumValue:String = "!";
      
      private var _key:String = "k";
      
      private var _set:Array;
      
      private var _projectData:Object;
      
      private var _hasData:int;
      
      private var _escapeCharMap:Object;
      
      private var _minimum:int;
      
      private var _value:String = "v";
      
      public function X10()
      {
         _set = [_key,_value];
         super();
         _projectData = {};
         _escapeCharMap = {};
         _escapeCharMap[_escapeChar] = "\'0";
         _escapeCharMap[_delimEnd] = "\'1";
         _escapeCharMap[_delimSet] = "\'2";
         _escapeCharMap[_delimNumValue] = "\'3";
         _minimum = 1;
      }
      
      private function _clearInternal(param1:Number, param2:String) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(hasProject(param1) && _projectData[param1][param2] != undefined)
         {
            _projectData[param1][param2] = undefined;
            _loc3_ = true;
            _loc5_ = int(_set.length);
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               if(_projectData[param1][_set[_loc4_]] != undefined)
               {
                  _loc3_ = false;
                  break;
               }
               _loc4_++;
            }
            if(_loc3_)
            {
               _projectData[param1] = undefined;
               --_hasData;
            }
         }
      }
      
      public function hasData() : Boolean
      {
         return _hasData > 0;
      }
      
      private function _setInternal(param1:Number, param2:String, param3:Number, param4:String) : void
      {
         if(!hasProject(param1))
         {
            _projectData[param1] = {};
         }
         if(_projectData[param1][param2] == undefined)
         {
            _projectData[param1][param2] = [];
         }
         _projectData[param1][param2][param3] = param4;
         _hasData += 1;
      }
      
      public function hasProject(param1:Number) : Boolean
      {
         return _projectData[param1];
      }
      
      public function clearKey(param1:Number) : void
      {
         _clearInternal(param1,_key);
      }
      
      private function _renderDataType(param1:Array) : String
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         _loc2_ = [];
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            if(param1[_loc4_] != undefined)
            {
               _loc3_ = "";
               if(_loc4_ != _minimum && param1[_loc4_ - 1] == undefined)
               {
                  _loc3_ += _loc4_.toString();
                  _loc3_ += _delimNumValue;
               }
               _loc3_ += _escapeExtensibleValue(param1[_loc4_]);
               _loc2_.push(_loc3_);
            }
            _loc4_++;
         }
         return _delimBegin + _loc2_.join(_delimSet) + _delimEnd;
      }
      
      public function getKey(param1:Number, param2:Number) : String
      {
         return _getInternal(param1,_key,param2) as String;
      }
      
      public function clearValue(param1:Number) : void
      {
         _clearInternal(param1,_value);
      }
      
      public function renderMergedUrlString(param1:X10 = null) : String
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         if(!param1)
         {
            return renderUrlString();
         }
         _loc2_ = [param1.renderUrlString()];
         for(_loc3_ in _projectData)
         {
            if(hasProject(Number(_loc3_)) && !param1.hasProject(Number(_loc3_)))
            {
               _loc2_.push(_loc3_ + _renderProject(_projectData[_loc3_]));
            }
         }
         return _loc2_.join("");
      }
      
      public function setValue(param1:Number, param2:Number, param3:Number) : Boolean
      {
         if(Math.round(param3) != param3 || isNaN(param3) || param3 == Infinity)
         {
            return false;
         }
         _setInternal(param1,_value,param2,param3.toString());
         return true;
      }
      
      public function renderUrlString() : String
      {
         var _loc1_:Array = null;
         var _loc2_:String = null;
         _loc1_ = [];
         for(_loc2_ in _projectData)
         {
            if(hasProject(Number(_loc2_)))
            {
               _loc1_.push(_loc2_ + _renderProject(_projectData[_loc2_]));
            }
         }
         return _loc1_.join("");
      }
      
      private function _getInternal(param1:Number, param2:String, param3:Number) : Object
      {
         if(hasProject(param1) && _projectData[param1][param2] != undefined)
         {
            return _projectData[param1][param2][param3];
         }
         return undefined;
      }
      
      public function setKey(param1:Number, param2:Number, param3:String) : Boolean
      {
         _setInternal(param1,_key,param2,param3);
         return true;
      }
      
      public function getValue(param1:Number, param2:Number) : *
      {
         var _loc3_:* = undefined;
         _loc3_ = _getInternal(param1,_value,param2);
         if(_loc3_ == null)
         {
            return null;
         }
         return Number(_loc3_);
      }
      
      private function _renderProject(param1:Object) : String
      {
         var _loc2_:String = null;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         _loc2_ = "";
         _loc3_ = false;
         _loc6_ = int(_set.length);
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc5_ = param1[_set[_loc4_]];
            if(_loc5_)
            {
               if(_loc3_)
               {
                  _loc2_ += _set[_loc4_];
               }
               _loc2_ += _renderDataType(_loc5_);
               _loc3_ = false;
            }
            else
            {
               _loc3_ = true;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function _escapeExtensibleValue(param1:String) : String
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:String = null;
         _loc2_ = "";
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1.charAt(_loc3_);
            _loc5_ = _escapeCharMap[_loc4_];
            if(_loc5_)
            {
               _loc2_ += _loc5_;
            }
            else
            {
               _loc2_ += _loc4_;
            }
            _loc3_++;
         }
         return _loc2_;
      }
   }
}

