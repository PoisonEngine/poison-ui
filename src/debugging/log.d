module poison.debugging.log;

void log(string msg) {
  import std.stdio : writeln;
  writeln(msg);
}
