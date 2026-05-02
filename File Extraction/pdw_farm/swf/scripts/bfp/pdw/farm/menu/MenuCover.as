package bfp.pdw.farm.menu
{
   import bfp.pdw.farm.FarmBridge;
   import bfp.pdw.farm.FarmData;
   import bfp.pokemon.liby.event.CustomEvent;
   import bfp.pokemon.liby.util.BtnSetting;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   
   public class MenuCover extends EventDispatcher
   {
      
      private var targetMC:MovieClip;
      
      private var bridge:FarmBridge;
      
      private var data:FarmData;
      
      public function MenuCover(param1:MovieClip)
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
         this.clearBtnFunc();
      }
      
      public function run() : *
      {
      }
      
      public function appear(param1:* = false) : *
      {
         this.targetMC.graphics.clear();
         this.targetMC.graphics.lineStyle();
         this.targetMC.graphics.beginFill(16777215);
         this.targetMC.graphics.drawRect(0,0,this.data.STAGE_WID,this.data.STAGE_HEI);
         this.targetMC.graphics.endFill();
         if(param1)
         {
            this.setBtnFunc();
         }
      }
      
      public function banish() : *
      {
         this.clearBtnFunc();
         this.targetMC.graphics.clear();
      }
      
      private function setBtnFunc() : *
      {
         BtnSetting.addBtn(this.targetMC,{
            "click":this.onClick,
            "buttonMode":false
         });
      }
      
      private function clearBtnFunc() : *
      {
         BtnSetting.removeBtn(this.targetMC,{
            "click":this.onClick,
            "buttonMode":false
         });
      }
      
      private function onClick(param1:MouseEvent) : *
      {
         dispatchEvent(new CustomEvent("onCoverClick"));
      }
   }
}

