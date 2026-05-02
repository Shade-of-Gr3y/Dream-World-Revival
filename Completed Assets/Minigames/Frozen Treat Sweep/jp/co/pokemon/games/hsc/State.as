package jp.co.pokemon.games.hsc
{
    import flash.utils.*;

    public class State extends Object
    {
        private var name:String = null;
        private var value:String = null;
        private var appointState:String = null;
        private var stateTime:uint = 0;
        private var pushStateTbl:Array;
        private var isTrace:Boolean = false;
        public var beforState:String = null;
        public var parameter:Object = null;
        public var localVar:Object;
        public var currentTime1000:int = 0;
        public var startTime1000:int = 0;

        public function State(param1:String, param2:Boolean = false)
        {
            this.pushStateTbl = new Array();
            this.localVar = new Object();
            this.name = param1;
            this.isTrace = param2;
            this.appoint("Begin");
            return;
        }// end function

        public function debug_trace(param1:String) : void
        {
            return;
        }// end function

        public function setTrace(param1:Boolean) : void
        {
            this.isTrace = param1;
            return;
        }// end function

        public function appoint(param1:String, param2:Object = null) : void
        {
            this.appointState = param1;
            this.parameterSet(param2);
            return;
        }// end function

        public function parameterSet(param1:Object) : void
        {
            this.parameter = param1;
            return;
        }// end function

        public function isAppointed() : Boolean
        {
            return this.appointState != null;
        }// end function

        public function isFirst() : Boolean
        {
            return this.stateTime == 0;
        }// end function

        public function getTime() : uint
        {
            return this.stateTime;
        }// end function

        public function getValue() : String
        {
            return this.value;
        }// end function

        public function pushCurrent() : void
        {
            this.pushOnly(this.value);
            return;
        }// end function

        public function pushOnly(param1:String) : void
        {
            this.pushStateTbl.push(param1);
            return;
        }// end function

        public function pushCall(param1:String, param2:String, param3:Object = null) : void
        {
            this.pushStateTbl.push(param1);
            this.appointState = param2;
            this.parameterSet(param3);
            return;
        }// end function

        public function popReturn() : void
        {
            var _loc_1:* = this.pushStateTbl.pop();
            if (_loc_1 == null)
            {
            }
            this.appoint(_loc_1);
            return;
        }// end function

        public function update() : String
        {
            this.currentTime1000 = getTimer();
            if (this.appointState == null)
            {
                var _loc_1:String = this;
                var _loc_2:* = this.stateTime + 1;
                _loc_1.stateTime = _loc_2;
            }
            else
            {
                if (this.isTrace)
                {
                    this.debug_trace("mode change! " + this.name + " " + this.appointState);
                }
                this.beforState = this.value;
                this.value = this.appointState;
                this.appointState = null;
                this.stateTime = 0;
                this.localVar = new Object();
                this.startTime1000 = this.currentTime1000;
            }
            return this.value;
        }// end function

        public function getTimeSecond1000() : int
        {
            return this.currentTime1000 - this.startTime1000;
        }// end function

    }
}
