/**
* Module for actions. Actions are classes that wraps around a function pointer or delegate.
*
* Authors:
*   Jacob Jensen
* License:
*   https://github.com/PoisonEngine/poison-ui/blob/master/LICENSE
*/
module poison.core.action;

/// An action.
class Action {
  private:
  /// The function pointer.
  void function() _f;

  /// The delegate.
  void delegate() _d;

  public:
  /**
  * Creates a new instance of the action passing a function pointer.
  * Params:
  *   f = The function pointer.
  */
  this(void function() f) {
    _f = f;
  }


  /**
  * Creates a new instance of the action passing a delegate.
  * Params:
  *   d = The delegate.
  */
  this(void delegate() d) {
    _d = d;
  }

  /// Operator overload for calling Action implicit.
  void opCall() {
    if (_f) {
      _f();
    }
    else if (_d) {
      _d();
    }
  }
}

/// An action that takes a generic argument.
class ActionArgs(T) {
  private:
  /// The function pointer.
  void function(T) _f;

  /// The delegate.
  void delegate(T) _d;

  public:
  /**
  * Creates a new instance of the action passing a function pointer.
  * Params:
  *   f = The function pointer.
  */
  this(void function(T) f) {
    _f = f;
  }

  /**
  * Creates a new instance of the action passing a delegate.
  * Params:
  *   d = The delegate.
  */
  this(void delegate(T) d) {
    _d = d;
  }

  /**
  * Operator overload for calling Action implicit.
  * Params:
  *   arg = The argument to pass.
  */
  void opCall(T arg) {
    if (_f) {
      _f(arg);
    }
    else if (_d) {
      _d(arg);
    }
  }
}
