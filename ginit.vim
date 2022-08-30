" 字体
if has('nvim')
	GuiFont! Monaco:h10:cAnsi,Microsoft_YaHei_UI:h10:cGB2312
	set guifontwide=Microsoft_YaHei_UI:h10

	" 关闭丑陋的nvim-qt弹出菜单的样式，改回vim自己的样式"
	GuiPopupmenu 0
else
    set guifont=Monaco:h10:cAnsi,Microsoft_YaHei_UI:h10:cGB2312
	set guifontwide=Microsoft_YaHei_UI:h10
endif

if !has('gui_running')
  nnoremap <C-L> <Esc><C-W><C-L>
  nnoremap <C-H> <Esc><C-W><C-H>
  nnoremap <C-J> <Esc><C-W><C-J>
  nnoremap <C-K> <Esc><C-W><C-K>
else
  nnoremap <A-L> <Esc><C-W><C-L>
  nnoremap <A-H> <Esc><C-W><C-H>
  nnoremap <A-J> <Esc><C-W><C-J>
  nnoremap <A-K> <Esc><C-W><C-K>
endif

" 打开256色?
let g:rehash256=1


