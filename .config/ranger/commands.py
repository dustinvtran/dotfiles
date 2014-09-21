#
# ~/.config/ranger/commands.py
# Author: Dustin Tran <dustinvtran.com>
#

from ranger.api.commands import *

class emptytrash(Command):
    """:trash-empty

    Runs the command without requiring shell.
    """

    def execute(self):
        self.fm.run("trash-empty")
