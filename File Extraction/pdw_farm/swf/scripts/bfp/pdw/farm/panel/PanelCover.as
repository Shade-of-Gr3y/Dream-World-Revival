package bfp.pdw.farm.panel
{
   import bfp.PDWBridge;
   import bfp.pdw.farm.FarmBridge;
   import bfp.pdw.farm.FarmData;
   import bfp.pokemon.liby.event.CustomEvent;
   import bfp.pokemon.liby.util.BtnSetting;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   
   public class PanelCover extends EventDispatcher
   {
      
      private var targetMC:MovieClip;
      
      private var bridge:FarmBridge;
      
      private var data:FarmData;
      
      private var funcType:String = "";
      
      public function PanelCover(param1:MovieClip)
      {
         super();
         this.targetMC = param1;
         this.init();
      }
      
      private function init() : *
      {
         this.bridge = FarmBridge.getInstance();
         this.data = FarmData.getInstance();
         this.targetMC.alpha = 0;
      }
      
      public function reset() : *
      {
         this.targetMC.graphics.clear();
      }
      
      public function stop() : *
      {
      }
      
      public function run() : *
      {
      }
      
      public function appear() : *
      {
         this.targetMC.graphics.clear();
         this.targetMC.graphics.lineStyle();
         this.targetMC.graphics.beginFill(16777215);
         this.targetMC.graphics.drawRect(0,0,this.data.STAGE_WID,this.data.STAGE_HEI);
         this.targetMC.graphics.endFill();
         PDWBridge.hideMoveArrows();
      }
      
      public function banish() : *
      {
         this.clearBtnFunc();
         this.targetMC.graphics.clear();
         PDWBridge.showMoveArrows();
      }
      
      public function setBtnFunc(param1:*) : *
      {
         this.funcType = param1;
         BtnSetting.addBtn(this.targetMC,{"click":this.onClick});
      }
      
      public function clearBtnFunc() : *
      {
         BtnSetting.removeBtn(this.targetMC,{"click":this.onClick});
      }
      
      private function onClick(param1:MouseEvent) : *
      {
         dispatchEvent(new CustomEvent("onCoverClick",{"type":this.funcType}));
      }
   }
}

