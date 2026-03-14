package com.google.analytics.campaign
{
   import com.google.analytics.utils.Variables;
   
   public class CampaignInfo
   {
      
      private var _new:Boolean;
      
      private var _empty:Boolean;
      
      public function CampaignInfo(param1:Boolean = true, param2:Boolean = false)
      {
         super();
         _empty = param1;
         _new = param2;
      }
      
      public function isEmpty() : Boolean
      {
         return _empty;
      }
      
      public function toURLString() : String
      {
         var _loc1_:Variables = null;
         _loc1_ = toVariables();
         return _loc1_.toString();
      }
      
      public function toVariables() : Variables
      {
         var _loc1_:Variables = null;
         _loc1_ = new Variables();
         _loc1_.URIencode = true;
         if(!isEmpty() && isNew())
         {
            _loc1_.utmcn = utmcn;
         }
         if(!isEmpty() && !isNew())
         {
            _loc1_.utmcr = utmcr;
         }
         return _loc1_;
      }
      
      public function isNew() : Boolean
      {
         return _new;
      }
      
      public function get utmcn() : String
      {
         return "1";
      }
      
      public function get utmcr() : String
      {
         return "1";
      }
   }
}

