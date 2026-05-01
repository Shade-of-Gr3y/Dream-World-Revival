package
{
   public class SwfImageMgr
   {
      
      private static var m_lpInstance:SwfImageMgr = null;
      
      private var m_imageArray:Array = new Array();
      
      public function SwfImageMgr()
      {
         super();
      }
      
      public static function GetInstance() : SwfImageMgr
      {
         if(m_lpInstance == null)
         {
            m_lpInstance = new SwfImageMgr();
         }
         return m_lpInstance;
      }
      
      public function destroyImage(param1:String) : void
      {
         var _loc2_:SwfImage = this.getImage(param1);
         if(_loc2_ != null)
         {
            this._destroy(_loc2_);
         }
      }
      
      public function getImage(param1:String) : SwfImage
      {
         var _loc2_:int = 0;
         var _loc3_:SwfImage = null;
         _loc2_ = 0;
         while(_loc2_ < this.m_imageArray.length)
         {
            _loc3_ = SwfImage(this.m_imageArray[_loc2_]);
            if(_loc3_ != null)
            {
               if(_loc3_.m_filename == param1)
               {
                  return _loc3_;
               }
            }
            _loc2_++;
         }
         return null;
      }
      
      private function _destroy(param1:SwfImage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:SwfImage = null;
         _loc2_ = 0;
         while(_loc2_ < this.m_imageArray.length)
         {
            _loc3_ = SwfImage(this.m_imageArray[_loc2_]);
            if(_loc3_ == param1)
            {
               this.m_imageArray.splice(_loc2_,1);
               break;
            }
            _loc2_++;
         }
      }
      
      public function createImage(param1:String, param2:* = false) : SwfImage
      {
         var _loc3_:SwfImage = null;
         if(param2 == false)
         {
            _loc3_ = this.getImage(param1);
         }
         if(_loc3_ == null)
         {
            _loc3_ = new SwfImage(param1);
         }
         this.m_imageArray.push(_loc3_);
         return _loc3_;
      }
   }
}

