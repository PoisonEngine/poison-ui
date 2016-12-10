/**
* Module for core application handling.
*
* Authors:
*   Jacob Jensen
* License:
*   https://github.com/PoisonEngine/poison-ui/blob/master/LICENSE
*/
module poison.core.application;

import std.concurrency : thisTid;
import core.thread : Thread, dur;

import poison.ui : Window;
import poison.core.threading : _uiTid, receiveMessages;
import poison.core.eventobserver;
import poison.core.eventargs;

/// A wrapper around the core application.
class Application {
  private:
  /// The running application.
  static Application _app;

  /// The name of the application.
  string _name;

  /// Collection of windows.
  Window[string] _windows;

  /// Windows that can be removed.
  string[] _removableWindows;

  /// Boolean determining whether the application is cycling or not.
  bool _cycling;

  /// Boolean determining whether the application is open or not.
  bool _open;

  public:
  /**
  * Creates a new application.
  * Params:
  *   name =  The name of the application.
  */
  this(string name) {
    _name = name;
    _uiTid = thisTid;
  }

  @property {
    /// Gets the name of the application.
    string name() { return _name; }
  }

  /// Updates all styles for each window.
  void updateStyles() {
    if (_windows) {
      foreach (window; _windows) {
        foreach (component; window._windowComponents) {
          component.updateStyles();
        }
      }
    }
  }

  /**
  * Adds a window to the application.
  * Params:
  *   window =  The window to add.
  */
  void add(Window window) {
    assert(window !is null);
    assert(_windows.get(window.name, null) is null);

    _windows[window.name] = window;

    foreach (component; window._windowComponents) {
      component.updateStyles();
    }
  }

  /**
  * Removes a window from the application.
  * Params:
  *   window =  The window to remove.
  */
  void remove(Window window) {
    assert(window !is null);

    remove(window.name);
  }

  /**
  * Removes a window from the application.
  * Params:
  *   name =  The name of the window to remove.
  */
  void remove(string name) {
    assert(_windows.get(name, null) !is null);

    if (_cycling) {
      _removableWindows ~= name;
    }
    else {
      auto windowToRemove = _windows.get(name, null);

      if (!windowToRemove) {
        return;
      }

      if (windowToRemove.isOpen) {
        windowToRemove.close();
      }

      _windows.remove(name);
    }
  }

  private:
  /// Processes the application.
  void process() {
    assert(_app !is null);

    _open = true;

    while (_open) {
      _removableWindows = [];
      _cycling = true;

      receiveMessages();

      processWindows();

      _cycling = false;

      foreach (removableWindow; _removableWindows) {
        remove(removableWindow);
      }
    }
  }

  /// Processes all windows.
  void processWindows() {
    _open = false;

    foreach (window; _windows) {
      if (window.isOpen) {
        _open = true;

        window.process();
      }
    }
  }

  public:
  static:
  /**
  * Initializes a application and then processes it.
  * Params:
  *   application = The application to initialize and process.
  */
  void initialize(Application application) {
    assert(_app is null);

    _app = application;

    _app.updateStyles();
    EventObserver.fireEventGlobal("applicationStart", EventArgs.empty);
    _app.process();
    EventObserver.fireEventGlobal("applicationEnd", EventArgs.empty);
  }

  @property {
    /// Gets the app.
    Application app() { return _app; }
  }
}
