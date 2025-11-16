package bfp.tpc.pdw.dialog
{
   import bfp.PDWBridge;
   import bfp.PDWBridgeEvent;
   import bfp.common.FontManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.Font;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import jp.feb19.utils.ButtonUtilities;
   import jp.feb19.utils.ColorUtilities;
   
   public class DialogNoCampaign extends Alert implements IDialog
   {
       
      
      public var closemc:MovieClip;
      
      public var title_tf:TextField;
      
      public function DialogNoCampaign()
      {
         super();
         PDWBridge.sfx(PDWBridge.SFX_ID_ALERT);
      }
      
      override public function init() : void
      {
         var _loc2_:String = null;
         var _loc3_:TextFormat = null;
         var _loc4_:TextFormat = null;
         var _loc5_:Font = null;
         var _loc1_:Boolean = false;
         for(_loc2_ in Font.enumerateFonts())
         {
            if((_loc5_ = Font.enumerateFonts()[_loc2_]).fontName == "PokemonFontShingoM")
            {
               _loc1_ = true;
            }
         }
         _loc3_ = new TextFormat();
         _loc3_.font = "PokemonFontShingoM";
         _loc3_.size = 12;
         _loc3_.color = 4333835;
         _loc3_.align = TextFormatAlign.CENTER;
         this.title_tf.defaultTextFormat = _loc3_;
         this.title_tf.embedFonts = _loc1_;
         this.title_tf.antiAliasType = "advanced";
         this.title_tf.gridFitType = "subpixel";
         this.title_tf.sharpness = 0;
         this.title_tf.thickness = 200;
         this.title_tf.y = 33;
         FontManager.setTextID(this.title_tf,"h_ca_13");
         (_loc4_ = new TextFormat()).font = "PokemonFontShingoM";
         _loc4_.size = 12;
         _loc4_.color = 16777215;
         _loc4_.align = TextFormatAlign.CENTER;
         this.closemc.tf.defaultTextFormat = _loc4_;
         this.closemc.tf.embedFonts = _loc1_;
         this.closemc.tf.antiAliasType = "advanced";
         this.closemc.tf.gridFitType = "subpixel";
         this.closemc.tf.sharpness = 0;
         this.closemc.tf.thickness = 200;
         this.closemc.tf.y = 5;
         FontManager.setTextID(this.closemc.tf,"dialog_35");
         super.init();
      }
      
      override public function visit() : void
      {
         ButtonUtilities.setBtn(this.closemc,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
      }
      
      override public function away() : void
      {
         ButtonUtilities.unsetBtn(this.closemc,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         super.away();
      }
      
      private function mouseOverHandler(param1:MouseEvent) : void
      {
         PDWBridge.sfxMouseOver();
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_.name)
         {
            case "closemc":
               ColorUtilities.paint(_loc2_.bgmc,PDWBridge.ROLLOVER_COLOR);
         }
      }
      
      private function mouseOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_.name)
         {
            case "closemc":
               ColorUtilities.reset(_loc2_.bgmc);
         }
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         PDWBridge.sfxClick();
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_.name)
         {
            case "closemc":
               ColorUtilities.reset(_loc2_.bgmc);
               this.away();
               PDWBridge.dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.DIALOG_CLOSE,{"dialog":PDWBridge.DIALOG_ERROR_REMOVE_CAPTURE}));
         }
      }
   }
}
