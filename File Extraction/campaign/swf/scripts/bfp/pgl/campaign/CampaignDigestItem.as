package bfp.pgl.campaign
{
   import bfp.common.FontManager;
   import bfp.common.ImageParser;
   import bfp.common.Logger;
   import bfp.common.PokemonBridge;
   import bfp.pgl.common.CampaignBridge;
   import caurina.transitions.Tweener;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class CampaignDigestItem extends TopCampaignItem
   {
      
      private var _titleMask:MovieClip;
      
      private var _back:MovieClip;
      
      private var _json:Object;
      
      private var _titleTf:TextField;
      
      private var _dateMask:MovieClip;
      
      private var _cateMask:MovieClip;
      
      private var _category:ImageParser;
      
      private var _dateTf:TextField;
      
      public function CampaignDigestItem(param1:Object, param2:Number)
      {
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:Array = null;
         var _loc12_:Array = null;
         var _loc13_:String = null;
         var _loc14_:String = null;
         var _loc15_:String = null;
         super();
         this._json = param1;
         var _loc3_:String = "";
         var _loc4_:String = this._json.open_date_from;
         if(_loc4_ != null)
         {
            _loc6_ = _loc4_.split(" ");
            _loc7_ = _loc6_[0].split("-");
            _loc8_ = _loc7_[0];
            _loc9_ = _loc7_[1].slice(0,_loc7_[1].length);
            _loc10_ = _loc7_[2].slice(0,_loc7_[2].length);
            if(_loc9_.length == 1)
            {
               _loc9_ = "0" + _loc9_;
            }
            if(_loc10_.length == 1)
            {
               _loc10_ = "0" + _loc10_;
            }
            switch(PokemonBridge.lang)
            {
               case "en":
                  _loc3_ = _loc9_ + "/" + _loc10_ + "/" + _loc8_ + " - ";
                  break;
               case "es":
                  _loc3_ = _loc10_ + "/" + _loc9_ + "/" + _loc8_ + " - ";
                  break;
               case "fr":
                  _loc3_ = _loc10_ + "/" + _loc9_ + "/" + _loc8_ + " - ";
                  break;
               case "it":
                  _loc3_ = _loc10_ + "/" + _loc9_ + "/" + _loc8_ + " - ";
                  break;
               case "de":
                  _loc3_ = _loc10_ + "." + _loc9_ + "." + _loc8_ + " - ";
                  break;
               case "ko":
                  _loc3_ = _loc8_ + "." + _loc9_ + "." + _loc10_ + " - ";
                  break;
               case "ja":
                  _loc3_ = _loc8_ + "." + _loc9_ + "." + _loc10_ + " - ";
            }
         }
         var _loc5_:String = this._json.open_date_to;
         if(_loc5_ != null)
         {
            _loc11_ = _loc5_.split(" ");
            _loc12_ = _loc11_[0].split("-");
            _loc13_ = _loc12_[0];
            _loc14_ = _loc12_[1].slice(0,_loc12_[1].length);
            _loc15_ = _loc12_[2].slice(0,_loc12_[2].length);
            if(_loc14_.length == 1)
            {
               _loc14_ = "0" + _loc14_;
            }
            if(_loc15_.length == 1)
            {
               _loc15_ = "0" + _loc15_;
            }
            switch(PokemonBridge.lang)
            {
               case "en":
                  _loc3_ += _loc14_ + "/" + _loc15_ + "/" + _loc13_;
                  break;
               case "es":
                  _loc3_ += _loc15_ + "/" + _loc14_ + "/" + _loc13_;
                  break;
               case "fr":
                  _loc3_ += _loc15_ + "/" + _loc14_ + "/" + _loc13_;
                  break;
               case "it":
                  _loc3_ += _loc15_ + "/" + _loc14_ + "/" + _loc13_;
                  break;
               case "de":
                  _loc3_ += _loc15_ + "." + _loc14_ + "." + _loc13_;
                  break;
               case "ko":
                  _loc3_ += _loc13_ + "." + _loc14_ + "." + _loc15_;
                  break;
               case "ja":
                  _loc3_ += _loc13_ + "." + _loc14_ + "." + _loc15_;
            }
            Logger.log(_loc3_);
         }
         this._dateTf = this.dateTf;
         this._dateTf.mouseEnabled = false;
         FontManager.setText(this._dateTf,_loc3_);
         FontManager.setFFFCorporateBold(this._dateTf);
         this._category = new ImageParser(this.category);
         if(Number(this._json.is_open) == 1)
         {
            if(0 <= Number(this._json.days_to) && Number(this._json.days_to) <= 5)
            {
               this._category.open(PokemonBridge.PATH + "../../../campaign/assets/" + PokemonBridge.lang + "/img/i004.png",false);
            }
            else
            {
               this._category.open(PokemonBridge.PATH + "../../../campaign/assets/" + PokemonBridge.lang + "/img/i002.png",false);
            }
         }
         else if(Number(this._json.days_from) == 0)
         {
            if(Number(this._json.days_to) == -1)
            {
               this._category.open(PokemonBridge.PATH + "../../../campaign/assets/" + PokemonBridge.lang + "/img/i003.png",false);
            }
            else
            {
               this._category.open(PokemonBridge.PATH + "../../../campaign/assets/" + PokemonBridge.lang + "/img/i001.png",false);
            }
         }
         else
         {
            this._category.open(PokemonBridge.PATH + "../../../campaign/assets/" + PokemonBridge.lang + "/img/i001.png",false);
         }
         this._titleTf = this.titleTf;
         this._titleTf.text = this._json.campaign_name;
         this._titleTf.mouseEnabled = false;
         this._titleTf.autoSize = "left";
         if(this._titleTf.height > 22)
         {
            this._titleTf.y = 11;
         }
         else
         {
            this._titleTf.y = 16;
         }
         this._titleTf.y += 0;
         this._back = this.back;
         if(param2 % 2 == 0)
         {
            this._back.gotoAndStop(1);
         }
         else
         {
            this._back.gotoAndStop(2);
         }
         this._back.buttonMode = true;
         this._back.addEventListener(MouseEvent.ROLL_OVER,this.buttonHandler);
         this._back.addEventListener(MouseEvent.ROLL_OUT,this.buttonHandler);
         this._back.addEventListener(MouseEvent.CLICK,this.buttonHandler);
         this._dateMask = this.dateMask;
         this._cateMask = this.cateMask;
         this._titleMask = this.titleMask;
         Tweener.addTween(this,{
            "_brightness":2.55,
            "time":0,
            "delay":0,
            "transition":"linear"
         });
         Tweener.addTween(this,{
            "_brightness":0,
            "time":0.5,
            "delay":0 + param2 * 0.1,
            "transition":"linear"
         });
      }
      
      public function get json() : Object
      {
         return this._json;
      }
      
      public function clear() : void
      {
         this._back.buttonMode = true;
         this._back.removeEventListener(MouseEvent.ROLL_OVER,this.buttonHandler);
         this._back.removeEventListener(MouseEvent.ROLL_OUT,this.buttonHandler);
         this._back.removeEventListener(MouseEvent.CLICK,this.buttonHandler);
         this._dateTf = null;
         this._category = null;
         this._titleTf = null;
         this._back = null;
         this._dateMask = null;
         this._cateMask = null;
         this._titleMask = null;
         this._json = null;
      }
      
      private function init() : void
      {
      }
      
      private function buttonHandler(param1:MouseEvent = null) : void
      {
         switch(param1.type)
         {
            case MouseEvent.ROLL_OVER:
               PokemonBridge.mouseOverSound();
               Tweener.addTween(this._back,{
                  "alpha":0,
                  "time":0.1,
                  "transition":"linear"
               });
               Tweener.addTween(this._dateTf,{
                  "delay":0,
                  "time":0.1,
                  "transition":"linear",
                  "_text_color_r":255,
                  "_text_color_g":255,
                  "_text_color_b":255
               });
               Tweener.addTween(this._titleTf,{
                  "delay":0,
                  "time":0.1,
                  "transition":"linear",
                  "_text_color_r":255,
                  "_text_color_g":255,
                  "_text_color_b":255
               });
               break;
            case MouseEvent.ROLL_OUT:
               Tweener.addTween(this._back,{
                  "alpha":1,
                  "time":0.25,
                  "transition":"linear"
               });
               Tweener.addTween(this._dateTf,{
                  "delay":0,
                  "time":0.25,
                  "transition":"linear",
                  "_text_color_r":249,
                  "_text_color_g":92,
                  "_text_color_b":24
               });
               Tweener.addTween(this._titleTf,{
                  "delay":0,
                  "time":0.25,
                  "transition":"linear",
                  "_text_color_r":0,
                  "_text_color_g":0,
                  "_text_color_b":0
               });
               break;
            case MouseEvent.CLICK:
               PokemonBridge.tag("pgl.campaign_title." + this.json.campaign_id);
               PokemonBridge.mouseClickSound();
               CampaignBridge.change(CampaignBridge.CAMPAIGN_DETAIL,this.json.campaign_id);
         }
      }
   }
}

