module poison.core.vector;

/**
* Vector mixin template to create vector types.
* Params:
*   T =     The type of the vector.
*   names = The names of all members of the vector.
*/
private mixin template Vector(T, string[] names) {
  /// Format for members.
  enum memberFormat = q{
    private %s _%s;
  };

  /// Format for properties.
  enum propertyFormat = q{
    @property {
      public auto %s() { return _%s; }

      public void %s(%s newValue) { _%s = newValue; }
    }
  };

  /// Format for parameters.
  enum paramFormat = "%s %s,";

  /// Format for member sets.
  enum memberSetFormat = "_%s = %s;";

  /// Generates the constructor.
  static string generateConstructor() {
    import std.string : format;

    auto paramsString = "";
    auto memberSetString = "";

    foreach (name; names) {
      paramsString ~= paramFormat.format(T.stringof, name);

      memberSetString ~= memberSetFormat.format(name, name);
    }

    if (paramsString) {
      paramsString.length -= 1;
    }

    return "this(" ~ paramsString ~ ") { " ~ memberSetString ~ " }";
  }

  mixin(generateConstructor);

  /// Generates the members.
  static string generateMembers() {
    import std.string : format;

    auto membersString = "";

    foreach (name; names) {
      membersString ~= memberFormat.format(T.stringof, name);
    }

    return membersString;
  }

  mixin(generateMembers);

  /// Generates the properties.
  static string generateProperties() {
    import std.string : format;

    auto propertiesString = "";

    foreach (name; names) {
      propertiesString ~= propertyFormat.format(name, name, name, T.stringof, name);
    }

    return propertiesString;
  }

  mixin(generateProperties);
}

/// A 2d point vector.
private class Point2dVector(T) {
  mixin Vector!(T, ["x", "y"]);
}

/// Alias to create a 2d point vector of ptrdiff_t.
public alias Point = Point2dVector!ptrdiff_t;

/// Alias to create a 2d point vector of float.
public alias PointF = Point2dVector!float;

/// A 3d point vector.
private class Point3dVector(T) {
  mixin Vector!(T, ["x", "y", "z"]);
}

/// Alias to create a 3d point vector of ptrdiff_t.
public alias Point3d = Point3dVector!ptrdiff_t;

/// Alias to create a 3d point vector of float.
public alias Point3dF = Point3dVector!float;

/// A 2d size vector.
private class Size2dVector(T) {
  mixin Vector!(T, ["width", "height"]);
}

/// Alias to create a 2d size vector of size_t.
public alias Size = Size2dVector!size_t;

/// Alias to create a 2d size vector of float.
public alias SizeF = Size2dVector!float;

/// A 3d size vector.
private class Size3dVector(T) {
  mixin Vector!(T, ["width", "height", "depth"]);
}

/// Alias to create a 3d size vector of size_t.
public alias Size3d = Size3dVector!size_t;

/// Alias to create a 3d size vector of float.
public alias Size3dF = Size3dVector!float;

/// An edge vector.
private class EdgeVector(T) {
  mixin Vector!(T, ["top", "right", "bottom", "left"]);
}

/// Alias to create an edge vector of ptrdiff_t.
public alias Edge = EdgeVector!ptrdiff_t;

/// Alias to create an edge vector of float.
public alias EdgeF = EdgeVector!float;
