package com.google.analytics.utils
{
   public class Version
   {
      
      private var _maxBuild:uint = 255;
      
      private var _maxMinor:uint = 15;
      
      private var _maxMajor:uint = 15;
      
      private var _revision:uint;
      
      private var _separator:String = ".";
      
      private var _maxRevision:uint = 65535;
      
      private var _build:uint;
      
      private var _minor:uint;
      
      private var _major:uint;
      
      public function Version(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0)
      {
         var _loc5_:Version = null;
         _maxMajor = 15;
         _maxMinor = 15;
         _maxBuild = 255;
         _maxRevision = 65535;
         _separator = ".";
         super();
         if(param1 > _maxMajor && param2 == 0 && param3 == 0 && param4 == 0)
         {
            _loc5_ = Version.fromNumber(param1);
            param1 = _loc5_.major;
            param2 = _loc5_.minor;
            param3 = _loc5_.build;
            param4 = _loc5_.revision;
         }
         this.major = param1;
         this.minor = param2;
         this.build = param3;
         this.revision = param4;
      }
      
      public static function fromString(param1:String = "", param2:String = ".") : Version
      {
         var _loc3_:Version = null;
         var _loc4_:Array = null;
         _loc3_ = new Version();
         if(param1 == "" || param1 == null)
         {
            return _loc3_;
         }
         if(param1.indexOf(param2) > -1)
         {
            _loc4_ = param1.split(param2);
            _loc3_.major = parseInt(_loc4_[0]);
            _loc3_.minor = parseInt(_loc4_[1]);
            _loc3_.build = parseInt(_loc4_[2]);
            _loc3_.revision = parseInt(_loc4_[3]);
         }
         else
         {
            _loc3_.major = parseInt(param1);
         }
         return _loc3_;
      }
      
      public static function fromNumber(param1:Number = 0) : Version
      {
         var _loc2_:Version = null;
         _loc2_ = new Version();
         if(isNaN(param1) || param1 == 0 || param1 < 0 || param1 == Number.MAX_VALUE || param1 == Number.POSITIVE_INFINITY || param1 == Number.NEGATIVE_INFINITY)
         {
            return _loc2_;
         }
         _loc2_.major = param1 >>> 28;
         _loc2_.minor = (param1 & 0x0F000000) >>> 24;
         _loc2_.build = (param1 & 0xFF0000) >>> 16;
         _loc2_.revision = param1 & 0xFFFF;
         return _loc2_;
      }
      
      public function toString(param1:int = 0) : String
      {
         var _loc2_:Array = null;
         if(param1 <= 0 || param1 > 4)
         {
            param1 = getFields();
         }
         switch(param1)
         {
            case 1:
               _loc2_ = [major];
               break;
            case 2:
               _loc2_ = [major,minor];
               break;
            case 3:
               _loc2_ = [major,minor,build];
               break;
            case 4:
            default:
               _loc2_ = [major,minor,build,revision];
         }
         return _loc2_.join(_separator);
      }
      
      public function get revision() : uint
      {
         return _revision;
      }
      
      public function set build(param1:uint) : void
      {
         _build = Math.min(param1,_maxBuild);
      }
      
      public function set minor(param1:uint) : void
      {
         _minor = Math.min(param1,_maxMinor);
      }
      
      public function get build() : uint
      {
         return _build;
      }
      
      public function set major(param1:uint) : void
      {
         _major = Math.min(param1,_maxMajor);
      }
      
      public function get minor() : uint
      {
         return _minor;
      }
      
      public function valueOf() : uint
      {
         return major << 28 | minor << 24 | build << 16 | revision;
      }
      
      public function get major() : uint
      {
         return _major;
      }
      
      public function set revision(param1:uint) : void
      {
         _revision = Math.min(param1,_maxRevision);
      }
      
      private function getFields() : int
      {
         var _loc1_:int = 0;
         _loc1_ = 4;
         if(revision == 0)
         {
            _loc1_--;
         }
         if(_loc1_ == 3 && build == 0)
         {
            _loc1_--;
         }
         if(_loc1_ == 2 && minor == 0)
         {
            _loc1_--;
         }
         return _loc1_;
      }
      
      public function equals(param1:*) : Boolean
      {
         if(!(param1 is Version))
         {
            return false;
         }
         if(param1.major == major && param1.minor == minor && param1.build == build && param1.revision == revision)
         {
            return true;
         }
         return false;
      }
   }
}

