package
{
   import fl.transitions.Tween;
   import fl.transitions.TweenEvent;
   import fl.transitions.easing.*;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import flash.media.Sound;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol28")]
   public class Barrel extends MovieClip
   {
      
      public var adhesion_MC:MovieClip;
      
      public var fricStarMc:MovieClip;
      
      private var m_tween:Tween;
      
      private var m_poiceData:PoiceData;
      
      public var barrel:MovieClip;
      
      public var scale_MC:MovieClip;
      
      private var m_mouseUpFunc:Function;
      
      public var timeStarMc:MovieClip;
      
      private var m_bMouseDown:Boolean = false;
      
      private var m_mouseOverFunc:Function;
      
      private var m_bEnable:Boolean;
      
      private var m_SeBarrelOn:Sound;
      
      private var m_tex:LoadSwfMovieClip;
      
      private var m_collision:MovieClip;
      
      public var collisionMc:MovieClip;
      
      private var m_bMouseOver:Boolean = false;
      
      private var m_mouseCursorFunc:Function;
      
      private var m_mouseDownFunc:Function;
      
      public function Barrel(param1:PoiceData, param2:Function, param3:Function, param4:Function, param5:Function)
      {
         var _loc6_:int = 0;
         this.m_SeBarrelOn = new SeBarrelRollOver();
         super();
         this.collisionMc.addEventListener(MouseEvent.MOUSE_OVER,this._mouseOver);
         this.collisionMc.addEventListener(MouseEvent.MOUSE_DOWN,this._mouseDown);
         this.collisionMc.addEventListener(MouseEvent.MOUSE_UP,this._mouseUp);
         this.collisionMc.addEventListener(MouseEvent.MOUSE_MOVE,this._mouseCursor);
         this.collisionMc.addEventListener(MouseEvent.MOUSE_OUT,this._mouseOut);
         this.m_collision = this.collisionMc;
         this.m_poiceData = param1;
         this.m_tex = param1.LoadTexture();
         this.m_tex.setLoadCallBack(this._loadEndCallBack);
         this.m_mouseOverFunc = param2;
         this.m_mouseDownFunc = param3;
         this.m_mouseUpFunc = param4;
         this.m_mouseCursorFunc = param5;
         _loc6_ = Math.min(param1.fric_top * 100000 / 12,5) + 1;
         _loc6_ = Math.max(_loc6_,2);
         this.fricStarMc.gotoAndStop(_loc6_);
         if(param1.mag < 1.1)
         {
            _loc6_ = 2;
         }
         else if(param1.mag < 1.6)
         {
            _loc6_ = 3;
         }
         else if(param1.mag < 2.1)
         {
            _loc6_ = 4;
         }
         else if(param1.mag < 2.6)
         {
            _loc6_ = 5;
         }
         else
         {
            _loc6_ = 6;
         }
         this.timeStarMc.gotoAndStop(_loc6_);
         this.m_bEnable = false;
      }
      
      public function enable(param1:Boolean) : void
      {
         this.m_bEnable = param1;
         this.m_bMouseDown = false;
      }
      
      protected function _releaseTween() : void
      {
         if(this.m_tween != null)
         {
            this.m_tween.removeEventListener(TweenEvent.MOTION_CHANGE,this._rewind);
            this.m_tween.stop();
            this.m_tween = null;
         }
      }
      
      public function isMouseOver() : Boolean
      {
         return this.m_bMouseOver;
      }
      
      public function get fric_side() : Number
      {
         return this.m_poiceData.fric_side;
      }
      
      protected function _rewind(param1:TweenEvent) : void
      {
         this.m_collision.x = x;
      }
      
      public function release() : void
      {
         this._releaseTween();
         this.collisionMc.removeEventListener(MouseEvent.MOUSE_OVER,this._mouseOver);
         this.collisionMc.removeEventListener(MouseEvent.MOUSE_DOWN,this._mouseDown);
         this.collisionMc.removeEventListener(MouseEvent.MOUSE_UP,this._mouseUp);
         this.collisionMc.removeEventListener(MouseEvent.MOUSE_MOVE,this._mouseCursor);
         this.collisionMc.removeEventListener(MouseEvent.MOUSE_OUT,this._mouseOut);
      }
      
      protected function _createTween(param1:Number) : void
      {
         this._releaseTween();
         this.m_tween = new Tween(this,"x",Strong.easeOut,x,param1,15,false);
         this.m_tween.addEventListener(TweenEvent.MOTION_CHANGE,this._rewind);
      }
      
      public function setPos(param1:Number) : void
      {
         y = param1;
         this.m_collision.y = param1;
      }
      
      private function _mouseOver(param1:MouseEvent) : void
      {
         if(this.m_bEnable == false)
         {
            return;
         }
         this.m_mouseOverFunc(this,param1);
         this.m_bMouseOver = true;
      }
      
      private function _mouseCursor(param1:MouseEvent) : void
      {
         if(this.m_bEnable == false)
         {
            return;
         }
         this.m_mouseCursorFunc(param1);
      }
      
      public function moveOut() : void
      {
         this._createTween(-36);
         this.m_bMouseDown = false;
      }
      
      private function _mouseOut(param1:MouseEvent) : void
      {
         if(this.m_bEnable == false)
         {
            return;
         }
         if(this.m_bMouseDown == false)
         {
            this.moveOut();
         }
         this.m_bMouseOver = false;
      }
      
      public function get mag() : Number
      {
         return this.m_poiceData.mag;
      }
      
      public function setChild(param1:MovieClip, param2:int) : void
      {
         param1.addChildAt(this,param2);
         param1.addChild(this.m_collision);
         this.m_collision.x = x;
         this.m_collision.y = y;
      }
      
      protected function _loadEndCallBack(param1:LoadSwfMovieClip) : void
      {
         var _loc2_:MovieClip = this.m_tex.m_lpMovieClip;
         var _loc3_:Shape = _loc2_.tex.image.getChildAt(0) as Shape;
         _loc2_.tex.image.removeChild(_loc3_);
         var _loc4_:BitmapData = new BitmapData(64,64);
         _loc4_.draw(_loc3_);
         var _loc5_:Shape = new Shape();
         _loc5_.graphics.clear();
         _loc5_.graphics.beginBitmapFill(_loc4_,null,true,true);
         _loc5_.graphics.drawRect(0,0,this.barrel.width,this.barrel.height);
         _loc5_.graphics.endFill();
         this.barrel.tex.addChild(_loc5_);
      }
      
      public function isMouseDown() : Boolean
      {
         return this.m_bMouseDown;
      }
      
      public function moveIn() : void
      {
         this._createTween(-36);
      }
      
      private function _mouseDown(param1:MouseEvent) : void
      {
         if(this.m_bEnable == false)
         {
            return;
         }
         this.m_mouseDownFunc(this.m_poiceData.no,this.m_poiceData.LoadTexture(),param1);
         this.m_bMouseDown = true;
      }
      
      private function _mouseUp(param1:MouseEvent) : void
      {
         if(this.m_bEnable == false)
         {
            return;
         }
         this.m_mouseUpFunc(param1);
      }
      
      public function get fric_top() : Number
      {
         return this.m_poiceData.fric_top;
      }
   }
}

