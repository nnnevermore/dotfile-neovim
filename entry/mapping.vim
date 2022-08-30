"inoremap <C-L> <Esc>

" 重载配置
nnoremap <Leader>rp :call <SID>reload_profile()<CR>

" 编辑配置
nnoremap <Leader>ep :call <SID>edit_profile()<CR>

" save
nnoremap <Leader>w :w<cr>
nnoremap <Leader>W :W!<cr>
nnoremap <Leader>wq :wq<cr>


if !exists('*s:reload_profile')
    function! s:reload_profile()
        runtime! init.vim
        if has('gui_running')
            runtime! ginit.vim
        endif
        echo "Reload profile done!"
    endfunction
endif

function! s:edit_profile()
    execute("e ".stdpath("config")."/init.vim")
endfunction

" 插入模式下，C-U 和 C-W不加入undo队列
if empty(mapcheck('<C-U>', 'i'))
  inoremap <C-U> <C-G>u<C-U>
endif
if empty(mapcheck('<C-W>', 'i'))
  inoremap <C-W> <C-G>u<C-W>
endif

" 移动
if !has('gui_running')
  nnoremap <C-L> <Esc><C-W><C-L>
  nnoremap <C-H> <Esc><C-W><C-H>
  nnoremap <C-J> <Esc><C-W><C-J>
  nnoremap <C-K> <Esc><C-W><C-K>
  tnoremap <C-H> <C-\><C-n><C-w>h
  tnoremap <C-L> <C-\><C-n><C-w>l
else
  nnoremap <A-L> <Esc><C-W><C-L>
  nnoremap <A-H> <Esc><C-W><C-H>
  nnoremap <A-J> <Esc><C-W><C-J>
  nnoremap <A-K> <Esc><C-W><C-K>
  tnoremap <A-H> <C-\><C-n><C-w>h
  tnoremap <A-L> <C-\><C-n><C-w>l
endif

" Down is really the next line
nnoremap j gj
nnoremap k gk
" Yank to the end of the line
nnoremap Y y$
" Copy to system clipboard
vnoremap <C-c> "+y
" Paste from system clipboard with Ctrl + v
inoremap <C-v> <Esc>"+p
" Move to the end of yanked text after yank and paste
nnoremap p p`]
vnoremap y y`]
vnoremap p p`]

" 注释
" Comment map
nmap <Leader>c gcc
" Line comment command
xmap <Leader>c gc

" Open vertical split
nnoremap <Leader>v <C-w>v

" quit buffer
" nnoremap <Leader>q <C-W>q

nnoremap <silent><Leader>q :call <sid>close_buffer()<CR>
nnoremap <silent><Leader>Q :call <sid>close_buffer(v:true)<CR>

function! s:close_buffer(...) abort
  if &buftype !=? ''
    return execute('q!')
  endif
  let l:windowCount = winnr('$')
  let l:totalBuffers = len(getbufinfo({ 'buflisted': 1 }))
  let l:noSplits = l:windowCount ==? 1
  let l:bang = a:0 > 0 ? '!' : ''
  if l:totalBuffers > 1 && l:noSplits
    let l:command = 'bp'
    if buflisted(bufnr('#'))
      let l:command .= '|bd'.l:bang.'#'
    endif
    return execute(l:command)
  endif
  return execute('q'.l:bang)
endfunction

nnoremap <silent> gF :call <sid>open_file_or_create_new()<CR>

function! s:open_file_or_create_new() abort
  let l:path = expand('<cfile>')
  if empty(l:path)
    return
  endif

  if &buftype ==? 'terminal'
    return s:open_file_on_line_and_column()
  endif

  try
    exe 'norm!gf'
  catch /.*/
    echo 'New file.'
    let l:new_path = fnamemodify(expand('%:p:h') . '/' . l:path, ':p')
    if !empty(fnamemodify(l:new_path, ':e')) "Edit immediately if file has extension
      return execute('edit '.l:new_path)
    endif

    let l:suffixes = split(&suffixesadd, ',')

    for l:suffix in l:suffixes
      if filereadable(l:new_path.l:suffix)
        return execute('edit '.l:new_path.l:suffix)
      endif
    endfor

    return execute('edit '.l:new_path.l:suffixes[0])
  endtry
endfunction

command! Json call <sid>paste_to_json_buffer()

function! s:paste_to_json_buffer() abort
  vsplit
  enew
  set filetype=json
  silent! exe 'norm!"+p'
  silent! exe 'norm!gg=G'
endfunction

function! s:open_file_on_line_and_column() abort
  let l:path = expand('<cfile>')
  let l:line = getline('.')
  let l:row = 1
  let l:col = 1
  if match(l:line, escape(l:path, '/').':\d*:\d*') > -1
    let l:matchlist = matchlist(l:line, escape(l:path, '/').':\(\d*\):\(\d*\)')
    let l:row = get(l:matchlist, 1, 1)
    let l:col = get(l:matchlist, 2, 1)
  endif

  let l:bufnr = bufnr(l:path)
  let l:winnr = bufwinnr(l:bufnr)
  if l:winnr > -1 && getbufvar(l:bufnr, '&buftype') !=? 'terminal'
    silent! exe l:winnr.'wincmd w'
  else
    silent! exe 'vsplit '.l:path
  endif
  call cursor(l:row, l:col)
endfunction
