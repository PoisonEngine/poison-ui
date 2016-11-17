module poison.core.eventargs.changeeventargs;

import poison.core.eventargs : EventArgs;

/// Event args for value changes.
class ChangeEventArgs(T) : EventArgs {
  private:
  /// The old value.
  T _oldValue;

  /// The new value.
  T _newValue;

  public:
  /**
  * Creates a new change event args.
  * Params:
  *   oldValue =  The old value.
  *   newValue =  The new value.
  */
  this(T oldValue, T newValue) {
    super();

    _oldValue = oldValue;
    _newValue = newValue;
  }

  @property {
    /// Gets the old value.
    T oldValue() { return _oldValue; }

    /// Gets the new value.
    T newValue() { return _newValue; }
  }
}
