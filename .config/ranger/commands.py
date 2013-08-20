#
# ranger commands
# ~/.config/ranger/commands.py
# Name: nil
#

from ranger.api.commands import *

class emptytrash(Command):
    """:trash-empty

    Runs the command without requiring shell.
    """

    def execute(self):
        self.fm.run("trash-empty")
