package caurina.transitions
{
   import flash.display.*;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class Tweener
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
       
      
      public function Tweener()
      {
         super();
         trace("Tweener is a static class and should not be instantiated.");
      }
      
      public static function addTween(param1:Object = null, param2:Object = null) : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc13_:Function = null;
         var _loc14_:Object = null;
         var _loc15_:TweenListObj = null;
         var _loc16_:Number = NaN;
         var _loc17_:Array = null;
         var _loc18_:Array = null;
         var _loc19_:Array = null;
         var _loc20_:String = null;
         if(!Boolean(param1))
         {
            return false;
         }
         if(param1 is Array)
         {
            _loc6_ = param1.concat();
         }
         else
         {
            _loc6_ = [param1];
         }
         var _loc7_:Object = TweenListObj.makePropertiesChain(param2);
         if(!_inited)
         {
            init();
         }
         if(!_engineExists || !Boolean(__tweener_controller__))
         {
            startEngine();
         }
         var _loc8_:Number = isNaN(_loc7_.time) ? 0 : Number(_loc7_.time);
         var _loc9_:Number = isNaN(_loc7_.delay) ? 0 : Number(_loc7_.delay);
         var _loc10_:Array = new Array();
         var _loc11_:Object = {
            "time":true,
            "delay":true,
            "useFrames":true,
            "skipUpdates":true,
            "transition":true,
            "transitionParams":true,
            "onStart":true,
            "onUpdate":true,
            "onComplete":true,
            "onOverwrite":true,
            "onError":true,
            "rounded":true,
            "onStartParams":true,
            "onUpdateParams":true,
            "onCompleteParams":true,
            "onOverwriteParams":true,
            "onStartScope":true,
            "onUpdateScope":true,
            "onCompleteScope":true,
            "onOverwriteScope":true,
            "onErrorScope":true
         };
         var _loc12_:Object = new Object();
         for(_loc5_ in _loc7_)
         {
            if(!_loc11_[_loc5_])
            {
               if(_specialPropertySplitterList[_loc5_])
               {
                  _loc17_ = _specialPropertySplitterList[_loc5_].splitValues(_loc7_[_loc5_],_specialPropertySplitterList[_loc5_].parameters);
                  _loc3_ = 0;
                  while(_loc3_ < _loc17_.length)
                  {
                     if(_specialPropertySplitterList[_loc17_[_loc3_].name])
                     {
                        _loc18_ = _specialPropertySplitterList[_loc17_[_loc3_].name].splitValues(_loc17_[_loc3_].value,_specialPropertySplitterList[_loc17_[_loc3_].name].parameters);
                        _loc4_ = 0;
                        while(_loc4_ < _loc18_.length)
                        {
                           _loc10_[_loc18_[_loc4_].name] = {
                              "valueStart":undefined,
                              "valueComplete":_loc18_[_loc4_].value,
                              "arrayIndex":_loc18_[_loc4_].arrayIndex,
                              "isSpecialProperty":false
                           };
                           _loc4_++;
                        }
                     }
                     else
                     {
                        _loc10_[_loc17_[_loc3_].name] = {
                           "valueStart":undefined,
                           "valueComplete":_loc17_[_loc3_].value,
                           "arrayIndex":_loc17_[_loc3_].arrayIndex,
                           "isSpecialProperty":false
                        };
                     }
                     _loc3_++;
                  }
               }
               else if(_specialPropertyModifierList[_loc5_] != undefined)
               {
                  _loc19_ = _specialPropertyModifierList[_loc5_].modifyValues(_loc7_[_loc5_]);
                  _loc3_ = 0;
                  while(_loc3_ < _loc19_.length)
                  {
                     _loc12_[_loc19_[_loc3_].name] = {
                        "modifierParameters":_loc19_[_loc3_].parameters,
                        "modifierFunction":_specialPropertyModifierList[_loc5_].getValue
                     };
                     _loc3_++;
                  }
               }
               else
               {
                  _loc10_[_loc5_] = {
                     "valueStart":undefined,
                     "valueComplete":_loc7_[_loc5_]
                  };
               }
            }
         }
         for(_loc5_ in _loc10_)
         {
            if(_specialPropertyList[_loc5_] != undefined)
            {
               _loc10_[_loc5_].isSpecialProperty = true;
            }
            else if(_loc6_[0][_loc5_] == undefined)
            {
               printError("The property \'" + _loc5_ + "\' doesn\'t seem to be a normal object property of " + String(_loc6_[0]) + " or a registered special property.");
            }
         }
         for(_loc5_ in _loc12_)
         {
            if(_loc10_[_loc5_] != undefined)
            {
               _loc10_[_loc5_].modifierParameters = _loc12_[_loc5_].modifierParameters;
               _loc10_[_loc5_].modifierFunction = _loc12_[_loc5_].modifierFunction;
            }
         }
         if(typeof _loc7_.transition == "string")
         {
            _loc20_ = String(_loc7_.transition.toLowerCase());
            _loc13_ = _transitionList[_loc20_];
         }
         else
         {
            _loc13_ = _loc7_.transition;
         }
         if(!Boolean(_loc13_))
         {
            _loc13_ = _transitionList["easeoutexpo"];
         }
         _loc3_ = 0;
         while(_loc3_ < _loc6_.length)
         {
            _loc14_ = new Object();
            for(_loc5_ in _loc10_)
            {
               _loc14_[_loc5_] = new PropertyInfoObj(_loc10_[_loc5_].valueStart,_loc10_[_loc5_].valueComplete,_loc10_[_loc5_].valueComplete,_loc10_[_loc5_].arrayIndex,{},_loc10_[_loc5_].isSpecialProperty,_loc10_[_loc5_].modifierFunction,_loc10_[_loc5_].modifierParameters);
            }
            if(_loc7_.useFrames == true)
            {
               _loc15_ = new TweenListObj(_loc6_[_loc3_],_currentTimeFrame + _loc9_ / _timeScale,_currentTimeFrame + (_loc9_ + _loc8_) / _timeScale,true,_loc13_,_loc7_.transitionParams);
            }
            else
            {
               _loc15_ = new TweenListObj(_loc6_[_loc3_],_currentTime + _loc9_ * 1000 / _timeScale,_currentTime + (_loc9_ * 1000 + _loc8_ * 1000) / _timeScale,false,_loc13_,_loc7_.transitionParams);
            }
            _loc15_.properties = _loc14_;
            _loc15_.onStart = _loc7_.onStart;
            _loc15_.onUpdate = _loc7_.onUpdate;
            _loc15_.onComplete = _loc7_.onComplete;
            _loc15_.onOverwrite = _loc7_.onOverwrite;
            _loc15_.onError = _loc7_.onError;
            _loc15_.onStartParams = _loc7_.onStartParams;
            _loc15_.onUpdateParams = _loc7_.onUpdateParams;
            _loc15_.onCompleteParams = _loc7_.onCompleteParams;
            _loc15_.onOverwriteParams = _loc7_.onOverwriteParams;
            _loc15_.onStartScope = _loc7_.onStartScope;
            _loc15_.onUpdateScope = _loc7_.onUpdateScope;
            _loc15_.onCompleteScope = _loc7_.onCompleteScope;
            _loc15_.onOverwriteScope = _loc7_.onOverwriteScope;
            _loc15_.onErrorScope = _loc7_.onErrorScope;
            _loc15_.rounded = _loc7_.rounded;
            _loc15_.skipUpdates = _loc7_.skipUpdates;
            removeTweensByTime(_loc15_.scope,_loc15_.properties,_loc15_.timeStart,_loc15_.timeComplete);
            _tweenList.push(_loc15_);
            if(_loc8_ == 0 && _loc9_ == 0)
            {
               _loc16_ = _tweenList.length - 1;
               updateTweenByIndex(_loc16_);
               removeTweenByIndex(_loc16_);
            }
            _loc3_++;
         }
         return true;
      }
      
      public static function addCaller(param1:Object = null, param2:Object = null) : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc4_:Array = null;
         var _loc8_:Function = null;
         var _loc9_:TweenListObj = null;
         var _loc10_:Number = NaN;
         var _loc11_:String = null;
         if(!Boolean(param1))
         {
            return false;
         }
         if(param1 is Array)
         {
            _loc4_ = param1.concat();
         }
         else
         {
            _loc4_ = [param1];
         }
         var _loc5_:Object = param2;
         if(!_inited)
         {
            init();
         }
         if(!_engineExists || !Boolean(__tweener_controller__))
         {
            startEngine();
         }
         var _loc6_:Number = isNaN(_loc5_.time) ? 0 : Number(_loc5_.time);
         var _loc7_:Number = isNaN(_loc5_.delay) ? 0 : Number(_loc5_.delay);
         if(typeof _loc5_.transition == "string")
         {
            _loc11_ = String(_loc5_.transition.toLowerCase());
            _loc8_ = _transitionList[_loc11_];
         }
         else
         {
            _loc8_ = _loc5_.transition;
         }
         if(!Boolean(_loc8_))
         {
            _loc8_ = _transitionList["easeoutexpo"];
         }
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            if(_loc5_.useFrames == true)
            {
               _loc9_ = new TweenListObj(_loc4_[_loc3_],_currentTimeFrame + _loc7_ / _timeScale,_currentTimeFrame + (_loc7_ + _loc6_) / _timeScale,true,_loc8_,_loc5_.transitionParams);
            }
            else
            {
               _loc9_ = new TweenListObj(_loc4_[_loc3_],_currentTime + _loc7_ * 1000 / _timeScale,_currentTime + (_loc7_ * 1000 + _loc6_ * 1000) / _timeScale,false,_loc8_,_loc5_.transitionParams);
            }
            _loc9_.properties = null;
            _loc9_.onStart = _loc5_.onStart;
            _loc9_.onUpdate = _loc5_.onUpdate;
            _loc9_.onComplete = _loc5_.onComplete;
            _loc9_.onOverwrite = _loc5_.onOverwrite;
            _loc9_.onStartParams = _loc5_.onStartParams;
            _loc9_.onUpdateParams = _loc5_.onUpdateParams;
            _loc9_.onCompleteParams = _loc5_.onCompleteParams;
            _loc9_.onOverwriteParams = _loc5_.onOverwriteParams;
            _loc9_.onStartScope = _loc5_.onStartScope;
            _loc9_.onUpdateScope = _loc5_.onUpdateScope;
            _loc9_.onCompleteScope = _loc5_.onCompleteScope;
            _loc9_.onOverwriteScope = _loc5_.onOverwriteScope;
            _loc9_.onErrorScope = _loc5_.onErrorScope;
            _loc9_.isCaller = true;
            _loc9_.count = _loc5_.count;
            _loc9_.waitFrames = _loc5_.waitFrames;
            _tweenList.push(_loc9_);
            if(_loc6_ == 0 && _loc7_ == 0)
            {
               _loc10_ = _tweenList.length - 1;
               updateTweenByIndex(_loc10_);
               removeTweenByIndex(_loc10_);
            }
            _loc3_++;
         }
         return true;
      }
      
      public static function removeTweensByTime(param1:Object, param2:Object, param3:Number, param4:Number) : Boolean
      {
         var removedLocally:Boolean = false;
         var i:uint = 0;
         var pName:String = null;
         var eventScope:Object = null;
         var p_scope:Object = param1;
         var p_properties:Object = param2;
         var p_timeStart:Number = param3;
         var p_timeComplete:Number = param4;
         var removed:Boolean = false;
         var tl:uint = _tweenList.length;
         i = 0;
         while(i < tl)
         {
            if(Boolean(_tweenList[i]) && p_scope == _tweenList[i].scope)
            {
               if(p_timeComplete > _tweenList[i].timeStart && p_timeStart < _tweenList[i].timeComplete)
               {
                  removedLocally = false;
                  for(pName in _tweenList[i].properties)
                  {
                     if(Boolean(p_properties[pName]))
                     {
                        if(Boolean(_tweenList[i].onOverwrite))
                        {
                           eventScope = Boolean(_tweenList[i].onOverwriteScope) ? _tweenList[i].onOverwriteScope : _tweenList[i].scope;
                           try
                           {
                              _tweenList[i].onOverwrite.apply(eventScope,_tweenList[i].onOverwriteParams);
                           }
                           catch(e:Error)
                           {
                              handleError(_tweenList[i],e,"onOverwrite");
                           }
                        }
                        _tweenList[i].properties[pName] = undefined;
                        delete _tweenList[i].properties[pName];
                        removedLocally = true;
                        removed = true;
                     }
                  }
                  if(removedLocally)
                  {
                     if(AuxFunctions.getObjectLength(_tweenList[i].properties) == 0)
                     {
                        removeTweenByIndex(i);
                     }
                  }
               }
            }
            i++;
         }
         return removed;
      }
      
      public static function removeTweens(param1:Object, ... rest) : Boolean
      {
         var _loc4_:uint = 0;
         var _loc5_:SpecialPropertySplitter = null;
         var _loc6_:Array = null;
         var _loc7_:uint = 0;
         var _loc3_:Array = new Array();
         _loc4_ = 0;
         while(_loc4_ < rest.length)
         {
            if(typeof rest[_loc4_] == "string" && _loc3_.indexOf(rest[_loc4_]) == -1)
            {
               if(_specialPropertySplitterList[rest[_loc4_]])
               {
                  _loc6_ = (_loc5_ = _specialPropertySplitterList[rest[_loc4_]]).splitValues(param1,null);
                  _loc7_ = 0;
                  while(_loc7_ < _loc6_.length)
                  {
                     _loc3_.push(_loc6_[_loc7_].name);
                     _loc7_++;
                  }
               }
               else
               {
                  _loc3_.push(rest[_loc4_]);
               }
            }
            _loc4_++;
         }
         return affectTweens(removeTweenByIndex,param1,_loc3_);
      }
      
      public static function removeAllTweens() : Boolean
      {
         var _loc2_:uint = 0;
         if(!Boolean(_tweenList))
         {
            return false;
         }
         var _loc1_:Boolean = false;
         _loc2_ = 0;
         while(_loc2_ < _tweenList.length)
         {
            removeTweenByIndex(_loc2_);
            _loc1_ = true;
            _loc2_++;
         }
         return _loc1_;
      }
      
      public static function pauseTweens(param1:Object, ... rest) : Boolean
      {
         var _loc4_:uint = 0;
         var _loc3_:Array = new Array();
         _loc4_ = 0;
         while(_loc4_ < rest.length)
         {
            if(typeof rest[_loc4_] == "string" && _loc3_.indexOf(rest[_loc4_]) == -1)
            {
               _loc3_.push(rest[_loc4_]);
            }
            _loc4_++;
         }
         return affectTweens(pauseTweenByIndex,param1,_loc3_);
      }
      
      public static function pauseAllTweens() : Boolean
      {
         var _loc2_:uint = 0;
         if(!Boolean(_tweenList))
         {
            return false;
         }
         var _loc1_:Boolean = false;
         _loc2_ = 0;
         while(_loc2_ < _tweenList.length)
         {
            pauseTweenByIndex(_loc2_);
            _loc1_ = true;
            _loc2_++;
         }
         return _loc1_;
      }
      
      public static function resumeTweens(param1:Object, ... rest) : Boolean
      {
         var _loc4_:uint = 0;
         var _loc3_:Array = new Array();
         _loc4_ = 0;
         while(_loc4_ < rest.length)
         {
            if(typeof rest[_loc4_] == "string" && _loc3_.indexOf(rest[_loc4_]) == -1)
            {
               _loc3_.push(rest[_loc4_]);
            }
            _loc4_++;
         }
         return affectTweens(resumeTweenByIndex,param1,_loc3_);
      }
      
      public static function resumeAllTweens() : Boolean
      {
         var _loc2_:uint = 0;
         if(!Boolean(_tweenList))
         {
            return false;
         }
         var _loc1_:Boolean = false;
         _loc2_ = 0;
         while(_loc2_ < _tweenList.length)
         {
            resumeTweenByIndex(_loc2_);
            _loc1_ = true;
            _loc2_++;
         }
         return _loc1_;
      }
      
      private static function affectTweens(param1:Function, param2:Object, param3:Array) : Boolean
      {
         var _loc5_:uint = 0;
         var _loc6_:Array = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:Boolean = false;
         if(!Boolean(_tweenList))
         {
            return false;
         }
         _loc5_ = 0;
         while(_loc5_ < _tweenList.length)
         {
            if(Boolean(_tweenList[_loc5_]) && _tweenList[_loc5_].scope == param2)
            {
               if(param3.length == 0)
               {
                  param1(_loc5_);
                  _loc4_ = true;
               }
               else
               {
                  _loc6_ = new Array();
                  _loc7_ = 0;
                  while(_loc7_ < param3.length)
                  {
                     if(Boolean(_tweenList[_loc5_].properties[param3[_loc7_]]))
                     {
                        _loc6_.push(param3[_loc7_]);
                     }
                     _loc7_++;
                  }
                  if(_loc6_.length > 0)
                  {
                     if((_loc8_ = AuxFunctions.getObjectLength(_tweenList[_loc5_].properties)) == _loc6_.length)
                     {
                        param1(_loc5_);
                        _loc4_ = true;
                     }
                     else
                     {
                        _loc9_ = splitTweens(_loc5_,_loc6_);
                        param1(_loc9_);
                        _loc4_ = true;
                     }
                  }
               }
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      public static function splitTweens(param1:Number, param2:Array) : uint
      {
         var _loc5_:uint = 0;
         var _loc6_:String = null;
         var _loc7_:Boolean = false;
         var _loc3_:TweenListObj = _tweenList[param1];
         var _loc4_:TweenListObj = _loc3_.clone(false);
         _loc5_ = 0;
         while(_loc5_ < param2.length)
         {
            _loc6_ = String(param2[_loc5_]);
            if(Boolean(_loc3_.properties[_loc6_]))
            {
               _loc3_.properties[_loc6_] = undefined;
               delete _loc3_.properties[_loc6_];
            }
            _loc5_++;
         }
         for(_loc6_ in _loc4_.properties)
         {
            _loc7_ = false;
            _loc5_ = 0;
            while(_loc5_ < param2.length)
            {
               if(param2[_loc5_] == _loc6_)
               {
                  _loc7_ = true;
                  break;
               }
               _loc5_++;
            }
            if(!_loc7_)
            {
               _loc4_.properties[_loc6_] = undefined;
               delete _loc4_.properties[_loc6_];
            }
         }
         _tweenList.push(_loc4_);
         return _tweenList.length - 1;
      }
      
      private static function updateTweens() : Boolean
      {
         var _loc1_:int = 0;
         if(_tweenList.length == 0)
         {
            return false;
         }
         _loc1_ = 0;
         while(_loc1_ < _tweenList.length)
         {
            if(_tweenList[_loc1_] == undefined || !_tweenList[_loc1_].isPaused)
            {
               if(!updateTweenByIndex(_loc1_))
               {
                  removeTweenByIndex(_loc1_);
               }
               if(_tweenList[_loc1_] == null)
               {
                  removeTweenByIndex(_loc1_,true);
                  _loc1_--;
               }
            }
            _loc1_++;
         }
         return true;
      }
      
      public static function removeTweenByIndex(param1:Number, param2:Boolean = false) : Boolean
      {
         _tweenList[param1] = null;
         if(param2)
         {
            _tweenList.splice(param1,1);
         }
         return true;
      }
      
      public static function pauseTweenByIndex(param1:Number) : Boolean
      {
         var _loc2_:TweenListObj = _tweenList[param1];
         if(_loc2_ == null || _loc2_.isPaused)
         {
            return false;
         }
         _loc2_.timePaused = getCurrentTweeningTime(_loc2_);
         _loc2_.isPaused = true;
         return true;
      }
      
      public static function resumeTweenByIndex(param1:Number) : Boolean
      {
         var _loc2_:TweenListObj = _tweenList[param1];
         if(_loc2_ == null || !_loc2_.isPaused)
         {
            return false;
         }
         var _loc3_:Number = getCurrentTweeningTime(_loc2_);
         _loc2_.timeStart += _loc3_ - _loc2_.timePaused;
         _loc2_.timeComplete += _loc3_ - _loc2_.timePaused;
         _loc2_.timePaused = undefined;
         _loc2_.isPaused = false;
         return true;
      }
      
      private static function updateTweenByIndex(param1:Number) : Boolean
      {
         var isOver:Boolean;
         var cTime:Number;
         var tTweening:TweenListObj = null;
         var mustUpdate:Boolean = false;
         var nv:Number = NaN;
         var t:Number = NaN;
         var b:Number = NaN;
         var c:Number = NaN;
         var d:Number = NaN;
         var pName:String = null;
         var eventScope:Object = null;
         var tScope:Object = null;
         var tProperty:Object = null;
         var pv:Number = NaN;
         var i:Number = param1;
         tTweening = _tweenList[i];
         if(tTweening == null || !Boolean(tTweening.scope))
         {
            return false;
         }
         isOver = false;
         cTime = getCurrentTweeningTime(tTweening);
         if(cTime >= tTweening.timeStart)
         {
            tScope = tTweening.scope;
            if(tTweening.isCaller)
            {
               do
               {
                  t = (tTweening.timeComplete - tTweening.timeStart) / tTweening.count * (tTweening.timesCalled + 1);
                  b = tTweening.timeStart;
                  c = tTweening.timeComplete - tTweening.timeStart;
                  d = tTweening.timeComplete - tTweening.timeStart;
                  nv = tTweening.transition(t,b,c,d);
                  if(cTime >= nv)
                  {
                     if(Boolean(tTweening.onUpdate))
                     {
                        eventScope = Boolean(tTweening.onUpdateScope) ? tTweening.onUpdateScope : tScope;
                        try
                        {
                           tTweening.onUpdate.apply(eventScope,tTweening.onUpdateParams);
                        }
                        catch(e1:Error)
                        {
                           handleError(tTweening,e1,"onUpdate");
                        }
                     }
                     ++tTweening.timesCalled;
                     if(tTweening.timesCalled >= tTweening.count)
                     {
                        isOver = true;
                        break;
                     }
                     if(tTweening.waitFrames)
                     {
                        break;
                     }
                  }
               }
               while(cTime >= nv);
               
            }
            else
            {
               mustUpdate = tTweening.skipUpdates < 1 || !tTweening.skipUpdates || tTweening.updatesSkipped >= tTweening.skipUpdates;
               if(cTime >= tTweening.timeComplete)
               {
                  isOver = true;
                  mustUpdate = true;
               }
               if(!tTweening.hasStarted)
               {
                  if(Boolean(tTweening.onStart))
                  {
                     eventScope = Boolean(tTweening.onStartScope) ? tTweening.onStartScope : tScope;
                     try
                     {
                        tTweening.onStart.apply(eventScope,tTweening.onStartParams);
                     }
                     catch(e2:Error)
                     {
                        handleError(tTweening,e2,"onStart");
                     }
                  }
                  for(pName in tTweening.properties)
                  {
                     if(tTweening.properties[pName].isSpecialProperty)
                     {
                        if(Boolean(_specialPropertyList[pName].preProcess))
                        {
                           tTweening.properties[pName].valueComplete = _specialPropertyList[pName].preProcess(tScope,_specialPropertyList[pName].parameters,tTweening.properties[pName].originalValueComplete,tTweening.properties[pName].extra);
                        }
                        pv = Number(_specialPropertyList[pName].getValue(tScope,_specialPropertyList[pName].parameters,tTweening.properties[pName].extra));
                     }
                     else
                     {
                        pv = Number(tScope[pName]);
                     }
                     tTweening.properties[pName].valueStart = isNaN(pv) ? tTweening.properties[pName].valueComplete : pv;
                  }
                  mustUpdate = true;
                  tTweening.hasStarted = true;
               }
               if(mustUpdate)
               {
                  for(pName in tTweening.properties)
                  {
                     tProperty = tTweening.properties[pName];
                     if(isOver)
                     {
                        nv = Number(tProperty.valueComplete);
                     }
                     else if(tProperty.hasModifier)
                     {
                        t = cTime - tTweening.timeStart;
                        d = tTweening.timeComplete - tTweening.timeStart;
                        nv = tTweening.transition(t,0,1,d,tTweening.transitionParams);
                        nv = Number(tProperty.modifierFunction(tProperty.valueStart,tProperty.valueComplete,nv,tProperty.modifierParameters));
                     }
                     else
                     {
                        t = cTime - tTweening.timeStart;
                        b = Number(tProperty.valueStart);
                        c = tProperty.valueComplete - tProperty.valueStart;
                        d = tTweening.timeComplete - tTweening.timeStart;
                        nv = tTweening.transition(t,b,c,d,tTweening.transitionParams);
                     }
                     if(tTweening.rounded)
                     {
                        nv = Math.round(nv);
                     }
                     if(tProperty.isSpecialProperty)
                     {
                        _specialPropertyList[pName].setValue(tScope,nv,_specialPropertyList[pName].parameters,tTweening.properties[pName].extra);
                     }
                     else
                     {
                        tScope[pName] = nv;
                     }
                  }
                  tTweening.updatesSkipped = 0;
                  if(Boolean(tTweening.onUpdate))
                  {
                     eventScope = Boolean(tTweening.onUpdateScope) ? tTweening.onUpdateScope : tScope;
                     try
                     {
                        tTweening.onUpdate.apply(eventScope,tTweening.onUpdateParams);
                     }
                     catch(e3:Error)
                     {
                        handleError(tTweening,e3,"onUpdate");
                     }
                  }
               }
               else
               {
                  ++tTweening.updatesSkipped;
               }
            }
            if(isOver && Boolean(tTweening.onComplete))
            {
               eventScope = Boolean(tTweening.onCompleteScope) ? tTweening.onCompleteScope : tScope;
               try
               {
                  tTweening.onComplete.apply(eventScope,tTweening.onCompleteParams);
               }
               catch(e4:Error)
               {
                  handleError(tTweening,e4,"onComplete");
               }
            }
            return !isOver;
         }
         return true;
      }
      
      public static function init(... rest) : void
      {
         _inited = true;
         _transitionList = new Object();
         Equations.init();
         _specialPropertyList = new Object();
         _specialPropertyModifierList = new Object();
         _specialPropertySplitterList = new Object();
      }
      
      public static function registerTransition(param1:String, param2:Function) : void
      {
         if(!_inited)
         {
            init();
         }
         _transitionList[param1] = param2;
      }
      
      public static function registerSpecialProperty(param1:String, param2:Function, param3:Function, param4:Array = null, param5:Function = null) : void
      {
         if(!_inited)
         {
            init();
         }
         var _loc6_:SpecialProperty = new SpecialProperty(param2,param3,param4,param5);
         _specialPropertyList[param1] = _loc6_;
      }
      
      public static function registerSpecialPropertyModifier(param1:String, param2:Function, param3:Function) : void
      {
         if(!_inited)
         {
            init();
         }
         var _loc4_:SpecialPropertyModifier = new SpecialPropertyModifier(param2,param3);
         _specialPropertyModifierList[param1] = _loc4_;
      }
      
      public static function registerSpecialPropertySplitter(param1:String, param2:Function, param3:Array = null) : void
      {
         if(!_inited)
         {
            init();
         }
         var _loc4_:SpecialPropertySplitter = new SpecialPropertySplitter(param2,param3);
         _specialPropertySplitterList[param1] = _loc4_;
      }
      
      private static function startEngine() : void
      {
         _engineExists = true;
         _tweenList = new Array();
         __tweener_controller__ = new MovieClip();
         __tweener_controller__.addEventListener(Event.ENTER_FRAME,Tweener.onEnterFrame);
         _currentTimeFrame = 0;
         updateTime();
      }
      
      private static function stopEngine() : void
      {
         _engineExists = false;
         _tweenList = null;
         _currentTime = 0;
         _currentTimeFrame = 0;
         __tweener_controller__.removeEventListener(Event.ENTER_FRAME,Tweener.onEnterFrame);
         __tweener_controller__ = null;
      }
      
      public static function updateTime() : void
      {
         _currentTime = getTimer();
      }
      
      public static function updateFrame() : void
      {
         ++_currentTimeFrame;
      }
      
      public static function onEnterFrame(param1:Event) : void
      {
         updateTime();
         updateFrame();
         var _loc2_:Boolean = false;
         _loc2_ = updateTweens();
         if(!_loc2_)
         {
            stopEngine();
         }
      }
      
      public static function setTimeScale(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(isNaN(param1))
         {
            param1 = 1;
         }
         if(param1 < 0.00001)
         {
            param1 = 0.00001;
         }
         if(param1 != _timeScale)
         {
            if(_tweenList != null)
            {
               _loc2_ = 0;
               while(_loc2_ < _tweenList.length)
               {
                  _loc3_ = getCurrentTweeningTime(_tweenList[_loc2_]);
                  _tweenList[_loc2_].timeStart = _loc3_ - (_loc3_ - _tweenList[_loc2_].timeStart) * _timeScale / param1;
                  _tweenList[_loc2_].timeComplete = _loc3_ - (_loc3_ - _tweenList[_loc2_].timeComplete) * _timeScale / param1;
                  if(_tweenList[_loc2_].timePaused != undefined)
                  {
                     _tweenList[_loc2_].timePaused = _loc3_ - (_loc3_ - _tweenList[_loc2_].timePaused) * _timeScale / param1;
                  }
                  _loc2_++;
               }
            }
            _timeScale = param1;
         }
      }
      
      public static function isTweening(param1:Object) : Boolean
      {
         var _loc2_:uint = 0;
         if(!Boolean(_tweenList))
         {
            return false;
         }
         _loc2_ = 0;
         while(_loc2_ < _tweenList.length)
         {
            if(Boolean(_tweenList[_loc2_]) && _tweenList[_loc2_].scope == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public static function getTweens(param1:Object) : Array
      {
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         if(!Boolean(_tweenList))
         {
            return [];
         }
         var _loc4_:Array = new Array();
         _loc2_ = 0;
         while(_loc2_ < _tweenList.length)
         {
            if(Boolean(_tweenList[_loc2_]) && _tweenList[_loc2_].scope == param1)
            {
               for(_loc3_ in _tweenList[_loc2_].properties)
               {
                  _loc4_.push(_loc3_);
               }
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      public static function getTweenCount(param1:Object) : Number
      {
         var _loc2_:uint = 0;
         if(!Boolean(_tweenList))
         {
            return 0;
         }
         var _loc3_:Number = 0;
         _loc2_ = 0;
         while(_loc2_ < _tweenList.length)
         {
            if(Boolean(_tweenList[_loc2_]) && _tweenList[_loc2_].scope == param1)
            {
               _loc3_ += AuxFunctions.getObjectLength(_tweenList[_loc2_].properties);
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      private static function handleError(param1:TweenListObj, param2:Error, param3:String) : void
      {
         var eventScope:Object = null;
         var pTweening:TweenListObj = param1;
         var pError:Error = param2;
         var pCallBackName:String = param3;
         if(Boolean(pTweening.onError) && pTweening.onError is Function)
         {
            eventScope = Boolean(pTweening.onErrorScope) ? pTweening.onErrorScope : pTweening.scope;
            try
            {
               pTweening.onError.apply(eventScope,[pTweening.scope,pError]);
            }
            catch(metaError:Error)
            {
               printError(String(pTweening.scope) + " raised an error while executing the \'onError\' handler. Original error:\n " + pError.getStackTrace() + "\nonError error: " + metaError.getStackTrace());
            }
         }
         else if(!Boolean(pTweening.onError))
         {
            printError(String(pTweening.scope) + " raised an error while executing the \'" + pCallBackName + "\'handler. \n" + pError.getStackTrace());
         }
      }
      
      public static function getCurrentTweeningTime(param1:Object) : Number
      {
         return !!param1.useFrames ? _currentTimeFrame : _currentTime;
      }
      
      public static function getVersion() : String
      {
         return "AS3 1.31.74";
      }
      
      public static function printError(param1:String) : void
      {
         trace("## [Tweener] Error: " + param1);
      }
   }
}
