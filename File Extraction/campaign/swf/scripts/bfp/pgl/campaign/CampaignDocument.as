package bfp.pgl.campaign
{
   import bfp.common.FontManager;
   import bfp.common.Logger;
   import bfp.common.PokemonBridge;
   import bfp.common.VersionManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.StageAlign;
   import flash.display.StageDisplayState;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   
   public class CampaignDocument extends Sprite
   {
      
      private var formatXML:String = "campaign_format.xml";
      
      private var copyXML:String = "campaign_strings.xml";
      
      private var copyXML1:String = "at_01_campaign_strings.xml";
      
      private var formatXML1:String = "at_01_campaign_format.xml";
      
      private var _main:CampaignScene;
      
      public var main:MovieClip;
      
      public function CampaignDocument()
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
      
      public function open(param1:Event = null) : void
      {
         Logger.log("// ************************************************************************");
         Logger.log("// CAMPAIGN の はじまり");
         Logger.log("// ************************************************************************");
         switch(PokemonBridge.lang)
         {
            case "ja":
               ExternalInterface.call("setCampaignAlert","受け取りが完了していませんがよろしいですか？受け取りを完了させるには、最後の画面で[OK]をクリックしてください。");
               break;
            case "en":
               ExternalInterface.call("setCampaignAlert","You have not yet finished receiving the promotion. To complete receiving this promotion, go back and click the button on the final screen.");
               break;
            case "fr":
               ExternalInterface.call("setCampaignAlert","Attention, vous n\'avez pas encore reçu le contenu de cette offre. Pour recevoir le contenu de cette offre, cliquez sur le bouton qui apparaît sur le dernier écran.");
               break;
            case "it":
               ExternalInterface.call("setCampaignAlert","Attenzione: non hai ancora ricevuto il regalo dell\'iniziativa. Per riceverlo, clicca sul pulsante che compare nell\'ultima schermata.");
               break;
            case "de":
               ExternalInterface.call("setCampaignAlert","Der Empfang des Aktionsinhaltes wurde unterbrochen. Geht das in Ordnung? Klicke auf die entsprechende Schaltfläche des Schlussbildschirms, um den Empfang des Aktionsinhaltes abzuschließen.");
               break;
            case "es":
               ExternalInterface.call("setCampaignAlert","Aún no has recibido el contenido de esta promoción. Si quieres recibir este contenido, haz clic en el botón que aparece en la última pantalla.");
               break;
            case "ko":
               ExternalInterface.call("setCampaignAlert","선물 받기가 제대로 완료되지 않은 상태에서 끝내겠습니까?선물 받기를 완료하려면 마지막에서 [OK]를 클릭해 주십시오.");
         }
         this.visible = true;
         this._main = new CampaignScene(this.main);
         this._main.open();
      }
      
      private function loadedCopyXML2Handler(param1:Event = null) : void
      {
         PokemonBridge.ClearConnect();
         FontManager.removeEventListener(Event.COMPLETE,this.loadedCopyXML2Handler);
         if(this.stage)
         {
            this.open();
         }
         else
         {
            this.addEventListener(Event.ADDED_TO_STAGE,this.open);
         }
      }
      
      private function loadedCopyXML1Handler(param1:Event = null) : void
      {
         FontManager.removeEventListener(Event.COMPLETE,this.loadedCopyXML1Handler);
         FontManager.addEventListener(Event.COMPLETE,this.loadedCopyXML2Handler);
         FontManager.loadStringsXml([this.copyXML1,this.formatXML1],"campaign_file2");
      }
      
      public function init() : void
      {
         this.copyXML = PokemonBridge.PATH + "../../../campaign/assets/" + PokemonBridge.lang + "/xml/" + this.copyXML;
         this.formatXML = PokemonBridge.PATH + "../../../campaign/assets/" + PokemonBridge.lang + "/xml/" + this.formatXML;
         this.copyXML1 = PokemonBridge.PATH + "../../../campaign/assets/" + PokemonBridge.lang + "/xml/" + this.copyXML1;
         this.formatXML1 = PokemonBridge.PATH + "../../../campaign/assets/" + PokemonBridge.lang + "/xml/" + this.formatXML1;
         if(PokemonBridge.version != "standalone")
         {
            this.copyXML += "?appver=" + PokemonBridge.version;
            this.copyXML += "&ver=" + VersionManager.xml.pgl.campaign.strings[PokemonBridge.lang].toString();
            this.copyXML1 += "?appver=" + PokemonBridge.version;
            this.copyXML1 += "&ver=" + VersionManager.xml.pgl.campaign.at_01_strings[PokemonBridge.lang].toString();
            this.formatXML += "?appver=" + PokemonBridge.version;
            this.formatXML += "&ver=" + VersionManager.xml.pgl.campaign.format[PokemonBridge.lang].toString();
            this.formatXML1 += "?appver=" + PokemonBridge.version;
            this.formatXML1 += "&ver=" + VersionManager.xml.pgl.campaign.at_01_format[PokemonBridge.lang].toString();
         }
         PokemonBridge.DataConnect();
         FontManager.addEventListener(Event.COMPLETE,this.loadedCopyXML1Handler);
         FontManager.loadStringsXml([this.copyXML,this.formatXML],"campaign_file1");
      }
   }
}

