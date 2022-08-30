if &compatible
  set nocompatible
endif

" 取消netrw
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

if !has('gui_running')
    set t_Co=256
endif

" 打开语法高亮
syntax on

set nospell

" 字符集
set encoding=utf-8
set fileencoding=utf-8

" 鼠标支持
set mouse=a

" 开启选择模式
" set selectmode=mouse

" 这样在切换buffer(文件/tab)的时候, 之前编辑的文件就只是切换到后台, 而不是关掉, 所以再切换回来, undo历史仍然在, 可以undo.
set hidden

" 折叠
set foldmethod=syntax

" 默认是已折叠状态
set nofoldenable

" 输入法相关
set iminsert=0
set imsearch=0

" 文件从外部被改变时自动更新内容
set autoread

set updatetime=250
set noswapfile

" 显示行号
set number

" 不自动换行显示
set nowrap

" 高亮当前行
set cursorline

" 高亮第200,300列
set colorcolumn=200,300

" 如果显示tab，行尾等的字符
set listchars=tab:│\ ,trail:·                                                   "Set trails for tabs and spaces
" 显示不可见字符
set list                                                                        "Enable listchars

set lazyredraw                                                                  "Do not redraw on registers and macros
set conceallevel=2 concealcursor=i                                              "neosnippets conceal marker

" tab为4个空格
set tabstop=4
set softtabstop=4

" 缩进为4个空格
set shiftwidth=4

" 智能tab
set smarttab

" tab替换为空格
set expandtab

" 智能缩进
set smartindent
set breakindent

" 组合键超时时间
" if !has('nvim') && &ttimeoutlen == -1
  " set ttimeout
  " set ttimeoutlen=100
" endif
" timeout for vim-which-key
" notimeout to close vim-which-key
set timeout
set timeoutlen=500

" 底部命令行补全
set wildmenu
set wildchar=<Tab>
set wildmode=full
set wildignorecase
set wildignore+=*.o,*.obj,*~                                                     "stuff to ignore when tab completing
set wildignore+=*.git*
set wildignore+=*.meteor*
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*mypy_cache*
set wildignore+=*__pycache__*
set wildignore+=*cache*
set wildignore+=*logs*
set wildignore+=*node_modules*
set wildignore+=**/node_modules/**
set wildignore+=*DS_Store*
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=**/.svn/**
set wildignore+=**/.git/**
set wildignore+=**/.vscode/**

" 弹出菜单长度
set pumheight=15

" 当光标距离页面顶部/底部还有n行时就开始滚动
set scrolloff=2
" 同上，不过是左右两边
set sidescrolloff=2

" session
set sessionoptions+=globals

" 不在底部显示当前模式，用lightline替代
set noshowmode

" 搜索时忽略大小写
set ignorecase

" 取消swap文件
set noswapfile
set nobackup                                                                    "Disable saving backup file
set nowritebackup                                                               "Disable writing backup file

set diffopt+=vertical                                                           "Always use vertical layout for diffs

" 搜索模式下才高亮匹配到的内容，其它时候不高亮，比如按下回车确定
augroup vimrc-incsearch-highlight
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

" jsonc支持
autocmd FileType json syntax match Comment +\/\/.\+$+

augroup vimrc
  autocmd!
  " autocmd BufWritePre * call s:strip_trailing_whitespace()                      "Auto-remove trailing spaces
  " autocmd InsertEnter * set nocul                                               "Remove cursorline highlight
  " autocmd InsertLeave * set cul                                                 "Add cursorline highlight in normal mode
  autocmd FocusGained,BufEnter * silent! exe 'checktime'                        "Refresh file when vim gets focus
  " autocmd FileType vim inoremap <buffer><silent><C-Space> <C-x><C-v>
  autocmd FileType markdown setlocal spell
  autocmd FileType json setlocal equalprg=python\ -m\ json.tool
  " autocmd TermOpen * setlocal nonumber norelativenumber
  autocmd VimEnter * call s:set_path()
augroup END

function! s:strip_trailing_whitespace()
  if &modifiable
    let l:l = line('.')
    let l:c = col('.')
    call execute('%s/\s\+$//e')
    call histdel('/', -1)
    call cursor(l:l, l:c)
  endif
endfunction

function! s:set_path() abort
  let l:dirs = filter(systemlist('find . -maxdepth 1 -type d'), {_,dir ->
        \ !empty(dir) && empty(filter(split(&wildignore, ','), {_,v -> v =~? dir[2:]}))
        \ })

  if !empty(l:dirs)
    let &path = &path.','.join(map(l:dirs, 'v:val[2:]."/**/*"'), ',')
  endif
endfunction

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
