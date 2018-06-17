#!/bin/bash


echo 'Installing packages\n'
sudo apt-get install -y vim python-dev python3-dev wget git exuberant-ctags

echo -e "\n########################################################\n"

echo "Installing basic vimrc settings"

while [[ "$xoria" != "y" && "$xoria" != "n" ]]; do
    echo "Install xoria256 theme? (y/n)"
    read xoria; done

if [[ "$xoria" == "y" ]]
then
    if [[ ! -d ~/.vim/colors ]]
    then
        mkdir ~/.vim/colors
        cp colors/xoria256.vim ~/.vim/colors/
    else
        if [[ ! -f ~/.vim/colors/xoria256.vim ]]
        then
            cp ./colors/xoria256.vim ~/.vim/colors/
        fi
    fi

    echo -e "
        set t_Co=256
        colorscheme xoria256" >> ~/.vimrc
fi

echo -e "\n########################################################\n"
 
echo -e "
set t_Co=256
colorscheme xoria256

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set ai
set autoindent
set incsearch
set nohlsearch
set mousemodel=popup
set termencoding=utf-8
set guioptions-=T
set mousehide
set pastetoggle=<F2>
set nocompatible

set splitright
set splitbelow
set number

function TrimEndLines()
    let save_cursor = getpos('.')
    :silent! %s#^\s\+\n#\r#g
    :silent! %s#\s\+\n#\r#g
    call setpos('.', save_cursor)
endfunction

au BufWritePre *.py call TrimEndLines()

autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview 

augroup AutoSaveFolds
  autocmd!
    autocmd BufWinLeave * mkview
    autocmd BufWinEnter * silent loadview
  augroup END

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
            
if &history < 1000
  set history=1000
endif

set hlsearch
set incsearch
set wildmenu
set wildmode=list:longest,list:full
set confirm
set completeopt=menuone,longest
set complete-=i

nmap <C-x> :wq<CR>
nmap <C-c><C-l> :lclose<CR>
nmap <C-n> :tabedit<CR>
noremap wa yiw
noremap wp viwp

nmap <C-q> :q!<CR>
noremap <C-S> :w<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>
" >> ~/.vimrc
echo 'Done'

echo -e "\n########################################################\n"

echo 'Installing pathogen'
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    wget https://tpo.pe/pathogen.vim -O ~/.vim/autoload/pathogen.vim
    echo -e "
        execute pathogen#infect()
        syntax on
        filetype plugin indent on" >> ~/.vimrc
echo 'Done'

echo -e "\n########################################################\n"

echo 'Installing syntastic'
git clone https://github.com/scrooloose/syntastic.git ~/.vim/bundle/syntastic
echo -e "
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
    let g:syntastic_loc_list_height=5
    let g:syntastic_python_checkers = ['flake8']
    let g:syntastic_python_flake8_args = '--ignore=\"E501,E302,E261,E701,E241,E126,E127,E128,W801,E265,E303\"'" >> ~/.vimrc
echo 'Done'

echo -e "\n########################################################\n"

echo 'Installing  YouCompleteMe'
cd ~/.vim/bundle/ && git clone https://github.com/Valloric/YouCompleteMe.git && \
    cd YouCompleteMe && git submodule update --init --recursive && ./install.py --clang-completer
echo -e "
    au FileType python set omnifunc=pythoncomplete#Complete
    let g:SuperTabDefaultCompletionType = 'context'
    set completeopt=menuone,longest,preview
    let g:ycm_auto_trigger = 0
    let g:ycm_autoclose_preview_window_after_completion = 1" >> ~/.vimrc
echo 'Done'

echo -e "\n########################################################\n"

echo 'Installing NERDTree'
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
echo -e "
\" NERDTree config
map <F3> :NERDTreeToggle<CR>
let NERDTreeIgnore=['.\.obj$', '.\.o$', '.\.so$', '.\.exe$', '.\.git$', '.\.swp$']
\" Automatically quit vim if NERDTree is last and only buffer
autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif

function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('py', 'lightblue', 'none', 'lightblue', '#0099ff')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
" >> ~/.vimrc
echo 'Done'

echo -e "\n########################################################\n"

echo 'Installing Taglist'
git clone https://github.com/vim-scripts/taglist.vim.git ~/.vim/bundle/taglist.vim
echo 'Done'

echo -e "\n########################################################\n"

while [[ "$tagger" != "1" && "$tagger" != "2" ]]; do
    echo "Install tagger:"
    echo "1. Ctrlp"
    echo "2. FZF (recommended)"
    read tagger; done

if [[ "$tagger" == "1" ]]
then
    echo 'Install Ctrlp'
    git clone https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim
    echo -e "
    let g:ctrlp_extensions = ['tag']
    nnoremap <C-o> :CtrlPTag<cr>
    set runtimepath^=~/.vim/bundle/ctrlp.vim" >> ~/.vimrc
    echo 'Done'
else
    echo 'Install FZF'
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
    git clone https://github.com/junegunn/fzf.vim.git ~/.vim/bundle/fzf.vim
    echo "set rtp+=~/.fzf" >> ~/.vimrc
    echo 'Done'
fi

echo -e "\n########################################################\n"

while [[ "$ag" != "y" && "$ag" != "n" ]]; do
    echo "Install silversearcher-ag? (y/n)"
    read ag; done
if [[ "$ag" == "y" ]]; then
    echo 'Installing silversearcher-ag'
    sudo apt-get install silversearcher-ag
    echo -e "nnoremap <F7> :Ag <C-R><C-W><CR>" >> ~/.vimrc
    echo 'Done'
fi

echo -e "\n########################################################\n"

while [[ "$line" != "1" && "$line" != "2" ]]; do
    echo "Install status line:"
    echo "1. vim-statline"
    echo "2. vim-airline (recommended)"
    read line; done

if [[ "$line" == "1" ]]
then
    echo 'Installing vim-statline'
    git clone https://github.com/millermedeiros/vim-statline.git ~/.vim/bundle/vim-statline
    echo 'Done';
else
    echo 'Installing vim-airline'
    git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
    git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/bundle/vim-airline-themes
    echo 'Remember to run :Helptags to generate help tags!'
    echo -e "
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_theme='lucius'
    let g:airline_section_z = '%p%%  \ue0a1 %l/%L Col:%c'
    let g:airline_powerline_fonts = '0'
    let g:airline_highlighting_cache = 1
    let g:airline#extensions#syntastic#enabled = 0
    let airline#extensions#tabline#tabs_label = ''
    let airline#extensions#tabline#show_splits = 0
    let g:airline#extensions#whitespace#checks = []
    let g:airline_detect_spell=0" >> ~/.vimrc
    echo 'Done';
fi

echo -e "\n########################################################\n"

echo 'Installing vim-fugitive (Git wrapper)'
git clone https://github.com/tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive
vim -u NONE -c "helptags vim-fugitive/doc" -c q
echo 'Done';

echo -e "\n########################################################\n"

while [[ "$sr" != "y" && "$sr" != "n" ]]; do
    echo "Install surround.vim? (y/n)"
    read sr; done

if [[ "$sr" == "y" ]]
then
    echo 'Installing surround.vim plugin'
    git clone https://tpope.io/vim/surround.git ~/.vim/bundle/surround
    vim -u NONE -c "helptags surround/doc" -c q
    echo 'Done'
fi

echo -e "\n########################################################\n"

while [[ "$gutter" != "y" && "$gutter" != "n" ]]; do
    echo "Install vim-gitgutter? (y/n)"
    read gutter; done
if [[ "$gutter" == "y" ]] 
then
    echo 'Installing vim-gitgutter plugin'
    git clone https://github.com/airblade/vim-gitgutter.git ~/.vim/bundle/vim-gitgutter
    echo 'Done'
fi

echo -e "\n########################################################\n"

while [[ "$delimitMate" != "y" && "$delimitMate" != "n" ]]; do
    echo "Install delimitMate? (y/n)"
    read delimitMate; done

if [[ "$delimitMate" == "y" ]]
then
    echo 'Installing delimitMate plugin'
    git clone https://github.com/Raimondi/delimitMate.git ~/.vim/bundle/delimitMate
    echo 'Done'
fi
