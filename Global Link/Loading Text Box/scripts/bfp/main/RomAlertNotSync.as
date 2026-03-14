package bfp.main
{
   import bfp.common.FontManager;
   import bfp.common.PokemonBridge;
   import caurina.transitions.Tweener;
   import caurina.transitions.properties.ColorShortcuts;
   import core.effect.MaskEffectManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.Font;
   import flash.text.TextField;
   
   public class RomAlertNotSync
   {
      
      private var _lines:MovieClip;
      
      private var _container:MovieClip;
      
      private var _back:MovieClip;
      
      private var _message:TextField;
      
      private var _bt:MovieClip;
      
      private var _title:TextField;
      
      public function RomAlertNotSync(param1:MovieClip)
      {
         super();
         this._container = param1;
         this._container.visible = false;
         this._back = this._container.back;
         this._lines = this._container.lines;
         this._title = this._back.title;
         this._message = this._back.message;
         this._bt = this._back.bt;
         ColorShortcuts.init();
      }
      
      public function open() : void
      {
         var _loc1_:Array = Font.enumerateFonts();
         this._title.y = 50;
         this._message.y = 100;
         this._bt.buttonName.y = 17;
         if(_loc1_.length > 1)
         {
            FontManager.setAutoFontTextID(this._title,"pg_ama_4");
            FontManager.setAutoFontTextID(this._message,"pg_ama_5");
            FontManager.setAutoFontTextID(this._bt.buttonName,"pg_ama_1");
         }
         else
         {
            this._title.text = FontManager.getIdText("pg_ama_4");
            this._message.text = FontManager.getIdText("pg_ama_5");
            this._bt.buttonName.text = FontManager.getIdText("pg_ama_1");
         }
         this._bt.buttonMode = true;
         this._bt.addEventListener(MouseEvent.CLICK,this.buttonHandler);
         this._bt.addEventListener(MouseEvent.ROLL_OVER,this.buttonHandler);
         this._bt.addEventListener(MouseEvent.ROLL_OUT,this.buttonHandler);
         Tweener.removeTweens(this._container);
         this._container.visible = true;
         this._lines.scaleX = this._lines.scaleY = 2;
         this._lines.alpha = 0;
         Tweener.addTween(this._container,{
            "alpha":1,
            "time":0.15,
            "transition":"linear"
         });
         Tweener.addTween(this._lines,{
            "alpha":1,
            "time":0.25,
            "delay":0,
            "transition":"linear"
         });
         Tweener.addTween(this._lines,{
            "scaleX":1,
            "scaleY":1,
            "time":0.25,
            "delay":0,
            "transition":"easeOutSine"
         });
         Tweener.addTween(this._lines,{
            "alpha":0,
            "time":0.25,
            "delay":0.3,
            "transition":"linear"
         });
         MaskEffectManager.MaskInImage(this._back,{
            "time":0.25,
            "delay":0.3
         });
      }
      
      private function buttonHandler(param1:MouseEvent = null) : void
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(param1.type)
         {
            case MouseEvent.ROLL_OVER:
               PokemonBridge.mouseOverSound();
               Tweener.addTween(_loc2_,{
                  "_brightness":0.5,
                  "time":0.25,
                  "delay":0,
                  "transition":"linear"
               });
               break;
            case MouseEvent.ROLL_OUT:
               Tweener.addTween(_loc2_,{
                  "_brightness":0,
                  "time":0.25,
                  "delay":0,
                  "transition":"linear"
               });
               break;
            case MouseEvent.CLICK:
               PokemonBridge.mouseClickSound();
               PokemonBridge.href("/");
         }
      }
   }
}

