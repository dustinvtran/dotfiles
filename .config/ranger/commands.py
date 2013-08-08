#
# ranger commands
# ~/.config/ranger/commands.py
# Name: nil
#

# Note: This appends commands to the already written default ones.

from ranger.api.commands import *

class emptytrash(Command):
    """:emptytrash

    Empties the trash directory ~/.trash
    """

    def execute(self):
        self.fm.run("rm -rf /home/nil/.trash/{*,.[^.]*}")
