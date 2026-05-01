package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class PoiceDataMgr extends MovieClip
   {
      
      private var m_loader:URLLoader;
      
      private var m_xml:XML;
      
      private var m_aSeedData:Array;
      
      private var m_aTex:Array;
      
      public function PoiceDataMgr()
      {
         super();
         comDefine.DebugPrint("PoiceDataMgr load  " + comDefine.g_Dir + "poice_tex/poice_list.xml");
         this.m_loader = new URLLoader();
         var _loc1_:URLRequest = new URLRequest(comDefine.g_Dir + "poice_tex/poice_list.xml");
         this.m_aSeedData = new Array();
         this.m_loader.addEventListener(Event.COMPLETE,this._completeLoad);
         this.m_loader.load(_loc1_);
         this.m_xml = null;
      }
      
      public function getPoiceData(param1:int) : Array
      {
         return this.m_aSeedData[param1];
      }
      
      public function nowLoading() : int
      {
         var _loc2_:LoadSwfMovieClip = null;
         if(this.m_aSeedData.length == 0)
         {
            return 0;
         }
         var _loc1_:int = 0;
         for each(_loc2_ in this.m_aTex)
         {
            if(_loc2_.m_lpMovieClip != null)
            {
               _loc1_++;
            }
         }
         return _loc1_ / this.m_aTex.length * 50;
      }
      
      private function _loadPoiceData(param1:Object) : Array
      {
         var attributeName:String = null;
         var poiceName:String = null;
         var poiceNode:XMLList = null;
         var poiceData:PoiceData = null;
         var xmlNode:Object = param1;
         var aPoiceData:Array = new Array();
         var i:int = 1;
         while(i <= 3)
         {
            attributeName = "tex_id0" + i.toString();
            poiceName = xmlNode.attribute(attributeName);
            poiceNode = this.m_xml.tex_list.children().(@name == poiceName);
            poiceData = new PoiceData(i,poiceNode.attribute("file"));
            poiceData.type = poiceNode.attribute("type");
            poiceData.fric_top = poiceNode.attribute("fric_top");
            poiceData.fric_side = poiceNode.attribute("fric_side");
            poiceData.mag = poiceNode.attribute("mag");
            poiceData.fric_top *= 0.00001;
            poiceData.fric_side *= 0.00001;
            poiceData.mag *= 0.1;
            this.m_aTex.push(poiceData.LoadTexture());
            aPoiceData.push(poiceData);
            i++;
         }
         return aPoiceData;
      }
      
      private function _loadData() : void
      {
         var _loc1_:Object = null;
         var _loc2_:int = 0;
         var _loc3_:* = undefined;
         this.m_aTex = new Array();
         for each(_loc1_ in this.m_xml.poice_list.children())
         {
            _loc2_ = int(_loc1_.attribute("no"));
            _loc3_ = this._loadPoiceData(_loc1_);
            this.m_aSeedData[_loc2_ - 1] = _loc3_;
         }
      }
      
      public function isLoad() : Boolean
      {
         var _loc2_:LoadSwfMovieClip = null;
         var _loc1_:* = this.m_xml != null;
         for each(_loc2_ in this.m_aTex)
         {
            if(_loc2_.m_lpMovieClip == null)
            {
               return false;
            }
         }
         return _loc1_;
      }
      
      private function _completeLoad(param1:Event) : void
      {
         comDefine.DebugPrint("load xml " + this.m_loader.data);
         this.m_xml = XML(this.m_loader.data);
         comDefine.DebugPrint("load xml " + this.m_xml);
         this._loadData();
         this.m_loader.removeEventListener(Event.COMPLETE,this._completeLoad);
      }
   }
}

