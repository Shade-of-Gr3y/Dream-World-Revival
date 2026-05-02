package hivelocity.flight.status
{
   import as3.hivelocity.flight.events.flightEvent;
   import caurina.transitions.Tweener;
   import flash.display.MovieClip;
   
   public class energyBox extends MovieClip
   {
      
      static const BOX_NUM:uint = 3;
      
      static const ENERGY_ICON_START:int = -50;
      
      static const ENERGY_TYPE_LEAF:uint = 1;
      
      static const ENERGY_TYPE_FIRE:uint = 2;
      
      static const ENERGY_TYPE_WATER:uint = 3;
      
      static const ENERGY_TYPE_THUNDER:uint = 4;
      
      static const COMBO_TYPE_USUALLY:uint = 1;
      
      static const COMBO_TYPE_LEAF:uint = 2;
      
      static const COMBO_TYPE_FIRE:uint = 3;
      
      static const COMBO_TYPE_WATER:uint = 4;
      
      static const COMBO_TYPE_ORDER:uint = 5;
       
      
      public var arrow_2:MovieClip;
      
      public var icon_1:MovieClip;
      
      public var icon_2:MovieClip;
      
      public var icon_3:MovieClip;
      
      public var arrow_1:MovieClip;
      
      private var _inNum:uint;
      
      private var _setY:Number;
      
      private var _resetNum:Number;
      
      private var _comboArr:Array;
      
      private var _comboJudgeArr:Array;
      
      public function energyBox()
      {
         super();
         this.__init();
      }
      
      public function set setEnergy(param1:uint) : void
      {
         if(param1 != ENERGY_TYPE_THUNDER)
         {
            this.energyIconInBox(param1);
         }
         else
         {
            this._resetNum = this._inNum;
            this._inNum = 1;
            this._comboArr = [];
            this.energyBoxReset();
         }
      }
      
      public function reset() : void
      {
         this._comboArr = [];
         this._inNum = 1;
         var _loc1_:int = 1;
         while(_loc1_ <= BOX_NUM)
         {
            this["icon_" + _loc1_].gotoAndStop(1);
            if(_loc1_ < BOX_NUM)
            {
               this["arrow_" + _loc1_].over.alpha = 0;
            }
            _loc1_++;
         }
      }
      
      private function __init() : void
      {
         this._inNum = 1;
         this._comboArr = [];
         this._comboJudgeArr = [];
         this._comboJudgeArr[0] = new Array();
         this._comboJudgeArr[0] = [ENERGY_TYPE_LEAF,ENERGY_TYPE_LEAF,ENERGY_TYPE_LEAF];
         this._comboJudgeArr[1] = new Array();
         this._comboJudgeArr[1] = [ENERGY_TYPE_FIRE,ENERGY_TYPE_FIRE,ENERGY_TYPE_FIRE];
         this._comboJudgeArr[2] = new Array();
         this._comboJudgeArr[2] = [ENERGY_TYPE_WATER,ENERGY_TYPE_WATER,ENERGY_TYPE_WATER];
         this._comboJudgeArr[3] = new Array();
         this._comboJudgeArr[3] = [ENERGY_TYPE_LEAF,ENERGY_TYPE_FIRE,ENERGY_TYPE_WATER];
         this._comboJudgeArr[4] = new Array();
         this._comboJudgeArr[4] = [ENERGY_TYPE_FIRE,ENERGY_TYPE_WATER,ENERGY_TYPE_LEAF];
         this._comboJudgeArr[5] = new Array();
         this._comboJudgeArr[5] = [ENERGY_TYPE_WATER,ENERGY_TYPE_LEAF,ENERGY_TYPE_FIRE];
      }
      
      private function energyIconInBox(param1:int) : void
      {
         this["icon_" + this._inNum].coins.gotoAndStop(param1);
         this["icon_" + this._inNum].gotoAndPlay("set");
         this._comboArr.push(param1);
         this._inNum++;
         if(this._inNum > BOX_NUM)
         {
            this._inNum = 1;
            this.judgeCombo();
            this.energyOutAnime();
         }
         else
         {
            this["arrow_" + (this._inNum - 1)].over.alpha = 100;
         }
      }
      
      private function judgeCombo() : void
      {
         var _loc3_:uint = 0;
         var _loc1_:int = 0;
         var _loc2_:Number = 0;
         var _loc4_:int = 0;
         while(_loc4_ < this._comboJudgeArr.length)
         {
            if(this._comboArr[0] == this._comboJudgeArr[_loc4_][0] && this._comboArr[1] == this._comboJudgeArr[_loc4_][1] && this._comboArr[2] == this._comboJudgeArr[_loc4_][2])
            {
               switch(_loc4_)
               {
                  case 0:
                     _loc1_ = 1000;
                     _loc2_ = 0.6;
                     _loc3_ = COMBO_TYPE_LEAF;
                     break;
                  case 1:
                     _loc1_ = 1000;
                     _loc2_ = 0.6;
                     _loc3_ = COMBO_TYPE_FIRE;
                     break;
                  case 2:
                     _loc1_ = 1000;
                     _loc2_ = 0.65;
                     _loc3_ = COMBO_TYPE_WATER;
                     break;
                  case 3:
                     _loc1_ = 2000;
                     _loc2_ = 0.4;
                     _loc3_ = COMBO_TYPE_ORDER;
                     break;
                  case 4:
                     _loc1_ = 2000;
                     _loc2_ = 0.4;
                     _loc3_ = COMBO_TYPE_ORDER;
                     break;
                  case 5:
                     _loc1_ = 2000;
                     _loc2_ = 0.4;
                     _loc3_ = COMBO_TYPE_ORDER;
               }
               dispatchEvent(new flightEvent(flightEvent.ENERGY_COMBO,_loc1_,_loc2_,_loc3_));
            }
            _loc4_++;
         }
         this._comboArr = [];
      }
      
      private function getComboTarget() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:int = 0;
         while(_loc2_ < this._comboJudgeArr.length)
         {
            switch(this._inNum)
            {
               case 2:
                  if(this._comboArr[0] == this._comboJudgeArr[_loc2_][0])
                  {
                     _loc1_.push(this._comboJudgeArr[_loc2_][1]);
                  }
                  break;
               case 3:
                  if(this._comboArr[0] == this._comboJudgeArr[_loc2_][0] && this._comboArr[1] == this._comboJudgeArr[_loc2_][1])
                  {
                     _loc1_.push(this._comboJudgeArr[_loc2_][2]);
                  }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function energyBoxReset(param1:Boolean = false) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 1;
         while(_loc3_ < this._resetNum)
         {
            _loc2_ = this["icon_" + _loc3_] as MovieClip;
            _loc2_.gotoAndStop(1);
            if(_loc3_ < BOX_NUM)
            {
               this["arrow_" + _loc3_].over.alpha = 0;
            }
            _loc3_++;
         }
         this.energyBoxFullThunder();
      }
      
      private function energyBoxFullThunder(param1:Boolean = false) : void
      {
         var _loc5_:MovieClip = null;
         var _loc6_:int = 0;
         var _loc2_:Number = 0.5;
         var _loc3_:String = "liner";
         var _loc4_:Function = this.energyBoxFullThunder;
         if(!param1)
         {
            _loc6_ = 1;
            while(_loc6_ <= BOX_NUM)
            {
               _loc5_ = this["icon_" + _loc6_] as MovieClip;
               _loc5_.coins.gotoAndStop(ENERGY_TYPE_THUNDER);
               _loc5_.gotoAndStop("setend");
               _loc6_++;
            }
            Tweener.addTween(_loc5_,{
               "time":1,
               "onComplete":_loc4_,
               "onCompleteParams":[true]
            });
         }
         else
         {
            this.energyBoxThunderReset();
         }
      }
      
      private function energyBoxThunderReset(param1:Boolean = false) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 1;
         while(_loc3_ <= BOX_NUM)
         {
            _loc2_ = this["icon_" + _loc3_] as MovieClip;
            _loc2_.gotoAndStop(1);
            _loc3_++;
         }
      }
      
      private function energyOutAnime(param1:Boolean = false) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 1;
         while(_loc3_ <= BOX_NUM)
         {
            _loc2_ = this["icon_" + _loc3_] as MovieClip;
            _loc2_.gotoAndPlay("get");
            if(_loc3_ < BOX_NUM)
            {
               this["arrow_" + _loc3_].over.alpha = 0;
            }
            _loc3_++;
         }
      }
   }
}
