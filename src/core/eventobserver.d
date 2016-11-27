/**
* Module for event observation.
*
* Authors:
*   Jacob Jensen
* License:
*   https://github.com/PoisonEngine/poison-ui/blob/master/LICENSE
*/
module poison.core.eventobserver;

import poison.core.eventhandler;
import poison.core.eventargs;

/// An observer for events.
class EventObserver {
  private:
  /// Global event handlers.
  static IBaseEventHandler[][string] _globalEventHandlers;

  /// Event handlers.
  IBaseEventHandler[][string] _eventHandlers;

  public:
  /**
  * Subscribes an event handler to an event.
  * Params:
  *   eventName = The event to subscribe to.
  *   handler =   The event handler.
  */
  void subscribe(TEventArgs : EventArgs)(string eventName, EventHandler!TEventArgs handler) {
    _eventHandlers[eventName] ~= handler;
  }

  /**
  * Unsubscribes an event.
  * Params:
  *   eventName = The name of the event to unsubscribe.
  */
  void unsubscribe(string eventName) {
    assert(eventName in _eventHandlers);

    _eventHandlers.remove(eventName);
  }

  /**
  * Fires an event.
  * Params:
  *   eventName = The name of the event to fire.
  *   eventArgs = The event args to pass.
  */
  void fireEvent(TEventArgs : EventArgs)(string eventName, TEventArgs eventArgs) {
    auto handlers = _eventHandlers.get(eventName, null);

    if (handlers) {
      foreach (handler; handlers) {
        (cast(EventHandler!TEventArgs)handler)(eventArgs);
      }
    }
  }

  static:
  /**
  * Subscribes a global event handler to an event.
  * Params:
  *   eventName = The event to subscribe to.
  *   handler =   The event handler.
  */
  void subscribeGlobal(TEventArgs : EventArgs)(string eventName, EventHandler!TEventArgs handler) {
    _globalEventHandlers[eventName] ~= handler;
  }

  /**
  * Unsubscribes a global event.
  * Params:
  *   eventName = The name of the event to unsubscribe.
  */
  void unsubscribeGlobal(string eventName) {
    assert(eventName in _globalEventHandlers);

    _globalEventHandlers.remove(eventName);
  }

  /**
  * Fires a global event.
  * Params:
  *   eventName = The name of the event to fire.
  *   eventArgs = The event args to pass.
  */
  void fireEventGlobal(TEventArgs : EventArgs)(string eventName, TEventArgs eventArgs) {
    auto handlers = _globalEventHandlers.get(eventName, null);

    if (handlers) {
      foreach (handler; handlers) {
        (cast(EventHandler!TEventArgs)handler)(eventArgs);
      }
    }
  }
}
