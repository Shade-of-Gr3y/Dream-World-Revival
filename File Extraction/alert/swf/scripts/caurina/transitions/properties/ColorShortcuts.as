package caurina.transitions.properties
{
   import caurina.transitions.AuxFunctions;
   import caurina.transitions.Tweener;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.ColorTransform;
   
   public class ColorShortcuts
   {
      
      private static var LUMINANCE_R:Number = 0.212671;
      
      private static var LUMINANCE_G:Number = 0.71516;
      
      private static var LUMINANCE_B:Number = 0.072169;
      
      public function ColorShortcuts()
      {
         super();
         trace("This is an static class and should not be instantiated.");
      }
      
      public static function _color_splitter(p_value:*, p_parameters:Array) : Array
      {
         var nArray:Array = new Array();
         if(p_value == null)
         {
            nArray.push({
               "name":"_color_redMultiplier",
               "value":1
            });
            nArray.push({
               "name":"_color_redOffset",
               "value":0
            });
            nArray.push({
               "name":"_color_greenMultiplier",
               "value":1
            });
            nArray.push({
               "name":"_color_greenOffset",
               "value":0
            });
            nArray.push({
               "name":"_color_blueMultiplier",
               "value":1
            });
            nArray.push({
               "name":"_color_blueOffset",
               "value":0
            });
         }
         else
         {
            nArray.push({
               "name":"_color_redMultiplier",
               "value":0
            });
            nArray.push({
               "name":"_color_redOffset",
               "value":AuxFunctions.numberToR(p_value)
            });
            nArray.push({
               "name":"_color_greenMultiplier",
               "value":0
            });
            nArray.push({
               "name":"_color_greenOffset",
               "value":AuxFunctions.numberToG(p_value)
            });
            nArray.push({
               "name":"_color_blueMultiplier",
               "value":0
            });
            nArray.push({
               "name":"_color_blueOffset",
               "value":AuxFunctions.numberToB(p_value)
            });
         }
         return nArray;
      }
      
      public static function _contrast_set(p_obj:Object, p_value:Number, p_parameters:Array, p_extra:Object = null) : void
      {
         var mc:Number = NaN;
         var co:Number = NaN;
         mc = p_value + 1;
         co = Math.round(p_value * -128);
         var cfm:ColorTransform = new ColorTransform(mc,mc,mc,1,co,co,co,0);
         p_obj.transform.colorTransform = cfm;
      }
      
      public static function _brightness_get(p_obj:Object, p_parameters:Array, p_extra:Object = null) : Number
      {
         var isTint:Boolean = Boolean(p_parameters[0]);
         var cfm:ColorTransform = p_obj.transform.colorTransform;
         var mc:Number = 1 - (cfm.redMultiplier + cfm.greenMultiplier + cfm.blueMultiplier) / 3;
         var co:Number = (cfm.redOffset + cfm.greenOffset + cfm.blueOffset) / 3;
         if(isTint)
         {
            return co > 0 ? co / 255 : -mc;
         }
         return co / 100;
      }
      
      public static function _saturation_get(p_obj:Object, p_parameters:Array, p_extra:Object = null) : Number
      {
         var mtx:Array = getObjectMatrix(p_obj);
         var isDumb:Boolean = Boolean(p_parameters[0]);
         var rl:Number = isDumb ? 1 / 3 : LUMINANCE_R;
         var gl:Number = isDumb ? 1 / 3 : LUMINANCE_G;
         var bl:Number = isDumb ? 1 / 3 : LUMINANCE_B;
         var mc:Number = ((mtx[0] - rl) / (1 - rl) + (mtx[6] - gl) / (1 - gl) + (mtx[12] - bl) / (1 - bl)) / 3;
         var cc:Number = 1 - (mtx[1] / gl + mtx[2] / bl + mtx[5] / rl + mtx[7] / bl + mtx[10] / rl + mtx[11] / gl) / 6;
         return (mc + cc) / 2;
      }
      
      public static function _oldColor_property_get(p_obj:Object, p_parameters:Array, p_extra:Object = null) : Number
      {
         return p_obj.transform.colorTransform[p_parameters[0]] * 100;
      }
      
      public static function _brightness_set(p_obj:Object, p_value:Number, p_parameters:Array, p_extra:Object = null) : void
      {
         var mc:Number = NaN;
         var co:Number = NaN;
         var isTint:Boolean = Boolean(p_parameters[0]);
         if(isTint)
         {
            mc = 1 - Math.abs(p_value);
            co = p_value > 0 ? Math.round(p_value * 255) : 0;
         }
         else
         {
            mc = 1;
            co = Math.round(p_value * 100);
         }
         var cfm:ColorTransform = new ColorTransform(mc,mc,mc,1,co,co,co,0);
         p_obj.transform.colorTransform = cfm;
      }
      
      public static function _saturation_set(p_obj:Object, p_value:Number, p_parameters:Array, p_extra:Object = null) : void
      {
         var isDumb:Boolean = Boolean(p_parameters[0]);
         var rl:Number = isDumb ? 1 / 3 : LUMINANCE_R;
         var gl:Number = isDumb ? 1 / 3 : LUMINANCE_G;
         var bl:Number = isDumb ? 1 / 3 : LUMINANCE_B;
         var sf:Number = p_value;
         var nf:Number = 1 - sf;
         var nr:Number = rl * nf;
         var ng:Number = gl * nf;
         var nb:Number = bl * nf;
         var mtx:Array = [nr + sf,ng,nb,0,0,nr,ng + sf,nb,0,0,nr,ng,nb + sf,0,0,0,0,0,1,0];
         setObjectMatrix(p_obj,mtx);
      }
      
      private static function getObjectMatrix(p_obj:Object) : Array
      {
         for(var i:Number = 0; i < p_obj.filters.length; i++)
         {
            if(p_obj.filters[i] is ColorMatrixFilter)
            {
               return p_obj.filters[i].matrix.concat();
            }
         }
         return [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0];
      }
      
      public static function getHueDistance(mtx1:Array, mtx2:Array) : Number
      {
         return Math.abs(mtx1[0] - mtx2[0]) + Math.abs(mtx1[1] - mtx2[1]) + Math.abs(mtx1[2] - mtx2[2]);
      }
      
      public static function _hue_set(p_obj:Object, p_value:Number, p_parameters:Array, p_extra:Object = null) : void
      {
         setObjectMatrix(p_obj,getHueMatrix(p_value));
      }
      
      public static function _hue_get(p_obj:Object, p_parameters:Array, p_extra:Object = null) : Number
      {
         var i:Number = NaN;
         var angleToSplit:Number = NaN;
         var mtx:Array = getObjectMatrix(p_obj);
         var hues:Array = [];
         hues[0] = {
            "angle":-179.9,
            "matrix":getHueMatrix(-179.9)
         };
         hues[1] = {
            "angle":180,
            "matrix":getHueMatrix(180)
         };
         for(i = 0; i < hues.length; i++)
         {
            hues[i].distance = getHueDistance(mtx,hues[i].matrix);
         }
         var maxTries:Number = 15;
         for(i = 0; i < maxTries; i++)
         {
            if(hues[0].distance < hues[1].distance)
            {
               angleToSplit = 1;
            }
            else
            {
               angleToSplit = 0;
            }
            hues[angleToSplit].angle = (hues[0].angle + hues[1].angle) / 2;
            hues[angleToSplit].matrix = getHueMatrix(hues[angleToSplit].angle);
            hues[angleToSplit].distance = getHueDistance(mtx,hues[angleToSplit].matrix);
         }
         return hues[angleToSplit].angle;
      }
      
      public static function getHueMatrix(hue:Number) : Array
      {
         var ha:Number = hue * Math.PI / 180;
         var rl:Number = LUMINANCE_R;
         var gl:Number = LUMINANCE_G;
         var bl:Number = LUMINANCE_B;
         var c:Number = Math.cos(ha);
         var s:Number = Math.sin(ha);
         return [rl + c * (1 - rl) + s * -rl,gl + c * -gl + s * -gl,bl + c * -bl + s * (1 - bl),0,0,rl + c * -rl + s * 0.143,gl + c * (1 - gl) + s * 0.14,bl + c * -bl + s * -0.283,0,0,rl + c * -rl + s * -(1 - rl),gl + c * -gl + s * gl,bl + c * (1 - bl) + s * bl,0,0,0,0,0,1,0];
      }
      
      public static function _color_property_get(p_obj:Object, p_parameters:Array, p_extra:Object = null) : Number
      {
         return p_obj.transform.colorTransform[p_parameters[0]];
      }
      
      public static function init() : void
      {
         Tweener.registerSpecialProperty("_color_ra",_oldColor_property_get,_oldColor_property_set,["redMultiplier"]);
         Tweener.registerSpecialProperty("_color_rb",_color_property_get,_color_property_set,["redOffset"]);
         Tweener.registerSpecialProperty("_color_ga",_oldColor_property_get,_oldColor_property_set,["greenMultiplier"]);
         Tweener.registerSpecialProperty("_color_gb",_color_property_get,_color_property_set,["greenOffset"]);
         Tweener.registerSpecialProperty("_color_ba",_oldColor_property_get,_oldColor_property_set,["blueMultiplier"]);
         Tweener.registerSpecialProperty("_color_bb",_color_property_get,_color_property_set,["blueOffset"]);
         Tweener.registerSpecialProperty("_color_aa",_oldColor_property_get,_oldColor_property_set,["alphaMultiplier"]);
         Tweener.registerSpecialProperty("_color_ab",_color_property_get,_color_property_set,["alphaOffset"]);
         Tweener.registerSpecialProperty("_color_redMultiplier",_color_property_get,_color_property_set,["redMultiplier"]);
         Tweener.registerSpecialProperty("_color_redOffset",_color_property_get,_color_property_set,["redOffset"]);
         Tweener.registerSpecialProperty("_color_greenMultiplier",_color_property_get,_color_property_set,["greenMultiplier"]);
         Tweener.registerSpecialProperty("_color_greenOffset",_color_property_get,_color_property_set,["greenOffset"]);
         Tweener.registerSpecialProperty("_color_blueMultiplier",_color_property_get,_color_property_set,["blueMultiplier"]);
         Tweener.registerSpecialProperty("_color_blueOffset",_color_property_get,_color_property_set,["blueOffset"]);
         Tweener.registerSpecialProperty("_color_alphaMultiplier",_color_property_get,_color_property_set,["alphaMultiplier"]);
         Tweener.registerSpecialProperty("_color_alphaOffset",_color_property_get,_color_property_set,["alphaOffset"]);
         Tweener.registerSpecialPropertySplitter("_color",_color_splitter);
         Tweener.registerSpecialPropertySplitter("_colorTransform",_colorTransform_splitter);
         Tweener.registerSpecialProperty("_brightness",_brightness_get,_brightness_set,[false]);
         Tweener.registerSpecialProperty("_tintBrightness",_brightness_get,_brightness_set,[true]);
         Tweener.registerSpecialProperty("_contrast",_contrast_get,_contrast_set);
         Tweener.registerSpecialProperty("_hue",_hue_get,_hue_set);
         Tweener.registerSpecialProperty("_saturation",_saturation_get,_saturation_set,[false]);
         Tweener.registerSpecialProperty("_dumbSaturation",_saturation_get,_saturation_set,[true]);
      }
      
      private static function setObjectMatrix(p_obj:Object, p_matrix:Array) : void
      {
         var cmtx:ColorMatrixFilter = null;
         var objFilters:Array = p_obj.filters.concat();
         var found:Boolean = false;
         for(var i:Number = 0; i < objFilters.length; i++)
         {
            if(objFilters[i] is ColorMatrixFilter)
            {
               objFilters[i].matrix = p_matrix.concat();
               found = true;
            }
         }
         if(!found)
         {
            cmtx = new ColorMatrixFilter(p_matrix);
            objFilters[objFilters.length] = cmtx;
         }
         p_obj.filters = objFilters;
      }
      
      public static function _color_property_set(p_obj:Object, p_value:Number, p_parameters:Array, p_extra:Object = null) : void
      {
         var cfm:ColorTransform = p_obj.transform.colorTransform;
         cfm[p_parameters[0]] = p_value;
         p_obj.transform.colorTransform = cfm;
      }
      
      public static function _oldColor_property_set(p_obj:Object, p_value:Number, p_parameters:Array, p_extra:Object = null) : void
      {
         var tf:ColorTransform = p_obj.transform.colorTransform;
         tf[p_parameters[0]] = p_value / 100;
         p_obj.transform.colorTransform = tf;
      }
      
      public static function _contrast_get(p_obj:Object, p_parameters:Array, p_extra:Object = null) : Number
      {
         var mc:Number = NaN;
         var co:Number = NaN;
         var cfm:ColorTransform = p_obj.transform.colorTransform;
         mc = (cfm.redMultiplier + cfm.greenMultiplier + cfm.blueMultiplier) / 3 - 1;
         co = (cfm.redOffset + cfm.greenOffset + cfm.blueOffset) / 3 / -128;
         return (mc + co) / 2;
      }
      
      public static function _colorTransform_splitter(p_value:Object, p_parameters:Array) : Array
      {
         var nArray:Array = new Array();
         if(p_value == null)
         {
            nArray.push({
               "name":"_color_redMultiplier",
               "value":1
            });
            nArray.push({
               "name":"_color_redOffset",
               "value":0
            });
            nArray.push({
               "name":"_color_greenMultiplier",
               "value":1
            });
            nArray.push({
               "name":"_color_greenOffset",
               "value":0
            });
            nArray.push({
               "name":"_color_blueMultiplier",
               "value":1
            });
            nArray.push({
               "name":"_color_blueOffset",
               "value":0
            });
         }
         else
         {
            nArray.push({
               "name":"_color_redMultiplier",
               "value":p_value.redMultiplier
            });
            nArray.push({
               "name":"_color_redOffset",
               "value":p_value.redOffset
            });
            nArray.push({
               "name":"_color_blueMultiplier",
               "value":p_value.blueMultiplier
            });
            nArray.push({
               "name":"_color_blueOffset",
               "value":p_value.blueOffset
            });
            nArray.push({
               "name":"_color_greenMultiplier",
               "value":p_value.greenMultiplier
            });
            nArray.push({
               "name":"_color_greenOffset",
               "value":p_value.greenOffset
            });
            nArray.push({
               "name":"_color_alphaMultiplier",
               "value":p_value.alphaMultiplier
            });
            nArray.push({
               "name":"_color_alphaOffset",
               "value":p_value.alphaOffset
            });
         }
         return nArray;
      }
   }
}

