" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Basic settings for vim. Remappings will come later.
set nocompatible              " required
set clipboard=unnamed		  " allows normal copy & paste
set nu
set hlsearch
set paste
set shortmess+=I
set tabstop=4
set virtualedit=all
set t_Co=256				  " had issues using color schemes in tmux

" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile
filetype off                  " required

autocmd FileType python map <buffer> <S-e> :w<CR>:!/usr/bin/env python3 %<CR>
"autocmd FileType python xnoremap <leader>p :w !python<cr>

filetype plugin indent  on    " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" Folding
Plugin 'tmhedberg/SimpylFold'

"Indentation
Plugin 'vim-scripts/indentpython.vim'

"Auto-Completion
Bundle 'Valloric/YouCompleteMe'

"Syntax Checking/Highlighting
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'

"Color schemes 
Plugin 'jnurmine/Zenburn'
Plugin 'chriskempson/base16-vim'
Plugin 'jacoborus/tender.vim'
Plugin 'vim-scripts/xoria256.vim'
" Nertree file tabs
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'

"Github configuration
Plugin 'tpope/vim-fugitive'

"Powerline
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

"CSV
Plugin 'csv.vim'

"Slimux (TMUX integration)
Plugin 'epeli/slimux'

" Jedi - helps with python completion and documentation lookup.
Plugin 'davidhalter/jedi-vim.git' 

" Itegrating R with vim 
Plugin 'jalvesaq/Nvim-R'

" Screen.vim, integrates with tmux to send code to be evaluated by programming running in shell
Plugin 'ervandew/screen'

" Configuring vim to runing python in tmux pane.
Bundle 'thoughtbot/vim-rspec'
Bundle 'jgdavey/tslime.vim'

" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required

" Allows for easy remappings of new keyboard , + (any other key).
let mapleader = ","


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Split / Tab Navigations  
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Window Splits
set splitbelow
set splitright

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" Show docstrings for folded code
let g:SimpylFold_docstring_preview=1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indentation 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Flagging Unnecessary Whitespace
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UTF8 Support 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim formatting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"colorscheme tender
colorscheme xoria256

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NerdTree 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
nmap <silent> <C-n> :NERDTreeToggle<CR>
map  <C-l> :tabn<CR>
map  <C-h> :tabp<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Powerline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INS
set t_Co=256
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSV 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi CSVColumnEven term=bold ctermbg=6
hi CSVColumnHeaderEven term=bold ctermbg=6
hi CSVColumnOdd term=bold ctermbg=4
hi CSVColumnHeaderOdd term=bold ctermbg=4
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual Selection 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

  
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python IDE settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 
" Settings for jedi-vim
" cd ~/.vim/bundle
" git clone git://github.com/davidhalter/jedi-vim.git
let g:jedi#usages_command = "<leader>z"
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto-Complete 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_path_to_python_interpreter = '/usr/bin/python3'
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Virtual Envrionment Support
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax Checking/Highlighting 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let pytonn_highlight_all=1
syntax on
syntax enable
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configuration for Tmux 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rspec_command = 'call Send_to_Tmux("rspec {spec}\n")' 

" vim-rspec mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""" R plugin with tmux and screen.vim """""""""""""

" sample settings for vim-r-plugin and screen.vim
" Installation 
"       - Place plugin file under ~/.vim/
"       - To activate help, type in vim :helptags ~/.vim/doc
"       - Place the following vim conf lines in .vimrc
" Usage
"       - Read intro/help in vim with :h vim-r-plugin or :h screen.txt
"       - To initialize vim/R session, start screen/tmux, open some *.R file in vim and then hit F2 key
"       - Object/omni completion command CTRL-X CTRL-O
"       - To update object list for omni completion, run :RUpdateObjList
" My favorite Vim/R window arrangement 
"	tmux attach
"	Open *.R file in Vim and hit F2 to open R
"	Go to R pane and create another pane with C-a %
"	Open second R session in new pane
"	Go to vim pane and open a new viewport with :split *.R
" Useful tmux commands
"       tmux new -s <myname>       start new session with a specific name
"	tmux ls (C-a-s)            list tmux session
"       tmux attach -t <id>        attach to specific session  
"       tmux kill-session -t <id>  kill specific session
" 	C-a-: kill-session         kill a session
" 	C-a %                      split pane vertically
"       C-a "                      split pane horizontally
" 	C-a-o                      jump cursor to next pane
"	C-a C-o                    swap panes
" 	C-a-: resize-pane -L 10    resizes pane by 10 to left (L R U D)
" Corresponding Vim commands
" 	:split or :vsplit      split viewport
" 	C-w-w                  jump cursor to next pane-
" 	C-w-r                  swap viewports
" 	C-w C-++               resize viewports to equal split
" 	C-w 10+                increase size of current pane by value

" To open R in terminal rather than RGui (only necessary on OS X)
" let vimrplugin_applescript = 0
" let vimrplugin_screenplugin = 0
" For tmux support
let g:ScreenImpl = 'Tmux'
let vimrplugin_screenvsplit = 1 " For vertical tmux split
let g:ScreenShellInitialFocus = 'shell' 
" instruct to use your own .screenrc file
let g:vimrplugin_noscreenrc = 1
" For integration of r-plugin with screen.vim
let g:vimrplugin_screenplugin = 1
" Don't use conque shell if installed
let vimrplugin_conqueplugin = 0
" map the letter 'r' to send visually selected lines to R 
let g:vimrplugin_map_r = 1
" see R documentation in a Vim buffer
let vimrplugin_vimpager = "no"
"set expandtab
set shiftwidth=4
set tabstop=8
" start R with F2 key
map <F2> <Plug>RStart 
imap <F2> <Plug>RStart
vmap <F2> <Plug>RStart
" send selection to R with space bar
vmap <Space> <Plug>RDSendSelection 
" send line to R with space bar
nmap <Space> <Plug>RDSendLine

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tslime settings 
let g:tslime_always_current_session = 1
let g:tslime_always_current_window = 1
vmap <C-c><C-c> <Plug>SendSelectionToTmux
nmap <C-c><C-c> <Plug>NormalModeSendToTmux
nmap <C-c>r <Plug>SetTmuxVars

