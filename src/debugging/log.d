/**
* Module for logging. (Not in use yet ...)
*
* Authors:
*   Jacob Jensen
* License:
*   https://github.com/PoisonEngine/poison-ui/blob/master/LICENSE
*/
module poison.debugging.log;

void log(string msg) {
  import std.stdio : writeln;
  writeln(msg);
}
