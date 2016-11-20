module main;

/// The entry point.
private void main(string[] args) {
  try {
    import poison.ui.styles;

    version (Poison_SharedStyles) {
      loadStyleSheet("configs\\poison.pss");
    }
    else version (Poison_Windows) {
      loadStyleSheet("configs\\poison-win32.pss");
    }
    else version (Poison_Linux) {
      loadStyleSheet("configs\\poison-linux.pss");
    }
    else version (Poison_OSX) {
      loadStyleSheet("configs\\poison-osx.pss");
    }
    else version (Poison_Android) {
      loadStyleSheet("configs\\poison-android.pss");
    }
    else version (Poison_iOS) {
      loadStyleSheet("configs\\poison-ios.pss");
    }
    else version (Poison_WindowsPhone) {
      loadStyleSheet("configs\\poison-wp.pss");
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
