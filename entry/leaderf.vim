" don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 1
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
" let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "Monaco" }
let g:Lf_StlSeparator = { 'left': '', 'right': '' }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

" let g:Lf_ShortcutF = "<leader>ff"
let g:Lf_ShortcutF = '<C-P>'
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

" noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
" noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" search visually selected text literally
" xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
" noremap go :<C-U>Leaderf! rg --recall<CR>


let g:Lf_RootMarkers       = ['.root', '.svn', '.git', '.project', '.vscode']
let g:Lf_CtagsFunc = {
    \ 'c': '--c-kinds=+px',
    \ 'c++': '--c++-kinds=+pxI'
  \ }

let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagslabel        = 'native-pygments'

if has('win32')
    let g:Lf_Gtagsconf         = 'C:\Users\wenqin\scoop\apps\global\current\share\gtags\gtags.conf'
endif

" gutentags支持
" let g:Lf_GtagsGutentags    = 0
" let g:Lf_CacheDirectory    = expand('~')

noremap <leader>fg  :<C-U><C-R>=printf("Leaderf! gtags" )<CR><CR>
" 引用
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
" 定义
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
" 重复最后一次搜索 
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
" 下个匹配
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
" 上个匹配
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
noremap <leader>fa :<C-U><C-R>=printf("Leaderf rg ")<CR>

let g:Lf_WildIgnore = {
        \ 'dir': ['.svn', '.git', '.vscode', '.hg'],
        \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]', '*.dll', '*.lib']
        \ }
