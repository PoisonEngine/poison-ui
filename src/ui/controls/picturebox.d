module poison.ui.controls.picturebox;

import poison.ui.picture;
import poison.ui.sprite;
import poison.ui.container;

import poison.core : Point, Size;

/// A container for a picture.
class PictureBox : Container {
  private:
  /// The associated picture.
  Picture _picture;

  public:
  /**
  * Creates a new picture box.
  * Params:
  *   name =        The name of the pictue box.
  *   imageFile =   The image file to load into the picture.
  *   layers =      The amount of layers the picture box has.
  */
  this(string name, string imageFile, size_t layers = 1) {
    auto picture = new Picture(imageFile);
    picture.finalize();

    this(name, picture, layers);
  }

  /**
  * Creates a new picture box.
  * Params:
  *   name =        The name of the pictue box.
  *   picture =     The picture to initialize with.
  *   layers =      The amount of layers the picture box has.
  */
  this(string name, Picture picture, size_t layers) {
    assert(picture !is null);
    super(name, layers);

    _picture = picture;
    size = _picture.size;

    addSelector("picturebox");
  }

  @property {
    /// Gets the picture.
    Picture picture() { return _picture; }

    /// Gets the position of the picturebox.
    override Point position() { return super.position; }

    /// Sets the position of the picturebox.
    override void position(Point newPosition) {
      _picture.position = newPosition;

      super.position = newPosition;
    }
  }

  /**
  * Draws the picture box.
  * Params:
  *   window =  The window to draw the picture box onto.
  */
  override void draw(RenderWindow window) {
    super.draw(window);

    if (_picture) {
      if (_picture.backgroundSprite) {
        window.draw(_picture.backgroundSprite);
      }

      if (_picture.drawingSprite) {
        window.draw(_picture.drawingSprite);
      }
    }
  }
}
