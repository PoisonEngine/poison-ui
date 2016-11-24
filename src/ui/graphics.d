module poison.ui.graphics;

import dsfml.graphics : RectangleShape;
import dsfml.system : Vector2f;

import poison.ui.paint;
import poison.core : Size, Point;
import poison.ui.picture;
import poison.ui.fonts;

/// Original space struct for graphical elements.
private struct OriginalSpace(TPosition,TSize) {
  /// The original x position.
  TPosition x;

  /// The original y position.
  TPosition y;

  /// The original width.
  TSize width;

  /// The original height.
  TSize height;
}

/// A sub rect of overflow calculation results.
private struct SubRect {
  /// The x coordinate.
  float x;

  /// The y coordinate.
  float y;

  /// The width.
  float width;

  /// The height.
  float height;

  /// The overflow top.
  float overflowTop;

  /// The overflow right.
  float overflowRight;

  /// The overflow bottom.
  float overflowBottom;

  /// The overflow left.
  float overflowLeft;
}

/// Graphics wrapper for components.
class Graphics {
  private:
  /// The background paint.
  Paint _backgroundPaint;

  /// The foreground paint.
  Paint _foregroundPaint;

  /// The low-level background rectangle.
  RectangleShape _backgroundRect;

  /// The original background rectangle's space.
  OriginalSpace!(float,float) _originalBackgroundRect;

  /// The background picture.
  Picture _backgroundPicture;

  /// The original background ´picture's space.
  OriginalSpace!(ptrdiff_t,int) _originalBackgroundPicture;

  /// The size.
  Size _size;

  /// The position.
  Point _position;

  /// The font.
  Font _font;

  /// The font size.
  uint _fontSize;

  /// Boolean determining whether the background rectangle is displayable or not.
  bool _displayableBackgroundRect;

  /// Boolean determining whether the background picture is displayable or not.
  bool _displayableBackgroundPicture;

  public:
  final:
  /// Creates a new graphics wrapper.
  this() {
    _backgroundPaint = transparent;
    _foregroundPaint = transparent;

    _size = new Size(0,0);
    _position = new Point(0,0);

    _fontSize = 13;
    _displayableBackgroundRect = true;
    _displayableBackgroundPicture = true;
    _originalBackgroundRect = OriginalSpace!(float,float)(0,0,0,0);
    _originalBackgroundPicture = OriginalSpace!(ptrdiff_t, int)(0,0,0,0);
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

      if (_backgroundPicture) {
        _backgroundPicture.position = _position;

        _originalBackgroundPicture.x = _position.x;
        _originalBackgroundPicture.y = _position.y;

        _originalBackgroundPicture.width = _size.width;
        _originalBackgroundPicture.height = _size.height;
      }
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
        _originalBackgroundRect.x = _backgroundRect.position.x;
        _originalBackgroundRect.y = _backgroundRect.position.y;
      }

      if (_backgroundPicture) {
        _backgroundPicture.position = _position;
        _originalBackgroundPicture.x = cast(int)_position.x;
        _originalBackgroundPicture.y = cast(int)_position.y;
      }
    }
  }

  /// Sets the size of the graphics.
  void size(Size newSize) {
    _size = newSize;

    _backgroundRect = new RectangleShape(Vector2f(cast(float)_size.width, cast(float)_size.height));
    backgroundPaint = _backgroundPaint;
    position = _position;

    _originalBackgroundRect.width = _backgroundRect.size.x;
    _originalBackgroundRect.height = _backgroundRect.size.y;

    _originalBackgroundPicture.width = cast(int)_size.width;
    _originalBackgroundPicture.height = cast(int)_size.height;
  }

  package(poison):
  @property {
    /// Gets a boolean determining whether the background rectangle is displayable.
    bool displayableBackgroundRect() { return _displayableBackgroundRect; }

    /// Gets a boolean determining whether the background picture is displayable.
    bool displayableBackgroundPicture() { return _displayableBackgroundPicture; }
  }

  /**
  * Renders the sub rectangles for the graphics elements.
  * Params:
  *   position =  The position to be relative to.
  *   size =      The size to be relative to.
  */
  void renderSub(Point position, Size size) {
    import dsfml.graphics : IntRect;
    import dsfml.system : Vector2f;

    SubRect calculateOverflow(float targetX, float targetY, float targetWidth, float targetHeight) {
      import std.math : fmax;

      float overflowTop = fmax(0, (cast(float)position.y - targetY));
      float overflowRight = fmax(0, (targetX + targetWidth) - (cast(float)position.x + cast(float)size.width));
      float overflowBottom = fmax(0, (targetY + targetHeight) - (cast(float)position.y + cast(float)size.height));
      float overflowLeft = fmax(0, (cast(float)position.x - targetX));

      targetY += overflowTop;
      targetHeight -= overflowTop;
      targetWidth -= overflowRight;
      targetHeight -= overflowBottom;
      targetX += overflowLeft;
      targetWidth -= overflowLeft;

      return SubRect(targetX, targetY, targetWidth, targetHeight, overflowTop, overflowRight, overflowBottom, overflowLeft);
    }

    bool intersect(float width, float height, float x, float y) {
      return(x < cast(float)position.x + cast(float)size.width) &&
        (cast(float)position.x < (x + width)) &&
        (y < cast(float)position.y + cast(float)size.height) &&
        (cast(float)position.y < y + height);
     }

    if (_backgroundRect) {
      _backgroundRect.size = Vector2f(_originalBackgroundRect.width, _originalBackgroundRect.height);
      _backgroundRect.position = Vector2f(_originalBackgroundRect.x, _originalBackgroundRect.y);

      auto rectSize = _backgroundRect.size;
      auto rectPosition = _backgroundRect.position;

      _displayableBackgroundRect = intersect(rectSize.x, rectSize.y, rectPosition.x, rectPosition.y);

      if (_displayableBackgroundRect) {
        auto overflow = calculateOverflow(rectPosition.x, rectPosition.y, rectSize.x, rectSize.y);

        _backgroundRect.size = Vector2f(overflow.width, overflow.height);
        _backgroundRect.position = Vector2f(overflow.x, overflow.y);
      }
    }

    if (_backgroundPicture) {
      _displayableBackgroundPicture = intersect(cast(float)_originalBackgroundPicture.x, cast(float)_originalBackgroundPicture.y, cast(float)_originalBackgroundPicture.width, cast(float)_originalBackgroundPicture.height);

      if (_displayableBackgroundPicture) {
        auto backgroundSprite = _backgroundPicture.backgroundSprite;
        auto drawingSprite = _backgroundPicture.drawingSprite;

        if (backgroundSprite) {
          backgroundSprite.position = new Point(_originalBackgroundPicture.x, _originalBackgroundPicture.y);
          backgroundSprite.textureRect = IntRect(0, 0, cast(int)_originalBackgroundPicture.width, cast(int)_originalBackgroundPicture.height);
        }

        if (drawingSprite) {
          drawingSprite.position = new Point(_originalBackgroundPicture.x, _originalBackgroundPicture.y);
          drawingSprite.textureRect = IntRect(0, 0, cast(int)_originalBackgroundPicture.width, cast(int)_originalBackgroundPicture.height);
        }

        auto overflow = calculateOverflow(cast(float)_originalBackgroundPicture.x, cast(float)_originalBackgroundPicture.y, cast(float)_originalBackgroundPicture.width, cast(float)_originalBackgroundPicture.height);

        if (backgroundSprite) {
          backgroundSprite.textureRect = IntRect(cast(int)overflow.overflowLeft, cast(int)overflow.overflowTop, cast(int)overflow.width, cast(int)overflow.height);
          backgroundSprite.position = new Point(cast(ptrdiff_t)overflow.x, cast(ptrdiff_t)overflow.y);
        }

        if (drawingSprite) {
          drawingSprite.textureRect = IntRect(cast(int)overflow.overflowLeft, cast(int)overflow.overflowTop, cast(int)overflow.width, cast(int)overflow.height);
          drawingSprite.position = new Point(cast(ptrdiff_t)overflow.x, cast(ptrdiff_t)overflow.y);
        }
      }
    }
  }
}
