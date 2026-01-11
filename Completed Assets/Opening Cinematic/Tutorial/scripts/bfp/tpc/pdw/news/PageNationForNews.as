package bfp.tpc.pdw.news
{
   import bfp.PDWBridge;
   import bfp.tpc.pdw.common.PageNumber;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   
   public class PageNationForNews extends Sprite
   {
       
      
      private var _total:int;
      
      private var _length:int;
      
      private var _rect:Rectangle;
      
      private var _defaultSelect:int;
      
      private var _select:int;
      
      private var _isIndex:Boolean;
      
      private var _container:Sprite;
      
      private var _pageNumbers:Array;
      
      private var _prevmc:Sprite;
      
      private var _nextmc:Sprite;
      
      public function PageNationForNews(param1:uint = 10, param2:uint = 6, param3:Rectangle = null, param4:uint = 1, param5:Boolean = false)
      {
         super();
         this.tabEnabled = false;
         this.tabChildren = false;
         this._pageNumbers = [];
         this._container = new Sprite();
         addChild(this._container);
         if(param1 > param2 && param2 < 5)
         {
            throw new Error("パラメーター total が length を超える場合、length は 5 以上を指定してください");
         }
         if(!param3)
         {
            this._rect = new Rectangle(0,0,298,20);
         }
         else
         {
            this._rect = param3;
         }
         this._isIndex = param5;
         this._total = param1;
         this._defaultSelect = param4;
         this._length = param2;
         this._select = this._defaultSelect;
         this._prevmc = new AssetPrevNews();
         addChild(this._prevmc);
         this._prevmc.name = "prevmc";
         this._prevmc.x = 10;
         this.setBtn(this._prevmc,{
            "over":this.mouseOverHandler2,
            "out":this.mouseOutHandler2,
            "click":this.clickHandler2
         });
         this._nextmc = new AssetNextNews();
         addChild(this._nextmc);
         this._nextmc.name = "nextmc";
         this._nextmc.x = this._rect.width - this._nextmc.width - 10;
         this.setBtn(this._nextmc,{
            "over":this.mouseOverHandler2,
            "out":this.mouseOutHandler2,
            "click":this.clickHandler2
         });
         this.update();
      }
      
      public function get select() : int
      {
         return this._select;
      }
      
      public function set select(param1:int) : void
      {
         this._select = param1;
         this.update();
      }
      
      public function release() : void
      {
         this.clear();
         if(this._container)
         {
            removeChild(this._container);
            this._container = null;
         }
         if(this._prevmc)
         {
            removeChild(this._prevmc);
            this.unsetBtn(this._prevmc,{
               "over":this.mouseOverHandler2,
               "out":this.mouseOutHandler,
               "click":this.clickHandler
            });
            this._prevmc = null;
         }
         if(this._nextmc)
         {
            removeChild(this._nextmc);
            this.unsetBtn(this._nextmc,{
               "over":this.mouseOverHandler2,
               "out":this.mouseOutHandler,
               "click":this.clickHandler
            });
            this._nextmc = null;
         }
      }
      
      public function clear() : void
      {
         var _loc3_:PageNumber = null;
         var _loc1_:Array = this._pageNumbers;
         var _loc2_:uint = _loc1_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _loc1_[_loc4_];
            this.unsetBtn(_loc3_,{
               "over":this.mouseOverHandler,
               "out":this.mouseOutHandler,
               "click":this.clickHandler
            });
            _loc3_.release();
            this._container.removeChild(_loc3_);
            _loc3_ = null;
            _loc4_++;
         }
         this._pageNumbers = [];
      }
      
      public function paintColor(param1:DisplayObject, param2:int = 16711680) : void
      {
         var _loc3_:ColorTransform = param1.transform.colorTransform;
         _loc3_.redMultiplier = 0;
         _loc3_.greenMultiplier = 0;
         _loc3_.blueMultiplier = 0;
         _loc3_.redOffset = param2 >> 16 & 255;
         _loc3_.greenOffset = param2 >> 8 & 255;
         _loc3_.blueOffset = param2 & 255;
         param1.transform.colorTransform = _loc3_;
      }
      
      public function resetColor(param1:DisplayObject) : void
      {
         var _loc2_:ColorTransform = param1.transform.colorTransform;
         _loc2_.redMultiplier = 1;
         _loc2_.greenMultiplier = 1;
         _loc2_.blueMultiplier = 1;
         _loc2_.redOffset = 0;
         _loc2_.greenOffset = 0;
         _loc2_.blueOffset = 0;
         param1.transform.colorTransform = _loc2_;
      }
      
      public function update() : void
      {
         var _loc2_:PageNumber = null;
         var _loc8_:int = 0;
         var _loc9_:uint = 0;
         this.clear();
         var _loc1_:Array = [];
         var _loc3_:int = 1;
         var _loc4_:int = 0;
         var _loc5_:uint = Math.min(this._length,this._total);
         var _loc6_:int = this._length;
         var _loc7_:int = this._total;
         if(_loc6_ >= _loc7_)
         {
            _loc8_ = 0;
            while(_loc8_ < _loc5_)
            {
               if(_loc8_ == 0)
               {
                  _loc2_ = new PageNumber(_loc3_,false,this._isIndex);
               }
               else
               {
                  _loc2_ = new PageNumber(_loc3_);
               }
               if(this._select == _loc3_)
               {
                  _loc2_.isActive = true;
                  this.unsetBtn(_loc2_,{
                     "over":this.mouseOverHandler,
                     "out":this.mouseOutHandler,
                     "click":this.clickHandler
                  });
               }
               else
               {
                  _loc2_.isActive = false;
                  this.setBtn(_loc2_,{
                     "over":this.mouseOverHandler,
                     "out":this.mouseOutHandler,
                     "click":this.clickHandler
                  });
               }
               _loc2_.x = _loc4_;
               _loc4_ += _loc2_.width + 10;
               this._container.addChild(_loc2_);
               _loc1_.push(_loc2_);
               _loc3_++;
               _loc8_++;
            }
         }
         else if(_loc6_ - this.select >= 3)
         {
            _loc8_ = 0;
            while(_loc8_ < _loc5_ - 2)
            {
               if(_loc8_ == 0)
               {
                  _loc2_ = new PageNumber(_loc3_,false,this._isIndex);
               }
               else
               {
                  _loc2_ = new PageNumber(_loc3_);
               }
               if(this._select == _loc3_)
               {
                  _loc2_.isActive = true;
                  this.unsetBtn(_loc2_,{
                     "over":this.mouseOverHandler,
                     "out":this.mouseOutHandler,
                     "click":this.clickHandler
                  });
               }
               else
               {
                  _loc2_.isActive = false;
                  this.setBtn(_loc2_,{
                     "over":this.mouseOverHandler,
                     "out":this.mouseOutHandler,
                     "click":this.clickHandler
                  });
               }
               _loc2_.x = _loc4_;
               _loc4_ += _loc2_.width + 10;
               this._container.addChild(_loc2_);
               _loc1_.push(_loc2_);
               _loc3_++;
               _loc8_++;
            }
            _loc2_ = new PageNumber(-2);
            _loc2_.isActive = false;
            this.setBtn(_loc2_,{
               "over":this.mouseOverHandler,
               "out":this.mouseOutHandler,
               "click":this.clickHandler
            });
            _loc2_.x = _loc4_;
            _loc4_ += _loc2_.width + 10;
            this._container.addChild(_loc2_);
            _loc1_.push(_loc2_);
            _loc2_ = new PageNumber(_loc7_);
            if(this._select == _loc7_)
            {
               _loc2_.isActive = true;
               this.unsetBtn(_loc2_,{
                  "over":this.mouseOverHandler,
                  "out":this.mouseOutHandler,
                  "click":this.clickHandler
               });
            }
            else
            {
               _loc2_.isActive = false;
               this.setBtn(_loc2_,{
                  "over":this.mouseOverHandler,
                  "out":this.mouseOutHandler,
                  "click":this.clickHandler
               });
            }
            _loc2_.x = _loc4_;
            _loc4_ += _loc2_.width + 10;
            this._container.addChild(_loc2_);
            _loc1_.push(_loc2_);
         }
         else if(_loc7_ - this.select <= _loc6_ / 2)
         {
            _loc2_ = new PageNumber(1,false,this._isIndex);
            if(this._select == 1)
            {
               _loc2_.isActive = true;
               this.unsetBtn(_loc2_,{
                  "over":this.mouseOverHandler,
                  "out":this.mouseOutHandler,
                  "click":this.clickHandler
               });
            }
            else
            {
               _loc2_.isActive = false;
               this.setBtn(_loc2_,{
                  "over":this.mouseOverHandler,
                  "out":this.mouseOutHandler,
                  "click":this.clickHandler
               });
            }
            _loc2_.x = _loc4_;
            _loc4_ += _loc2_.width + 10;
            this._container.addChild(_loc2_);
            _loc1_.push(_loc2_);
            _loc2_ = new PageNumber(-1);
            _loc2_.isActive = false;
            this.setBtn(_loc2_,{
               "over":this.mouseOverHandler,
               "out":this.mouseOutHandler,
               "click":this.clickHandler
            });
            _loc2_.x = _loc4_;
            _loc4_ += _loc2_.width + 10;
            this._container.addChild(_loc2_);
            _loc1_.push(_loc2_);
            _loc3_ = _loc7_ - (_loc6_ - 3);
            _loc8_ = 0;
            while(_loc8_ < _loc5_ - 2)
            {
               _loc2_ = new PageNumber(_loc3_);
               if(this._select == _loc3_)
               {
                  _loc2_.isActive = true;
                  this.unsetBtn(_loc2_,{
                     "over":this.mouseOverHandler,
                     "out":this.mouseOutHandler,
                     "click":this.clickHandler
                  });
               }
               else
               {
                  _loc2_.isActive = false;
                  this.setBtn(_loc2_,{
                     "over":this.mouseOverHandler,
                     "out":this.mouseOutHandler,
                     "click":this.clickHandler
                  });
               }
               _loc2_.x = _loc4_;
               _loc4_ += _loc2_.width + 10;
               this._container.addChild(_loc2_);
               _loc1_.push(_loc2_);
               _loc3_++;
               _loc8_++;
            }
         }
         else
         {
            _loc2_ = new PageNumber(1,false,this._isIndex);
            if(this._select == 1)
            {
               _loc2_.isActive = true;
               this.unsetBtn(_loc2_,{
                  "over":this.mouseOverHandler,
                  "out":this.mouseOutHandler,
                  "click":this.clickHandler
               });
            }
            else
            {
               _loc2_.isActive = false;
               this.setBtn(_loc2_,{
                  "over":this.mouseOverHandler,
                  "out":this.mouseOutHandler,
                  "click":this.clickHandler
               });
            }
            _loc2_.x = _loc4_;
            _loc4_ += _loc2_.width + 10;
            this._container.addChild(_loc2_);
            _loc1_.push(_loc2_);
            _loc2_ = new PageNumber(-1);
            _loc2_.isActive = false;
            this.setBtn(_loc2_,{
               "over":this.mouseOverHandler,
               "out":this.mouseOutHandler,
               "click":this.clickHandler
            });
            _loc2_.x = _loc4_;
            _loc4_ += _loc2_.width + 10;
            this._container.addChild(_loc2_);
            _loc1_.push(_loc2_);
            if((_loc9_ = uint(_loc6_ - 4)) % 2 == 0)
            {
               _loc3_ = this._select - int(_loc9_ / 2) + 1;
            }
            else
            {
               _loc3_ = this._select - int(_loc9_ / 2);
            }
            _loc8_ = 0;
            while(_loc8_ < _loc9_)
            {
               _loc2_ = new PageNumber(_loc3_);
               if(this._select == _loc3_)
               {
                  _loc2_.isActive = true;
                  this.unsetBtn(_loc2_,{
                     "over":this.mouseOverHandler,
                     "out":this.mouseOutHandler,
                     "click":this.clickHandler
                  });
               }
               else
               {
                  _loc2_.isActive = false;
                  this.setBtn(_loc2_,{
                     "over":this.mouseOverHandler,
                     "out":this.mouseOutHandler,
                     "click":this.clickHandler
                  });
               }
               _loc2_.x = _loc4_;
               _loc4_ += _loc2_.width + 10;
               this._container.addChild(_loc2_);
               _loc1_.push(_loc2_);
               _loc3_++;
               _loc8_++;
            }
            _loc2_ = new PageNumber(-2);
            _loc2_.isActive = false;
            this.setBtn(_loc2_,{
               "over":this.mouseOverHandler,
               "out":this.mouseOutHandler,
               "click":this.clickHandler
            });
            _loc2_.x = _loc4_;
            _loc4_ += _loc2_.width + 10;
            this._container.addChild(_loc2_);
            _loc1_.push(_loc2_);
            _loc2_ = new PageNumber(_loc7_);
            if(this._select == _loc7_)
            {
               _loc2_.isActive = true;
               this.unsetBtn(_loc2_,{
                  "over":this.mouseOverHandler,
                  "out":this.mouseOutHandler,
                  "click":this.clickHandler
               });
            }
            else
            {
               _loc2_.isActive = false;
               this.setBtn(_loc2_,{
                  "over":this.mouseOverHandler,
                  "out":this.mouseOutHandler,
                  "click":this.clickHandler
               });
            }
            _loc2_.x = _loc4_;
            _loc4_ += _loc2_.width + 10;
            this._container.addChild(_loc2_);
            _loc1_.push(_loc2_);
         }
         this.unsetBtn(this._prevmc,{
            "over":this.mouseOverHandler2,
            "out":this.mouseOutHandler2,
            "click":this.clickHandler2
         });
         this.unsetBtn(this._nextmc,{
            "over":this.mouseOverHandler2,
            "out":this.mouseOutHandler2,
            "click":this.clickHandler2
         });
         if(this.select == 1)
         {
            this._prevmc.alpha = 0.5;
         }
         else
         {
            this._prevmc.alpha = 1;
            this.setBtn(this._prevmc,{
               "over":this.mouseOverHandler2,
               "out":this.mouseOutHandler2,
               "click":this.clickHandler2
            });
         }
         if(this.select == this._total)
         {
            this._nextmc.alpha = 0.5;
         }
         else
         {
            this._nextmc.alpha = 1;
            this.setBtn(this._nextmc,{
               "over":this.mouseOverHandler2,
               "out":this.mouseOutHandler2,
               "click":this.clickHandler2
            });
         }
         this._pageNumbers = _loc1_;
         this.x = this._rect.x;
         this.y = this._rect.y;
         this._container.x = int((this._rect.width - this._container.width) / 2);
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      private function mouseOverHandler(param1:MouseEvent) : void
      {
         PDWBridge.sfxMouseOver();
         var _loc2_:PageNumber = PageNumber(param1.currentTarget);
      }
      
      private function mouseOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:PageNumber = PageNumber(param1.currentTarget);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         PDWBridge.sfxClick();
         var _loc2_:PageNumber = PageNumber(param1.currentTarget);
         switch(_loc2_.index)
         {
            case -1:
               this._select = this._pageNumbers[2].index - 1;
               break;
            case -2:
               this._select = this._pageNumbers[this._pageNumbers.length - 3].index + 1;
               break;
            default:
               this._select = _loc2_.index;
         }
         this.update();
      }
      
      private function mouseOverHandler2(param1:MouseEvent) : void
      {
         PDWBridge.sfxMouseOver();
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_.name)
         {
            case "prevmc":
            case "nextmc":
               this.paintColor(_loc2_,PDWBridge.ROLLOVER_COLOR);
         }
      }
      
      private function mouseOutHandler2(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_.name)
         {
            case "prevmc":
            case "nextmc":
               this.resetColor(_loc2_);
         }
      }
      
      private function clickHandler2(param1:MouseEvent) : void
      {
         PDWBridge.sfxClick();
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         this.resetColor(_loc2_);
         switch(_loc2_.name)
         {
            case "prevmc":
               --this._select;
               if(1 >= this._select)
               {
                  this._select = 1;
               }
               this.update();
               break;
            case "nextmc":
               ++this._select;
               if(this._total <= this._select)
               {
                  this._select = this._total;
               }
               this.update();
         }
      }
      
      private function setBtn(param1:DisplayObject, param2:Object, param3:Boolean = true, param4:Boolean = false) : void
      {
         Sprite(param1).buttonMode = param3;
         Sprite(param1).mouseChildren = param4;
         if(param2)
         {
            if(param2.over)
            {
               param1.addEventListener(MouseEvent.MOUSE_OVER,param2.over);
            }
            if(param2.out)
            {
               param1.addEventListener(MouseEvent.MOUSE_OUT,param2.out);
            }
            if(param2.down)
            {
               param1.addEventListener(MouseEvent.MOUSE_DOWN,param2.down);
            }
            if(param2.up)
            {
               param1.addEventListener(MouseEvent.MOUSE_UP,param2.up);
            }
            if(param2.click)
            {
               param1.addEventListener(MouseEvent.CLICK,param2.click);
            }
            if(param2.doubleClick)
            {
               Sprite(param1).doubleClickEnabled = true;
               param1.addEventListener(MouseEvent.DOUBLE_CLICK,param2.doubleClick);
            }
         }
      }
      
      private function unsetBtn(param1:DisplayObject, param2:Object, param3:Boolean = false, param4:Boolean = true) : void
      {
         Sprite(param1).buttonMode = param3;
         Sprite(param1).mouseChildren = param4;
         if(param2)
         {
            if(param2.over)
            {
               param1.removeEventListener(MouseEvent.MOUSE_OVER,param2.over);
            }
            if(param2.out)
            {
               param1.removeEventListener(MouseEvent.MOUSE_OUT,param2.out);
            }
            if(param2.down)
            {
               param1.removeEventListener(MouseEvent.MOUSE_DOWN,param2.down);
            }
            if(param2.up)
            {
               param1.removeEventListener(MouseEvent.MOUSE_UP,param2.up);
            }
            if(param2.click)
            {
               param1.removeEventListener(MouseEvent.CLICK,param2.click);
            }
            if(param2.doubleClick)
            {
               Sprite(param1).doubleClickEnabled = false;
               param1.removeEventListener(MouseEvent.DOUBLE_CLICK,param2.doubleClick);
            }
         }
      }
   }
}
