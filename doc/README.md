# A philosophy of a workflow

In a past life, I fully customized my workflow in order to maximize efficiency. 
However, because of frequent collaboration, I took a full 180: 
defaults are preferred as minimum maintenance is the highest priority;
additional settings are only a feature creep.

Some philosophies:

+ More desktop app integration: use desktop apps over web apps if they have a
  particular advantage such as speed, desktop notifications, etc.
+ More use of built-in shortcuts: stick with built-in shortcuts unless your
  customization drastically increases productivity, e.g., s/t to move prev/next
  tab in firefox
+ Ability to go from all gui to all hacker terminal
  + preferably a nice gui aesthetic like hdni with power commands
+ Stick with app launcher/focuser for most things, only keybind things you need
  instant access to, such as browser, todolist, and vim, but not e.g., spotlight
+ Keep lots of stuff minimized, e.g., calendar, wunderlist, spotify
+ Allow other users to easily access, understand, and use primary apps (general
  desktop movement, browser)
+ Some easy combination of both all gui and all themed/customized cli apps
+ On browsers: modal editing just does not work here. Some pages work
  best under their own controls, so it makes no sense to have an
  overarching normal mode where you do browser navigation, and then
  you have to go to insert mode to work on the page, e.g., mail, or
  even simple things such as text input from google instant search.
  This requires the emacs approach of purely modifiers, and use only
  keys that no other app would.

Examples of moves from customizability extreme to defaults:
+ tiling manager -> none
+ colemak -> qwerty
+ firefox with modal editing, custom styles, etc. -> safari
+ irssi -> slack
+ mpd, npm -> spotify
+ ranger -> finder
+ transmission-cli -> utorrent
+ vim -> macvim
+ zathura -> slim

## primary applications

+ 1password | password manager
+ calibre | ebook reader
+ drive | cloud storage
+ finder, ranger | file manager
+ iterm2 | terminal
+ macvim | tex editor
+ mpv | video player
+ omnifocus, calendar | task manager
+ papers | paper library
+ preview, slim | pdf reader
+ rsync, ssh, tmux | working with remote servers
+ safari | web browser
+ mail, slack, gitter | messenger
+ spotify | music player
+ twitter | twitter client
+ utorrent | torrent client
+ zsh | Unix shell

## todo list

new setup
+ zsh
  + highlighting during selection
  + compinit
  + prompt with git branch, and other feature lines you can find on other ppl's
+ look more into os x hacks
+ dotfiles to save
  + dock
  + finder (e.g., favorites, open with)
  + google drive (selected folders)
  + iterm2
  + mail
  + omnifocus
  + safari (settings and extensions)
    + res | pinned subreddits
  + skim
  + spotify
  + system preferences
  (basically every gui app)
+ documentation
  + clean up the old three dotfiles branches
  + update new workflow docs
  + the list of apps in devices.ods
+ rss notifications
+ remove spotlight from menu bar

## manual

defaults write com.apple.screencapture location ~/Pictures
killall SystemUIServer
