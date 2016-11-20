module poison.ui.component;

import std.algorithm : filter;
import std.array : array;

import poison.ui.space;
import poison.core : ActionArgs, Point, Size, EventArgs, ChangeEventArgs, executeUI, isUIThread, CrossThreadingExeption;
import poison.ui.window;
import poison.ui.graphics;
import poison.ui.paint;
import poison.ui.picture;

public import dsfml.graphics : RenderWindow;

/// The next component id.
private size_t nextId = 0;

/// A component.
class Component : Space {
  private:
  /// The name.
  string _name;

  /// The inner text.
  dstring _innerText;

  /// The outer text.
  dstring _outerText;

  /// Boolean determining whether it's disabled or not.
  bool _disabled;

  /// Boolean determining whether it's hidden or not.
  bool _hidden;

  /// The id.
  size_t _id;

  /// The layer.
  ptrdiff_t _layer;

  /// The parent window.
  Window _parentWindow;

  /// The graphics.
  Graphics _graphics;

  /// Style selectors.
  string[] _selectors;

  /// Selectors to render with.
  string[] _renderSelectors;

  /// The selector name.
  string _selectorName;

  protected:
  /**
  * Creates a new component.
  * Params:
  *   name =        The name of the component.
  *   initialSize = The initial size of the component.
  */
  this(string name, Size initialSize) {
    if (!isUIThread) {
      throw new CrossThreadingExeption("Cannot create a component outside the UI thread. Consider using exeuteUI();");
    }

    super(new Point(0, 0), initialSize);

    _name = name;
    _layer = -1;
    _id = nextId++;
    _graphics = new Graphics();
    _selectors = ["component"];
    _selectorName = "#" ~ _name;
  }

  /**
  * Creates a new component.
  * Params:
  *   name =  The name of the component.
  */
  this(string name) {
    this(name, new Size(100, 100));
  }


  /// Renders the component. Override this!
  void render() {
    _graphics.size = super.size;
    _graphics.position = super.position;
  }

  /**
  * Draws the component. Override this!
  * Params:
  *   window =  The window to draw the component to.
  */
  void draw(RenderWindow window) {
    window.draw(_graphics.backgroundRect);

    auto picture = _graphics.backgroundPicture;

    if (picture) {
      if (picture.backgroundSprite) {
        window.draw(picture.backgroundSprite);
      }

      if (picture.drawingSprite) {
        window.draw(picture.drawingSprite);
      }
    }
  }

  public:
  @property {
    /// Gets the name of the component.
    string name() { return _name; }

    /// Gets a boolean determining whether the component is enabled or not.
    bool enabled() { return !_disabled; }

    /// Sets a boolean determining whether the component is enabled or not.
    void enabled(bool isEnabled) {
      disabled = !isEnabled;
    }

    /// Gets a boolean determining whether the component is disabled or not.
    bool disabled() { return _disabled; }

    /// Sets a boolean determining whether the component is disabled.
    void disabled(bool isDisabled) {
      executeUI({
        _disabled = isDisabled;

        fireEvent(_disabled ? "beforeDisabled" : "beforeEnabled", EventArgs.empty);

        updateSelectors();
        render();

        fireEvent(_disabled ? "disabled" : "enabled", EventArgs.empty);
      });
    }

    /// Gets a boolean determining whether the component is visible or not.
    bool visible() { return !_hidden; }

    /// Sets a boolean determining whether the component is visible or not.
    void visible(bool isVisible) {
      hidden = !isVisible;
    }

    /// Gets a boolean determining whether the component is hidden or not.
    bool hidden() { return _hidden; }

    /// Sets a boolean determining whether the component is hidden or not.
    void hidden(bool isHidden) {
      executeUI({
        _hidden = isHidden;

        fireEvent(_hidden ? "beforeHide" : "beforeShow", EventArgs.empty);

        if (!_hidden) {
          render();
        }

        fireEvent(_hidden ? "hide" : "show", EventArgs.empty);
      });
    }

    /// Gets the inner text of the component.
    dstring innerText() { return _innerText; }

    /// Sets the inner text of the component.
    void innerText(dstring newInnerText) {
      executeUI({
        auto oldInnerText = _innerText;
        _innerText = newInnerText;

        fireEvent("innerText", new ChangeEventArgs!dstring(oldInnerText, _innerText));

        render();
      });
    }

    /// Gets the outer text of the component.
    dstring outerText() { return _outerText; }

    /// Sets the outer text of the component.
    void outerText(dstring newOuterText) {
      executeUI({
        auto oldOuterText = _outerText;
        _outerText = newOuterText;

        fireEvent("outerText", new ChangeEventArgs!dstring(oldOuterText, _outerText));

        render();
      });
    }

    /// Ges the position of the component.
    override Point position() { return super.position; }

    /// Sets the position of the component.
    override void position(Point newPoint) {
      executeUI({
        super.position = newPoint;

        render();
      });
    }

    /// Gets the size of the component.
    override Size size() { return super.size; }

    /// Sets the size of the component.
    override void size(Size newSize) {
      executeUI({
        super.size = newSize;

        render();
      });
    }

    /// Gets the layer of the component.
    ptrdiff_t layer() { return _layer; }

    /// Gets the parent window of the component.
    Window parentWindow() {
      return _parentWindow;
    }
  }

  /// Shows the component.
  void show() {
    visible = true;
  }

  /// Hides the component.
  void hide() {
    hidden = true;
  }

  /// Enables the component.
  void enable() {
    enabled = true;
  }

  /// Disables the component.
  void disable() {
    disabled = true;
  }

  /**
  * Adds a style selector.
  * Params:
  *   selector =  The selector to add.
  */
  void addSelector(string selector) {
    _selectors ~= selector;

    updateSelectors();
  }

  /**
  * Removes a style selector.
  * Params:
  *   The style selector to remove.
  */
  void removeSelector(string selector) {
    _selectors = _selectors.filter!((s) { return s != selector; }).array;

    updateSelectors();
  }

  protected:
  @property {
    /// Gets the graphics of the component.
    Graphics graphics() { return _graphics; }
  }

  /**
  * Processes the component during application cycles.
  * Params:
  *   window = The render window to process.
  */
  void process(RenderWindow window) {
    if (!_hidden) {
      draw(window);
    }
  }

  private:
  /// Updates the selectors.
  void updateSelectors() {
    auto prefix = (_disabled ? ":disabled" : ":enabled");

    _renderSelectors ~= _selectors;

    foreach (selector; _selectors) {
        _renderSelectors ~= selector ~ prefix;
    }

    _renderSelectors  ~= _selectorName;
    _renderSelectors ~= _selectorName ~ prefix;

    updateStyles();
  }

  package(poison):
  /**
  * Processes the component during application cycles.
  * Params:
  *   window =        The render window to process.
  */
  void processInternal(RenderWindow window) {
    process(window);
  }

  /// Updates the styles of the component.
  void updateStyles() {
    import poison.ui.styles;

    if (_selectors) {
      foreach (selector; _renderSelectors) {
        auto styleEntry = getStyleEntry(selector);

        if (styleEntry) {
          if (styleEntry.backgroundPicture) {
            _graphics.backgroundPicture = new Picture(styleEntry.backgroundPicture);
            _graphics.position = super.position;
            _graphics.backgroundPicture.finalize();
          }

          _graphics.backgroundPaint = styleEntry.backgroundPaint;
          _graphics.foregroundPaint = styleEntry.foregroundPaint;
        }
      }
    }
  }

  @property {
    /// Gets the id of the component.
    size_t id() { return _id; }

    /// Sets the layer of the component.
    void layer(ptrdiff_t newLayer) {
      _layer = newLayer;
    }

    /// Sets the parent window of the component.
    void parentWindow(Window newParentWindow) {
      _parentWindow = newParentWindow;
    }
  }
}
