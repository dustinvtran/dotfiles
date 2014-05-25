# dotfiles
Hello!

The documentation for these dotfiles is currently being worked on, and is subject to vast changes at random moments in time.

## navigation
For general documentation, see `~/doc`. Scripts are in `~/bin`, and edited system configs are in `~/system-dotfiles`.

## syncing multiple PCs
I use two computers, and in order to manage their configuration files efficiently, I set up this dotfile repository with the following three branches:

* `laptop`: This is the branch displayed by default (in laymen's terms, the one you're most likely looking at at this moment), which comprises of the dotfiles used on my laptop PC.
* `desktop`: This comprises of the dotfiles used on my desktop PC. In order to view this branch, click the dropdown menu next to the repository name on Github.
* `master`: This holds all common dotfiles to be shared across all machines.

On each machine, all files are always committed and pushed into their respective niche branch (`laptop` and `desktop` accordingly). Whenever a common file is changed, i.e., one belonging to `master`, I checkout those files into the `master` branch. Then on the other machine, I merge the `master` branch into the machine-specific branch, which will update the common files but not affect the machine-specific files.

Thus all PCs share the common dotfiles in `master`, and they also use revision control for their machine-specific files on their respective branches. This is the best method to manage config files across multiple machines!

## screencaps
Here are a few screenies of current/past setups, sorted roughly in descending chronological order.

## current (laptop)
![screeny4](http://a.pomf.se/msusru.png)

###desktop - first display
![screeny3](http://a.pomf.se/3Hy9.png)

##desktop - second display
![screeny2](http://a.pomf.se/6Wh3.png)

##laptop
![screeny1](http://a.pomf.se/3Zp7.gif)
