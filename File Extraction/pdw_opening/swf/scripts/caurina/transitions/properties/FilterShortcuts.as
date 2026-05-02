package caurina.transitions.properties
{
   import caurina.transitions.AuxFunctions;
   import caurina.transitions.Tweener;
   import flash.display.BitmapData;
   import flash.filters.BevelFilter;
   import flash.filters.BitmapFilter;
   import flash.filters.BlurFilter;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.ConvolutionFilter;
   import flash.filters.DisplacementMapFilter;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.filters.GradientBevelFilter;
   import flash.filters.GradientGlowFilter;
   import flash.geom.Point;
   
   public class FilterShortcuts
   {
      
      public function FilterShortcuts()
      {
         super();
         trace("This is an static class and should not be instantiated.");
      }
      
      public static function init() : void
      {
         Tweener.registerSpecialPropertySplitter("_filter",_filter_splitter);
         Tweener.registerSpecialProperty("_Bevel_angle",_filter_property_get,_filter_property_set,[BevelFilter,"angle"]);
         Tweener.registerSpecialProperty("_Bevel_blurX",_filter_property_get,_filter_property_set,[BevelFilter,"blurX"]);
         Tweener.registerSpecialProperty("_Bevel_blurY",_filter_property_get,_filter_property_set,[BevelFilter,"blurY"]);
         Tweener.registerSpecialProperty("_Bevel_distance",_filter_property_get,_filter_property_set,[BevelFilter,"distance"]);
         Tweener.registerSpecialProperty("_Bevel_highlightAlpha",_filter_property_get,_filter_property_set,[BevelFilter,"highlightAlpha"]);
         Tweener.registerSpecialPropertySplitter("_Bevel_highlightColor",_generic_color_splitter,["_Bevel_highlightColor_r","_Bevel_highlightColor_g","_Bevel_highlightColor_b"]);
         Tweener.registerSpecialProperty("_Bevel_highlightColor_r",_filter_property_get,_filter_property_set,[BevelFilter,"highlightColor","color","r"]);
         Tweener.registerSpecialProperty("_Bevel_highlightColor_g",_filter_property_get,_filter_property_set,[BevelFilter,"highlightColor","color","g"]);
         Tweener.registerSpecialProperty("_Bevel_highlightColor_b",_filter_property_get,_filter_property_set,[BevelFilter,"highlightColor","color","b"]);
         Tweener.registerSpecialProperty("_Bevel_knockout",_filter_property_get,_filter_property_set,[BevelFilter,"knockout"]);
         Tweener.registerSpecialProperty("_Bevel_quality",_filter_property_get,_filter_property_set,[BevelFilter,"quality"]);
         Tweener.registerSpecialProperty("_Bevel_shadowAlpha",_filter_property_get,_filter_property_set,[BevelFilter,"shadowAlpha"]);
         Tweener.registerSpecialPropertySplitter("_Bevel_shadowColor",_generic_color_splitter,["_Bevel_shadowColor_r","_Bevel_shadowColor_g","_Bevel_shadowColor_b"]);
         Tweener.registerSpecialProperty("_Bevel_shadowColor_r",_filter_property_get,_filter_property_set,[BevelFilter,"shadowColor","color","r"]);
         Tweener.registerSpecialProperty("_Bevel_shadowColor_g",_filter_property_get,_filter_property_set,[BevelFilter,"shadowColor","color","g"]);
         Tweener.registerSpecialProperty("_Bevel_shadowColor_b",_filter_property_get,_filter_property_set,[BevelFilter,"shadowColor","color","b"]);
         Tweener.registerSpecialProperty("_Bevel_strength",_filter_property_get,_filter_property_set,[BevelFilter,"strength"]);
         Tweener.registerSpecialProperty("_Bevel_type",_filter_property_get,_filter_property_set,[BevelFilter,"type"]);
         Tweener.registerSpecialProperty("_Blur_blurX",_filter_property_get,_filter_property_set,[BlurFilter,"blurX"]);
         Tweener.registerSpecialProperty("_Blur_blurY",_filter_property_get,_filter_property_set,[BlurFilter,"blurY"]);
         Tweener.registerSpecialProperty("_Blur_quality",_filter_property_get,_filter_property_set,[BlurFilter,"quality"]);
         Tweener.registerSpecialPropertySplitter("_ColorMatrix_matrix",_generic_matrix_splitter,[[1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0],["_ColorMatrix_matrix_rr","_ColorMatrix_matrix_rg","_ColorMatrix_matrix_rb","_ColorMatrix_matrix_ra","_ColorMatrix_matrix_ro","_ColorMatrix_matrix_gr","_ColorMatrix_matrix_gg","_ColorMatrix_matrix_gb","_ColorMatrix_matrix_ga","_ColorMatrix_matrix_go","_ColorMatrix_matrix_br","_ColorMatrix_matrix_bg","_ColorMatrix_matrix_bb","_ColorMatrix_matrix_ba","_ColorMatrix_matrix_bo","_ColorMatrix_matrix_ar","_ColorMatrix_matrix_ag","_ColorMatrix_matrix_ab","_ColorMatrix_matrix_aa","_ColorMatrix_matrix_ao"]]);
         Tweener.registerSpecialProperty("_ColorMatrix_matrix_rr",_filter_property_get,_filter_property_set,[ColorMatrixFilter,"matrix","matrix",0]);
         Tweener.registerSpecialProperty("_ColorMatrix_matrix_rg",_filter_property_get,_filter_property_set,[ColorMatrixFilter,"matrix","matrix",1]);
         Tweener.registerSpecialProperty("_ColorMatrix_matrix_rb",_filter_property_get,_filter_property_set,[ColorMatrixFilter,"matrix","matrix",2]);
         Tweener.registerSpecialProperty("_ColorMatrix_matrix_ra",_filter_property_get,_filter_property_set,[ColorMatrixFilter,"matrix","matrix",3]);
         Tweener.registerSpecialProperty("_ColorMatrix_matrix_ro",_filter_property_get,_filter_property_set,[ColorMatrixFilter,"matrix","matrix",4]);
         Tweener.registerSpecialProperty("_ColorMatrix_matrix_gr",_filter_property_get,_filter_property_set,[ColorMatrixFilter,"matrix","matrix",5]);
         Tweener.registerSpecialProperty("_ColorMatrix_matrix_gg",_filter_property_get,_filter_property_set,[ColorMatrixFilter,"matrix","matrix",6]);
         Tweener.registerSpecialProperty("_ColorMatrix_matrix_gb",_filter_property_get,_filter_property_set,[ColorMatrixFilter,"matrix","matrix",7]);
         Tweener.registerSpecialProperty("_ColorMatrix_matrix_ga",_filter_property_get,_filter_property_set,[ColorMatrixFilter,"matrix","matrix",8]);
         Tweener.registerSpecialProperty("_ColorMatrix_matrix_go",_filter_property_get,_filter_property_set,[ColorMatrixFilter,"matrix","matrix",9]);
         Tweener.registerSpecialProperty("_ColorMatrix_matrix_br",_filter_property_get,_filter_property_set,[ColorMatrixFilter,"matrix","matrix",10]);
         Tweener.registerSpecialProperty("_ColorMatrix_matrix_bg",_filter_property_get,_filter_property_set,[ColorMatrixFilter,"matrix","matrix",11]);
         Tweener.registerSpecialProperty("_ColorMatrix_matrix_bb",_filter_property_get,_filter_property_set,[ColorMatrixFilter,"matrix","matrix",12]);
         Tweener.registerSpecialProperty("_ColorMatrix_matrix_ba",_filter_property_get,_filter_property_set,[ColorMatrixFilter,"matrix","matrix",13]);
         Tweener.registerSpecialProperty("_ColorMatrix_matrix_bo",_filter_property_get,_filter_property_set,[ColorMatrixFilter,"matrix","matrix",14]);
         Tweener.registerSpecialProperty("_ColorMatrix_matrix_ar",_filter_property_get,_filter_property_set,[ColorMatrixFilter,"matrix","matrix",15]);
         Tweener.registerSpecialProperty("_ColorMatrix_matrix_ag",_filter_property_get,_filter_property_set,[ColorMatrixFilter,"matrix","matrix",16]);
         Tweener.registerSpecialProperty("_ColorMatrix_matrix_ab",_filter_property_get,_filter_property_set,[ColorMatrixFilter,"matrix","matrix",17]);
         Tweener.registerSpecialProperty("_ColorMatrix_matrix_aa",_filter_property_get,_filter_property_set,[ColorMatrixFilter,"matrix","matrix",18]);
         Tweener.registerSpecialProperty("_ColorMatrix_matrix_ao",_filter_property_get,_filter_property_set,[ColorMatrixFilter,"matrix","matrix",19]);
         Tweener.registerSpecialProperty("_Convolution_alpha",_filter_property_get,_filter_property_set,[ConvolutionFilter,"alpha"]);
         Tweener.registerSpecialProperty("_Convolution_bias",_filter_property_get,_filter_property_set,[ConvolutionFilter,"bias"]);
         Tweener.registerSpecialProperty("_Convolution_clamp",_filter_property_get,_filter_property_set,[ConvolutionFilter,"clamp"]);
         Tweener.registerSpecialPropertySplitter("_Convolution_color",_generic_color_splitter,["_Convolution_color_r","_Convolution_color_g","_Convolution_color_b"]);
         Tweener.registerSpecialProperty("_Convolution_color_r",_filter_property_get,_filter_property_set,[ConvolutionFilter,"color","color","r"]);
         Tweener.registerSpecialProperty("_Convolution_color_g",_filter_property_get,_filter_property_set,[ConvolutionFilter,"color","color","g"]);
         Tweener.registerSpecialProperty("_Convolution_color_b",_filter_property_get,_filter_property_set,[ConvolutionFilter,"color","color","b"]);
         Tweener.registerSpecialProperty("_Convolution_divisor",_filter_property_get,_filter_property_set,[ConvolutionFilter,"divisor"]);
         Tweener.registerSpecialProperty("_Convolution_matrixX",_filter_property_get,_filter_property_set,[ConvolutionFilter,"matrixX"]);
         Tweener.registerSpecialProperty("_Convolution_matrixY",_filter_property_get,_filter_property_set,[ConvolutionFilter,"matrixY"]);
         Tweener.registerSpecialProperty("_Convolution_preserveAlpha",_filter_property_get,_filter_property_set,[ConvolutionFilter,"preserveAlpha"]);
         Tweener.registerSpecialProperty("_DisplacementMap_alpha",_filter_property_get,_filter_property_set,[DisplacementMapFilter,"alpha"]);
         Tweener.registerSpecialPropertySplitter("_DisplacementMap_color",_generic_color_splitter,["_DisplacementMap_color_r","_DisplacementMap_color_r","_DisplacementMap_color_r"]);
         Tweener.registerSpecialProperty("_DisplacementMap_color_r",_filter_property_get,_filter_property_set,[DisplacementMapFilter,"color","color","r"]);
         Tweener.registerSpecialProperty("_DisplacementMap_color_g",_filter_property_get,_filter_property_set,[DisplacementMapFilter,"color","color","g"]);
         Tweener.registerSpecialProperty("_DisplacementMap_color_b",_filter_property_get,_filter_property_set,[DisplacementMapFilter,"color","color","b"]);
         Tweener.registerSpecialProperty("_DisplacementMap_componentX",_filter_property_get,_filter_property_set,[DisplacementMapFilter,"componentX"]);
         Tweener.registerSpecialProperty("_DisplacementMap_componentY",_filter_property_get,_filter_property_set,[DisplacementMapFilter,"componentY"]);
         Tweener.registerSpecialProperty("_DisplacementMap_mapBitmap",_filter_property_get,_filter_property_set,[DisplacementMapFilter,"mapBitmap"]);
         Tweener.registerSpecialPropertySplitter("_DisplacementMap_mapPoint",_generic_point_splitter,["_DisplacementMap_mapPoint_x","_DisplacementMap_mapPoint_y"]);
         Tweener.registerSpecialProperty("_DisplacementMap_mapPoint_x",_filter_property_get,_filter_property_set,[DisplacementMapFilter,"mapPoint","point","x"]);
         Tweener.registerSpecialProperty("_DisplacementMap_mapPoint_y",_filter_property_get,_filter_property_set,[DisplacementMapFilter,"mapPoint","point","y"]);
         Tweener.registerSpecialProperty("_DisplacementMap_mode",_filter_property_get,_filter_property_set,[DisplacementMapFilter,"mode"]);
         Tweener.registerSpecialProperty("_DisplacementMap_scaleX",_filter_property_get,_filter_property_set,[DisplacementMapFilter,"scaleX"]);
         Tweener.registerSpecialProperty("_DisplacementMap_scaleY",_filter_property_get,_filter_property_set,[DisplacementMapFilter,"scaleY"]);
         Tweener.registerSpecialProperty("_DropShadow_alpha",_filter_property_get,_filter_property_set,[DropShadowFilter,"alpha"]);
         Tweener.registerSpecialProperty("_DropShadow_angle",_filter_property_get,_filter_property_set,[DropShadowFilter,"angle"]);
         Tweener.registerSpecialProperty("_DropShadow_blurX",_filter_property_get,_filter_property_set,[DropShadowFilter,"blurX"]);
         Tweener.registerSpecialProperty("_DropShadow_blurY",_filter_property_get,_filter_property_set,[DropShadowFilter,"blurY"]);
         Tweener.registerSpecialPropertySplitter("_DropShadow_color",_generic_color_splitter,["_DropShadow_color_r","_DropShadow_color_g","_DropShadow_color_b"]);
         Tweener.registerSpecialProperty("_DropShadow_color_r",_filter_property_get,_filter_property_set,[DropShadowFilter,"color","color","r"]);
         Tweener.registerSpecialProperty("_DropShadow_color_g",_filter_property_get,_filter_property_set,[DropShadowFilter,"color","color","g"]);
         Tweener.registerSpecialProperty("_DropShadow_color_b",_filter_property_get,_filter_property_set,[DropShadowFilter,"color","color","b"]);
         Tweener.registerSpecialProperty("_DropShadow_distance",_filter_property_get,_filter_property_set,[DropShadowFilter,"distance"]);
         Tweener.registerSpecialProperty("_DropShadow_hideObject",_filter_property_get,_filter_property_set,[DropShadowFilter,"hideObject"]);
         Tweener.registerSpecialProperty("_DropShadow_inner",_filter_property_get,_filter_property_set,[DropShadowFilter,"inner"]);
         Tweener.registerSpecialProperty("_DropShadow_knockout",_filter_property_get,_filter_property_set,[DropShadowFilter,"knockout"]);
         Tweener.registerSpecialProperty("_DropShadow_quality",_filter_property_get,_filter_property_set,[DropShadowFilter,"quality"]);
         Tweener.registerSpecialProperty("_DropShadow_strength",_filter_property_get,_filter_property_set,[DropShadowFilter,"strength"]);
         Tweener.registerSpecialProperty("_Glow_alpha",_filter_property_get,_filter_property_set,[GlowFilter,"alpha"]);
         Tweener.registerSpecialProperty("_Glow_blurX",_filter_property_get,_filter_property_set,[GlowFilter,"blurX"]);
         Tweener.registerSpecialProperty("_Glow_blurY",_filter_property_get,_filter_property_set,[GlowFilter,"blurY"]);
         Tweener.registerSpecialPropertySplitter("_Glow_color",_generic_color_splitter,["_Glow_color_r","_Glow_color_g","_Glow_color_b"]);
         Tweener.registerSpecialProperty("_Glow_color_r",_filter_property_get,_filter_property_set,[GlowFilter,"color","color","r"]);
         Tweener.registerSpecialProperty("_Glow_color_g",_filter_property_get,_filter_property_set,[GlowFilter,"color","color","g"]);
         Tweener.registerSpecialProperty("_Glow_color_b",_filter_property_get,_filter_property_set,[GlowFilter,"color","color","b"]);
         Tweener.registerSpecialProperty("_Glow_inner",_filter_property_get,_filter_property_set,[GlowFilter,"inner"]);
         Tweener.registerSpecialProperty("_Glow_knockout",_filter_property_get,_filter_property_set,[GlowFilter,"knockout"]);
         Tweener.registerSpecialProperty("_Glow_quality",_filter_property_get,_filter_property_set,[GlowFilter,"quality"]);
         Tweener.registerSpecialProperty("_Glow_strength",_filter_property_get,_filter_property_set,[GlowFilter,"strength"]);
         Tweener.registerSpecialProperty("_GradientBevel_angle",_filter_property_get,_filter_property_set,[GradientBevelFilter,"angle"]);
         Tweener.registerSpecialProperty("_GradientBevel_blurX",_filter_property_get,_filter_property_set,[GradientBevelFilter,"blurX"]);
         Tweener.registerSpecialProperty("_GradientBevel_blurY",_filter_property_get,_filter_property_set,[GradientBevelFilter,"blurY"]);
         Tweener.registerSpecialProperty("_GradientBevel_distance",_filter_property_get,_filter_property_set,[GradientBevelFilter,"distance"]);
         Tweener.registerSpecialProperty("_GradientBevel_quality",_filter_property_get,_filter_property_set,[GradientBevelFilter,"quality"]);
         Tweener.registerSpecialProperty("_GradientBevel_strength",_filter_property_get,_filter_property_set,[GradientBevelFilter,"strength"]);
         Tweener.registerSpecialProperty("_GradientBevel_type",_filter_property_get,_filter_property_set,[GradientBevelFilter,"type"]);
         Tweener.registerSpecialProperty("_GradientGlow_angle",_filter_property_get,_filter_property_set,[GradientGlowFilter,"angle"]);
         Tweener.registerSpecialProperty("_GradientGlow_blurX",_filter_property_get,_filter_property_set,[GradientGlowFilter,"blurX"]);
         Tweener.registerSpecialProperty("_GradientGlow_blurY",_filter_property_get,_filter_property_set,[GradientGlowFilter,"blurY"]);
         Tweener.registerSpecialProperty("_GradientGlow_distance",_filter_property_get,_filter_property_set,[GradientGlowFilter,"distance"]);
         Tweener.registerSpecialProperty("_GradientGlow_knockout",_filter_property_get,_filter_property_set,[GradientGlowFilter,"knockout"]);
         Tweener.registerSpecialProperty("_GradientGlow_quality",_filter_property_get,_filter_property_set,[GradientGlowFilter,"quality"]);
         Tweener.registerSpecialProperty("_GradientGlow_strength",_filter_property_get,_filter_property_set,[GradientGlowFilter,"strength"]);
         Tweener.registerSpecialProperty("_GradientGlow_type",_filter_property_get,_filter_property_set,[GradientGlowFilter,"type"]);
      }
      
      public static function _filter_property_get(param1:Object, param2:Array, param3:Object = null) : Number
      {
         var _loc5_:Number = NaN;
         var _loc9_:Object = null;
         var _loc10_:String = null;
         var _loc4_:Array = param1.filters;
         var _loc6_:Object = param2[0];
         var _loc7_:String = param2[1];
         var _loc8_:String = param2[2];
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            if(_loc4_[_loc5_] is Class(_loc6_))
            {
               if(_loc8_ != "color")
               {
                  if(_loc8_ == "matrix")
                  {
                     return _loc4_[_loc5_][_loc7_][param2[3]];
                  }
                  if(_loc8_ == "point")
                  {
                     return _loc4_[_loc5_][_loc7_][param2[3]];
                  }
                  return _loc4_[_loc5_][_loc7_];
               }
               _loc10_ = param2[3];
               if(_loc10_ == "r")
               {
                  return AuxFunctions.numberToR(_loc4_[_loc5_][_loc7_]);
               }
               if(_loc10_ == "g")
               {
                  return AuxFunctions.numberToG(_loc4_[_loc5_][_loc7_]);
               }
               if(_loc10_ == "b")
               {
                  return AuxFunctions.numberToB(_loc4_[_loc5_][_loc7_]);
               }
            }
            _loc5_++;
         }
         switch(_loc6_)
         {
            case BevelFilter:
               _loc9_ = {
                  "angle":NaN,
                  "blurX":0,
                  "blurY":0,
                  "distance":0,
                  "highlightAlpha":1,
                  "highlightColor":NaN,
                  "knockout":null,
                  "quality":NaN,
                  "shadowAlpha":1,
                  "shadowColor":NaN,
                  "strength":2,
                  "type":null
               };
               break;
            case BlurFilter:
               _loc9_ = {
                  "blurX":0,
                  "blurY":0,
                  "quality":NaN
               };
               break;
            case ColorMatrixFilter:
               _loc9_ = {"matrix":[1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0]};
               break;
            case ConvolutionFilter:
               _loc9_ = {
                  "alpha":0,
                  "bias":0,
                  "clamp":null,
                  "color":NaN,
                  "divisor":1,
                  "matrix":[1],
                  "matrixX":1,
                  "matrixY":1,
                  "preserveAlpha":null
               };
               break;
            case DisplacementMapFilter:
               _loc9_ = {
                  "alpha":0,
                  "color":NaN,
                  "componentX":null,
                  "componentY":null,
                  "mapBitmap":null,
                  "mapPoint":null,
                  "mode":null,
                  "scaleX":0,
                  "scaleY":0
               };
               break;
            case DropShadowFilter:
               _loc9_ = {
                  "distance":0,
                  "angle":NaN,
                  "color":NaN,
                  "alpha":1,
                  "blurX":0,
                  "blurY":0,
                  "strength":1,
                  "quality":NaN,
                  "inner":null,
                  "knockout":null,
                  "hideObject":null
               };
               break;
            case GlowFilter:
               _loc9_ = {
                  "alpha":1,
                  "blurX":0,
                  "blurY":0,
                  "color":NaN,
                  "inner":null,
                  "knockout":null,
                  "quality":NaN,
                  "strength":2
               };
               break;
            case GradientBevelFilter:
               _loc9_ = {
                  "alphas":null,
                  "angle":NaN,
                  "blurX":0,
                  "blurY":0,
                  "colors":null,
                  "distance":0,
                  "knockout":null,
                  "quality":NaN,
                  "ratios":NaN,
                  "strength":1,
                  "type":null
               };
               break;
            case GradientGlowFilter:
               _loc9_ = {
                  "alphas":null,
                  "angle":NaN,
                  "blurX":0,
                  "blurY":0,
                  "colors":null,
                  "distance":0,
                  "knockout":null,
                  "quality":NaN,
                  "ratios":NaN,
                  "strength":1,
                  "type":null
               };
         }
         if(_loc8_ == "color")
         {
            return NaN;
         }
         if(_loc8_ == "matrix")
         {
            return _loc9_[_loc7_][param2[3]];
         }
         if(_loc8_ == "point")
         {
            return _loc9_[_loc7_][param2[3]];
         }
         return _loc9_[_loc7_];
      }
      
      public static function _filter_property_set(param1:Object, param2:Number, param3:Array, param4:Object = null) : void
      {
         var _loc6_:Number = NaN;
         var _loc10_:BitmapFilter = null;
         var _loc11_:String = null;
         var _loc12_:Array = null;
         var _loc13_:Point = null;
         var _loc5_:Array = param1.filters;
         var _loc7_:Object = param3[0];
         var _loc8_:String = param3[1];
         var _loc9_:String = param3[2];
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            if(_loc5_[_loc6_] is Class(_loc7_))
            {
               if(_loc9_ == "color")
               {
                  _loc11_ = param3[3];
                  if(_loc11_ == "r")
                  {
                     _loc5_[_loc6_][_loc8_] = _loc5_[_loc6_][_loc8_] & 0xFFFF | param2 << 16;
                  }
                  if(_loc11_ == "g")
                  {
                     _loc5_[_loc6_][_loc8_] = _loc5_[_loc6_][_loc8_] & 0xFF00FF | param2 << 8;
                  }
                  if(_loc11_ == "b")
                  {
                     _loc5_[_loc6_][_loc8_] = _loc5_[_loc6_][_loc8_] & 0xFFFF00 | param2;
                  }
               }
               else if(_loc9_ == "matrix")
               {
                  _loc12_ = _loc5_[_loc6_][_loc8_];
                  _loc12_[param3[3]] = param2;
                  _loc5_[_loc6_][_loc8_] = _loc12_;
               }
               else if(_loc9_ == "point")
               {
                  _loc13_ = Point(_loc5_[_loc6_][_loc8_]);
                  _loc13_[param3[3]] = param2;
                  _loc5_[_loc6_][_loc8_] = _loc13_;
               }
               else
               {
                  _loc5_[_loc6_][_loc8_] = param2;
               }
               param1.filters = _loc5_;
               return;
            }
            _loc6_++;
         }
         if(_loc5_ == null)
         {
            _loc5_ = new Array();
         }
         switch(_loc7_)
         {
            case BevelFilter:
               _loc10_ = new BevelFilter(0,45,16777215,1,0,1,0,0);
               break;
            case BlurFilter:
               _loc10_ = new BlurFilter(0,0);
               break;
            case ColorMatrixFilter:
               _loc10_ = new ColorMatrixFilter([1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0]);
               break;
            case ConvolutionFilter:
               _loc10_ = new ConvolutionFilter(1,1,[1],1,0,true,true,0,0);
               break;
            case DisplacementMapFilter:
               _loc10_ = new DisplacementMapFilter(new BitmapData(10,10),new Point(0,0),0,1,0,0);
               break;
            case DropShadowFilter:
               _loc10_ = new DropShadowFilter(0,45,0,1,0,0);
               break;
            case GlowFilter:
               _loc10_ = new GlowFilter(16711680,1,0,0);
               break;
            case GradientBevelFilter:
               _loc10_ = new GradientBevelFilter(0,45,[16777215,0],[1,1],[32,223],0,0);
               break;
            case GradientGlowFilter:
               _loc10_ = new GradientGlowFilter(0,45,[16777215,0],[1,1],[32,223],0,0);
         }
         _loc5_.push(_loc10_);
         param1.filters = _loc5_;
         _filter_property_set(param1,param2,param3);
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
      
      public static function _generic_point_splitter(param1:Point, param2:Array) : Array
      {
         var _loc3_:Array = new Array();
         _loc3_.push({
            "name":param2[0],
            "value":param1.x
         });
         _loc3_.push({
            "name":param2[1],
            "value":param1.y
         });
         return _loc3_;
      }
      
      public static function _generic_matrix_splitter(param1:Array, param2:Array) : Array
      {
         if(param1 == null)
         {
            param1 = param2[0].concat();
         }
         var _loc3_:Array = new Array();
         var _loc4_:Number = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_.push({
               "name":param2[1][_loc4_],
               "value":param1[_loc4_]
            });
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function _filter_splitter(param1:BitmapFilter, param2:Array, param3:Object = null) : Array
      {
         var _loc4_:Array = new Array();
         if(param1 is BevelFilter)
         {
            _loc4_.push({
               "name":"_Bevel_angle",
               "value":BevelFilter(param1).angle
            });
            _loc4_.push({
               "name":"_Bevel_blurX",
               "value":BevelFilter(param1).blurX
            });
            _loc4_.push({
               "name":"_Bevel_blurY",
               "value":BevelFilter(param1).blurY
            });
            _loc4_.push({
               "name":"_Bevel_distance",
               "value":BevelFilter(param1).distance
            });
            _loc4_.push({
               "name":"_Bevel_highlightAlpha",
               "value":BevelFilter(param1).highlightAlpha
            });
            _loc4_.push({
               "name":"_Bevel_highlightColor",
               "value":BevelFilter(param1).highlightColor
            });
            _loc4_.push({
               "name":"_Bevel_knockout",
               "value":BevelFilter(param1).knockout
            });
            _loc4_.push({
               "name":"_Bevel_quality",
               "value":BevelFilter(param1).quality
            });
            _loc4_.push({
               "name":"_Bevel_shadowAlpha",
               "value":BevelFilter(param1).shadowAlpha
            });
            _loc4_.push({
               "name":"_Bevel_shadowColor",
               "value":BevelFilter(param1).shadowColor
            });
            _loc4_.push({
               "name":"_Bevel_strength",
               "value":BevelFilter(param1).strength
            });
            _loc4_.push({
               "name":"_Bevel_type",
               "value":BevelFilter(param1).type
            });
         }
         else if(param1 is BlurFilter)
         {
            _loc4_.push({
               "name":"_Blur_blurX",
               "value":BlurFilter(param1).blurX
            });
            _loc4_.push({
               "name":"_Blur_blurY",
               "value":BlurFilter(param1).blurY
            });
            _loc4_.push({
               "name":"_Blur_quality",
               "value":BlurFilter(param1).quality
            });
         }
         else if(param1 is ColorMatrixFilter)
         {
            _loc4_.push({
               "name":"_ColorMatrix_matrix",
               "value":ColorMatrixFilter(param1).matrix
            });
         }
         else if(param1 is ConvolutionFilter)
         {
            _loc4_.push({
               "name":"_Convolution_alpha",
               "value":ConvolutionFilter(param1).alpha
            });
            _loc4_.push({
               "name":"_Convolution_bias",
               "value":ConvolutionFilter(param1).bias
            });
            _loc4_.push({
               "name":"_Convolution_clamp",
               "value":ConvolutionFilter(param1).clamp
            });
            _loc4_.push({
               "name":"_Convolution_color",
               "value":ConvolutionFilter(param1).color
            });
            _loc4_.push({
               "name":"_Convolution_divisor",
               "value":ConvolutionFilter(param1).divisor
            });
            _loc4_.push({
               "name":"_Convolution_matrixX",
               "value":ConvolutionFilter(param1).matrixX
            });
            _loc4_.push({
               "name":"_Convolution_matrixY",
               "value":ConvolutionFilter(param1).matrixY
            });
            _loc4_.push({
               "name":"_Convolution_preserveAlpha",
               "value":ConvolutionFilter(param1).preserveAlpha
            });
         }
         else if(param1 is DisplacementMapFilter)
         {
            _loc4_.push({
               "name":"_DisplacementMap_alpha",
               "value":DisplacementMapFilter(param1).alpha
            });
            _loc4_.push({
               "name":"_DisplacementMap_color",
               "value":DisplacementMapFilter(param1).color
            });
            _loc4_.push({
               "name":"_DisplacementMap_componentX",
               "value":DisplacementMapFilter(param1).componentX
            });
            _loc4_.push({
               "name":"_DisplacementMap_componentY",
               "value":DisplacementMapFilter(param1).componentY
            });
            _loc4_.push({
               "name":"_DisplacementMap_mapBitmap",
               "value":DisplacementMapFilter(param1).mapBitmap
            });
            _loc4_.push({
               "name":"_DisplacementMap_mapPoint",
               "value":DisplacementMapFilter(param1).mapPoint
            });
            _loc4_.push({
               "name":"_DisplacementMap_mode",
               "value":DisplacementMapFilter(param1).mode
            });
            _loc4_.push({
               "name":"_DisplacementMap_scaleX",
               "value":DisplacementMapFilter(param1).scaleX
            });
            _loc4_.push({
               "name":"_DisplacementMap_scaleY",
               "value":DisplacementMapFilter(param1).scaleY
            });
         }
         else if(param1 is DropShadowFilter)
         {
            _loc4_.push({
               "name":"_DropShadow_alpha",
               "value":DropShadowFilter(param1).alpha
            });
            _loc4_.push({
               "name":"_DropShadow_angle",
               "value":DropShadowFilter(param1).angle
            });
            _loc4_.push({
               "name":"_DropShadow_blurX",
               "value":DropShadowFilter(param1).blurX
            });
            _loc4_.push({
               "name":"_DropShadow_blurY",
               "value":DropShadowFilter(param1).blurY
            });
            _loc4_.push({
               "name":"_DropShadow_color",
               "value":DropShadowFilter(param1).color
            });
            _loc4_.push({
               "name":"_DropShadow_distance",
               "value":DropShadowFilter(param1).distance
            });
            _loc4_.push({
               "name":"_DropShadow_hideObject",
               "value":DropShadowFilter(param1).hideObject
            });
            _loc4_.push({
               "name":"_DropShadow_inner",
               "value":DropShadowFilter(param1).inner
            });
            _loc4_.push({
               "name":"_DropShadow_knockout",
               "value":DropShadowFilter(param1).knockout
            });
            _loc4_.push({
               "name":"_DropShadow_quality",
               "value":DropShadowFilter(param1).quality
            });
            _loc4_.push({
               "name":"_DropShadow_strength",
               "value":DropShadowFilter(param1).strength
            });
         }
         else if(param1 is GlowFilter)
         {
            _loc4_.push({
               "name":"_Glow_alpha",
               "value":GlowFilter(param1).alpha
            });
            _loc4_.push({
               "name":"_Glow_blurX",
               "value":GlowFilter(param1).blurX
            });
            _loc4_.push({
               "name":"_Glow_blurY",
               "value":GlowFilter(param1).blurY
            });
            _loc4_.push({
               "name":"_Glow_color",
               "value":GlowFilter(param1).color
            });
            _loc4_.push({
               "name":"_Glow_inner",
               "value":GlowFilter(param1).inner
            });
            _loc4_.push({
               "name":"_Glow_knockout",
               "value":GlowFilter(param1).knockout
            });
            _loc4_.push({
               "name":"_Glow_quality",
               "value":GlowFilter(param1).quality
            });
            _loc4_.push({
               "name":"_Glow_strength",
               "value":GlowFilter(param1).strength
            });
         }
         else if(param1 is GradientBevelFilter)
         {
            _loc4_.push({
               "name":"_GradientBevel_angle",
               "value":GradientBevelFilter(param1).strength
            });
            _loc4_.push({
               "name":"_GradientBevel_blurX",
               "value":GradientBevelFilter(param1).blurX
            });
            _loc4_.push({
               "name":"_GradientBevel_blurY",
               "value":GradientBevelFilter(param1).blurY
            });
            _loc4_.push({
               "name":"_GradientBevel_distance",
               "value":GradientBevelFilter(param1).distance
            });
            _loc4_.push({
               "name":"_GradientBevel_quality",
               "value":GradientBevelFilter(param1).quality
            });
            _loc4_.push({
               "name":"_GradientBevel_strength",
               "value":GradientBevelFilter(param1).strength
            });
            _loc4_.push({
               "name":"_GradientBevel_type",
               "value":GradientBevelFilter(param1).type
            });
         }
         else if(param1 is GradientGlowFilter)
         {
            _loc4_.push({
               "name":"_GradientGlow_angle",
               "value":GradientGlowFilter(param1).strength
            });
            _loc4_.push({
               "name":"_GradientGlow_blurX",
               "value":GradientGlowFilter(param1).blurX
            });
            _loc4_.push({
               "name":"_GradientGlow_blurY",
               "value":GradientGlowFilter(param1).blurY
            });
            _loc4_.push({
               "name":"_GradientGlow_distance",
               "value":GradientGlowFilter(param1).distance
            });
            _loc4_.push({
               "name":"_GradientGlow_knockout",
               "value":GradientGlowFilter(param1).knockout
            });
            _loc4_.push({
               "name":"_GradientGlow_quality",
               "value":GradientGlowFilter(param1).quality
            });
            _loc4_.push({
               "name":"_GradientGlow_strength",
               "value":GradientGlowFilter(param1).strength
            });
            _loc4_.push({
               "name":"_GradientGlow_type",
               "value":GradientGlowFilter(param1).type
            });
         }
         else
         {
            trace("Tweener FilterShortcuts Error :: Unknown filter class used");
         }
         return _loc4_;
      }
   }
}

