package jp.feb19.transitions
{
   public class TweeningObject
   {
       
      
      public var properties:Object;
      
      public var target:Object;
      
      public var start:int;
      
      public var end:int;
      
      public var easing:Function;
      
      public var easingParams:Object;
      
      public var onStart:Function;
      
      public var onStartParams:Object;
      
      public var onUpdate:Function;
      
      public var onUpdateParams:Object;
      
      public var onComplete:Function;
      
      public var onCompleteParams:Object;
      
      public var hasStarted:Boolean = false;
      
      public var skipUpdates:int;
      
      public var updatesSkipped:int;
      
      public function TweeningObject()
      {
         this.properties = new Object();
         super();
      }
   }
}
