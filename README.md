I use two computers, and in order to manage their configuration files efficiently, I set up this dotfile repository with the following three branches:

* `desktop`: This is the branch displayed by default (in laymen's terms, the one you're most likely looking at at this moment), which comprises of the dotfiles used on my desktop PC.
* `laptop`: This comprises of the dotfiles used on my laptop PC. In order to see the dotfiles of this one instead, click the dropdown menu next to the repository name on Github.
* `master`: This holds all common dotfiles to be shared across all machines.

On each machine, all files are always committed and pushed into their respective niche branch (`laptop` and `desktop` accordingly). Whenever a common file is changed (i.e., one belonging to `master`), I merge those files into the `master` branch. Then on the other machine, I merge the `master` branch into the machine-specific branch, which will update the common files but not affect the machine-specific files. Thus all PCs share the common dotfiles, and they also use revision control for their machine-specific files on their own branch. This is the best way to manage config files across machines!

For general documentation, see `~/doc`. Scripts are in `~/bin`, and edited system configs are in `~/system-dotfiles`.

##first display
![screeny1](http://a.pomf.se/3Hy9.png)

##second display
![screeny2](http://a.pomf.se/6Wh3.png)

##laptop by itself
![screeny3](http://a.pomf.se/3Zp7.gif)
