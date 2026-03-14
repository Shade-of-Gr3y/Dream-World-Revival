package com.google.analytics.core
{
   import com.google.analytics.data.X10;
   import com.google.analytics.utils.Variables;
   
   public class EventInfo
   {
      
      private var _isEventHit:Boolean;
      
      private var _ext10:X10;
      
      private var _x10:X10;
      
      public function EventInfo(param1:Boolean, param2:X10, param3:X10 = null)
      {
         super();
         _isEventHit = param1;
         _x10 = param2;
         _ext10 = param3;
      }
      
      public function toURLString() : String
      {
         var _loc1_:Variables = null;
         _loc1_ = toVariables();
         return _loc1_.toString();
      }
      
      public function get utmt() : String
      {
         return "event";
      }
      
      public function get utme() : String
      {
         return _x10.renderMergedUrlString(_ext10);
      }
      
      public function toVariables() : Variables
      {
         var _loc1_:Variables = null;
         _loc1_ = new Variables();
         _loc1_.URIencode = true;
         if(_isEventHit)
         {
            _loc1_.utmt = utmt;
         }
         _loc1_.utme = utme;
         return _loc1_;
      }
   }
}

