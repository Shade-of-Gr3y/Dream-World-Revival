package caurina.transitions
{

    public class TweenListObj extends Object
    {
        public var scope:Object;
        public var properties:Object;
        public var timeStart:Number;
        public var timeComplete:Number;
        public var useFrames:Boolean;
        public var transition:Function;
        public var transitionParams:Object;
        public var onStart:Function;
        public var onUpdate:Function;
        public var onComplete:Function;
        public var onOverwrite:Function;
        public var onError:Function;
        public var onStartParams:Array;
        public var onUpdateParams:Array;
        public var onCompleteParams:Array;
        public var onOverwriteParams:Array;
        public var onStartScope:Object;
        public var onUpdateScope:Object;
        public var onCompleteScope:Object;
        public var onOverwriteScope:Object;
        public var onErrorScope:Object;
        public var rounded:Boolean;
        public var isPaused:Boolean;
        public var timePaused:Number;
        public var isCaller:Boolean;
        public var count:Number;
        public var timesCalled:Number;
        public var waitFrames:Boolean;
        public var skipUpdates:Number;
        public var updatesSkipped:Number;
        public var hasStarted:Boolean;

        public function TweenListObj(param1:Object, param2:Number, param3:Number, param4:Boolean, param5:Function, param6:Object)
        {
            this.scope = param1;
            this.timeStart = param2;
            this.timeComplete = param3;
            this.useFrames = param4;
            this.transition = param5;
            this.transitionParams = param6;
            this.properties = new Object();
            this.isPaused = false;
            this.timePaused = undefined;
            this.isCaller = false;
            this.updatesSkipped = 0;
            this.timesCalled = 0;
            this.skipUpdates = 0;
            this.hasStarted = false;
            return;
        }// end function

        public function clone(param1:Boolean) : TweenListObj
        {
            var _loc_3:String = null;
            var _loc_2:* = new TweenListObj(this.scope, this.timeStart, this.timeComplete, this.useFrames, this.transition, this.transitionParams);
            _loc_2.properties = new Array();
            for (_loc_3 in this.properties)
            {
                
                _loc_2.properties[_loc_3] = this.properties[_loc_3].clone();
            }
            _loc_2.skipUpdates = this.skipUpdates;
            _loc_2.updatesSkipped = this.updatesSkipped;
            if (!param1)
            {
                _loc_2.onStart = this.onStart;
                _loc_2.onUpdate = this.onUpdate;
                _loc_2.onComplete = this.onComplete;
                _loc_2.onOverwrite = this.onOverwrite;
                _loc_2.onError = this.onError;
                _loc_2.onStartParams = this.onStartParams;
                _loc_2.onUpdateParams = this.onUpdateParams;
                _loc_2.onCompleteParams = this.onCompleteParams;
                _loc_2.onOverwriteParams = this.onOverwriteParams;
                _loc_2.onStartScope = this.onStartScope;
                _loc_2.onUpdateScope = this.onUpdateScope;
                _loc_2.onCompleteScope = this.onCompleteScope;
                _loc_2.onOverwriteScope = this.onOverwriteScope;
                _loc_2.onErrorScope = this.onErrorScope;
            }
            _loc_2.rounded = this.rounded;
            _loc_2.isPaused = this.isPaused;
            _loc_2.timePaused = this.timePaused;
            _loc_2.isCaller = this.isCaller;
            _loc_2.count = this.count;
            _loc_2.timesCalled = this.timesCalled;
            _loc_2.waitFrames = this.waitFrames;
            _loc_2.hasStarted = this.hasStarted;
            return _loc_2;
        }// end function

        public function toString() : String
        {
            var _loc_3:String = null;
            var _loc_1:String = "\n[TweenListObj ";
            _loc_1 = _loc_1 + ("scope:" + String(this.scope));
            _loc_1 = _loc_1 + ", properties:";
            var _loc_2:Boolean = true;
            for (_loc_3 in this.properties)
            {
                
                if (!_loc_2)
                {
                    _loc_1 = _loc_1 + ",";
                }
                _loc_1 = _loc_1 + ("[name:" + this.properties[_loc_3].name);
                _loc_1 = _loc_1 + (",valueStart:" + this.properties[_loc_3].valueStart);
                _loc_1 = _loc_1 + (",valueComplete:" + this.properties[_loc_3].valueComplete);
                _loc_1 = _loc_1 + "]";
                _loc_2 = false;
            }
            _loc_1 = _loc_1 + (", timeStart:" + String(this.timeStart));
            _loc_1 = _loc_1 + (", timeComplete:" + String(this.timeComplete));
            _loc_1 = _loc_1 + (", useFrames:" + String(this.useFrames));
            _loc_1 = _loc_1 + (", transition:" + String(this.transition));
            _loc_1 = _loc_1 + (", transitionParams:" + String(this.transitionParams));
            if (this.skipUpdates)
            {
                _loc_1 = _loc_1 + (", skipUpdates:" + String(this.skipUpdates));
            }
            if (this.updatesSkipped)
            {
                _loc_1 = _loc_1 + (", updatesSkipped:" + String(this.updatesSkipped));
            }
            if (Boolean(this.onStart))
            {
                _loc_1 = _loc_1 + (", onStart:" + String(this.onStart));
            }
            if (Boolean(this.onUpdate))
            {
                _loc_1 = _loc_1 + (", onUpdate:" + String(this.onUpdate));
            }
            if (Boolean(this.onComplete))
            {
                _loc_1 = _loc_1 + (", onComplete:" + String(this.onComplete));
            }
            if (Boolean(this.onOverwrite))
            {
                _loc_1 = _loc_1 + (", onOverwrite:" + String(this.onOverwrite));
            }
            if (Boolean(this.onError))
            {
                _loc_1 = _loc_1 + (", onError:" + String(this.onError));
            }
            if (this.onStartParams)
            {
                _loc_1 = _loc_1 + (", onStartParams:" + String(this.onStartParams));
            }
            if (this.onUpdateParams)
            {
                _loc_1 = _loc_1 + (", onUpdateParams:" + String(this.onUpdateParams));
            }
            if (this.onCompleteParams)
            {
                _loc_1 = _loc_1 + (", onCompleteParams:" + String(this.onCompleteParams));
            }
            if (this.onOverwriteParams)
            {
                _loc_1 = _loc_1 + (", onOverwriteParams:" + String(this.onOverwriteParams));
            }
            if (this.onStartScope)
            {
                _loc_1 = _loc_1 + (", onStartScope:" + String(this.onStartScope));
            }
            if (this.onUpdateScope)
            {
                _loc_1 = _loc_1 + (", onUpdateScope:" + String(this.onUpdateScope));
            }
            if (this.onCompleteScope)
            {
                _loc_1 = _loc_1 + (", onCompleteScope:" + String(this.onCompleteScope));
            }
            if (this.onOverwriteScope)
            {
                _loc_1 = _loc_1 + (", onOverwriteScope:" + String(this.onOverwriteScope));
            }
            if (this.onErrorScope)
            {
                _loc_1 = _loc_1 + (", onErrorScope:" + String(this.onErrorScope));
            }
            if (this.rounded)
            {
                _loc_1 = _loc_1 + (", rounded:" + String(this.rounded));
            }
            if (this.isPaused)
            {
                _loc_1 = _loc_1 + (", isPaused:" + String(this.isPaused));
            }
            if (this.timePaused)
            {
                _loc_1 = _loc_1 + (", timePaused:" + String(this.timePaused));
            }
            if (this.isCaller)
            {
                _loc_1 = _loc_1 + (", isCaller:" + String(this.isCaller));
            }
            if (this.count)
            {
                _loc_1 = _loc_1 + (", count:" + String(this.count));
            }
            if (this.timesCalled)
            {
                _loc_1 = _loc_1 + (", timesCalled:" + String(this.timesCalled));
            }
            if (this.waitFrames)
            {
                _loc_1 = _loc_1 + (", waitFrames:" + String(this.waitFrames));
            }
            if (this.hasStarted)
            {
                _loc_1 = _loc_1 + (", hasStarted:" + String(this.hasStarted));
            }
            _loc_1 = _loc_1 + "]\n";
            return _loc_1;
        }// end function

        public static function makePropertiesChain(param1:Object) : Object
        {
            var _loc_3:Object = null;
            var _loc_4:Object = null;
            var _loc_5:Object = null;
            var _loc_6:Number = NaN;
            var _loc_7:Number = NaN;
            var _loc_8:Number = NaN;
            var _loc_2:* = param1.base;
            if (_loc_2)
            {
                _loc_3 = {};
                if (_loc_2 is Array)
                {
                    _loc_4 = [];
                    _loc_8 = 0;
                    while (_loc_8 < _loc_2.length)
                    {
                        
                        _loc_4.push(_loc_2[_loc_8]);
                        _loc_8 = _loc_8 + 1;
                    }
                }
                else
                {
                    _loc_4 = [_loc_2];
                }
                _loc_4.push(param1);
                _loc_6 = _loc_4.length;
                _loc_7 = 0;
                while (_loc_7 < _loc_6)
                {
                    
                    if (_loc_4[_loc_7]["base"])
                    {
                        _loc_5 = AuxFunctions.concatObjects(makePropertiesChain(_loc_4[_loc_7]["base"]), _loc_4[_loc_7]);
                    }
                    else
                    {
                        _loc_5 = _loc_4[_loc_7];
                    }
                    _loc_3 = AuxFunctions.concatObjects(_loc_3, _loc_5);
                    _loc_7 = _loc_7 + 1;
                }
                if (_loc_3["base"])
                {
                    delete _loc_3["base"];
                }
                return _loc_3;
            }
            else
            {
                return param1;
            }
        }// end function

    }
}
