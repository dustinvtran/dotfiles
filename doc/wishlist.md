This document compiles a list of features that I would like on various
applications I have used (including websites I browse). This is mainly for
personal use, so I can keep track of features I desire and what I personally
find to be faulty with them.

This is sorted alphabetically by application. Each item on the list is assigned
a priority level depending how much I personally want them to be implemented.
Then each item in the Priority categories are themselves ranked in descending
order of priority.

## autocutsel

High Priority
* pastes the escaped code for unicode characters and not the actual character,
  e.g., emdash, and a particular single quote variant

## awesome

High Priority
* terrible floating window management: do stuff that allow for beautiful gaps in
  tiling
* preconfigured tiling layouts are stupid. What on earth use case is that? Just
  let me f-ing move this one window here, shrink that other one, and set it up
  like so-and-so. With the right implementation (like i3), it would hardly be
  much time to get it exactly as you want
* windows are not moved to designated default location on startup, requiring
  that you restart awesome in order for them to position correctly

Low Priority
* better debug handling: don't crash the PC and cause me to reboot in safe mode
  just because of some minor typo in my rc.lua!

The list below is an archive of tasks that were still on my todolist before I
stopped using it Highest Priority
* fix mail-notify!!
  * Weird freezing where application works but everything can't be given focus
    although they're still running. This seems to happen most during
    downloading.  Perhaps a problem because of dhcpccd/netctl?
  * This happens because of mail-notify while it's using up bandwidth. Is this
    in conjunction with transmission running? Why would it stall the PC apps if
    it just takes up time to finish?
* shift centered floating windows relative, e.g., down and/or to the left, for
  applications like mpv
* move mouse to center of screen of new focused tag
  * Do something like switchtotag in the keybinds
* applications not shifting correctly between monitors and #s, what with
  absolute positions. Maybe add movetoscreeen or something? see mod4+control+j
  function in the default rc.lua and add it to your keybinds
* increase height of top bar

High Priority
* Appearance
  * square icons like twily's, and also earsplit's
  * bashets: Apply if conditions from a grep, so that all colors and formatting
    works correctly mpd: stopped battery: low
  * have the tag icons turn sideways on focus Find how to change tag name when
    focused Find the appropriate icons
  * mpv: Somehow grep with regexp and gray any parts of the filenames in [...]
    maybe by sedding them and adding the separator variable
  * get nu on workspaces and layout icon only. Lemon the rest (particularly the
    menu)
  * dropdown widgets using Naughty/dzen/whatever: Calendar, Music Now Playing,
    all the widgets!
* General
  * awesome starts a little too early for udev-hdmi, not getting wallpaper every
    time, especially if I try to open apps
  * have the directional focusings go across monitors too
  * make widgets that only appear on a keybind that moves them, e.g., volume
    widget (see user-contributed widgets for ex.) have battery widget show ETA
    on hover
  * everything not moved right on startup (e.g., transmission-cli, calendar
    (which has a different startup position depending on the workspace, lol),
    etc.)
  * revamp menu, all with cute icons
  * somehow move the next libreoffice window to the succeeding workspace (iii,
    iv, v,...) depending on whether there's already a window in that workspace.
    For example, pgrep the # of currently running and assign accordingly Do the
    same for zathura and feh
  * set alt+o to not do "on top", but to focus window that's below it, which
    would then put it on top Set Library on top of Firefox always
  * when mpv changes to another file on its playlist and is at a different
    resolution. Have it recenter/position again
  * for things like gimp, have the extra dialog folders show appropriately on
    the right workspace (this includes the right monitor). For example, GIMP's
    save dialog appears on my external display
* Panel Scripts
  * mpv If the file name is too long (e.g. if X has > Y characters), truncate it
  * mpd If the song name is too long (e.g. if X has > Y characters), truncate it
    Have keybind which shows albumart which is not locally stored but always
    taken from the web via audioscrobbler
  * volume: have a keybind to check current volume, or to pop up the display for
    a few seconds Instead of overhead, you can also put it into your panel by
    the following: have 2 scripts, script A which gets tracked by .conkyrightrc,
    and script B which pipes what to echo and for how long into script A. for
    example do in script B echo "echo '^fg(....)'" > script A. then keybind
    script B with your 4 volumes (up/down/mute/nothing but display) and do a
    similar one in each
  * right-aligned panel widgets should be cut off from the left not the right
* Misc
  * can't fullscreen VirtualBox, even with the function
  * not distinguishing the sizes for other dialogs of calibre-ebook-viewer
  * if I can't set feh to change only if bigger than X size like mpv can, then
    set the feh settings in awesome instead of rifle.conf
  * try rodentbane for the occasionally necessary mouse movement with keyboard
  * add left+right click as move window
  * how to deal with skype notifications

Medium Priority
* maybe use nicer looking pngs for the icons, e.g., Ahoka or Lemonboy's
* when clicking away from menu, have it hide just like it does with Escape
* use all variable names in rc.lua so that the theme.lua becomes modular and
  determines all your colors, e.g., see ahoka
* hide cursor if it doesn't move for >=5 seconds
* configure Gimp so that the main application is tiled, and the toolbars are
  floating always on top
* Panel Scripts
  * Bashets font: err, it sucks on playing japanese/fallbacks. use fallback
    fonts
  * battery: On single digit %, it also shows the comma
  * irssi Have fnotify grab the whole nick, not just the line, so i see the
    whole nick of longer truncated names Also, if that person's nick is long
    enough, it may connect with his/her nick mode, which causes the script to
    grab the wrong word to display
  * skype
  * add clickables (or keybindables?) into dzen
* when youtube video is a url in firefox, have play-pause cycle pause that, not
  mpv or ncmpcpp instead

Low Priority
* irssi-notify doesn't echo the nick if it starts with 'dvt'. Lolwat
* eminent mouse scroll through tags not working
* erm, that dropbox notification. Modify it

## bspwm

High Priority
* command to focus a specific application via window id

## byzanz

High Priority
* allow filename to take in timestamps, as scrot does
* allow argument to take a file path, instead of being forced to alias a 'cd ...
  && byzanz-record ... && cd-' command. This also means menu commands like
  * awesome cannot take a file path, only interactive shells

Low Priority
* capture just one window without needing to specify dimensions

## calibre-ebook-viewer

High Priority
* more keybinds: Go to Table of Contents, progress osd like with mpv's, toggle
  toolbars, Dictionary type & look up (instead of highlighting then <C-l>)
* hint mode to hit links with keypresses
* remove entire GTK interface similar to zathura
* keybinds in fullscreen don't work

## feh

Medium Priority
* allow pan+next to be set to left mouse click, where you pan if you click+drag
  * moving around, and next otherwise

## feedly (os x)

High Priority
* rss notifications when new articles appear

## firefox

High Priority
* faster speed/memory usage and responsiveness, e.g., compared to chrome and its
  touchpad gestures
* better integration with os x notifications, or like chrome's own system
* when firefox crashes, it doesn't always recover the tabs (but chrome does!)

Medium Priority
* an addon or something, where you can right click a link and use the wrapped
  text for a search engine. For example, so you don't have to highlight the
  linked text in order to right click then hit Wikipedia to search for the wiki
  article
* auto web translation
* better builtin viewer apps like chrome's for office and pdfs
* better default ui
* triple tap dictionary search in os x

## firefox addon: 4chan X (ccd0)

High Priority
* can't navigate to last thread on a board's page (and subsequently
  keyboard-open its thread)
* mouse drag-hold adjustable image like RES; better yet, a keyboard adjustable
  one
* ability to keyboard hint-click replies to posts, or at least hit a keybind
  that will open them up if they exist 'Quote Hash Navigation' can do this
  partially, but it only moves to that post, not opens up the inline post like
  the arrow does; also it is prevalent on all quotes, which is unnecessary for
  this purpose

Medium Priority
* keybind to open up corresponding archive link to board
* have <C-j>/<C-k> navigate between threads on the board index, and navigate
  between posts on a thread page (this saves two keybinds since I never nagivate
  between two posts on the board index)
    * At the very least, the ability to unbind c-j/k on comments page,
      preventing it from going  to home page
* when J/K navigating between posts and when hitting K at the top most post,
  have it deselect (this saves a keybind). This allows you to select the OP and
  expand his/her image

Low Priority
* have the extra info when hovering over a post be shown when you're selecting
  it through keyboard navigation, i.e., the image file name, its size and
  resolution, and the google and iqdb links

## firefox addon: pentadactyl

Medium Priority
* an actually useful way to nagivate with caret mode. Possibly where caret
  starts at center of screen instead of wherever. I dunno, something. Right now
  trying to cp+paste with it is just terrible navigate between multiple
  scrollbars on the same tab, e.g., on feedly
* i can't hint links that are popup windows or when the damn hints are off the
  left border of the screen.
* i can't hint out of the popup windows, e.g., when editing entries in MAL
* true Bookmark support
  * No -folder option when adding bookmarks through :bmark
  * Better navigation through :bmarks, c.f., through folders with GUI
  * E.g., a url link with all bookmarks with the folders, then i can use the f/F
    hints to hint the links or the folders better native GUI support: Better way
    to work with recently closed tabs/windows and view them, as well as bunch of
    "back"'s history, instead of showing Menu Bar and navigating from there
  * Same with history dialog
* ability to toggle scrollbar without needing to refresh page in order to see it
* tab Options Plugin: I want it to open tabs at the end if I open a bunch of
  links, but otherwise to the right of the current "group". This is more
  intuitive in Chrome which does this automatically
* not clear when I'm in text edit mode during cmd-line, and how to escape it

Low Priority
* check list of back's, in case hitting it once keeps redirecting you instead,
  or you just want to check something way back
* no support for <Leader><Leader> (though <Leader>,> works

## firefox addon: reddit enhancement suite

High Priority
* open comments in new (unfocused) tab
* hide child comments, not hide the parent comment as well
* prefetch all images like 4chanx

Medium Priority
* keyboard adjustable image, not just mouse drag-hold adjustable
* refocus frame movement like 4chanx, where if you scroll normally, then start
  navigating between threads or posts, it automoves that keyboard cursor to
  whichever ones are seen on your current display

## firefox addon: lastpass

High Priority
* free android usage
* it should work better like chrome's, e.g., in its UI and it can't autocomplete
  in github like chrome's version can

Medium Priority
* better designed UI and keyboard shortcuts

## google-chrome

High Priority
* customizable keybinds to focus/control embedded pdf and omnibox (extensions can do
  neither)
  * using the built-in search, i can't scroll with the keyboard while still seeing results
  * open new/current tab with current url
* better battery life such as safari's
* better integration with other devices like safari

Low Priority
* configurable context menu
* customizable interface

## google-chrome addon: cvim

High Priority
* omnibox
  * open new tab
  * open new tab with current url
  * open current tab
  * open current tab with current url
  * unfocus omnibox
* always unfocus text box, so you can actually use your keybinds consistently
* better default hint style

Medium Priority
* open multiple links at once
* yank highlighted text

Low Priority
* display certain commands with ?, such as :set blacklist?
* accept search keywords in doing :tabopen
* javascript commands, maybe already possible with tabopen?
* open tabs at the end, not right in front, e.g., see pentadactyl's buftabs
* ? to show all keybinds like in vimium
* when moving tabs +1/-1, have it loop around too instead of stopping at the end

## google-chrome addon: vimium

High Priority
* omnibox
  * open new tab
  * open new tab with current url
  * open current tab
  * open current tab with current url
  * unfocus omnibox
* always unfocus text box, so you can actually use your keybinds consistently
  * smooth scroll and move tab left/right simultaneously (one fork has the other
  feature)

Low Priority
* keyboard shortcuts for bookmarks
* more pentadactyl features

## herbsluftwm

High Priority
* command to focus a specific application via window id

## i3

High Priority
* slightly more advanced panel customizability Non-integer order, e.g.,
  alphabetical or UTF-8 icons Different styles for focused workspace, e.g., have
  them animate, turn sideways, have a triangle instead of turn completely
  different colors, or do /something/ different Can't add a black outline to the
  workspace panel. The first workspace icon isn't completely covered when
  focused this way
* single keybind to spawn app if doesn't exist, focus app if exist. This makes
  two keybinds in one
* when focusing an application and there are multiple hits for that string,
  cycle among them; don't just stick with the first result

Medium Priority
* slightly more advanced panel customizability Keybindable panel applets, e.g.,
  a now-playing mpd widget with not just hover/click support, but keybind
  support Image icon/non-UTF name support
* better true panel support for dzen2 E.g., don't require so many manual dzen2's
  depending on separate text alignments E.g., dzen2 in center has weird
  flickering when moving workspaces in laptop rapidly, while HDMI is in
  fullscreen on mpv E.g., when restarting, the nondocked dzen2's get overlapped
  because i3bar restarts
* recall window sizes of things that don't size their own windows (mostly GUIs)
* ability to not use borders on non-floating windows, but keep them for manually
  made floating windows. (And also a keybind to be able to toggle that border.)
* move between floating windows with hjkl, not just a (counter)clockwise cycle
  through hl as a subset, this means I can't move to the next monitor with hl
* execute a shell command when triggered with focusing a window, e.g., remove
  irssi notification ping once you focus irssi
* prevent certain applications from stealing focus due to it re-issuing the
  for_window command, ncmpcpp in particular
* modular config files, e.g., having theming parts of config optionally in
  another file so that you can interchange them easily by citing a different
  file path to import from in the ~/.config/i3/config file

Low Priority
* more instantaneous mouse-over-window focus, rather than require to move
  further into the window to activate focus
* somehow absolute positioning based off workspace, not pixels and monitor
  alignment, so plugging out a large external display from a laptop, which
  forces the workspace onto the laptop, won't have crazy positioning based off
  the external display's larger resolution for_window [class=asdf] move absolute
  position 4000 px 300 px works, but is not nice for dynamic monitor management,
  e.g., if I switch to just the laptop instead of a dual screen setup
* ability to dynamically set the different floating layouts, move (by cycling)
  the floating windows around, etc
* independent scratchpads, e.g., ability to have multiple overlayed on each
  other and still can toggle hide them all away (can only do one at a time
  currently)
* ability to hide/close floating window on loss of focus (for better use of some
  scratchpad windows, like scratchpad terminals)
* right-click desktop with options
* when changing workspaces and back, the w3m image preview in ranger is gone

The list below is an archive of tasks that were still on my todolist before I
stopped using it Medium Priority
* ncmcpp reissues for_window occasionally, causing it to focus (which is
  annoying if you're in the middle of typing and cause ncmpcpp to do something)
  Low Priority
* set all firefox popups to float more generally, rather than needing to xprop
  each individually read up on no-startup-id
* somehow move the next libreoffice window to the succeeding workspace (iii, iv,
  v,...) depending on whether there's already a window in that workspace
* switch audios on hotplug without requiring restart applications, and distinct
  volumes on each, whilst still allowing for just three buttons (a pulseaudio
  solution)

## irssi

High Priority
* integrated search function that highlights the search parameter and scrolls
  through the buffer for you like a normal <C-f> would in other IRC clients.
  /lastlog is terrible and outputs all the results, resulting in clunky chat
  window. Then keybind them with ? and / modes in vim_mode At the very least,
  some way to open up the current log within vim, and then browse it from there

Medium Priority
* inline embedded images when displaying an image link (in the same way ranger
  uses w3m)
* true mouse support, e.g., clickable links (not just (shift+ with
  mouse.pl)drag+copy), clickable window names, maybe context menus for something
* advanced Window List: Collapse channels to a tab bar much like firefox with a
  bunch of ellipses and clear answers for the ends
* vim_mode: maps with <CR>/<C-j> don't work

Low Priority
* advanced Window List: Ability to condense channel texts from just left to
  right, instead of cutting down the middle
* advanced Window List: Better centered text than that with the
  awl_display_header
* c-# and C-j as separate keys
* openURL: Ability for multiple urls in one line
* openURL: Ability for urls in /me commands
* openURL: Ability for urls that I post (yes I open my own links heh)
* uberprompt: show without indicating its status at the beginning. '/prompt set
  -only $' only works temporarily until I hit another ex command. Would require
  some more extensive scripting to rid this feature

## libreoffice

High Priority
* modal editing, and keybind navigation a la vim
* keybinds to append/prepend text instead of wiping a cell on a keypress to
  insert characters

## (apple) mail

high priority
* word wrap all emails

medium priority
* undo send
* google plus pictures tied into people's gmails, in the same way the gmail
  client does it

## mcomix

High Priority
* precise Seeking: Keybinds to seek -/+ 5 pages, -/+ 20 pages, -/+ 50 pages
  allow <Shift>s/t to be the ff Prev/Next Page keybinds instead of using
  <Primary>s/t. The latter don't work!
* allow <Shift>n/e to scroll right/left instead of using <Primary>s/t. The
  latter don't work!
* if I save+quit a file, allow mcomix to save a cache for every file I do this
  to, not always go to that progress on that file when I try to open and read
  another file
* customizable mouse keybinds: have rightclick go to previous page instead of
  context menu, double left click toggle fullscreen, another to toggle GUI, etc
* have smart scrolling with j/k not jump scroll so discretely, e.g., have it
  scroll continuously as with normal scrolling, while still allowing for the
  smart component

Medium Priority
* if I save+quit a file while it's fullscreen, have it fullscreen on startup
  whether or not I set that to be default in general
* when fullscreening, have it automatically go to dual view, and then when
  exiting, have it exit dual view
* left/right scrolling won't work with <Shift>n/<Shift>e
* allow to remove certain default keybindings in keybindings.conf, without being
  auto-added in again when starting up Mcomix

Low Priority
* change size of osd-bar/progress bar to not cover so much
* bug: Map <Primary>p to preferences, which will work if I also map p to osd-bar
* multiple keybinds to the same command
* advanced mouse gestures (c.f. MangaMeeya)
* don't require killing mcomix before editing settings

## mjolnir

High Priority
* animation in launchorfocus is slow

## mpv

High Priority
* internal subtitle rendering quality just like MPC-HC, where the subtitles
  aren't integrated into the video (and hence blurred on fullscreen), but rather
  overwritten on top

Medium Priority
* Playlist Navigation/Management if no playlist exists, automatically play next
  file in the same directory (like MPC-HC) See
  https://github.com/mpv-player/mpv/issues/132 better default support for
  playlist navigation and management have only one running instance of mpv where
  opening other files only add append them to the present playlist (note:
  no-fixed-vo doesn't do this) Luckily my own solution is good enough that I
  don't care /that/ much about these features
* allow to reduce osd_border_size but without reducing the size of the fangs for
  the chapter markers

Low Priority
* let keep-open work if at end of last file, but not prevent say, automatic
  segwaying into the next file on the playlist. This offers the normal behavior
  in GUIs: automatic movement into next files in playlists but not closing its
  application once done playing all files
* when at end of file, freeze at last frame instead of a blackout that keep-open
  does. It does this on some files but not all. Somehow mandate this for those
  that reach a black screen
* compound commands don't work for everything. Luckily, I can cheat/work around
  this by making scripts which pipe into my Fifo with them
* a "go back to last place before last time seek was done" keybind, in case of
  accidentally hitting chapter skips or something
* hotkey that can toggle screen size between 100% and whatever my preferred is
* view (and access) list of recently opened files
* for screenshot-template, have the file extension displayed with a - instead of
  a . Currently, one can only include .filetype or omit it altogether

## qtile

High Priority
* write it in python 3!

## ncmpcpp

Medium Priority
* when holding spacebar to add music to playlist, don't add the last one at end
  of list multiple times

Low Priority
* turn selected/highlighted item attribute to bold, not reverse
* display album art on another window or when I prompt for it
* half-page up/downs (or 5j/k's)

## preview

High Priority
* when auto-updating don't go back to page 1

## ranger

Medium Priority
* have transfers show an ETA and other such details like what file is currently
  being copied and what has already been copied, not just a progress bar
* more color choices, like irssi can
* allow .zshrc things to run through, such as aliases and functions, when you
  use :shell commands, not just for interactive shells

Low Priority
* choose what files are pasted first when copying a bunch of them
* enhanced out-of-console previews: activate video previews (just some snapshot
  much like w3m for images, or better yet, several snapshots and it cycling
  through them), txt previews from an embeddable gvim or vim one (i.e. not just
  pager)
* w3img shows a piece of its bottom occasionally, although it resets when I
  teleport to another folder Did i affect this when editing the interface
  scripts, or was it always like this?

## rssdler

Low Priority
* don't exit the rssdler process on errors, e.g., connection lost. (Forced to
  run a cron job to keep it up)

## safari

high priority
* custom search engines
* reopen multiple recently closed tabs, not only one

medium priority
* ability to right click to search by image
* undo tab in private mode
* see list of recently closed tabs that i can restore
* choose where to place downloads
* autotranslate pages

low priority
* have streaming videos keep playing in the preview when you zoom out to see all
  tabs

## scrot

Medium Priority
* scrot just one window, or just one display, or just set some pixel argument to
  specify how much to capture

## slate

High Priority
* spaces support
* display hint for overlapping windows
* focus minimized windows
* launch or focus, especially hidden applicatiosn

Low Priority
* working colemak/qwerty hybrid support

## transmission

High Priority
* preserve queue order on exit
* >3 file priorities
* occasional opposite queue behavior: Sometimes the queue order is prioritized
  reversed, but this isn't indicated visibly. That is, sometimes it goes to the
  lowest items on the queue order rather than the ones at the highest
* wonky queue behavior: When moving to new queue positions, the bottom ones
  previously active (and now moved away to no longer be active) continue to be
  active regardless, while the moved queue are still queued/inactive. I have to
  pause/replay the moved active torrent to make it inactive and let transmission
  start the new queued torrent

Low Priority
* custom tags/labels for custom filtering
* built-in RSS, meaning in particular that 3rd party RSS dlers can only download
  to watch directory, and not set each torrent hit to change its default
  download directory, or force them to queue on top (a feature uTorrent has)
  * User-made script for this exists for queueing to top; as for different
    download directories, can run custom script to move particular RSS
    downloaded torrent files after the torrent completes
* >1 watch directory, and subsequently the default download directory depending
  on the watch directory or if torrent opened into Transmission directly
* no need to use Firefox plugin to start magnets into Transmission
* don't require killing transmission-daemon before editing settings.json

## transmission-remote-cli

High Priority
* set default download location from transmission-remote-cli client
* add a timeout so the selected item attribute resets
  * Afterwards, set that BOLD thing to REVERSE, so it's like ncmpcpp

Low Priority
* mouse support
* move location of several downloaded locations at once, similar to 'highlight'
  in torrents' file lists
* somehow allow ranger to open containing folder of torrent
* huge huge input lag when the file list is enormous (lagged on rahxephon with
  ~1000 files)
* when i queue up/down when already at top/bottom, they add weird stats to my
  uploads (only happens when downloading)

## urxvt/Xresources

Medium Priority
* have j/k scroll up/down the buffer during vicmd

Low Priority
* single quotes don't work in comments

## vim

High Priority
* rubber: Compile files with spaces in their name

Medium Priority
* easyMotion: This is inspired from the browser search commands. Have the
  secondary options (e.g. when it spits out the same letter) start double
  digraphs and trigraphs. This allows you to know exactly the sequence to press,
  without having to hit one key, wait for your brain to process the next, and
  hit again
* easyMotion: Allow f/F's to be case-insensitive, but smartcase when I do
  capitalize
  * (Maybe I can already do this by setting it to the EasyMotion n/N commands,
    whilst allowing a one key argument for the find. This also makes it easier
    in case I screw up so I can cycle with n/N.)
* nERDTree: I want you as a Toggle, but I also want you to always autotree node
  to CWD

Low Priority
* stop being so goddamn slow when scrolling through long lines and with syntax
  on. Setting max syntax through column shouldn't be an issue to begin with
* easyMotion: Include the fold title as part of search
* nERDTree: 'cd' doesn't work in the tree, nor does :NERDTreeCWD
* some plugin to track all the commands I do in normal mode and ex mode. This
  way, I can see how productive I can be by remapping the keys that take longest
  or shortest

## zathura

Low Priority
* have J/K be your PgUp/Downs, while <C-j><C-k> navigate to the beginning/end of
  the page. E.g., you're at the top of the page but don't see the whole page,
  <C-j> hits you to the end of the page, then <C-j> again hits you to the
  beginning of the next page, etc. etc

## ios: notability

high priority
* have zoom box not have any delay when writing into it and waiting for new
  space

## ios: notability

low priority
* vertical margins
* hardcoded margins where you just can't write there

## ios: penultimate

high priority
* zoom box

## ios: goodnotes

high priority
* directly sync with dropbox instead of import/export, e.g., no need to create
  additional copy when reading/editing a file in goodnotes; automatically
  detects files in dropbox and places in goodnotes; delete files when deleting
  from goodnotes

## Website: Any.Do

High Priority
* folder rearrangement
* list of previously performed tasks, with some sort of revision control
* custom keyboard shortcuts

Medium Priority
* an easy way to determine which tasks have extra descriptions/subtasks (this is
  available in mobile but not web), and which tasks are given certain dates
* more flexible recurring tasks
* better UI (not everything centerfaced, and more tiling/columns of things such
  as seeing descriptions/subtasks for a specific task (don't zoom into it and
  not be able to see anything else); the folders should each be tabs you can
  click, and you should be able to select a folder on the left of the web
  interface, not click at the top then see all folders)
* color options for different folders

Low Priority
* description region (hack: write them as subtasks) ## Web App: Asana

High Priority
* custom keyboard shortcuts
* auto-assign all personal project stuff to me
* offline access that syncs afterwards, like with editing Dropbox files
* better mobile functionality: especially in adding tasks (it shouldn't just
* exist in the new tasks list on the desktop), and moving things
* super slow launch time

Medium Priority
* prettier UI

Low Priority
* tags in personal projects (hack: use a workspace as your personal instead)
* ability to reorganize personal projects (hack: use a workspace as your
  personal instead) ## Web App: Google Calendar

High Priority
* better fucking Tasks functionality
  * have the ability to view multiple tasks lists simultaneously, with this
    option for both the calendars (just like you can click on and off for
    multiple calendars) and the task lists. Without this option, I'm currently
    forced to use only one task list (otherwise I'd have to recheck multiple
    lists over and over, and I could easily forget something). But then in order
    to organize things efficiently, I use indented tasks, which only allows one
    sorting option. I would then only use multiple task lists if those two
    sections of my life were extremely discrete and demanded the schism while
    fully understanding that I cannot combine the two (e.g. my anime blog task
    list and my work life task list). Ultimately, it's a shitty life trying to
    adapt to all the limitations here, and so you'd be better off at not
    integrating your task/todo list into your calendar at the moment
    * collapsible tasks grouped under subtasks
    * allow indentation still when sorted under due date. Without this, I'm
      forced to stick with my own order
  * import/export/share tasks
  * reminders (SMS, email, popup) for tasks
  * recurring tasks (e.g. to do something every week like Groceries)
* vim-able modal keybinding
  * at the very least, customizable keybinds for what's already available

Medium Priority
* larger expansions of long text strings as titles of tasks or events

Low Priority
* sort calendars

## Website: Gmail (google-chrome)

High Priority
* allow desktop notifications to come from any category, not just primary
* allow undo send to more easily hit undo

## website/app: google calendar

high priority
* better interface, like apple's
* include more services, such as facebook events and their birthdays without
  having to treat it as another subscription, so then you get the little fb icon
  like apple's calendar

## website: delicious

high priority
* better ui, like kifft/kifi with comments, images
* auto-tagging based on classification algorithm
* more universality, e.g., ability to save in feedly
* better safari page add, which doesn't open a new page to bookmark
  something

## Website: Instapaper

High Priority
* a public profile, so others can view all your saved articles
* organizing archived content, e.g., if I use folders as a way of organizing
  content, I need the ability to differentiate them as "read/unread", rather
  than have the "unread" list exclusive
* free search and mobile app

## Website: MangaTraders

Medium Priority
* When downloading a file but not being able to download because the connection
  limit is reached, don't strikethrough the file

## Website: Pocket

High Priority
* a public profile, so others can view all your saved articles
* subfolders
* better clustering and viewing of tags, like delicious'
* edit titles (otherwise it is impossible to organize pdfs)

Low Priority
* buld move articles from one tag to another (but not all in the tag, which is
  what merge can do)

## Website: Wunderlist

High Priority
* as responsive and quick as the desktop client
* auto set reminder to due date
* revision control history
  * e.g., to see what you completed yesterday, at what time, when things were
    renamed, and more stats reporting to see when you tend to complete things
* rearrange tasks within due today
* more functionality to edit multiple tasks
  * e.g., set all their due dates (possible in desktop client)

Medium Priority
* more keyboard shortcuts (and custom ones)
  * up down left right
  * set due today, due tomorrow
  * sort by due date, by alphabetical, etc.
  * edit task description, edit task title, edit due date
* add a "start date", and in general a time range to complete tasks
  * e.g., you need to plan out a bunch of tasks to do during a week-long
    vacation (hack: make a list and put all those tasks in there; only problem
    is that you can't then organize those tasks by categories; second hack: also
    use remind me's as start dates, although ideally they should also be
    displayed in the pure task list)
* move tasks between lists without requiring the all smart list in android; it's
  impossible to move them without taking a super long time, so you're pretty
  much forced to wait until you have a desktop to move stuff
* ability to archive lists, not necessarily delete them (simply hide them from
  view); current workaround is before deleting a list, i move all the completed
  tasks to the inbox
* undo button

Medium Priority
* calendar sync
* subsections in lists
  * (hack: prepend "#subsection-name " to all such tasks, using the tags system
    as the subsection)
* ability to set inbox to auto, or hidden, just like the others
* better design (not as 3d/button-y)
* ability to customize background image
* a date to start doing a task (hack: use due date for now)
* ability to rearrange the smart lists

Low Priority
* more flexible recurring tasks
* real tags, and not shitty hashtags that make it difficult to add to multiple
  or have their own design
* color options for different folders ## Website: Goodreads

High Priority
* >5 ratings on rating scale

Low Priority
* Ability to remove sections of profile to clean it up

## Website: StyleForum Classifieds

High Priority
* Budget restrictions, search engine, item classifications, more immediately
  clear whether active listing or not, and certain key phrases that everyone
  uses, like "closet cleaning"
* Implement embedded, auto-loaded images on the classified forum posts, not
  require some stupid pop-up image that takes forever to load because the image
  servers are so slow

## Website: Youtube

High Priority
* stahp losing buffer when you move to new seek position
* load the entire playback even while the video is paused
* store the entire buffer into cache so you can replay a video without requiring
  to buffer all over again

## Website: Anything with a Search Engine

High Priority
* f'kin regex functionality

## Website: Online Surveys

Survey Monkey -: can only do <=100 responses, can't export data to .csv, can't
change layout that much

Google Form -: Can't track IP, default fonts are ugly, can't autoclose at a date
and with custom end text, poor summary stats (not that this matters much)

## misc: colemak

* universality, i.e., harder to type among other's keyboards since not everyone
  uses it, and also default application keybinds
* should be language agnostic
