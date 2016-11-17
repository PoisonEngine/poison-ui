module poison.core.eventargs.keyeventargs;

import dsfml.window : Keyboard;

public alias Key = Keyboard.Key;

import poison.core.eventargs.buttoneventargs;

/// Event args for key events.
class KeyEventArgs : ButtonEventArgs!Key {
  package(poison):
  /// Creates a new instance key event args.
  this() {
    super();
  }
}
