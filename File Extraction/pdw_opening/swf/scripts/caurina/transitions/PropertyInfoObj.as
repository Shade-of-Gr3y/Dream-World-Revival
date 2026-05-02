package caurina.transitions
{
   public class PropertyInfoObj
   {
      
      public var modifierParameters:Array;
      
      public var isSpecialProperty:Boolean;
      
      public var valueComplete:Number;
      
      public var modifierFunction:Function;
      
      public var extra:Object;
      
      public var valueStart:Number;
      
      public var hasModifier:Boolean;
      
      public var arrayIndex:Number;
      
      public var originalValueComplete:Object;
      
      public function PropertyInfoObj(param1:Number, param2:Number, param3:Object, param4:Number, param5:Object, param6:Boolean, param7:Function, param8:Array)
      {
         super();
         valueStart = param1;
         valueComplete = param2;
         originalValueComplete = param3;
         arrayIndex = param4;
         extra = param5;
         isSpecialProperty = param6;
         hasModifier = Boolean(param7);
         modifierFunction = param7;
         modifierParameters = param8;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "\n[PropertyInfoObj ";
         _loc1_ += "valueStart:" + String(valueStart);
         _loc1_ += ", ";
         _loc1_ += "valueComplete:" + String(valueComplete);
         _loc1_ += ", ";
         _loc1_ += "originalValueComplete:" + String(originalValueComplete);
         _loc1_ += ", ";
         _loc1_ += "arrayIndex:" + String(arrayIndex);
         _loc1_ += ", ";
         _loc1_ += "extra:" + String(extra);
         _loc1_ += ", ";
         _loc1_ += "isSpecialProperty:" + String(isSpecialProperty);
         _loc1_ += ", ";
         _loc1_ += "hasModifier:" + String(hasModifier);
         _loc1_ += ", ";
         _loc1_ += "modifierFunction:" + String(modifierFunction);
         _loc1_ += ", ";
         _loc1_ += "modifierParameters:" + String(modifierParameters);
         return _loc1_ + "]\n";
      }
      
      public function clone() : PropertyInfoObj
      {
         return new PropertyInfoObj(valueStart,valueComplete,originalValueComplete,arrayIndex,extra,isSpecialProperty,modifierFunction,modifierParameters);
      }
   }
}

