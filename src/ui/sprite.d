/**
* Module for texture sprite handling.
*
* Authors:
*   Jacob Jensen
* License:
*   https://github.com/PoisonEngine/poison-ui/blob/master/LICENSE
*/
module poison.ui.sprite;

import dsfml.graphics : Sprite, Texture;
import dsfml.system : Vector2f;

import poison.core : Point;

/// An extension class to the sprite implementation of Dsfml.
class TextureSprite : Sprite {
  private:
  /// The position of the sprite.
  Point _position;

  public:
  /**
	*	Creates a new texture sprite.
	*	Params:
	*		texture =	The texture of the sprite.
	*/
	this(Texture texture) {
		super(texture);
	}

	@property {
		/// Gets the position of the sprite.
		Point position() { return _position; }

		/// Sets the position of the sprite.
		void position(Point newPosition) {
			_position = newPosition;

			super.position = Vector2f(_position.x, _position.y);
		}
	}
}
