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
   
   public class DialogConfirmGotoProfile extends Alert implements IDialog
   {
       
      
      public var cancelmc:MovieClip;
      
      public var okmc:MovieClip;
      
      public var closemc:MovieClip;
      
      public var tf:TextField;
      
      public function DialogConfirmGotoProfile()
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
         _loc3_.size = 13;
         _loc3_.color = 4333835;
         _loc3_.align = TextFormatAlign.CENTER;
         this.tf.defaultTextFormat = _loc3_;
         this.tf.embedFonts = _loc1_;
         this.tf.antiAliasType = "advanced";
         this.tf.gridFitType = "subpixel";
         this.tf.sharpness = 0;
         this.tf.thickness = 200;
         this.tf.y = 30;
         FontManager.setTextID(this.tf,"Xz_an_1");
         (_loc4_ = new TextFormat()).font = "PokemonFontShingoM";
         _loc4_.size = 12;
         _loc4_.color = 16777215;
         _loc4_.align = TextFormatAlign.CENTER;
         this.okmc.tf.defaultTextFormat = _loc4_;
         this.okmc.tf.embedFonts = _loc1_;
         this.okmc.tf.antiAliasType = "advanced";
         this.okmc.tf.gridFitType = "subpixel";
         this.okmc.tf.sharpness = 0;
         this.okmc.tf.thickness = 200;
         this.okmc.tf.y = 5;
         FontManager.setTextID(this.okmc.tf,"h_cc_2");
         this.cancelmc.tf.defaultTextFormat = _loc4_;
         this.cancelmc.tf.embedFonts = _loc1_;
         this.cancelmc.tf.antiAliasType = "advanced";
         this.cancelmc.tf.gridFitType = "subpixel";
         this.cancelmc.tf.sharpness = 0;
         this.cancelmc.tf.thickness = 200;
         this.cancelmc.tf.y = 5;
         FontManager.setTextID(this.cancelmc.tf,"h_cc_3");
         super.init();
      }
      
      override public function visit() : void
      {
         ButtonUtilities.setBtn(this.cancelmc,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         ButtonUtilities.setBtn(this.okmc,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         ButtonUtilities.setBtn(this.closemc,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
      }
      
      override public function away() : void
      {
         ButtonUtilities.unsetBtn(this.cancelmc,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
         ButtonUtilities.unsetBtn(this.okmc,{
            "over":this.mouseOverHandler,
            "out":this.mouseOutHandler,
            "click":this.clickHandler
         });
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
            case "cancelmc":
            case "okmc":
               ColorUtilities.paint(_loc2_.bgmc,PDWBridge.ROLLOVER_COLOR);
               break;
            case "closemc":
               ColorUtilities.paint(_loc2_,PDWBridge.ROLLOVER_COLOR);
         }
      }
      
      private function mouseOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_.name)
         {
            case "cancelmc":
            case "okmc":
               ColorUtilities.reset(_loc2_.bgmc);
               break;
            case "closemc":
               ColorUtilities.reset(_loc2_);
         }
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         PDWBridge.sfxClick();
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         switch(_loc2_.name)
         {
            case "cancelmc":
               ColorUtilities.reset(_loc2_.bgmc);
               this.away();
               PDWBridge.dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.DIALOG_CLOSE,{"dialog":PDWBridge.DIALOG_TYPE_GO_PROFILE}));
               break;
            case "closemc":
               ColorUtilities.reset(_loc2_);
               this.away();
               PDWBridge.dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.DIALOG_CLOSE,{"dialog":PDWBridge.DIALOG_TYPE_GO_PROFILE}));
               break;
            case "okmc":
               ColorUtilities.reset(_loc2_.bgmc);
               this.away();
               PDWBridge.dispatchEvent(new PDWBridgeEvent(PDWBridgeEvent.DIALOG_OK,{"dialog":PDWBridge.DIALOG_TYPE_GO_PROFILE}));
         }
      }
   }
}
