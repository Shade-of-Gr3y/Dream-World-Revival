package bfp.main.alert
{
   import bfp.common.FontManager;
   import bfp.common.PokemonBridge;
   import bfp.common.VersionManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.StageAlign;
   import flash.display.StageDisplayState;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   
   public class AlertDocument extends Sprite
   {
      
      private var formatXML:String = "alert_format.xml";
      
      private var copyXML:String = "alert_strings.xml";
      
      public var main:MovieClip;
      
      private var _main:AlertScene;
      
      public function AlertDocument()
      {
         super();
         this.visible = false;
         this.tabEnabled = false;
         this.tabChildren = false;
         if(this.stage)
         {
            this.stage.align = StageAlign.TOP_LEFT;
            this.stage.displayState = StageDisplayState.NORMAL;
            this.stage.scaleMode = StageScaleMode.NO_SCALE;
         }
         else
         {
            this.init();
         }
      }
      
      public function open(e:Event = null) : void
      {
         this.visible = true;
         this._main = new AlertScene(this.main);
         this._main.open();
      }
      
      public function clear(e:Event = null) : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.open);
         this.removeEventListener(Event.REMOVED_FROM_STAGE,this.clear);
         this._main.clear();
         this._main = null;
      }
      
      private function loadedCopyXMLHandler(e:Event = null) : void
      {
         PokemonBridge.ClearConnect();
         FontManager.removeEventListener(Event.COMPLETE,this.loadedCopyXMLHandler);
         if(this.stage)
         {
            this.open();
         }
         else
         {
            this.addEventListener(Event.ADDED_TO_STAGE,this.open);
         }
      }
      
      public function init() : void
      {
         this.copyXML = PokemonBridge.PATH + "../../../pdw/assets/" + PokemonBridge.lang + "/xml/" + this.copyXML;
         this.formatXML = PokemonBridge.PATH + "../../../pdw/assets/" + PokemonBridge.lang + "/xml/" + this.formatXML;
         if(PokemonBridge.version != "standalone")
         {
            this.copyXML += "?appver=" + PokemonBridge.version;
            this.copyXML += "&ver=" + VersionManager.xml.pdw.alert.strings[PokemonBridge.lang].toString();
            this.formatXML += "?appver=" + PokemonBridge.version;
            this.formatXML += "&ver=" + VersionManager.xml.pdw.alert.format[PokemonBridge.lang].toString();
         }
         PokemonBridge.DataConnect();
         FontManager.addEventListener(Event.COMPLETE,this.loadedCopyXMLHandler);
         FontManager.loadStringsXml([this.copyXML,this.formatXML],"alert_file");
      }
      
      public function close(e:Event = null) : void
      {
      }
   }
}

