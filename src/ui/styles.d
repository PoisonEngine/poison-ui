module poison.ui.styles;

import std.file : readText;
import std.json : parseJSON;
import std.conv : to;
import std.array : split, replace;
import std.string : toLower;
import std.algorithm : strip, stripLeft, stripRight, countUntil;
import std.base64 : Base64;

import poison.ui.graphics;
import poison.ui.paint;
import poison.ui.picture;

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

        final switch (styleName) {
          case "background": {
            auto groups = value.split("|");

            foreach (group; groups) {
              auto separatorIndex = countUntil(group, ":");
              auto propertyName = group[0 .. separatorIndex];
              auto propertyValue = group[separatorIndex + 1 .. $];

              final switch (propertyName) {
                case "color": {
                  graphics.backgroundPaint = handlePaintInput(propertyValue);
                  break;
                }

                case "image": {
                  graphics.backgroundPicture = handleImageInput(propertyValue);
                  break;
                }
              }
            }
            break;
          }

          case "background-color": {
            graphics.backgroundPaint = handlePaintInput(value);
            break;
          }

          case "background-image": {
            graphics.backgroundPicture = handleImageInput(value);
            break;
          }

          case "foreground-color": {
            graphics.foregroundPaint = handlePaintInput(value);
            break;
          }
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

private:
/**
* Handles paint input.
* Params:
*   value = The value of the paint input.
* Returns:
*   The generated paint from the value.
*/
Paint handlePaintInput(string value) {
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

    return paintFromRGBA(r, g, b, a);
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

      return paintFromRGBA(r, g, b, a);
    }

    return paintFromName(value);
  }
}

/**
* Handles image inputs.
* Params:
*   value = The image input.
* Returns:
*   The generated picture from the value.
*/
Picture handleImageInput(string value) {
  auto data = value.split(":");

  if (data.length == 1) {
    return new Picture(value);
  }
  else {
    assert(data.length == 2);

    auto propertyName = data[0];
    auto propertyValue = data[1];

    final switch (propertyName) {
      case "base64": {
        auto buffer = Base64.decode(propertyValue);

        return new Picture(buffer);
      }
    }
  }
}
