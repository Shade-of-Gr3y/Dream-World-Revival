package bfp.main
{
   import bfp.common.FontManager;
   import bfp.common.Logger;
   import bfp.common.PokemonBridge;
   import caurina.transitions.Tweener;
   import caurina.transitions.properties.ColorShortcuts;
   import core.effect.MaskEffectManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.Font;
   import flash.text.TextField;
   
   public class RomAlertNoid
   {
      
      private var _lines:MovieClip;
      
      private var _bt2:MovieClip;
      
      private var _container:MovieClip;
      
      private var _back:MovieClip;
      
      private var _message:TextField;
      
      private var _bt1:MovieClip;
      
      private var _title:TextField;
      
      public function RomAlertNoid(param1:MovieClip)
      {
         super();
         this._container = param1;
         this._container.visible = false;
         this._back = this._container.back;
         this._lines = this._container.lines;
         this._title = this._back.title;
         this._message = this._back.message;
         this._bt1 = this._back.bt1;
         this._bt2 = this._back.bt2;
         ColorShortcuts.init();
      }
      
      public function open() : void
      {
         var _loc1_:Array = Font.enumerateFonts();
         this._title.y = 40;
         this._message.y = 100;
         this._bt1.buttonName.y = 14;
         this._bt2.buttonName.y = 14;
         if(_loc1_.length > 1)
         {
            Logger.log(_loc1_.length);
            FontManager.setAutoFontTextID(this._title,"pg_amb_1");
            FontManager.setAutoFontTextID(this._message,"pg_amb_2");
            FontManager.setAutoFontTextID(this._bt1.buttonName,"pg_amb_3");
            FontManager.setAutoFontTextID(this._bt2.buttonName,"pg_amb_4");
         }
         else
         {
            Logger.log("YES");
            this._title.text = FontManager.getIdText("pg_amb_1");
            this._message.text = FontManager.getIdText("pg_amb_2");
            this._bt1.buttonName.text = FontManager.getIdText("pg_amb_3");
            this._bt2.buttonName.text = FontManager.getIdText("pg_amb_4");
         }
         this._bt1.buttonMode = true;
         this._bt1.addEventListener(MouseEvent.CLICK,this.buttonHandler);
         this._bt1.addEventListener(MouseEvent.ROLL_OVER,this.buttonHandler);
         this._bt1.addEventListener(MouseEvent.ROLL_OUT,this.buttonHandler);
         this._bt2.buttonMode = true;
         this._bt2.addEventListener(MouseEvent.CLICK,this.buttonHandler);
         this._bt2.addEventListener(MouseEvent.ROLL_OVER,this.buttonHandler);
         this._bt2.addEventListener(MouseEvent.ROLL_OUT,this.buttonHandler);
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
               if(_loc2_ == this._bt1)
               {
                  PokemonBridge.href("/");
               }
               else
               {
                  PokemonBridge.href("/profile/#register-gsid");
               }
         }
      }
   }
}

