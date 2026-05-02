package caurina.transitions
{
   public class SpecialPropertyModifier
   {
      
      public var getValue:Function;
      
      public var modifyValues:Function;
      
      public function SpecialPropertyModifier(param1:Function, param2:Function)
      {
         super();
         modifyValues = param1;
         getValue = param2;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "";
         _loc1_ += "[SpecialPropertyModifier ";
         _loc1_ += "modifyValues:" + String(modifyValues);
         _loc1_ += ", ";
         _loc1_ += "getValue:" + String(getValue);
         return _loc1_ + "]";
      }
   }
}

