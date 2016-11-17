module poison.core.eventargs.buttoneventargs;

import std.algorithm : filter;
import std.array : array;

import poison.core.eventargs : EventArgs;

// TODO: handle double click by time checking ...


/// Event args that relies on button logic.
class ButtonEventArgs(T) : EventArgs {
  private:
  /// The currently pressed buttons.
  T[] _pressed;

  /// The last pressed button.
  T _lastPressed;

  /// The current pressed button.
  T _currentPressed;

  protected:
  /// Creates a new button event args wrapper.
  this() {
    super();
  }

  public:
  /**
  * Presses a button.
  * Params:
  *   button =  The button to press.
  */
  void press(T button) {
    if (isPressed(button)) {
      return;
    }

    _pressed ~= button;
    _lastPressed = _currentPressed;
    _currentPressed = button;
  }

  /**
  * Releases a button.
  * Params:
  *   button =  The button to release.
  */
  void release(T button) {
    _pressed = _pressed.filter!((b) { return b != button; }).array;
    _lastPressed = _currentPressed;
  }

  /**
  * Checks whether a specific button is pressed or not.
  * Params:
  *   pressedButton = The button to check if pressed or not.
  * Returns:
  *   true if the button is pressed.
  */
  bool isPressed(T pressedButton) {
    if (_currentPressed == pressedButton) {
      return true;
    }

    foreach (button; _pressed) {
      if (button == pressedButton) {
        return true;
      }
    }

    return false;
  }

  /**
  * Checks whether a range of buttons are pressed or not.
  * Params:
  *   pressedButtons = The buttons to check if pressed or not.
  * Returns:
  *   true if all buttons are pressed.
  */
  bool isPressed(Range)(Range pressedButtons) {
    assert(pressedButtons !is null);

    foreach (button; pressedButtons) {
      if (!isPressed(button)) {
        return false;
      }
    }

    return true;
  }

  @property {
    /// Gets all buttons currently pressed.
    T[] pressed() { return _pressed; }

    /// Gets the last button pressed.
    T lastPressed() { return _lastPressed; }

    /// Gets the current button pressed.
    T currentPressed() { return _currentPressed; }
  }
}
