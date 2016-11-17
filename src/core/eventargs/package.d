module poison.core.eventargs;

/// Base event args
class EventArgs {
  /// The empty event args.
  private static EventArgs _empty;

  protected:
  /// Creates a new instance of event args.
  this() {

  }

  public:
  static:
  @property {
    /// Gets an empty event args. 
    EventArgs empty() {
      if (!_empty) {
        _empty = new EventArgs();
      }

      return _empty;
    }
  }
}

public {
  import poison.core.eventargs.changeeventargs;
  import poison.core.eventargs.buttoneventargs;
  import poison.core.eventargs.keyeventargs;
  import poison.core.eventargs.mouseeventargs;
  import poison.core.eventargs.texteventargs;
}
