package caurina.transitions
{
   public class SpecialPropertySplitter
   {
      
      public var parameters:Array;
      
      public var splitValues:Function;
      
      public function SpecialPropertySplitter(param1:Function, param2:Array)
      {
         super();
         splitValues = param1;
         parameters = param2;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "";
         _loc1_ += "[SpecialPropertySplitter ";
         _loc1_ += "splitValues:" + String(splitValues);
         _loc1_ += ", ";
         _loc1_ += "parameters:" + String(parameters);
         return _loc1_ + "]";
      }
   }
}

