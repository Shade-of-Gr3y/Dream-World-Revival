package
{
   import flash.display.MovieClip;
   import game.message.FontSetting;
   
   public class HeightMeter
   {
      
      private static const COUNT_MAX:* = 48;
      
      private var m_pos:Number;
      
      private var m_nowHeight:Number;
      
      private var m_count:int;
      
      private var m_height:Number;
      
      public function HeightMeter()
      {
         super();
         this.m_pos = 0;
         this.m_height = 0;
      }
      
      public function getNow() : Number
      {
         return this.m_nowHeight;
      }
      
      public function setHeight(param1:Number) : void
      {
         if(param1 == this.m_height)
         {
            return;
         }
         this.m_pos = this.m_height;
         this.m_height = param1;
         this.m_count = 0;
      }
      
      public function print(param1:MovieClip) : void
      {
         var _loc2_:Number = NaN;
         if(this.m_count > COUNT_MAX)
         {
            return;
         }
         if(this.m_count < COUNT_MAX)
         {
            _loc2_ = Interpolate.GetF(0,COUNT_MAX,this.m_pos,this.m_height,0,this.m_count);
         }
         else
         {
            _loc2_ = this.m_height;
         }
         ++this.m_count;
         this.m_nowHeight = _loc2_;
         var _loc3_:* = _loc2_.toString();
         if(_loc2_ <= 0.01)
         {
            _loc3_ = "0.00";
         }
         var _loc4_:int = int(_loc3_.indexOf(".",0));
         if(_loc3_.length <= _loc4_ + 2)
         {
            _loc3_ += "0";
         }
         var _loc5_:int = Math.max(_loc4_ - 3,0);
         var _loc6_:String = _loc3_.substring(_loc5_,_loc4_ + 3);
         _loc4_ = int(_loc3_.indexOf(".",0));
         _loc3_ = _loc6_.substring(0,_loc4_);
         FontSetting.setText(param1.topMC.textMC,_loc3_,false);
         _loc3_ = _loc6_.substring(_loc4_ + 1,_loc6_.length);
         FontSetting.setText(param1.bottomMC.textMC,_loc3_,false);
      }
      
      public function isLoad() : Boolean
      {
         return true;
      }
      
      public function resetHeight() : void
      {
         this.m_pos = 0;
         this.m_height = 0;
         this.m_count = COUNT_MAX;
      }
      
      public function commit() : void
      {
         this.m_count = COUNT_MAX;
      }
      
      public function getHeight() : Number
      {
         return this.m_height;
      }
   }
}

