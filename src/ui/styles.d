/**
* Module for style handling/parsing.
*
* Authors:
*   Jacob Jensen
* License:
*   https://github.com/PoisonEngine/poison-ui/blob/master/LICENSE
*/
module poison.ui.styles;

import std.file : readText;
import std.json : parseJSON, JSONValue;
import std.conv : to;
import std.array : split, replace;
import std.string : toLower, stripLeft, stripRight;
import std.algorithm : countUntil;
import std.base64 : Base64;

import poison.ui.graphics;
import poison.ui.paint;
import poison.ui.picture;
import poison.ui.fonts;
import poison.core : Point, Size;

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
        final switch (styleName) {
          case "background": {
            auto value = styleValue.str;

            handleGroups(graphics, value, (gfx, propertyName, propertyValue) {
              final switch (propertyName) {
                case "color": {
                  gfx.backgroundPaint = handlePaintInput(propertyValue);
                  break;
                }

                case "image": {
                  gfx.backgroundPicture = handleImageInput(graphics, propertyValue);
                  break;
                }
              }
            });
            break;
          }

          case "background-color": {
            auto value = styleValue.str;

            graphics.backgroundPaint = handlePaintInput(value);
            break;
          }

          case "background-image": {
            auto value = styleValue.str;

            graphics.backgroundPicture = handleImageInput(graphics, value);
            break;
          }

          case "foreground-color": {
            auto value = styleValue.str;

            graphics.foregroundPaint = handlePaintInput(value);
            break;
          }

          case "font": {
            auto value = styleValue.str;

            handleGroups(graphics, value, (gfx, propertyName, propertyValue) {
              final switch (propertyName) {
                case "name": {
                  gfx.font = handleFontInput(propertyValue);
                  break;
                }

                case "path": {
                  gfx.font = loadFont(propertyValue);
                  break;
                }

                case "size": {
                  gfx.fontSize = to!uint(propertyValue);
                  break;
                }
              }
            });
            break;
          }

          case "font-name": {
            auto value = styleValue.str;

            graphics.font = handleFontInput(value);
            break;
          }

          case "font-path": {
            auto value = styleValue.str;

            graphics.font = loadFont(value);
            break;
          }

          case "font-size": {
            auto value = styleValue.str;

            graphics.fontSize = to!uint(value);
            break;
          }

          case "size": {
            auto size = styleValue.str.split(";");

            graphics.size = new Size(to!size_t(size[0]), to!size_t(size[1]));
            graphics.hasSize = true;
            break;
          }

          case "position": {
            auto position = styleValue.str.split(";");

            graphics.position = new Point(to!ptrdiff_t(position[0]), to!ptrdiff_t(position[1]));
            graphics.hasPosition = true;
            break;
          }

          case "paint-color": {
            auto colors = styleValue.array;

            if (!colors) {
              break;
            }

            foreach (color; colors) {
              Point colorPosition;
              Size colorSize;
              Paint colorPaint;

              handleGroups(graphics, color.str, (gfx, propertyName, propertyValue) {
                final switch (propertyName) {
                  case "position": {
                    auto position = propertyValue.split(";");

                    if (position.length != 2) {
                      break;
                    }

                    colorPosition = new Point(to!ptrdiff_t(position[0]), to!ptrdiff_t(position[1]));
                    break;
                  }

                  case "size": {
                    auto size = propertyValue.split(";");

                    if (size.length != 2) {
                      break;
                    }

                    colorSize = new Size(to!size_t(size[0]), to!size_t(size[1]));
                    break;
                  }

                  case "color": {
                    colorPaint = handlePaintInput(propertyValue);
                    break;
                  }
                }
              });

              graphics.finalizePaint(colorPosition, colorSize, colorPaint);
            }
            break;
          }

          case "paint-gradient-hoz": {
            handleGradientInput(styleValue, graphics, false);
            break;
          }

          case "paint-gradient-ver": {
            handleGradientInput(styleValue, graphics, true);
            break;
          }
        }
      }

      if (graphics.backgroundPicture) {
        graphics.backgroundPicture.finalize();
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
* Handles group values.
* Params:
*   graphics =  The graphics to handle values for.
*   value =     The value to parse groups from.
*   predicate = A predicate to mutate the graphics.
*/
void handleGroups(Graphics graphics, string value, void delegate(Graphics, string, string) predicate) {
  assert(predicate !is null);

  auto groups = value.split("|");

  foreach (group; groups) {
    auto separatorIndex = countUntil(group, ":");
    auto propertyName = group[0 .. separatorIndex];
    auto propertyValue = group[separatorIndex + 1 .. $].stripLeft().stripRight();

    predicate(graphics, propertyName, propertyValue);
  }
}

/**
* Handles group values.
* Params:
*   graphics =  The graphics to handle values for.
*   value =     The value to parse groups from.
*   predicate = A predicate to mutate the graphics.
*/
void handleGroups(Graphics graphics, string value, void function(Graphics, string, string) predicate) {
  assert(predicate !is null);

  auto groups = value.split("|");

  foreach (group; groups) {
    auto separatorIndex = countUntil(group, ":");
    auto propertyName = group[0 .. separatorIndex];
    auto propertyValue = group[separatorIndex + 1 .. $];

    predicate(graphics, propertyName, propertyValue);
  }
}

/**
* Handles gradient input.
* Params:
*   styleValue =  The value of the style input.
*   graphics =    The graphics.
*   isVertical =  Boolean determining whether the gradient is vertical or not.
*/
void handleGradientInput(JSONValue styleValue, Graphics graphics, bool isVertical) {
  auto gradients = styleValue.array;

  if (!gradients) {
    return;
  }

  foreach (gradient; gradients) {
    Point gradientPosition;
    Size gradientSize;
    Paint fromColorPaint;
    Paint toColorPaint;

    handleGroups(graphics, gradient.str, (gfx, propertyName, propertyValue) {
      final switch (propertyName) {
        case "position": {
          auto position = propertyValue.split(";");

          if (position.length != 2) {
            break;
          }

          gradientPosition = new Point(to!ptrdiff_t(position[0]), to!ptrdiff_t(position[1]));
          break;
        }

        case "size": {
          auto size = propertyValue.split(";");

          if (size.length != 2) {
            break;
          }

          gradientSize = new Size(to!size_t(size[0]), to!size_t(size[1]));
          break;
        }

        case "fromColor": {
          fromColorPaint = handlePaintInput(propertyValue);
          break;
        }

        case "toColor": {
          toColorPaint = handlePaintInput(propertyValue);
          break;
        }
      }
    });

    if (isVertical) {
      graphics.finalizeGradientVertical(gradientPosition, gradientSize, fromColorPaint, toColorPaint);
    }
    else {
      graphics.finalizeGradientHorizontal(gradientPosition, gradientSize, fromColorPaint, toColorPaint);
    }
  }
}

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
*   graphics =  The graphics.
*   value =     The image input.
* Returns:
*   The generated picture from the value.
*/
Picture handleImageInput(Graphics graphics, string value) {
  auto data = value.split(":");

  if (data.length == 1) {
    if (graphics.backgroundPicture) {
      graphics.backgroundPicture.fileName = value;
      return graphics.backgroundPicture;
    }

    return new Picture(value);
  }
  else {
    assert(data.length == 2);

    auto propertyName = data[0];
    auto propertyValue = data[1];

    final switch (propertyName) {
      case "base64": {
        auto buffer = Base64.decode(propertyValue);

        if (graphics.backgroundPicture) {
          graphics.backgroundPicture.imageBuffer = buffer;
          return graphics.backgroundPicture;
        }

        return new Picture(buffer);
      }
    }
  }
}

/**
* Handles font input.
* Params:
*   value = The font input value.
*/
Font handleFontInput(string value) {
  auto values = value.split(";");
  auto fontName = values[0];

  if (values.length == 2) {
    return retrieveFont(fontName, to!FontStyle(values[1]));
  }

  return retrieveFont(fontName, FontStyle.normal);
}
