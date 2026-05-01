package
{
   import flash.display.MovieClip;
   import game.message.FontSetting;
   
   public class Result extends MovieClip
   {
      
      private var m_score:int;
      
      private var m_mag:Number;
      
      private var m_mc:MovieClip;
      
      private var m_height:int;
      
      private var m_dialog:DialogBase;
      
      private var m_numMag:Number;
      
      public function Result()
      {
         super();
      }
      
      public function getRank() : int
      {
         var _loc1_:int = 5;
         if(10000 <= this.m_score)
         {
            _loc1_ = 4;
         }
         if(20000 <= this.m_score)
         {
            _loc1_ = 3;
         }
         if(25000 <= this.m_score)
         {
            _loc1_ = 2;
         }
         if(30000 <= this.m_score)
         {
            _loc1_ = 1;
         }
         return _loc1_;
      }
      
      private function _printDecimal(param1:MovieClip, param2:Number) : *
      {
         var _loc3_:* = param2.toString();
         if(param2 <= 0.01)
         {
            _loc3_ = "0.00";
         }
         var _loc4_:int = int(_loc3_.indexOf(".",0));
         if(_loc4_ == -1)
         {
            _loc3_ += ".00";
            _loc4_ = int(_loc3_.indexOf(".",0));
         }
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
      
      public function open(param1:MovieClip, param2:MovieClip) : void
      {
         this.m_dialog = new DialogBase(param1,param2);
         this.m_mc = param1;
      }
      
      public function print(param1:MovieClip, param2:Number, param3:int, param4:int, param5:Array) : void
      {
         var _loc6_:MovieClip = null;
         var _loc8_:* = undefined;
         this.m_height = param2 * 75;
         if(param4 != 0)
         {
            this.m_mag = Math.ceil((param3 / param4 + 1) * 10) / 10;
         }
         else
         {
            this.m_mag = 1;
         }
         this.m_mag = Math.floor(this.m_mag * 100) / 100;
         var _loc7_:* = param5[0] + param5[1] + param5[2];
         if(_loc7_ != 0)
         {
            _loc8_ = 0;
            while(Boolean(param5[0]) && Boolean(param5[1]) && Boolean(param5[2]))
            {
               --param5[0];
               --param5[1];
               --param5[2];
            }
            while(Boolean(param5[0]) && Boolean(param5[1]) || Boolean(param5[1]) && Boolean(param5[2]) || Boolean(param5[0]) && Boolean(param5[2]))
            {
               if(param5[0])
               {
                  --param5[0];
               }
               if(param5[1])
               {
                  --param5[1];
               }
               if(param5[2])
               {
                  --param5[2];
               }
               _loc8_++;
            }
            this.m_numMag = 2 - (param5[0] + param5[1] + param5[2]) / _loc7_ - _loc8_ / _loc7_ / 2;
         }
         else
         {
            this.m_numMag = 1;
         }
         this.m_numMag = Math.floor(this.m_numMag * 100) / 100;
         this.m_score = this.m_height * this.m_mag * this.m_numMag;
         this._printDecimal(param1.resultpointcm_MC,param2);
         this._printFig(param1.resultpointeat_MC,param3,-1);
         this._printFig(param1.resultpointeatm_MC,param4,-1);
         this._printFig(param1.resultheightpoint_MC,this.m_height,-1);
         _loc6_ = comDefine.getTextMc(param1.resultfallpoint_MC);
         this._printDecimal(_loc6_,this.m_numMag);
         _loc6_ = comDefine.getTextMc(param1.resultXpoint_MC);
         this._printDecimal(_loc6_,this.m_mag);
         this._printFig(param1.resultallpoint_MC,this.m_score,-1);
      }
      
      public function isOpen() : Boolean
      {
         if(this.m_dialog != null)
         {
            return this.m_dialog.isOpen();
         }
         return false;
      }
      
      private function _printFig(param1:MovieClip, param2:Number, param3:int) : *
      {
         var _loc4_:Number = param1.x;
         var _loc5_:Number = param1.y;
         var _loc6_:int = 0;
         var _loc7_:* = param2.toString();
         var _loc8_:int = int(_loc7_.indexOf(".",0));
         if(_loc8_ == -1)
         {
            _loc7_ += ".0";
            _loc8_ = int(_loc7_.indexOf(".",0));
         }
         _loc8_ += param3;
         FontSetting.setText(param1.textMC,_loc7_.substring(0,_loc8_ + 1),false);
      }
      
      public function close() : void
      {
         if(this.m_dialog != null)
         {
            this.m_dialog.release();
            this.m_dialog = null;
         }
      }
      
      public function isEnable() : Boolean
      {
         if(this.m_dialog != null)
         {
            return this.m_dialog.isEnable();
         }
         return false;
      }
   }
}

