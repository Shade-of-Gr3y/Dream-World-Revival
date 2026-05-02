package hivelocity.flight.status
{
   import flash.display.MovieClip;
   
   public class speedGauge extends MovieClip
   {
       
      
      public var speedGauge_mc:MovieClip;
      
      public var max_blink:MovieClip;
      
      private var _speedMax:Number;
      
      private var _speedMin:Number;
      
      private var _speedGaugeScale:Number;
      
      public function speedGauge()
      {
         super();
         this.__init();
      }
      
      public function set setGaugeMax(param1:Number) : void
      {
         this._speedMax = param1;
      }
      
      public function set setGaugeMin(param1:Number) : void
      {
         this._speedMin = param1;
      }
      
      public function set setSpeed(param1:Number) : void
      {
         this._speedGaugeScale = (param1 - this._speedMin) / (this._speedMax - this._speedMin);
         this.setGaugeScale();
      }
      
      public function reset() : void
      {
         this["speedGauge_mc"].bar_scale.x = 0;
         this.__init();
      }
      
      private function __init() : void
      {
         this._speedGaugeScale = 0;
         this.setGaugeScale();
      }
      
      private function setGaugeScale() : void
      {
         this["speedGauge_mc"].bar_scale.x = this["speedGauge_mc"].bar_scale.width * this._speedGaugeScale;
      }
   }
}
