# VimPro - create a professional IDE from Vim in a minute
### Plugin manager:
* [pathogen.vim](https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim)
### Basic Plugins list:
* [Syntastic](https://github.com/scrooloose/syntastic) 
* [YouCompleteMe](https://github.com/Valloric/YouCompleteMe) 
* [NERDTree](https://github.com/scrooloose/nerdtree) 
* [Taglist](https://github.com/vim-scripts/taglist.vim) 
* [FZF](https://github.com/junegunn/fzf) 
* [vim-airline](https://github.com/vim-airline/vim-airline) 
* [vim-fugitive](https://github.com/tpope/vim-fugitive) 
##### You can also choose:
* [surround](https://tpope.io/vim/surround) 
* [vim-gitgutter](https://github.com/airblade/vim-gitgutter.git) 
* [delimitMate](https://github.com/Raimondi/delimitMate.git) 
* [vim-statline (vim-airline replacement)](https://github.com/millermedeiros/vim-statline) 
* [Ctrlp (fzf replacement)](https://github.com/ctrlpvim/ctrlp.vim) 
### Additional packages:
* silversearcher-ag
* exuberant-ctags
* python-dev 
* python3-dev 
* wget 
* git
### Custom commands:
##### All modes
* ctrl+s - save 
##### Normal mode
* F2 - Enable/Disable Paste Mode (auto-indenting)
* F3 - NERDTree
* F4 - Taglist
* F7 - Run silversearcher (if silversearcher-ag is installed)
* ctrl+x - save and exit
* ctrl+q - exit without saving
* ctrl+n - open a new tab
* ctrl+c + ctrl+l - close syntastic window
* wa - copy word to buffer
* wp - replace word with buffer (wa)
### Other:
+ Automatically removes trailing whitespaces on save
+ [Toggle auto-indenting for code paste (F2)](http://vim.wikia.com/wiki/Toggle_auto-indenting_for_code_paste)
### Vim auto deployment on save
Automatically upload files to a remote host whenever a change is saved in the Vim

~/.vimrc:
```bash
autocmd BufWritePost * execute "!if [ $PWD == '/source/folder' ]; then 
    /usr/bin/rsync -avz --update -e 'ssh -p 9966' --delete --exclude='.data' \
    --exclude='migrations' --exclude='.env' --exclude='.git' --exclude='.idea' \
    /source/folder root@remotehost.com:/destination/folder;fi"
```

### Alternatively we can create a deploy comand to run deploy manually:
~/.vimrc:
```bash
command Deploy execute "!/usr/bin/rsync ..."
map <F5> :Deploy<CR>
```

### Highlight right screen block after 81 symbol (conflicts with xoria256 theme)
```auto
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermbg=236 guibg=#2c2d27
```
### Set ripgrep as default fzf file searcher

~/.bashrc:
```
export FZF_DEFAULT_COMMAND='rg --files'
```
