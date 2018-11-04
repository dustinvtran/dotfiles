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


## misc notes

I most commonly use the following commands on tmux.

```sh
ctrl-b d to detach with tmux
ctrl-b )
ctrl-b (
ctrl-b :rename-session
tmux new-session
tmux attach
tmux attach -t 1
```

To automatically crop whitespace in an image, I run the following command over
all files in a directory.

```sh
for a in *.png; do convert -trim "$a" "$a"; done
```

To avoid writing my password each time I SSH (e.g., push to git, connect to a
server), I write the following:

```sh
ssh-add
```
Things I no longe ruse but still would find useful if I have the use case:

Cataloging an archive.
```sh
# List directory structure of ~/dvt/media
# TODO: write as external shell script
alias media-catalog=" ( find '/mnt/sdb1' -type d -not -path '*/\[backlog\]/*'\
    | sed -e 's/^\/mnt\/sdb1\///' -e '/^\/media\/sdb1/d'\
    | sed -e 's/\[backlog\]/\[aabacklog\]/'\
    && echo 'anime/[aabacklog]/...
anime/[aabacklog]/[completed]
anime/[aabacklog]/[completed]/...
anime/[aabacklog]/[current]
anime/[aabacklog]/[current]/...
anime/[aabacklog]/[winter-2014]
anime/[aabacklog]/[winter-2014]/...
films/[aabacklog]/...
films/[aabacklog]/[completed]
films/[aabacklog]/[completed]/...
literature/[aabacklog]/...
literature/[aabacklog]/[completed]
literature/[aabacklog]/[completed]/...
manga/[aabacklog]/...
manga/[aabacklog]/[completed]
manga/[aabacklog]/[completed]/...
manga/[aabacklog]/[current]
manga/[aabacklog]/[current]/...
music/[aabacklog]/...
music/[aabacklog]/[completed]
music/[aabacklog]/[completed]/...
tv/[aabacklog]/...
tv/[aabacklog]/[completed]
tv/[aabacklog]/[completed]/...
video games/[aabacklog]/...
video games/[aabacklog]/[completed]
video games/[aabacklog]/[completed]/...
visual novels/[aabacklog]/...
visual novels/[aabacklog]/[completed]
visual novels/[aabacklog]/[completed]/...' )\
    | sort\
    | sed -e 's/\[aabacklog\]/\[backlog\]/'\
    | sed -e 's/^\(anime\|films\|literature\|manga\|music\|tv\|video games\|visual novels\)$/\n&/'\
    | sed -e '1i This lists the entire directory structure of my ~/dvt/media folder, which is a collection\
 of all titles I rate >=8/10 and\n their affiliated installments. It also stores my massive backlogs within each\
 medium, but I omit them here. Why archive\n my media directory structure, you ask? Because its so pretty and\
 autistic of me I simply must. When you\x27re a consumer,\n there ought to be a competent way to organize your\
 collection. See ~/.zshrc for the command.'\
    > ~/doc/media-catalog"
```

Screen capture and GIFs.

```sh
alias screencapture="screencapture -T 3 ~/dvt/media/pictures/screencaps/desktop/$(date +%Y-%m-%T).png"
alias screencapturei="screencapture -i ~/dvt/media/pictures/screencaps/desktop/$(date +%Y-%m-%T).png"
alias byzanz-record="cd ~/dvt/media/pictures/screencaps/byzanz && byzanz-record -c -d 10 dvt.gif && cd -"
```

```sh
alias coursera-dl="coursera-dl -n -f 'mp4'"
alias matlab="matlab -nodesktop"
alias R="R --no-save"
```
