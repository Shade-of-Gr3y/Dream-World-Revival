package
{
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol146")]
   public class CircleTimer extends MovieClip
   {
      
      public var MaskMc:MovieClip;
      
      internal var m_maskShape:Shape;
      
      internal var m_endCall:Function;
      
      internal var m_start:int;
      
      internal var m_pauseTime:int;
      
      public var SecondHandMc:MovieClip;
      
      internal var m_time:int;
      
      public var Meter:MovieClip;
      
      internal var m_bEnd:Boolean;
      
      internal var m_totalTime:int;
      
      internal var m_bEnable:Boolean;
      
      public function CircleTimer()
      {
         super();
         this.m_maskShape = new Shape();
         this.m_maskShape.graphics.clear();
         Object(this).MaskMc.addChild(this.m_maskShape);
         addEventListener(Event.ENTER_FRAME,this._enterFrame);
         this.m_bEnable = false;
      }
      
      public function release() : void
      {
         removeEventListener(Event.ENTER_FRAME,this._enterFrame);
      }
      
      public function Start(param1:int, param2:Function) : void
      {
         this.Meter.gotoAndStop(1);
         this.m_totalTime = param1 * 1000;
         this.m_start = getTimer();
         this.m_bEnable = true;
         this.m_bEnd = false;
         this.m_endCall = param2;
      }
      
      public function isEnable() : Boolean
      {
         return this.m_bEnable;
      }
      
      private function _drawTimer(param1:int) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc8_:Vector.<int> = null;
         var _loc4_:Number = param1 * Math.PI * 2 / this.m_totalTime;
         var _loc5_:Number = this.m_totalTime / 4;
         var _loc6_:Number = this.Meter.height;
         Object(this).SecondHandMc.rotation = 360 * param1 / this.m_totalTime;
         _loc2_ = Math.sin(_loc4_) * _loc6_;
         _loc3_ = -Math.cos(_loc4_) * _loc6_;
         this.m_maskShape.graphics.clear();
         this.m_maskShape.graphics.beginFill(16711680);
         var _loc7_:Vector.<Number> = Vector.<Number>([0,0,0,-_loc6_,_loc6_,0,0,_loc6_,-_loc6_,0,_loc2_,_loc3_]);
         if(_loc5_ > param1)
         {
            _loc8_ = Vector.<int>([0,1,5]);
         }
         else if(_loc5_ * 2 > param1)
         {
            _loc8_ = Vector.<int>([0,1,2,0,2,5]);
         }
         else if(_loc5_ * 3 > param1)
         {
            _loc8_ = Vector.<int>([0,1,2,0,2,3,0,3,5]);
         }
         else
         {
            _loc8_ = Vector.<int>([0,1,2,0,2,3,0,3,4,0,4,5]);
         }
         this.m_maskShape.graphics.drawTriangles(_loc7_,_loc8_);
         this.m_maskShape.graphics.endFill();
      }
      
      private function _enterFrame(param1:Event) : void
      {
         var _loc2_:* = undefined;
         if(this.m_bEnable)
         {
            this.m_time = getTimer();
            _loc2_ = this.m_time - this.m_start;
            this._drawTimer(_loc2_);
            if(_loc2_ >= this.m_totalTime)
            {
               this.Meter.gotoAndStop(1);
               this.m_endCall();
               this.m_bEnable = false;
               this.m_bEnd = true;
            }
            if(_loc2_ >= this.m_totalTime - 10000)
            {
               this.Meter.play();
            }
         }
      }
      
      public function Pause(param1:Boolean) : void
      {
         if(this.m_bEnd == false)
         {
            if(this.m_bEnable != param1)
            {
               this.m_bEnable = param1;
               if(this.m_bEnable == false)
               {
                  this.m_pauseTime = getTimer();
               }
               else
               {
                  this.m_start += getTimer() - this.m_pauseTime;
               }
            }
         }
      }
      
      public function Stop() : void
      {
         this.m_bEnable = false;
      }
   }
}

