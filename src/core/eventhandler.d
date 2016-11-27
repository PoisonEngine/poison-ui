/**
* Module for event handlers.
*
* Authors:
*   Jacob Jensen
* License:
*   https://github.com/PoisonEngine/poison-ui/blob/master/LICENSE
*/
module poison.core.eventhandler;

import poison.core.eventargs;

/// A base event handler.
interface IBaseEventHandler { }

/// An event handler.
class EventHandler(TEventArgs : EventArgs) : IBaseEventHandler {
  private:
  /// The function pointer of the event handler.
  void function(TEventArgs) _f;

  /// The delegate of the event handler.
  void delegate(TEventArgs) _d;

  public:
  /**
  * Creates a new event handler.
  * Params:
  *   f = The function pointer.
  */
  this(void function(TEventArgs) f) {
    _f = f;
  }

  /**
  * Creates a new event handler.
  * Params:
  *   d = The delegate.
  */
  this(void delegate(TEventArgs) d) {
    _d = d;
  }

  /**
  * Operator overload for calling the event handler implicit.
  * Params:
  *   e = The event args.
  */
  void opCall(TEventArgs e) {
    if (_f) {
      _f(e);
    }
    else if (_d) {
      _d(e);
    }
  }
}
