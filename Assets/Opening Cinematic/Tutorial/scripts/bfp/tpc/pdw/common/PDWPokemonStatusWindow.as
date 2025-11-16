package bfp.tpc.pdw.common
{
   import bfp.IPDWPokemonStatus;
   import bfp.PDWBridge;
   import bfp.common.FontManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.Font;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import jp.feb19.utils.ColorUtilities;
   
   public class PDWPokemonStatusWindow extends Sprite implements IPDWPokemonStatus
   {
       
      
      public var closemc:MovieClip;
      
      public var label0:TextField;
      
      public var label1:TextField;
      
      public var label2:TextField;
      
      public var label3:TextField;
      
      public var tf0:TextField;
      
      public var label4:TextField;
      
      public var tf1:TextField;
      
      public var label5:TextField;
      
      public var tf2:TextField;
      
      public var label6:TextField;
      
      public var tf3:TextField;
      
      public var label7:TextField;
      
      public var tf4:TextField;
      
      public var label8:TextField;
      
      public var tf5:TextField;
      
      public var tf6:TextField;
      
      public var tf7:TextField;
      
      public var tf8:TextField;
      
      private var _nickname:String;
      
      private var _pglNickname:String;
      
      private var _pokemonName:String;
      
      private var _parentName:String;
      
      private var _level:int;
      
      private var _type:String;
      
      private var _gender:int;
      
      private var _personality:String;
      
      private var _monsterball:String;
      
      private var _hasFont:Boolean;
      
      private var _tfm:TextFormat;
      
      public function PDWPokemonStatusWindow()
      {
         var _loc2_:String = null;
         var _loc3_:TextFormat = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:Font = null;
         super();
         var _loc1_:Boolean = false;
         for(_loc2_ in Font.enumerateFonts())
         {
            if((_loc6_ = Font.enumerateFonts()[_loc2_]).fontName == "PokemonFontShingoM")
            {
               _loc1_ = true;
               break;
            }
         }
         this._hasFont;
         _loc3_ = new TextFormat();
         _loc3_.font = "PokemonFontShingoM";
         _loc3_.size = 12;
         _loc3_.color = 4664077;
         _loc3_.align = TextFormatAlign.LEFT;
         _loc3_.leading = 0;
         this._tfm = _loc3_;
         this.label0.y = 26;
         this.label1.y = 47;
         this.label2.y = 68;
         this.label3.y = 89;
         this.label4.y = 110;
         this.label5.y = 131;
         this.label6.y = 152;
         this.label7.y = 172;
         this.label8.y = 194;
         FontManager.setTextID(this.label0,"h_ee_1");
         _loc4_ = FontManager.getIdText("h_ee_2");
         _loc5_ = FontManager.markupMultilingualText(_loc4_,true);
         FontManager.setTextAndFormatTag(this.label1,_loc5_,"h_ee_2");
         FontManager.setTextID(this.label2,"h_ee_3");
         FontManager.setTextID(this.label3,"h_ee_4");
         FontManager.setTextID(this.label4,"h_ee_5");
         FontManager.setTextID(this.label5,"h_ee_6");
         FontManager.setTextID(this.label6,"h_ee_7");
         FontManager.setTextID(this.label7,"h_ee_8");
         FontManager.setTextID(this.label8,"h_ee_9");
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      private function setText(param1:TextField, param2:String) : void
      {
         param1.width = 130;
         param1.wordWrap = true;
         param1.multiline = true;
         param1.defaultTextFormat = this._tfm;
         param1.antiAliasType = "advanced";
         param1.gridFitType = "subpixel";
         param1.sharpness = -200;
         param1.thickness = 100;
         param1.embedFonts = this._hasFont;
         param1.text = param2;
         FontManager.setTextM(param1);
      }
      
      private function addedToStageHandler(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
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
         this.closemc.buttonMode = true;
         this.closemc.mouseChildren = false;
         this.closemc.addEventListener(MouseEvent.MOUSE_OVER,this.mouseOverHandler);
         this.closemc.addEventListener(MouseEvent.MOUSE_OUT,this.mouseOutHandler);
         this.closemc.addEventListener(MouseEvent.CLICK,this.clickHandler);
         this.tf0.y = 26;
         this.tf1.y = 47;
         this.tf2.y = 68;
         this.tf3.y = 89;
         this.tf4.y = 110;
         this.tf5.y = 131;
         this.tf6.y = 152;
         this.tf7.y = 172;
         this.tf8.y = 211;
         this.setText(this.tf0,this._nickname);
         this.setText(this.tf1,this._pglNickname);
         this.setText(this.tf2,this._pokemonName);
         this.setText(this.tf3,this._parentName);
         this.setText(this.tf4,this._level.toString());
         this.setText(this.tf5,this._type);
         this.setText(this.tf6,this._gender == 0 ? "♂" : (this._gender == 1 ? "♀" : ""));
         this.setText(this.tf7,this._personality);
         this.setText(this.tf8,this._monsterball);
      }
      
      public function release() : void
      {
         this.closemc.removeEventListener(MouseEvent.MOUSE_OVER,this.mouseOverHandler);
         this.closemc.removeEventListener(MouseEvent.MOUSE_OUT,this.mouseOutHandler);
         this.closemc.removeEventListener(MouseEvent.CLICK,this.clickHandler);
      }
      
      public function dispose() : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      private function mouseOverHandler(param1:MouseEvent) : void
      {
         PDWBridge.sfxMouseOver();
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         ColorUtilities.paint(_loc2_,PDWBridge.ROLLOVER_COLOR);
      }
      
      private function mouseOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         ColorUtilities.reset(_loc2_);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         PDWBridge.sfxClick();
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         ColorUtilities.reset(_loc2_);
         dispatchEvent(new Event(Event.CLOSE));
      }
      
      public function get nickname() : String
      {
         return this._nickname;
      }
      
      public function set nickname(param1:String) : void
      {
         this._nickname = param1;
      }
      
      public function get pglNickname() : String
      {
         return this._pglNickname;
      }
      
      public function set pglNickname(param1:String) : void
      {
         this._pglNickname = param1;
      }
      
      public function get pokemonName() : String
      {
         return this._pokemonName;
      }
      
      public function set pokemonName(param1:String) : void
      {
         this._pokemonName = param1;
      }
      
      public function get parentName() : String
      {
         return this._parentName;
      }
      
      public function set parentName(param1:String) : void
      {
         this._parentName = param1;
      }
      
      public function get level() : int
      {
         return this._level;
      }
      
      public function set level(param1:int) : void
      {
         this._level = param1;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function set type(param1:String) : void
      {
         this._type = param1;
      }
      
      public function get gender() : int
      {
         return this._gender;
      }
      
      public function set gender(param1:int) : void
      {
         this._gender = param1;
      }
      
      public function get personality() : String
      {
         return this._personality;
      }
      
      public function set personality(param1:String) : void
      {
         this._personality = param1;
      }
      
      public function get monsterball() : String
      {
         return this._monsterball;
      }
      
      public function set monsterball(param1:String) : void
      {
         this._monsterball = param1;
      }
   }
}
