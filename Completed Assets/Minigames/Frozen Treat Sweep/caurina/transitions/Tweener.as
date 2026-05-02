package caurina.transitions
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class Tweener extends Object
    {
        private static var __tweener_controller__:MovieClip;
        private static var _engineExists:Boolean = false;
        private static var _inited:Boolean = false;
        private static var _currentTime:Number;
        private static var _currentTimeFrame:Number;
        private static var _tweenList:Array;
        private static var _timeScale:Number = 1;
        private static var _transitionList:Object;
        private static var _specialPropertyList:Object;
        private static var _specialPropertyModifierList:Object;
        private static var _specialPropertySplitterList:Object;
        public static var autoOverwrite:Boolean = true;

        public function Tweener()
        {
            return;
        }// end function

        public static function addTween(param1:Object = null, param2:Object = null) : Boolean
        {
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_5:String = null;
            var _loc_6:Array = null;
            var _loc_13:Function = null;
            var _loc_14:Object = null;
            var _loc_15:TweenListObj = null;
            var _loc_16:Number = NaN;
            var _loc_17:Array = null;
            var _loc_18:Array = null;
            var _loc_19:Array = null;
            var _loc_20:String = null;
            if (!Boolean(param1))
            {
                return false;
            }
            if (param1 is Array)
            {
                _loc_6 = param1.concat();
            }
            else
            {
                _loc_6 = [param1];
            }
            var _loc_7:* = TweenListObj.makePropertiesChain(param2);
            if (!_inited)
            {
                init();
            }
            if (!_engineExists || !Boolean(__tweener_controller__))
            {
                startEngine();
            }
            var _loc_8:* = isNaN(_loc_7.time) ? (0) : (_loc_7.time);
            var _loc_9:* = isNaN(_loc_7.delay) ? (0) : (_loc_7.delay);
            var _loc_10:* = new Array();
            var _loc_11:Object = {overwrite:true, time:true, delay:true, useFrames:true, skipUpdates:true, transition:true, transitionParams:true, onStart:true, onUpdate:true, onComplete:true, onOverwrite:true, onError:true, rounded:true, onStartParams:true, onUpdateParams:true, onCompleteParams:true, onOverwriteParams:true, onStartScope:true, onUpdateScope:true, onCompleteScope:true, onOverwriteScope:true, onErrorScope:true};
            var _loc_12:* = new Object();
            for (_loc_5 in _loc_7)
            {
                
                if (!_loc_11[_loc_5])
                {
                    if (_specialPropertySplitterList[_loc_5])
                    {
                        _loc_17 = _specialPropertySplitterList[_loc_5].splitValues(_loc_7[_loc_5], _specialPropertySplitterList[_loc_5].parameters);
                        _loc_3 = 0;
                        while (_loc_3 < _loc_17.length)
                        {
                            
                            if (_specialPropertySplitterList[_loc_17[_loc_3].name])
                            {
                                _loc_18 = _specialPropertySplitterList[_loc_17[_loc_3].name].splitValues(_loc_17[_loc_3].value, _specialPropertySplitterList[_loc_17[_loc_3].name].parameters);
                                _loc_4 = 0;
                                while (_loc_4 < _loc_18.length)
                                {
                                    
                                    _loc_10[_loc_18[_loc_4].name] = {valueStart:undefined, valueComplete:_loc_18[_loc_4].value, arrayIndex:_loc_18[_loc_4].arrayIndex, isSpecialProperty:false};
                                    _loc_4 = _loc_4 + 1;
                                }
                            }
                            else
                            {
                                _loc_10[_loc_17[_loc_3].name] = {valueStart:undefined, valueComplete:_loc_17[_loc_3].value, arrayIndex:_loc_17[_loc_3].arrayIndex, isSpecialProperty:false};
                            }
                            _loc_3 = _loc_3 + 1;
                        }
                        continue;
                    }
                    if (_specialPropertyModifierList[_loc_5] != undefined)
                    {
                        _loc_19 = _specialPropertyModifierList[_loc_5].modifyValues(_loc_7[_loc_5]);
                        _loc_3 = 0;
                        while (_loc_3 < _loc_19.length)
                        {
                            
                            _loc_12[_loc_19[_loc_3].name] = {modifierParameters:_loc_19[_loc_3].parameters, modifierFunction:_specialPropertyModifierList[_loc_5].getValue};
                            _loc_3 = _loc_3 + 1;
                        }
                        continue;
                    }
                    _loc_10[_loc_5] = {valueStart:undefined, valueComplete:_loc_7[_loc_5]};
                }
            }
            for (_loc_5 in _loc_10)
            {
                
                if (_specialPropertyList[_loc_5] != undefined)
                {
                    _loc_10[_loc_5].isSpecialProperty = true;
                    continue;
                }
                if (_loc_6[0][_loc_5] == undefined)
                {
                    printError("The property \'" + _loc_5 + "\' doesn\'t seem to be a normal object property of " + String(_loc_6[0]) + " or a registered special property.");
                }
            }
            for (_loc_5 in _loc_12)
            {
                
                if (_loc_10[_loc_5] != undefined)
                {
                    _loc_10[_loc_5].modifierParameters = _loc_12[_loc_5].modifierParameters;
                    _loc_10[_loc_5].modifierFunction = _loc_12[_loc_5].modifierFunction;
                }
            }
            if (typeof(_loc_7.transition) == "string")
            {
                _loc_20 = _loc_7.transition.toLowerCase();
                _loc_13 = _transitionList[_loc_20];
            }
            else
            {
                _loc_13 = _loc_7.transition;
            }
            if (!Boolean(_loc_13))
            {
                _loc_13 = _transitionList["easeoutexpo"];
            }
            _loc_3 = 0;
            while (_loc_3 < _loc_6.length)
            {
                
                _loc_14 = new Object();
                for (_loc_5 in _loc_10)
                {
                    
                    _loc_14[_loc_5] = new PropertyInfoObj(_loc_10[_loc_5].valueStart, _loc_10[_loc_5].valueComplete, _loc_10[_loc_5].valueComplete, _loc_10[_loc_5].arrayIndex, {}, _loc_10[_loc_5].isSpecialProperty, _loc_10[_loc_5].modifierFunction, _loc_10[_loc_5].modifierParameters);
                }
                if (_loc_7.useFrames == true)
                {
                    _loc_15 = new TweenListObj(_loc_6[_loc_3], _currentTimeFrame + _loc_9 / _timeScale, _currentTimeFrame + (_loc_9 + _loc_8) / _timeScale, true, _loc_13, _loc_7.transitionParams);
                }
                else
                {
                    _loc_15 = new TweenListObj(_loc_6[_loc_3], _currentTime + _loc_9 * 1000 / _timeScale, _currentTime + (_loc_9 * 1000 + _loc_8 * 1000) / _timeScale, false, _loc_13, _loc_7.transitionParams);
                }
                _loc_15.properties = _loc_14;
                _loc_15.onStart = _loc_7.onStart;
                _loc_15.onUpdate = _loc_7.onUpdate;
                _loc_15.onComplete = _loc_7.onComplete;
                _loc_15.onOverwrite = _loc_7.onOverwrite;
                _loc_15.onError = _loc_7.onError;
                _loc_15.onStartParams = _loc_7.onStartParams;
                _loc_15.onUpdateParams = _loc_7.onUpdateParams;
                _loc_15.onCompleteParams = _loc_7.onCompleteParams;
                _loc_15.onOverwriteParams = _loc_7.onOverwriteParams;
                _loc_15.onStartScope = _loc_7.onStartScope;
                _loc_15.onUpdateScope = _loc_7.onUpdateScope;
                _loc_15.onCompleteScope = _loc_7.onCompleteScope;
                _loc_15.onOverwriteScope = _loc_7.onOverwriteScope;
                _loc_15.onErrorScope = _loc_7.onErrorScope;
                _loc_15.rounded = _loc_7.rounded;
                _loc_15.skipUpdates = _loc_7.skipUpdates;
                if (_loc_7.overwrite == undefined ? (autoOverwrite) : (_loc_7.overwrite))
                {
                    removeTweensByTime(_loc_15.scope, _loc_15.properties, _loc_15.timeStart, _loc_15.timeComplete);
                }
                _tweenList.push(_loc_15);
                if (_loc_8 == 0 && _loc_9 == 0)
                {
                    _loc_16 = _tweenList.length - 1;
                    updateTweenByIndex(_loc_16);
                    removeTweenByIndex(_loc_16);
                }
                _loc_3 = _loc_3 + 1;
            }
            return true;
        }// end function

        public static function addCaller(param1:Object = null, param2:Object = null) : Boolean
        {
            var _loc_3:Number = NaN;
            var _loc_4:Array = null;
            var _loc_8:Function = null;
            var _loc_9:TweenListObj = null;
            var _loc_10:Number = NaN;
            var _loc_11:String = null;
            if (!Boolean(param1))
            {
                return false;
            }
            if (param1 is Array)
            {
                _loc_4 = param1.concat();
            }
            else
            {
                _loc_4 = [param1];
            }
            var _loc_5:* = param2;
            if (!_inited)
            {
                init();
            }
            if (!_engineExists || !Boolean(__tweener_controller__))
            {
                startEngine();
            }
            var _loc_6:* = isNaN(_loc_5.time) ? (0) : (_loc_5.time);
            var _loc_7:* = isNaN(_loc_5.delay) ? (0) : (_loc_5.delay);
            if (typeof(_loc_5.transition) == "string")
            {
                _loc_11 = _loc_5.transition.toLowerCase();
                _loc_8 = _transitionList[_loc_11];
            }
            else
            {
                _loc_8 = _loc_5.transition;
            }
            if (!Boolean(_loc_8))
            {
                _loc_8 = _transitionList["easeoutexpo"];
            }
            _loc_3 = 0;
            while (_loc_3 < _loc_4.length)
            {
                
                if (_loc_5.useFrames == true)
                {
                    _loc_9 = new TweenListObj(_loc_4[_loc_3], _currentTimeFrame + _loc_7 / _timeScale, _currentTimeFrame + (_loc_7 + _loc_6) / _timeScale, true, _loc_8, _loc_5.transitionParams);
                }
                else
                {
                    _loc_9 = new TweenListObj(_loc_4[_loc_3], _currentTime + _loc_7 * 1000 / _timeScale, _currentTime + (_loc_7 * 1000 + _loc_6 * 1000) / _timeScale, false, _loc_8, _loc_5.transitionParams);
                }
                _loc_9.properties = null;
                _loc_9.onStart = _loc_5.onStart;
                _loc_9.onUpdate = _loc_5.onUpdate;
                _loc_9.onComplete = _loc_5.onComplete;
                _loc_9.onOverwrite = _loc_5.onOverwrite;
                _loc_9.onStartParams = _loc_5.onStartParams;
                _loc_9.onUpdateParams = _loc_5.onUpdateParams;
                _loc_9.onCompleteParams = _loc_5.onCompleteParams;
                _loc_9.onOverwriteParams = _loc_5.onOverwriteParams;
                _loc_9.onStartScope = _loc_5.onStartScope;
                _loc_9.onUpdateScope = _loc_5.onUpdateScope;
                _loc_9.onCompleteScope = _loc_5.onCompleteScope;
                _loc_9.onOverwriteScope = _loc_5.onOverwriteScope;
                _loc_9.onErrorScope = _loc_5.onErrorScope;
                _loc_9.isCaller = true;
                _loc_9.count = _loc_5.count;
                _loc_9.waitFrames = _loc_5.waitFrames;
                _tweenList.push(_loc_9);
                if (_loc_6 == 0 && _loc_7 == 0)
                {
                    _loc_10 = _tweenList.length - 1;
                    updateTweenByIndex(_loc_10);
                    removeTweenByIndex(_loc_10);
                }
                _loc_3 = _loc_3 + 1;
            }
            return true;
        }// end function

        public static function removeTweensByTime(param1:Object, param2:Object, param3:Number, param4:Number) : Boolean
        {
            var removedLocally:Boolean;
            var i:uint;
            var pName:String;
            var eventScope:Object;
            var p_scope:* = param1;
            var p_properties:* = param2;
            var p_timeStart:* = param3;
            var p_timeComplete:* = param4;
            var removed:Boolean;
            var tl:* = _tweenList.length;
            i;
            while (i < tl)
            {
                
                if (Boolean(_tweenList[i]) && p_scope == _tweenList[i].scope)
                {
                    if (p_timeComplete > _tweenList[i].timeStart && p_timeStart < _tweenList[i].timeComplete)
                    {
                        removedLocally;
                        var _loc_6:int = 0;
                        var _loc_7:* = _tweenList[i].properties;
                        while (_loc_7 in _loc_6)
                        {
                            
                            pName = _loc_7[_loc_6];
                            if (Boolean(p_properties[pName]))
                            {
                                if (Boolean(_tweenList[i].onOverwrite))
                                {
                                    eventScope = Boolean(_tweenList[i].onOverwriteScope) ? (_tweenList[i].onOverwriteScope) : (_tweenList[i].scope);
                                    try
                                    {
                                        _tweenList[i].onOverwrite.apply(eventScope, _tweenList[i].onOverwriteParams);
                                    }
                                    catch (e:Error)
                                    {
                                        handleError(_tweenList[i], e, "onOverwrite");
                                    }
                                }
                                _tweenList[i].properties[pName] = undefined;
                                delete _tweenList[i].properties[pName];
                                removedLocally;
                                removed;
                            }
                        }
                        if (removedLocally)
                        {
                            if (AuxFunctions.getObjectLength(_tweenList[i].properties) == 0)
                            {
                                removeTweenByIndex(i);
                            }
                        }
                    }
                }
                i = (i + 1);
            }
            return removed;
        }// end function

        public static function removeTweens(param1:Object, ... args) : Boolean
        {
            var _loc_4:uint = 0;
            var _loc_5:SpecialPropertySplitter = null;
            var _loc_6:Array = null;
            var _loc_7:uint = 0;
            args = new Array();
            _loc_4 = 0;
            while (_loc_4 < args.length)
            {
                
                if (typeof(args[_loc_4]) == "string" && args.indexOf(args[_loc_4]) == -1)
                {
                    if (_specialPropertySplitterList[args[_loc_4]])
                    {
                        _loc_5 = _specialPropertySplitterList[args[_loc_4]];
                        _loc_6 = _loc_5.splitValues(param1, null);
                        _loc_7 = 0;
                        while (_loc_7 < _loc_6.length)
                        {
                            
                            args.push(_loc_6[_loc_7].name);
                            _loc_7 = _loc_7 + 1;
                        }
                    }
                    else
                    {
                        args.push(args[_loc_4]);
                    }
                }
                _loc_4 = _loc_4 + 1;
            }
            return affectTweens(removeTweenByIndex, param1, args);
        }// end function

        public static function removeAllTweens() : Boolean
        {
            var _loc_2:uint = 0;
            if (!Boolean(_tweenList))
            {
                return false;
            }
            var _loc_1:Boolean = false;
            _loc_2 = 0;
            while (_loc_2 < _tweenList.length)
            {
                
                removeTweenByIndex(_loc_2);
                _loc_1 = true;
                _loc_2 = _loc_2 + 1;
            }
            return _loc_1;
        }// end function

        public static function pauseTweens(param1:Object, ... args) : Boolean
        {
            var _loc_4:uint = 0;
            args = new Array();
            _loc_4 = 0;
            while (_loc_4 < args.length)
            {
                
                if (typeof(args[_loc_4]) == "string" && args.indexOf(args[_loc_4]) == -1)
                {
                    args.push(args[_loc_4]);
                }
                _loc_4 = _loc_4 + 1;
            }
            return affectTweens(pauseTweenByIndex, param1, args);
        }// end function

        public static function pauseAllTweens() : Boolean
        {
            var _loc_2:uint = 0;
            if (!Boolean(_tweenList))
            {
                return false;
            }
            var _loc_1:Boolean = false;
            _loc_2 = 0;
            while (_loc_2 < _tweenList.length)
            {
                
                pauseTweenByIndex(_loc_2);
                _loc_1 = true;
                _loc_2 = _loc_2 + 1;
            }
            return _loc_1;
        }// end function

        public static function resumeTweens(param1:Object, ... args) : Boolean
        {
            var _loc_4:uint = 0;
            args = new Array();
            _loc_4 = 0;
            while (_loc_4 < args.length)
            {
                
                if (typeof(args[_loc_4]) == "string" && args.indexOf(args[_loc_4]) == -1)
                {
                    args.push(args[_loc_4]);
                }
                _loc_4 = _loc_4 + 1;
            }
            return affectTweens(resumeTweenByIndex, param1, args);
        }// end function

        public static function resumeAllTweens() : Boolean
        {
            var _loc_2:uint = 0;
            if (!Boolean(_tweenList))
            {
                return false;
            }
            var _loc_1:Boolean = false;
            _loc_2 = 0;
            while (_loc_2 < _tweenList.length)
            {
                
                resumeTweenByIndex(_loc_2);
                _loc_1 = true;
                _loc_2 = _loc_2 + 1;
            }
            return _loc_1;
        }// end function

        private static function affectTweens(param1:Function, param2:Object, param3:Array) : Boolean
        {
            var _loc_5:uint = 0;
            var _loc_6:Array = null;
            var _loc_7:uint = 0;
            var _loc_8:uint = 0;
            var _loc_9:uint = 0;
            var _loc_4:Boolean = false;
            if (!Boolean(_tweenList))
            {
                return false;
            }
            _loc_5 = 0;
            while (_loc_5 < _tweenList.length)
            {
                
                if (_tweenList[_loc_5] && _tweenList[_loc_5].scope == param2)
                {
                    if (param3.length == 0)
                    {
                        Tweener.param1(_loc_5);
                        _loc_4 = true;
                    }
                    else
                    {
                        _loc_6 = new Array();
                        _loc_7 = 0;
                        while (_loc_7 < param3.length)
                        {
                            
                            if (Boolean(_tweenList[_loc_5].properties[param3[_loc_7]]))
                            {
                                _loc_6.push(param3[_loc_7]);
                            }
                            _loc_7 = _loc_7 + 1;
                        }
                        if (_loc_6.length > 0)
                        {
                            _loc_8 = AuxFunctions.getObjectLength(_tweenList[_loc_5].properties);
                            if (_loc_8 == _loc_6.length)
                            {
                                Tweener.param1(_loc_5);
                                _loc_4 = true;
                            }
                            else
                            {
                                _loc_9 = splitTweens(_loc_5, _loc_6);
                                Tweener.param1(_loc_9);
                                _loc_4 = true;
                            }
                        }
                    }
                }
                _loc_5 = _loc_5 + 1;
            }
            return _loc_4;
        }// end function

        public static function splitTweens(param1:Number, param2:Array) : uint
        {
            var _loc_5:uint = 0;
            var _loc_6:String = null;
            var _loc_7:Boolean = false;
            var _loc_3:* = _tweenList[param1];
            var _loc_4:* = _loc_3.clone(false);
            _loc_5 = 0;
            while (_loc_5 < param2.length)
            {
                
                _loc_6 = param2[_loc_5];
                if (Boolean(_loc_3.properties[_loc_6]))
                {
                    _loc_3.properties[_loc_6] = undefined;
                    delete _loc_3.properties[_loc_6];
                }
                _loc_5 = _loc_5 + 1;
            }
            for (_loc_6 in _loc_4.properties)
            {
                
                _loc_7 = false;
                _loc_5 = 0;
                while (_loc_5 < param2.length)
                {
                    
                    if (param2[_loc_5] == _loc_6)
                    {
                        _loc_7 = true;
                        break;
                    }
                    _loc_5 = _loc_5 + 1;
                }
                if (!_loc_7)
                {
                    _loc_4.properties[_loc_6] = undefined;
                    delete _loc_4.properties[_loc_6];
                }
            }
            _tweenList.push(_loc_4);
            return (_tweenList.length - 1);
        }// end function

        private static function updateTweens() : Boolean
        {
            var _loc_1:int = 0;
            if (_tweenList.length == 0)
            {
                return false;
            }
            _loc_1 = 0;
            while (_loc_1 < _tweenList.length)
            {
                
                if (_tweenList[_loc_1] == undefined || !_tweenList[_loc_1].isPaused)
                {
                    if (!updateTweenByIndex(_loc_1))
                    {
                        removeTweenByIndex(_loc_1);
                    }
                    if (_tweenList[_loc_1] == null)
                    {
                        removeTweenByIndex(_loc_1, true);
                        _loc_1 = _loc_1 - 1;
                    }
                }
                _loc_1++;
            }
            return true;
        }// end function

        public static function removeTweenByIndex(param1:Number, param2:Boolean = false) : Boolean
        {
            _tweenList[param1] = null;
            if (param2)
            {
                _tweenList.splice(param1, 1);
            }
            return true;
        }// end function

        public static function pauseTweenByIndex(param1:Number) : Boolean
        {
            var _loc_2:* = _tweenList[param1];
            if (_loc_2 == null || _loc_2.isPaused)
            {
                return false;
            }
            _loc_2.timePaused = getCurrentTweeningTime(_loc_2);
            _loc_2.isPaused = true;
            return true;
        }// end function

        public static function resumeTweenByIndex(param1:Number) : Boolean
        {
            var _loc_2:* = _tweenList[param1];
            if (_loc_2 == null || !_loc_2.isPaused)
            {
                return false;
            }
            var _loc_3:* = getCurrentTweeningTime(_loc_2);
            _loc_2.timeStart = _loc_2.timeStart + (_loc_3 - _loc_2.timePaused);
            _loc_2.timeComplete = _loc_2.timeComplete + (_loc_3 - _loc_2.timePaused);
            _loc_2.timePaused = undefined;
            _loc_2.isPaused = false;
            return true;
        }// end function

        private static function updateTweenByIndex(param1:Number) : Boolean
        {
            var tTweening:TweenListObj;
            var mustUpdate:Boolean;
            var nv:Number;
            var t:Number;
            var b:Number;
            var c:Number;
            var d:Number;
            var pName:String;
            var eventScope:Object;
            var tScope:Object;
            var tProperty:Object;
            var pv:Number;
            var i:* = param1;
            tTweening = _tweenList[i];
            if (tTweening == null || !Boolean(tTweening.scope))
            {
                return false;
            }
            var isOver:Boolean;
            var cTime:* = getCurrentTweeningTime(tTweening);
            if (cTime >= tTweening.timeStart)
            {
                tScope = tTweening.scope;
                if (tTweening.isCaller)
                {
                    if (!tTweening.hasStarted)
                    {
                        if (Boolean(tTweening.onStart))
                        {
                            eventScope = Boolean(tTweening.onStartScope) ? (tTweening.onStartScope) : (tScope);
                            try
                            {
                                tTweening.onStart.apply(eventScope, tTweening.onStartParams);
                            }
                            catch (e2:Error)
                            {
                                handleError(tTweening, e2, "onStart");
                            }
                        }
                        tTweening.hasStarted = true;
                    }
                    do
                    {
                        
                        t = (tTweening.timeComplete - tTweening.timeStart) / tTweening.count * (tTweening.timesCalled + 1);
                        b = tTweening.timeStart;
                        c = tTweening.timeComplete - tTweening.timeStart;
                        d = tTweening.timeComplete - tTweening.timeStart;
                        nv = tTweening.transition(t, b, c, d);
                        if (cTime >= nv)
                        {
                            if (Boolean(tTweening.onUpdate))
                            {
                                eventScope = Boolean(tTweening.onUpdateScope) ? (tTweening.onUpdateScope) : (tScope);
                                try
                                {
                                    tTweening.onUpdate.apply(eventScope, tTweening.onUpdateParams);
                                }
                                catch (e1:Error)
                                {
                                    handleError(tTweening, e1, "onUpdate");
                                }
                            }
                            var _loc_3:* = tTweening;
                            var _loc_4:* = tTweening.timesCalled + 1;
                            _loc_3.timesCalled = _loc_4;
                            if (tTweening.timesCalled >= tTweening.count)
                            {
                                isOver;
                                break;
                            }
                            if (tTweening.waitFrames)
                            {
                                break;
                            }
                        }
                    }while (cTime >= nv)
                }
                else
                {
                    mustUpdate = tTweening.skipUpdates < 1 || !tTweening.skipUpdates || tTweening.updatesSkipped >= tTweening.skipUpdates;
                    if (cTime >= tTweening.timeComplete)
                    {
                        isOver;
                        mustUpdate;
                    }
                    if (!tTweening.hasStarted)
                    {
                        if (Boolean(tTweening.onStart))
                        {
                            eventScope = Boolean(tTweening.onStartScope) ? (tTweening.onStartScope) : (tScope);
                            try
                            {
                                tTweening.onStart.apply(eventScope, tTweening.onStartParams);
                            }
                            catch (e2:Error)
                            {
                                handleError(tTweening, e2, "onStart");
                            }
                        }
                        var _loc_3:int = 0;
                        var _loc_4:* = tTweening.properties;
                        while (_loc_4 in _loc_3)
                        {
                            
                            pName = _loc_4[_loc_3];
                            if (tTweening.properties[pName].isSpecialProperty)
                            {
                                if (Boolean(_specialPropertyList[pName].preProcess))
                                {
                                    tTweening.properties[pName].valueComplete = _specialPropertyList[pName].preProcess(tScope, _specialPropertyList[pName].parameters, tTweening.properties[pName].originalValueComplete, tTweening.properties[pName].extra);
                                }
                                pv = _specialPropertyList[pName].getValue(tScope, _specialPropertyList[pName].parameters, tTweening.properties[pName].extra);
                            }
                            else
                            {
                                pv = tScope[pName];
                            }
                            tTweening.properties[pName].valueStart = isNaN(pv) ? (tTweening.properties[pName].valueComplete) : (pv);
                        }
                        mustUpdate;
                        tTweening.hasStarted = true;
                    }
                    if (mustUpdate)
                    {
                        var _loc_3:int = 0;
                        var _loc_4:* = tTweening.properties;
                        while (_loc_4 in _loc_3)
                        {
                            
                            pName = _loc_4[_loc_3];
                            tProperty = tTweening.properties[pName];
                            if (isOver)
                            {
                                nv = tProperty.valueComplete;
                            }
                            else if (tProperty.hasModifier)
                            {
                                t = cTime - tTweening.timeStart;
                                d = tTweening.timeComplete - tTweening.timeStart;
                                nv = tTweening.transition(t, 0, 1, d, tTweening.transitionParams);
                                nv = tProperty.modifierFunction(tProperty.valueStart, tProperty.valueComplete, nv, tProperty.modifierParameters);
                            }
                            else
                            {
                                t = cTime - tTweening.timeStart;
                                b = tProperty.valueStart;
                                c = tProperty.valueComplete - tProperty.valueStart;
                                d = tTweening.timeComplete - tTweening.timeStart;
                                nv = tTweening.transition(t, b, c, d, tTweening.transitionParams);
                            }
                            if (tTweening.rounded)
                            {
                                nv = Math.round(nv);
                            }
                            if (tProperty.isSpecialProperty)
                            {
                                _specialPropertyList[pName].setValue(tScope, nv, _specialPropertyList[pName].parameters, tTweening.properties[pName].extra);
                                continue;
                            }
                            tScope[pName] = nv;
                        }
                        tTweening.updatesSkipped = 0;
                        if (Boolean(tTweening.onUpdate))
                        {
                            eventScope = Boolean(tTweening.onUpdateScope) ? (tTweening.onUpdateScope) : (tScope);
                            try
                            {
                                tTweening.onUpdate.apply(eventScope, tTweening.onUpdateParams);
                            }
                            catch (e3:Error)
                            {
                                handleError(tTweening, e3, "onUpdate");
                            }
                        }
                    }
                    else
                    {
                        var _loc_3:* = tTweening;
                        var _loc_4:* = tTweening.updatesSkipped + 1;
                        _loc_3.updatesSkipped = _loc_4;
                    }
                }
                if (isOver && Boolean(tTweening.onComplete))
                {
                    eventScope = Boolean(tTweening.onCompleteScope) ? (tTweening.onCompleteScope) : (tScope);
                    try
                    {
                        tTweening.onComplete.apply(eventScope, tTweening.onCompleteParams);
                    }
                    catch (e4:Error)
                    {
                        handleError(tTweening, e4, "onComplete");
                    }
                }
                return !isOver;
            }
            return true;
        }// end function

        public static function init(... args) : void
        {
            _inited = true;
            _transitionList = new Object();
            Equations.init();
            _specialPropertyList = new Object();
            _specialPropertyModifierList = new Object();
            _specialPropertySplitterList = new Object();
            return;
        }// end function

        public static function registerTransition(param1:String, param2:Function) : void
        {
            if (!_inited)
            {
                init();
            }
            _transitionList[param1] = param2;
            return;
        }// end function

        public static function registerSpecialProperty(param1:String, param2:Function, param3:Function, param4:Array = null, param5:Function = null) : void
        {
            if (!_inited)
            {
                init();
            }
            var _loc_6:* = new SpecialProperty(param2, param3, param4, param5);
            _specialPropertyList[param1] = _loc_6;
            return;
        }// end function

        public static function registerSpecialPropertyModifier(param1:String, param2:Function, param3:Function) : void
        {
            if (!_inited)
            {
                init();
            }
            var _loc_4:* = new SpecialPropertyModifier(param2, param3);
            _specialPropertyModifierList[param1] = _loc_4;
            return;
        }// end function

        public static function registerSpecialPropertySplitter(param1:String, param2:Function, param3:Array = null) : void
        {
            if (!_inited)
            {
                init();
            }
            var _loc_4:* = new SpecialPropertySplitter(param2, param3);
            _specialPropertySplitterList[param1] = _loc_4;
            return;
        }// end function

        private static function startEngine() : void
        {
            _engineExists = true;
            _tweenList = new Array();
            __tweener_controller__ = new MovieClip();
            __tweener_controller__.addEventListener(Event.ENTER_FRAME, Tweener.onEnterFrame);
            _currentTimeFrame = 0;
            updateTime();
            return;
        }// end function

        private static function stopEngine() : void
        {
            _engineExists = false;
            _tweenList = null;
            _currentTime = 0;
            _currentTimeFrame = 0;
            __tweener_controller__.removeEventListener(Event.ENTER_FRAME, Tweener.onEnterFrame);
            __tweener_controller__ = null;
            return;
        }// end function

        public static function updateTime() : void
        {
            _currentTime = getTimer();
            return;
        }// end function

        public static function updateFrame() : void
        {
            var _loc_2:* = _currentTimeFrame + 1;
            _currentTimeFrame = _loc_2;
            return;
        }// end function

        public static function onEnterFrame(event:Event) : void
        {
            updateTime();
            updateFrame();
            var _loc_2:Boolean = false;
            _loc_2 = updateTweens();
            if (!_loc_2)
            {
                stopEngine();
            }
            return;
        }// end function

        public static function setTimeScale(param1:Number) : void
        {
            var _loc_2:Number = NaN;
            var _loc_3:Number = NaN;
            if (isNaN(param1))
            {
                param1 = 1;
            }
            if (param1 < 1e-005)
            {
                param1 = 1e-005;
            }
            if (param1 != _timeScale)
            {
                if (_tweenList != null)
                {
                    _loc_2 = 0;
                    while (_loc_2 < _tweenList.length)
                    {
                        
                        _loc_3 = getCurrentTweeningTime(_tweenList[_loc_2]);
                        _tweenList[_loc_2].timeStart = _loc_3 - (_loc_3 - _tweenList[_loc_2].timeStart) * _timeScale / param1;
                        _tweenList[_loc_2].timeComplete = _loc_3 - (_loc_3 - _tweenList[_loc_2].timeComplete) * _timeScale / param1;
                        if (_tweenList[_loc_2].timePaused != undefined)
                        {
                            _tweenList[_loc_2].timePaused = _loc_3 - (_loc_3 - _tweenList[_loc_2].timePaused) * _timeScale / param1;
                        }
                        _loc_2 = _loc_2 + 1;
                    }
                }
                _timeScale = param1;
            }
            return;
        }// end function

        public static function isTweening(param1:Object) : Boolean
        {
            var _loc_2:uint = 0;
            if (!Boolean(_tweenList))
            {
                return false;
            }
            _loc_2 = 0;
            while (_loc_2 < _tweenList.length)
            {
                
                if (Boolean(_tweenList[_loc_2]) && _tweenList[_loc_2].scope == param1)
                {
                    return true;
                }
                _loc_2 = _loc_2 + 1;
            }
            return false;
        }// end function

        public static function getTweens(param1:Object) : Array
        {
            var _loc_2:uint = 0;
            var _loc_3:String = null;
            if (!Boolean(_tweenList))
            {
                return [];
            }
            var _loc_4:* = new Array();
            _loc_2 = 0;
            while (_loc_2 < _tweenList.length)
            {
                
                if (Boolean(_tweenList[_loc_2]) && _tweenList[_loc_2].scope == param1)
                {
                    for (_loc_3 in _tweenList[_loc_2].properties)
                    {
                        
                        _loc_4.push(_loc_3);
                    }
                }
                _loc_2 = _loc_2 + 1;
            }
            return _loc_4;
        }// end function

        public static function getTweenCount(param1:Object) : Number
        {
            var _loc_2:uint = 0;
            if (!Boolean(_tweenList))
            {
                return 0;
            }
            var _loc_3:Number = 0;
            _loc_2 = 0;
            while (_loc_2 < _tweenList.length)
            {
                
                if (Boolean(_tweenList[_loc_2]) && _tweenList[_loc_2].scope == param1)
                {
                    _loc_3 = _loc_3 + AuxFunctions.getObjectLength(_tweenList[_loc_2].properties);
                }
                _loc_2 = _loc_2 + 1;
            }
            return _loc_3;
        }// end function

        private static function handleError(param1:TweenListObj, param2:Error, param3:String) : void
        {
            var eventScope:Object;
            var pTweening:* = param1;
            var pError:* = param2;
            var pCallBackName:* = param3;
            if (Boolean(pTweening.onError) && pTweening.onError is Function)
            {
                eventScope = Boolean(pTweening.onErrorScope) ? (pTweening.onErrorScope) : (pTweening.scope);
                try
                {
                    pTweening.onError.apply(eventScope, [pTweening.scope, pError]);
                }
                catch (metaError:Error)
                {
                    printError(String(pTweening.scope) + " raised an error while executing the \'onError\' handler. Original error:\n " + pError.getStackTrace() + "\nonError error: " + metaError.getStackTrace());
                }
            }
            else if (!Boolean(pTweening.onError))
            {
                printError(String(pTweening.scope) + " raised an error while executing the \'" + pCallBackName + "\'handler. \n" + pError.getStackTrace());
            }
            return;
        }// end function

        public static function getCurrentTweeningTime(param1:Object) : Number
        {
            return param1.useFrames ? (_currentTimeFrame) : (_currentTime);
        }// end function

        public static function getVersion() : String
        {
            return "AS3 1.33.74";
        }// end function

        public static function printError(param1:String) : void
        {
            return;
        }// end function

    }
}
