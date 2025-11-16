package bfp.common
{
   public class VersionManager
   {
      
      private static var _xml:XML;
       
      
      public function VersionManager()
      {
         super();
      }
      
      public static function set xml(param1:XML) : void
      {
         _xml = param1;
         Logger.log(_xml.toString());
      }
      
      public static function get xml() : XML
      {
         return _xml;
      }
   }
}
