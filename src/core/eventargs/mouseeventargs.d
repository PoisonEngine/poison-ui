/**
* Module for mouse event args handling.
*
* Authors:
*   Jacob Jensen
* License:
*   https://github.com/PoisonEngine/poison-ui/blob/master/LICENSE
*/
module poison.core.eventargs.mouseeventargs;

import dsfml.window : Mouse;

public alias MouseButton = Mouse.Button;

import poison.core.eventargs.buttoneventargs;
import poison.core.vector : Point;

/// Event args for mouse events.
class MouseEventArgs : ButtonEventArgs!MouseButton {
  private:
  /// The current position of the mouse.
  Point _position;

  public:
  @property {
    /// Gets the current position of the mouse.
    Point position() { return _position; }
  }

  package(poison):
  /// Creates a new instance of the mouse event args.
  this() {
    super();
  }

  @property {
    /// Sets the position of the mouse.
    void position(Point newPosition) {
      _position = newPosition;
    }
  }
}
