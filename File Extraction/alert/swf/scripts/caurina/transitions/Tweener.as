package caurina.transitions
{
   import flash.display.*;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class Tweener
   {
      
      private static var _currentTimeFrame:Number;
      
      private static var _specialPropertySplitterList:Object;
      
      private static var _specialPropertyModifierList:Object;
      
      private static var _currentTime:Number;
      
      private static var _tweenList:Array;
      
      private static var _specialPropertyList:Object;
      
      private static var _transitionList:Object;
      
      private static var __tweener_controller__:MovieClip;
      
      private static var _engineExists:Boolean = false;
      
      private static var _inited:Boolean = false;
      
      private static var _timeScale:Number = 1;
      
      public function Tweener()
      {
         super();
         trace("Tweener is a static class and should not be instantiated.");
      }
      
      public static function registerSpecialPropertyModifier(p_name:String, p_modifyFunction:Function, p_getFunction:Function) : void
      {
         if(!_inited)
         {
            init();
         }
         var spm:SpecialPropertyModifier = new SpecialPropertyModifier(p_modifyFunction,p_getFunction);
         _specialPropertyModifierList[p_name] = spm;
      }
      
      public static function registerSpecialProperty(p_name:String, p_getFunction:Function, p_setFunction:Function, p_parameters:Array = null, p_preProcessFunction:Function = null) : void
      {
         if(!_inited)
         {
            init();
         }
         var sp:SpecialProperty = new SpecialProperty(p_getFunction,p_setFunction,p_parameters,p_preProcessFunction);
         _specialPropertyList[p_name] = sp;
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
      
      private static function updateTweens() : Boolean
      {
         var i:* = 0;
         if(_tweenList.length == 0)
         {
            return false;
         }
         for(i = 0; i < _tweenList.length; i++)
         {
            if(_tweenList[i] == undefined || !_tweenList[i].isPaused)
            {
               if(!updateTweenByIndex(i))
               {
                  removeTweenByIndex(i);
               }
               if(_tweenList[i] == null)
               {
                  removeTweenByIndex(i,true);
                  i--;
               }
            }
         }
         return true;
      }
      
      public static function addCaller(p_scopes:Object = null, p_parameters:Object = null) : Boolean
      {
         var i:Number = NaN;
         var rScopes:Array = null;
         var rTransition:Function = null;
         var nTween:TweenListObj = null;
         var myT:Number = NaN;
         var trans:String = null;
         if(!Boolean(p_scopes))
         {
            return false;
         }
         if(p_scopes is Array)
         {
            rScopes = p_scopes.concat();
         }
         else
         {
            rScopes = [p_scopes];
         }
         var p_obj:Object = p_parameters;
         if(!_inited)
         {
            init();
         }
         if(!_engineExists || !Boolean(__tweener_controller__))
         {
            startEngine();
         }
         var rTime:Number = isNaN(p_obj.time) ? 0 : Number(p_obj.time);
         var rDelay:Number = isNaN(p_obj.delay) ? 0 : Number(p_obj.delay);
         if(typeof p_obj.transition == "string")
         {
            trans = p_obj.transition.toLowerCase();
            rTransition = _transitionList[trans];
         }
         else
         {
            rTransition = p_obj.transition;
         }
         if(!Boolean(rTransition))
         {
            rTransition = _transitionList["easeoutexpo"];
         }
         for(i = 0; i < rScopes.length; i++)
         {
            if(p_obj.useFrames == true)
            {
               nTween = new TweenListObj(rScopes[i],_currentTimeFrame + rDelay / _timeScale,_currentTimeFrame + (rDelay + rTime) / _timeScale,true,rTransition,p_obj.transitionParams);
            }
            else
            {
               nTween = new TweenListObj(rScopes[i],_currentTime + rDelay * 1000 / _timeScale,_currentTime + (rDelay * 1000 + rTime * 1000) / _timeScale,false,rTransition,p_obj.transitionParams);
            }
            nTween.properties = null;
            nTween.onStart = p_obj.onStart;
            nTween.onUpdate = p_obj.onUpdate;
            nTween.onComplete = p_obj.onComplete;
            nTween.onOverwrite = p_obj.onOverwrite;
            nTween.onStartParams = p_obj.onStartParams;
            nTween.onUpdateParams = p_obj.onUpdateParams;
            nTween.onCompleteParams = p_obj.onCompleteParams;
            nTween.onOverwriteParams = p_obj.onOverwriteParams;
            nTween.onStartScope = p_obj.onStartScope;
            nTween.onUpdateScope = p_obj.onUpdateScope;
            nTween.onCompleteScope = p_obj.onCompleteScope;
            nTween.onOverwriteScope = p_obj.onOverwriteScope;
            nTween.onErrorScope = p_obj.onErrorScope;
            nTween.isCaller = true;
            nTween.count = p_obj.count;
            nTween.waitFrames = p_obj.waitFrames;
            _tweenList.push(nTween);
            if(rTime == 0 && rDelay == 0)
            {
               myT = _tweenList.length - 1;
               updateTweenByIndex(myT);
               removeTweenByIndex(myT);
            }
         }
         return true;
      }
      
      public static function pauseAllTweens() : Boolean
      {
         var i:uint = 0;
         if(!Boolean(_tweenList))
         {
            return false;
         }
         var paused:Boolean = false;
         for(i = 0; i < _tweenList.length; i++)
         {
            pauseTweenByIndex(i);
            paused = true;
         }
         return paused;
      }
      
      public static function removeTweens(p_scope:Object, ... args) : Boolean
      {
         var i:uint = 0;
         var sps:SpecialPropertySplitter = null;
         var specialProps:Array = null;
         var j:uint = 0;
         var properties:Array = new Array();
         for(i = 0; i < args.length; i++)
         {
            if(typeof args[i] == "string" && properties.indexOf(args[i]) == -1)
            {
               if(_specialPropertySplitterList[args[i]])
               {
                  sps = _specialPropertySplitterList[args[i]];
                  specialProps = sps.splitValues(p_scope,null);
                  for(j = 0; j < specialProps.length; j++)
                  {
                     properties.push(specialProps[j].name);
                  }
               }
               else
               {
                  properties.push(args[i]);
               }
            }
         }
         return affectTweens(removeTweenByIndex,p_scope,properties);
      }
      
      public static function splitTweens(p_tween:Number, p_properties:Array) : uint
      {
         var i:uint = 0;
         var pName:String = null;
         var found:Boolean = false;
         var originalTween:TweenListObj = _tweenList[p_tween];
         var newTween:TweenListObj = originalTween.clone(false);
         for(i = 0; i < p_properties.length; i++)
         {
            pName = p_properties[i];
            if(Boolean(originalTween.properties[pName]))
            {
               originalTween.properties[pName] = undefined;
               delete originalTween.properties[pName];
            }
         }
         for(pName in newTween.properties)
         {
            found = false;
            for(i = 0; i < p_properties.length; i++)
            {
               if(p_properties[i] == pName)
               {
                  found = true;
                  break;
               }
            }
            if(!found)
            {
               newTween.properties[pName] = undefined;
               delete newTween.properties[pName];
            }
         }
         _tweenList.push(newTween);
         return _tweenList.length - 1;
      }
      
      public static function updateFrame() : void
      {
         ++_currentTimeFrame;
      }
      
      public static function resumeTweenByIndex(p_tween:Number) : Boolean
      {
         var tTweening:TweenListObj = _tweenList[p_tween];
         if(tTweening == null || !tTweening.isPaused)
         {
            return false;
         }
         var cTime:Number = getCurrentTweeningTime(tTweening);
         tTweening.timeStart += cTime - tTweening.timePaused;
         tTweening.timeComplete += cTime - tTweening.timePaused;
         tTweening.timePaused = undefined;
         tTweening.isPaused = false;
         return true;
      }
      
      public static function getVersion() : String
      {
         return "AS3 1.31.74";
      }
      
      public static function onEnterFrame(e:Event) : void
      {
         updateTime();
         updateFrame();
         var hasUpdated:Boolean = false;
         hasUpdated = updateTweens();
         if(!hasUpdated)
         {
            stopEngine();
         }
      }
      
      public static function updateTime() : void
      {
         _currentTime = getTimer();
      }
      
      private static function updateTweenByIndex(i:Number) : Boolean
      {
         var cTime:Number;
         var isOver:Boolean;
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
      
      public static function setTimeScale(p_time:Number) : void
      {
         var i:Number = NaN;
         var cTime:Number = NaN;
         if(isNaN(p_time))
         {
            p_time = 1;
         }
         if(p_time < 0.00001)
         {
            p_time = 0.00001;
         }
         if(p_time != _timeScale)
         {
            if(_tweenList != null)
            {
               for(i = 0; i < _tweenList.length; i++)
               {
                  cTime = getCurrentTweeningTime(_tweenList[i]);
                  _tweenList[i].timeStart = cTime - (cTime - _tweenList[i].timeStart) * _timeScale / p_time;
                  _tweenList[i].timeComplete = cTime - (cTime - _tweenList[i].timeComplete) * _timeScale / p_time;
                  if(_tweenList[i].timePaused != undefined)
                  {
                     _tweenList[i].timePaused = cTime - (cTime - _tweenList[i].timePaused) * _timeScale / p_time;
                  }
               }
            }
            _timeScale = p_time;
         }
      }
      
      public static function resumeAllTweens() : Boolean
      {
         var i:uint = 0;
         if(!Boolean(_tweenList))
         {
            return false;
         }
         var resumed:Boolean = false;
         for(i = 0; i < _tweenList.length; i++)
         {
            resumeTweenByIndex(i);
            resumed = true;
         }
         return resumed;
      }
      
      private static function handleError(pTweening:TweenListObj, pError:Error, pCallBackName:String) : void
      {
         var eventScope:Object = null;
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
      
      private static function startEngine() : void
      {
         _engineExists = true;
         _tweenList = new Array();
         __tweener_controller__ = new MovieClip();
         __tweener_controller__.addEventListener(Event.ENTER_FRAME,Tweener.onEnterFrame);
         _currentTimeFrame = 0;
         updateTime();
      }
      
      public static function removeAllTweens() : Boolean
      {
         var i:uint = 0;
         if(!Boolean(_tweenList))
         {
            return false;
         }
         var removed:Boolean = false;
         for(i = 0; i < _tweenList.length; i++)
         {
            removeTweenByIndex(i);
            removed = true;
         }
         return removed;
      }
      
      public static function addTween(p_scopes:Object = null, p_parameters:Object = null) : Boolean
      {
         var i:Number = NaN;
         var j:Number = NaN;
         var istr:String = null;
         var rScopes:Array = null;
         var rTransition:Function = null;
         var nProperties:Object = null;
         var nTween:TweenListObj = null;
         var myT:Number = NaN;
         var splitProperties:Array = null;
         var splitProperties2:Array = null;
         var tempModifiedProperties:Array = null;
         var trans:String = null;
         if(!Boolean(p_scopes))
         {
            return false;
         }
         if(p_scopes is Array)
         {
            rScopes = p_scopes.concat();
         }
         else
         {
            rScopes = [p_scopes];
         }
         var p_obj:Object = TweenListObj.makePropertiesChain(p_parameters);
         if(!_inited)
         {
            init();
         }
         if(!_engineExists || !Boolean(__tweener_controller__))
         {
            startEngine();
         }
         var rTime:Number = isNaN(p_obj.time) ? 0 : Number(p_obj.time);
         var rDelay:Number = isNaN(p_obj.delay) ? 0 : Number(p_obj.delay);
         var rProperties:Array = new Array();
         var restrictedWords:Object = {
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
         var modifiedProperties:Object = new Object();
         for(istr in p_obj)
         {
            if(!restrictedWords[istr])
            {
               if(_specialPropertySplitterList[istr])
               {
                  splitProperties = _specialPropertySplitterList[istr].splitValues(p_obj[istr],_specialPropertySplitterList[istr].parameters);
                  for(i = 0; i < splitProperties.length; i++)
                  {
                     if(_specialPropertySplitterList[splitProperties[i].name])
                     {
                        splitProperties2 = _specialPropertySplitterList[splitProperties[i].name].splitValues(splitProperties[i].value,_specialPropertySplitterList[splitProperties[i].name].parameters);
                        for(j = 0; j < splitProperties2.length; j++)
                        {
                           rProperties[splitProperties2[j].name] = {
                              "valueStart":undefined,
                              "valueComplete":splitProperties2[j].value,
                              "arrayIndex":splitProperties2[j].arrayIndex,
                              "isSpecialProperty":false
                           };
                        }
                     }
                     else
                     {
                        rProperties[splitProperties[i].name] = {
                           "valueStart":undefined,
                           "valueComplete":splitProperties[i].value,
                           "arrayIndex":splitProperties[i].arrayIndex,
                           "isSpecialProperty":false
                        };
                     }
                  }
               }
               else if(_specialPropertyModifierList[istr] != undefined)
               {
                  tempModifiedProperties = _specialPropertyModifierList[istr].modifyValues(p_obj[istr]);
                  for(i = 0; i < tempModifiedProperties.length; i++)
                  {
                     modifiedProperties[tempModifiedProperties[i].name] = {
                        "modifierParameters":tempModifiedProperties[i].parameters,
                        "modifierFunction":_specialPropertyModifierList[istr].getValue
                     };
                  }
               }
               else
               {
                  rProperties[istr] = {
                     "valueStart":undefined,
                     "valueComplete":p_obj[istr]
                  };
               }
            }
         }
         for(istr in rProperties)
         {
            if(_specialPropertyList[istr] != undefined)
            {
               rProperties[istr].isSpecialProperty = true;
            }
            else if(rScopes[0][istr] == undefined)
            {
               printError("The property \'" + istr + "\' doesn\'t seem to be a normal object property of " + String(rScopes[0]) + " or a registered special property.");
            }
         }
         for(istr in modifiedProperties)
         {
            if(rProperties[istr] != undefined)
            {
               rProperties[istr].modifierParameters = modifiedProperties[istr].modifierParameters;
               rProperties[istr].modifierFunction = modifiedProperties[istr].modifierFunction;
            }
         }
         if(typeof p_obj.transition == "string")
         {
            trans = p_obj.transition.toLowerCase();
            rTransition = _transitionList[trans];
         }
         else
         {
            rTransition = p_obj.transition;
         }
         if(!Boolean(rTransition))
         {
            rTransition = _transitionList["easeoutexpo"];
         }
         for(i = 0; i < rScopes.length; i++)
         {
            nProperties = new Object();
            for(istr in rProperties)
            {
               nProperties[istr] = new PropertyInfoObj(rProperties[istr].valueStart,rProperties[istr].valueComplete,rProperties[istr].valueComplete,rProperties[istr].arrayIndex,{},rProperties[istr].isSpecialProperty,rProperties[istr].modifierFunction,rProperties[istr].modifierParameters);
            }
            if(p_obj.useFrames == true)
            {
               nTween = new TweenListObj(rScopes[i],_currentTimeFrame + rDelay / _timeScale,_currentTimeFrame + (rDelay + rTime) / _timeScale,true,rTransition,p_obj.transitionParams);
            }
            else
            {
               nTween = new TweenListObj(rScopes[i],_currentTime + rDelay * 1000 / _timeScale,_currentTime + (rDelay * 1000 + rTime * 1000) / _timeScale,false,rTransition,p_obj.transitionParams);
            }
            nTween.properties = nProperties;
            nTween.onStart = p_obj.onStart;
            nTween.onUpdate = p_obj.onUpdate;
            nTween.onComplete = p_obj.onComplete;
            nTween.onOverwrite = p_obj.onOverwrite;
            nTween.onError = p_obj.onError;
            nTween.onStartParams = p_obj.onStartParams;
            nTween.onUpdateParams = p_obj.onUpdateParams;
            nTween.onCompleteParams = p_obj.onCompleteParams;
            nTween.onOverwriteParams = p_obj.onOverwriteParams;
            nTween.onStartScope = p_obj.onStartScope;
            nTween.onUpdateScope = p_obj.onUpdateScope;
            nTween.onCompleteScope = p_obj.onCompleteScope;
            nTween.onOverwriteScope = p_obj.onOverwriteScope;
            nTween.onErrorScope = p_obj.onErrorScope;
            nTween.rounded = p_obj.rounded;
            nTween.skipUpdates = p_obj.skipUpdates;
            removeTweensByTime(nTween.scope,nTween.properties,nTween.timeStart,nTween.timeComplete);
            _tweenList.push(nTween);
            if(rTime == 0 && rDelay == 0)
            {
               myT = _tweenList.length - 1;
               updateTweenByIndex(myT);
               removeTweenByIndex(myT);
            }
         }
         return true;
      }
      
      public static function registerTransition(p_name:String, p_function:Function) : void
      {
         if(!_inited)
         {
            init();
         }
         _transitionList[p_name] = p_function;
      }
      
      public static function printError(p_message:String) : void
      {
         trace("## [Tweener] Error: " + p_message);
      }
      
      private static function affectTweens(p_affectFunction:Function, p_scope:Object, p_properties:Array) : Boolean
      {
         var i:uint = 0;
         var affectedProperties:Array = null;
         var j:uint = 0;
         var objectProperties:uint = 0;
         var slicedTweenIndex:uint = 0;
         var affected:Boolean = false;
         if(!Boolean(_tweenList))
         {
            return false;
         }
         for(i = 0; i < _tweenList.length; i++)
         {
            if(Boolean(_tweenList[i]) && _tweenList[i].scope == p_scope)
            {
               if(p_properties.length == 0)
               {
                  p_affectFunction(i);
                  affected = true;
               }
               else
               {
                  affectedProperties = new Array();
                  for(j = 0; j < p_properties.length; j++)
                  {
                     if(Boolean(_tweenList[i].properties[p_properties[j]]))
                     {
                        affectedProperties.push(p_properties[j]);
                     }
                  }
                  if(affectedProperties.length > 0)
                  {
                     objectProperties = AuxFunctions.getObjectLength(_tweenList[i].properties);
                     if(objectProperties == affectedProperties.length)
                     {
                        p_affectFunction(i);
                        affected = true;
                     }
                     else
                     {
                        slicedTweenIndex = splitTweens(i,affectedProperties);
                        p_affectFunction(slicedTweenIndex);
                        affected = true;
                     }
                  }
               }
            }
         }
         return affected;
      }
      
      public static function getTweens(p_scope:Object) : Array
      {
         var i:uint = 0;
         var pName:String = null;
         if(!Boolean(_tweenList))
         {
            return [];
         }
         var tList:Array = new Array();
         for(i = 0; i < _tweenList.length; i++)
         {
            if(Boolean(_tweenList[i]) && _tweenList[i].scope == p_scope)
            {
               for(pName in _tweenList[i].properties)
               {
                  tList.push(pName);
               }
            }
         }
         return tList;
      }
      
      public static function isTweening(p_scope:Object) : Boolean
      {
         var i:uint = 0;
         if(!Boolean(_tweenList))
         {
            return false;
         }
         for(i = 0; i < _tweenList.length; i++)
         {
            if(Boolean(_tweenList[i]) && _tweenList[i].scope == p_scope)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function pauseTweenByIndex(p_tween:Number) : Boolean
      {
         var tTweening:TweenListObj = _tweenList[p_tween];
         if(tTweening == null || tTweening.isPaused)
         {
            return false;
         }
         tTweening.timePaused = getCurrentTweeningTime(tTweening);
         tTweening.isPaused = true;
         return true;
      }
      
      public static function getCurrentTweeningTime(p_tweening:Object) : Number
      {
         return p_tweening.useFrames ? _currentTimeFrame : _currentTime;
      }
      
      public static function getTweenCount(p_scope:Object) : Number
      {
         var i:uint = 0;
         if(!Boolean(_tweenList))
         {
            return 0;
         }
         var c:Number = 0;
         for(i = 0; i < _tweenList.length; i++)
         {
            if(Boolean(_tweenList[i]) && _tweenList[i].scope == p_scope)
            {
               c += AuxFunctions.getObjectLength(_tweenList[i].properties);
            }
         }
         return c;
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
      
      public static function removeTweensByTime(p_scope:Object, p_properties:Object, p_timeStart:Number, p_timeComplete:Number) : Boolean
      {
         var removedLocally:Boolean = false;
         var i:uint = 0;
         var pName:String = null;
         var eventScope:Object = null;
         var removed:Boolean = false;
         var tl:uint = _tweenList.length;
         for(i = 0; i < tl; i++)
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
         }
         return removed;
      }
      
      public static function registerSpecialPropertySplitter(p_name:String, p_splitFunction:Function, p_parameters:Array = null) : void
      {
         if(!_inited)
         {
            init();
         }
         var sps:SpecialPropertySplitter = new SpecialPropertySplitter(p_splitFunction,p_parameters);
         _specialPropertySplitterList[p_name] = sps;
      }
      
      public static function removeTweenByIndex(i:Number, p_finalRemoval:Boolean = false) : Boolean
      {
         _tweenList[i] = null;
         if(p_finalRemoval)
         {
            _tweenList.splice(i,1);
         }
         return true;
      }
      
      public static function resumeTweens(p_scope:Object, ... args) : Boolean
      {
         var i:uint = 0;
         var properties:Array = new Array();
         for(i = 0; i < args.length; i++)
         {
            if(typeof args[i] == "string" && properties.indexOf(args[i]) == -1)
            {
               properties.push(args[i]);
            }
         }
         return affectTweens(resumeTweenByIndex,p_scope,properties);
      }
      
      public static function pauseTweens(p_scope:Object, ... args) : Boolean
      {
         var i:uint = 0;
         var properties:Array = new Array();
         for(i = 0; i < args.length; i++)
         {
            if(typeof args[i] == "string" && properties.indexOf(args[i]) == -1)
            {
               properties.push(args[i]);
            }
         }
         return affectTweens(pauseTweenByIndex,p_scope,properties);
      }
   }
}

