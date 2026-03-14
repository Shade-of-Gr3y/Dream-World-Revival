package fl.managers
{
   import fl.controls.Button;
   import fl.core.UIComponent;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.SimpleButton;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.ui.Keyboard;
   import flash.utils.*;
   
   public class FocusManager implements IFocusManager
   {
      
      private var focusableObjects:Dictionary;
      
      private var _showFocusIndicator:Boolean = true;
      
      private var defButton:Button;
      
      private var focusableCandidates:Array;
      
      private var _form:DisplayObjectContainer;
      
      private var _defaultButtonEnabled:Boolean = true;
      
      private var activated:Boolean = false;
      
      private var _defaultButton:Button;
      
      private var calculateCandidates:Boolean = true;
      
      private var lastFocus:InteractiveObject;
      
      private var lastAction:String;
      
      public function FocusManager(param1:DisplayObjectContainer)
      {
         super();
         focusableObjects = new Dictionary(true);
         if(param1 != null)
         {
            _form = param1;
            addFocusables(DisplayObject(param1));
            param1.addEventListener(Event.ADDED,addedHandler);
            param1.addEventListener(Event.REMOVED,removedHandler);
            activate();
         }
      }
      
      public function get showFocusIndicator() : Boolean
      {
         return _showFocusIndicator;
      }
      
      private function getIndexOfNextObject(param1:int, param2:Boolean, param3:Boolean, param4:String) : int
      {
         var _loc7_:DisplayObject = null;
         var _loc8_:IFocusManagerGroup = null;
         var _loc9_:int = 0;
         var _loc10_:DisplayObject = null;
         var _loc11_:IFocusManagerGroup = null;
         var _loc5_:int = int(focusableCandidates.length);
         var _loc6_:int = param1;
         while(true)
         {
            if(param2)
            {
               param1--;
            }
            else
            {
               param1++;
            }
            if(param3)
            {
               if(param2 && param1 < 0)
               {
                  break;
               }
               if(!param2 && param1 == _loc5_)
               {
                  break;
               }
            }
            else
            {
               param1 = (param1 + _loc5_) % _loc5_;
               if(_loc6_ == param1)
               {
                  break;
               }
            }
            if(isValidFocusCandidate(focusableCandidates[param1],param4))
            {
               _loc7_ = DisplayObject(findFocusManagerComponent(focusableCandidates[param1]));
               if(_loc7_ is IFocusManagerGroup)
               {
                  _loc8_ = IFocusManagerGroup(_loc7_);
                  _loc9_ = 0;
                  while(_loc9_ < focusableCandidates.length)
                  {
                     _loc10_ = focusableCandidates[_loc9_];
                     if(_loc10_ is IFocusManagerGroup)
                     {
                        _loc11_ = IFocusManagerGroup(_loc10_);
                        if(_loc11_.groupName == _loc8_.groupName && _loc11_.selected)
                        {
                           param1 = _loc9_;
                           break;
                        }
                     }
                     _loc9_++;
                  }
               }
               return param1;
            }
         }
         return param1;
      }
      
      private function mouseFocusChangeHandler(param1:FocusEvent) : void
      {
         if(param1.relatedObject is TextField)
         {
            return;
         }
         param1.preventDefault();
      }
      
      public function set form(param1:DisplayObjectContainer) : void
      {
         _form = param1;
      }
      
      private function addFocusables(param1:DisplayObject, param2:Boolean = false) : void
      {
         var focusable:IFocusManagerComponent = null;
         var io:InteractiveObject = null;
         var doc:DisplayObjectContainer = null;
         var i:int = 0;
         var child:DisplayObject = null;
         var o:DisplayObject = param1;
         var skipTopLevel:Boolean = param2;
         if(!skipTopLevel)
         {
            if(o is IFocusManagerComponent)
            {
               focusable = IFocusManagerComponent(o);
               if(focusable.focusEnabled)
               {
                  if(focusable.tabEnabled && isTabVisible(o))
                  {
                     focusableObjects[o] = true;
                     calculateCandidates = true;
                  }
                  o.addEventListener(Event.TAB_ENABLED_CHANGE,tabEnabledChangeHandler);
                  o.addEventListener(Event.TAB_INDEX_CHANGE,tabIndexChangeHandler);
               }
            }
            else if(o is InteractiveObject)
            {
               io = o as InteractiveObject;
               if(io && io.tabEnabled && findFocusManagerComponent(io) == io)
               {
                  focusableObjects[io] = true;
                  calculateCandidates = true;
               }
               io.addEventListener(Event.TAB_ENABLED_CHANGE,tabEnabledChangeHandler);
               io.addEventListener(Event.TAB_INDEX_CHANGE,tabIndexChangeHandler);
            }
         }
         if(o is DisplayObjectContainer)
         {
            doc = DisplayObjectContainer(o);
            o.addEventListener(Event.TAB_CHILDREN_CHANGE,tabChildrenChangeHandler);
            if(doc is Stage || doc.parent is Stage || doc.tabChildren)
            {
               i = 0;
               while(i < doc.numChildren)
               {
                  try
                  {
                     child = doc.getChildAt(i);
                     if(child != null)
                     {
                        addFocusables(doc.getChildAt(i));
                     }
                  }
                  catch(error:SecurityError)
                  {
                  }
                  i++;
               }
            }
         }
      }
      
      private function getChildIndex(param1:DisplayObjectContainer, param2:DisplayObject) : int
      {
         return param1.getChildIndex(param2);
      }
      
      public function findFocusManagerComponent(param1:InteractiveObject) : InteractiveObject
      {
         var _loc2_:InteractiveObject = param1;
         while(param1)
         {
            if(param1 is IFocusManagerComponent && IFocusManagerComponent(param1).focusEnabled)
            {
               return param1;
            }
            param1 = param1.parent;
         }
         return _loc2_;
      }
      
      private function focusOutHandler(param1:FocusEvent) : void
      {
         var _loc2_:InteractiveObject = param1.target as InteractiveObject;
      }
      
      private function isValidFocusCandidate(param1:DisplayObject, param2:String) : Boolean
      {
         var _loc3_:IFocusManagerGroup = null;
         if(!isEnabledAndVisible(param1))
         {
            return false;
         }
         if(param1 is IFocusManagerGroup)
         {
            _loc3_ = IFocusManagerGroup(param1);
            if(param2 == _loc3_.groupName)
            {
               return false;
            }
         }
         return true;
      }
      
      private function setFocusToNextObject(param1:FocusEvent) : void
      {
         if(!hasFocusableObjects())
         {
            return;
         }
         var _loc2_:InteractiveObject = getNextFocusManagerComponent(param1.shiftKey);
         if(_loc2_)
         {
            setFocus(_loc2_);
         }
      }
      
      private function sortFocusableObjectsTabIndex() : void
      {
         var _loc1_:Object = null;
         var _loc2_:InteractiveObject = null;
         focusableCandidates = [];
         for(_loc1_ in focusableObjects)
         {
            _loc2_ = InteractiveObject(_loc1_);
            if(Boolean(_loc2_.tabIndex) && !isNaN(Number(_loc2_.tabIndex)))
            {
               focusableCandidates.push(_loc2_);
            }
         }
         focusableCandidates.sort(sortByTabIndex);
      }
      
      private function removeFocusables(param1:DisplayObject) : void
      {
         var _loc2_:Object = null;
         var _loc3_:DisplayObject = null;
         if(param1 is DisplayObjectContainer)
         {
            param1.removeEventListener(Event.TAB_CHILDREN_CHANGE,tabChildrenChangeHandler);
            param1.removeEventListener(Event.TAB_INDEX_CHANGE,tabIndexChangeHandler);
            for(_loc2_ in focusableObjects)
            {
               _loc3_ = DisplayObject(_loc2_);
               if(DisplayObjectContainer(param1).contains(_loc3_))
               {
                  if(_loc3_ == lastFocus)
                  {
                     lastFocus = null;
                  }
                  _loc3_.removeEventListener(Event.TAB_ENABLED_CHANGE,tabEnabledChangeHandler);
                  delete focusableObjects[_loc2_];
                  calculateCandidates = true;
               }
            }
         }
      }
      
      private function getTopLevelFocusTarget(param1:InteractiveObject) : InteractiveObject
      {
         while(param1 != InteractiveObject(form))
         {
            if(param1 is IFocusManagerComponent && IFocusManagerComponent(param1).focusEnabled && IFocusManagerComponent(param1).mouseFocusEnabled && UIComponent(param1).enabled)
            {
               return param1;
            }
            param1 = param1.parent;
            if(param1 == null)
            {
               break;
            }
         }
         return null;
      }
      
      public function sendDefaultButtonEvent() : void
      {
         defButton.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      private function addedHandler(param1:Event) : void
      {
         var _loc2_:DisplayObject = DisplayObject(param1.target);
         if(_loc2_.stage)
         {
            addFocusables(DisplayObject(param1.target));
         }
      }
      
      private function isEnabledAndVisible(param1:DisplayObject) : Boolean
      {
         var _loc3_:TextField = null;
         var _loc4_:SimpleButton = null;
         var _loc2_:DisplayObjectContainer = DisplayObject(form).parent;
         while(param1 != _loc2_)
         {
            if(param1 is UIComponent)
            {
               if(!UIComponent(param1).enabled)
               {
                  return false;
               }
            }
            else if(param1 is TextField)
            {
               _loc3_ = TextField(param1);
               if(_loc3_.type == TextFieldType.DYNAMIC || !_loc3_.selectable)
               {
                  return false;
               }
            }
            else if(param1 is SimpleButton)
            {
               _loc4_ = SimpleButton(param1);
               if(!_loc4_.enabled)
               {
                  return false;
               }
            }
            if(!param1.visible)
            {
               return false;
            }
            param1 = param1.parent;
         }
         return true;
      }
      
      private function tabChildrenChangeHandler(param1:Event) : void
      {
         if(param1.target != param1.currentTarget)
         {
            return;
         }
         calculateCandidates = true;
         var _loc2_:DisplayObjectContainer = DisplayObjectContainer(param1.target);
         if(_loc2_.tabChildren)
         {
            addFocusables(_loc2_,true);
         }
         else
         {
            removeFocusables(_loc2_);
         }
      }
      
      private function deactivateHandler(param1:Event) : void
      {
         var _loc2_:InteractiveObject = InteractiveObject(param1.target);
      }
      
      public function setFocus(param1:InteractiveObject) : void
      {
         if(param1 is IFocusManagerComponent)
         {
            IFocusManagerComponent(param1).setFocus();
         }
         else
         {
            form.stage.focus = param1;
         }
      }
      
      public function getFocus() : InteractiveObject
      {
         var _loc1_:InteractiveObject = form.stage.focus;
         return findFocusManagerComponent(_loc1_);
      }
      
      private function hasFocusableObjects() : Boolean
      {
         var _loc1_:Object = null;
         var _loc2_:int = 0;
         var _loc3_:* = focusableObjects;
         for(_loc1_ in _loc3_)
         {
            return true;
         }
         return false;
      }
      
      private function tabIndexChangeHandler(param1:Event) : void
      {
         calculateCandidates = true;
      }
      
      public function set defaultButton(param1:Button) : void
      {
         var _loc2_:Button = param1 ? Button(param1) : null;
         if(_loc2_ != _defaultButton)
         {
            if(_defaultButton)
            {
               _defaultButton.emphasized = false;
            }
            if(defButton)
            {
               defButton.emphasized = false;
            }
            _defaultButton = _loc2_;
            defButton = _loc2_;
            if(_loc2_)
            {
               _loc2_.emphasized = true;
            }
         }
      }
      
      private function sortFocusableObjects() : void
      {
         var _loc1_:Object = null;
         var _loc2_:InteractiveObject = null;
         focusableCandidates = [];
         for(_loc1_ in focusableObjects)
         {
            _loc2_ = InteractiveObject(_loc1_);
            if(_loc2_.tabIndex && !isNaN(Number(_loc2_.tabIndex)) && _loc2_.tabIndex > 0)
            {
               sortFocusableObjectsTabIndex();
               return;
            }
            focusableCandidates.push(_loc2_);
         }
         focusableCandidates.sort(sortByDepth);
      }
      
      private function keyFocusChangeHandler(param1:FocusEvent) : void
      {
         showFocusIndicator = true;
         if((param1.keyCode == Keyboard.TAB || param1.keyCode == 0) && !param1.isDefaultPrevented())
         {
            setFocusToNextObject(param1);
            param1.preventDefault();
         }
      }
      
      private function getIndexOfFocusedObject(param1:DisplayObject) : int
      {
         var _loc2_:int = int(focusableCandidates.length);
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(focusableCandidates[_loc3_] == param1)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function hideFocus() : void
      {
      }
      
      private function removedHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc4_:InteractiveObject = null;
         var _loc3_:DisplayObject = DisplayObject(param1.target);
         if(_loc3_ is IFocusManagerComponent && focusableObjects[_loc3_] == true)
         {
            if(_loc3_ == lastFocus)
            {
               IFocusManagerComponent(lastFocus).drawFocus(false);
               lastFocus = null;
            }
            _loc3_.removeEventListener(Event.TAB_ENABLED_CHANGE,tabEnabledChangeHandler);
            delete focusableObjects[_loc3_];
            calculateCandidates = true;
         }
         else if(_loc3_ is InteractiveObject && focusableObjects[_loc3_] == true)
         {
            _loc4_ = _loc3_ as InteractiveObject;
            if(_loc4_)
            {
               if(_loc4_ == lastFocus)
               {
                  lastFocus = null;
               }
               delete focusableObjects[_loc4_];
               calculateCandidates = true;
            }
            _loc3_.addEventListener(Event.TAB_ENABLED_CHANGE,tabEnabledChangeHandler);
         }
         removeFocusables(_loc3_);
      }
      
      private function sortByDepth(param1:InteractiveObject, param2:InteractiveObject) : Number
      {
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc3_:String = "";
         var _loc4_:String = "";
         var _loc8_:String = "0000";
         var _loc9_:DisplayObject = DisplayObject(param1);
         var _loc10_:DisplayObject = DisplayObject(param2);
         while(_loc9_ != DisplayObject(form) && Boolean(_loc9_.parent))
         {
            _loc5_ = getChildIndex(_loc9_.parent,_loc9_);
            _loc6_ = _loc5_.toString(16);
            if(_loc6_.length < 4)
            {
               _loc7_ = _loc8_.substring(0,4 - _loc6_.length) + _loc6_;
            }
            _loc3_ = _loc7_ + _loc3_;
            _loc9_ = _loc9_.parent;
         }
         while(_loc10_ != DisplayObject(form) && Boolean(_loc10_.parent))
         {
            _loc5_ = getChildIndex(_loc10_.parent,_loc10_);
            _loc6_ = _loc5_.toString(16);
            if(_loc6_.length < 4)
            {
               _loc7_ = _loc8_.substring(0,4 - _loc6_.length) + _loc6_;
            }
            _loc4_ = _loc7_ + _loc4_;
            _loc10_ = _loc10_.parent;
         }
         return _loc3_ > _loc4_ ? 1 : (_loc3_ < _loc4_ ? -1 : 0);
      }
      
      public function get defaultButton() : Button
      {
         return _defaultButton;
      }
      
      private function activateHandler(param1:Event) : void
      {
         var _loc2_:InteractiveObject = InteractiveObject(param1.target);
         if(lastFocus)
         {
            if(lastFocus is IFocusManagerComponent)
            {
               IFocusManagerComponent(lastFocus).setFocus();
            }
            else
            {
               form.stage.focus = lastFocus;
            }
         }
         lastAction = "ACTIVATE";
      }
      
      public function showFocus() : void
      {
      }
      
      public function set defaultButtonEnabled(param1:Boolean) : void
      {
         _defaultButtonEnabled = param1;
      }
      
      public function getNextFocusManagerComponent(param1:Boolean = false) : InteractiveObject
      {
         var _loc8_:IFocusManagerGroup = null;
         if(!hasFocusableObjects())
         {
            return null;
         }
         if(calculateCandidates)
         {
            sortFocusableObjects();
            calculateCandidates = false;
         }
         var _loc2_:DisplayObject = form.stage.focus;
         _loc2_ = DisplayObject(findFocusManagerComponent(InteractiveObject(_loc2_)));
         var _loc3_:String = "";
         if(_loc2_ is IFocusManagerGroup)
         {
            _loc8_ = IFocusManagerGroup(_loc2_);
            _loc3_ = _loc8_.groupName;
         }
         var _loc4_:int = getIndexOfFocusedObject(_loc2_);
         var _loc5_:Boolean = false;
         var _loc6_:int = _loc4_;
         if(_loc4_ == -1)
         {
            if(param1)
            {
               _loc4_ = int(focusableCandidates.length);
            }
            _loc5_ = true;
         }
         var _loc7_:int = getIndexOfNextObject(_loc4_,param1,_loc5_,_loc3_);
         return findFocusManagerComponent(focusableCandidates[_loc7_]);
      }
      
      private function mouseDownHandler(param1:MouseEvent) : void
      {
         if(param1.isDefaultPrevented())
         {
            return;
         }
         var _loc2_:InteractiveObject = getTopLevelFocusTarget(InteractiveObject(param1.target));
         if(!_loc2_)
         {
            return;
         }
         showFocusIndicator = false;
         if((_loc2_ != lastFocus || lastAction == "ACTIVATE") && !(_loc2_ is TextField))
         {
            setFocus(_loc2_);
         }
         lastAction = "MOUSEDOWN";
      }
      
      private function isTabVisible(param1:DisplayObject) : Boolean
      {
         var _loc2_:DisplayObjectContainer = param1.parent;
         while(_loc2_ && !(_loc2_ is Stage) && !(_loc2_.parent && _loc2_.parent is Stage))
         {
            if(!_loc2_.tabChildren)
            {
               return false;
            }
            _loc2_ = _loc2_.parent;
         }
         return true;
      }
      
      public function get nextTabIndex() : int
      {
         return 0;
      }
      
      private function keyDownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.TAB)
         {
            lastAction = "KEY";
            if(calculateCandidates)
            {
               sortFocusableObjects();
               calculateCandidates = false;
            }
         }
         if(defaultButtonEnabled && param1.keyCode == Keyboard.ENTER && defaultButton && defButton.enabled)
         {
            sendDefaultButtonEvent();
         }
      }
      
      private function focusInHandler(param1:FocusEvent) : void
      {
         var _loc3_:Button = null;
         var _loc2_:InteractiveObject = InteractiveObject(param1.target);
         if(form.contains(_loc2_))
         {
            lastFocus = findFocusManagerComponent(InteractiveObject(_loc2_));
            if(lastFocus is Button)
            {
               _loc3_ = Button(lastFocus);
               if(defButton)
               {
                  defButton.emphasized = false;
                  defButton = _loc3_;
                  _loc3_.emphasized = true;
               }
            }
            else if(Boolean(defButton) && defButton != _defaultButton)
            {
               defButton.emphasized = false;
               defButton = _defaultButton;
               _defaultButton.emphasized = true;
            }
         }
      }
      
      private function tabEnabledChangeHandler(param1:Event) : void
      {
         calculateCandidates = true;
         var _loc2_:InteractiveObject = InteractiveObject(param1.target);
         var _loc3_:* = focusableObjects[_loc2_] == true;
         if(_loc2_.tabEnabled)
         {
            if(!_loc3_ && isTabVisible(_loc2_))
            {
               if(!(_loc2_ is IFocusManagerComponent))
               {
                  _loc2_.focusRect = false;
               }
               focusableObjects[_loc2_] = true;
            }
         }
         else if(_loc3_)
         {
            delete focusableObjects[_loc2_];
         }
      }
      
      public function set showFocusIndicator(param1:Boolean) : void
      {
         _showFocusIndicator = param1;
      }
      
      public function get form() : DisplayObjectContainer
      {
         return _form;
      }
      
      private function sortByTabIndex(param1:InteractiveObject, param2:InteractiveObject) : int
      {
         return param1.tabIndex > param2.tabIndex ? 1 : (param1.tabIndex < param2.tabIndex ? -1 : int(sortByDepth(param1,param2)));
      }
      
      public function get defaultButtonEnabled() : Boolean
      {
         return _defaultButtonEnabled;
      }
      
      public function activate() : void
      {
         if(activated)
         {
            return;
         }
         form.stage.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,mouseFocusChangeHandler,false,0,true);
         form.stage.addEventListener(FocusEvent.KEY_FOCUS_CHANGE,keyFocusChangeHandler,false,0,true);
         form.addEventListener(FocusEvent.FOCUS_IN,focusInHandler,true);
         form.addEventListener(FocusEvent.FOCUS_OUT,focusOutHandler,true);
         form.stage.addEventListener(Event.ACTIVATE,activateHandler,false,0,true);
         form.stage.addEventListener(Event.DEACTIVATE,deactivateHandler,false,0,true);
         form.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
         form.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler,true);
         activated = true;
         if(lastFocus)
         {
            setFocus(lastFocus);
         }
      }
      
      public function deactivate() : void
      {
         form.stage.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,mouseFocusChangeHandler);
         form.stage.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE,keyFocusChangeHandler);
         form.removeEventListener(FocusEvent.FOCUS_IN,focusInHandler,true);
         form.removeEventListener(FocusEvent.FOCUS_OUT,focusOutHandler,true);
         form.stage.removeEventListener(Event.ACTIVATE,activateHandler);
         form.stage.removeEventListener(Event.DEACTIVATE,deactivateHandler);
         form.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
         form.removeEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler,true);
         activated = false;
      }
   }
}

