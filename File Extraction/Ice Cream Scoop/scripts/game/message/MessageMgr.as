package game.message
{
   import flash.display.MovieClip;
   
   public class MessageMgr
   {
      
      public static const ID_OK:int = 1;
      
      public static const ID_CANCEL:int = 2;
      
      public static const ID_PROMISE_LOOK:int = 3;
      
      public static const ID_PROMISE_START:int = 4;
      
      public static const ID_STATUS_TIMENAME:int = 5;
      
      public static const ID_HEIGHTNAME:int = 6;
      
      public static const ID_NUM0:int = 7;
      
      public static const ID_NUM00:int = 8;
      
      public static const ID_CM:int = 9;
      
      public static const ID_EATNAME:int = 10;
      
      public static const ID_X:int = 11;
      
      public static const ID_NUM_KO:int = 12;
      
      public static const ID_NUM_KOS:int = 13;
      
      public static const ID_COLORNAME:int = 14;
      
      public static const ID_STATUS_POKE_ME_NAME:int = 15;
      
      public static const ID_STATUS_POKE_YOU_NAME:int = 16;
      
      public static const ID_STATUS_AUTO:int = 17;
      
      public static const ID_RESULT_TITLE:int = 18;
      
      public static const ID_RESULT_TOTALNAME:int = 19;
      
      public static const ID_RESULY_POINT:int = 20;
      
      public static const ID_RESULT_MAG:int = 21;
      
      public static const ID_END_MESSAGE:int = 22;
      
      public static const ID_EXIT_MESSAGE_TOP:int = 23;
      
      public static const ID_EXIT_MESSAGE_END:int = 24;
      
      public static const ID_SEED_SELECT:int = 25;
      
      public static const ID_HELP_TITLE:int = 26;
      
      public static const ID_HELP_MES0:int = 27;
      
      public static const ID_HELP_MES2:int = 28;
      
      public static const ID_HELP_MES3:int = 29;
      
      public static const ID_HELP_MES4:int = 30;
      
      public static const ID_HELP_MES5:int = 31;
      
      public static const ID_HELP_MES6:int = 32;
      
      public static const ID_LIKE_SIZE_TITLE:int = 33;
      
      public static const ID_LIKE_SIZE_WINDOW:int = 34;
      
      public static const ID_BARREL_TIME:int = 35;
      
      public static const ID_BARREL_FRIC:int = 36;
      
      public static const ID_GUIDE_SELECT:int = 37;
      
      public static const ID_GUIDE_BUTTON:int = 38;
      
      public static const ID_GUIDE_MOVE:int = 39;
      
      public static const ID_GUIDE_DOWN:int = 40;
      
      public static const ID_ERROR:int = 41;
      
      public static const ID_RETURN:int = 42;
      
      public static const ID_EXITGAME:int = 43;
      
      public static const ID_CLEAR_LINE:int = 44;
      
      public static const ID_USE_ICESEED:int = 45;
      
      public static const ID_LOADING:int = 46;
      
      public static const ID_SLASH:int = 47;
      
      public static const ID_DOT:int = 48;
      
      private static var _inscance:MessageMgr = null;
      
      internal var _aMsgData_fra:Array = [{
         "id":ID_OK,
         "msg":"OUI"
      },{
         "id":ID_CANCEL,
         "msg":"NON"
      },{
         "id":ID_PROMISE_LOOK,
         "msg":"INSTRUCTIONS"
      },{
         "id":ID_PROMISE_START,
         "msg":"COMMENCER"
      },{
         "id":ID_STATUS_TIMENAME,
         "msg":"TEMPS RESTANT"
      },{
         "id":ID_HEIGHTNAME,
         "msg":"HAUTEUR"
      },{
         "id":ID_CM,
         "msg":"cm"
      },{
         "id":ID_NUM_KO,
         "msg":"Boule"
      },{
         "id":ID_NUM_KOS,
         "msg":"Boules"
      },{
         "id":ID_COLORNAME,
         "msg":"Variété"
      },{
         "id":ID_STATUS_POKE_ME_NAME,
         "msg":"VOUS"
      },{
         "id":ID_STATUS_POKE_YOU_NAME,
         "msg":""
      },{
         "id":ID_RESULT_TITLE,
         "msg":"RÉSULTAT"
      },{
         "id":ID_RESULT_TOTALNAME,
         "msg":"TOTAL"
      },{
         "id":ID_RESULY_POINT,
         "msg":"POINTS"
      },{
         "id":ID_RESULT_MAG,
         "msg":"×"
      },{
         "id":ID_END_MESSAGE,
         "msg":"FINI !"
      },{
         "id":ID_EXIT_MESSAGE_TOP,
         "msg":"Voulez-vous quitter ?\n" + "Si vous quittez maintenant, vous perdrez l\'occasion d\'être apprécié par le"
      },{
         "id":ID_HELP_TITLE,
         "msg":"INSTRUCTIONS"
      },{
         "id":ID_HELP_MES0,
         "msg":"Créons une belle coupe de sorbet !"
      },{
         "id":ID_HELP_MES2,
         "msg":"1. Laissez appuyé le bouton gauche de la souris sur la réserve de sorbet pour faire une plus grosse boule."
      },{
         "id":ID_HELP_MES3,
         "msg":"2. Gardez le bouton appuyé pour déplacer la boule."
      },{
         "id":ID_HELP_MES4,
         "msg":"3. Lachez le bouton pour placer la boule où vous voulez."
      },{
         "id":ID_HELP_MES5,
         "msg":"4. Empilez les boules de sorbet jusqu\'à la fin du temps imparti !"
      },{
         "id":ID_HELP_MES6,
         "msg":"Vous gagnez plus de points si vous utilisez également les trois types de sorbet, et si vous mettez des boules d\'une taille que le Pokémon arrive à manger facilement."
      },{
         "id":ID_LIKE_SIZE_TITLE,
         "msg":"Taille Préférée"
      },{
         "id":ID_BARREL_TIME,
         "msg":"Onctuosité"
      },{
         "id":ID_BARREL_FRIC,
         "msg":"Adhérence"
      },{
         "id":ID_GUIDE_SELECT,
         "msg":"Choisissez un sorbet"
      },{
         "id":ID_GUIDE_BUTTON,
         "msg":"En restant appuyé, la boule grossit"
      },{
         "id":ID_GUIDE_MOVE,
         "msg":"Déplacez-la en restant appuyé sur le bouton"
      },{
         "id":ID_GUIDE_DOWN,
         "msg":"Posez-la en lâchant le bouton"
      },{
         "id":ID_ERROR,
         "msg":"Vous ne pouvez pas jouer, parce que vous n\'avez pas de Baie. Allez en chercher une !"
      },{
         "id":ID_RETURN,
         "msg":"REVENIR"
      },{
         "id":ID_EXITGAME,
         "msg":"ARRÊTER DE JOUER"
      },{
         "id":ID_CLEAR_LINE,
         "msg":"MINIMUM REQUIS"
      },{
         "id":ID_USE_ICESEED,
         "msg":"CHOISISSEZ LA BAIE POUR PRÉPARER LES SORBETS"
      },{
         "id":ID_SEED_SELECT,
         "msg":"CETTE BAIE ?"
      },{
         "id":ID_EXIT_MESSAGE_END,
         "msg":"."
      },{
         "id":ID_NUM0,
         "msg":"0"
      },{
         "id":ID_NUM00,
         "msg":"00"
      },{
         "id":ID_X,
         "msg":"x"
      },{
         "id":ID_LOADING,
         "msg":"Chargement en cours..."
      },{
         "id":ID_SLASH,
         "msg":"/"
      },{
         "id":ID_DOT,
         "msg":"."
      }];
      
      internal var _aMsgData_ita:Array = [{
         "id":ID_OK,
         "msg":"OK"
      },{
         "id":ID_CANCEL,
         "msg":"No"
      },{
         "id":ID_PROMISE_LOOK,
         "msg":"Istruzioni"
      },{
         "id":ID_PROMISE_START,
         "msg":"Via!"
      },{
         "id":ID_STATUS_TIMENAME,
         "msg":"Tempo"
      },{
         "id":ID_HEIGHTNAME,
         "msg":"Altezza"
      },{
         "id":ID_CM,
         "msg":"cm"
      },{
         "id":ID_NUM_KO,
         "msg":"Pall."
      },{
         "id":ID_NUM_KOS,
         "msg":"Pall."
      },{
         "id":ID_COLORNAME,
         "msg":"Tonalità"
      },{
         "id":ID_STATUS_POKE_ME_NAME,
         "msg":"Tu"
      },{
         "id":ID_STATUS_POKE_YOU_NAME,
         "msg":"Pokémon"
      },{
         "id":ID_RESULT_TITLE,
         "msg":"Risultato"
      },{
         "id":ID_RESULT_TOTALNAME,
         "msg":"Totale"
      },{
         "id":ID_RESULY_POINT,
         "msg":"P."
      },{
         "id":ID_RESULT_MAG,
         "msg":"×"
      },{
         "id":ID_END_MESSAGE,
         "msg":"Fine"
      },{
         "id":ID_EXIT_MESSAGE_TOP,
         "msg":"Vuoi interrompere il minigioco?\n" + "Se interrompi ora, non potrai\n" + "fare amicizia con "
      },{
         "id":ID_HELP_TITLE,
         "msg":"Istruzioni"
      },{
         "id":ID_HELP_MES0,
         "msg":"Il Gelataio!"
      },{
         "id":ID_HELP_MES2,
         "msg":"1. Punta il cursore sulla vaschetta.\n" + "Se tieni premuto il tasto del mouse,\n" + "la pallina aumenta di grandezza."
      },{
         "id":ID_HELP_MES3,
         "msg":"2. Sempre tenendo premuto,\n" + "sposta la pallina nella ciotola."
      },{
         "id":ID_HELP_MES4,
         "msg":"3. Rilascia il tasto del mouse \n" + "per scodellare il gelato."
      },{
         "id":ID_HELP_MES5,
         "msg":"4. Accumula gelato finché il tempo non scade."
      },{
         "id":ID_HELP_MES6,
         "msg":"Il tuo punteggio aumenta se fai\n" + "un gelato di tre gusti diversi ben\n" + "bilanciati, oppure di una misura\n" + "pratica per essere mangiato."
      },{
         "id":ID_LIKE_SIZE_TITLE,
         "msg":"Praticità"
      },{
         "id":ID_BARREL_TIME,
         "msg":"Prendibilità"
      },{
         "id":ID_BARREL_FRIC,
         "msg":"Adesività"
      },{
         "id":ID_GUIDE_SELECT,
         "msg":"Scegli un gusto."
      },{
         "id":ID_GUIDE_BUTTON,
         "msg":"Se tieni premuto il pulsante,\n" + "la pallina di gelato si ingrandisce."
      },{
         "id":ID_GUIDE_MOVE,
         "msg":"Sposta la pallina continuando\n" + "a tenere premuto il pulsante."
      },{
         "id":ID_GUIDE_DOWN,
         "msg":"Se rilasci il pulsante, puoi\n" + "scodellare il gelato."
      },{
         "id":ID_ERROR,
         "msg":"Non hai Bacche per giocare.\n" + "Vai a cercarne."
      },{
         "id":ID_RETURN,
         "msg":"Indietro"
      },{
         "id":ID_EXITGAME,
         "msg":"Interrompi"
      },{
         "id":ID_CLEAR_LINE,
         "msg":"Linea guida"
      },{
         "id":ID_USE_ICESEED,
         "msg":"Scegli una Bacca per fare il gelato."
      },{
         "id":ID_SEED_SELECT,
         "msg":"Va bene questa?"
      },{
         "id":ID_EXIT_MESSAGE_END,
         "msg":"."
      },{
         "id":ID_NUM0,
         "msg":"0"
      },{
         "id":ID_NUM00,
         "msg":"00"
      },{
         "id":ID_X,
         "msg":"x"
      },{
         "id":ID_LOADING,
         "msg":"Caricamento"
      },{
         "id":ID_SLASH,
         "msg":"/"
      },{
         "id":ID_DOT,
         "msg":"."
      }];
      
      internal var _aMsgData_eng:Array = [{
         "id":ID_OK,
         "msg":"Yes"
      },{
         "id":ID_CANCEL,
         "msg":"No"
      },{
         "id":ID_PROMISE_LOOK,
         "msg":"How to play"
      },{
         "id":ID_PROMISE_START,
         "msg":"Start"
      },{
         "id":ID_STATUS_TIMENAME,
         "msg":"Remaining time"
      },{
         "id":ID_HEIGHTNAME,
         "msg":"Height"
      },{
         "id":ID_CM,
         "msg":"in."
      },{
         "id":ID_NUM_KO,
         "msg":"scoop"
      },{
         "id":ID_NUM_KOS,
         "msg":"scoops"
      },{
         "id":ID_COLORNAME,
         "msg":"Flavors"
      },{
         "id":ID_STATUS_POKE_ME_NAME,
         "msg":"You"
      },{
         "id":ID_STATUS_POKE_YOU_NAME,
         "msg":"Pokémon"
      },{
         "id":ID_RESULT_TITLE,
         "msg":"Results"
      },{
         "id":ID_RESULT_TOTALNAME,
         "msg":"Total"
      },{
         "id":ID_RESULY_POINT,
         "msg":"pts."
      },{
         "id":ID_RESULT_MAG,
         "msg":"×"
      },{
         "id":ID_END_MESSAGE,
         "msg":"End"
      },{
         "id":ID_EXIT_MESSAGE_TOP,
         "msg":"Do you want to quit this game?\n" + "If you quit, you can\'t befriend"
      },{
         "id":ID_HELP_TITLE,
         "msg":"How to play"
      },{
         "id":ID_HELP_MES0,
         "msg":"Pile ice cream!"
      },{
         "id":ID_HELP_MES2,
         "msg":"1. If you keep holding down the mouse button\n" + "on one of the ice cream trays,\n" + "the scoop will get bigger."
      },{
         "id":ID_HELP_MES3,
         "msg":"2. Move the ice cream\n" + "while holding down the mouse button."
      },{
         "id":ID_HELP_MES4,
         "msg":"3. Release the mouse button\n" + "to pile up the ice cream."
      },{
         "id":ID_HELP_MES5,
         "msg":"4. Pile the ice cream until the time is up."
      },{
         "id":ID_HELP_MES6,
         "msg":"If you balance three kinds\n" + "of ice cream, or if you make\n" + "bite-size scoops,\n" + "your score will go up."
      },{
         "id":ID_LIKE_SIZE_TITLE,
         "msg":"Bite-size"
      },{
         "id":ID_BARREL_TIME,
         "msg":"Easy to scoop"
      },{
         "id":ID_BARREL_FRIC,
         "msg":"Stickiness"
      },{
         "id":ID_GUIDE_SELECT,
         "msg":"Choose ice cream."
      },{
         "id":ID_GUIDE_BUTTON,
         "msg":"If you keep holding down the button,\n" + "the scoop will be bigger."
      },{
         "id":ID_GUIDE_MOVE,
         "msg":"Move the ice cream\n" + "while holding down the button."
      },{
         "id":ID_GUIDE_DOWN,
         "msg":"Release the button to\n" + "pile up the ice cream."
      },{
         "id":ID_ERROR,
         "msg":"You can\'t play without a Berry.\n" + "Please find a Berry."
      },{
         "id":ID_RETURN,
         "msg":"Back"
      },{
         "id":ID_EXITGAME,
         "msg":"Quit game."
      },{
         "id":ID_CLEAR_LINE,
         "msg":"Target line"
      },{
         "id":ID_USE_ICESEED,
         "msg":"Choose a Berry for ice cream."
      },{
         "id":ID_SEED_SELECT,
         "msg":"Is this OK?"
      },{
         "id":ID_EXIT_MESSAGE_END,
         "msg":"."
      },{
         "id":ID_NUM0,
         "msg":"0"
      },{
         "id":ID_NUM00,
         "msg":"00"
      },{
         "id":ID_X,
         "msg":"x"
      },{
         "id":ID_LOADING,
         "msg":"Loading…"
      },{
         "id":ID_SLASH,
         "msg":"/"
      },{
         "id":ID_DOT,
         "msg":"."
      }];
      
      internal var _aMessage:Array;
      
      internal var _aMsgData_spa:Array = [{
         "id":ID_OK,
         "msg":"Sí"
      },{
         "id":ID_CANCEL,
         "msg":"No"
      },{
         "id":ID_PROMISE_LOOK,
         "msg":"Cómo se juega"
      },{
         "id":ID_PROMISE_START,
         "msg":"Empezar"
      },{
         "id":ID_STATUS_TIMENAME,
         "msg":"Tiempo restante"
      },{
         "id":ID_HEIGHTNAME,
         "msg":"Altura"
      },{
         "id":ID_CM,
         "msg":"cm"
      },{
         "id":ID_NUM_KO,
         "msg":"bola"
      },{
         "id":ID_NUM_KOS,
         "msg":"bolas"
      },{
         "id":ID_COLORNAME,
         "msg":"Sabores"
      },{
         "id":ID_STATUS_POKE_ME_NAME,
         "msg":"Tú"
      },{
         "id":ID_STATUS_POKE_YOU_NAME,
         "msg":"Pokémon"
      },{
         "id":ID_RESULT_TITLE,
         "msg":"Resultados"
      },{
         "id":ID_RESULT_TOTALNAME,
         "msg":"Total"
      },{
         "id":ID_RESULY_POINT,
         "msg":"puntos"
      },{
         "id":ID_RESULT_MAG,
         "msg":"×"
      },{
         "id":ID_END_MESSAGE,
         "msg":"Fin del juego"
      },{
         "id":ID_EXIT_MESSAGE_TOP,
         "msg":"¿Quieres finalizar este juego?\n" + "Ten presente que, si sales de este juego, no podrás hacerte amigo de \n" + ""
      },{
         "id":ID_HELP_TITLE,
         "msg":"Cómo se juega"
      },{
         "id":ID_HELP_MES0,
         "msg":"¡Apila bolas de helado!"
      },{
         "id":ID_HELP_MES2,
         "msg":"\n" + "1. Si dejas pulsado el botón del ratón sobre el bol de helado, las bolas de helado crecerán."
      },{
         "id":ID_HELP_MES3,
         "msg":"2. Mueve tu bola de helado con el botón del ratón pulsado."
      },{
         "id":ID_HELP_MES4,
         "msg":"3. Podrás apilar tus bolas de helado al soltar el botón del ratón."
      },{
         "id":ID_HELP_MES5,
         "msg":"4. Apila todas las bolas de helado que puedas antes de que se acabe el tiempo."
      },{
         "id":ID_HELP_MES6,
         "msg":"Tu puntuación aumentará cuando logres apilar  tres  clases  de  helado  diferentes  en equilibrio  y cuando hagas bolas de helado del tamaño recomendado."
      },{
         "id":ID_LIKE_SIZE_TITLE,
         "msg":"Tamaño recomendado"
      },{
         "id":ID_BARREL_TIME,
         "msg":"Fácil de hacer"
      },{
         "id":ID_BARREL_FRIC,
         "msg":"Adherencia"
      },{
         "id":ID_GUIDE_SELECT,
         "msg":"Elige el helado."
      },{
         "id":ID_GUIDE_BUTTON,
         "msg":"Si dejas el botón del ratón pulsado, ¡la bola de helado aumentará en tamaño!"
      },{
         "id":ID_GUIDE_MOVE,
         "msg":"Mueve el helado manteniendo pulsado el botón de tu ratón."
      },{
         "id":ID_GUIDE_DOWN,
         "msg":"Podrás apilar tus bolas de helado cuando sueltes el botón de tu ratón."
      },{
         "id":ID_ERROR,
         "msg":"No tienes Bayas suficientes, así que no puedes jugar. ¡Vete a buscar Bayas!"
      },{
         "id":ID_RETURN,
         "msg":"Volver"
      },{
         "id":ID_EXITGAME,
         "msg":"Salir del juego"
      },{
         "id":ID_CLEAR_LINE,
         "msg":"Altura superada"
      },{
         "id":ID_USE_ICESEED,
         "msg":"Selecciona una Baya para hacer helado"
      },{
         "id":ID_SEED_SELECT,
         "msg":"¿Estás de acuerdo?"
      },{
         "id":ID_EXIT_MESSAGE_END,
         "msg":"."
      },{
         "id":ID_NUM0,
         "msg":"0"
      },{
         "id":ID_NUM00,
         "msg":"00"
      },{
         "id":ID_X,
         "msg":"x"
      },{
         "id":ID_LOADING,
         "msg":"Cargando"
      },{
         "id":ID_SLASH,
         "msg":"/"
      },{
         "id":ID_DOT,
         "msg":"."
      }];
      
      internal var _aMsgData_kor:Array = [{
         "id":ID_OK,
         "msg":"예"
      },{
         "id":ID_CANCEL,
         "msg":"아니오"
      },{
         "id":ID_PROMISE_LOOK,
         "msg":"즐기는 방법 보기"
      },{
         "id":ID_PROMISE_START,
         "msg":"스타트"
      },{
         "id":ID_STATUS_TIMENAME,
         "msg":"남은 시간"
      },{
         "id":ID_HEIGHTNAME,
         "msg":"높이"
      },{
         "id":ID_CM,
         "msg":"cm"
      },{
         "id":ID_NUM_KO,
         "msg":"개"
      },{
         "id":ID_NUM_KOS,
         "msg":"개"
      },{
         "id":ID_COLORNAME,
         "msg":"색조합"
      },{
         "id":ID_STATUS_POKE_ME_NAME,
         "msg":"너"
      },{
         "id":ID_STATUS_POKE_YOU_NAME,
         "msg":"포켓몬"
      },{
         "id":ID_RESULT_TITLE,
         "msg":"결과발표"
      },{
         "id":ID_RESULT_TOTALNAME,
         "msg":"합계"
      },{
         "id":ID_RESULY_POINT,
         "msg":"점"
      },{
         "id":ID_RESULT_MAG,
         "msg":"배"
      },{
         "id":ID_END_MESSAGE,
         "msg":"종료"
      },{
         "id":ID_EXIT_MESSAGE_TOP,
         "msg":"이 게임을 종료하겠습니까?\n" + "종료할 경우"
      },{
         "id":ID_HELP_TITLE,
         "msg":"즐기는 방법"
      },{
         "id":ID_HELP_MES0,
         "msg":"아이스크림을 담자!"
      },{
         "id":ID_HELP_MES2,
         "msg":"1.아이스크림 케이스 위에서\n" + " 마우스 버튼을 누르고 있으면\n" + " 아이스크림이 커집니다"
      },{
         "id":ID_HELP_MES3,
         "msg":"2.마우스 버튼을 누른 채로\n" + " 아이스크림을 옮깁니다"
      },{
         "id":ID_HELP_MES4,
         "msg":"3.마우스 버튼을 떼면\n" + " 아이스크림을 담습니다"
      },{
         "id":ID_HELP_MES5,
         "msg":"4.시간이 끝날 때까지 아이스크림을 담자"
      },{
         "id":ID_HELP_MES6,
         "msg":"3종류의 아이스크림을\n" + "균형을 맞추어 담거나\n" + "먹기 좋은 크기의\n" + "아이스크림을 만들면\n" + "점수가 올라가"
      },{
         "id":ID_LIKE_SIZE_TITLE,
         "msg":"먹기 좋은 크기"
      },{
         "id":ID_BARREL_TIME,
         "msg":"퍼지는 정도"
      },{
         "id":ID_BARREL_FRIC,
         "msg":"붙는 정도"
      },{
         "id":ID_GUIDE_SELECT,
         "msg":"아이스크림을 고르자"
      },{
         "id":ID_GUIDE_BUTTON,
         "msg":"버튼을 누르고 있으면\n" + "아이스크림이 커져"
      },{
         "id":ID_GUIDE_MOVE,
         "msg":"버튼을 누른 채로\n" + "아이스크림을 옮기자"
      },{
         "id":ID_GUIDE_DOWN,
         "msg":"버튼을 떼면\n" + "아이스크림을 담게 돼"
      },{
         "id":ID_ERROR,
         "msg":"나무열매가 없어서 즐길 수 없어\n" + "나무열매를 가지고 와줘"
      },{
         "id":ID_RETURN,
         "msg":"돌아가기"
      },{
         "id":ID_EXITGAME,
         "msg":"게임을 그만두기"
      },{
         "id":ID_CLEAR_LINE,
         "msg":"클리어 라인"
      },{
         "id":ID_USE_ICESEED,
         "msg":"아이스크림에 사용할 나무열매를 고르자"
      },{
         "id":ID_SEED_SELECT,
         "msg":"이것으로 결정할래?"
      },{
         "id":ID_EXIT_MESSAGE_END,
         "msg":"와(과)\n" + "사이가 좋아질 수 없습니다."
      },{
         "id":ID_NUM0,
         "msg":"0"
      },{
         "id":ID_NUM00,
         "msg":"00"
      },{
         "id":ID_X,
         "msg":"x"
      },{
         "id":ID_LOADING,
         "msg":"로딩"
      },{
         "id":ID_SLASH,
         "msg":"/"
      },{
         "id":ID_DOT,
         "msg":"."
      }];
      
      internal var _aMsgData_gen:Array = [{
         "id":ID_OK,
         "msg":"O.K."
      },{
         "id":ID_CANCEL,
         "msg":"Nein"
      },{
         "id":ID_PROMISE_LOOK,
         "msg":"Spielanleitung"
      },{
         "id":ID_PROMISE_START,
         "msg":"Start"
      },{
         "id":ID_STATUS_TIMENAME,
         "msg":"Restzeit"
      },{
         "id":ID_HEIGHTNAME,
         "msg":"Höhe"
      },{
         "id":ID_CM,
         "msg":"cm"
      },{
         "id":ID_NUM_KO,
         "msg":"Kugel"
      },{
         "id":ID_NUM_KOS,
         "msg":"Kugeln"
      },{
         "id":ID_COLORNAME,
         "msg":"Zusammenstellung"
      },{
         "id":ID_STATUS_POKE_ME_NAME,
         "msg":"Du"
      },{
         "id":ID_STATUS_POKE_YOU_NAME,
         "msg":"Pokémon"
      },{
         "id":ID_RESULT_TITLE,
         "msg":"Ergebnis"
      },{
         "id":ID_RESULT_TOTALNAME,
         "msg":"Insgesamt"
      },{
         "id":ID_RESULY_POINT,
         "msg":"Punkte"
      },{
         "id":ID_RESULT_MAG,
         "msg":"×"
      },{
         "id":ID_END_MESSAGE,
         "msg":"Fertig!"
      },{
         "id":ID_EXIT_MESSAGE_TOP,
         "msg":"Möchtest du das Spiel beenden?\n" + "Beendest du das Spiel jetzt,\n" + "kannst du dich nicht mit"
      },{
         "id":ID_HELP_TITLE,
         "msg":"Spielanleitung"
      },{
         "id":ID_HELP_MES0,
         "msg":"Lass uns ein tolles Eis zaubern!"
      },{
         "id":ID_HELP_MES2,
         "msg":"1. Je länger du die linke Maustaste über\n" + "einem der Eisbehälter gedrückt hältst,\n" + "desto größer wird die Eiskugel."
      },{
         "id":ID_HELP_MES3,
         "msg":"2. Halte die Maustaste weiterhin gedrückt, während du die Eiskugel aufnimmst."
      },{
         "id":ID_HELP_MES4,
         "msg":"3. Die Eiskugel wird platziert, sobald du die Maustaste loslässt."
      },{
         "id":ID_HELP_MES5,
         "msg":"4. Türme die Eiskugeln auf,\n" + "solang die Zeit reicht."
      },{
         "id":ID_HELP_MES6,
         "msg":"Du erhältst mehr Punkte, wenn du die\n" + "drei Eissorten im richtigen Verhältnis\n" + "zueinander einsetzt und letztlich ein\n" + "Eis in mundgerechter Größe herstellst."
      },{
         "id":ID_LIKE_SIZE_TITLE,
         "msg":"Mundgerechte Größe"
      },{
         "id":ID_BARREL_TIME,
         "msg":"Cremigkeit"
      },{
         "id":ID_BARREL_FRIC,
         "msg":"Klebefestigkeit"
      },{
         "id":ID_GUIDE_SELECT,
         "msg":"Wähle eine Eissorte!"
      },{
         "id":ID_GUIDE_BUTTON,
         "msg":"Solang du die Maustaste gedrückt hältst,\n" + "nimmt die Eiskugel an Größe zu!"
      },{
         "id":ID_GUIDE_MOVE,
         "msg":"Nimm die Eiskugel mit gedrückter\n" + "Maustaste auf!"
      },{
         "id":ID_GUIDE_DOWN,
         "msg":"Lass die Maustaste los, um die Eiskugel zu platzieren!"
      },{
         "id":ID_ERROR,
         "msg":"Ohne Beeren kannst du nicht spielen. Komm wieder, wenn du eine Beere gefunden hast."
      },{
         "id":ID_RETURN,
         "msg":"Zurück"
      },{
         "id":ID_EXITGAME,
         "msg":"Spiel beenden"
      },{
         "id":ID_CLEAR_LINE,
         "msg":"Mindesthöhe"
      },{
         "id":ID_USE_ICESEED,
         "msg":"Wähle eine Beere für das Eis"
      },{
         "id":ID_SEED_SELECT,
         "msg":"Diese Beere wählen?"
      },{
         "id":ID_EXIT_MESSAGE_END,
         "msg":"anfreunden."
      },{
         "id":ID_NUM0,
         "msg":"0"
      },{
         "id":ID_NUM00,
         "msg":"00"
      },{
         "id":ID_X,
         "msg":"x"
      },{
         "id":ID_LOADING,
         "msg":"Lädt"
      },{
         "id":ID_SLASH,
         "msg":"/"
      },{
         "id":ID_DOT,
         "msg":"."
      }];
      
      internal var _aMsgDataJpn:Array = [{
         "id":ID_OK,
         "msg":"はい"
      },{
         "id":ID_CANCEL,
         "msg":"いいえ"
      },{
         "id":ID_PROMISE_LOOK,
         "msg":"あそびかたをみる"
      },{
         "id":ID_PROMISE_START,
         "msg":"スタート"
      },{
         "id":ID_STATUS_TIMENAME,
         "msg":"のこりじかん"
      },{
         "id":ID_HEIGHTNAME,
         "msg":"たかさ"
      },{
         "id":ID_NUM0,
         "msg":"0"
      },{
         "id":ID_NUM00,
         "msg":"00"
      },{
         "id":ID_CM,
         "msg":"cm"
      },{
         "id":ID_EATNAME,
         "msg":"たべやすいかず"
      },{
         "id":ID_X,
         "msg":"x"
      },{
         "id":ID_NUM_KO,
         "msg":"コ"
      },{
         "id":ID_NUM_KOS,
         "msg":"コ"
      },{
         "id":ID_COLORNAME,
         "msg":"いろあい"
      },{
         "id":ID_STATUS_POKE_ME_NAME,
         "msg":"キミ"
      },{
         "id":ID_STATUS_POKE_YOU_NAME,
         "msg":"ポケモン"
      },{
         "id":ID_STATUS_AUTO,
         "msg":"じどう"
      },{
         "id":ID_RESULT_TITLE,
         "msg":"けっかはっぴょう"
      },{
         "id":ID_RESULT_TOTALNAME,
         "msg":"ごうけい"
      },{
         "id":ID_RESULY_POINT,
         "msg":"てん"
      },{
         "id":ID_RESULT_MAG,
         "msg":"倍"
      },{
         "id":ID_END_MESSAGE,
         "msg":"しゅうりょう"
      },{
         "id":ID_EXIT_MESSAGE_TOP,
         "msg":"このゲームをしゅうりょうしますか？\n" + "しゅうりょうしたばあい、　"
      },{
         "id":ID_EXIT_MESSAGE_END,
         "msg":"と　\n" + "なかよくなることはできません。"
      },{
         "id":ID_SEED_SELECT,
         "msg":"これでいいかな？"
      },{
         "id":ID_HELP_TITLE,
         "msg":"あそびかた"
      },{
         "id":ID_HELP_MES0,
         "msg":"アイスをもりつけよう！"
      },{
         "id":ID_HELP_MES2,
         "msg":"1．アイスケースのうえで\n" + "　　マウスのボタンを　おしつづけると\n" + "　　アイスがおおきくなります"
      },{
         "id":ID_HELP_MES3,
         "msg":"2．マウスのボタンを　おしたままで\n" + "　　アイスをはこびます"
      },{
         "id":ID_HELP_MES4,
         "msg":"3．マウスのボタンを　はなすと\n" + "　　アイスをもりつけます"
      },{
         "id":ID_HELP_MES5,
         "msg":"4．じかんがくるまで　アイスをもりつけよう"
      },{
         "id":ID_HELP_MES6,
         "msg":"3しゅるいのアイスを\n" + "バランスよくもりつけたり\n" + "たべやすいおおきさの\n" + "アイスをつくると\n" + "とくてんが　あがるよ"
      },{
         "id":ID_LIKE_SIZE_TITLE,
         "msg":"たべやすいおおきさ"
      },{
         "id":ID_LIKE_SIZE_WINDOW,
         "msg":"たべやすい\n" + "おおきさ"
      },{
         "id":ID_BARREL_TIME,
         "msg":"すくいやすさ"
      },{
         "id":ID_BARREL_FRIC,
         "msg":"くっつきやすさ"
      },{
         "id":ID_GUIDE_SELECT,
         "msg":"アイスをえらぼう"
      },{
         "id":ID_GUIDE_BUTTON,
         "msg":"ボタンを おしつづけると\n" + "アイスが おおきくなるよ"
      },{
         "id":ID_GUIDE_MOVE,
         "msg":"ボタンをおしたまま\n" + "アイスをはこぼう"
      },{
         "id":ID_GUIDE_DOWN,
         "msg":"ボタンをはなすと\n" + "アイスをもりつけるよ"
      },{
         "id":ID_ERROR,
         "msg":"きのみがないので　あそべません\n" + "きのみを　さがしてきてね"
      },{
         "id":ID_RETURN,
         "msg":"もどる"
      },{
         "id":ID_EXITGAME,
         "msg":"ゲームをやめる"
      },{
         "id":ID_CLEAR_LINE,
         "msg":"クリアーライン"
      },{
         "id":ID_USE_ICESEED,
         "msg":"アイスにつかう きのみをえらぼう"
      },{
         "id":ID_LOADING,
         "msg":"ローディング"
      },{
         "id":ID_SLASH,
         "msg":"/"
      },{
         "id":ID_DOT,
         "msg":"."
      }];
      
      public function MessageMgr(param1:Blocker)
      {
         super();
      }
      
      public static function getInstance() : MessageMgr
      {
         if(!_inscance)
         {
            _inscance = new MessageMgr(new Blocker());
         }
         return _inscance;
      }
      
      public static function visibleMessageMc(param1:MovieClip) : *
      {
         var _loc3_:MovieClip = null;
         var _loc2_:* = 0;
         while(_loc2_ < param1.numChildren)
         {
            _loc3_ = param1.getChildAt(_loc2_) as MovieClip;
            _loc3_.visible = false;
            _loc2_++;
         }
         switch(comDefine.nLanguage)
         {
            case "ja":
               param1.jpnMc.visible = true;
               break;
            case "en":
               param1.engMc.visible = true;
               break;
            case "fr":
               param1.fraMc.visible = true;
               break;
            case "de":
               param1.gerMc.visible = true;
               break;
            case "it":
               param1.itaMc.visible = true;
               break;
            case "es":
               param1.spaMc.visible = true;
               break;
            case "ko":
               param1.korMc.visible = true;
         }
      }
      
      public function finalize() : void
      {
         this._aMessage = null;
      }
      
      public function getMessage(param1:int) : String
      {
         return this._aMessage[param1];
      }
      
      public function initialize() : void
      {
         var _loc1_:Array = null;
         switch(comDefine.nLanguage)
         {
            case "ja":
               _loc1_ = this._aMsgDataJpn;
               break;
            case "en":
               _loc1_ = this._aMsgData_eng;
               break;
            case "fr":
               _loc1_ = this._aMsgData_fra;
               break;
            case "de":
               _loc1_ = this._aMsgData_gen;
               break;
            case "it":
               _loc1_ = this._aMsgData_ita;
               break;
            case "es":
               _loc1_ = this._aMsgData_spa;
               break;
            case "ko":
               _loc1_ = this._aMsgData_kor;
         }
         this._aMessage = [];
         var _loc2_:* = 0;
         while(_loc2_ < _loc1_.length)
         {
            this._aMessage[_loc1_[_loc2_].id] = _loc1_[_loc2_].msg;
            _loc2_++;
         }
      }
   }
}

class Blocker
{
   
   public function Blocker()
   {
      super();
   }
}
