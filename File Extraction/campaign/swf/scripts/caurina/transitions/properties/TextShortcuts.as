package caurina.transitions.properties
{
   import caurina.transitions.AuxFunctions;
   import caurina.transitions.Tweener;
   import flash.text.TextFormat;
   
   public class TextShortcuts
   {
      
      public function TextShortcuts()
      {
         super();
      }
      
      public static function init() : void
      {
         Tweener.registerSpecialProperty("_text",_text_get,_text_set,null,_text_preProcess);
         Tweener.registerSpecialPropertySplitter("_text_color",_generic_color_splitter,["_text_color_r","_text_color_g","_text_color_b"]);
         Tweener.registerSpecialProperty("_text_color_r",_textFormat_property_get,_textFormat_property_set,["color",true,"r"]);
         Tweener.registerSpecialProperty("_text_color_g",_textFormat_property_get,_textFormat_property_set,["color",true,"g"]);
         Tweener.registerSpecialProperty("_text_color_b",_textFormat_property_get,_textFormat_property_set,["color",true,"b"]);
         Tweener.registerSpecialProperty("_text_indent",_textFormat_property_get,_textFormat_property_set,["indent"]);
         Tweener.registerSpecialProperty("_text_leading",_textFormat_property_get,_textFormat_property_set,["leading"]);
         Tweener.registerSpecialProperty("_text_leftMargin",_textFormat_property_get,_textFormat_property_set,["leftMargin"]);
         Tweener.registerSpecialProperty("_text_letterSpacing",_textFormat_property_get,_textFormat_property_set,["letterSpacing"]);
         Tweener.registerSpecialProperty("_text_rightMargin",_textFormat_property_get,_textFormat_property_set,["rightMargin"]);
         Tweener.registerSpecialProperty("_text_size",_textFormat_property_get,_textFormat_property_set,["size"]);
      }
      
      public static function _text_get(param1:Object, param2:Array, param3:Object = null) : Number
      {
         return -param1.text.length;
      }
      
      public static function _textFormat_property_set(param1:Object, param2:Number, param3:Array, param4:Object = null) : void
      {
         var _loc8_:String = null;
         var _loc5_:TextFormat = param1.getTextFormat();
         var _loc6_:String = param3[0];
         var _loc7_:Boolean = Boolean(param3[1]);
         if(!_loc7_)
         {
            _loc5_[_loc6_] = param2;
         }
         else
         {
            _loc8_ = param3[2];
            if(_loc8_ == "r")
            {
               _loc5_[_loc6_] = _loc5_[_loc6_] & 0xFFFF | param2 << 16;
            }
            if(_loc8_ == "g")
            {
               _loc5_[_loc6_] = _loc5_[_loc6_] & 0xFF00FF | param2 << 8;
            }
            if(_loc8_ == "b")
            {
               _loc5_[_loc6_] = _loc5_[_loc6_] & 0xFFFF00 | param2;
            }
         }
         param1.defaultTextFormat = _loc5_;
         param1.setTextFormat(_loc5_);
      }
      
      public static function _text_set(param1:Object, param2:Number, param3:Array, param4:Object = null) : void
      {
         if(param2 < 0)
         {
            param1.text = param4.oldText.substr(0,-Math.round(param2));
         }
         else
         {
            param1.text = param4.newText.substr(0,Math.round(param2));
         }
      }
      
      public static function _textFormat_property_get(param1:Object, param2:Array, param3:Object = null) : Number
      {
         var _loc7_:String = null;
         var _loc4_:TextFormat = param1.getTextFormat();
         var _loc5_:String = param2[0];
         var _loc6_:Boolean = Boolean(param2[1]);
         if(!_loc6_)
         {
            return _loc4_[_loc5_];
         }
         _loc7_ = param2[2];
         if(_loc7_ == "r")
         {
            return AuxFunctions.numberToR(_loc4_[_loc5_]);
         }
         if(_loc7_ == "g")
         {
            return AuxFunctions.numberToG(_loc4_[_loc5_]);
         }
         if(_loc7_ == "b")
         {
            return AuxFunctions.numberToB(_loc4_[_loc5_]);
         }
         return NaN;
      }
      
      public static function _generic_color_splitter(param1:Number, param2:Array) : Array
      {
         var _loc3_:Array = new Array();
         _loc3_.push({
            "name":param2[0],
            "value":AuxFunctions.numberToR(param1)
         });
         _loc3_.push({
            "name":param2[1],
            "value":AuxFunctions.numberToG(param1)
         });
         _loc3_.push({
            "name":param2[2],
            "value":AuxFunctions.numberToB(param1)
         });
         return _loc3_;
      }
      
      public static function _text_preProcess(param1:Object, param2:Array, param3:Object, param4:Object) : Number
      {
         param4.oldText = param1.text;
         param4.newText = param3;
         return param4.newText.length;
      }
   }
}

