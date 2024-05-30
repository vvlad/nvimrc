
### Install

```sh
rm -rf ~/.local/share/nvim ~/.cache/nvim ~/.local/state/nvim/
git clone https://github.com/vvlad/nvimrc ~/.config/nvim

cd ~/.config/nvim/helper/
go build -o e main.go
cp e ~/.local/bin/

```

Add ~/.local/bin/e to the $PATH enviroment variable

### The e

1. Opens neovide if no argument is given
2. If an argument is given then it computes an address that is passed to --listen to enable nvim remote support.  
   The address is computed using the following rules:
   - if $NVIM variable is set that it will be used as the address
   - it walks the directory hierarchy starting from the path provided as an argument, and if a associated address is found that that will be used.
   - otherwise if there is a parent directory that has a .git directory the address of that directory will be used
   - otherwise if no address has been identified then address of the provided argument will be used if the argument is a directory
   - otherwise the address of the directory of the provided argument will be used
3. If the connection to the unix address is established then the path that was passed will be opened in that nvim instance
4. otherwise a new neovide instance is launched for the associated address

## References

Nvim Events - https://gist.github.com/dtr2300/2f867c2b6c051e946ef23f92bd9d1180
