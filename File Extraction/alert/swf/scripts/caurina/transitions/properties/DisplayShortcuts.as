package caurina.transitions.properties
{
   import caurina.transitions.Tweener;
   import flash.geom.Rectangle;
   
   public class DisplayShortcuts
   {
      
      public function DisplayShortcuts()
      {
         super();
         trace("This is an static class and should not be instantiated.");
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
      
      public static function _frame_set(p_obj:Object, p_value:Number, p_parameters:Array, p_extra:Object = null) : void
      {
         p_obj.gotoAndStop(Math.round(p_value));
      }
      
      public static function _autoAlpha_set(p_obj:Object, p_value:Number, p_parameters:Array, p_extra:Object = null) : void
      {
         p_obj.alpha = p_value;
         p_obj.visible = p_value > 0;
      }
      
      public static function _frame_get(p_obj:Object, p_parameters:Array, p_extra:Object = null) : Number
      {
         return p_obj.currentFrame;
      }
      
      public static function _scrollRect_splitter(p_value:Rectangle, p_parameters:Array, p_extra:Object = null) : Array
      {
         var nArray:Array = new Array();
         if(p_value == null)
         {
            nArray.push({
               "name":"_scrollRect_x",
               "value":0
            });
            nArray.push({
               "name":"_scrollRect_y",
               "value":0
            });
            nArray.push({
               "name":"_scrollRect_width",
               "value":100
            });
            nArray.push({
               "name":"_scrollRect_height",
               "value":100
            });
         }
         else
         {
            nArray.push({
               "name":"_scrollRect_x",
               "value":p_value.x
            });
            nArray.push({
               "name":"_scrollRect_y",
               "value":p_value.y
            });
            nArray.push({
               "name":"_scrollRect_width",
               "value":p_value.width
            });
            nArray.push({
               "name":"_scrollRect_height",
               "value":p_value.height
            });
         }
         return nArray;
      }
      
      public static function _autoAlpha_get(p_obj:Object, p_parameters:Array, p_extra:Object = null) : Number
      {
         return p_obj.alpha;
      }
      
      public static function _scrollRect_property_get(p_obj:Object, p_parameters:Array, p_extra:Object = null) : Number
      {
         return p_obj.scrollRect[p_parameters[0]];
      }
      
      public static function _scale_splitter(p_value:Number, p_parameters:Array) : Array
      {
         var nArray:Array = new Array();
         nArray.push({
            "name":"scaleX",
            "value":p_value
         });
         nArray.push({
            "name":"scaleY",
            "value":p_value
         });
         return nArray;
      }
      
      public static function _scrollRect_property_set(p_obj:Object, p_value:Number, p_parameters:Array, p_extra:Object = null) : void
      {
         var rect:Rectangle = p_obj.scrollRect;
         rect[p_parameters[0]] = Math.round(p_value);
         p_obj.scrollRect = rect;
      }
   }
}

