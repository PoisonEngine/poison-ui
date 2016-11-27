/**
* Module for fonts.
*
* Authors:
*   Jacob Jensen
* License:
*   https://github.com/PoisonEngine/poison-ui/blob/master/LICENSE
*/
module poison.ui.fonts;

import std.file : dirEntries, SpanMode;
import std.algorithm : filter, endsWith;
import std.string : toLower;
import std.path : stripExtension, baseName;

public import dsfml.graphics : Font;

/// The fonts.
private Font[string] _fonts;

/// Enumeration of font styles.
enum FontStyle {
  /// Normal font style.
  normal = "",

  /// Bold font style.
  bold = "b",

  /// Italic font style.
  italic = "i",

  /// Bold & italic font style.
  boldItalic = "z"
}

/**
* Loads all fonts within a specific path.
* Params:
*   path =  The path of the fonts.
*/
void loadFonts(string path) {
  auto entries = dirEntries(path, SpanMode.depth).filter!(f => f.name.toLower().endsWith(".ttf"));

  foreach (string filePath; entries) {
    loadFont(filePath);
  }
}

/**
* Loads a font by its path or retrieves it from the font cache.
* Params:
*   path =  The path of the font.
* Note:
*   The path can be a name too, but is required with the font-style suffix. Use retrieveFont for easier access.
*/
Font loadFont(string path) {
  auto font = _fonts.get(path, null);

  if (font) {
    return font;
  }

  font = new Font();
  font.loadFromFile(path);

  auto name = stripExtension(baseName(path));

  _fonts[name] = font;
  _fonts[path] = font;
  return font;
}

/**
* Retrieves a font by a name and style.
* Params:
*   fontName =  The name of the font to retrieve.
*   style =     The style of the font.
*/
Font retrieveFont(string fontName, FontStyle style) {
  return _fonts.get(fontName ~ style, null);
}
