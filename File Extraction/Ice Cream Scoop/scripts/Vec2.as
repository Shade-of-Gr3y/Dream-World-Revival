package
{
   public class Vec2
   {
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public function Vec2()
      {
         super();
      }
      
      public function InnerProduct(param1:Vec2) : Number
      {
         return this.x * param1.x + this.y * param1.y;
      }
      
      public function Add(param1:Vec2) : void
      {
         this.x += param1.x;
         this.y += param1.y;
      }
      
      public function Set(param1:Number, param2:Number) : *
      {
         this.x = param1;
         this.y = param2;
      }
      
      public function GetRotation(param1:Number) : Vec2
      {
         var _loc2_:Vec2 = new Vec2();
         _loc2_.x = Math.cos(param1) * this.x - Math.sin(param1) * this.y;
         _loc2_.y = Math.sin(param1) * this.x + Math.cos(param1) * this.y;
         return _loc2_;
      }
      
      public function LengthProduct() : Number
      {
         return Math.sqrt(this.x * this.x + this.y * this.y);
      }
      
      public function Scale(param1:Number) : void
      {
         this.x *= param1;
         this.y *= param1;
      }
      
      public function GetAdd(param1:Vec2) : Vec2
      {
         var _loc2_:Vec2 = new Vec2();
         _loc2_.x = this.x + param1.x;
         _loc2_.y = this.y + param1.y;
         return _loc2_;
      }
      
      public function Normalize() : void
      {
         var _loc1_:Number = 1 / Math.sqrt(this.InnerProduct(this));
         this.x *= _loc1_;
         this.y *= _loc1_;
      }
      
      public function GetSubtract(param1:Vec2) : Vec2
      {
         var _loc2_:Vec2 = new Vec2();
         _loc2_.x = this.x - param1.x;
         _loc2_.y = this.y - param1.y;
         return _loc2_;
      }
      
      public function Subtract(param1:Vec2) : void
      {
         this.x -= param1.x;
         this.y -= param1.y;
      }
      
      public function GetScale(param1:Number) : Vec2
      {
         var _loc2_:Vec2 = new Vec2();
         _loc2_.x = this.x * param1;
         _loc2_.y = this.y * param1;
         return _loc2_;
      }
      
      public function GetNormal() : Vec2
      {
         var _loc1_:Vec2 = new Vec2();
         var _loc2_:Number = 1 / Math.sqrt(this.InnerProduct(this));
         _loc1_.x = this.x * _loc2_;
         _loc1_.y = this.y * _loc2_;
         return _loc1_;
      }
   }
}

