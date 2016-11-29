/**
* Module for window handling.
*
* Authors:
*   Jacob Jensen
* License:
*   https://github.com/PoisonEngine/poison-ui/blob/master/LICENSE
*/
module poison.ui.window;

import dsfmlWindow = dsfml.window;
import dsfml.window : Event, Keyboard, Mouse;

private alias ContextSettings = dsfmlWindow.ContextSettings;
private alias VideoMode = dsfmlWindow.VideoMode;
private alias WindowStyle = dsfmlWindow.Window.Style;

import poison.core : Point, Size, ActionArgs, KeyEventArgs, MouseEventArgs, TextEventArgs, executeUI;
import poison.ui.container;
import poison.ui.component;

/// A window component.
class Window : Container {
  private:
  /// The context settings.
  ContextSettings _context;

  /// The video mode.
  VideoMode _videoMode;

  /// The render window.
  RenderWindow _window;

  /// The key event.
  KeyEventArgs _keyEvent;

  /// The mouse event.
  MouseEventArgs _mouseEvent;

  /// The text event.
  TextEventArgs _textEvent;

  /// The fps for the window.
  uint _fps;

  /// Boolean determining whether the cursor is visible or not.
  bool _cursorVisible;

  public:
  /**
  * Creates a new window.
  * Params:
  *   name =    The name of the window.
  *   title =   The title of the window.
  *   size =    The size of the window.
  *   layers =  The layers of the window. (Defaults to 1)
  */
  this(string name, dstring title, Size size, size_t layers = 1) {
    super(name, size, layers);

    _context.antialiasingLevel = 8;
    _videoMode = VideoMode(cast(int)size.width, cast(int)size.height);
    _keyEvent = new KeyEventArgs();
    _mouseEvent = new MouseEventArgs();
    _textEvent = new TextEventArgs();

    innerText = title;
    _fps = 60;

    addSelector("window");
  }

  @property {
    /// Gets the title of the window.
    dstring title() { return super.innerText; }

    /// Sets the title of the window.
    void title(dstring newTitle) {
      super.innerText = newTitle;

      if (_window) {
        _window.setTitle(super.innerText);
      }
    }

    /// Gets a boolean determining whether the window is open or not.
    bool isOpen() {
      return _window && _window.isOpen();
    }

    /**
    * Gets the parent window.
    * Returns:
    *   Always returns "this" where "this" is the window itself.
    */
    override Window parentWindow() {
      return this;
    }

    /// Gets or sets a boolean determining whether the window is hidden or not.
    override void hidden(bool isHidden) {
      if (_window) {
        _window.setVisible(!isHidden);
      }

      super.hidden = isHidden;
    }

    /// Gets the fps of the window.
    uint fps() { return _fps; }

    /// Sets the fps of the window.
    void fps(uint newFps) {
      _fps = newFps;

      if (_window) {
        _window.setFramerateLimit(_fps);
      }
    }

    /// Gets a boolean determining whether the cursor is visible or not.
    bool cursorVisible() { return _cursorVisible; }

    /// Sets a boolean determining whether the cursor is visible or not.
    void cursorVisible(bool isCursorVisible) {
      _cursorVisible = isCursorVisible;

      _window.setMouseCursorVisible(_cursorVisible);
    }
  }

  /// Shows the window.
  override void show() {
    if (!_window) {
      _window = new RenderWindow(_videoMode, title, (WindowStyle.Titlebar | WindowStyle.Resize | WindowStyle.Close), _context);

      if (_fps) {
        _window.setFramerateLimit(_fps);
      }

      _windowComponents[super.id] = this;
    }

    super.show();
  }

  /// Closes the window.
  void close() {
    assert(_window !is null);

    _window.close();
  }

  /**
  * Sends a key input through memory.
  * Params:
  *   key = The key to send an input of.
  */
  void sendKeyInput(Keyboard.Key key) {
    executeUI({
      _keyEvent.press(key);

      if (_windowComponents) {
        foreach (component; _windowComponents) {
          if (component && !component.disabled) {
            component.fireEvent("keyDown", _keyEvent);
          }
        }
      }

      _keyEvent.release(key);

      if (_windowComponents) {
        foreach (component; _windowComponents) {
          if (component && !component.disabled) {
            component.fireEvent("keyUp", _keyEvent);
          }
        }
      }
    });
  }

  /**
  * Sends a mouse input through memory.
  * Params:
  *   button =    The button to send an input of.
  *   position =  The position of the mouse input.
  * Note:
  *   This doesn't change the position of the cursor. Use Window.changeCursorPosition() instead.
  */
  void sendMouseInput(Mouse.Button button, Point position) {
    executeUI({
      auto lastPosition = _mouseEvent.position;

      _mouseEvent.press(button);
      _mouseEvent.position = position;

      if (_windowComponents) {
        foreach (component; _windowComponents) {
          if (component && !component.disabled) {
            component.fireEvent("mouseDown", _mouseEvent);
          }
        }
      }

      _mouseEvent.release(button);

      if (_windowComponents) {
        foreach (component; _windowComponents) {
          if (component && !component.disabled) {
            component.fireEvent("mouseUp", _mouseEvent);
          }
        }
      }

      _mouseEvent.position = lastPosition;
    });
  }

  /**
  * Changes the cursor position.
  * Params:
  *   position =  The position to set the cursor at.
  * Note:
  *   For virtual mouse presses do not use this. Use Window.sendMouseInput() instead.
  */
  void changeCursorPosition(Point position) {
    executeUI({
      _mouseEvent.position = position;

      import dsfml.system : Vector2i;
      Mouse.setPosition(Vector2i(position.x, position.y));
    });
  }

  package(poison):
  /// Components for event handling
  Component[size_t] _windowComponents;

  /// Processes the window cycle.
  void process() {
    Event event;
    while(_window.pollEvent(event)) {
      switch (event.type) {
        case Event.EventType.Closed: {
          _window.close();
          return;
        }

        case Event.EventType.KeyPressed: {
          _keyEvent.press(event.key.code);

          if (_windowComponents) {
            foreach (component; _windowComponents) {
              if (component && !component.disabled) {
                component.fireEvent("keyDown", _keyEvent);
              }
            }
          }

          break;
        }

        case Event.EventType.KeyReleased: {
          _keyEvent.release(event.key.code);

          if (_windowComponents) {
            foreach (component; _windowComponents) {

              if (component && !component.disabled) {
                component.fireEvent("keyUp", _keyEvent);
              }
            }
          }

          break;
        }

        case Event.EventType.MouseButtonPressed: {
          _mouseEvent.press(event.mouseButton.button);

          if (_windowComponents) {
            foreach (component; _windowComponents) {
              if (component && !component.disabled && component.intersect(_mouseEvent.position)) {
                component.fireEvent("mouseDown", _mouseEvent);
              }
            }
          }

          break;
        }

        case Event.EventType.MouseButtonReleased: {
          _mouseEvent.release(event.mouseButton.button);

          if (_windowComponents) {
            foreach (component; _windowComponents) {
              if (component && !component.disabled && component.intersect(_mouseEvent.position)) {
                component.fireEvent("mouseUp", _mouseEvent);
              }
            }
          }

          break;
        }

        case Event.EventType.MouseMoved: {
          _mouseEvent.position = new Point(event.mouseMove.x, event.mouseMove.y);

          if (_windowComponents) {
            foreach (component; _windowComponents) {
              if (component) {
                component.fireEvent("mouseMoved", _mouseEvent);
              }
            }
          }

          break;
        }

        case Event.EventType.TextEntered: {
          _textEvent.enter(event.text.unicode);

          if (_windowComponents) {
            foreach (component; _windowComponents) {
              if (component && !component.disabled) {
                component.fireEvent("textEntered", _textEvent);
              }
            }
          }

          break;
        }

        default: break;
      }
    }

    _window.clear(super.graphics.backgroundPaint.sfmlColor);
    super.process(_window);
    _window.display();
  }
}
