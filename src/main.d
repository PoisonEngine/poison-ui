/**
* Main module.
*
* Authors:
*   Jacob Jensen
* License:
*   https://github.com/PoisonEngine/poison-ui/blob/master/LICENSE
*/
module main;

/// The entry point.
private void main(string[] args) {
  try {
    import poison.ui.fonts;
    loadFonts("resources\\poison\\fonts");

    import poison.ui.styles;

    version (Poison_SharedStyles) {
      loadStyleSheet("resources\\poison\\styles\\poison.pss");
    }

    version (Poison_Win_XP) {
      loadStyleSheet("resources\\poison\\styles\\win-xp.pss");
    }
    else version (Poison_Win_Vista) {
      loadStyleSheet("resources\\poison\\styles\\win-vista.pss");
    }
    else version (Poison_Win_7) {
      loadStyleSheet("resources\\poison\\styles\\win-7.pss");
    }
    else version (Poison_Win_8) {
      loadStyleSheet("resources\\poison\\styles\\win-8.pss");
    }
    else version (Poison_Win_10) {
      loadStyleSheet("resources\\poison\\styles\\win-10.pss");
    }
    else version (Poison_Linux) {
      loadStyleSheet("resources\\poison\\styles\\linux.pss");
    }
    else version (Poison_OSX) {
      loadStyleSheet("resources\\poison\\styles\\osx.pss");
    }
    else version (Poison_Android) {
      loadStyleSheet("resources\\poison\\styles\\android.pss");
    }
    else version (Poison_iOS) {
      loadStyleSheet("resources\\poison\\styles\\ios.pss");
    }
    else version (Poison_WindowsPhone) {
      loadStyleSheet("resources\\poison\\styles\\poison-wp.pss");
    }

    import application;
    run();
  }
  catch (Exception e) {
    import std.stdio : writeln, readln;

    writeln(e);
    readln();
  }
  catch (Throwable t) {
    // TODO: exit program here ...
    import std.stdio : writeln, readln;

    writeln("Fatal error ...");
    writeln(t);
    readln();
  }
}
