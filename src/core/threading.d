/**
* Module for threading.
*
* Authors:
*   Jacob Jensen
* License:
*   https://github.com/PoisonEngine/poison-ui/blob/master/LICENSE
*/
module poison.core.threading;

import std.concurrency : send, receive, Tid, thisTid, receiveTimeout;
import core.thread : dur;

import poison.core.action;

package(poison.core) {
  /// The tid of the ui thread.
  __gshared Tid _uiTid;
}

/// Checks whether the current thread is the UI thread.
@property bool isUIThread() {
  return thisTid == _uiTid;
}

/**
* Executes an action on the UI thread.
* Params:
*   f = The function pointer to execute.
*/
void executeUI(void function() f) {
  executeUI(new Action(f));
}

/**
* Executes an action on the UI thread.
* Params:
*   d = The delegate to execute.
*/
void executeUI(void delegate() d) {
  executeUI(new Action(d));
}

/**
* Executes an action on the UI thread.
* Params:
*   action =  The action to execute.
*/
void executeUI(Action action) {
  if (isUIThread) {
    action();
    return;
  }

  send(_uiTid, cast(shared)action);
}

/**
* Receives a concurrent message non-blocking.
* Params:
*   ops = The message ops.
*/
private void receiveNonBlocking(T...)(T ops) {
    receiveTimeout(
        dur!("nsecs")(-1),
        ops
    );
}

/// Receives all messages for the current thread and executes them.
void receiveMessages() {
  receiveNonBlocking(
    (shared(Action) a) { (cast(Action)a)(); }
  );
}
