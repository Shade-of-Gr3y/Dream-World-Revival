package caurina.transitions
{

    public class SpecialProperty extends Object
    {
        public var getValue:Function;
        public var setValue:Function;
        public var parameters:Array;
        public var preProcess:Function;

        public function SpecialProperty(param1:Function, param2:Function, param3:Array = null, param4:Function = null)
        {
            this.getValue = param1;
            this.setValue = param2;
            this.parameters = param3;
            this.preProcess = param4;
            return;
        }// end function

        public function toString() : String
        {
            var _loc_1:String = "";
            _loc_1 = _loc_1 + "[SpecialProperty ";
            _loc_1 = _loc_1 + ("getValue:" + String(this.getValue));
            _loc_1 = _loc_1 + ", ";
            _loc_1 = _loc_1 + ("setValue:" + String(this.setValue));
            _loc_1 = _loc_1 + ", ";
            _loc_1 = _loc_1 + ("parameters:" + String(this.parameters));
            _loc_1 = _loc_1 + ", ";
            _loc_1 = _loc_1 + ("preProcess:" + String(this.preProcess));
            _loc_1 = _loc_1 + "]";
            return _loc_1;
        }// end function

    }
}
