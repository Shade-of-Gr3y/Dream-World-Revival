package bfp.pdw.farm.objects
{
   import bfp.common.Logger;
   import bfp.common.PokemonBridge;
   import bfp.pdw.common_y.PokemonFukidashi;
   import bfp.pdw.farm.*;
   import bfp.pdw.farm.cursor.*;
   import bfp.pdw.farm.field.*;
   import bfp.pdw.farm.menu.*;
   import bfp.pdw.farm.net.*;
   import bfp.pdw.farm.panel.*;
   import bfp.pdw.farm.ui.*;
   import bfp.pdw.farm.une.*;
   import bfp.pdw.farm.water.*;
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
   
   public class PokemonFiledArea extends EventDispatcher
   {
      
      private var frontArea:MovieClip;
      
      private var backArea:MovieClip;
      
      private var pokeFukidashiArea:MovieClip;
      
      private var pokemonObj:*;
      
      private var pokemonContainer:MovieClip;
      
      private var pokemonFukidashi:PokemonFukidashi;
      
      private var posType:String = "";
      
      private var fukidashiPlaceType:String = "normal";
      
      private const FUKIDASHI_PLACE_TYPE_NORMAL:String = "normal";
      
      private const FUKIDASHI_PLACE_TYPE_BOTTOM:String = "bottom";
      
      private const FUKIDASHI_PLACE_TYPE_UPMIDDLE:String = "upmiddle";
      
      private var data:FarmData;
      
      private var bridge:FarmBridge;
      
      public function PokemonFiledArea(param1:MovieClip, param2:MovieClip, param3:MovieClip)
      {
         super();
         this.frontArea = param1;
         this.backArea = param2;
         this.pokeFukidashiArea = param3;
         this.init();
      }
      
      private function init() : *
      {
         this.data = FarmData.getInstance();
         this.bridge = FarmBridge.getInstance();
         this.frontArea.mouseEnabled = false;
         this.backArea.mouseEnabled = false;
         this.pokemonContainer = new MovieClip();
         this.pokemonContainer.mouseEnabled = false;
         this.pokemonFukidashi = new PokemonFukidashi();
         this.reset();
      }
      
      public function reset() : *
      {
         this.frontArea.visible = false;
         this.frontArea.alpha = 0;
         this.backArea.visible = false;
         this.backArea.alpha = 0;
      }
      
      public function stop() : *
      {
         this.clearBtnFunc();
         Tweener.removeTweens(this);
         Tweener.removeTweens(this.frontArea);
         Tweener.removeTweens(this.backArea);
         this.removePokemon();
         if(this.pokeFukidashiArea.contains(this.pokemonFukidashi))
         {
            this.pokeFukidashiArea.removeChild(this.pokemonFukidashi);
         }
      }
      
      public function run() : *
      {
      }
      
      public function show(param1:* = 0) : *
      {
         this.addPokemon();
         Tweener.removeTweens(this);
         Tweener.addTween(this,{
            "delay":param1,
            "onComplete":this.showAnime
         });
      }
      
      private function showAnime() : *
      {
         Tweener.addTween(this.frontArea,{
            "delay":0,
            "time":0.3,
            "transition":"linear",
            "_autoAlpha":1,
            "onComplete":this.showEnd
         });
         Tweener.addTween(this.backArea,{
            "delay":0,
            "time":0.3,
            "transition":"linear",
            "_autoAlpha":1
         });
      }
      
      private function showEnd() : *
      {
      }
      
      public function hide(param1:* = 0) : *
      {
         Tweener.removeTweens(this);
         Tweener.addTween(this,{
            "delay":param1,
            "onComplete":this.hideAnime
         });
      }
      
      private function hideAnime() : *
      {
         Tweener.addTween(this.frontArea,{
            "delay":0,
            "time":0.1,
            "transition":"linear",
            "_autoAlpha":0,
            "onComplete":this.hideEnd
         });
         Tweener.addTween(this.backArea,{
            "delay":0,
            "time":0.1,
            "transition":"linear",
            "_autoAlpha":0
         });
      }
      
      private function hideEnd() : *
      {
      }
      
      private function getPokemonPosType(param1:DisplayObject) : *
      {
      }
      
      private function addPokemon() : *
      {
         try
         {
            if(this.data.pokemonID != 0)
            {
               this.pokemonContainer.visible = false;
               this.pokemonContainer.alpha = 0;
               this.pokemonObj = PokemonBridge.createRenderer();
               if(this.pokemonObj)
               {
                  Logger.log("はたけ　pokemonNo:" + this.data.pokemonID + "  formNo:" + this.data.pokemonFormID);
                  this.pokemonObj.addEventListener(Event.COMPLETE,this.onPokemonLoadComplete);
                  this.pokemonObj.addEventListener(IOErrorEvent.IO_ERROR,this.onPokemonLoadIOError);
                  this.pokemonObj.loadToScene(this.data.pokemonID,this.data.pokemonFormID,PokemonRendererScene.CROFT);
                  this.pokemonObj.display.buttonMode = true;
               }
            }
            else
            {
               this.pokemonContainer.visible = false;
               this.pokemonContainer.alpha = 0;
            }
         }
         catch(e:*)
         {
            Logger.log("はたけ　addPokemon エラー　message:" + e);
            pokemonObj = null;
         }
      }
      
      private function onPokemonLoadComplete(param1:Event) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:Rectangle = null;
         Logger.log("はたけ　ポケモンロードコンプリート");
         Logger.log("はたけ ポケモン　placeName:" + this.pokemonObj.placeName);
         this.pokemonObj.removeEventListener(Event.COMPLETE,this.onPokemonLoadComplete);
         this.posType = this.pokemonObj.placeName;
         this.data.pokemonPlaceType = this.pokemonObj.placeName;
         switch(this.posType)
         {
            case PokemonRendererScene.CROFT_NEAR_LEFT:
            case PokemonRendererScene.CROFT_NEAR_RIGHT:
               Logger.log("はたけ　ポケモン配置　front");
               this.pokemonContainer.x = 0;
               this.pokemonContainer.y = 0;
               this.pokemonContainer.addChild(this.pokemonObj.display);
               this.frontArea.addChild(this.pokemonContainer);
               break;
            case PokemonRendererScene.CROFT_MIDDLE_LEFT:
            case PokemonRendererScene.CROFT_MIDDLE_RIGHT:
            case PokemonRendererScene.CROFT_FAR_LEFT:
            case PokemonRendererScene.CROFT_FAR_RIGHT:
               Logger.log("はたけ　ポケモン配置　back");
               this.pokemonContainer.x = 0;
               this.pokemonContainer.y = 0;
               this.pokemonContainer.addChild(this.pokemonObj.display);
               this.backArea.addChild(this.pokemonContainer);
               break;
            default:
               Logger.log("はたけ　ポケモン配置　null");
               this.pokemonContainer.x = 0;
               this.pokemonContainer.y = 0;
               this.pokemonContainer.addChild(this.pokemonObj.display);
               this.frontArea.addChild(this.pokemonContainer);
         }
         this.pokemonObj.animator.play(this.pokemonObj.animator.centerFrame);
         var _loc4_:Sprite = Sprite(this.pokemonObj.display);
         var _loc5_:Sprite = Sprite(this.pokemonObj.bodyDisplay);
         _loc4_.tabChildren = false;
         _loc4_.tabEnabled = false;
         _loc3_ = _loc5_.getBounds(this.pokemonContainer);
         this.pokemonFukidashi.dx = Math.floor(_loc4_.x);
         this.pokemonFukidashi.dy = Math.floor(this.getFukidashiPos(this.pokemonContainer.y + _loc3_.y,this.pokemonContainer.y + _loc3_.y + _loc3_.height));
         if(!this.data.isUneIncreaseAnime)
         {
            this.pokemonContainer.visible = true;
            this.pokemonContainer.alpha = 1;
            this.pokemonObj.animator.play();
            this.setBtnFunc();
         }
      }
      
      private function onPokemonLoadIOError(param1:IOErrorEvent) : *
      {
         Logger.log("はたけ　ポケモンロードエラー");
         this.pokemonObj = null;
      }
      
      private function removePokemon() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         if(this.pokemonObj)
         {
            this.pokemonObj.animator.stop();
            this.pokemonObj.dispose();
         }
      }
      
      private function getFukidashiPos(param1:*, param2:*) : *
      {
         var _loc3_:* = 60;
         switch(this.data.pokemonPlaceType)
         {
            case PokemonRendererScene.CROFT_FAR_LEFT:
            case PokemonRendererScene.CROFT_MIDDLE_LEFT:
            case PokemonRendererScene.CROFT_NEAR_LEFT:
               _loc3_ = 214;
         }
         if(param1 < _loc3_)
         {
            if(param2 > 450)
            {
               this.fukidashiPlaceType = this.FUKIDASHI_PLACE_TYPE_UPMIDDLE;
               return _loc3_;
            }
            this.fukidashiPlaceType = this.FUKIDASHI_PLACE_TYPE_BOTTOM;
            return param2;
         }
         this.fukidashiPlaceType = this.FUKIDASHI_PLACE_TYPE_NORMAL;
         return param1;
      }
      
      private function setBtnFunc() : *
      {
         var _loc1_:Sprite = null;
         if(this.pokemonObj)
         {
            _loc1_ = Sprite(this.pokemonObj.display);
            _loc1_.buttonMode = true;
            _loc1_.addEventListener(MouseEvent.CLICK,this.onClick);
            _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.onOver);
            _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this.onOut);
         }
      }
      
      private function clearBtnFunc() : *
      {
         var _loc1_:Sprite = null;
         if(this.pokemonObj)
         {
            _loc1_ = Sprite(this.pokemonObj.display);
            _loc1_.buttonMode = false;
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onClick);
            _loc1_.removeEventListener(MouseEvent.MOUSE_OVER,this.onOver);
            _loc1_.removeEventListener(MouseEvent.MOUSE_OUT,this.onOut);
         }
      }
      
      private function onClick(param1:MouseEvent) : *
      {
         dispatchEvent(new CustomEvent("onPokemonClick"));
      }
      
      private function onOver(param1:MouseEvent) : *
      {
         this.showFukidashi();
      }
      
      private function onOut(param1:MouseEvent) : *
      {
      }
      
      private function showFukidashi() : *
      {
         Logger.log("はたけ　フキダシ表示　myPoint:" + this.data.myPoint);
         switch(this.fukidashiPlaceType)
         {
            case this.FUKIDASHI_PLACE_TYPE_NORMAL:
            case this.FUKIDASHI_PLACE_TYPE_UPMIDDLE:
               if(this.data.myPoint < 100)
               {
                  this.pokemonFukidashi.changeView(this.pokemonFukidashi.VIEW_TYPE_NONE);
                  break;
               }
               if(this.data.myPoint < 300)
               {
                  this.pokemonFukidashi.changeView(this.pokemonFukidashi.VIEW_TYPE_SMAIL);
                  break;
               }
               if(this.data.myPoint < 500)
               {
                  this.pokemonFukidashi.changeView(this.pokemonFukidashi.VIEW_TYPE_MUSIC);
                  break;
               }
               this.pokemonFukidashi.changeView(this.pokemonFukidashi.VIEW_TYPE_HEART);
               break;
            case this.FUKIDASHI_PLACE_TYPE_BOTTOM:
               if(this.data.myPoint < 100)
               {
                  this.pokemonFukidashi.changeView(this.pokemonFukidashi.VIEW_TYPE_REVERSE_NONE);
                  break;
               }
               if(this.data.myPoint < 300)
               {
                  this.pokemonFukidashi.changeView(this.pokemonFukidashi.VIEW_TYPE_REVERSE_SMAIL);
                  break;
               }
               if(this.data.myPoint < 500)
               {
                  this.pokemonFukidashi.changeView(this.pokemonFukidashi.VIEW_TYPE_REVERSE_MUSIC);
                  break;
               }
               this.pokemonFukidashi.changeView(this.pokemonFukidashi.VIEW_TYPE_REVERSE_HEART);
         }
         if(this.pokemonObj)
         {
            this.pokemonFukidashi.x = this.pokemonFukidashi.dx;
            this.pokemonFukidashi.y = this.pokemonFukidashi.dy;
            this.pokeFukidashiArea.addChild(this.pokemonFukidashi);
         }
      }
      
      public function showPokemon(param1:* = 0) : *
      {
         if(this.data.pokemonID != 0 && this.pokemonObj != null)
         {
            Tweener.addTween(this.pokemonContainer,{
               "delay":param1,
               "time":0.1,
               "transition":"linear",
               "_autoAlpha":1,
               "onComplete":this.showPokemonFinish
            });
            this.pokemonObj.animator.play();
         }
      }
      
      private function showPokemonFinish() : *
      {
         this.setBtnFunc();
      }
   }
}

