module poison.ui.fonts;

import std.file : dirEntries, SpanMode;
import std.algorithm : filter, endsWith;
import std.string : toLower;
import std.path : stripExtension, baseName;

import dsfml.graphics : Font;

private Font[string] _fonts;

enum FontStyle {
  normal = "",
  bold = "b",
  italic = "i",
  boldItalic = "z"
}

void loadFonts(string path) {
  auto entries = dirEntries(path, SpanMode.depth).filter!(f => f.name.toLower().endsWith(".ttf"));

  foreach (string filePath; entries) {
    loadFont(filePath);
  }

  import std.stdio;
  writeln(_fonts);
}

void loadFont(string path) {
  auto font = new Font();
  font.loadFromFile(path);

  auto name = stripExtension(baseName(path));

  _fonts[name] = font;
}

Font retrieveFont(string fontName, FontStyle style) {
  return _fonts.get(fontName ~ style, null);
}
