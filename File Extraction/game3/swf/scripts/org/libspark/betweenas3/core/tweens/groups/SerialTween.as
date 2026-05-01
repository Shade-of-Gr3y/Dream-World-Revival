package org.libspark.betweenas3.core.tweens.groups
{
   import org.libspark.betweenas3.core.ticker.ITicker;
   import org.libspark.betweenas3.core.tweens.AbstractTween;
   import org.libspark.betweenas3.core.tweens.IITween;
   import org.libspark.betweenas3.core.tweens.IITweenGroup;
   import org.libspark.betweenas3.tweens.ITween;
   
   public class SerialTween extends AbstractTween implements IITweenGroup
   {
      
      private var _a:IITween;
      
      private var _b:IITween;
      
      private var _c:IITween;
      
      private var _d:IITween;
      
      private var _targets:Array;
      
      private var _lastTime:Number = 0;
      
      public function SerialTween(param1:Array, param2:ITicker, param3:Number)
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:IITween = null;
         super(param2,param3);
         _loc4_ = param1.length;
         _duration = 0;
         if(_loc4_ > 0)
         {
            this._a = param1[0] as IITween;
            _duration += this._a.duration;
            if(_loc4_ > 1)
            {
               this._b = param1[1] as IITween;
               _duration += this._b.duration;
               if(_loc4_ > 2)
               {
                  this._c = param1[2] as IITween;
                  _duration += this._c.duration;
                  if(_loc4_ > 3)
                  {
                     this._d = param1[3] as IITween;
                     _duration += this._d.duration;
                     if(_loc4_ > 4)
                     {
                        this._targets = new Array(_loc4_ - 4);
                        _loc5_ = 4;
                        while(_loc5_ < _loc4_)
                        {
                           _loc6_ = param1[_loc5_] as IITween;
                           this._targets[_loc5_ - 4] = _loc6_;
                           _duration += _loc6_.duration;
                           _loc5_++;
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function contains(param1:ITween) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         if(this._a == param1)
         {
            return true;
         }
         if(this._b == param1)
         {
            return true;
         }
         if(this._c == param1)
         {
            return true;
         }
         if(this._d == param1)
         {
            return true;
         }
         if(this._targets != null)
         {
            return this._targets.indexOf(param1 as IITween) != -1;
         }
         return false;
      }
      
      public function getTweenAt(param1:int) : ITween
      {
         if(param1 < 0)
         {
            return null;
         }
         if(param1 == 0)
         {
            return this._a;
         }
         if(param1 == 1)
         {
            return this._b;
         }
         if(param1 == 2)
         {
            return this._c;
         }
         if(param1 == 3)
         {
            return this._d;
         }
         if(this._targets != null)
         {
            if(param1 - 4 < this._targets.length)
            {
               return this._targets[param1 - 4];
            }
         }
         return null;
      }
      
      public function getTweenIndex(param1:ITween) : int
      {
         var _loc2_:int = 0;
         if(param1 == null)
         {
            return -1;
         }
         if(this._a == param1)
         {
            return 0;
         }
         if(this._b == param1)
         {
            return 1;
         }
         if(this._c == param1)
         {
            return 2;
         }
         if(this._d == param1)
         {
            return 3;
         }
         if(this._targets != null)
         {
            _loc2_ = this._targets.indexOf(param1 as IITween);
            if(_loc2_ != -1)
            {
               return _loc2_ + 4;
            }
         }
         return -1;
      }
      
      override protected function internalUpdate(param1:Number) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:* = 0;
         var _loc7_:IITween = null;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = this._lastTime;
         if(param1 - _loc4_ >= 0)
         {
            if(this._a != null)
            {
               if(_loc4_ <= (_loc2_ = _loc2_ + this._a.duration) && _loc3_ <= param1)
               {
                  this._a.update(param1 - _loc3_);
               }
               _loc3_ = _loc2_;
               if(this._b != null)
               {
                  if(_loc4_ <= (_loc2_ = _loc2_ + this._b.duration) && _loc3_ <= param1)
                  {
                     this._b.update(param1 - _loc3_);
                  }
                  _loc3_ = _loc2_;
                  if(this._c != null)
                  {
                     if(_loc4_ <= (_loc2_ = _loc2_ + this._c.duration) && _loc3_ <= param1)
                     {
                        this._c.update(param1 - _loc3_);
                     }
                     _loc3_ = _loc2_;
                     if(this._d != null)
                     {
                        if(_loc4_ <= (_loc2_ = _loc2_ + this._d.duration) && _loc3_ <= param1)
                        {
                           this._d.update(param1 - _loc3_);
                        }
                        _loc3_ = _loc2_;
                        if(this._targets != null)
                        {
                           _loc5_ = this._targets.length;
                           _loc6_ = 0;
                           while(_loc6_ < _loc5_)
                           {
                              _loc7_ = this._targets[_loc6_] as IITween;
                              if(_loc4_ <= (_loc2_ = _loc2_ + _loc7_.duration) && _loc3_ <= param1)
                              {
                                 _loc7_.update(param1 - _loc3_);
                              }
                              _loc3_ = _loc2_;
                              _loc6_++;
                           }
                        }
                     }
                  }
               }
            }
         }
         else
         {
            _loc2_ = _duration;
            _loc3_ = _loc2_;
            if(this._targets != null)
            {
               _loc6_ = int(this._targets.length - 1);
               while(_loc6_ >= 0)
               {
                  _loc7_ = this._targets[_loc6_] as IITween;
                  if(_loc4_ >= (_loc2_ = _loc2_ - _loc7_.duration) && _loc3_ >= param1)
                  {
                     _loc7_.update(param1 - _loc2_);
                  }
                  _loc3_ = _loc2_;
                  _loc6_--;
               }
            }
            if(this._d != null)
            {
               if(_loc4_ >= (_loc2_ = _loc2_ - this._d.duration) && _loc3_ >= param1)
               {
                  this._d.update(param1 - _loc2_);
               }
               _loc3_ = _loc2_;
            }
            if(this._c != null)
            {
               if(_loc4_ >= (_loc2_ = _loc2_ - this._c.duration) && _loc3_ >= param1)
               {
                  this._c.update(param1 - _loc2_);
               }
               _loc3_ = _loc2_;
            }
            if(this._b != null)
            {
               if(_loc4_ >= (_loc2_ = _loc2_ - this._b.duration) && _loc3_ >= param1)
               {
                  this._b.update(param1 - _loc2_);
               }
               _loc3_ = _loc2_;
            }
            if(this._a != null)
            {
               if(_loc4_ >= (_loc2_ = _loc2_ - this._a.duration) && _loc3_ >= param1)
               {
                  this._a.update(param1 - _loc2_);
               }
               _loc3_ = _loc2_;
            }
         }
         this._lastTime = param1;
      }
      
      override protected function newInstance() : AbstractTween
      {
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc1_:Array = [];
         if(this._a != null)
         {
            _loc1_.push(this._a.clone());
         }
         if(this._b != null)
         {
            _loc1_.push(this._b.clone());
         }
         if(this._c != null)
         {
            _loc1_.push(this._c.clone());
         }
         if(this._d != null)
         {
            _loc1_.push(this._d.clone());
         }
         if(this._targets != null)
         {
            _loc2_ = this._targets;
            _loc3_ = _loc2_.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc1_.push(_loc2_[_loc4_].clone());
               _loc4_++;
            }
         }
         return new SerialTween(_loc1_,ticker,0);
      }
   }
}

