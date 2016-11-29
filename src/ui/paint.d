/**
* Module for paint.
*
* Authors:
*   Jacob Jensen
* License:
*   https://github.com/PoisonEngine/poison-ui/blob/master/LICENSE
*/
module poison.ui.paint;

import dsfml.graphics : Color;

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

/**
* Gets paint from a color name.
* Params:
*   name =  The name of the color.
* Returns:
*   The paint.
*/
Paint paintFromName(string name) {
  import std.string : toLower;

  switch (name.toLower()) {
    case "aliceblue": return aliceBlue;
    case "antiquewhite": return antiqueWhite;
    case "aqua": return aqua;
    case "aquamarine": return aquamarine;
    case "azure": return azure;
    case "beige": return beige;
    case "bisque": return bisque;
    case "black": return black;
    case "blanchedalmond": return blanchedAlmond;
    case "blue": return blue;
    case "blueviolet": return blueViolet;
    case "brown": return brown;
    case "burlywood": return burlyWood;
    case "cadetblue": return cadetBlue;
    case "chartreuse": return chartreuse;
    case "chocolate": return chocolate;
    case "coral": return coral;
    case "cornflowerblue": return cornflowerBlue;
    case "cornsilk": return cornsilk;
    case "crimson": return crimson;
    case "cyan": return cyan;
    case "darkblue": return darkBlue;
    case "darkcyan": return darkCyan;
    case "darkgoldenrod": return darkGoldenrod;
    case "darkgrey": return darkGrey;
    case "darkgray": return darkGray;
    case "darkgreen": return darkGreen;
    case "darkkhaki": return darkKhaki;
    case "darkmagenta": return darkMagenta;
    case "darkolivegreen": return darkOliveGreen;
    case "darkorange": return darkOrange;
    case "darkorchid": return darkOrchid;
    case "darkred": return darkRed;
    case "darksalmon": return darkSalmon;
    case "darkseagreen": return darkSeaGreen;
    case "darkslateblue": return darkSlateBlue;
    case "darkslategray": return darkSlateGray;
    case "darkslategrey": return darkSlateGrey;
    case "darkturquoise": return darkTurquoise;
    case "darkviolet": return darkViolet;
    case "deeppink": return deepPink;
    case "deepskyblue": return deepSkyBlue;
    case "dimgray": return dimGray;
    case "dimgrey": return dimGrey;
    case "dodgerblue": return dodgerBlue;
    case "firebrick": return fireBrick;
    case "floralwhite": return floralWhite;
    case "forestgreen": return forestGreen;
    case "fuchsia": return fuchsia;
    case "gainsboro": return gainsboro;
    case "ghostwhite": return ghostWhite;
    case "gold": return gold;
    case "goldenrod": return goldenrod;
    case "gray": return gray;
    case "grey": return grey;
    case "green": return green;
    case "greenyellow": return greenYellow;
    case "honeydew": return honeydew;
    case "hotpink": return hotPink;
    case "indianred": return indianRed;
    case "indigo": return indigo;
    case "ivory": return ivory;
    case "khaki": return khaki;
    case "lavender": return lavender;
    case "lavenderblush": return lavenderBlush;
    case "lawngreen": return lawnGreen;
    case "lemonchiffon": return lemonChiffon;
    case "lightblue": return lightBlue;
    case "lightcoral": return lightCoral;
    case "lightcyan": return lightCyan;
    case "lightgoldenrodyellow": return lightGoldenrodYellow;
    case "lightgreen": return lightGreen;
    case "lightgray": return lightGray;
    case "lightgrey": return lightGrey;
    case "lightpink": return lightPink;
    case "lightsalmon": return lightSalmon;
    case "lightseagreen": return lightSeaGreen;
    case "lightskyblue": return lightSkyBlue;
    case "lightslategray": return lightSlateGray;
    case "lightslategrey": return lightSlateGrey;
    case "lightsteelblue": return lightSteelBlue;
    case "lightyellow": return lightYellow;
    case "lime": return lime;
    case "limegreen": return limeGreen;
    case "linen": return linen;
    case "magenta": return magenta;
    case "maroon": return maroon;
    case "mediumaquamarine": return mediumAquamarine;
    case "mediumblue": return mediumBlue;
    case "mediumorchid": return mediumOrchid;
    case "mediumpurple": return mediumPurple;
    case "mediumseagreen": return mediumSeaGreen;
    case "mediumslateblue": return mediumSlateBlue;
    case "mediumspringgreen": return mediumSpringGreen;
    case "mediumturquoise": return mediumTurquoise;
    case "mediumvioletred": return mediumVioletRed;
    case "midnightblue": return midnightBlue;
    case "mintcream": return mintCream;
    case "mistyrose": return mistyRose;
    case "moccasin": return moccasin;
    case "navajowhite": return navajoWhite;
    case "navy": return navy;
    case "oldlace": return oldLace;
    case "olive": return olive;
    case "olivedrab": return oliveDrab;
    case "orange": return orange;
    case "orangered": return orangeRed;
    case "orchid": return orchid;
    case "palegoldenrod": return paleGoldenrod;
    case "palegreen": return paleGreen;
    case "paleturquoise": return paleTurquoise;
    case "palevioletred": return paleVioletRed;
    case "papayawhip": return papayaWhip;
    case "peachpuff": return peachPuff;
    case "peru": return peru;
    case "pink": return pink;
    case "plum": return plum;
    case "powderblue": return powderBlue;
    case "purple": return purple;
    case "red": return red;
    case "rosybrown": return rosyBrown;
    case "royalblue": return royalBlue;
    case "saddlebrown": return saddleBrown;
    case "salmon": return salmon;
    case "sandybrown": return sandyBrown;
    case "seagreen": return seaGreen;
    case "seashell": return seashell;
    case "sienna": return sienna;
    case "silver": return silver;
    case "skyblue": return skyBlue;
    case "slateblue": return slateBlue;
    case "slategray": return slateGray;
    case "slategrey": return slateGrey;
    case "snow": return snow;
    case "springgreen": return springGreen;
    case "steelblue": return steelBlue;
    case "tan": return tan;
    case "teal": return teal;
    case "thistle": return thistle;
    case "tomato": return tomato;
    case "turquoise": return turquoise;
    case "violet": return violet;
    case "wheat": return wheat;
    case "white": return white;
    case "whitesmoke": return whiteSmoke;
    case "yellow": return yellow;
    case "yellowgreen": return yellowGreen;
    default: return transparent;
  }
}

/* Contrast & Misc */

///	White paint.
Paint white = paintFromRGBA(0xff, 0xff, 0xff);

///	Black paint.
Paint black = paintFromRGBA(0x00, 0x00, 0x00);

/// Transparent paint.
Paint transparent = paintFromRGBA(0x00, 0x00, 0x00, 0x00);

/* Standard */

///	Red paint.
Paint red = paintFromRGBA(0xff, 0x00, 0x00);

///	Green paint.
Paint green = paintFromRGBA(0x00, 0xff, 0x00);

///	Blue paint.
Paint blue = paintFromRGBA(0x00, 0x00, 0xff);

/* System colors */

/// AliceBlue paint.
Paint aliceBlue = paintFromRGBA(0xf0, 0xf8, 0xff);

/// AntiqueWhite paint.
Paint antiqueWhite = paintFromRGBA(0xfa, 0xeb, 0xd7);

/// Aqua paint.
Paint aqua = paintFromRGBA(0x00, 0xff, 0xff);

/// Aquamarine paint.
Paint aquamarine = paintFromRGBA(0x7f, 0xff, 0xd4);

/// Azure paint.
Paint azure = paintFromRGBA(0xf0, 0xff, 0xff);

/// Beige paint.
Paint beige = paintFromRGBA(0xf5, 0xf5, 0xdc);

/// Bisque paint.
Paint bisque = paintFromRGBA(0xff, 0xe4, 0xc4);

/// BlanchedAlmond paint.
Paint blanchedAlmond = paintFromRGBA(0xff, 0xeb, 0xcd);

/// BlueViolet paint.
Paint blueViolet = paintFromRGBA(0x8a, 0x2b, 0xe2);

/// Brown paint.
Paint brown = paintFromRGBA(0xa5, 0x2a, 0x2a);

/// BurlyWood paint.
Paint burlyWood = paintFromRGBA(0xde, 0xb8, 0x87);

/// CadetBlue paint.
Paint cadetBlue = paintFromRGBA(0x5f, 0x9e, 0xa0);

/// Chartreuse paint.
Paint chartreuse = paintFromRGBA(0x7f, 0xff, 0x00);

/// Chocolate paint.
Paint chocolate = paintFromRGBA(0xd2, 0x69, 0x1e);

/// Coral paint.
Paint coral = paintFromRGBA(0xff, 0x7f, 0x50);

/// CornflowerBlue paint.
Paint cornflowerBlue = paintFromRGBA(0x64, 0x95, 0xed);

/// Cornsilk paint.
Paint cornsilk = paintFromRGBA(0xff, 0xf8, 0xdc);

/// Crimson paint.
Paint crimson = paintFromRGBA(0xdc, 0x14, 0x3c);

/// Cyan paint.
Paint cyan = paintFromRGBA(0x00, 0xff, 0xff);

/// DarkBlue paint.
Paint darkBlue = paintFromRGBA(0x00, 0x00, 0x8b);

/// DarkCyan paint.
Paint darkCyan = paintFromRGBA(0x00, 0x8b, 0x8b);

/// DarkGoldenrod paint.
Paint darkGoldenrod = paintFromRGBA(0xb8, 0x86, 0x0b);

/// DarkGrey paint.
Paint darkGrey = paintFromRGBA(0xa9, 0xa9, 0xa9);

/// DarkGray paint.
Paint darkGray = paintFromRGBA(0xa9, 0xa9, 0xa9);

/// DarkGreen paint.
Paint darkGreen = paintFromRGBA(0x00, 0x64, 0x00);

/// DarkKhaki paint.
Paint darkKhaki = paintFromRGBA(0xbd, 0xb7, 0x6b);

/// DarkMagenta paint.
Paint darkMagenta = paintFromRGBA(0x8b, 0x00, 0x8b);

/// DarkOliveGreen paint.
Paint darkOliveGreen = paintFromRGBA(0x55, 0x6b, 0x2f);

/// DarkOrange paint.
Paint darkOrange = paintFromRGBA(0xff, 0x8c, 0x00);

/// DarkOrchid paint.
Paint darkOrchid = paintFromRGBA(0x99, 0x32, 0xcc);

/// DarkRed paint.
Paint darkRed = paintFromRGBA(0x8b, 0x00, 0x00);

/// DarkSalmon paint.
Paint darkSalmon = paintFromRGBA(0xe9, 0x96, 0x7a);

/// DarkSeaGreen paint.
Paint darkSeaGreen = paintFromRGBA(0x8f, 0xbc, 0x8f);

/// DarkSlateBlue paint.
Paint darkSlateBlue = paintFromRGBA(0x48, 0x3d, 0x8b);

/// DarkSlateGray paint.
Paint darkSlateGray = paintFromRGBA(0x2f, 0x4f, 0x4f);

/// DarkSlateGrey paint.
Paint darkSlateGrey = paintFromRGBA(0x2f, 0x4f, 0x4f);

/// DarkTurquoise paint.
Paint darkTurquoise = paintFromRGBA(0x00, 0xce, 0xd1);

/// DarkViolet paint.
Paint darkViolet = paintFromRGBA(0x94, 0x00, 0xd3);

/// DeepPink paint.
Paint deepPink = paintFromRGBA(0xff, 0x14, 0x93);

/// DeepSkyBlue paint.
Paint deepSkyBlue = paintFromRGBA(0x00, 0xbf, 0xff);

/// DimGray paint.
Paint dimGray = paintFromRGBA(0x69, 0x69, 0x69);

/// DimGrey paint.
Paint dimGrey = paintFromRGBA(0x69, 0x69, 0x69);

/// DodgerBlue paint.
Paint dodgerBlue = paintFromRGBA(0x1e, 0x90, 0xff);

/// FireBrick paint.
Paint fireBrick = paintFromRGBA(0xb2, 0x22, 0x22);

/// FloralWhite paint.
Paint floralWhite = paintFromRGBA(0xff, 0xfa, 0xf0);

/// ForestGreen paint.
Paint forestGreen = paintFromRGBA(0x22, 0x8b, 0x22);

/// Fuchsia paint.
Paint fuchsia = paintFromRGBA(0xff, 0x00, 0xff);

/// Gainsboro paint.
Paint gainsboro = paintFromRGBA(0xdc, 0xdc, 0xdc);

/// GhostWhite paint.
Paint ghostWhite = paintFromRGBA(0xf8, 0xf8, 0xff);

/// Gold paint.
Paint gold = paintFromRGBA(0xff, 0xd7, 0x00);

/// Goldenrod paint.
Paint goldenrod = paintFromRGBA(0xda, 0xa5, 0x20);

/// Gray paint.
Paint gray = paintFromRGBA(0x80, 0x80, 0x80);

/// Grey paint.
Paint grey = paintFromRGBA(0x80, 0x80, 0x80);

/// GreenYellow paint.
Paint greenYellow = paintFromRGBA(0xad, 0xff, 0x2f);

/// Honeydew paint.
Paint honeydew = paintFromRGBA(0xf0, 0xff, 0xf0);

/// HotPink paint.
Paint hotPink = paintFromRGBA(0xff, 0x69, 0xb4);

/// IndianRed paint.
Paint indianRed = paintFromRGBA(0xcd, 0x5c, 0x5c);

/// Indigo paint.
Paint indigo = paintFromRGBA(0x4b, 0x00, 0x82);

/// Ivory paint.
Paint ivory = paintFromRGBA(0xff, 0xff, 0xf0);

/// Khaki paint.
Paint khaki = paintFromRGBA(0xf0, 0xe6, 0x8c);

/// Lavender paint.
Paint lavender = paintFromRGBA(0xe6, 0xe6, 0xfa);

/// LavenderBlush paint.
Paint lavenderBlush = paintFromRGBA(0xff, 0xf0, 0xf5);

/// LawnGreen paint.
Paint lawnGreen = paintFromRGBA(0x7c, 0xfc, 0x00);

/// LemonChiffon paint.
Paint lemonChiffon = paintFromRGBA(0xff, 0xfa, 0xcd);

/// LightBlue paint.
Paint lightBlue = paintFromRGBA(0xad, 0xd8, 0xe6);

/// LightCoral paint.
Paint lightCoral = paintFromRGBA(0xf0, 0x80, 0x80);

/// LightCyan paint.
Paint lightCyan = paintFromRGBA(0xe0, 0xff, 0xff);

/// LightGoldenrodYellow paint.
Paint lightGoldenrodYellow = paintFromRGBA(0xfa, 0xfa, 0xd2);

/// LightGreen paint.
Paint lightGreen = paintFromRGBA(0x90, 0xee, 0x90);

/// LightGray paint.
Paint lightGray = paintFromRGBA(0xd3, 0xd3, 0xd3);

/// LightGrey paint.
Paint lightGrey = paintFromRGBA(0xd3, 0xd3, 0xd3);

/// LightPink paint.
Paint lightPink = paintFromRGBA(0xff, 0xb6, 0xc1);

/// LightSalmon paint.
Paint lightSalmon = paintFromRGBA(0xff, 0xa0, 0x7a);

/// LightSeaGreen paint.
Paint lightSeaGreen = paintFromRGBA(0x20, 0xb2, 0xaa);

/// LightSkyBlue paint.
Paint lightSkyBlue = paintFromRGBA(0x87, 0xce, 0xfa);

/// LightSlateGray paint.
Paint lightSlateGray = paintFromRGBA(0x77, 0x88, 0x99);

/// LightSlateGrey paint.
Paint lightSlateGrey = paintFromRGBA(0x77, 0x88, 0x99);

/// LightSteelBlue paint.
Paint lightSteelBlue = paintFromRGBA(0xb0, 0xc4, 0xde);

/// LightYellow paint.
Paint lightYellow = paintFromRGBA(0xff, 0xff, 0xe0);

/// Lime paint.
Paint lime = paintFromRGBA(0x00, 0xff, 0x00);

/// LimeGreen paint.
Paint limeGreen = paintFromRGBA(0x32, 0xcd, 0x32);

/// Linen paint.
Paint linen = paintFromRGBA(0xfa, 0xf0, 0xe6);

/// Magenta paint.
Paint magenta = paintFromRGBA(0xff, 0x00, 0xff);

/// Maroon paint.
Paint maroon = paintFromRGBA(0x80, 0x00, 0x00);

/// MediumAquamarine paint.
Paint mediumAquamarine = paintFromRGBA(0x66, 0xcd, 0xaa);

/// MediumBlue paint.
Paint mediumBlue = paintFromRGBA(0x00, 0x00, 0xcd);

/// MediumOrchid paint.
Paint mediumOrchid = paintFromRGBA(0xba, 0x55, 0xd3);

/// MediumPurple paint.
Paint mediumPurple = paintFromRGBA(0x93, 0x70, 0xdb);

/// MediumSeaGreen paint.
Paint mediumSeaGreen = paintFromRGBA(0x3c, 0xb3, 0x71);

/// MediumSlateBlue paint.
Paint mediumSlateBlue = paintFromRGBA(0x7b, 0x68, 0xee);

/// MediumSpringGreen paint.
Paint mediumSpringGreen = paintFromRGBA(0x00, 0xfa, 0x9a);

/// MediumTurquoise paint.
Paint mediumTurquoise = paintFromRGBA(0x48, 0xd1, 0xcc);

/// MediumVioletRed paint.
Paint mediumVioletRed = paintFromRGBA(0xc7, 0x15, 0x85);

/// MidnightBlue paint.
Paint midnightBlue = paintFromRGBA(0x19, 0x19, 0x70);

/// MintCream paint.
Paint mintCream = paintFromRGBA(0xf5, 0xff, 0xfa);

/// MistyRose paint.
Paint mistyRose = paintFromRGBA(0xff, 0xe4, 0xe1);

/// Moccasin paint.
Paint moccasin = paintFromRGBA(0xff, 0xe4, 0xb5);

/// NavajoWhite paint.
Paint navajoWhite = paintFromRGBA(0xff, 0xde, 0xad);

/// Navy paint.
Paint navy = paintFromRGBA(0x00, 0x00, 0x80);

/// OldLace paint.
Paint oldLace = paintFromRGBA(0xfd, 0xf5, 0xe6);

/// Olive paint.
Paint olive = paintFromRGBA(0x80, 0x80, 0x00);

/// OliveDrab paint.
Paint oliveDrab = paintFromRGBA(0x6b, 0x8e, 0x23);

/// Orange paint.
Paint orange = paintFromRGBA(0xff, 0xa5, 0x00);

/// OrangeRed paint.
Paint orangeRed = paintFromRGBA(0xff, 0x45, 0x00);

/// Orchid paint.
Paint orchid = paintFromRGBA(0xda, 0x70, 0xd6);

/// PaleGoldenrod paint.
Paint paleGoldenrod = paintFromRGBA(0xee, 0xe8, 0xaa);

/// PaleGreen paint.
Paint paleGreen = paintFromRGBA(0x98, 0xfb, 0x98);

/// PaleTurquoise paint.
Paint paleTurquoise = paintFromRGBA(0xaf, 0xee, 0xee);

/// PaleVioletRed paint.
Paint paleVioletRed = paintFromRGBA(0xdb, 0x70, 0x93);

/// PapayaWhip paint.
Paint papayaWhip = paintFromRGBA(0xff, 0xef, 0xd5);

/// PeachPuff paint.
Paint peachPuff = paintFromRGBA(0xff, 0xda, 0xb9);

/// Peru paint.
Paint peru = paintFromRGBA(0xcd, 0x85, 0x3f);

/// Pink paint.
Paint pink = paintFromRGBA(0xff, 0xc0, 0xcb);

/// Plum paint.
Paint plum = paintFromRGBA(0xdd, 0xa0, 0xdd);

/// PowderBlue paint.
Paint powderBlue = paintFromRGBA(0xb0, 0xe0, 0xe6);

/// Purple paint.
Paint purple = paintFromRGBA(0x80, 0x00, 0x80);

/// RosyBrown paint.
Paint rosyBrown = paintFromRGBA(0xbc, 0x8f, 0x8f);

/// RoyalBlue paint.
Paint royalBlue = paintFromRGBA(0x41, 0x69, 0xe1);

/// SaddleBrown paint.
Paint saddleBrown = paintFromRGBA(0x8b, 0x45, 0x13);

/// Salmon paint.
Paint salmon = paintFromRGBA(0xfa, 0x80, 0x72);

/// SandyBrown paint.
Paint sandyBrown = paintFromRGBA(0xf4, 0xa4, 0x60);

/// SeaGreen paint.
Paint seaGreen = paintFromRGBA(0x2e, 0x8b, 0x57);

/// Seashell paint.
Paint seashell = paintFromRGBA(0xff, 0xf5, 0xee);

/// Sienna paint.
Paint sienna = paintFromRGBA(0xa0, 0x52, 0x2d);

/// Silver paint.
Paint silver = paintFromRGBA(0xc0, 0xc0, 0xc0);

/// SkyBlue paint.
Paint skyBlue = paintFromRGBA(0x87, 0xce, 0xeb);

/// SlateBlue paint.
Paint slateBlue = paintFromRGBA(0x6a, 0x5a, 0xcd);

/// SlateGray paint.
Paint slateGray = paintFromRGBA(0x70, 0x80, 0x90);

/// SlateGrey paint.
Paint slateGrey = paintFromRGBA(0x70, 0x80, 0x90);

/// Snow paint.
Paint snow = paintFromRGBA(0xff, 0xfa, 0xfa);

/// SpringGreen paint.
Paint springGreen = paintFromRGBA(0x00, 0xff, 0x7f);

/// SteelBlue paint.
Paint steelBlue = paintFromRGBA(0x46, 0x82, 0xb4);

/// Tan paint.
Paint tan = paintFromRGBA(0xd2, 0xb4, 0x8c);

/// Teal paint.
Paint teal = paintFromRGBA(0x00, 0x80, 0x80);

/// Thistle paint.
Paint thistle = paintFromRGBA(0xd8, 0xbf, 0xd8);

/// Tomato paint.
Paint tomato = paintFromRGBA(0xff, 0x63, 0x47);

/// Turquoise paint.
Paint turquoise = paintFromRGBA(0x40, 0xe0, 0xd0);

/// Violet paint.
Paint violet = paintFromRGBA(0xee, 0x82, 0xee);

/// Wheat paint.
Paint wheat = paintFromRGBA(0xf5, 0xde, 0xb3);

/// WhiteSmoke paint.
Paint whiteSmoke = paintFromRGBA(0xf5, 0xf5, 0xf5);

/// Yellow paint.
Paint yellow = paintFromRGBA(0xff, 0xff, 0x00);

/// YellowGreen paint.
Paint yellowGreen = paintFromRGBA(0x9a, 0xcd, 0x32);
