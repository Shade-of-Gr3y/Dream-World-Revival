package caurina.transitions.properties
{
   import caurina.transitions.Tweener;
   import flash.geom.Rectangle;
   
   public class DisplayShortcuts
   {
      
      public function DisplayShortcuts()
      {
         super();
      }
      
      public static function init() : void
      {
         Tweener.registerSpecialProperty("_frame",_frame_get,_frame_set);
         Tweener.registerSpecialProperty("_autoAlpha",_autoAlpha_get,_autoAlpha_set);
         Tweener.registerSpecialPropertySplitter("_scale",_scale_splitter);
         Tweener.registerSpecialPropertySplitter("_scrollRect",_scrollRect_splitter);
         Tweener.registerSpecialProperty("_scrollRect_x",_scrollRect_property_get,_scrollRect_property_set,["x"]);
         Tweener.registerSpecialProperty("_scrollRect_y",_scrollRect_property_get,_scrollRect_property_set,["y"]);
         Tweener.registerSpecialProperty("_scrollRect_left",_scrollRect_property_get,_scrollRect_property_set,["left"]);
         Tweener.registerSpecialProperty("_scrollRect_right",_scrollRect_property_get,_scrollRect_property_set,["right"]);
         Tweener.registerSpecialProperty("_scrollRect_top",_scrollRect_property_get,_scrollRect_property_set,["top"]);
         Tweener.registerSpecialProperty("_scrollRect_bottom",_scrollRect_property_get,_scrollRect_property_set,["bottom"]);
         Tweener.registerSpecialProperty("_scrollRect_width",_scrollRect_property_get,_scrollRect_property_set,["width"]);
         Tweener.registerSpecialProperty("_scrollRect_height",_scrollRect_property_get,_scrollRect_property_set,["height"]);
      }
      
      public static function _frame_set(param1:Object, param2:Number, param3:Array, param4:Object = null) : void
      {
         param1.gotoAndStop(Math.round(param2));
      }
      
      public static function _autoAlpha_set(param1:Object, param2:Number, param3:Array, param4:Object = null) : void
      {
         param1.alpha = param2;
         param1.visible = param2 > 0;
      }
      
      public static function _frame_get(param1:Object, param2:Array, param3:Object = null) : Number
      {
         return param1.currentFrame;
      }
      
      public static function _scrollRect_splitter(param1:Rectangle, param2:Array, param3:Object = null) : Array
      {
         var _loc4_:Array = new Array();
         if(param1 == null)
         {
            _loc4_.push({
               "name":"_scrollRect_x",
               "value":0
            });
            _loc4_.push({
               "name":"_scrollRect_y",
               "value":0
            });
            _loc4_.push({
               "name":"_scrollRect_width",
               "value":100
            });
            _loc4_.push({
               "name":"_scrollRect_height",
               "value":100
            });
         }
         else
         {
            _loc4_.push({
               "name":"_scrollRect_x",
               "value":param1.x
            });
            _loc4_.push({
               "name":"_scrollRect_y",
               "value":param1.y
            });
            _loc4_.push({
               "name":"_scrollRect_width",
               "value":param1.width
            });
            _loc4_.push({
               "name":"_scrollRect_height",
               "value":param1.height
            });
         }
         return _loc4_;
      }
      
      public static function _autoAlpha_get(param1:Object, param2:Array, param3:Object = null) : Number
      {
         return param1.alpha;
      }
      
      public static function _scrollRect_property_get(param1:Object, param2:Array, param3:Object = null) : Number
      {
         return param1.scrollRect[param2[0]];
      }
      
      public static function _scale_splitter(param1:Number, param2:Array) : Array
      {
         var _loc3_:Array = new Array();
         _loc3_.push({
            "name":"scaleX",
            "value":param1
         });
         _loc3_.push({
            "name":"scaleY",
            "value":param1
         });
         return _loc3_;
      }
      
      public static function _scrollRect_property_set(param1:Object, param2:Number, param3:Array, param4:Object = null) : void
      {
         var _loc5_:Rectangle = param1.scrollRect;
         _loc5_[param3[0]] = Math.round(param2);
         param1.scrollRect = _loc5_;
      }
   }
}

