package bfp.pdw.farm.panel
{
   import bfp.IPDWPokemonStatus;
   import bfp.PDWBridge;
   import bfp.PDWHomeData;
   import bfp.common.Logger;
   import bfp.pdw.farm.FarmData;
   import bfp.pokemon.liby.event.CustomEvent;
   import caurina.transitions.*;
   import caurina.transitions.properties.*;
   import com.pokemon_gl.pdw.display.PokemonRendererScene;
   import flash.display.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   
   public class PokemonStatusPanel extends EventDispatcher
   {
      
      private var targetMC:MovieClip;
      
      private var data:FarmData;
      
      private var leftPosX:Number = 614;
      
      private var rightPosX:Number = 9;
      
      private var panelObj:IPDWPokemonStatus;
      
      public function PokemonStatusPanel(param1:MovieClip)
      {
         super();
         this.targetMC = param1;
         this.init();
      }
      
      private function init() : *
      {
         this.data = FarmData.getInstance();
         this.reset();
      }
      
      public function reset() : *
      {
         this.targetMC.visible = false;
         this.targetMC.alpha = 0;
      }
      
      public function stop() : *
      {
      }
      
      public function run() : *
      {
      }
      
      public function show(param1:* = 0) : *
      {
         Logger.log("はたけ　pokemonPlaceType:" + this.data.pokemonPlaceType);
         switch(this.data.pokemonPlaceType)
         {
            case PokemonRendererScene.CROFT_FAR_LEFT:
               Logger.log("はたけ　CROFT_FAR_LEFT:" + PokemonRendererScene.CROFT_FAR_LEFT);
               break;
            case PokemonRendererScene.CROFT_MIDDLE_LEFT:
               Logger.log("はたけ　CROFT_MIDDLE_LEFT:" + PokemonRendererScene.CROFT_MIDDLE_LEFT);
               break;
            case PokemonRendererScene.CROFT_NEAR_LEFT:
               Logger.log("はたけ　CROFT_NEAR_LEFT:" + PokemonRendererScene.CROFT_NEAR_LEFT);
               break;
            case PokemonRendererScene.CROFT_FAR_RIGHT:
               Logger.log("はたけ　CROFT_FAR_RIGHT:" + PokemonRendererScene.CROFT_FAR_RIGHT);
               break;
            case PokemonRendererScene.CROFT_MIDDLE_RIGHT:
               Logger.log("はたけ　CROFT_MIDDLE_RIGHT:" + PokemonRendererScene.CROFT_MIDDLE_RIGHT);
               break;
            case PokemonRendererScene.CROFT_NEAR_RIGHT:
               Logger.log("はたけ　CROFT_NEAR_RIGHT:" + PokemonRendererScene.CROFT_NEAR_RIGHT);
         }
         switch(this.data.pokemonPlaceType)
         {
            case PokemonRendererScene.CROFT_FAR_LEFT:
            case PokemonRendererScene.CROFT_MIDDLE_LEFT:
            case PokemonRendererScene.CROFT_NEAR_LEFT:
               Logger.log("はたけ　ポケモンプロフィール　右側表示");
               this.targetMC.dx = this.leftPosX;
               this.targetMC.tx = this.leftPosX + 40;
               this.targetMC.x = this.targetMC.tx;
               break;
            case PokemonRendererScene.CROFT_FAR_RIGHT:
            case PokemonRendererScene.CROFT_MIDDLE_RIGHT:
            case PokemonRendererScene.CROFT_NEAR_RIGHT:
               Logger.log("はたけ　ポケモンプロフィール　左側表示");
               this.targetMC.dx = this.rightPosX;
               this.targetMC.tx = this.rightPosX - 40;
               this.targetMC.x = this.targetMC.tx;
         }
         Tweener.addTween(this.targetMC,{
            "delay":param1,
            "onComplete":this.showAnime
         });
      }
      
      private function showAnime() : *
      {
         Tweener.addTween(this.targetMC,{
            "delay":0,
            "time":0.3,
            "transition":"linear",
            "_autoAlpha":1,
            "onComplete":this.showEnd
         });
         Tweener.addTween(this.targetMC,{
            "delay":0,
            "time":0.3,
            "transition":"easeOutQuint",
            "x":this.targetMC.dx
         });
      }
      
      private function showEnd() : *
      {
      }
      
      public function hide(param1:* = 0) : *
      {
         Tweener.addTween(this.targetMC,{
            "delay":param1,
            "onComplete":this.hideAnime
         });
      }
      
      private function hideAnime() : *
      {
         Tweener.addTween(this.targetMC,{
            "delay":0,
            "time":0.3,
            "transition":"linear",
            "_autoAlpha":0,
            "onComplete":this.hideEnd
         });
         Tweener.addTween(this.targetMC,{
            "delay":0,
            "time":0.3,
            "transition":"easeInQuint",
            "x":this.targetMC.tx
         });
      }
      
      private function hideEnd() : *
      {
         if(this.panelObj)
         {
            if(this.targetMC.contains(DisplayObject(this.panelObj)))
            {
               this.targetMC.removeChild(DisplayObject(this.panelObj));
            }
         }
      }
      
      public function initialize(param1:*) : *
      {
         var _loc2_:String = "";
         var _loc3_:String = "";
         var _loc4_:String = "";
         var _loc5_:String = "";
         var _loc6_:int = 0;
         var _loc7_:String = "";
         var _loc8_:int = 0;
         var _loc9_:String = "";
         var _loc10_:String = "";
         switch(param1)
         {
            case this.data.POKEMON_INFO_TYPE_MY:
               _loc2_ = PDWHomeData.myPokemonNickName != null ? PDWHomeData.myPokemonNickName : "";
               _loc3_ = PDWHomeData.myPGLName != null ? PDWHomeData.myPGLName : "";
               _loc4_ = PDWHomeData.myPokemonName != null ? PDWHomeData.myPokemonName : "";
               _loc5_ = PDWHomeData.myPokemonOyaName != null ? PDWHomeData.myPokemonOyaName : "";
               _loc6_ = String(PDWHomeData.myPokemonLevel) != null ? int(Number(PDWHomeData.myPokemonLevel)) : -1;
               _loc7_ = PDWHomeData.myPokemonType1 != null ? PDWHomeData.myPokemonType1 : "";
               if(PDWHomeData.myPokemonType2 != null)
               {
                  if(PDWHomeData.myPokemonType1 != PDWHomeData.myPokemonType2)
                  {
                     _loc7_ += "　" + PDWHomeData.myPokemonType2;
                  }
               }
               _loc8_ = String(PDWHomeData.myPokemonSex) != null ? int(Number(PDWHomeData.myPokemonSex)) : -1;
               _loc9_ = PDWHomeData.myPokemonPersonality != null ? PDWHomeData.myPokemonPersonality : "";
               _loc10_ = PDWHomeData.myPokemonBall != null ? PDWHomeData.myPokemonBall : "";
               this.panelObj = PDWBridge.getStatusWindow(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_);
               this.panelObj.addEventListener(Event.CLOSE,this.onPanelClose);
               this.targetMC.addChild(DisplayObject(this.panelObj));
               break;
            case this.data.POKEMON_INFO_TYPE_FRIEND:
               _loc2_ = PDWHomeData.anotherPokemonNickName != null ? PDWHomeData.anotherPokemonNickName : "";
               _loc3_ = PDWHomeData.anotherPGLName != null ? PDWHomeData.anotherPGLName : "";
               _loc4_ = PDWHomeData.anotherPokemonName != null ? PDWHomeData.anotherPokemonName : "";
               _loc5_ = PDWHomeData.anotherPokemonOyaName != null ? PDWHomeData.anotherPokemonOyaName : "";
               _loc6_ = String(PDWHomeData.anotherPokemonLevel) != null ? int(Number(PDWHomeData.anotherPokemonLevel)) : -1;
               _loc7_ = PDWHomeData.anotherPokemonType1 != null ? PDWHomeData.anotherPokemonType1 : "";
               if(PDWHomeData.anotherPokemonType2 != null)
               {
                  if(PDWHomeData.anotherPokemonType1 != PDWHomeData.anotherPokemonType2)
                  {
                     _loc7_ += "　" + PDWHomeData.anotherPokemonType2;
                  }
               }
               _loc8_ = String(PDWHomeData.anotherPokemonSex) != null ? int(Number(PDWHomeData.anotherPokemonSex)) : -1;
               _loc9_ = PDWHomeData.anotherPokemonPersonality != null ? PDWHomeData.anotherPokemonPersonality : "";
               _loc10_ = PDWHomeData.anotherPokemonBall != null ? PDWHomeData.anotherPokemonBall : "";
               this.panelObj = PDWBridge.getStatusWindow(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_);
               this.panelObj.addEventListener(Event.CLOSE,this.onPanelClose);
               this.targetMC.addChild(DisplayObject(this.panelObj));
         }
      }
      
      private function onPanelClose(param1:Event) : *
      {
         dispatchEvent(new CustomEvent("onPokemonStatusPanelCloseClick"));
      }
   }
}

