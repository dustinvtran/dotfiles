#
# Ranger colorscheme
# ~/.config/ranger/colorschemes/dvt.py
# Name: Dustin Tran
#

# Note: I changed the interface for titlebar and statusbar, and so some conditions are added/removed accordingly,
#   particularly in context.in_statusbar.
# Parameters:
# conditions: See ranger documentation.
# bg/fg: black, blue, cyan, green, magenta, red, white, yellow, default
#     You can also specify the color value by the corresponding 256 number.
# attr: normal, bold, blink, reverse, underline, invisible

from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import *

class Default(ColorScheme):
    progress_bar_color = green

    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        elif context.in_browser:
            if context.selected:
                attr = reverse
            else:
                attr = normal
            if context.empty or context.error:
                bg = red
            if context.border:
                fg = default
            if context.media:
                if context.image:
                    fg = yellow
                if context.audio:
                    fg = cyan
                else:
                    fg = magenta
            if context.container:
                fg = red
            if context.directory:
                fg = green
            elif context.executable and not \
                    any((context.media, context.container,
                        context.fifo, context.socket)):
                fg = blue
            if context.socket:
                fg = magenta
            if context.fifo or context.device:
                fg = yellow
            if context.link:
                fg = context.good and cyan or magenta
            if context.tag_marker and not context.selected:
                fg = red
            if not context.selected and (context.cut or context.copied):
                attr |= bold
            if context.main_column and context.marked:
                fg = yellow
            if context.badinfo:
                if attr & reverse:
                    bg = magenta
                else:
                    fg = magenta

        elif context.in_statusbar:
            if context.directory:
                fg = red
            if context.space:
                fg = white
            if context.message:
                if context.bad:
                    fg = red
            if context.loaded:
                bg = self.progress_bar_color

        if context.text:
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            if context.title:
                fg = green

            if context.selected:
                attr |= reverse

            if context.loaded:
                if context.selected:
                    fg = self.progress_bar_color
                else:
                    bg = self.progress_bar_color

        return fg, bg, attr

