module poison.ui.paint;

import dsfml.graphics : Color;

/**
*	Gets a painting from RGBA.
*	Params:
*		r =		The red channel.
*		g =		The green channel.
*		b =		The blue channel.
*		a =		The alpha channel.
*	Returns:
*   The paint.
*/
Paint paintFromRGBA(ubyte r, ubyte g, ubyte b, ubyte a = 0xff) {
	Paint p;
	p.r = r;
	p.g = g;
	p.b = b;
	p.a = a;
	return p;
}

///	White paint.
Paint white = paintFromRGBA(0xff, 0xff, 0xff);
///	Black paint.
Paint black = paintFromRGBA(0x00, 0x00, 0x00);

///	Red paint.
Paint red = paintFromRGBA(0xff, 0x00, 0x00);
///	Green paint.
Paint green = paintFromRGBA(0x00, 0xff, 0x00);
///	Blue paint.
Paint blue = paintFromRGBA(0x00, 0x00, 0xff);

/// Paint structure.
struct Paint {
public:
	///	The red channel.
	ubyte r;
	///	The green channel.
	ubyte g;
	///	The blue channel.
	ubyte b;
	///	The alpha channel.
	ubyte a;

	@property {
    /// Gets the low-level sfml color equivalent to the paint.
  	Color sfmlColor() {
  		return Color(r,g,b,a);
  	}
  }
}
