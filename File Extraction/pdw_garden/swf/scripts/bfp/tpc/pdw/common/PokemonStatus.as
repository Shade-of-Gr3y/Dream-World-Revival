package bfp.tpc.pdw.common
{
   import bfp.IPDWPokemonStatus;
   import bfp.PDWBridge;
   import bfp.PDWHomeData;
   import caurina.transitions.Tweener;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class PokemonStatus extends Panel
   {
      
      private var _tfm:TextFormat;
      
      private var _hasFont:Boolean;
      
      private var _isShow:Boolean;
      
      private var _hitArea:MovieClip;
      
      private var _view:IPDWPokemonStatus;
      
      public function PokemonStatus()
      {
         super();
      }
      
      override public function visit(p:Point, rect:Rectangle) : void
      {
         var type:String;
         var status:PokemonStatus = null;
         PDWBridge.hideMoveArrows();
         if(this._isShow)
         {
            return;
         }
         this._isShow = true;
         type = "";
         if(Boolean(PDWHomeData.myPokemonType1) && Boolean(PDWHomeData.myPokemonType1 != "") && PDWHomeData.myPokemonType1 != "null")
         {
            type = PDWHomeData.myPokemonType1;
         }
         if(Boolean(type != "" && PDWHomeData.myPokemonType2 && PDWHomeData.myPokemonType2 != "") && Boolean(PDWHomeData.myPokemonType2 != "null") && PDWHomeData.myPokemonType1 != PDWHomeData.myPokemonType2)
         {
            type += "　" + PDWHomeData.myPokemonType2;
         }
         else if(Boolean(PDWHomeData.myPokemonType2) && Boolean(PDWHomeData.myPokemonType2 != "") && PDWHomeData.myPokemonType2 != "null")
         {
            type = PDWHomeData.myPokemonType2;
         }
         this._view = PDWBridge.getStatusWindow(PDWHomeData.myPokemonNickName ? PDWHomeData.myPokemonNickName : "",PDWHomeData.myPGLName ? PDWHomeData.myPGLName : "",PDWHomeData.myPokemonName ? PDWHomeData.myPokemonName : "",PDWHomeData.myPokemonOyaName ? PDWHomeData.myPokemonOyaName : "",PDWHomeData.myPokemonLevel ? PDWHomeData.myPokemonLevel : 0,type,PDWHomeData.myPokemonSex,PDWHomeData.myPokemonPersonality ? PDWHomeData.myPokemonPersonality : "",PDWHomeData.myPokemonBall ? PDWHomeData.myPokemonBall : "");
         this._view.addEventListener(Event.CLOSE,this.closeHandler);
         addChild(this._view as DisplayObject);
         super.visit(p,rect);
         status = this;
         Tweener.addTween(this,{
            "time":0.3,
            "onComplete":function():void
            {
               status.addEventListener(MouseEvent.CLICK,clickHandler0);
               status.stage.addEventListener(MouseEvent.CLICK,clickHandler0);
            }
         });
      }
      
      private function closeHandler(event:Event) : void
      {
         this.away();
      }
      
      override public function release() : void
      {
         this._isShow = false;
         if(this._view)
         {
            removeChild(this._view as DisplayObject);
            this._view = null;
         }
         super.release();
      }
      
      private function setText(tf:TextField, value:String, tfm:TextFormat, embedFonts:Boolean, multiline:Boolean = false, multilingual:Boolean = false) : void
      {
         if(tfm.font == "PokemonFontShingoM" || tfm.font == "InterparkGothicOTFM")
         {
            tf.antiAliasType = "advanced";
            tf.gridFitType = "subpixel";
            tf.sharpness = -200;
            tf.thickness = 100;
         }
         tf.defaultTextFormat = tfm;
         tf.autoSize = TextFieldAutoSize.LEFT;
         if(multilingual)
         {
            tf.htmlText = PDWUtils.markupMultilingualText(value);
         }
         else
         {
            tf.text = value;
         }
         tf.embedFonts = embedFonts;
         tf.multiline = multiline;
         tf.selectable = false;
      }
      
      override public function away() : void
      {
         this.removeEventListener(MouseEvent.CLICK,this.clickHandler0);
         if(this.stage)
         {
            this.stage.removeEventListener(MouseEvent.CLICK,this.clickHandler0);
         }
         super.away();
      }
      
      private function clickHandler0(event:MouseEvent) : void
      {
         if(event.currentTarget == this)
         {
            event.stopImmediatePropagation();
         }
         else if(event.currentTarget == this.stage)
         {
            this.away();
         }
      }
   }
}

