" Plugins will be downloaded under the specified directory.
if has('win32')
    call plug#begin('~/AppData/Local/nvim/plugged')
else
    call plug#begin('~/.vim/plugged')
endif

" 基于Seoul Colors的低对比度配色方案
Plug 'junegunn/seoul256.vim'

" color
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'arzg/vim-colors-xcode'
Plug 'arzg/vim-colors-xcode'

" 不用多说了吧
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" 状态栏
Plug 'itchyny/lightline.vim'

" 在浮动窗口中打开一个终端
Plug 'voldikss/vim-floaterm'

" leaderf
" Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' }
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

Plug 'andymass/vim-matchup'

" 语法高亮包
Plug 'sheerun/vim-polyglot'

" 异步增量更新tags
" gtags管理leaderf已经内置了类似功能，这里不用了
" 用来生成ctags
" Plug 'ludovicchabant/vim-gutentags'

" 扩展 % 键匹配
Plug 'andymass/vim-matchup'

" 自动改匹配的html tag
Plug 'AndrewRadev/tagalong.vim'

" 增却搜索的光标体验
Plug 'haya14busa/vim-asterisk'

" 增却搜索的信息显示
" Plug 'osyo-manga/vim-anzu'

" comment plugin 注释插件
Plug 'tpope/vim-commentary'

" 快速在单词两侧填充字符
Plug 'tpope/vim-surround'

" extend repeat,
" 扩展vim自带重复(快捷键: . )功能, 可以支持 vim-surround
" http://einverne.github.io/post/2014/11/vim-plugin-vim-repeat.html
" http://wklken.me/posts/2015/06/13/vim-plugin-surround-repeat.html
Plug 'tpope/vim-repeat'

" git plugin
Plug 'tpope/vim-fugitive'

" 快速将多行合并成单行或单行拆分成多行
Plug 'AndrewRadev/splitjoin.vim'

Plug 'editorconfig/editorconfig-vim'

Plug 'liuchengxu/vim-which-key'

" markdown 预览
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'
" 目录树
if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" 快速跳转
Plug 'easymotion/vim-easymotion'

" 快速对齐
Plug 'junegunn/vim-easy-align'

" 滚动条
Plug 'Xuyuanp/scrollbar.nvim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" ============================================================================================
" Better search status
" nnoremap <silent><Leader><space> :AnzuClearSearchStatus<BAR>noh<CR>
" nmap n <Plug>(anzu-n)zz
" nmap N <Plug>(anzu-N)zz
" map * <Plug>(asterisk-z*)<Plug>(anzu-update-search-status)
" map # <Plug>(asterisk-z#)<Plug>(anzu-update-search-status)
" map g* <Plug>(asterisk-gz*)<Plug>(anzu-update-search-status)
" map g# <Plug>(asterisk-gz#)<Plug>(anzu-update-search-status)

" ============================================================================================
" 打开终端
nnoremap <silent><Leader>G :FloatermNew<CR>
let g:floaterm_keymap_toggle = '<Leader>T'                                      "Mapping for toggling floaterm

" ============================================================================================
" matchup
let g:matchup_matchparen_status_offscreen = 0                                   "Do not show offscreen closing match in statusline
let g:matchup_matchparen_nomode = "ivV\<c-v>"                                   "Enable matchup only in normal mode
let g:matchup_matchparen_deferred = 1                                           "Defer matchup highlights to allow better cursor movement performance

" ============================================================================================
" which key
" nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
" nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR

" ============================================================================================
" easy motion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
" nmap m <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap m <Plug>(easymotion-bd-w)
" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1
" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" ============================================================================================
" easy align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" 滚动条设置
augroup ScrollbarInit
  autocmd!
  autocmd WinEnter,FocusGained,CursorMoved,VimResized * silent! lua require('scrollbar').show()
  autocmd WinLeave,FocusLost                          * silent! lua require('scrollbar').clear()
augroup end

" markdown
nmap <silent> <F5> <Plug>MarkdownPreview        " for normal mode
imap <silent> <F5> <Plug>MarkdownPreview        " for insert mode
nmap <silent> <F5> <Plug>StopMarkdownPreview    " for normal mode
imap <silent> <F5> <Plug>StopMarkdownPreview    " for insert mode
