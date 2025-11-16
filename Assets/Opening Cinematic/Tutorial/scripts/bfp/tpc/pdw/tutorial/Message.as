package bfp.tpc.pdw.tutorial
{
   import bfp.PDWBridge;
   import bfp.PDWTutorial;
   import bfp.PDWTutorialEvent;
   import bfp.PDWTutorialMessages;
   import bfp.common.FontManager;
   import bfp.common.PokemonBridge;
   import caurina.transitions.Tweener;
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.ColorTransform;
   import flash.text.Font;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class Message extends Sprite
   {
      
      public static const LINK_CLICK:String = "message_linkClick";
       
      
      public var nextmc:MovieClip;
      
      public var alertmc:MovieClip;
      
      private var _currentMessageId:int;
      
      private var _currentMessageType:int;
      
      private var _messageData:Array;
      
      private var _bmp:Bitmap;
      
      private var _tf:TextField;
      
      private var _container:Sprite;
      
      public function Message()
      {
         super();
         this.nextmc.gotoAndStop(1);
         this.blendMode = BlendMode.LAYER;
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      public function get currentMessageId() : int
      {
         return this._currentMessageId;
      }
      
      public function set currentMessageId(param1:int) : void
      {
         this._currentMessageId = param1;
      }
      
      private function addedToStageHandler(param1:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
         this.init();
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
      }
      
      private function removedFromStageHandler(param1:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
         this.release();
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      public function init() : void
      {
         var _loc2_:* = undefined;
         var _loc3_:StyleSheet = null;
         var _loc4_:TextFormat = null;
         var _loc5_:TextFormat = null;
         var _loc6_:Font = null;
         this.visible = false;
         this.x = 163;
         this.y = 396;
         var _loc1_:Boolean = false;
         for(_loc2_ in Font.enumerateFonts())
         {
            if((_loc6_ = Font.enumerateFonts()[_loc2_]).fontName == "PokemonFontShingoM")
            {
               _loc1_ = true;
               break;
            }
         }
         _loc3_ = new StyleSheet();
         _loc3_.setStyle("a",{
            "color":"#31190C",
            "textDecoration":"underline"
         });
         _loc3_.setStyle("p",{
            "color":"#31190C",
            "fontSize":13,
            "leading":4
         });
         _loc3_.setStyle(".emphasis",{"color":"#EC4E4D"});
         (_loc4_ = new TextFormat()).font = "PokemonFontShingoM";
         _loc4_.size = 13;
         _loc4_.color = 16777215;
         this.alertmc.btn0.tf.defaultTextFormat = _loc4_;
         this.alertmc.btn0.tf.embedFonts = _loc1_;
         this.alertmc.btn0.tf.wordWrap = false;
         this.alertmc.btn0.tf.multiline = false;
         this.alertmc.btn0.tf.autoSize = TextFieldAutoSize.LEFT;
         this.alertmc.btn1.tf.defaultTextFormat = _loc4_;
         this.alertmc.btn1.tf.embedFonts = _loc1_;
         this.alertmc.btn1.tf.wordWrap = false;
         this.alertmc.btn1.tf.multiline = false;
         this.alertmc.btn1.tf.autoSize = TextFieldAutoSize.LEFT;
         (_loc5_ = new TextFormat()).font = "PokemonFontShingoM";
         _loc5_.size = 13;
         _loc5_.color = 3217676;
         _loc5_.leading = 4;
         this._container = new Sprite();
         addChild(this._container);
         this._tf = new TextField();
         this._tf.defaultTextFormat = _loc5_;
         this._tf.width = 589;
         this._tf.selectable = false;
         this._tf.height = 83;
         this._tf.htmlText = "";
         this._tf.multiline = true;
         this._tf.embedFonts = _loc1_;
         this._tf.wordWrap = true;
         this._container.addChild(this._tf);
         this._tf.styleSheet = _loc3_;
         this.setChildIndex(this.alertmc,this.numChildren - 1);
         this.setChildIndex(this.nextmc,this.numChildren - 1);
      }
      
      public function release() : void
      {
         if(this._bmp)
         {
            this._container.removeChild(this._bmp);
            this._bmp = null;
         }
         this.alertmc.btn0.removeEventListener(MouseEvent.CLICK,this.clickHandler);
         this.alertmc.btn1.removeEventListener(MouseEvent.CLICK,this.clickHandler);
         this.nextmc.removeEventListener(MouseEvent.CLICK,this.clickHandler);
      }
      
      public function open() : void
      {
         if(this._bmp)
         {
            this._container.removeChild(this._bmp);
            this._bmp = null;
         }
         this.reset(this.nextmc.bgmc);
         this.reset(this.alertmc.btn0.bgmc);
         this.reset(this.alertmc.btn1.bgmc);
         this.unsetBtn(this.nextmc,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         this.unsetBtn(this.alertmc.btn0,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         this.unsetBtn(this.alertmc.btn1,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         this.visible = true;
         this.alertmc.visible = false;
         this.alpha = 0;
         this._tf.text = "";
         Tweener.addTween(this,{
            "time":0.4,
            "alpha":1,
            "transition":"easeNone"
         });
      }
      
      public function close() : void
      {
         if(this._bmp)
         {
            this._container.removeChild(this._bmp);
            this._bmp = null;
         }
         this._tf.text = "";
         this.unsetBtn(this.nextmc,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         this.unsetBtn(this.alertmc.btn0,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         this.unsetBtn(this.alertmc.btn1,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         Tweener.addTween(this,{
            "time":0.4,
            "alpha":0,
            "transition":"easeNone",
            "onComplete":function():void
            {
               _currentMessageId = 0;
               if(_tf)
               {
                  _tf.removeEventListener(TextEvent.LINK,linkHandler);
               }
               _tf.text = "";
               this.visible = false;
            }
         });
      }
      
      public function start(param1:Array) : void
      {
         if(this._bmp)
         {
            this._container.removeChild(this._bmp);
            this._bmp = null;
         }
         this._tf.text = "";
         this._currentMessageId = 0;
         this._messageData = param1;
         this.setMessage(0);
      }
      
      public function setMessage(param1:int) : void
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         this.alertmc.visible = false;
         this.unsetBtn(this.nextmc,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         this.unsetBtn(this.alertmc.btn0,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         this.unsetBtn(this.alertmc.btn1,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         if(this._bmp)
         {
            this._container.removeChild(this._bmp);
            this._bmp = null;
         }
         this._currentMessageId = param1;
         this._currentMessageType = this._messageData[param1][0];
         if(this._currentMessageType == PDWTutorialMessages.TYPE_DESIGNED)
         {
            this._tf.visible = false;
            this._bmp = PDWTutorial.assetsOfTutorial[this._messageData[param1][1]];
            this._bmp.x = 5;
            this._bmp.y = 5;
            this._container.addChild(this._bmp);
            this.nextmc.gotoAndStop(1);
            this.setBtn(this.nextmc,{
               "over":this.mouseOverHandler,
               "out":this.mouseOutHandler,
               "click":this.clickHandler
            });
            PDWTutorial.dispatchEvent(new PDWTutorialEvent(PDWTutorialEvent.MESSAGE_CHANGE,{"id":this._currentMessageId}));
            return;
         }
         this._tf.visible = true;
         var _loc2_:int = 77;
         if(this._currentMessageType == 1)
         {
            _loc2_ = 40;
         }
         if(this._tf)
         {
            this._tf.removeEventListener(TextEvent.LINK,this.linkHandler);
         }
         this._tf.addEventListener(TextEvent.LINK,this.linkHandler);
         this._tf.y = 13;
         this._tf.x = 19;
         this._tf.antiAliasType = "advanced";
         this._tf.gridFitType = "subpixel";
         this._tf.sharpness = -200;
         this._tf.thickness = 100;
         var _loc3_:String = FontManager.getIdText(this._messageData[param1][1]);
         _loc3_ = _loc3_.replace(/<span class='emphasis'>/ig,"[startemphasis]");
         _loc3_ = _loc3_.replace(/<span class='textlink'>/ig,"[starttextlink]");
         _loc3_ = _loc3_.replace(/<\/span>/ig,"[endspan]");
         _loc3_ = _loc3_.replace(/<a href='event:MouseEvent' id='about_gamesync_idcode'>/ig,"[starta1]");
         _loc3_ = _loc3_.replace(/<\/a>/ig,"[enda1]");
         var _loc4_:String = (_loc4_ = (_loc4_ = (_loc4_ = (_loc4_ = (_loc4_ = (_loc4_ = (_loc4_ = FontManager.markupMultilingualText(_loc3_,false)).replace(/\[startemphasis\]/ig,"<span class=\'emphasis\'>")).replace(/\[starttextlink\]/ig,"<span class=\'textlink\'>")).replace(/\[endspan\]/ig,"</span>")).replace(/\[starta1\]/ig,"<a href=\'event:MouseEvent\' id=\'about_gamesync_idcode\'>")).replace(/\[enda1\]/ig,"</a>")).replace(/<FONT FACE="PokemonHelveticaNeueLTStdMdCn"><\/span><span class='textlink'><\/FONT>/ig,"</span><span class=\'textlink\'>")).replace(/<FONT FACE="PokemonHelveticaNeueLTStdMdCn"><\/span><\/a><\/FONT>/ig,"</span></a>");
         if(PokemonBridge.lang != "ko")
         {
            _loc4_ = _loc4_.replace(/<\/FONT><FONT FACE="PokemonFontKozM"> <\/FONT><FONT FACE="PokemonHelveticaNeueLTStdMdCn">/ig," ");
         }
         _loc4_ = (_loc4_ = (_loc4_ = (_loc4_ = (_loc4_ = _loc4_.replace(/<FONT FACE="PokemonHelveticaNeueLTStdMdCn"><\/span><\/FONT>/ig,"</span>")).replace(/<FONT FACE="PokemonHelveticaNeueLTStdMdCn"><span class='emphasis'><\/FONT>/ig,"<span class=\'emphasis\'>")).replace(/<FONT FACE="PokemonHelveticaNeueLTStdMdCn"><span class='textlink'><\/FONT>/ig,"<span class=\'textlink\'>")).replace(/<FONT FACE="PokemonHelveticaNeueLTStdMdCn"><\/span><\/a><\/FONT>/ig,"</span></a>")).replace(/<FONT FACE="PokemonHelveticaNeueLTStdMdCn"><a href='event:MouseEvent' id='about_gamesync_idcode'><span class='emphasis'><\/FONT>/ig,"<a href=\'event:MouseEvent\' id=\'about_gamesync_idcode\'><span class=\'emphasis\'>");
         this._tf.htmlText = "";
         this._tf.embedFonts = true;
         this._tf.htmlText = _loc4_;
         PDWTutorial.dispatchEvent(new PDWTutorialEvent(PDWTutorialEvent.MESSAGE_CHANGE,{"id":this._currentMessageId}));
         if(this._currentMessageType == PDWTutorialMessages.TYPE_NORMAL)
         {
            this.reset(this.nextmc);
            this.setBtn(this.nextmc,{
               "over":this.mouseOverHandler,
               "out":this.mouseOutHandler,
               "click":this.clickHandler
            });
         }
         else if(this._currentMessageType == PDWTutorialMessages.TYPE_QUESTION)
         {
            _loc5_ = FontManager.markupMultilingualText(FontManager.getIdText(this._messageData[param1][2]),false);
            FontManager.setHtmlText(this.alertmc.btn0.tf,_loc5_);
            _loc6_ = FontManager.markupMultilingualText(FontManager.getIdText(this._messageData[param1][3]),false);
            FontManager.setHtmlText(this.alertmc.btn1.tf,_loc6_);
            this.alertmc.btn0.tf.y = 5;
            this.alertmc.btn1.tf.y = 5;
            this.alertmc.btn0.tf.x = int((180 - this.alertmc.btn0.tf.width) / 2);
            this.alertmc.btn1.tf.x = int((180 - this.alertmc.btn1.tf.width) / 2);
            this.reset(this.nextmc);
            this.setUnavailableColor(this.nextmc);
            this.reset(this.nextmc.bgmc);
            this.unsetBtn(this.nextmc,{
               "over":this.mouseOverHandler,
               "out":this.mouseOutHandler,
               "click":this.clickHandler
            });
            this.setBtn(this.alertmc.btn0,{
               "over":this.mouseOverHandler,
               "out":this.mouseOutHandler,
               "click":this.clickHandler
            });
            this.setBtn(this.alertmc.btn1,{
               "over":this.mouseOverHandler,
               "out":this.mouseOutHandler,
               "click":this.clickHandler
            });
            this.alertmc.visible = true;
         }
      }
      
      private function setUnavailableColor(param1:DisplayObject) : void
      {
         var _loc2_:ColorTransform = param1.transform.colorTransform;
         _loc2_.redMultiplier = 0.5;
         _loc2_.greenMultiplier = 0.5;
         _loc2_.blueMultiplier = 0.5;
         _loc2_.redOffset = 111;
         _loc2_.greenOffset = 111;
         _loc2_.blueOffset = 111;
         param1.transform.colorTransform = _loc2_;
      }
      
      public function nextpage() : void
      {
         ++this._currentMessageId;
         if(this._messageData.length <= this._currentMessageId)
         {
            PDWTutorial.dispatchEvent(new PDWTutorialEvent(PDWTutorialEvent.MESSAGE_COMPLETE,{"id":this._currentMessageId}));
         }
         else
         {
            this.setMessage(this._currentMessageId);
         }
      }
      
      private function linkHandler(param1:TextEvent) : void
      {
         PDWTutorial.dispatchEvent(new PDWTutorialEvent(PDWTutorialEvent.MESSAGE_LINK_CLICK,{"id":this._currentMessageId}));
      }
      
      private function mouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         PDWBridge.sfxMouseOver();
         switch(_loc2_.name)
         {
            case "nextmc":
            case "btn0":
            case "btn1":
               this.paint(_loc2_.bgmc,PDWBridge.ROLLOVER_COLOR);
         }
      }
      
      private function mouseOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_.name)
         {
            case "nextmc":
            case "btn0":
            case "btn1":
               this.reset(_loc2_.bgmc);
         }
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         PDWBridge.sfxClick();
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_.name)
         {
            case "nextmc":
               this.nextpage();
               break;
            case "btn0":
               this.reset(_loc2_.bgmc);
               PDWTutorial.dispatchEvent(new PDWTutorialEvent(PDWTutorialEvent.MESSAGE_BUTTON_CLICK,{
                  "id":this._currentMessageId,
                  "click":0
               }));
               break;
            case "btn1":
               this.reset(_loc2_.bgmc);
               PDWTutorial.dispatchEvent(new PDWTutorialEvent(PDWTutorialEvent.MESSAGE_BUTTON_CLICK,{
                  "id":this._currentMessageId,
                  "click":1
               }));
         }
      }
      
      private function reset(param1:DisplayObject) : void
      {
         var _loc2_:ColorTransform = param1.transform.colorTransform;
         _loc2_.redMultiplier = 1;
         _loc2_.greenMultiplier = 1;
         _loc2_.blueMultiplier = 1;
         _loc2_.redOffset = 0;
         _loc2_.greenOffset = 0;
         _loc2_.blueOffset = 0;
         param1.transform.colorTransform = _loc2_;
      }
      
      private function paint(param1:DisplayObject, param2:int = 16711680) : void
      {
         var _loc3_:ColorTransform = param1.transform.colorTransform;
         _loc3_.redMultiplier = 0;
         _loc3_.greenMultiplier = 0;
         _loc3_.blueMultiplier = 0;
         _loc3_.redOffset = param2 >> 16 & 255;
         _loc3_.greenOffset = param2 >> 8 & 255;
         _loc3_.blueOffset = param2 & 255;
         param1.transform.colorTransform = _loc3_;
      }
      
      public function setBtn(param1:DisplayObject, param2:Object, param3:Boolean = true, param4:Boolean = false) : void
      {
         Sprite(param1).buttonMode = param3;
         Sprite(param1).mouseChildren = param4;
         if(param2)
         {
            if(param2.over)
            {
               param1.addEventListener(MouseEvent.MOUSE_OVER,param2.over);
            }
            if(param2.out)
            {
               param1.addEventListener(MouseEvent.MOUSE_OUT,param2.out);
            }
            if(param2.down)
            {
               param1.addEventListener(MouseEvent.MOUSE_DOWN,param2.down);
            }
            if(param2.up)
            {
               param1.addEventListener(MouseEvent.MOUSE_UP,param2.up);
            }
            if(param2.click)
            {
               param1.addEventListener(MouseEvent.CLICK,param2.click);
            }
            if(param2.doubleClick)
            {
               Sprite(param1).doubleClickEnabled = true;
               param1.addEventListener(MouseEvent.DOUBLE_CLICK,param2.doubleClick);
            }
         }
      }
      
      public function unsetBtn(param1:DisplayObject, param2:Object, param3:Boolean = false, param4:Boolean = true) : void
      {
         Sprite(param1).buttonMode = param3;
         Sprite(param1).mouseChildren = param4;
         if(param2)
         {
            if(param2.over)
            {
               param1.removeEventListener(MouseEvent.MOUSE_OVER,param2.over);
            }
            if(param2.out)
            {
               param1.removeEventListener(MouseEvent.MOUSE_OUT,param2.out);
            }
            if(param2.down)
            {
               param1.removeEventListener(MouseEvent.MOUSE_DOWN,param2.down);
            }
            if(param2.up)
            {
               param1.removeEventListener(MouseEvent.MOUSE_UP,param2.up);
            }
            if(param2.click)
            {
               param1.removeEventListener(MouseEvent.CLICK,param2.click);
            }
            if(param2.doubleClick)
            {
               Sprite(param1).doubleClickEnabled = false;
               param1.removeEventListener(MouseEvent.DOUBLE_CLICK,param2.doubleClick);
            }
         }
      }
   }
}
