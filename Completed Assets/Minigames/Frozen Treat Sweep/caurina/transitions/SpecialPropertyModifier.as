package caurina.transitions
{

    public class SpecialPropertyModifier extends Object
    {
        public var modifyValues:Function;
        public var getValue:Function;

        public function SpecialPropertyModifier(param1:Function, param2:Function)
        {
            this.modifyValues = param1;
            this.getValue = param2;
            return;
        }// end function

        public function toString() : String
        {
            var _loc_1:String = "";
            _loc_1 = _loc_1 + "[SpecialPropertyModifier ";
            _loc_1 = _loc_1 + ("modifyValues:" + String(this.modifyValues));
            _loc_1 = _loc_1 + ", ";
            _loc_1 = _loc_1 + ("getValue:" + String(this.getValue));
            _loc_1 = _loc_1 + "]";
            return _loc_1;
        }// end function

    }
}
