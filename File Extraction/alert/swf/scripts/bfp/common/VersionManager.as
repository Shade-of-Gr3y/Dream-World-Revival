package bfp.common
{
   public class VersionManager
   {
      
      private static var _xml:XML;
      
      public function VersionManager()
      {
         super();
      }
      
      public static function get xml() : XML
      {
         return _xml;
      }
      
      public static function set xml(src:XML) : void
      {
         _xml = src;
         Logger.log(_xml.toString());
      }
   }
}

