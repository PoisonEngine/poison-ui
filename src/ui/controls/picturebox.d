/**
* Module for a picturebox.
*
* Authors:
*   Jacob Jensen
* License:
*   https://github.com/PoisonEngine/poison-ui/blob/master/LICENSE
*/
module poison.ui.controls.picturebox;

import poison.ui.picture;
import poison.ui.sprite;
import poison.ui.container;

import poison.core : Point, Size;

/// A container for a picture.
class PictureBox : Container {
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

    super.graphics.backgroundPicture = picture;
    size = super.graphics.backgroundPicture.size;

    addSelector("picturebox");
  }

  @property {
    /// Gets the picture.
    Picture picture() { return super.graphics.backgroundPicture; }

    /// Gets the position of the picturebox.
    override Point position() { return super.position; }

    /// Sets the position of the picturebox.
    override void position(Point newPosition) {
      super.graphics.backgroundPicture.position = newPosition;

      super.position = newPosition;
    }
  }
}
