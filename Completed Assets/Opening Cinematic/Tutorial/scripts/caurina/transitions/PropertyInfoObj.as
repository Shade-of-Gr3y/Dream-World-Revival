package caurina.transitions
{
   public class PropertyInfoObj
   {
       
      
      public var valueStart:Number;
      
      public var valueComplete:Number;
      
      public var originalValueComplete:Object;
      
      public var arrayIndex:Number;
      
      public var extra:Object;
      
      public var isSpecialProperty:Boolean;
      
      public var hasModifier:Boolean;
      
      public var modifierFunction:Function;
      
      public var modifierParameters:Array;
      
      public function PropertyInfoObj(param1:Number, param2:Number, param3:Object, param4:Number, param5:Object, param6:Boolean, param7:Function, param8:Array)
      {
         super();
         this.valueStart = param1;
         this.valueComplete = param2;
         this.originalValueComplete = param3;
         this.arrayIndex = param4;
         this.extra = param5;
         this.isSpecialProperty = param6;
         this.hasModifier = Boolean(param7);
         this.modifierFunction = param7;
         this.modifierParameters = param8;
      }
      
      public function clone() : PropertyInfoObj
      {
         return new PropertyInfoObj(this.valueStart,this.valueComplete,this.originalValueComplete,this.arrayIndex,this.extra,this.isSpecialProperty,this.modifierFunction,this.modifierParameters);
      }
      
      public function toString() : String
      {
         var _loc1_:* = "\n[PropertyInfoObj ";
         _loc1_ += "valueStart:" + String(this.valueStart);
         _loc1_ += ", ";
         _loc1_ += "valueComplete:" + String(this.valueComplete);
         _loc1_ += ", ";
         _loc1_ += "originalValueComplete:" + String(this.originalValueComplete);
         _loc1_ += ", ";
         _loc1_ += "arrayIndex:" + String(this.arrayIndex);
         _loc1_ += ", ";
         _loc1_ += "extra:" + String(this.extra);
         _loc1_ += ", ";
         _loc1_ += "isSpecialProperty:" + String(this.isSpecialProperty);
         _loc1_ += ", ";
         _loc1_ += "hasModifier:" + String(this.hasModifier);
         _loc1_ += ", ";
         _loc1_ += "modifierFunction:" + String(this.modifierFunction);
         _loc1_ += ", ";
         _loc1_ += "modifierParameters:" + String(this.modifierParameters);
         return _loc1_ + "]\n";
      }
   }
}
