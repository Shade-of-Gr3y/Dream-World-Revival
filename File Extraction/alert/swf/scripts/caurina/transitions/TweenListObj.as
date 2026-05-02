package caurina.transitions
{
   public class TweenListObj
   {
      
      public var hasStarted:Boolean;
      
      public var onUpdate:Function;
      
      public var useFrames:Boolean;
      
      public var count:Number;
      
      public var onOverwriteParams:Array;
      
      public var timeStart:Number;
      
      public var timeComplete:Number;
      
      public var onStartParams:Array;
      
      public var onUpdateScope:Object;
      
      public var rounded:Boolean;
      
      public var onUpdateParams:Array;
      
      public var properties:Object;
      
      public var onComplete:Function;
      
      public var transitionParams:Object;
      
      public var updatesSkipped:Number;
      
      public var onStart:Function;
      
      public var onOverwriteScope:Object;
      
      public var skipUpdates:Number;
      
      public var onStartScope:Object;
      
      public var scope:Object;
      
      public var isCaller:Boolean;
      
      public var timePaused:Number;
      
      public var transition:Function;
      
      public var onCompleteParams:Array;
      
      public var onError:Function;
      
      public var timesCalled:Number;
      
      public var onErrorScope:Object;
      
      public var onOverwrite:Function;
      
      public var isPaused:Boolean;
      
      public var waitFrames:Boolean;
      
      public var onCompleteScope:Object;
      
      public function TweenListObj(p_scope:Object, p_timeStart:Number, p_timeComplete:Number, p_useFrames:Boolean, p_transition:Function, p_transitionParams:Object)
      {
         super();
         this.scope = p_scope;
         this.timeStart = p_timeStart;
         this.timeComplete = p_timeComplete;
         this.useFrames = p_useFrames;
         this.transition = p_transition;
         this.transitionParams = p_transitionParams;
         this.properties = new Object();
         this.isPaused = false;
         this.timePaused = undefined;
         this.isCaller = false;
         this.updatesSkipped = 0;
         this.timesCalled = 0;
         this.skipUpdates = 0;
         this.hasStarted = false;
      }
      
      public static function makePropertiesChain(p_obj:Object) : Object
      {
         var chainedObject:Object = null;
         var chain:Object = null;
         var currChainObj:Object = null;
         var len:Number = NaN;
         var i:Number = NaN;
         var k:Number = NaN;
         var baseObject:Object = p_obj.base;
         if(baseObject)
         {
            chainedObject = {};
            if(baseObject is Array)
            {
               chain = [];
               k = 0;
               while(k < baseObject.length)
               {
                  chain.push(baseObject[k]);
                  k++;
               }
            }
            else
            {
               chain = [baseObject];
            }
            chain.push(p_obj);
            len = Number(chain.length);
            for(i = 0; i < len; i++)
            {
               if(chain[i]["base"])
               {
                  currChainObj = AuxFunctions.concatObjects(makePropertiesChain(chain[i]["base"]),chain[i]);
               }
               else
               {
                  currChainObj = chain[i];
               }
               chainedObject = AuxFunctions.concatObjects(chainedObject,currChainObj);
            }
            if(chainedObject["base"])
            {
               delete chainedObject["base"];
            }
            return chainedObject;
         }
         return p_obj;
      }
      
      public function clone(omitEvents:Boolean) : TweenListObj
      {
         var pName:String = null;
         var nTween:TweenListObj = new TweenListObj(this.scope,this.timeStart,this.timeComplete,this.useFrames,this.transition,this.transitionParams);
         nTween.properties = new Array();
         for(pName in this.properties)
         {
            nTween.properties[pName] = this.properties[pName].clone();
         }
         nTween.skipUpdates = this.skipUpdates;
         nTween.updatesSkipped = this.updatesSkipped;
         if(!omitEvents)
         {
            nTween.onStart = this.onStart;
            nTween.onUpdate = this.onUpdate;
            nTween.onComplete = this.onComplete;
            nTween.onOverwrite = this.onOverwrite;
            nTween.onError = this.onError;
            nTween.onStartParams = this.onStartParams;
            nTween.onUpdateParams = this.onUpdateParams;
            nTween.onCompleteParams = this.onCompleteParams;
            nTween.onOverwriteParams = this.onOverwriteParams;
            nTween.onStartScope = this.onStartScope;
            nTween.onUpdateScope = this.onUpdateScope;
            nTween.onCompleteScope = this.onCompleteScope;
            nTween.onOverwriteScope = this.onOverwriteScope;
            nTween.onErrorScope = this.onErrorScope;
         }
         nTween.rounded = this.rounded;
         nTween.isPaused = this.isPaused;
         nTween.timePaused = this.timePaused;
         nTween.isCaller = this.isCaller;
         nTween.count = this.count;
         nTween.timesCalled = this.timesCalled;
         nTween.waitFrames = this.waitFrames;
         nTween.hasStarted = this.hasStarted;
         return nTween;
      }
      
      public function toString() : String
      {
         var i:String = null;
         var returnStr:String = "\n[TweenListObj ";
         returnStr += "scope:" + String(this.scope);
         returnStr += ", properties:";
         var isFirst:Boolean = true;
         for(i in this.properties)
         {
            if(!isFirst)
            {
               returnStr += ",";
            }
            returnStr += "[name:" + this.properties[i].name;
            returnStr += ",valueStart:" + this.properties[i].valueStart;
            returnStr += ",valueComplete:" + this.properties[i].valueComplete;
            returnStr += "]";
            isFirst = false;
         }
         returnStr += ", timeStart:" + String(this.timeStart);
         returnStr += ", timeComplete:" + String(this.timeComplete);
         returnStr += ", useFrames:" + String(this.useFrames);
         returnStr += ", transition:" + String(this.transition);
         returnStr += ", transitionParams:" + String(this.transitionParams);
         if(this.skipUpdates)
         {
            returnStr += ", skipUpdates:" + String(this.skipUpdates);
         }
         if(this.updatesSkipped)
         {
            returnStr += ", updatesSkipped:" + String(this.updatesSkipped);
         }
         if(Boolean(this.onStart))
         {
            returnStr += ", onStart:" + String(this.onStart);
         }
         if(Boolean(this.onUpdate))
         {
            returnStr += ", onUpdate:" + String(this.onUpdate);
         }
         if(Boolean(this.onComplete))
         {
            returnStr += ", onComplete:" + String(this.onComplete);
         }
         if(Boolean(this.onOverwrite))
         {
            returnStr += ", onOverwrite:" + String(this.onOverwrite);
         }
         if(Boolean(this.onError))
         {
            returnStr += ", onError:" + String(this.onError);
         }
         if(this.onStartParams)
         {
            returnStr += ", onStartParams:" + String(this.onStartParams);
         }
         if(this.onUpdateParams)
         {
            returnStr += ", onUpdateParams:" + String(this.onUpdateParams);
         }
         if(this.onCompleteParams)
         {
            returnStr += ", onCompleteParams:" + String(this.onCompleteParams);
         }
         if(this.onOverwriteParams)
         {
            returnStr += ", onOverwriteParams:" + String(this.onOverwriteParams);
         }
         if(this.onStartScope)
         {
            returnStr += ", onStartScope:" + String(this.onStartScope);
         }
         if(this.onUpdateScope)
         {
            returnStr += ", onUpdateScope:" + String(this.onUpdateScope);
         }
         if(this.onCompleteScope)
         {
            returnStr += ", onCompleteScope:" + String(this.onCompleteScope);
         }
         if(this.onOverwriteScope)
         {
            returnStr += ", onOverwriteScope:" + String(this.onOverwriteScope);
         }
         if(this.onErrorScope)
         {
            returnStr += ", onErrorScope:" + String(this.onErrorScope);
         }
         if(this.rounded)
         {
            returnStr += ", rounded:" + String(this.rounded);
         }
         if(this.isPaused)
         {
            returnStr += ", isPaused:" + String(this.isPaused);
         }
         if(this.timePaused)
         {
            returnStr += ", timePaused:" + String(this.timePaused);
         }
         if(this.isCaller)
         {
            returnStr += ", isCaller:" + String(this.isCaller);
         }
         if(this.count)
         {
            returnStr += ", count:" + String(this.count);
         }
         if(this.timesCalled)
         {
            returnStr += ", timesCalled:" + String(this.timesCalled);
         }
         if(this.waitFrames)
         {
            returnStr += ", waitFrames:" + String(this.waitFrames);
         }
         if(this.hasStarted)
         {
            returnStr += ", hasStarted:" + String(this.hasStarted);
         }
         return returnStr + "]\n";
      }
   }
}

