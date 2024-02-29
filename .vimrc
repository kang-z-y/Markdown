" 关闭烦人的当当当声音
set vb t_vb=
" 显示行号
set number
" 高亮显示当前行
set cursorline 
" 高亮显示当前列
set cursorcolumn
" Tab键的宽度
set tabstop=2
" 统一缩进为2
set softtabstop=2
set shiftwidth=2
" 不要用空格代替制表符
set noexpandtab
" 列出当前目录文件  
map <F3> :tabnew .<CR>
" 打开树状文件目录  
map <C-F3> \be
" paste模式
set pastetoggle=<F11>
" 设置当文件被改动时自动载入
set autoread
" 不要使用vi的键盘模式，而是vim自己的
set nocompatible
" 解决无法删除的问题 
set backspace=indent,eol,start
" 自动缩进
set autoindent
" 为特定文件类型载入相关缩进文件
filetype indent on
" 文件类型
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8
" GVIM 字体
set gfn=YaHei_Consolas_Hybrid:h13
" 主题
colorscheme desert

" *************** 自动补全 *****************
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap {<CR> {<CR>}<ESC>O
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
:inoremap < <><ESC>i
function! ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endfunction

" *************** 自动文件信息头 *****************
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()"
func SetTitle()
    if &filetype == 'sh'
        call setline(1,"\#########################################################################")
        call append(line("."), "\# File Name: ".expand("%"))
        call append(line(".")+1, "\# Author: kzy")
        call append(line(".")+2, "\# mail: geqiv1@163.com")
        call append(line(".")+3, "\# Created Time: ".strftime("%c"))
        call append(line(".")+4, "\#########################################################################")
        call append(line(".")+5, "\#!/bin/bash")
        call append(line(".")+6, "")
        call append(line(".")+7, "")
    else
        call setline(1, "/*************************************************************************")
        call append(line("."), "    > File Name: ".expand("%"))
        call append(line(".")+1, "    > Author: kzy")
        call append(line(".")+2, "    > Mail: kzy@163.com ")
        call append(line(".")+3, "    > Created Time: ".strftime("%c"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
    endif
    if &filetype == 'cpp'
        call append(line(".")+6, "#include <iostream>")
        call append(line(".")+7, "")
        call append(line(".")+8, "using namespace std;")
        call append(line(".")+9, "")
        call append(line(".")+10, "int main(int argc, char *argv[])")
        call append(line(".")+11, "{")
        call append(line(".")+12,	"	")
        call append(line(".")+13, "	return 0;")
        call append(line(".")+14, "}")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include <stdio.h>			//printf()")
        call append(line(".")+7, "#include <stdlib.h>			//exit()")
        call append(line(".")+8, "#include <string.h>			//strlen(), bzero();")
        call append(line(".")+9, "")
        call append(line(".")+10, "")
        call append(line(".")+11, "")
        call append(line(".")+12, "int main(int argc, char *argv[])")
        call append(line(".")+13,	"{")
        call append(line(".")+14,	"	")
        call append(line(".")+15,	"	return 0;")
        call append(line(".")+16, "}")
    endif
    autocmd BufNewFile * normal G
    if &filetype == 'c' || &filetype == 'cpp'
        autocmd BufNewFile * normal k
        autocmd BufNewFile * normal k
        autocmd BufNewFile * normal k
    endif
endfunc

" 啊,搞不懂,上面的BufNewFile需要再调用一下才正确
autocmd BufNewFile * exec ":call Test()"
func Test()

endfunc
