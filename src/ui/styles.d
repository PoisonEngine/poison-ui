module poison.ui.styles;

import std.file : readText;
import std.json : parseJSON;
import std.conv : to;

import poison.ui.graphics;
import poison.ui.paint;

/// Table of styles.
private Graphics[string] _styles;

/**
* Gets a style entry.
* Params:
*   selector =  The selector to find the style for.
*/
Graphics getStyleEntry(string selector) {
  return _styles ? _styles.get(selector, null) : null;
}

/**
* Loads a style sheet.
* Params:
*   The style sheet to load.
*/
void loadStyleSheet(string styleSheet) {
  auto jsonText = readText(styleSheet);

  loadStyles(jsonText);
}

/**
* Loads styles from json structured pss.
* Params:
*   jsonText =  The json.
*/
void loadStyles(string jsonText) {
  if (!jsonText) {
    return;
  }

  auto json = parseJSON("{ " ~ jsonText ~ " }");
  auto entries = json.object;

  if (!entries) {
    return;
  }

  foreach (selector,entryJson; entries) {
    auto styles = entryJson.object;

    if (styles) {
      auto graphics = new Graphics();

      foreach (styleName,styleValue; styles) {
        import std.array : split;

        auto values = styleValue.str.split(";");

        assert(values);

        switch (styleName) {
          case "background-color": {
            assert(values.length == 3 || values.length == 4);

            ubyte r = to!ubyte(values[0]);
            ubyte g = to!ubyte(values[1]);
            ubyte b = to!ubyte(values[2]);
            ubyte a = 0xff;

            if (values.length == 4) {
              a = to!ubyte(values[3]);
            }

            graphics.backgroundPaint = paintFromRGBA(r, g, b, a);
            break;
          }

          case "foreground-color": {
            assert(values.length == 3 || values.length == 4);

            ubyte r = to!ubyte(values[0]);
            ubyte g = to!ubyte(values[1]);
            ubyte b = to!ubyte(values[2]);
            ubyte a = 0xff;

            if (values.length == 4) {
              a = to!ubyte(values[3]);
            }

            graphics.foregroundPaint = paintFromRGBA(r, g, b, a);
            break;
          }

          default: break;
        }
      }

      _styles[selector] = graphics;
    }
  }

  import poison.core : Application;

  auto app = Application.app;

  if (!app) {
    return;
  }

  app.updateStyles();
}
