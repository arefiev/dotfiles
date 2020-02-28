def doc(x): print(x.__doc__)
from pprint import pprint
from dis import dis
import datetime
dd, dt = datetime.datetime, datetime.timedelta
import json
import os
import sys

_readline = __import__("readline")
_os = __import__("os")
_os_exit = _os._exit
history = _os.path.expanduser("~/.python_history")
if not _os.path.exists(history): file(history, "w").write("")
_readline.read_history_file(history)
__import__("atexit").register(_readline.write_history_file, history)

# Exit the interpreter without saving history.
# Good for history hygiene (if you practice it).
# Same as kill -9 $$ in shell.
# Unfortunately, it breaks vars().
class SelfTerminator(object):
    def s(self):
        __import__("atexit")._exithandlers = []
        _os_exit(13)
    __repr__    = lambda self : self.s()
s = SelfTerminator()
del _readline
del _os

import rlcompleter, readline
readline.parse_and_bind('tab:complete')
readline.parse_and_bind('"\\C-w": backward-kill-word')
