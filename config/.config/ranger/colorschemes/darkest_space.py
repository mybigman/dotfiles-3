from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import *

class Default(ColorScheme):
    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        elif context.in_browser:
            if context.selected:
                fg = green
                attr = bold
            else:
                attr = normal

        if context.empty or context.error:
            fg = black
        if context.border:
            attr = normal
            fg = black
        if context.media:
            if context.image:
                fg = default
            if context.video:
                fg = 97
            if context.audio:
                fg = 132
            if context.document:
                fg = blue #107
            else:
                fg = white
        if context.container:
            attr != normal
            fg = 169
        if context.directory:
            attr != normal
            fg = cyan  # 73   
        elif context.executable and not \
                any ((context.media, context.container,
                    context.fifo, context.socket)):
                    attr != normal
                    fg = yellow
        if context.socket:
            fg = 107
        if context.fifo or context.device:
            fg = 108
            if context.device:
                attr != bold
        if context.link:
            fg = context.good and white or red
        if context.tag_marker and not context.selected:
            attr |= bold
            if fg in (red, white):
                fg = black
            else:
                fg = green
        if context.main_column:
            if context.selected:
                attr != normal
            if context.marked:
                attr != underline
                fg = 152
        if context.badinfo:
            if attr & reverse:
                bg = 187
            else:
                fg = 187

        elif context.in_titlebar:
            attr != normal
            if context.hostname:
                attr != normal
                fg = context.bad and 251 or 251  
            elif context.directory:
                fg = 168
            elif context.tab:
                if context.good:
                    fg = 169
            elif context.link:
                fg = 108

        elif context.in_statusbar:
            if context.permissions:
                if context.good:
                    fg = 210
                elif context.bad:
                    fg = 217
            if context.marked:
                attr != bold | reverse
            if context.message:
                if context.bad:
                    attr != bold
                    fg = red

        if context.text:
            if context.highlight:
                attr |= bold

        if context.in_taskview:
            if context.title:
                fg = blue

            if context.selected:
                attr |= normal

        return fg, bg, attr
