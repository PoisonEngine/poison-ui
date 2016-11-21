module poison.ui.graphics;

import dsfml.graphics : RectangleShape;
import dsfml.system : Vector2f;

import poison.ui.paint;
import poison.core : Size, Point;
import poison.ui.picture;
import poison.ui.fonts;

/// Graphics wrapper for components.
class Graphics {
  private:
  /// The background paint.
  Paint _backgroundPaint;

  /// The foreground paint.
  Paint _foregroundPaint;

  /// The low-level background rectangle.
  RectangleShape _backgroundRect;

  /// The background picture.
  Picture _backgroundPicture;

  /// The size.
  Size _size;

  /// The position.
  Point _position;

  /// The font.
  Font _font;

  /// The font size.
  uint _fontSize;

  public:
  final:
  /// Creates a new graphics wrapper.
  this() {
    _backgroundPaint = transparent;
    _foregroundPaint = transparent;

    _size = new Size(0,0);
    _position = new Point(0,0);

    _fontSize = 13;
  }

  @property {
    /// Gets the background paint.
    Paint backgroundPaint() { return _backgroundPaint; }

    /// Sets the background paint.
    void backgroundPaint(Paint newPaint) {
      _backgroundPaint = newPaint;

      if (_backgroundRect) {
        _backgroundRect.fillColor = _backgroundPaint.sfmlColor;
      }
    }

    /// Gets the foreground paint.
    Paint foregroundPaint() { return _foregroundPaint; }

    /// Sets the foreground paint.
    void foregroundPaint(Paint newPaint) {
      _foregroundPaint = newPaint;
    }

    /// Gets the low-level background rectangle.
    RectangleShape backgroundRect() { return _backgroundRect; }

    /// Gets the background picture.
    Picture backgroundPicture() { return _backgroundPicture; }

    /// Sets the background picture.
    void backgroundPicture(Picture newBackgroundPicture) {
      _backgroundPicture = newBackgroundPicture;
    }

    /// Gets the font.
    Font font() { return _font; }

    /// Sets the font.
    void font(Font newFont) {
      _font = newFont;
    }

    /// Gets the font size.
    uint fontSize() { return _fontSize; }

    /// Sets the font size.
    void fontSize(uint newFontSize) {
      _fontSize = newFontSize;
    }
  }

  package(poison):
  @property {
    /// Sets the position of the graphics.
    void position(Point newPosition) {
      _position = newPosition;

      if (_backgroundRect) {
        _backgroundRect.position = Vector2f(cast(float)_position.x, cast(float)_position.y);
      }

      if (_backgroundPicture) {
        _backgroundPicture.position = _position;
      }
    }
  }

  /// Sets the size of the graphics.
  void size(Size newSize) {
    _size = newSize;

    _backgroundRect = new RectangleShape(Vector2f(cast(float)_size.width, cast(float)_size.height));
    backgroundPaint = _backgroundPaint;
    position = _position;
  }
}
