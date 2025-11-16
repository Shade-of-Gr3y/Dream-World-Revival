package bfp.tpc.pdw.common
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class PageNumber extends Sprite
   {
       
      
      private var _pagenums:Array;
      
      private var _activepagenums:Array;
      
      private var _dot:MovieClip;
      
      private var _index:int;
      
      private var _isActive:Boolean;
      
      private var _isIndex:Boolean;
      
      public function PageNumber(param1:int = 1, param2:Boolean = false, param3:Boolean = false)
      {
         super();
         this._index = param1;
         this._isActive = param2;
         this._isIndex = param3;
         this._pagenums = [];
         this._activepagenums = [];
         this.init();
         this.isActive = param2;
      }
      
      public function init() : void
      {
         var _loc1_:Array = null;
         var _loc2_:uint = 0;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:MovieClip = null;
         var _loc8_:MovieClip = null;
         var _loc9_:int = 0;
         var _loc10_:MovieClip = null;
         if(this._index >= 0)
         {
            _loc1_ = this._index.toString().split("");
            _loc2_ = _loc1_.length;
            _loc3_ = [];
            _loc4_ = [];
            _loc5_ = 0;
            _loc6_ = -1;
            if(this._isIndex)
            {
               (_loc7_ = new AssetPageIndex()).x = _loc5_;
               _loc7_.y = -1;
               if(!this._isActive)
               {
                  addChild(_loc7_);
               }
               _loc3_.push(_loc7_);
               (_loc8_ = new AssetActivePageIndex()).x = _loc6_;
               _loc8_.y = -1;
               if(this._isActive)
               {
                  addChild(_loc8_);
               }
               _loc4_.push(_loc8_);
               _loc5_ += _loc7_.width;
               _loc6_ += _loc8_.width;
            }
            else
            {
               _loc9_ = 0;
               while(_loc9_ < _loc2_)
               {
                  (_loc7_ = new AssetPageNumbers()).gotoAndStop(int(_loc1_[_loc9_]) + 1);
                  _loc7_.x = _loc5_ - _loc9_;
                  _loc7_.y = -1;
                  if(!this._isActive)
                  {
                     addChild(_loc7_);
                  }
                  _loc3_.push(_loc7_);
                  (_loc8_ = new AssetActivePageNumbers()).gotoAndStop(int(_loc1_[_loc9_]) + 1);
                  _loc8_.x = _loc6_ - _loc9_ * 4;
                  _loc8_.y = -4;
                  if(this._isActive)
                  {
                     addChild(_loc8_);
                  }
                  _loc4_.push(_loc8_);
                  _loc5_ += _loc7_.width;
                  _loc6_ += _loc8_.width;
                  _loc9_++;
               }
            }
            this._pagenums = _loc3_;
            this._activepagenums = _loc4_;
         }
         else
         {
            _loc10_ = new AssetPageDots();
            addChild(_loc10_);
            this._dot = _loc10_;
         }
      }
      
      public function release() : void
      {
         var _loc1_:Array = this._pagenums;
         var _loc2_:Array = this._activepagenums;
         var _loc3_:uint = _loc2_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc1_[_loc4_].parent)
            {
               removeChild(_loc1_[_loc4_]);
               _loc1_[_loc4_] = null;
            }
            if(_loc2_[_loc4_].parent)
            {
               removeChild(_loc2_[_loc4_]);
               _loc2_[_loc4_] = null;
            }
            _loc4_++;
         }
         if(Boolean(this._dot) && Boolean(this._dot.parent))
         {
            removeChild(this._dot);
            this._dot = null;
         }
         this._pagenums = [];
         this._activepagenums = [];
      }
      
      public function get isActive() : Boolean
      {
         return this._isActive;
      }
      
      public function set isActive(param1:Boolean) : void
      {
         this._isActive = param1;
         var _loc2_:Array = this._pagenums;
         var _loc3_:Array = this._activepagenums;
         var _loc4_:uint = _loc3_.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if(param1 && !_loc3_[_loc5_].parent)
            {
               addChild(_loc3_[_loc5_]);
            }
            if(!param1 && Boolean(_loc3_[_loc5_].parent))
            {
               removeChild(_loc3_[_loc5_]);
            }
            if(!param1 && !_loc2_[_loc5_].parent)
            {
               addChild(_loc2_[_loc5_]);
            }
            if(param1 && Boolean(_loc2_[_loc5_].parent))
            {
               removeChild(_loc2_[_loc5_]);
            }
            _loc5_++;
         }
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function set index(param1:int) : void
      {
         this._index = param1;
      }
   }
}
