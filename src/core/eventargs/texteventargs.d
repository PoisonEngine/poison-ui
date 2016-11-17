module poison.core.eventargs.texteventargs;

import poison.core.eventargs : EventArgs;

/// Event args for text events.
class TextEventArgs : EventArgs {
  private:
  /// The last character entered.
  dchar _last;

  /// The current character entered.
  dchar _current;

  public:
  @property {
    /// Gets the last character entered.
    dchar last() { return _last; }

    /// Gets the current character entered.
    dchar current() { return _current; }
  }

  /**
  * Enteres a character.
  * Params:
  *   enteredChar = The entered character.
  */
  void enter(dchar enteredChar) {
    _last = _current;
    _current = enteredChar;
  }

  package(poison):
  /// Creates a new instance of text event args.
  this() {
    super();
  }
}
