package bfp.pgl.campaign
{
   import bfp.common.CustomEvent;
   import bfp.common.PokemonBridge;
   import bfp.pgl.common.CampaignBridge;
   import caurina.transitions.Tweener;
   import flash.display.MovieClip;
   
   public class CampaignScene
   {
      
      private var _container:MovieClip;
      
      private var _digest:CampaignDigest;
      
      private var _json:Object;
      
      private var _back:MovieClip;
      
      private var _detail:CampaignDetail;
      
      private var _game:CampaignGame;
      
      private var _page:String;
      
      public function CampaignScene(param1:MovieClip)
      {
         super();
         this._container = param1;
         this._container.visible = false;
         this._digest = new CampaignDigest(this._container.digest);
         this._detail = new CampaignDetail(this._container.detail);
         this._game = new CampaignGame(this._container.game);
         this._back = this._container.back;
      }
      
      public function open() : void
      {
         var _loc1_:Number = NaN;
         this._container.visible = true;
         this._back.alpha = 0;
         Tweener.addTween(this._back,{
            "alpha":1,
            "time":0.25,
            "transition":"linear"
         });
         CampaignBridge.addEventListener(CampaignBridge.CAMPAIGN_CHANGE,this.eventHandler);
         if(PokemonBridge.shortcut_campaign)
         {
            _loc1_ = PokemonBridge.shortcut_campaign;
            PokemonBridge.shortcut_campaign = undefined;
            CampaignBridge.change(CampaignBridge.CAMPAIGN_DETAIL,_loc1_);
         }
         else
         {
            CampaignBridge.change(CampaignBridge.CAMPAIGN_LIST);
         }
      }
      
      private function eventHandler(param1:CustomEvent) : void
      {
         switch(this._page)
         {
            case CampaignBridge.CAMPAIGN_LIST:
               this._digest.close();
               break;
            case CampaignBridge.CAMPAIGN_DETAIL:
               this._detail.close();
               break;
            case CampaignBridge.CAMPAIGN_CLEAR:
            case CampaignBridge.CAMPAIGN_GAME:
               this._game.close();
         }
         switch(CampaignBridge.page)
         {
            case CampaignBridge.CAMPAIGN_GAME:
               this._game.open(param1.data);
               break;
            case CampaignBridge.CAMPAIGN_DETAIL:
               this._detail.open(Number(param1.data));
               break;
            case CampaignBridge.CAMPAIGN_LIST:
               this._digest.open();
         }
         this._page = CampaignBridge.page;
      }
   }
}

