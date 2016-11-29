/**
* Module for cross threading exceptions.
*
* Authors:
*   Jacob Jensen
* License:
*   https://github.com/PoisonEngine/poison-ui/blob/master/LICENSE
*/
module poison.core.exceptions.crossthreadingexception;

import std.concurrency : Tid;
import std.string : format;

/// Exception thrown when attempting cross threading access in thread-bound contexts.
class CrossThreadingExeption : Exception {
  private:
  /// The tid the thread was accessed from.
  Tid _tid;

  public:
  /**
  * Creates a new instance of the cross threading exception.
  * Params:
  *   tid = The accessible tid.
  *   msg = The message of the exception.
  */
  this(Tid tid, string msg) {
    msg = format("Tid: %s\r\n%s", tid, msg);

    super(msg);

    _tid = tid;
  }

  @property {
    /// Gets the tid that the thread-bound context was accessed from.
    Tid tid() { return _tid; }
  }
}
