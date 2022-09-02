" vimlsp
let g:markdown_fenced_languages = [
      \ 'vim',
      \ 'help'
      \]

let g:coc_global_extensions = [
            \ "coc-vimlsp",
            \ 'coc-json',
            \ 'coc-prettier',
            \ 'coc-vimlsp',
            \ 'coc-pairs',
            \ 'coc-tabnine',
            \ 'coc-emoji',
            \ 'coc-tag',
            \ 'coc-python'
            \]

" ==========================  2022-09-02 ==========================
" 旧版设置
" use <tab> for trigger completion and navigate to the next complete item
" 使用tab来触发coc补全
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~ '\s'
" endfunction

" " inoremap <silent><expr> <Tab>
" "      \ pumvisible() ? '\<C-n>' :
" "     \ <SID>check_back_space() ? '\<Tab>' :
" "    \ coc#refresh()

" " 使用tab来切换补全上下
" function s:tab_completion() abort
"   let snippet = snippets#check()
"   if !empty(snippet)
"     return snippets#expand(snippet)
"   endif

"   if pumvisible()
"     return "\<C-n>"
"   endif

"   if s:check_back_space()
"     return "\<TAB>"
"   endif

"   return coc#refresh()
" endfunction

" inoremap <silent><expr> <TAB> <sid>tab_completion()
" inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" inoremap <expr> <C-J> pumvisible() ? "\<C-N>" : "\<C-J>"
" inoremap <expr> <C-K> pumvisible() ? "\<C-P>" : "\<C-K>"
"
" ================================================================================
" 补全结束自动关闭预览窗口
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

nmap <Leader>ds :CocDiagnostics<CR>
nmap <Leader>dn <Plug>(coc-diagnostic-next)
nmap <Leader>dp <Plug>(coc-diagnostic-prev)
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <Leader>gd <Plug>(coc-definition)
nmap <Leader>gD <Plug>(coc-declaration)
nmap <Leader>gi <Plug>(coc-implementation)
nmap <Leader>gs <Plug>(coc-references)

vmap <Leader>fp  <Plug>(coc-format-selected)
nmap <Leader>fp  <Plug>(coc-format-selected)
nmap <Leader>=fp <Plug>(coc-format)

" nnoremap <expr><C-f> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-f>"
" nnoremap <expr><C-b> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-b>"


" 光标停在词上面时显示函数签名等信息
augroup vimrc_autocomplete
  autocmd CursorHold * silent! call CocActionAsync('highlight')
"  autocmd CursorHold * silent! call CocActionAsync('showSignatureHelp')
"  autocmd CursorHoldI * silent! call CocActionAsync('showSignatureHelp')
  autocmd FileType dbout let b:coc_enabled = 0
augroup END

" lightline support
"
let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component_function': {
            \   'cocstatus': 'coc#status'
            \ },
            \ }

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" ================================================================================
" 新版本coc的补全窗口不再使用内置浮动窗口了，所以需要修改一下设置
" 新设置
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" 当coc补全窗口存在时，c-j和c-k也可以上下移动
inoremap <expr> <C-J> coc#pum#visible() ? coc#pum#next(1) : "\<C-J>"
inoremap <expr> <C-K> coc#pum#visible() ? coc#pum#prev(1) : "\<C-K>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" ================================================================================
