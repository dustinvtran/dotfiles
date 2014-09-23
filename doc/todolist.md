This document compiles a list of tasks that I have yet to complete. This is
purely for personal (although somewhat public) use, so I can keep track of
features I desire and when I complete them.

Each to-do item for an application is assigned a priority level depending on how
much I personally want them to be completed. Then in the Priority categories,
each application is sorted by alphabetical order. Then each task within an
application is itself ranked by descending order of priority.

## Highest Priority

The following is a bunch of unorganized "todolist" things
live-tex
* get tikz-cd working, e.g., 134-lecture-05.tex
* compile from lecture note
* subsubsection numbering
finish major set up of linux on laptop {{{
* mpd: set up stream on PC to get working for laptop using icecast
* replace naughty with libnotify, include it for dropbox, gmail, irssi, ?, low battery notification, skype notifications
* both: get zathura and things such as private firefox to tile when desired
    * xbacklight not the same on plug in, display off/on
    * clipit not always working when highliting over
    * auto-enter rsa password for git
    * rc.lua
      * libreoffice popups
    * libreoffice: have dropbox sync auto-update xlsx sheets
    * udev-power-supply
      * install it
      * another if condition
          * after 90 sec of idle
              * xbacklight -dec 20
          * after 180s of idle
              * xbacklight -dec 20
          * if i move during any of these, it resets it back to normal
      * also while learning this, set laptop lid event to pm-suspend-hybrid
    * vim: power bar colors
    * touchpad: touch and drag while scrolling
    * both: gimp-git
    * both: update infinality repos
    * new share
      * libreoffice keybinds
      * .config/ranger/bookmarks
      * /etc/systemd/system/getty@tty1.service.d/autologin.conf
      * firefox addon configs
      * vim airline colors
  * new
      * /etc/pm/config.d/unload_module
  * no need
      * system-dotfiles/hdmi.rules.. cron..
}}}

* redo ts=80 for all files
* import 4chan x settings
* somehow migrate all pic bookmarks from pixiv to pinterest
* audio output is broken
* yanking full line and pasting in another vim buffer
* vimrc: set up one where i can do fuzzy file find by default on /home/dvt
* mpv-control not working
* clean your installed package list
  * filezilla, thunderbird, deluge
* How to follow link in man using vim as manpager? I've done it before
* double press both volume buttons to play pause
* devices:
  * set up android stuff as zshrc aliases, and also save fuse.conf
  have gallery sync with the current dropbox, e.g., if i delete stuff in dropbox delete in gallery too, and other way around
  find way to recover text on mobile devices
  * text expansion on mobile devices
  * ereader: google books' dictionary not working without internet, so!show integrate it with webster's original dictionary
  * todo: encrypted, rooted, two factor authentication

colorscheme
  * ~/.irssi/nick colors
      * gray shouldnt be an available nick color
      * can't see spoilers

sync pc: someway to make this easier and less manual
  * git checkout master && git checkout laptop .. & git merge-master-from-laptop
  * git checkout master && git checkout desktop .. & git merge-master-from-desktop
      * automate this
  * what special cases do i still need to do manually?
      * if it's adding new files into master, and you want to push master
      * there are overlapping commits from both pcs

bspwm
  * finish locus
  * have windows move on launch
  * panel
  * media shortcut
  * perhaps switch to pseudo_tile

misc
  * firefox popups too big
  * clean packages/my PC's memory

mpd
  * in the alias, set if statement of it mpdas defunct/not there, add mpdas & line too

qtile
  * alphabetical order workspaces
  * raise and run specific apps
  * remember position of windows

Colemak
  * convert: vim (nerdtree, bufexplorer)
  * scrolling up/down in docs, e.g., r doc
  * re-arrange any keybinds (e.g. dealing with ctrl s across multiple applications).

cron
   * Fix the cronjobs. mpdas simply goes defunct. Fails on reboot. Perhaps add an if condition that stipulates to run it if it says <defunct>. rssdler isn't always downloading

urxvt
  * urxvt-perls: c-v as paste (eg for irssi and readline), url clicker+keyboard select.
  * maybe rekeybind shift+insert via awesome

## High Priority

Android USB Connection
  * shows up on lsusb but not fdisk -l

Firefox Addon: Pentadactyl
  * for places like RES, 4chanx, gmail: have ? keybinded to overhead GUI to show all keybinds
  * make a script to open archive url of current board, which is set as a keybind
  * using digits autogoes to a url page. stahp. let them use google.
  * google search suggestions aren't working. unless i specifically go to 'g'.
  * have '/' searches show the # of results.
  * when I try to hit a popup X box, the status line shifts everything up, then it shifts it down and so it goes screwy in a loop, making it hard to hit the box.

irssi
  * better way to store logs, so you dont see things like truncated names
  * include invisible (status) channel so it collects all commands like /names
  * quitting with /away doesn't show away in sb on new login, although I'm still away.
  * possibly use (status) at login, which you can then close afterwards, so you don't have to deal with all that garbage on login. Or maybe (msgs) too.
  * alias > to automatically expand to C-c3>.

media-catalog
  * have 2001 Space Odyssey after everything in sort, not before [ characters.
  * automate this: Don't include [Backlog] subfolders and but do include them if they start with [...], like [Completed] and [Summer 2013].
      * i've worked around this for now by echo'ing them directly from the .zshrc command.
  * specify up to levels for certain things, to avoid massive musics for instance
      * i have to delete them manually for now.

mpv-open
  * occasionally getting these weird blank sed files in ~/.mpv.

mpv
  * does >/< across multiple directories?
  * should I add a kill mpv + mpv-open option in rifle.conf? Should I make mpv auto-focus?
  * stream youtube into here.

pentadactyl
  * better way to deal with bookmarks..
  * somehow always have backups of pentadactyl.txt in case I close it when window no longer exists (hence losing all my text edits).

ranger
  * if scope shows preview and cuts off filename where <50% Of filename is shown, don't have it show a preview.
  * mpv-open: Sometimes it doesn't work? Maybe have ranger show the error if it doesn't open.

readline
  * matlab: Add.
  * change less pager to vim, e.g., for R.
  * matlab: Hide welcome/copyright/version message via tail output.
  * add color to inputs of python, R, Matlab to determine what mode you're in.
  * add more vim keybindings like ones I did for zle widgets. Possibly even sync the two.
      * use github for suggestions.

skype/mic
  * usb audio output should always be set to 50. it resets. putting it in udev-hdmi is not the right way since you only put up the usb when about to speak
      * amixer -c 2 set Mic 9dB
  * enable push to talk
  * some configuration to enable user to see who talks in a group

transmission
  * occasionally corrupt pieces of files in Transmission downloading. Is this transmission's fault or mine??
      * for now, you'll have to check each torrent after it finishes individually.

Vim
  * fix 'df' and 'ct' (basically omap) til-ing.
  * note that you uncommented that one part from NERDCommenter.vim.
  * make or use some syntax file for your todolists.
  * NERDTree: Get movement keys working, e.g., <C-j>/<C-k>.

udev-hdmi
  * urxvt open commands not working.

virtualbox
  * err, Windows 8 died on me.

xinitrc
  * tcli not starting up, even if I put it in rc.lua. It seems to take a while for transmission-daemon to load? What??

Zathura
  * keybind for fullscreen
  * when redoing pdf, zathura doesn't reload unless I move the page a bit; same happens for rubber or pdflatex.
  * have <Leader><Space> turn off the highlight, not just Esc.

zsh
  * deletearound not working.
  * tab completion doesn't work on some commands (e.g. fasd, git).

Misc
  * automate the following
      * unmounting: pkill ranger (sometimes); pause all torrents in transmission-client; pkill mpd; umountb
      * mounting: mountb; unpause all torrents in transmission-client; mpd (the alias); mpdas &
  * fork transmissionremotecli properly so people can use your own more professionally
  * workMethod: Finish final draft.

## Medium Priority

laptop
  * optimize battery with CPU frequency scaling and stuff

feh
  * set maximum size, but not minimum, so you don't see the ugly box for small pictures.

Firefox
  * script to save both HN comments+article link to pocket
  * should I style sites such as MAL, wikipedia, etc.?
  * mAL: Set up wikipedia+MAL API so that you can autoadd all tags.
  * whatcd: get power user (1.05 ratio) for ptp, btn, and bibilotik invites
  * better way to integrate my other/mobile bookmarks that's keyboard navigable.
  * flash: fullscreen toggles away once i hit something else.
  * display notifications on primary desktop, not HDMI (e.g. download finished, autopager notification of not loading, etc.).
  * don't have middle click on webpage go to last opened tab.
  * screen glitches when moving to firefox sometimes.

Firefox Addon: Pentadactyl
  * have searches show # of hits.
  * better font to distinguish upper cases in hint mode.

irssi
  * url links are no longer underlined and turned blue
  * get a way to set a vim mode map to do "3 ", and another for "1,1 "
  * do stuff like /whois, <c-r>, ,n and /nicklist while being able to remove all that text when i no longer want to see it.
  * a status window works for this, but it doesn't include /names. How to?
  * display some type of % sign when not at bottom of text.
  * do nick/vhosts/BNC for all servers.
  * irc: SSL cerificate path and SSL_verify.

mcomix
  * have right click show osd-bar as in mpv, but how else to do context menu?

mpv
  * configure autosync to never go out during fast forward, e.g., with --mc or whatever.

media-lists
  * figure out how to sort, e.g., pull out from a section and place into a file, and have sed sort by every 7th row or something

ncmpcpp
  * somehow play everything as the playlist (clear, then add them).
  * get progress bar elapsed color to work.
  * incremental seek like with mpv.
  * if it idles for longer than 10 seconds, have it automatically go to playlist view.
  * clean up keys.

plex
  * get the server working.

ranger
  * have the l keybind for unpack work on multiply selected items, doing it sequentially.
  * set it to auto-open last directory as hut stated in the Q&A.
  * set djvu to not show any preview.
  * set vim as a (read-only) pager so mediainfo can navigate with it.
  * when using Dt to see trash list, have it ask if you want to clear the trash list also.
  * when renaming, allow some way to already have the current name to modify (e.g., when trying to rename long file names but only a portion of it).

transmission-remote-cli
  * set default download location setting.
  * add better documentation in help messages.
  * can't see cursor anymore when typing, e.g., moving location of file.
  * have a keybind that sets all active downloads/seeding (basically, non-paused) to the bottom of queue position. And even more advanced, have those ones all sorted by completion rather than arbitrarily. E.g., Seeds above, then highest % downloads sorted descending. Also consider automating this on entering tcli.

ranger
  * make pdfs and djvus the same color.
  * don't have it preview .srts, which makes it when browsing through a list of movies with .srts each to them.
  * when mounting extHD while with ranger up and shown the empty links already, have it load and preview them without requiring restart.

trash-cli
  * delete trash things for external hard drives.
  * have it show other properties, such as file size.

urxvt
  * change urxvt settings without requiring to restart application.
  * separate ^J and <CR>, so you can bind them in irssi, and not do workarounds in the rest either.
      * same for S-spacebar, C-c
  * what is this alt+s urxvtperl business with scrollback? can i use it for searching, especially in irssi/terminal?
  * make sure all the fallback weeaboo fonts work.

vim
  * use different fonts for different languages, e.g., similar to how urxvt has fallback font.
  * latex: Autobuild.
      * first, need to be able to compile in background. But & fails for both pdflatex and rubber?
  * change up colors for terminal vim.
  * type lime/uushi encodings with ctrl+shift.
  * anyway to refer to <SID> functions, e.g., Matchit, stuff that don't use <Plug> so you can nnoremap.
  * SetColors: not sure how to change the runtimepath to ~/.vim/bundle/dvt/colors/*.vim. technically, i could always do a symlink.
  * Repeat: Not working with Surround.
  * Snippets: Fix the auto-reload command to not be so computation heavy.
  * Snippets: How to do snippets inside a snippet? Or perhaps manage more carefully if not.
  * YankStack: not cycling all the time, never cycling when I paste, screws a shitload of my vimrc behavior.
  * vim fold text styling. donri is coming up with a plugin for a nice one.

xcape
  * doesn't allow for holding down another modifier (e.g., ctrl+shift+tab)

Zathura
  * keybind >/< to go through all possible readable documents within that directory.
  * maybe some to go up/down directories too. I don't need anything too fancy; just these four shortcuts are good enough.

zsh
  * make cleaner format for ls -l in terminal.
  * better ls and grep colors, and better ls style.
  * have it autoopen files that arent commands in the respective application (e.g. gvim, mplayer, etc).
  * display the red dots while waiting for long commands as well, e.g., cp large files, pl, etc.
  * make zle widget for 's/S' as your insert char function
  * when pressing <CR> while still in cmd mode (green), the directory stays the cmd-color. I would like the color to reset back to the default (red) before <CR> is hit, so that it's /always/ the default (red) unless I'm in cmd mode (blue).

## Low Priority

audio-output
  * don't require restarting applications, e.g., mpd, firefox, but don't force-kill and restart them.

Audio
  * can't change volume with alsamixer and usb DAC; i can change all volumes in their own app save for ncmpcpp's.
  * mpd
      * set udev rule on headphone jack into amp
      * changes audio-source to headphones if i plugged in, monitor if i plugged out (and if monitor not there, then last resort as laptop)
      * pkill mpd    mpd ~/.config/mpd/mpd.conf &    mpdas &

Compton
  * somehow shadow-exclude all fullscreen windows, but no longer when they're floating.

Firefox Addon: Pentadactyl
  * normal <C-j> goes to home page if it's assigned to do nothing else at that issue of command, e.g., if it's unbinded, for example, in 4chan thread pages.
  * g not always working on reddit
  * $ not working in google
  * function to tabdetach if there's not a 2nd Firefox window, tabattach to the other window if there is (this compounds 3 keys into one (:taba 1,:taba 2,:tabd).
  * jumps in same buffer without changing pages. (same problem in Vim)
  * set tabmove to move to 1st position, if it's already in last position (similarly for first to last)

irssi
  * some way to highlight all text, so you can see text underneath spoilers without requiring to use mouse.
  * set vim_mode command to open corresponding log of the current channel in vim, so you can browse through the log.
  * pubmsghighlight, e.g., "text + highlight", have an extra letter in their names.
  * set adv_windowlist so that all the channels are only on one line, and the middles get ellipses, like browser tabs.
  * alias to list top 10-20 channels and sort by name or # users.
  * see ban list of channels like in hexchat.
  * set -> mode so that when you do something like +ao, it only shows the designated nick once, not twice.
  * OpenURL: never lose focus when opening url and firefox is on a focused workspace.
  * OpenURL: second+ lines of long urls are not underlined and blued.
  * <C-v> not pasting (a urxvt issue).
  * vim_mode: Have yank/paste go to the clipboard.
  * anames: Add a bunch of whitespace to the first column.
  * anames: spacing goes crazy if there's a user with a long name.
  * vim_mode: Remove that annoying operator shit, or append it to the right like in vim.
  * pubmsg_me shows one extra character for long names, i.e., when i'm highlighted.

R
  * knitr Compiling: It works if I don't use \input{}. See if I can do it with \input{}.
     * current command works fine but it adds knitr things twice.

ranger
  * add a :zip command that does as desired.
  * have those console commands (!) automatically be given a space.
  * learn all the :scout commands.
  * prevent certain things from causing ranger window to blink for really quick output, e.g., atool unpacking or emptying trash, if they're shorter than half a second.

urxvt
  * fallback japanese fonts still render some blurry.

vim
  * Airline: Add an arrow to filename, and reformat the +.
  * Airline: Customize how it handles statuslines on inactive windows, e.g., nerd or another.
  * Airline: change color of middle bar to a lighter white.
  * LaTeX
      * allow to <Tab> between the $..$.
      * configure inoreabbrev,snippets,surround instead of in-LaTeX macros.
          * which ones should be via LaTeX and others via vim?
      * check out surround's macros for auto-completing text like 'div id=' but when you don't want to include an id, it takes it away from the tab.
      * later, when you deal with LaTeX plugins, try the IDE stuff like SuperTab.
  * option for "resize" mode of windows, like with i3.
  * make InsertCharFunction() an atomic operator, e.g., '.'-able.
  * C-o and C-p (C-I) not really working as intended. Have it so that it jumps around only in the current file, not whereever.
      * stuff about jump lists vs normal motion.
  * jump to paragraphs? One that includes <br><br> for html.
  * clear error (one great use of this would be for folding so it doesn't output errors when none exists).
  * if in same workspace as another Vim file, somehow combine the two into one Vim window, with it split.
  * reloading vim doesn't work for everything, namely newly omitted mappings and settings.
  * fix $...$ in case there are none.
  * have cursor position returned to exact position (i.e. column) not just line position.
  * the "jump to next/last sentence" doesn't always work as intended. Do them better, along with paragraph.
  * load multiple files so you can <C-e> right away.

zathura
  * when Page Uping midway on first page, go to top. Analogous for Page down on last page.
  * manage pdfs with tabs, while with keybinds to detach/attach.

zsh
  * all keybind/vim stuff lost during ssh session, wonky prompt.
  * tab completion menu colors for scp  are wonky/inverted.
  * maybe use vim, or at least vim buffer navigation, when I do --help and I the output suggestions are larger than the buffer.

## Misc

what to change when moving to different monitors: udev-hdmi, xinitrc
Better partition your code in repos, e.g., github old dotfiles repo, firefox styles repo, and latex templates and firefox bookmarks (e.g. bookmarklets,search engines), how i sort my media.
system
  * optimize boot time.
  * recheck and sync the keys and colors on all apps; clean their configs.
  * purge all system dotfiles from old packages and/or reinstall.
  * complete wish/todolists.
  * place all dotfiles into .config! (while removing their '.')
  * rename menu entries in grub
  * login manager
      * boot into X as normally, but first overlayed by a floating terminal asking for password; if fail, then repeat ask, with prompt saying that 'reboot' and 'poweroff' as passwords work; if success, then resume normally. And then whenever I close/open the lid, it does that same terminal function.  I can issue that close/open lid condition using acpid.
  * look at other people's dotfiles in github for more ideas.
