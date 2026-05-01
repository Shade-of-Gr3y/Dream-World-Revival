package
{
   import flash.display.MovieClip;
   import flash.display.Shape;
   
   public class Plate extends Poice
   {
      
      public static const plateSize:* = 86;
      
      public static const revisionHeight:* = 15;
      
      private var col_r:Poice;
      
      private var m_debugMaskMc:MovieClip = new MovieClip();
      
      private var col_l:Poice;
      
      private var m_debugMaskShape:Shape = new Shape();
      
      public function Plate()
      {
         super(0,new LoadSwfMovieClip());
         m_size = 99999;
         m_free = true;
         this._create(0);
         this.col_l = new Poice(0,new LoadSwfMovieClip());
         this.col_r = new Poice(0,new LoadSwfMovieClip());
         this.col_l.Addition(7);
         this.col_r.Addition(7);
         this.col_l.setSolid(SolidTypeSolid);
         this.col_r.setSolid(SolidTypeSolid);
         this.col_l.visible = true;
         this.col_r.visible = true;
      }
      
      override public function resetAccel() : void
      {
      }
      
      override public function getReflection(param1:Poice) : Vec2
      {
         var _loc4_:Vec2 = null;
         var _loc5_:* = undefined;
         var _loc6_:Number = NaN;
         var _loc2_:Vec2 = new Vec2();
         if(param1.y < this.colHeight - this.col_l.size)
         {
            _loc2_ = this.col_l.getReflection(param1);
            if(_loc2_ != null)
            {
               return _loc2_;
            }
            _loc2_ = this.col_r.getReflection(param1);
            if(_loc2_ != null)
            {
               return _loc2_;
            }
         }
         var _loc3_:Vec2 = this.GetNearPosition(param1);
         if(_loc3_ != null)
         {
            _loc3_.x -= x;
            _loc3_.y -= y;
            _loc3_.Normalize();
            _loc3_.Scale(plateSize);
            _loc3_.x += x;
            _loc3_.y += y;
            param1.setHit(_loc3_);
            param1.setPlateHit(true);
            _loc2_ = new Vec2();
            _loc2_.Set(param1.x - x,param1.y - y);
            _loc2_.Normalize();
            _loc4_ = new Vec2();
            _loc4_.Set(param1.accel.x,param1.accel.y);
            _loc5_ = _loc4_.LengthProduct();
            _loc4_.Normalize();
            _loc6_ = _loc4_.InnerProduct(_loc2_);
            if(_loc6_ < 0)
            {
               return null;
            }
            _loc2_.Scale(_loc5_ * _loc6_);
            if(_loc5_ > 0)
            {
               if(_loc2_.LengthProduct() > solidFreeForce / 2)
               {
                  m_seLanding.play();
               }
            }
            this._debugLine(_loc2_);
            return _loc2_;
         }
         return null;
      }
      
      override public function addAccel(param1:Vec2) : void
      {
      }
      
      override public function get size() : Number
      {
         return this.col_r.x - x + this.col_r.size;
      }
      
      private function _getNearPositionPlateOnly(param1:Poice) : Vec2
      {
         var _loc2_:* = Math.abs(param1.x - x);
         if(_loc2_ > plateSize)
         {
            return null;
         }
         var _loc3_:Vec2 = new Vec2();
         var _loc4_:Vec2 = new Vec2();
         var _loc5_:Vec2 = new Vec2();
         var _loc6_:Number = 1;
         _loc4_.Set(param1.x,param1.y);
         _loc5_.Set(x,y);
         _loc3_.Set(param1.x,param1.y);
         _loc3_.Subtract(_loc5_);
         var _loc7_:Number = _loc3_.LengthProduct();
         _loc7_ = _loc7_ + (param1.size + _loc6_);
         if(_loc7_ < plateSize)
         {
            return null;
         }
         _loc3_.Normalize();
         _loc4_ = _loc3_.GetScale(plateSize);
         _loc4_.Add(_loc5_);
         if(_loc4_.y < this.colHeight)
         {
            return null;
         }
         _loc3_.Scale(plateSize - param1.size);
         _loc3_.Add(_loc5_);
         return _loc3_;
      }
      
      override protected function _debugLine(param1:Vec2) : void
      {
         if(m_debugDisplay == false)
         {
            return;
         }
         var _loc2_:* = plateSize / 10;
         m_debugShape.graphics.clear();
         m_debugShape.graphics.lineStyle(1,6710886);
         m_debugShape.graphics.drawCircle(0,0,plateSize);
         addChild(m_debugShape);
         this.m_debugMaskShape.graphics.clear();
         this.m_debugMaskShape.graphics.beginFill(16711680);
         this.m_debugMaskShape.graphics.drawRect(-plateSize,revisionHeight,plateSize * 2,plateSize);
         this.m_debugMaskMc.addChild(this.m_debugMaskShape);
         addChild(this.m_debugMaskMc);
         mask = this.m_debugMaskMc;
         m_debugShape.graphics.lineStyle(1,6710886);
         m_debugShape.graphics.drawCircle(0,0,200);
         m_debugShape.graphics.lineStyle(4,16711680);
         m_debugShape.graphics.moveTo(0,0);
         m_debugShape.graphics.lineTo(param1.x * 100,param1.y * 100);
      }
      
      private function get colHeight() : Number
      {
         return y + revisionHeight;
      }
      
      override public function overRevision(param1:Poice) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:Vec2 = null;
         var _loc4_:Vec2 = null;
         var _loc5_:Vec2 = null;
         var _loc6_:Boolean = false;
         if(param1.y + param1.size > this.colHeight - this.col_l.size * 3)
         {
            _loc2_ = false;
            if(this.col_l.GetNearPosition(param1) != null && this.col_r.GetNearPosition(param1) != null)
            {
               param1.x = x;
               param1.setSolid(SolidTypeSolid);
               return false;
            }
            _loc3_ = this._getNearPositionPlateOnly(param1);
            if(_loc3_ != null)
            {
               _loc4_ = new Vec2();
               _loc5_ = new Vec2();
               _loc4_.Set(param1.x - x,param1.y - y);
               _loc5_ = _loc4_.GetNormal();
               _loc5_.Scale(plateSize - param1.size);
               if(param1.isSolid() == false)
               {
                  param1.x = _loc5_.x + x;
                  param1.y = _loc5_.y + y;
                  param1.accel.Scale(0.98);
               }
               return true;
            }
            if(y + plateSize > param1.y + param1.size)
            {
               _loc2_ = this.col_l.overRevision(param1);
               _loc6_ = this.col_r.overRevision(param1);
               _loc2_ ||= _loc6_;
            }
         }
         return false;
      }
      
      override public function commitAccel() : void
      {
      }
      
      override public function setPos(param1:Number, param2:Number) : void
      {
         x = param1;
         y = param2;
         var _loc3_:Vec2 = new Vec2();
         _loc3_.Set(plateSize,revisionHeight);
         _loc3_.Normalize();
         _loc3_.Scale(plateSize);
         this.col_l.x = x - _loc3_.x - this.col_l.size;
         this.col_r.x = x + _loc3_.x + this.col_r.size;
         this.col_l.y = y + _loc3_.y;
         this.col_r.y = y + _loc3_.y;
         parent.addChild(this.col_l);
         parent.addChild(this.col_r);
      }
      
      override public function GetNearPosition(param1:Poice) : Vec2
      {
         var _loc2_:Vec2 = null;
         if(param1.y < this.colHeight)
         {
            _loc2_ = this.col_l.GetNearPosition(param1);
            if(_loc2_ != null)
            {
               return _loc2_;
            }
            _loc2_ = this.col_r.GetNearPosition(param1);
            if(_loc2_ != null)
            {
               return _loc2_;
            }
         }
         return this._getNearPositionPlateOnly(param1);
      }
      
      override public function isDrop(param1:Poice) : Boolean
      {
         if(param1.y + param1.size > this.colHeight)
         {
            if(Math.abs(param1.x - x) > plateSize + param1.size)
            {
               return true;
            }
            if(this.col_l.GetNearPosition(param1) != null || this.col_r.GetNearPosition(param1) != null)
            {
               return true;
            }
            if(param1.y + param1.size > this.colHeight + 20)
            {
               return true;
            }
         }
         return false;
      }
      
      override protected function _create(param1:Number) : void
      {
      }
      
      override public function debugDisplayMode(param1:Boolean) : void
      {
         if(comDefine.DEBUG)
         {
            super.debugDisplayMode(param1);
            this.col_l.debugDisplayMode(param1);
            this.col_r.debugDisplayMode(param1);
         }
      }
   }
}

