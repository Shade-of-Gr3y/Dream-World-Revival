package bfp.main
{
   import bfp.common.FontManager;
   import bfp.common.PokemonBridge;
   import caurina.transitions.Tweener;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.Font;
   
   public class PokemonLoading
   {
      
      private var _window1:MovieClip;
      
      private var _window2:MovieClip;
      
      private var _container:MovieClip;
      
      private var flag:Boolean = true;
      
      private var _alert:String = "";
      
      public function PokemonLoading(param1:MovieClip)
      {
         super();
         this._container = param1;
         this._container.visible = false;
         this._window1 = this._container.window1;
         this._window2 = this._container.window2;
         this._window1.alpha = 0;
         this._window2.alpha = 0;
         PokemonBridge.addEventListener(PokemonBridge.LOADING_API,this.apiHandler);
         PokemonBridge.addEventListener(PokemonBridge.LOADING_DATA,this.dataHandler);
         PokemonBridge.addEventListener(PokemonBridge.LOADING_CLEAR,this.clearHandler);
      }
      
      private function dataHandler(param1:Event = null) : void
      {
         this.init();
         Tweener.removeTweens(this._window1);
         this._window1.visible = true;
         Tweener.addTween(this._window1,{
            "alpha":1,
            "time":0.25,
            "transition":"linear"
         });
         Tweener.addTween(this._window2,{
            "alpha":0,
            "time":0.25,
            "transition":"linear"
         });
         this._container.addEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
      }
      
      public function clear() : void
      {
         PokemonBridge.removeEventListener(PokemonBridge.LOADING_API,this.apiHandler);
         PokemonBridge.removeEventListener(PokemonBridge.LOADING_DATA,this.dataHandler);
         PokemonBridge.removeEventListener(PokemonBridge.LOADING_CLEAR,this.clearHandler);
         this._container.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         this._container = null;
         this._window1 = null;
         this._window2 = null;
         this._alert = null;
      }
      
      private function init() : void
      {
         Tweener.removeTweens(this._container);
         this._container.visible = true;
         this._container.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         this._window1.loading.y = 68;
         var _loc1_:Array = Font.enumerateFonts();
         if(_loc1_.length > 1)
         {
            FontManager.setAutoFontTextID(this._window1.loading,"pg_opa_1");
         }
         else
         {
            this._window1.loading.text = "";
         }
      }
      
      private function clearHandler(param1:Event = null) : void
      {
         Tweener.removeTweens(this._window1);
         Tweener.addTween(this._window1,{
            "alpha":0,
            "time":0.25,
            "transition":"linear"
         });
         Tweener.removeTweens(this._window2);
         Tweener.addTween(this._window2,{
            "alpha":0,
            "time":0.25,
            "transition":"linear"
         });
         Tweener.addTween(this._container,{
            "visible":false,
            "time":0,
            "delay":0.25,
            "transition":"linear"
         });
      }
      
      private function apiHandler(param1:Event = null) : void
      {
         this.init();
         Tweener.removeTweens(this._window2);
         this._window2.visible = true;
         Tweener.addTween(this._window2,{
            "alpha":1,
            "time":0.25,
            "transition":"linear"
         });
         Tweener.addTween(this._window1,{
            "alpha":0,
            "time":0.25,
            "transition":"linear"
         });
         this._container.addEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
      }
      
      private function enterFrameHandler(param1:Event = null) : void
      {
         var _loc2_:* = Math.floor(PokemonBridge.percent * 100) + "%";
         this._window1.percent.text = _loc2_;
         if(this.flag)
         {
            this._window1.circle.rotation += 360 / 12;
            this._window2.circle.rotation += 360 / 12;
            this.flag = false;
         }
         else
         {
            this.flag = true;
         }
      }
   }
}

