package bfp.tpc.pdw.garden
{
   import bfp.PDWBridge;
   import bfp.PDWHomeData;
   import bfp.common.FontManager;
   import bfp.common.PokemonBridge;
   import bfp.tpc.pdw.common.*;
   import caurina.transitions.Tweener;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.ProgressEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.LocalConnection;
   import flash.net.URLRequest;
   import flash.text.Font;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import jp.feb19.utils.Tracer;
   
   public class Garden extends Sprite
   {
      
      public var titlemc:MovieClip;
      
      public var ballondoormc:MovieClip;
      
      public var ballonfootprintmc:MovieClip;
      
      public var mistmc:MovieClip;
      
      private var _pokemon:*;
      
      private var _emotion:Emotion;
      
      private var _status:PokemonStatus;
      
      private var _exteriorLoader:Loader;
      
      private var _islandId:int;
      
      private var _tf:TextField;
      
      private var _pokemonSet:*;
      
      private var _emotionSet:*;
      
      private var _emotionWordSet:*;
      
      private var _mistBmd:BitmapData;
      
      private var _mistBmp:Bitmap;
      
      public function Garden()
      {
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      private function addedToStageHandler(event:Event = null) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
         this.init();
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
      }
      
      private function removedFromStageHandler(event:Event = null) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
         this.release();
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      public function init() : void
      {
         var i:String = null;
         var tfm:TextFormat = null;
         var f:Font = null;
         var label_id:* = undefined;
         var hasFont:Boolean = false;
         for(i in Font.enumerateFonts())
         {
            f = Font.enumerateFonts()[i];
            if(f.fontName == "PokemonFontShingoM")
            {
               hasFont = true;
               break;
            }
         }
         tfm = new TextFormat();
         tfm.align = TextFormatAlign.LEFT;
         tfm.font = "PokemonFontShingoM";
         tfm.color = 4202765;
         tfm.size = 11;
         tfm.letterSpacing = 0;
         this.ballondoormc.tf.defaultTextFormat = tfm;
         this.ballondoormc.tf.antiAliasType = "advanced";
         this.ballondoormc.tf.gridFitType = "subpixel";
         this.ballondoormc.tf.sharpness = -200;
         this.ballondoormc.tf.thickness = 200;
         this.ballondoormc.tf.embedFonts = hasFont;
         this.ballondoormc.tf.autoSize = TextFieldAutoSize.LEFT;
         this.ballondoormc.tf.selectable = false;
         this.ballondoormc.tf.mouseEnabled = false;
         this.ballondoormc.tf.multiline = false;
         this.ballondoormc.tf.y = 3;
         if(PDWHomeData.currentHomeType == PDWHomeData.HOME_CAMPAIGN && Boolean(campaignData.data.home.hasOwnProperty("button_label")))
         {
            label_id = campaignData.data.home.button_label.into_room;
            FontManager.setTextID(this.ballondoormc.tf,label_id);
         }
         else
         {
            FontManager.setTextID(this.ballondoormc.tf,"h_ca_7");
         }
         if(!this.ballondoormc.defX)
         {
            this.ballondoormc.bgmc.x = 5;
            this.ballondoormc.bgmc.width = this.ballondoormc.tf.width;
            this.ballondoormc.bgrightmc.x = this.ballondoormc.tf.width + 5;
            this.ballondoormc.bgbottommc.x = int(this.ballondoormc.tf.width / 2 - 7 / 2) + 5;
         }
         this.ballonfootprintmc.tf.defaultTextFormat = tfm;
         this.ballonfootprintmc.tf.antiAliasType = "advanced";
         this.ballonfootprintmc.tf.gridFitType = "subpixel";
         this.ballonfootprintmc.tf.sharpness = -200;
         this.ballonfootprintmc.tf.thickness = 200;
         this.ballonfootprintmc.tf.embedFonts = hasFont;
         this.ballonfootprintmc.tf.autoSize = TextFieldAutoSize.LEFT;
         this.ballonfootprintmc.tf.selectable = false;
         this.ballonfootprintmc.tf.mouseEnabled = false;
         this.ballonfootprintmc.tf.multiline = false;
         this.ballonfootprintmc.tf.y = 3;
         if(PDWHomeData.isCampaign)
         {
            FontManager.setTextID(this.ballonfootprintmc.tf,"h_ca_21");
         }
         else
         {
            FontManager.setTextID(this.ballonfootprintmc.tf,"h_ca_8");
         }
         this.ballonfootprintmc.bgmc.x = 5;
         this.ballonfootprintmc.bgmc.width = this.ballonfootprintmc.tf.width;
         this.ballonfootprintmc.bgrightmc.x = this.ballonfootprintmc.tf.width + 5;
         this.ballonfootprintmc.bgbottommc.x = int(this.ballonfootprintmc.tf.width / 2 - 7 / 2) + 5;
         this.tabEnabled = false;
         this.tabChildren = false;
         this.blendMode = BlendMode.LAYER;
         this.ballondoormc.visible = false;
         this.ballondoormc.mouseEnabled = false;
         this.ballondoormc.mouseChildren = false;
         this.ballonfootprintmc.visible = false;
         this.ballonfootprintmc.mouseEnabled = false;
         this.ballonfootprintmc.mouseChildren = false;
         PDWBridge.currentHelp = PDWBridge.HELP_HOME_TOP;
         if(PDWHomeData.myPoint < 100)
         {
            this._emotion = new AssetEmotion0();
         }
         else if(PDWHomeData.myPoint < 300)
         {
            this._emotion = new AssetEmotion2();
         }
         else if(PDWHomeData.myPoint < 500)
         {
            this._emotion = new AssetEmotion3();
         }
         else
         {
            this._emotion = new AssetEmotion4();
         }
         this.titlemc.alpha = 0;
         var islandId:int = 0;
         if(PDWHomeData.isCampaign)
         {
            islandId = PDWHomeData.campaignId + 10000;
         }
         else if(PDWHomeData.isMyHome)
         {
            islandId = PDWHomeData.myIslandId;
         }
         else
         {
            islandId = PDWHomeData.anotherIslandId;
         }
         if(islandId < 0)
         {
            islandId = 0;
         }
         if(!this._mistBmd)
         {
            this._mistBmd = PDWBridge.mistBitmapData.clone();
         }
         if(!this._mistBmp)
         {
            this._mistBmp = new Bitmap(this._mistBmd);
            this.mistmc.addChild(this._mistBmp);
         }
         this.mistmc.mouseEnabled = false;
         this.mistmc.mouseChildren = false;
         if(Boolean(this._exteriorLoader) && Boolean(this._exteriorLoader.content) && this._islandId == islandId)
         {
            addChildAt(this._exteriorLoader.content,0);
            this._exteriorLoader.content.addEventListener(ExteriorConfig.SHOW_BALLON_DOOR,this.showBallonDoorHandler);
            this._exteriorLoader.content.addEventListener(ExteriorConfig.SHOW_BALLON_FOOTPRINT,this.showBallonFootprintHandler);
            this._exteriorLoader.content.addEventListener(ExteriorConfig.SHOW_BALLON_PANEL,this.showBallonPanelHandler);
            this._exteriorLoader.content.addEventListener(ExteriorConfig.HIDE_BALLON_DOOR,this.hideBallonDoorHandler);
            this._exteriorLoader.content.addEventListener(ExteriorConfig.HIDE_BALLON_FOOTPRINT,this.hideBallonFootprintHandler);
            this._exteriorLoader.content.addEventListener(ExteriorConfig.HIDE_BALLON_PANEL,this.hideBallonPanelHandler);
            this.loadPokemon();
            setChildIndex(this.mistmc,this.numChildren - 1);
            setChildIndex(this.ballondoormc,this.numChildren - 1);
            setChildIndex(this.ballonfootprintmc,this.numChildren - 1);
            setChildIndex(this.titlemc,this.numChildren - 1);
         }
         else
         {
            this.loadExterior(islandId);
            this._islandId = islandId;
         }
      }
      
      public function release() : void
      {
         var i:* = undefined;
         var emo_data:* = undefined;
         var poke_data:* = undefined;
         if(this._pokemon)
         {
            this._pokemon.removeEventListener(Event.COMPLETE,this.loadCompleteHandler);
            this._pokemon.removeEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
            if(Boolean(this._pokemon.display) && Boolean(this._pokemon.display.parent))
            {
               removeChild(this._pokemon.display);
               this._pokemon.display.removeEventListener(MouseEvent.MOUSE_OVER,this.mouseOverHandler);
               this._pokemon.display.removeEventListener(MouseEvent.CLICK,this.clickHandler);
            }
            this._pokemon.dispose();
            this._pokemon = null;
         }
         Tweener.removeTweens(this.titlemc);
         if(this._tf)
         {
            this.titlemc.removeChild(this._tf);
            this._tf = null;
         }
         if(Boolean(this._exteriorLoader) && Boolean(this._exteriorLoader.content) && Boolean(this._exteriorLoader.content.parent))
         {
            this._exteriorLoader.content.removeEventListener(ExteriorConfig.SHOW_BALLON_DOOR,this.showBallonDoorHandler);
            this._exteriorLoader.content.removeEventListener(ExteriorConfig.SHOW_BALLON_FOOTPRINT,this.showBallonFootprintHandler);
            this._exteriorLoader.content.removeEventListener(ExteriorConfig.SHOW_BALLON_PANEL,this.showBallonPanelHandler);
            this._exteriorLoader.content.removeEventListener(ExteriorConfig.HIDE_BALLON_DOOR,this.hideBallonDoorHandler);
            this._exteriorLoader.content.removeEventListener(ExteriorConfig.HIDE_BALLON_FOOTPRINT,this.hideBallonFootprintHandler);
            this._exteriorLoader.content.removeEventListener(ExteriorConfig.HIDE_BALLON_PANEL,this.hideBallonPanelHandler);
            this._exteriorLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.exterirorProgressHandler);
            this._exteriorLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.exterirorCompleteHandler);
            this._exteriorLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.exterirorIOErrorHandler);
            removeChild(this._exteriorLoader.content);
         }
         if(this._emotion)
         {
            if(this._emotion.parent)
            {
               removeChild(this._emotion);
            }
            this._emotion = null;
         }
         if(Boolean(this._status) && Boolean(this._status.parent))
         {
            this._status.removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler1);
            removeChild(this._status);
            this._status = null;
         }
         if(this._mistBmp)
         {
            if(this._mistBmp.parent)
            {
               this.mistmc.removeChild(this._mistBmp);
            }
            this._mistBmp = null;
         }
         if(this._mistBmd)
         {
            this._mistBmd.dispose();
            this._mistBmd = null;
         }
         if(this._pokemonSet)
         {
            for(i = 0; i < this._pokemonSet.length; i++)
            {
               poke_data = this._pokemonSet[i];
               poke_data.addEventListener(MouseEvent.MOUSE_OVER,this.pokemonMouseOverHandler);
               poke_data.addEventListener(MouseEvent.CLICK,this.pokemonClickHandler);
               removeChild(poke_data.renderPokemon.display);
               poke_data.unloadSwf();
               this._pokemonSet[i] = null;
            }
            this._pokemonSet = null;
         }
         if(this._emotionSet)
         {
            for(i = 0; i < this._emotionSet.length; i++)
            {
               emo_data = this._emotionSet[i];
               if(this.contains(emo_data))
               {
                  removeChild(emo_data);
               }
               this._emotionSet[i] = null;
            }
            this._emotionSet = null;
         }
         if(this._emotionWordSet)
         {
            for(i = 0; i < this._emotionWordSet.length; i++)
            {
               this._emotionWordSet[i] = null;
            }
            this._emotionWordSet = null;
         }
      }
      
      public function changeExteriror() : void
      {
         var islandId:int = 0;
         if(PDWHomeData.isCampaign)
         {
            islandId = PDWHomeData.campaignId + 10000;
         }
         else if(PDWHomeData.isMyHome)
         {
            islandId = PDWHomeData.myIslandId;
         }
         else
         {
            islandId = PDWHomeData.anotherIslandId;
         }
         if(islandId < 0)
         {
            islandId = 0;
         }
         this.loadExterior(islandId);
         setChildIndex(this.mistmc,this.numChildren - 1);
      }
      
      private function loadExterior(islandId:int = 201) : void
      {
         var url:String = this.loaderInfo.url;
         var path:String = url.substr(0,url.lastIndexOf("/")) + "/";
         var cacheBuster:String = !PDWBridge.isLocal ? "?appver=" + PokemonBridge.version : "";
         var version:String = "";
         this._exteriorLoader = new Loader();
         this._exteriorLoader.tabEnabled = false;
         this._exteriorLoader.tabChildren = false;
         this._exteriorLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.exterirorCompleteHandler);
         this._exteriorLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.exterirorProgressHandler);
         this._exteriorLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.exterirorIOErrorHandler);
         if(new LocalConnection().domain == "localhost")
         {
            this._exteriorLoader.load(new URLRequest(path + "./" + islandId + ".swf"));
         }
         else
         {
            this._exteriorLoader.load(new URLRequest(path + "../../theme/assets/global/parts/interior/" + islandId + ".swf" + cacheBuster + version));
         }
      }
      
      private function exterirorProgressHandler(event:ProgressEvent) : void
      {
         dispatchEvent(event);
      }
      
      private function exterirorCompleteHandler(event:Event) : void
      {
         this._exteriorLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.exterirorProgressHandler);
         this._exteriorLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.exterirorCompleteHandler);
         this._exteriorLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.exterirorIOErrorHandler);
         this._exteriorLoader.content.addEventListener(ExteriorConfig.INIT_DATA,this.initExteriorHandler);
         addChildAt(this._exteriorLoader.content,0);
         dispatchEvent(new Event(Event.COMPLETE));
         this.loadPokemon();
         this._exteriorLoader.content.addEventListener(ExteriorConfig.SHOW_BALLON_DOOR,this.showBallonDoorHandler);
         this._exteriorLoader.content.addEventListener(ExteriorConfig.SHOW_BALLON_FOOTPRINT,this.showBallonFootprintHandler);
         this._exteriorLoader.content.addEventListener(ExteriorConfig.SHOW_BALLON_PANEL,this.showBallonPanelHandler);
         this._exteriorLoader.content.addEventListener(ExteriorConfig.HIDE_BALLON_DOOR,this.hideBallonDoorHandler);
         this._exteriorLoader.content.addEventListener(ExteriorConfig.HIDE_BALLON_FOOTPRINT,this.hideBallonFootprintHandler);
         this._exteriorLoader.content.addEventListener(ExteriorConfig.HIDE_BALLON_PANEL,this.hideBallonPanelHandler);
         setChildIndex(this.titlemc,numChildren - 1);
      }
      
      private function initExteriorHandler(event:Event) : void
      {
         var data:* = undefined;
         var one_data:* = undefined;
         var rotate_data:* = undefined;
         this._exteriorLoader.content.removeEventListener(ExteriorConfig.INIT_DATA,this.initExteriorHandler);
         Tracer.add("footprint --------------------");
         Tracer.add("x: " + ExteriorConfig.footprintX);
         Tracer.add("y: " + ExteriorConfig.footprintY);
         Tracer.add("w: " + ExteriorConfig.footprintW);
         Tracer.add("h: " + ExteriorConfig.footprintH);
         Tracer.add("door --------------------");
         Tracer.add("x: " + ExteriorConfig.doorX);
         Tracer.add("y: " + ExteriorConfig.doorY);
         Tracer.add("w: " + ExteriorConfig.doorW);
         Tracer.add("h: " + ExteriorConfig.doorH);
         this.ballonfootprintmc.defX = int((ExteriorConfig.footprintW - this.ballonfootprintmc.width) / 2) + ExteriorConfig.footprintX;
         this.ballonfootprintmc.defY = ExteriorConfig.footprintY - 36;
         if(PDWHomeData.isCampaign)
         {
            data = campaignData.data;
            this.ballondoormc.defX = data.home.ballon.(@type == "door").@x;
            this.ballondoormc.defY = data.home.ballon.(@type == "door").@y;
            one_data = data.home.ballon.(@type == "door");
            rotate_data = one_data.@rotate;
            if(Boolean(one_data.hasOwnProperty("@rotate")) && Boolean(rotate_data))
            {
               switch(String(rotate_data))
               {
                  case "left":
                     this.ballondoormc.bgbottommc.rotation = 90;
                     this.ballondoormc.bgbottommc.x = 10.05;
                     this.ballondoormc.bgbottommc.y = 12.85;
                     this.ballondoormc.tf.x = 15.9;
                     this.ballondoormc.bgmc.x = 14;
                     this.ballondoormc.bgmc.width = Math.floor(this.ballondoormc.tf.width + 3);
                     this.ballondoormc.bgleftmc.x = 9;
                     this.ballondoormc.bgrightmc.x = this.ballondoormc.bgmc.x + this.ballondoormc.bgmc.width;
               }
            }
            else
            {
               this.ballondoormc.bgbottommc.rotation = 0;
               this.ballondoormc.bgbottommc.y = 25.8;
               this.ballondoormc.tf.x = 6.9;
               this.ballondoormc.bgleftmc.x = 0;
               this.ballondoormc.defX = int((ExteriorConfig.doorW - this.ballondoormc.width) / 2) + ExteriorConfig.doorX;
               this.ballondoormc.defY = ExteriorConfig.doorY - 36;
            }
            if(data.home.ballon.(@type == "moviepanel"))
            {
               this.ballonfootprintmc.defX = data.home.ballon.(@type == "moviepanel").@x - Math.floor(this.ballonfootprintmc.width / 2);
               this.ballonfootprintmc.defY = data.home.ballon.(@type == "moviepanel").@y - Math.floor(this.ballonfootprintmc.height);
            }
         }
         else
         {
            this.ballondoormc.bgbottommc.rotation = 0;
            this.ballondoormc.bgbottommc.y = 25.8;
            this.ballondoormc.tf.x = 6.9;
            this.ballondoormc.bgleftmc.x = 0;
            this.ballondoormc.defX = int((ExteriorConfig.doorW - this.ballondoormc.width) / 2) + ExteriorConfig.doorX;
            this.ballondoormc.defY = ExteriorConfig.doorY - 36;
         }
         this.ballonfootprintmc.x = this.ballonfootprintmc.defX;
         this.ballonfootprintmc.y = this.ballonfootprintmc.defY;
         this.ballondoormc.x = this.ballondoormc.defX;
         this.ballondoormc.y = this.ballondoormc.defY;
         setChildIndex(this.ballonfootprintmc,numChildren - 1);
         setChildIndex(this.ballondoormc,numChildren - 1);
      }
      
      private function exterirorIOErrorHandler(event:IOErrorEvent) : void
      {
         trace(event);
         this._exteriorLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.exterirorProgressHandler);
         this._exteriorLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.exterirorCompleteHandler);
         this._exteriorLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.exterirorIOErrorHandler);
         dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
      }
      
      public function loadPokemon() : void
      {
         var pokemon:* = undefined;
         var data:* = undefined;
         var i:* = undefined;
         var poke_one:* = undefined;
         var poke_data:* = undefined;
         var rect:Rectangle = null;
         var emo_data:* = undefined;
         if(PDWHomeData.currentHomeType == PDWHomeData.HOME_CAMPAIGN)
         {
            data = campaignData.data;
            this._pokemonSet = new Array();
            this._emotionSet = new Array();
            this._emotionWordSet = new Array();
            for(i = 0; i < data.home.poke.length(); i++)
            {
               poke_one = data.home.poke[i];
               poke_data = new pokemonLoader2(parseInt(poke_one.@x,10),parseInt(poke_one.@y,10),parseInt(poke_one.@width,10),parseInt(poke_one.@height,10));
               poke_data.loadSwf(poke_one.@pokeid,poke_one.@form);
               poke_data.addEventListener(Event.COMPLETE,this.pokemonLoadCompleteHandler);
               poke_data.num = i;
               this._pokemonSet.push(poke_data);
               addChild(poke_data.renderPokemon.display);
               rect = poke_data.renderPokemon.display.getBounds(this);
               switch(parseInt(poke_one.@icon,10))
               {
                  case 1:
                     emo_data = new AssetEmotion0();
                     break;
                  case 2:
                     emo_data = new AssetEmotion2();
                     break;
                  case 3:
                     emo_data = new AssetEmotion3();
                     break;
                  case 4:
                     emo_data = new AssetEmotion4();
               }
               this._emotionSet.push(emo_data);
               this._emotionWordSet.push(poke_one.@comment);
            }
         }
         else if(Boolean(PDWHomeData.myPokemonNo) && PDWHomeData.myPokemonNo != 0)
         {
            pokemon = PokemonBridge.createRenderer();
            if(pokemon)
            {
               pokemon.addEventListener(Event.COMPLETE,this.loadCompleteHandler);
               pokemon.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
               try
               {
                  pokemon.load(PDWHomeData.myPokemonNo,PDWHomeData.myPokemonFormNo,0.55);
                  pokemon.display.buttonMode = true;
                  pokemon.display.addEventListener(MouseEvent.MOUSE_OVER,this.mouseOverHandler);
                  pokemon.display.addEventListener(MouseEvent.CLICK,this.clickHandler);
                  addChild(pokemon.display);
               }
               catch(error:Error)
               {
               }
               try
               {
                  pokemon.animator.play();
               }
               catch(error:Error)
               {
               }
               this._pokemon = pokemon;
            }
            this._status = new AssetPokemonStatus();
         }
         setChildIndex(this.mistmc,this.numChildren - 1);
      }
      
      private function loadCompleteHandler(event:Event) : void
      {
         this._pokemon.display.x = 501;
         this._pokemon.display.y = 381;
         var rect:Rectangle = this._pokemon.display.getBounds(this);
         this._emotion.defX = int(rect.x + rect.width / 2 - this._emotion.width / 2);
         this._emotion.defY = int(rect.y - this._emotion.height);
         this._pokemon.removeEventListener(Event.COMPLETE,this.loadCompleteHandler);
         this._pokemon.removeEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         this._pokemon.display.tabEnabled = false;
         this._pokemon.display.tabChildren = false;
      }
      
      private function pokemonLoadCompleteHandler(e:Event) : void
      {
         var emo_data:* = undefined;
         var pokemon:* = e.currentTarget;
         pokemon.renderPokemon.display.buttonMode = true;
         pokemon.renderPokemon.display.tabEnabled = false;
         pokemon.renderPokemon.display.tabChildren = false;
         pokemon.addEventListener(MouseEvent.MOUSE_OVER,this.pokemonMouseOverHandler);
         pokemon.addEventListener(MouseEvent.CLICK,this.pokemonClickHandler);
         pokemon.addEventListener(MouseEvent.MOUSE_OUT,this.pokemonMouseOutHandler);
         pokemon.renderPokemon.animator.play();
         var num:* = pokemon.num;
         emo_data = this._emotionSet[num];
         var rect:Rectangle = this._pokemonSet[num].renderPokemon.display.getBounds(this);
         emo_data.defX = int(rect.x + rect.width / 2 - emo_data.width / 2);
         emo_data.defY = int(rect.y - emo_data.height);
      }
      
      private function ioErrorHandler(event:IOErrorEvent) : void
      {
         this._pokemon.removeEventListener(Event.COMPLETE,this.loadCompleteHandler);
         this._pokemon.removeEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
      }
      
      public function showTitle() : void
      {
         var i:String = null;
         var tfm:TextFormat = null;
         var tf:TextField = null;
         var t:String = null;
         var f:Font = null;
         var mc:DisplayObject = null;
         setChildIndex(this.titlemc,this.numChildren - 1);
         this.titlemc.alpha = 0;
         Tweener.addTween(this.titlemc,{
            "time":0.5,
            "alpha":1,
            "transition":"easeNone"
         });
         Tweener.addTween(this.titlemc,{
            "delay":3,
            "time":0.5,
            "alpha":0,
            "transition":"easeNone"
         });
         var hasFont:Boolean = false;
         for(i in Font.enumerateFonts())
         {
            f = Font.enumerateFonts()[i];
            if(f.fontName == "PokemonFontShingoM")
            {
               hasFont = true;
            }
         }
         tfm = new TextFormat();
         tfm.align = TextFormatAlign.LEFT;
         tfm.font = "PokemonFontShingoM";
         tfm.color = 16777215;
         tfm.size = 18;
         tfm.letterSpacing = 0;
         tf = new TextField();
         tf.defaultTextFormat = tfm;
         tf.antiAliasType = "advanced";
         tf.gridFitType = "subpixel";
         tf.sharpness = -200;
         tf.thickness = 200;
         tf.embedFonts = hasFont;
         tf.autoSize = TextFieldAutoSize.LEFT;
         tf.selectable = false;
         tf.mouseEnabled = false;
         tf.y = 0;
         t = FontManager.getIdText("h_ca_1");
         if(PDWHomeData.isCampaign)
         {
            t = PDWHomeData.campaignName + t.split("[PGLニックネーム]")[1];
         }
         else if(PDWHomeData.isMyHome)
         {
            t = t.replace(/\[PGLニックネーム\]/ig,PDWHomeData.myPGLName);
         }
         else
         {
            t = t.replace(/\[PGLニックネーム\]/ig,PDWHomeData.anotherPGLName);
         }
         tf.text = t;
         FontManager.setTextM(tf);
         for(var j:Number = this.titlemc.numChildren - 1; j >= 0; j--)
         {
            mc = this.titlemc.getChildAt(j);
            Tweener.removeTweens(mc);
            this.titlemc.removeChild(mc);
         }
         this.titlemc.addChild(tf);
         tf.y = 0;
         this._tf = tf;
         this.titlemc.x = int((1003 - this.titlemc.width) / 2);
      }
      
      private function showBallonDoorHandler(event:Event) : void
      {
         Tracer.add("showBallonDoorHandler");
         this.ballondoormc.visible = true;
         Tweener.removeTweens(this.ballondoormc);
         Tweener.addTween(this.ballondoormc,{
            "delay":0,
            "time":0.1,
            "y":this.ballondoormc.defY - 16,
            "transition":"easeOutQuad"
         });
         Tweener.addTween(this.ballondoormc,{
            "delay":0.1,
            "time":0.2,
            "y":this.ballondoormc.defY,
            "transition":"easeInQuad"
         });
      }
      
      private function showBallonFootprintHandler(event:Event) : void
      {
         Tracer.add("showBallonFootprintHandler");
         this.ballonfootprintmc.visible = true;
         Tweener.removeTweens(this.ballonfootprintmc);
         Tweener.addTween(this.ballonfootprintmc,{
            "delay":0,
            "time":0.1,
            "y":this.ballonfootprintmc.defY - 16,
            "transition":"easeOutQuad"
         });
         Tweener.addTween(this.ballonfootprintmc,{
            "delay":0.1,
            "time":0.2,
            "y":this.ballonfootprintmc.defY,
            "transition":"easeInQuad"
         });
      }
      
      private function showBallonPanelHandler(event:Event) : void
      {
         this.ballonfootprintmc.visible = true;
         Tweener.removeTweens(this.ballonfootprintmc);
         Tweener.addTween(this.ballonfootprintmc,{
            "delay":0,
            "time":0.1,
            "y":this.ballonfootprintmc.defY - 16,
            "transition":"easeOutQuad"
         });
         Tweener.addTween(this.ballonfootprintmc,{
            "delay":0.1,
            "time":0.2,
            "y":this.ballonfootprintmc.defY,
            "transition":"easeInQuad"
         });
      }
      
      private function hideBallonDoorHandler(event:Event) : void
      {
         Tracer.add("hideBallonDoorHandler");
         this.ballondoormc.visible = false;
      }
      
      private function hideBallonFootprintHandler(event:Event) : void
      {
         Tracer.add("hideBallonFootprintHandler");
         this.ballonfootprintmc.visible = false;
      }
      
      private function hideBallonPanelHandler(event:Event) : void
      {
         this.ballonfootprintmc.visible = false;
      }
      
      private function mouseOverHandler(event:MouseEvent) : void
      {
         addChild(this._emotion);
      }
      
      private function clickHandler(event:MouseEvent) : void
      {
         addChild(this._status);
         this._status.addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler1);
         this._status.visit(new Point(580,160),new Rectangle(0,0,406,238));
      }
      
      private function pokemonMouseOverHandler(event:MouseEvent) : void
      {
         var emo_data:* = this._emotionSet[event.currentTarget.num];
         addChild(emo_data);
      }
      
      private function pokemonMouseOutHandler(event:MouseEvent) : void
      {
      }
      
      private function pokemonClickHandler(event:MouseEvent) : void
      {
         PDWBridge.showMessageWindow(FontManager.getIdText(this._emotionWordSet[event.currentTarget.num]));
      }
      
      private function removedFromStageHandler1(event:Event) : void
      {
         this._status.removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler1);
         PDWBridge.showMoveArrows();
      }
   }
}

