## Some notes to myself or otherwise.

1. The system-dotfiles are manual copy and pastes of system configs that I've edited and want to backup. I don't want to have the actual files in ~/system-dotfiles and symlink them, since that's a really bad idea. Manual copy-pastas for these are fine. 'pkglist' is formed from an alias, with 'pl > ~/system-dotfiles/pkglist'.
2. Don't add folders, only specific files. The only folders added are gm_scripts.
3. 'git rm' literally removes the file from local directory. Use 'git rm --cached', or my lovable alias 'gr'.
4. repository organization a la http://codingkilledthecat.wordpress.com/2012/08/08/git-dotfiles-and-hardlinks/.

## Quick-Start.

1. Add:
    ```
    ga file
    ```
2. Commit:
    ```
    gc 'msg'
    ```
3. Push:
    ```
    gp
    ```
