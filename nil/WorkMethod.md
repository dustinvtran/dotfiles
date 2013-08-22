In the works. This documents how my work methodology, particularly in how I make the most effective use of my window management, main applications, etc.

### Window Management
For frequently used applications, I float them, often because they don't need to take the entire screen nor does it look very pretty (particularly on my 27'' display). In fact, that becomes counter-intuitive to the tiling WM philosophy, since while you're using the full screen for an application, you could more effectively use that unneeded space for another application (much like how I orient my floating windows). Gaps are pretty and arguably helps efficiency (it keeps my eyes focused on key apps for example, and concentrates text from having massive margins). Then to focus an application, I have a keybind to focus each one of my main apps (as well a similar keybind which spawns them), with i3's properties set in place to give them the floating property and their location. This works both for 'casual use' and 'real work', as floating this way is efficient in both manners. I honestly use a mouse maybe once every 5 minutes at most, and the only times I require it are the few times pentadactyl fails on me in Firefox (e.g., popup links, javascript) and in non-main GUI apps like libreoffice and gimp.

### Keybinds

### [L+E] Laptop + External Display & [L] Laptop-only Display
I use a setup of a 1366x768 display connected to an external one with 1920x1080. However, I don't always have the external
display connected to the laptop. Hence, I noted necessary-to-change regions in my dotfiles with [L+E] and [L], which I
 (un)comment correspondingly depending on whichever displays I have available. The following apps have such regions:

* `~/.config/awesome/rc.lua`
* `~/.config/ranger/rifle.conf`
* `~/.config/zathura/zathurarc`
* `~/.irssi/config`
* `~/.mpv/config`
* `~/.xinitrc`
