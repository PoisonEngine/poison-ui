module poison.ui.container;

import std.algorithm : filter;
import std.array : array;

public import dsfml.graphics : RenderWindow;

import poison.ui.component;
import poison.core : Size, Point, ActionArgs, executeUI;

/// A container component.
class Container : Component {
  private:
  /// The components.
  Component[][] _components;

  public:
  /**
  * Creates a new container.
  * Params:
  *   name =        The name of the container.
  *   initialSize = The initial size of the container.
  *   layers =      The layers of the container.
  */
  this(string name, Size initialSize, size_t layers) {
    assert(layers > 0);

    super(name, initialSize);

    _components = new Component[][layers];

    foreach (i; 0 .. _components.length) {
      _components[i] = [];
    }

    addSelector("container");
  }

  /**
  * Creates a new container.
  * Params:
  *   name =        The name of the container.
  *   layers =      The layers of the container.
  */
  this(string name, size_t layers) {
    this(name, new Size(100, 100), layers);
  }

  /**
  * Adds a component to the container.
  * Params:
  *   child = The child component to add.
  *   layer = The layer to add the component to.
  */
  void add(Component child, size_t layer) {
    assert(layer >= 0);
    assert(layer < _components.length);
    assert(child !is null);
    assert(child.layer == -1);

    executeUI({
      _components[layer] ~= child;

      child.layer = cast(ptrdiff_t)layer;
      child.parentWindow = parentWindow;
      parentWindow._windowComponents[child.id] = child;

      child.show();
    });
  }

  /**
  * Adds an array of components to the container.
  * Params:
  *   components = The child components to add.
  *   layer = The layer to add the components to.
  */
  void add(Component[] components, size_t layer) {
    assert(components && components.length);

    executeUI({
      foreach (component; components) {
        add(component, layer);
      }
    });
  }

  /**
  * Removes a component from the container.
  * Params:
  *   child = The child component to remove.
  */
  void remove(Component child) {
    assert(child.layer != -1);

    executeUI({
      auto children = _components[child.layer];

      if (children) {
        children = children.filter!((c) { return c.id == child.id; }).array;

        _components[layer] = children;
      }

      child.layer = -1;
      child.parentWindow._windowComponents.remove(child.id);
      child.parentWindow = null;
    });
  }

  /**
  * Removes a component from the container.
  * Params:
  *   name =  The name of the component.
  */
  void remove(string name) {
    executeUI({
      foreach (ref children; _components) {
        if (children) {
          children = children.filter!((c) { return c.name == name; }).array;
        }
      }
    });
  }

  /// Clears the component for children.
  void clear() {
    executeUI({
      foreach (children; _components) {
        if (children) {
          foreach (component; children) {
            if (component) {
              component.layer = -1;
            }
          }
        }
      }

      _components = new Component[][_components.length];
    });
  }

  /**
  * Clears the components for a specific layer.
  * Params:
  *   layer = The layer to clear.
  */
  void clear(size_t layer) {
    assert(layer >= 0);
    assert(layer < _components.length);

    executeUI({
      auto children = _components[layer];

      if (children) {
        foreach (component; children) {
          if (component) {
            component.layer = -1;
          }
        }
      }

      _components[layer] = [];
    });
  }

  protected:
  /**
  * Processes the container during application cycles.
  * Params:
  *   window =        The render window to process.
  */
  override void process(RenderWindow window) {
    super.process(window);

    foreach (children; _components) {
      if (children) {
        foreach (component; children) {
          if (component) {
            component.processInternal(window);
          }
        }
      }
    }
  }
}
