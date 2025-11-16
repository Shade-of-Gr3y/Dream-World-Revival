package jp.feb19.utils
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class Tracer
   {
      
      private static var _log:Array = new Array();
      
      private static var _isShow:Boolean = false;
      
      private static var _stage:Stage;
      
      private static var _offsetX:int = 0;
      
      private static var _offsetY:int = 0;
      
      private static var _input:String = "";
      
      private static const LIMIT:uint = 100;
      
      private static var _tracermc:MovieClip;
      
      private static var _password:String = "tracer";
       
      
      public function Tracer()
      {
         super();
      }
      
      private static function set tracermc(param1:MovieClip) : void
      {
         _tracermc = param1;
      }
      
      private static function get tracermc() : MovieClip
      {
         return _tracermc;
      }
      
      public static function set password(param1:String) : void
      {
         _password = param1;
      }
      
      public static function get password() : String
      {
         return _password;
      }
      
      public static function init(param1:Stage) : void
      {
         tracermc = createTracermc();
         _stage = param1;
         _stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);
      }
      
      public static function add(... rest) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         try
         {
            _loc2_ = "";
            _loc3_ = 0;
            while(_loc3_ < rest.length)
            {
               if(_loc3_ != 0)
               {
                  _loc2_ += ", " + rest[_loc3_].toString();
               }
               else
               {
                  _loc2_ += rest[_loc3_].toString();
               }
               _loc3_++;
            }
            _log.push(_loc2_);
            update();
         }
         catch(error:Error)
         {
         }
      }
      
      public static function update() : void
      {
         var _loc1_:Array = _log;
         tracermc.tf.text = "";
         var _loc2_:uint = 0;
         var _loc3_:int = int(_loc1_.length);
         while(_loc3_ > 0)
         {
            if(_loc2_ >= LIMIT)
            {
               return;
            }
            tracermc.tf.appendText(_loc1_[_loc3_ - 1].toString() + "\n");
            _loc2_++;
            _loc3_--;
         }
      }
      
      public static function show() : void
      {
         if(!_isShow)
         {
            _isShow = true;
            update();
            _stage.addChild(tracermc);
            ButtonUtilities.setBtn(tracermc.bgmc,{
               "doubleClick":doubleClickHandler,
               "down":mouseDownHandler
            });
         }
      }
      
      public static function hide() : void
      {
         if(_isShow)
         {
            _isShow = false;
            ButtonUtilities.unsetBtn(tracermc.bgmc,{
               "doubleClick":doubleClickHandler,
               "down":mouseDownHandler
            });
            _stage.removeChild(tracermc);
         }
      }
      
      private static function keyDownHandler(param1:KeyboardEvent) : void
      {
         _input += String.fromCharCode(param1.charCode);
         if(_input.substr(-_password.length,_password.length) == _password)
         {
            show();
         }
         if(_input.length > _password.length)
         {
            _input = _input.substr(-_password.length,_password.length);
         }
      }
      
      private static function mouseDownHandler(param1:MouseEvent) : void
      {
         _stage.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
         _offsetX = param1.localX;
         _offsetY = param1.localY;
         _stage.addEventListener(Event.ENTER_FRAME,enterFrameHandler);
      }
      
      private static function mouseUpHandler(param1:MouseEvent) : void
      {
         _stage.removeEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
         _stage.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
      }
      
      private static function enterFrameHandler(param1:Event) : void
      {
         tracermc.x = _stage.mouseX - _offsetX;
         tracermc.y = _stage.mouseY - _offsetY;
      }
      
      private static function createTracermc() : MovieClip
      {
         var _loc1_:MovieClip = new MovieClip();
         var _loc2_:Sprite = new Sprite();
         _loc2_.graphics.beginFill(0,0.8);
         _loc2_.graphics.lineStyle(0,13421772,0.5);
         _loc2_.graphics.drawRect(0,0,440,260);
         _loc2_.graphics.endFill();
         _loc1_.addChild(_loc2_);
         _loc1_.bgmc = _loc2_;
         var _loc3_:Sprite = new Sprite();
         _loc3_.graphics.beginFill(16776960);
         _loc3_.graphics.drawRect(10,10,420,240);
         _loc3_.graphics.endFill();
         _loc1_.addChild(_loc3_);
         var _loc4_:Sprite = new Sprite();
         _loc1_.addChild(_loc4_);
         _loc4_.mask = _loc3_;
         var _loc5_:TextFormat = new TextFormat(null,11,16777215);
         var _loc6_:TextField;
         (_loc6_ = new TextField()).defaultTextFormat = _loc5_;
         _loc6_.autoSize = TextFieldAutoSize.RIGHT;
         _loc6_.selectable = true;
         _loc6_.multiline = true;
         _loc6_.wordWrap = true;
         _loc6_.x = 10;
         _loc6_.y = 10;
         _loc6_.width = 420;
         _loc6_.height = 240;
         _loc4_.addChild(_loc6_);
         _loc1_.tf = _loc6_;
         _loc1_.cacheAsBitmap = true;
         return _loc1_;
      }
      
      private static function doubleClickHandler(param1:Event) : void
      {
         hide();
      }
   }
}
