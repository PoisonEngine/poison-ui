/**
* Module for cross threading exceptions.
*
* Authors:
*   Jacob Jensen
* License:
*   https://github.com/PoisonEngine/poison-ui/blob/master/LICENSE
*/
module poison.core.exceptions.crossthreadingexception;

/// Exception thrown when attempting cross threading access in non-allowed contexts.
class CrossThreadingExeption : Exception {
  public:
  /**
  * Creates a new instance of the cross threading exception.
  * Params:
  *   msg = The message of the exception.
  */
  this(string msg) {
    super(msg);
  }
}
