#
# ranger commands
# ~/.config/ranger/commands.py
# Name: nil
#

# Note: This appends (and overwrites) commands to the already written default ones.

from ranger.api.commands import *

class emptytrash(Command):
    """:trash-empty

    Runs the command without requiring shell.
    """

    def execute(self):
        self.fm.run("trash-empty")
