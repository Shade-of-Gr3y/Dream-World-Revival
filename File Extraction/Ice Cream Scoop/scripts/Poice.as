package
{
   import fl.transitions.Tween;
   import fl.transitions.easing.*;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   
   public class Poice extends MovieClip
   {
      
      public static const Margin:* = 20;
      
      public static const Gravity:* = 0.098;
      
      public static const solidFreeForce:* = 2.5;
      
      public static const solidTime:* = 128;
      
      public static const SolidTypeFriction:* = 0;
      
      public static const SolidTypeSinks:* = 1;
      
      public static const SolidTypeStop:* = 2;
      
      public static const SolidTypeSolid:* = 3;
      
      public static const SNOW_L:* = 0;
      
      public static const SNOW_S:* = 1;
      
      protected var m_beforePos:Vec2;
      
      protected var m_fric_top:Number;
      
      protected var m_seLanding:SeLanding;
      
      protected var m_bLoad:Boolean;
      
      protected var m_imageShape:Shape;
      
      protected var m_debugShape:Shape;
      
      protected var m_bFriction:Boolean;
      
      protected var m_plateHit:Boolean;
      
      protected var m_solidPos:Vec2;
      
      protected var m_texture:MovieClip;
      
      protected var m_solidType:int;
      
      protected var m_bMelt:Boolean;
      
      protected var m_FrictionAdd:Number;
      
      protected var m_addAccel:Vec2;
      
      protected var m_solid:Boolean;
      
      protected var m_bHit:Boolean;
      
      protected var m_radForce:Number;
      
      protected var m_bAdd:Boolean;
      
      protected var m_lineColor:uint;
      
      protected var m_debugDisplay:Boolean = false;
      
      protected var m_exMarkMc:MovieClip;
      
      protected var m_flashTween:Tween;
      
      protected var m_size:Number;
      
      protected var m_exSnowWait:int;
      
      protected var m_accel:Vec2;
      
      protected var m_aHitPoice:Array;
      
      protected var m_flashShape:Shape;
      
      protected var m_seSolid:SeSolid;
      
      protected var m_Friction:Number;
      
      protected var m_plusY:Number;
      
      protected var m_bmpShape:Sprite;
      
      protected var m_bmp:BitmapData;
      
      protected var m_maskMc:MovieClip;
      
      protected var m_bFirctionReset:Boolean;
      
      protected var m_textureBase:LoadSwfMovieClip;
      
      protected var m_fric_side:Number;
      
      protected var m_margin:Number;
      
      protected var m_plusNum:Number;
      
      protected var m_bNotScaffold:Boolean;
      
      protected var m_solidTime:Number;
      
      protected var m_type:int;
      
      protected var m_flashMc:MovieClip;
      
      protected var m_plusAdd:Number;
      
      protected var m_textureShape:MovieClip;
      
      protected var m_aMelt:Array;
      
      protected var m_bSolidTime:Boolean;
      
      protected var m_exMarkWait:int;
      
      protected var m_free:Boolean;
      
      public function Poice(param1:int, param2:LoadSwfMovieClip)
      {
         super();
         this.m_textureBase = param2;
         this.m_textureBase.setLoadCallBack(this._loadEndCallBack);
         this.m_textureShape = this._getPoiceShape();
         this.m_bmpShape = new Sprite();
         this.m_bmp = null;
         this.m_debugShape = new Shape();
         addChild(this.m_debugShape);
         this.m_seSolid = new SeSolid();
         this.m_seLanding = new SeLanding();
         this.m_type = param1;
         this.m_size = 10;
         this.m_free = false;
         this.m_solid = false;
         this.m_Friction = 0;
         this.m_accel = new Vec2();
         this.m_addAccel = new Vec2();
         this.m_solidPos = new Vec2();
         this.m_beforePos = new Vec2();
         this.m_margin = 0;
         this.m_plusAdd = 0;
         this.m_plusNum = 0;
         this.m_plusY = 0;
         this.m_exMarkWait = 0;
         this.m_exSnowWait = 0;
      }
      
      public function get size() : Number
      {
         return this.m_size + this.m_margin - this.m_plusY;
      }
      
      public function isHit() : Boolean
      {
         return this.m_bHit;
      }
      
      protected function _create(param1:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:DropShadowFilter = null;
         var _loc5_:GlowFilter = null;
         var _loc2_:* = this.size;
         if(this.m_texture != null)
         {
            _loc3_ = _loc2_ + 5;
            if(this.m_texture.filters.length != 0)
            {
               _loc4_ = this.m_texture.filters[0] as DropShadowFilter;
               _loc5_ = this.m_texture.filters[1] as GlowFilter;
               _loc4_.blurX = param1 / 2;
               _loc4_.blurY = param1 / 2;
               _loc4_.distance = param1 / 2;
               this.m_texture.filters = [_loc4_,_loc5_];
            }
            this.m_bmpShape.graphics.clear();
            this.m_bmpShape.graphics.beginBitmapFill(this.m_bmp,null,true,true);
            this.m_bmpShape.graphics.drawCircle(0,0,_loc3_ + _loc2_ / 3);
            this.m_bmpShape.graphics.endFill();
            this.m_textureShape.width = _loc3_ * 2;
            this.m_textureShape.height = _loc3_ * 2;
            if(this.m_flashMc == null)
            {
               this.m_flashMc = new MovieClip();
               this.m_flashShape = new Shape();
               this.m_flashMc.addChild(this.m_flashShape);
               this.m_texture.tex.addChild(this.m_flashMc);
               this.m_flashMc.alpha = 0;
            }
            this.m_flashShape.graphics.clear();
            this.m_flashShape.graphics.beginFill(16777215);
            this.m_flashShape.graphics.drawCircle(0,0,_loc3_ + _loc2_ / 3);
            this.m_flashShape.graphics.endFill();
            addChild(this.m_texture);
            this.m_texture.tex.image.rotation += 1;
         }
         addChild(this.m_debugShape);
      }
      
      public function Addition(param1:Number) : void
      {
         this.m_size = param1;
         this.m_margin = Math.min(this.m_size / 100 * Margin,10);
         this._create(this.m_size);
      }
      
      public function setPlateHit(param1:Boolean) : void
      {
         this.m_plateHit = param1;
      }
      
      public function getReflection(param1:Poice) : Vec2
      {
         var _loc3_:Vec2 = null;
         var _loc4_:Vec2 = null;
         var _loc5_:* = undefined;
         var _loc6_:Number = NaN;
         var _loc7_:* = undefined;
         var _loc2_:Vec2 = this.GetNearPosition(param1);
         if(_loc2_ != null)
         {
            this.setHit(_loc2_,param1);
            param1.setHit(_loc2_,this);
            _loc3_ = new Vec2();
            _loc3_.Set(param1.x - x,param1.y - y);
            _loc3_.Normalize();
            _loc4_ = new Vec2();
            _loc4_.Set(this.m_accel.x - param1.accel.x,this.m_accel.y - param1.accel.y);
            _loc5_ = _loc4_.LengthProduct();
            _loc4_.Normalize();
            _loc6_ = _loc4_.InnerProduct(_loc3_);
            if(_loc6_ < 0)
            {
               return null;
            }
            if(_loc5_ > 0)
            {
               _loc3_.Scale(-_loc5_ * _loc6_);
               if(this.m_exSnowWait == 0)
               {
                  _loc7_ = _loc3_.LengthProduct();
                  if(_loc7_ > solidFreeForce)
                  {
                     this._addEffectSnow(SNOW_L,_loc2_);
                  }
                  else if(_loc7_ > solidFreeForce / 2)
                  {
                     this._addEffectSnow(SNOW_S,_loc2_);
                  }
                  this.m_exSnowWait = 10;
               }
               return _loc3_;
            }
         }
         return null;
      }
      
      private function _addMeltPoice(param1:Number, param2:Number) : void
      {
         if(param2 < y)
         {
            return;
         }
         var _loc3_:meltPoice = new meltPoice();
         var _loc4_:Number = this.maxSize / 10;
         _loc4_ = Math.max(_loc4_,6);
         var _loc5_:Number = _loc4_ + Math.random() * this.maxSize / 15;
         _loc3_.pos.Set(param1 - x,param2 - y);
         _loc3_.create(_loc5_,this.m_size + this.m_margin);
         this.m_aMelt.push(_loc3_);
         this.m_maskMc.addChild(_loc3_);
      }
      
      public function debugDisplayMode(param1:Boolean) : void
      {
         if(comDefine.DEBUG)
         {
            this.m_debugDisplay = param1;
            this.m_debugShape.visible = param1;
            this._debugLine(new Vec2());
         }
      }
      
      private function _addEffectSnow(param1:int, param2:Vec2) : *
      {
         var _loc3_:MovieClip = null;
         if(param1 == SNOW_L)
         {
            _loc3_ = new snow_l();
         }
         else
         {
            _loc3_ = new snow_s();
         }
         parent.addChild(_loc3_);
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         this.m_seLanding.play();
      }
      
      public function isLoad() : Boolean
      {
         return this.m_bLoad;
      }
      
      public function isDrop(param1:Poice) : Boolean
      {
         this.overRevision(param1);
         return param1.isSolid();
      }
      
      public function get type() : int
      {
         return this.m_type;
      }
      
      private function _procMeltPoice() : void
      {
         var _loc1_:meltPoice = null;
         for each(_loc1_ in this.m_aMelt)
         {
            _loc1_.move();
         }
      }
      
      protected function _loadEndCallBack(param1:LoadSwfMovieClip) : void
      {
         var _loc2_:DropShadowFilter = null;
         var _loc3_:GlowFilter = null;
         this.m_texture = this.m_textureBase.m_lpMovieClip;
         if(this.m_texture.tex.filters.length != 0)
         {
            _loc2_ = this.m_texture.tex.filters[0] as DropShadowFilter;
            _loc3_ = this.m_texture.tex.filters[1] as GlowFilter;
            this.m_texture.tex.filters = null;
            if(_loc3_ != null)
            {
               this.m_lineColor = _loc3_.color;
            }
            this.m_texture.filters = [_loc2_,_loc3_];
         }
         this.m_maskMc = new MovieClip();
         this.m_maskMc.addChild(this.m_textureShape);
         this.m_texture.tex.maskMc.addChild(this.m_maskMc);
         this.m_texture.cacheAsBitmap = true;
         this.m_imageShape = this.m_texture.tex.image.getChildAt(0) as Shape;
         this.m_texture.tex.image.removeChild(this.m_imageShape);
         this.m_bmp = new BitmapData(64,64);
         this.m_bmp.draw(this.m_imageShape);
         this.m_texture.tex.image.addChild(this.m_bmpShape);
         this.m_bLoad = true;
      }
      
      public function setSolid(param1:int, param2:Boolean = true) : void
      {
         if(this.m_bNotScaffold == true)
         {
            return;
         }
         if(this.m_solid == false || this.m_solidType != param1)
         {
            this.m_solid = true;
            this.m_solidPos.x = x;
            this.m_solidPos.y = y;
            this._setMeltPoice();
            if(this.m_flashMc != null)
            {
               if(this.m_flashTween != null)
               {
                  this.m_flashTween.stop();
                  this.m_flashTween = null;
               }
               this.m_flashTween = new Tween(this.m_flashMc,"alpha",Strong.easeInOut,0.5,0,20,false);
               if(this.m_exMarkWait == 0)
               {
                  this.m_seSolid.play();
               }
            }
         }
         this.m_solidType = param1;
         if(param2 == true)
         {
            this.m_accel.x = 0;
            this.m_accel.y = 0;
         }
      }
      
      public function setFric(param1:Number, param2:Number) : void
      {
         this.m_fric_top = param1;
         this.m_fric_side = param2;
      }
      
      protected function _rotationTexture() : void
      {
         var _loc1_:Vec2 = null;
         var _loc2_:Vec2 = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(this.m_solid != true && this.m_bFriction != false)
         {
            _loc1_ = new Vec2();
            _loc2_ = new Vec2();
            _loc1_.Set(0,1);
            _loc2_.Set(x - this.m_beforePos.x,y - this.m_beforePos.y);
            _loc3_ = _loc2_.InnerProduct(_loc1_);
            _loc4_ = _loc2_.LengthProduct();
            if(this.m_accel.x > 0)
            {
               this.m_radForce = _loc4_;
            }
            else if(this.m_accel.x < 0)
            {
               this.m_radForce = -_loc4_;
            }
            else
            {
               this.m_radForce = 0;
            }
         }
         else if(this.isHit() != false)
         {
            this.m_radForce -= this.m_radForce / 20;
         }
         if(this.m_solid == false)
         {
            if(Math.abs(this.m_radForce) > 0.5)
            {
               this.m_texture.tex.image.rotation += this.m_radForce;
            }
            else
            {
               this.m_radForce = 0;
            }
         }
      }
      
      private function _resetMeltPoice() : void
      {
         var _loc1_:meltPoice = null;
         for each(_loc1_ in this.m_aMelt)
         {
            _loc1_.bSolid = false;
         }
         this.m_bMelt = false;
      }
      
      public function mulAccel(param1:Number) : void
      {
         this.m_addAccel.Scale(param1);
      }
      
      public function get maxSize() : Number
      {
         return this.m_size + this.m_margin + 5;
      }
      
      public function click() : void
      {
         this.m_free = true;
         this.m_bMelt = false;
         this.m_aHitPoice = new Array();
         this.m_aMelt = new Array();
      }
      
      private function _setMeltPoice() : void
      {
         var _loc1_:Poice = null;
         var _loc2_:* = undefined;
         var _loc3_:Vec2 = null;
         var _loc4_:Vec2 = null;
         var _loc5_:Vec2 = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Vec2 = null;
         var _loc11_:Vec2 = null;
         if(this.m_bMelt == true)
         {
            return;
         }
         for each(_loc1_ in this.m_aHitPoice)
         {
            _loc2_ = this.maxSize + _loc1_.maxSize;
            _loc3_ = new Vec2();
            _loc4_ = new Vec2();
            _loc3_.Set(x,y);
            _loc4_.Set(_loc1_.x,_loc1_.y);
            _loc5_ = _loc4_.GetSubtract(_loc3_);
            _loc6_ = _loc5_.LengthProduct();
            if(_loc6_ == _loc2_)
            {
               _loc5_.Normalize();
               _loc5_.Scale(this.maxSize);
               _loc5_.x += _loc3_.x;
               _loc5_.y += _loc3_.y;
               this._addMeltPoice(_loc5_.x,_loc5_.y);
            }
            else if(_loc6_ < _loc2_ && _loc6_ > Math.abs(this.maxSize - _loc1_.maxSize))
            {
               _loc7_ = 0.5 * (this.maxSize * this.maxSize - _loc1_.maxSize * _loc1_.maxSize + _loc6_ * _loc6_) / _loc6_;
               _loc8_ = Math.acos(_loc7_ / this.maxSize);
               _loc9_ = Math.atan2(_loc5_.y,_loc5_.x);
               _loc10_ = new Vec2();
               _loc11_ = new Vec2();
               _loc10_.Set(x + this.maxSize * Math.cos(_loc9_ + _loc8_),y + this.maxSize * Math.sin(_loc9_ + _loc8_));
               _loc11_.Set(x + this.maxSize * Math.cos(_loc9_ - _loc8_),y + this.maxSize * Math.sin(_loc9_ - _loc8_));
               this._addMeltPoice(_loc10_.x,_loc10_.y);
               this._addMeltPoice(_loc11_.x,_loc11_.y);
               _loc5_ = _loc10_.GetSubtract(_loc11_);
               _loc7_ = _loc5_.LengthProduct();
               _loc5_.Normalize();
               _loc5_.Scale(Math.random() * _loc7_);
               this._addMeltPoice(_loc11_.x + _loc5_.x,_loc11_.y + _loc5_.y);
            }
            this.m_bMelt = true;
         }
      }
      
      public function setPos(param1:Number, param2:Number) : void
      {
         x = param1;
         y = param2;
      }
      
      public function resetSolid() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:Number = NaN;
         if(this.m_solidType != SolidTypeSolid)
         {
            this.m_solid = false;
            this._resetMeltPoice();
            if(this.m_exMarkWait == 0)
            {
               _loc1_ = new exMarkMc();
               addChild(_loc1_);
               _loc2_ = width * 1.1;
               _loc1_.height = width * _loc1_.height / _loc1_.width;
               _loc1_.width = _loc2_;
               this.m_exMarkWait = 10;
            }
         }
         this.fric = 0;
      }
      
      public function isSolid() : Boolean
      {
         return this.m_solid;
      }
      
      protected function _solidTime() : void
      {
         ++this.m_solidTime;
         if(this.m_solid == false)
         {
            if(this.m_accel.LengthProduct() < 0.2)
            {
               if(this.m_bSolidTime == false)
               {
                  this.m_bSolidTime = true;
                  this.m_solidTime = 0;
               }
               else if(this.m_solidTime == solidTime)
               {
                  this.setSolid(SolidTypeStop);
                  this.m_bSolidTime = false;
               }
            }
            else
            {
               this.m_bSolidTime = false;
               this.m_solidTime = 0;
            }
         }
      }
      
      protected function _debugLine(param1:Vec2) : void
      {
         if(this.m_debugDisplay == false)
         {
            return;
         }
         this.m_debugShape.graphics.clear();
         this.m_debugShape.graphics.lineStyle(1,6684672);
         this.m_debugShape.graphics.drawCircle(0,0,this.fric * 200);
         this.m_debugShape.graphics.lineStyle(1,65280);
         this.m_debugShape.graphics.drawCircle(0,0,this.m_size);
         this.m_debugShape.graphics.lineStyle(1,255);
         this.m_debugShape.graphics.drawCircle(0,0,this.size);
         this.m_debugShape.graphics.lineStyle(4,65280);
         this.m_debugShape.graphics.moveTo(0,0);
         this.m_debugShape.graphics.lineTo((this.m_accel.x + param1.x) * 10,(this.m_accel.y + param1.y) * 10);
         this.m_debugShape.graphics.lineStyle(2,255);
         this.m_debugShape.graphics.moveTo(0,0);
         this.m_debugShape.graphics.lineTo(this.m_accel.x * 10,this.m_accel.y * 10);
         this.m_debugShape.graphics.lineStyle(1,16711680);
         this.m_debugShape.graphics.moveTo(0,0);
         this.m_debugShape.graphics.lineTo(param1.x * 10,param1.y * 10);
      }
      
      public function addAccel(param1:Vec2) : void
      {
         this.m_addAccel.Add(param1);
         this.m_bAdd = true;
      }
      
      public function set fric(param1:Number) : void
      {
         this.m_Friction = Math.max(Math.min(param1,0.05),0);
      }
      
      public function GetNearPosition(param1:Poice) : Vec2
      {
         var _loc2_:Vec2 = new Vec2();
         var _loc3_:Vec2 = new Vec2();
         var _loc4_:Vec2 = new Vec2();
         var _loc5_:Number = 1;
         _loc2_.Set(param1.x,param1.y);
         _loc3_.Set(x,y);
         _loc4_.Set(param1.x,param1.y);
         _loc4_.Subtract(_loc3_);
         var _loc6_:Number = Math.floor(_loc4_.LengthProduct());
         var _loc7_:Number = Math.floor(this.size + param1.size + _loc5_);
         if(_loc6_ > Math.floor(this.size + param1.size + _loc5_))
         {
            return null;
         }
         _loc4_.Normalize();
         _loc4_.Scale((this.size + param1.size) / 2);
         _loc4_.Add(_loc3_);
         return _loc4_;
      }
      
      public function overRevision(param1:Poice) : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc4_:Vec2 = null;
         var _loc5_:* = undefined;
         var _loc6_:Vec2 = null;
         var _loc7_:Vec2 = null;
         var _loc8_:Vec2 = null;
         if(param1.isSolid() == true && this.isSolid() == true)
         {
            return false;
         }
         var _loc2_:Vec2 = this.GetNearPosition(param1);
         if(_loc2_ != null)
         {
            _loc3_ = param1.size + this.size;
            _loc4_ = new Vec2();
            _loc5_ = param1.size + this.size;
            _loc6_ = new Vec2();
            _loc4_.Set(param1.x - x,param1.y - y);
            if(_loc4_.LengthProduct() < _loc5_ - _loc5_ / 7)
            {
               this.setSolid(SolidTypeSinks);
               param1.setSolid(SolidTypeSinks);
               return false;
            }
            _loc6_ = _loc4_.GetNormal();
            _loc6_.Scale(_loc5_);
            _loc6_.Subtract(_loc4_);
            _loc7_ = new Vec2();
            _loc8_ = new Vec2();
            _loc7_ = _loc6_.GetScale(this.size / _loc3_);
            _loc8_ = _loc6_.GetSubtract(_loc7_);
            if(param1.isSolid() == true && this.isSolid() == false)
            {
               x -= _loc6_.x;
               y -= _loc6_.y;
               return true;
            }
            if(param1.isSolid() == false && this.isSolid() == true)
            {
               param1.x += _loc6_.x;
               param1.y += _loc6_.y;
               return true;
            }
            x -= _loc7_.x;
            y -= _loc7_.y;
            param1.x += _loc8_.x;
            param1.y += _loc8_.y;
            return true;
         }
         return false;
      }
      
      public function setHit(param1:Vec2, param2:Poice = null) : void
      {
         var _loc3_:Vec2 = new Vec2();
         _loc3_.Set(0,1);
         var _loc4_:Vec2 = new Vec2();
         _loc4_.Set(x - param1.x,y - param1.y);
         _loc4_.Normalize();
         var _loc5_:Number = Math.abs(_loc3_.InnerProduct(_loc4_));
         if(_loc5_ > 0.6)
         {
            this.m_bFriction = true;
         }
         if(_loc5_ > 0.8)
         {
            this.m_FrictionAdd += this.m_fric_top * _loc5_;
         }
         else if(_loc5_ > 0.6)
         {
            this.m_FrictionAdd += this.m_fric_side * _loc5_;
         }
         else
         {
            this.m_bFirctionReset = true;
         }
         this.m_bHit = true;
         if(param2 != null && this.m_aHitPoice != null)
         {
            if(y <= param2.y)
            {
               this.m_aHitPoice.push(param2);
            }
         }
      }
      
      public function getOrgSize() : Number
      {
         return this.m_size;
      }
      
      public function resetAccel() : void
      {
         this.m_addAccel.x = 0;
         this.m_addAccel.y = 0;
         this.m_FrictionAdd = 0;
         this.m_bFirctionReset = false;
         if(this.m_solid == false)
         {
            this.m_accel.y += Gravity;
         }
         this.m_aHitPoice.splice(0);
         this.m_bAdd = false;
         this.m_bHit = false;
         this.m_plateHit = false;
         this.m_bFriction = false;
      }
      
      private function _getPoiceShape() : MovieClip
      {
         var _loc1_:int = Math.floor(Math.random() * 8);
         switch(_loc1_)
         {
            case 0:
               return new poiceShape01();
            case 1:
               return new poiceShape02();
            case 2:
               return new poiceShape03();
            case 3:
               return new poiceShape04();
            case 4:
               return new poiceShape05();
            case 5:
               return new poiceShape06();
            case 6:
               return new poiceShape07();
            default:
               return new poiceShape08();
         }
      }
      
      public function get fric() : Number
      {
         return this.m_Friction;
      }
      
      public function isPlateHit() : Boolean
      {
         return this.m_plateHit;
      }
      
      public function get accel() : Vec2
      {
         var _loc1_:Vec2 = null;
         if(this.isSolid() == true)
         {
            _loc1_ = new Vec2();
            _loc1_.x = 0;
            _loc1_.y = 0;
            return _loc1_;
         }
         return this.m_accel;
      }
      
      public function commitAccel() : void
      {
         var _loc1_:Vec2 = null;
         this._debugLine(this.m_addAccel);
         if(this.m_bFirctionReset == true && this.m_FrictionAdd == 0)
         {
            this.fric = 0;
            this.m_plusAdd = 0;
            this.m_plusNum = 0;
         }
         else
         {
            this.fric += this.m_FrictionAdd;
         }
         if(this.m_solid == false)
         {
            if(this.m_free)
            {
               this.m_accel.Add(this.m_addAccel);
               if(this.m_accel.LengthProduct() > 0.01)
               {
                  _loc1_ = this.m_accel.GetNormal();
                  _loc1_.Scale(-1);
                  _loc1_.Scale(this.m_accel.LengthProduct() * this.m_Friction);
                  this.m_accel.Add(_loc1_);
                  if(this.m_solid == false)
                  {
                     x += this.m_accel.x;
                     y += this.m_accel.y;
                  }
                  else
                  {
                     this.m_accel.Scale(0.5);
                  }
               }
            }
         }
         else if(this.m_addAccel.LengthProduct() > solidFreeForce && this.isSolid() == true)
         {
            this.resetSolid();
            this.m_plusNum = 0;
         }
         if(this.fric > 0.04)
         {
            this.m_plusAdd += this.m_margin / 2000;
            this.m_plusNum += this.m_plusAdd;
            this.m_plusNum = Math.min(this.m_margin,this.m_plusNum);
            this.m_plusAdd = Math.min(this.m_margin,this.m_plusAdd);
            if(this.m_plusNum / 2 > this.m_plusY)
            {
               if(this.isSolid() == true)
               {
                  this.m_solidPos.y += this.m_plusNum / 2 - this.m_plusY;
               }
               this.m_plusY = this.m_plusNum / 2;
            }
            this.m_solidTime = 0;
         }
         if(this.m_accel.LengthProduct() > solidFreeForce && this.isHit() == false)
         {
            this.fric = 0;
         }
         if((this.isHit() == false || this.m_bFriction == false) && this.isSolid() == true)
         {
            this.m_plusNum = 0;
            this.resetSolid();
         }
         if(this.m_plusNum == this.m_margin && this.m_solid == false)
         {
            this.setSolid(SolidTypeFriction,false);
         }
         if(this.m_solid == true)
         {
            x = this.m_solidPos.x;
            y = this.m_solidPos.y;
            if(this.isHit() == true && this.m_aHitPoice.length == 0 && this.isPlateHit() == false)
            {
               this.resetSolid();
               this.m_bNotScaffold = true;
            }
         }
         else if(this.isHit() == true && this.m_aHitPoice.length != 0 && this.isPlateHit() == false)
         {
            this.m_bNotScaffold = false;
         }
         this._rotationTexture();
         this._solidTime();
         this._procMeltPoice();
         this.m_beforePos.Set(x,y);
         if(this.m_exMarkWait != 0)
         {
            --this.m_exMarkWait;
         }
         if(this.m_exSnowWait != 0)
         {
            --this.m_exSnowWait;
         }
      }
   }
}

