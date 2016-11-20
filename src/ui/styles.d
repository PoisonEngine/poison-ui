module poison.ui.styles;

import std.file : readText;
import std.json : parseJSON;
import std.conv : to;
import std.array : split, replace;
import std.string : toLower;

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
        auto value = styleValue.str;

        assert(value);

        switch (styleName) {
          case "background-color": {
            if (value[0] == '#') {
              value = value[1 .. $].toLower();

              if (value.length == 3 && value[0] == value[1] && value[0] == value[2]) {
                value ~= value;
              }

              if (value.length == 6) {
                value ~= "ff";
              }

              auto values = [value[0 .. 2], value[2 .. 4], value[4 .. 6], value[6 .. $]];

              ubyte r = to!ubyte(values[0], 16);
              ubyte g = to!ubyte(values[1], 16);
              ubyte b = to!ubyte(values[2], 16);
              ubyte a = to!ubyte(values[3], 16);

              graphics.backgroundPaint = paintFromRGBA(r, g, b, a);
            }
            else {
              auto values = value.split(";");

              if (values.length > 1) {
                assert(values.length == 3 || values.length == 4);

                ubyte r = to!ubyte(values[0]);
                ubyte g = to!ubyte(values[1]);
                ubyte b = to!ubyte(values[2]);
                ubyte a = 0xff;

                if (values.length == 4) {
                  a = to!ubyte(values[3]);
                }

                graphics.backgroundPaint = paintFromRGBA(r, g, b, a);
              }
              else {
                graphics.backgroundPaint = paintFromName(value);
              }
            }

            break;
          }

          case "foreground-color": {
            if (value[0] == '#') {
              value = value[1 .. $].toLower();

              if (value.length == 3 && value[0] == value[1] && value[0] == value[2]) {
                value ~= value;
              }

              if (value.length == 6) {
                value ~= "ff";
              }

              auto values = [value[0 .. 2], value[2 .. 4], value[4 .. 6], value[6 .. $]];

              ubyte r = to!ubyte(values[0], 16);
              ubyte g = to!ubyte(values[1], 16);
              ubyte b = to!ubyte(values[2], 16);
              ubyte a = to!ubyte(values[3], 16);

              graphics.foregroundPaint = paintFromRGBA(r, g, b, a);
            }
            else {
              auto values = value.split(";");

              if (values.length > 1) {
                assert(values.length == 3 || values.length == 4);

                ubyte r = to!ubyte(values[0]);
                ubyte g = to!ubyte(values[1]);
                ubyte b = to!ubyte(values[2]);
                ubyte a = 0xff;

                if (values.length == 4) {
                  a = to!ubyte(values[3]);
                }

                graphics.foregroundPaint = paintFromRGBA(r, g, b, a);
              }
              else {
                graphics.foregroundPaint = paintFromName(value);
              }
            }

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
