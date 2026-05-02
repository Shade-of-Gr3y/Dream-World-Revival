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
      
      private static var _stage:Stage;
      
      private static var _tracermc:MovieClip;
      
      private static var _log:Array = new Array();
      
      private static var _isShow:Boolean = false;
      
      private static var _offsetX:int = 0;
      
      private static var _offsetY:int = 0;
      
      private static var _input:String = "";
      
      private static const LIMIT:uint = 100;
      
      private static var _password:String = "tracer";
      
      public function Tracer()
      {
         super();
      }
      
      private static function set tracermc(value:MovieClip) : void
      {
         _tracermc = value;
      }
      
      private static function get tracermc() : MovieClip
      {
         return _tracermc;
      }
      
      public static function set password(value:String) : void
      {
         _password = value;
      }
      
      public static function get password() : String
      {
         return _password;
      }
      
      public static function init(stage:Stage) : void
      {
         tracermc = createTracermc();
         _stage = stage;
         _stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);
      }
      
      public static function add(... rest) : void
      {
         var str:String = null;
         var i:int = 0;
         try
         {
            str = "";
            for(i = 0; i < rest.length; i++)
            {
               if(i != 0)
               {
                  str += ", " + rest[i].toString();
               }
               else
               {
                  str += rest[i].toString();
               }
            }
            _log.push(str);
            update();
         }
         catch(error:Error)
         {
         }
      }
      
      public static function update() : void
      {
         var log:Array = _log;
         tracermc.tf.text = "";
         var cnt:uint = 0;
         for(var i:* = int(log.length); i > 0; i--)
         {
            if(cnt >= LIMIT)
            {
               return;
            }
            tracermc.tf.appendText(log[i - 1].toString() + "\n");
            cnt++;
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
      
      private static function keyDownHandler(event:KeyboardEvent) : void
      {
         _input += String.fromCharCode(event.charCode);
         if(_input.substr(-_password.length,_password.length) == _password)
         {
            show();
         }
         if(_input.length > _password.length)
         {
            _input = _input.substr(-_password.length,_password.length);
         }
      }
      
      private static function mouseDownHandler(event:MouseEvent) : void
      {
         _stage.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
         _offsetX = event.localX;
         _offsetY = event.localY;
         _stage.addEventListener(Event.ENTER_FRAME,enterFrameHandler);
      }
      
      private static function mouseUpHandler(event:MouseEvent) : void
      {
         _stage.removeEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
         _stage.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
      }
      
      private static function enterFrameHandler(event:Event) : void
      {
         tracermc.x = _stage.mouseX - _offsetX;
         tracermc.y = _stage.mouseY - _offsetY;
      }
      
      private static function createTracermc() : MovieClip
      {
         var mc:MovieClip = new MovieClip();
         var bg:Sprite = new Sprite();
         bg.graphics.beginFill(0,0.8);
         bg.graphics.lineStyle(0,13421772,0.5);
         bg.graphics.drawRect(0,0,440,260);
         bg.graphics.endFill();
         mc.addChild(bg);
         mc.bgmc = bg;
         var mask:Sprite = new Sprite();
         mask.graphics.beginFill(16776960);
         mask.graphics.drawRect(10,10,420,240);
         mask.graphics.endFill();
         mc.addChild(mask);
         var tfs:Sprite = new Sprite();
         mc.addChild(tfs);
         tfs.mask = mask;
         var tfm:TextFormat = new TextFormat(null,11,16777215);
         var tf:TextField = new TextField();
         tf.defaultTextFormat = tfm;
         tf.autoSize = TextFieldAutoSize.RIGHT;
         tf.selectable = true;
         tf.multiline = true;
         tf.wordWrap = true;
         tf.x = 10;
         tf.y = 10;
         tf.width = 420;
         tf.height = 240;
         tfs.addChild(tf);
         mc.tf = tf;
         mc.cacheAsBitmap = true;
         return mc;
      }
      
      private static function doubleClickHandler(event:Event) : void
      {
         hide();
      }
   }
}

