# Work Method
-------------
In the works~~~ this is just random words at the moment

This documents my modus operandi, the god-endorsed efficiency that everyone and his grandmother should already be following. Here are some highly opinionated points that I centralize my methodology on:

* Keep your hands on the keyboard all the time, every time (particularly the home row).
* If it can be done faster, it will be done faster.
* Always look *fabulous*.

### Float vs. Tile
While I use a tiling window manager, I am first and foremost a floater. This is because none of my most frequently used applications actually need to take the entire screen, nor does it look very pretty (particularly on large displays). Sure, just add in another window, resize your portions, and then your window will still be tiled while with just enough room as you desire. But what about having it centered? What about that other window? I don't *care* about that window anyways, so why not center the one application I am using, and fill in beautiful gaps to view your wallpaper instead?

Doing the opposite already becomes counter-intuitive to the tiling WM philosophy. After all, gaps are not only aesthetically pleasing but arguably more efficient (it keeps my eyes focused on key apps for example, and prevents text from having ugly, unnecessarily gargantuan margins). With how I manage my windows (see below), floating can be just as, if not more, efficient than tiling.

### Window Management

For window navigation within  a workspace, I have keybinds to focus each one of my main applications (and the keybind spawns the app if it doesn't already exist). This makes it easy to move exactly where I want to go. Say I'm editing a file in Vim in one workspace, and now suddenly I want to browse my IRC client. Simple. `alt+i` instantly focuses irssi, I move around a bit or respond to someone, and then I `alt+w` to go back to editing my file in Vim.

My window manger's properties are also set in place to give each application the floating property, as well as their position. Each application's geometry are also automatically set, either from their own configuration file or from a commandline flag. This makes every application on startup to already be in position and to already be in the right size. Who needs tiling (a manually adjusted affair) when I already have the exact positions in mind?

### Keybinds

Vim. Vim always. Every one of my applications follow roughly the same idea, with `hjkl` taking the forefront in movement, and other essential Vim keys (e.g., `d`, `<Leader>`, modifiers with `hjkl`) taking analogous traits. This makes my keybinds universal across all platforms, and efficient through sane keybinds located near or on the home row.

With all these keybinds in place, I honestly only ever require a mouse for the perchance occasion in Firefox, when pentadactyl fails on me to do something (e.g., navigation in popup links or Javascript), or in non-main GUI apps like libreoffice and gimp.

### Working with a Dynamic Set of Displays
I use a setup of a 1366x768 display connected to an external one with 1920x1080, but this setup doesn't necessarily work on the go. Hence, I noted necessary-to-change regions in my dotfiles with [L+E] and [L], in which I (un)comment correspondingly depending on whichever displays I have available. The following apps have such notations:

* `~/.config/awesome/rc.lua`
* `~/.config/ranger/rifle.conf`
* `~/.config/zathura/zathurarc`
* `~/.irssi/config`
* `~/.mpv/config`
* `~/.xinitrc`
