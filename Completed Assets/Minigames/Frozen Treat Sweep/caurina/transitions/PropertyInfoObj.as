package caurina.transitions
{

    public class PropertyInfoObj extends Object
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
            this.valueStart = param1;
            this.valueComplete = param2;
            this.originalValueComplete = param3;
            this.arrayIndex = param4;
            this.extra = param5;
            this.isSpecialProperty = param6;
            this.hasModifier = Boolean(param7);
            this.modifierFunction = param7;
            this.modifierParameters = param8;
            return;
        }// end function

        public function clone() : PropertyInfoObj
        {
            var _loc_1:* = new PropertyInfoObj(this.valueStart, this.valueComplete, this.originalValueComplete, this.arrayIndex, this.extra, this.isSpecialProperty, this.modifierFunction, this.modifierParameters);
            return _loc_1;
        }// end function

        public function toString() : String
        {
            var _loc_1:String = "\n[PropertyInfoObj ";
            _loc_1 = _loc_1 + ("valueStart:" + String(this.valueStart));
            _loc_1 = _loc_1 + ", ";
            _loc_1 = _loc_1 + ("valueComplete:" + String(this.valueComplete));
            _loc_1 = _loc_1 + ", ";
            _loc_1 = _loc_1 + ("originalValueComplete:" + String(this.originalValueComplete));
            _loc_1 = _loc_1 + ", ";
            _loc_1 = _loc_1 + ("arrayIndex:" + String(this.arrayIndex));
            _loc_1 = _loc_1 + ", ";
            _loc_1 = _loc_1 + ("extra:" + String(this.extra));
            _loc_1 = _loc_1 + ", ";
            _loc_1 = _loc_1 + ("isSpecialProperty:" + String(this.isSpecialProperty));
            _loc_1 = _loc_1 + ", ";
            _loc_1 = _loc_1 + ("hasModifier:" + String(this.hasModifier));
            _loc_1 = _loc_1 + ", ";
            _loc_1 = _loc_1 + ("modifierFunction:" + String(this.modifierFunction));
            _loc_1 = _loc_1 + ", ";
            _loc_1 = _loc_1 + ("modifierParameters:" + String(this.modifierParameters));
            _loc_1 = _loc_1 + "]\n";
            return _loc_1;
        }// end function

    }
}
