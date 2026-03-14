package com.google.analytics.core
{
   import com.google.analytics.utils.Variables;
   
   public class Organic
   {
      
      public static var throwErrors:Boolean = false;
      
      private var _sourcesCache:Array;
      
      private var _sourcesEngine:Array;
      
      private var _ignoredKeywords:Array;
      
      private var _ignoredReferralsCache:Object;
      
      private var _ignoredReferrals:Array;
      
      private var _ignoredKeywordsCache:Object;
      
      private var _sources:Array;
      
      public function Organic()
      {
         super();
         _sources = [];
         _sourcesCache = [];
         _sourcesEngine = [];
         _ignoredReferrals = [];
         _ignoredReferralsCache = {};
         _ignoredKeywords = [];
         _ignoredKeywordsCache = {};
      }
      
      public static function getKeywordValueFromPath(param1:String, param2:String) : String
      {
         var _loc3_:String = null;
         var _loc4_:Variables = null;
         if(param2.indexOf(param1 + "=") > -1)
         {
            if(param2.charAt(0) == "?")
            {
               param2 = param2.substr(1);
            }
            param2 = param2.split("+").join("%20");
            _loc4_ = new Variables(param2);
            _loc3_ = _loc4_[param1];
         }
         return _loc3_;
      }
      
      public function getKeywordValue(param1:OrganicReferrer, param2:String) : String
      {
         var _loc3_:String = null;
         _loc3_ = param1.keyword;
         return getKeywordValueFromPath(_loc3_,param2);
      }
      
      public function isIgnoredKeyword(param1:String) : Boolean
      {
         if(_ignoredKeywordsCache.hasOwnProperty(param1))
         {
            return true;
         }
         return false;
      }
      
      public function isIgnoredReferral(param1:String) : Boolean
      {
         if(_ignoredReferralsCache.hasOwnProperty(param1))
         {
            return true;
         }
         return false;
      }
      
      public function clear() : void
      {
         clearEngines();
         clearIgnoredReferrals();
         clearIgnoredKeywords();
      }
      
      public function get ignoredKeywordsCount() : int
      {
         return _ignoredKeywords.length;
      }
      
      public function match(param1:String) : Boolean
      {
         if(param1 == "")
         {
            return false;
         }
         param1 = param1.toLowerCase();
         if(_sourcesEngine[param1] != undefined)
         {
            return true;
         }
         return false;
      }
      
      public function get count() : int
      {
         return _sources.length;
      }
      
      public function addSource(param1:String, param2:String) : void
      {
         var _loc3_:OrganicReferrer = null;
         _loc3_ = new OrganicReferrer(param1,param2);
         if(_sourcesCache[_loc3_.toString()] == undefined)
         {
            _sources.push(_loc3_);
            _sourcesCache[_loc3_.toString()] = _sources.length - 1;
            if(_sourcesEngine[_loc3_.engine] == undefined)
            {
               _sourcesEngine[_loc3_.engine] = [_sources.length - 1];
            }
            else
            {
               _sourcesEngine[_loc3_.engine].push(_sources.length - 1);
            }
         }
         else if(throwErrors)
         {
            throw new Error(_loc3_.toString() + " already exists, we don\'t add it.");
         }
      }
      
      public function clearIgnoredKeywords() : void
      {
         _ignoredKeywords = [];
         _ignoredKeywordsCache = {};
      }
      
      public function clearEngines() : void
      {
         _sources = [];
         _sourcesCache = [];
         _sourcesEngine = [];
      }
      
      public function get ignoredReferralsCount() : int
      {
         return _ignoredReferrals.length;
      }
      
      public function addIgnoredReferral(param1:String) : void
      {
         if(_ignoredReferralsCache[param1] == undefined)
         {
            _ignoredReferrals.push(param1);
            _ignoredReferralsCache[param1] = _ignoredReferrals.length - 1;
         }
         else if(throwErrors)
         {
            throw new Error("\"" + param1 + "\" already exists, we don\'t add it.");
         }
      }
      
      public function clearIgnoredReferrals() : void
      {
         _ignoredReferrals = [];
         _ignoredReferralsCache = {};
      }
      
      public function getReferrerByName(param1:String) : OrganicReferrer
      {
         var _loc2_:int = 0;
         if(match(param1))
         {
            _loc2_ = int(_sourcesEngine[param1][0]);
            return _sources[_loc2_];
         }
         return null;
      }
      
      public function addIgnoredKeyword(param1:String) : void
      {
         if(_ignoredKeywordsCache[param1] == undefined)
         {
            _ignoredKeywords.push(param1);
            _ignoredKeywordsCache[param1] = _ignoredKeywords.length - 1;
         }
         else if(throwErrors)
         {
            throw new Error("\"" + param1 + "\" already exists, we don\'t add it.");
         }
      }
      
      public function get sources() : Array
      {
         return _sources;
      }
   }
}

