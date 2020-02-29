"==============================前置设定===============================
let mapleader = ";" "定义<leader>键
"==============================================================================
"        << 判断操作系统是 Windows 还是 Linux 和判断是终端还是 Gvim >>
"==============================================================================

"------------------------------------------------------------------------------
"  < 判断操作系统是否是 Windows 还是 Linux >
"------------------------------------------------------------------------------
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:iswindows = 0
endif

"------------------------------------------------------------------------------
"  < 判断是终端还是 Gvim >
"------------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

"==============================================================================
"                          << 以下为软件默认配置 >>
"==============================================================================

"------------------------------------------------------------------------------
"  < Windows Gvim 默认配置> 做了一点修改
"------------------------------------------------------------------------------
if (g:iswindows && g:isGUI)
    "source $VIMRUNTIME/vimrc_example.vim
    "source $VIMRUNTIME/mswin.vim
    "behave mswin
    set diffexpr=MyDiff()

    function MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif

"------------------------------------------------------------------------------
"  < Linux Gvim/Vim 默认配置> 做了一点修改
"------------------------------------------------------------------------------
if !g:iswindows
    set incsearch       "在输入要搜索的文字时，实时匹配

    " Uncomment the following to have Vim jump to the last position when
    " reopening a file
    if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif

    if g:isGUI
        " Source a global configuration file if available
        if filereadable("/etc/vim/gvimrc.local")
            source /etc/vim/gvimrc.local
        endif
    else
        " This line should not be removed as it ensures that various options are
        " properly set to work with the Vim-related packages available in Debian.
        runtime! debian.vim

        " Vim5 and later versions support syntax highlighting. Uncommenting the next
        " line enables syntax highlighting by default.
        if has("syntax")
            syntax on
        endif

        set mouse=a                    " 在任何模式下启用鼠标
        set t_Co=256                   " 在终端启用256色
        set backspace=2                " 设置退格键可用

        " Source a global configuration file if available
        if filereadable("/etc/vim/vimrc.local")
            source /etc/vim/vimrc.local
        endif
    endif
endif


"==============================================================================
"                          << 以下为用户自定义配置 >>
"==============================================================================

"------------------------------------------------------------------------------
"  < 编码配置 >
"------------------------------------------------------------------------------
"注：使用utf-8格式后，软件与程序源码、文件路径不能有中文，否则报错
set encoding=utf-8                                    "gvim内部编码
set fileencoding=utf-8                                "当前文件编码
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1     "支持打开文件的编码
" 文件格式，默认 ffs=dos,unix
"set fileformat=unix
set fileformats=dos,unix,mac

if (g:iswindows && g:isGUI)
    "解决菜单乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    "解决consle输出乱码
    language messages zh_CN.utf-8
    colorscheme desert                                "Gvim配色方案
    set guifont=Lucida_Consola:h12:cANSI              "设置字体:字号（字体名称空格用下划线代替）       
    "快速打开vim配置文件：_vimrc
    nnoremap <leader>e :e ~/_vimrc<cr>
else
    colorscheme desert                                "vim配色方案
    set fencs=utf-8,gbk,utf-16,utf-32,ucs-bom
    nnoremap <leader>e :e ~/.vimrc<cr>
endif

"------------------------------------------------------------------------------
"  < 编写文件时的配置 >
"------------------------------------------------------------------------------
set nocompatible                                      "关闭 Vi 兼容模式
filetype on                                           "启用文件类型侦测
filetype plugin on                                    "针对不同的文件类型加载对应的插件
filetype plugin indent on                             "启用缩进
"below 5 setting from link: https://www.cnblogs.com/jcuan/articles/5765528.html 
filetype indent on                                     " 自适应不同语言的智能缩进 
set expandtab                                          " 将制表符扩展为空格 
set tabstop=4                                          "设置编辑时制表符占用空格数
set shiftwidth=4                                       "设置格式化时制表符占用空格数 
set softtabstop=4                                      "让 vim 把连续数量的空格视为一个制表符 

set expandtab                                         "将tab键转换为空格
set tabstop=4                                         "设置tab键的宽度
set softtabstop=4
set shiftwidth=4                                      "换行时自动缩进4个空格
set smarttab                                          "指定按一次backspace就删除4个空格
set foldenable                                        "启用折叠
set foldmethod=indent                                 "indent 折叠方式
"set foldmethod=marker                                "marker 折叠方式
set ignorecase                                        "搜索模式里忽略大小写
set smartcase                                         "如果搜索模式包含大写字符，不使用 'ignorecase' 选项，只有在输入搜索模式并且打开 'ignorecase' 选项时才会使用
"set noincsearch                                      "在输入要搜索的文字时，取消实时匹配
set is                                                "在输入要搜索的文字时，取消实时匹配
set hlsearch                                          "高亮搜索
"set cursorcolumn									  "高亮当前列
set cursorline                                        "突出显示当前行
set autoread                                          "当文件在外部被修改，自动更新该文件
"对齐方式
set smartindent                                       "启用智能对齐方式
set cindent
set autoindent
set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s


"------------------------------------------------------------------------------
"  <快捷键配置>
"------------------------------------------------------------------------------
"自动切换目录为当前编辑文件所在目录
au BufRead,BufNewFile,BufEnter * cd %:p:h
" Ctrl + K 插入模式下光标向上移动
imap <c-k> <Up>
" Ctrl + J 插入模式下光标向下移动
imap <c-j> <Down>
" Ctrl + H 插入模式下光标向左移动
imap <c-h> <Left>
" Ctrl + L 插入模式下光标向右移动
imap <c-l> <Right>

"buffer change
nnoremap <c-n> :bn<cr>
nnoremap <c-p> :bp<cr>
"用空格键来开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
" 按\m 键以后，高亮当前字符，不跳到下一个
nmap \m :let @/=expand('<cword>')<cr>
"常规模式下输入 cs 清除行尾空格
nmap cs :%s/\s\+$//g<cr>:noh<cr>
"因为windows的默认编码是GBK，而Linux的默认编码是UTF-8，这样windows的每条完整json数据的结尾是通过回车换行来实现\r\n,而在Linux操作系统中则是通过在每行结尾通过\n来实现的，这样windows的换行符在Linux下就不会被正确识别，导致每条数据之间无法正确分开而出现了在上面描述的在每条json数据后面出现^M的这样。
"原文链接：https://blog.csdn.net/a532672728/article/details/78976639 
"常规模式下输入 cm 清除行尾 ^M 符号
nmap cm :%s/\r$//g<cr>:noh<cr>
"每行超过80个的字符用下划线标示
"au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)

"------------------------------------------------------------------------------
"  < 界面配置 >
"------------------------------------------------------------------------------
set number                                            "显示行号
set laststatus=2                                      "开启状态栏信息
set cmdheight=2                                       "设置命令行的高度为2，默认为1
set nowrap                                            "设置不自动换行
set shortmess=atI                                     "去掉欢迎界面
"au GUIEnter * simalt ~x                              "窗口启动时自动最大化
"winpos 1000 20                                         "指定窗口出现的位置，坐标原点在屏幕左上角
"set lines=42 columns=190                              "指定窗口大小，lines为高度，columns为宽度



"个性化状栏（这里提供两种方式，要使用其中一种去掉注释即可，不使用反之）
let &statusline=' %t %{&mod?(&ro?"*":"+"):(&ro?"=":" ")} %1*|%* %{&ft==""?"any":&ft} %1*|%* %{&ff} %1*|%* %{(&fenc=="")?&enc:&fenc}%{(&bomb?",BOM":"")} %1*|%* %=%1*|%* 0x%B %1*|%* (%l,%c%V) %1*|%* %L %1*|%* %P'
"set statusline=%t\ %1*%m%*\ %1*%r%*\ %2*%h%*%w%=%l%3*/%L(%p%%)%*,%c%V]\ [%b:0x%B]\ [%{&ft==''?'TEXT':toupper(&ft)},%{toupper(&ff)},%{toupper(&fenc!=''?&fenc:&enc)}%{&bomb?',BOM':''}%{&eol?'':',NOEOL'}]

"显示/隐藏菜单栏、工具栏、滚动条，可用 Ctrl + F11 切换
if g:isGUI
    map <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=r <Bar>
        \set guioptions-=L <Bar>
    \else <Bar>
        \set guioptions+=m <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=r <Bar>
        \set guioptions+=L <Bar>
    \endif<CR>
endif

"------------------------------------------------------------------------------
"  < 缓存配置 >
"------------------------------------------------------------------------------
set writebackup                             "保存文件前建立备份，保存成功后删除该备份
set nobackup                                "设置无备份文件
set noswapfile                              "设置无临时文件
set vb t_vb=                                "关闭提示音
"set paste                                   "避免上面是注释，下一行还是注释,但是这个与set cindent 相互之间有冲突
set undodir=~/.undodir                      "将un~ 文件都放在一个folder，可以方便恢复原来文件


"------------------------------------------------------------------------------
"<多个 Tap设定>
"------------------------------------------------------------------------------
"====================移动Tap====================
let g:miniBufExplMapWindowNavVim = 1        "用<C-k,j,h,l>切换到上下左右的窗口中去
let g:miniBufExplMapCTabSwitchBufs = 1      "功能增强（不过好像只有在Windows中才有用）

function! MoveToPrevTab()
	"there is only one window
	if tabpagenr('$') == 1 &;&; winnr('$') == 1
		return
	endif
	"preparing new window
	let l:tab_nr = tabpagenr('$')
	let l:cur_buf = bufnr('%')
	if tabpagenr() != 1
		close!
		if l:tab_nr == tabpagenr('$')
			tabprev
		endif
		sp
	else
		close!
		exe "0tabnew"
	endif
	"opening current buffer in new window
	exe "b".l:cur_buf
endfunc

function! MoveToNextTab()
	"there is only one window
	if tabpagenr('$') == 1 &;&; winnr('$') == 1
		return
	endif
	"preparing new window
	let l:tab_nr = tabpagenr('$')
	let l:cur_buf = bufnr('%')
	if tabpagenr() < tab_nr
		close!
		if l:tab_nr == tabpagenr('$')
			tabnext
		endif
		sp
	else
		close!
		tabnew
	endif
	"opening current buffer in new window
	exe "b".l:cur_buf
endfunc

nnoremap mt :call MoveToNextTab()<cr>   "mt move to next tab
nnoremap mT :call MoveToPrevTab()<cr>   "mT move to Pre tab
" <C-W>, T  split to a divid tab
"
"------------------------------------------------------------------------------
"  < std_c 语法文件配置 >
"------------------------------------------------------------------------------
"用于增强C语法高亮
"启用 // 注视风格
let c_cpp_comments = 0
" Class Testing Customizations
" ------------------------------------------------------------------------------
" In toplevel files, allow the cursor to go anywhere and format as C code
"autocmd BufReadPre *toplevel.txt set virtualedit=all
au BufRead *toplevel*.txt set filetype=cpp
" Format FAT scripts as c code
" Advantest Tester Language *.asc and *.asc35p Files
au BufRead *.asc* set filetype=atl
au BufRead *.inc set filetype=c
au BufRead *.seq set filetype=c
" Magnum V APG Language *.pat File
au BufNewFile,BufRead *.pat setf pat
au BufRead *define*.h set filetype=pat
" C1D CCS Code
au BufRead *.apg set filetype=cpp



"==============================================================================
"                          << 以下为常用插件配置 >>
"==============================================================================

"------------------------------------------------------------------------------
"  < ctags 插件配置 >
"------------------------------------------------------------------------------
"对浏览代码非常的方便,可以在函数,变量之间跳转等
""set tags=./tags;                            "向上级目录递归查找tags文件（好像只有在Windows下才有用）
set tags=tags;                              " CB 照着网上改的 
set autochdir                               " CB 网上学习加的
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q<CR>
""""""""""REMOVE THE ADVANTEST LANGUAGE CONNECT""""""""""
""map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q<CR> :!burntags.pl <CR>
"map <C-F12> :!burntags.pl <CR>

"------------------------------------------------------------------------------
"  < gvimfullscreen 插件配置 > 请确保以安装了插件
"------------------------------------------------------------------------------
"用于 Windows Gvim 全屏窗口，可用 F11 切换
"全屏后再隐藏菜单栏、工具栏、滚动条效果更好

"------------------------------------------------------------------------------
" Below setting from link: https://github.com/xqin/gvimfullscreen 
"------------------------------------------------------------------------------
if has('gui_running') && has('libcall')
	let g:MyVimLib = $VIMRUNTIME.'/gvimfullscreen.dll'
	function ToggleFullScreen()
		call libcallnr(g:MyVimLib, "ToggleFullScreen", 0)
	endfunction
    
	"Alt+Enter
	"map <A-Enter> <Esc>:call ToggleFullScreen()<CR>

	let g:VimAlpha = 240
	function! SetAlpha(alpha)
		let g:VimAlpha = g:VimAlpha + a:alpha
		if g:VimAlpha < 180
			let g:VimAlpha = 180
		endif
		if g:VimAlpha > 255
			let g:VimAlpha = 255
		endif
		call libcall(g:MyVimLib, 'SetAlpha', g:VimAlpha)
	endfunction
    
	"Shift+Y
	nmap <s-y> <Esc>:call SetAlpha(3)<CR>
	"Shift+T
	nmap <s-t> <Esc>:call SetAlpha(-3)<CR>

	let g:VimTopMost = 0
	function! SwitchVimTopMostMode()
		if g:VimTopMost == 0
			let g:VimTopMost = 1
		else
			let g:VimTopMost = 0
		endif
		call libcall(g:MyVimLib, 'EnableTopMost', g:VimTopMost)
	endfunction
    
	"Shift+R
	nmap <s-r> <Esc>:call SwitchVimTopMostMode()<CR>
endif

if (g:iswindows && g:isGUI)
   "map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
   map <A-CR> :call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
   imap <A-CR> :call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
endif

"------------------------------------------------------------------------------
"  < 其它 >
"------------------------------------------------------------------------------

"
"==============================Comment by CB ==============================
"----------------------------------------
" 生成文件注释格式,还没有研究
"----------------------------------------
" 当新建 .h .c .hpp .cpp .mk .sh等文件时自动调用SetTitle 函数
autocmd BufNewFile *.[ch],*.hpp,*.cpp,Makefile,*.mk,*.sh exec ":call SetTitle()"
" 加入注释
func SetComment()
	call setline(1,"/*================================================================")
	call append(line("."),   "*   Copyright (C) ".strftime("%Y")." INTEL COMPONET Ltd. All rights reserved.")
	call append(line(".")+1, "*   ")
	call append(line(".")+2, "*   FILE			：".expand("%:t"))
	call append(line(".")+3, "*   Author		：Chunbo")
	call append(line(".")+4, "*   Date			：".strftime("%Y.%m.%d."))
	call append(line(".")+5, "*   Description	：")
	call append(line(".")+6, "*")
	call append(line(".")+7, "================================================================*/")
	call append(line(".")+8, "")
	call append(line(".")+9, "")
endfunc
" 加入shell,Makefile注释
func SetComment_sh()
	call setline(3, "#================================================================")
	call setline(4, "#   Copyright (C) ".strftime("%Y")." INTEL COMPONET. All rights reserved.")
	call setline(5, "#   ")
	call setline(6, "#   FILE       ：".expand("%:t"))
	call setline(7, "#   Author     ：Chunbo")
	call setline(8, "#   Date       ：".strftime("%Y年%m月%d日"))
	call setline(9, "#   Description：")
	call setline(10, "#")
	call setline(11, "#================================================================")
	call setline(12, "")
	call setline(13, "")
endfunc
" 定义函数SetTitle，自动插入文件头
func SetTitle()
	if &filetype == 'make'
		call setline(1,"")
		call setline(2,"")
		call SetComment_sh()

	elseif &filetype == 'sh'
		call setline(1,"#!/system/bin/sh")
		call setline(2,"")
		call SetComment_sh()

	else
	     call SetComment()
	     if expand("%:e") == 'hpp'
	        call append(line(".")+10, "#ifndef _".toupper(expand("%:t:r"))."_H")
	        call append(line(".")+11, "#define _".toupper(expand("%:t:r"))."_H")
	        call append(line(".")+12, "#ifdef __cplusplus")
	        call append(line(".")+13, "extern \"C\"")
	        call append(line(".")+14, "{")
	        call append(line(".")+15, "#endif")
	        call append(line(".")+16, "")
	        call append(line(".")+17, "#ifdef __cplusplus")
	        call append(line(".")+18, "}")
	        call append(line(".")+19, "#endif")
	        call append(line(".")+20, "#endif //".toupper(expand("%:t:r"))."_H")
	     elseif expand("%:e") == 'h'
	  	    call append(line(".")+10, "#pragma once")
	     elseif &filetype == 'c'
	  	    call append(line(".")+10,"#include \"".expand("%:t:r").".h\"")
	     elseif &filetype == 'cpp'
	  	    call append(line(".")+10, "#include \"".expand("%:t:r").".h\"")
	  	    call append(line(".")+11, "#include <iostream>")
	  	    call append(line(".")+12, "using namespace std;")
	  	    call append(line(".")+13, "int main()")
	  	    call append(line(".")+14, "{")
	  	    call append(line(".")+15, "    return 0;")
	  	    call append(line(".")+16, "}")
	     endif
	endif
endfunc



"map <F4> :call TitleDet()<cr>'s
function AddTitle()
        call append(0,"/*=============================================================================")
        call append(1,"*")
        call append(2,"* Author: vaptu - vaptu@qq.com")
        call append(3,"*")
        call append(4,"* Last modified: ".strftime("%Y-%m-%d %H:%M"))
        call append(5,"*")
        call append(6,"* Filename: ".expand("%:t"))
        call append(7,"*")
        call append(8,"* Description: ")
        call append(9,"*")
        call append(10,"=============================================================================*/")
        echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
endf
        "更新最近修改时间和文件名
function UpdateTitle()
        normal m'
        execute '/* *Last modified:/s@:.*$@\=strftime(":\t%Y-%m-%d %H:%M")@'
        normal ''
        normal mk
        execute '/* *Filename:/s@:.*$@\=":\t\t".expand("%:t")@'
        execute "noh"
        normal 'k
        echohl WarningMsg | echo "Successful in updating the copy right." | echohl None
endfunction
        "判断前10行代码里面，是否有Last modified这个单词，
        "如果没有的话，代表没有添加过作者信息，需要新添加；
        "如果有的话，那么只需要更新即可
function TitleDet()
        let n=1
        "默认为添加
        while n < 10
            let line = getline(n)
            if line =~ '^\#\s*\S*Last\smodified:\S*.*$'
                call UpdateTitle()
                return
            endif
        let n = n + 1
        endwhile

        call AddTitle()
endfunction

map <F3> :call SetCommentEveryPlace()<cr>'s
func SetCommentEveryPlace()
    call append(line(".")  , '/*================================ comment start ========================================')
    call append(line(".")+1, '*  Author :Chunbo')
	call append(line(".")+2, "*  Date   :".strftime("%Y.%m.%d."))
    call append(line(".")+3, '*  Descrip:')
    call append(line(".")+4, '*================================= comment end   ======================================*/')
endfunction

"------------------------------------------------------------------------------
"大文件打开配置 
"文件中，当文件大于1MB，不启动语法高亮在内的一切附加功能
"原文链接：https://blog.csdn.net/LaineGates/article/details/78504884
"------------------------------------------------------------------------------
" file is large from 1MB
let g:LargeFile = 500  * 1024 * 1024 
augroup LargeFile
autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END
function LargeFile()
    " no syntax highlighting etc
    set eventignore+=FileType
    " save memory when other file is viewed
    setlocal bufhidden=unload
    " is read-only (write with :w new_filename)
    setlocal buftype=nowrite
    " no undo possible
    setlocal undolevels=-1
    " display message
    autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / (1024 * 1024) )  . " MB, suggest to open it with LINUX"
endfunction


"NOT ENABLE YET  "------------------------------------------------------------------------------
"NOT ENABLE YET  "  < 编译、连接、运行配置 >
"NOT ENABLE YET  "------------------------------------------------------------------------------
"NOT ENABLE YET  " F9 一键保存、编译、连接存并运行
"NOT ENABLE YET  map <F9> :call Run()<CR>
"NOT ENABLE YET  imap <F9> <ESC>:call Run()<CR>
"NOT ENABLE YET  
"NOT ENABLE YET  " Ctrl + F9 一键保存并编译
"NOT ENABLE YET  map <c-F9> :call Compile()<CR>
"NOT ENABLE YET  imap <c-F9> <ESC>:call Compile()<CR>
"NOT ENABLE YET  
"NOT ENABLE YET  " Ctrl + F10 一键保存并连接
"NOT ENABLE YET  map <c-F10> :call Link()<CR>
"NOT ENABLE YET  imap <c-F10> <ESC>:call Link()<CR>
"NOT ENABLE YET  
"NOT ENABLE YET  let s:LastShellReturn_C = 0
"NOT ENABLE YET  let s:LastShellReturn_L = 0
"NOT ENABLE YET  let s:ShowWarning = 1
"NOT ENABLE YET  let s:Obj_Extension = '.o'
"NOT ENABLE YET  let s:Exe_Extension = '.exe'
"NOT ENABLE YET  let s:Sou_Error = 0
"NOT ENABLE YET  
"NOT ENABLE YET  let s:windows_CFlags = 'gcc\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
"NOT ENABLE YET  let s:linux_CFlags = 'gcc\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
"NOT ENABLE YET  
"NOT ENABLE YET  let s:windows_CPPFlags = 'g++\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
"NOT ENABLE YET  let s:linux_CPPFlags = 'g++\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
"NOT ENABLE YET  
"NOT ENABLE YET  func! Compile()
"NOT ENABLE YET      exe ":ccl"
"NOT ENABLE YET      exe ":update"
"NOT ENABLE YET      if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
"NOT ENABLE YET          let s:Sou_Error = 0
"NOT ENABLE YET          let s:LastShellReturn_C = 0
"NOT ENABLE YET          let Sou = expand("%:p")
"NOT ENABLE YET          let Obj = expand("%:p:r").s:Obj_Extension
"NOT ENABLE YET          let Obj_Name = expand("%:p:t:r").s:Obj_Extension
"NOT ENABLE YET          let v:statusmsg = ''
"NOT ENABLE YET          if !filereadable(Obj) || (filereadable(Obj) && (getftime(Obj) < getftime(Sou)))
"NOT ENABLE YET              redraw!
"NOT ENABLE YET              if expand("%:e") == "c"
"NOT ENABLE YET                  if g:iswindows
"NOT ENABLE YET                      exe ":setlocal makeprg=".s:windows_CFlags
"NOT ENABLE YET                  else
"NOT ENABLE YET                      exe ":setlocal makeprg=".s:linux_CFlags
"NOT ENABLE YET                  endif
"NOT ENABLE YET                  echohl WarningMsg | echo " compiling..."
"NOT ENABLE YET                  silent make
"NOT ENABLE YET              elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
"NOT ENABLE YET                  if g:iswindows
"NOT ENABLE YET                      exe ":setlocal makeprg=".s:windows_CPPFlags
"NOT ENABLE YET                  else
"NOT ENABLE YET                      exe ":setlocal makeprg=".s:linux_CPPFlags
"NOT ENABLE YET                  endif
"NOT ENABLE YET                  echohl WarningMsg | echo " compiling..."
"NOT ENABLE YET                  silent make
"NOT ENABLE YET              endif
"NOT ENABLE YET              redraw!
"NOT ENABLE YET              if v:shell_error != 0
"NOT ENABLE YET                  let s:LastShellReturn_C = v:shell_error
"NOT ENABLE YET              endif
"NOT ENABLE YET              if g:iswindows
"NOT ENABLE YET                  if s:LastShellReturn_C != 0
"NOT ENABLE YET                      exe ":bo cope"
"NOT ENABLE YET                      echohl WarningMsg | echo " compilation failed"
"NOT ENABLE YET                  else
"NOT ENABLE YET                      if s:ShowWarning
"NOT ENABLE YET                          exe ":bo cw"
"NOT ENABLE YET                      endif
"NOT ENABLE YET                      echohl WarningMsg | echo " compilation successful"
"NOT ENABLE YET                  endif
"NOT ENABLE YET              else
"NOT ENABLE YET                  if empty(v:statusmsg)
"NOT ENABLE YET                      echohl WarningMsg | echo " compilation successful"
"NOT ENABLE YET                  else
"NOT ENABLE YET                      exe ":bo cope"
"NOT ENABLE YET                  endif
"NOT ENABLE YET              endif
"NOT ENABLE YET          else
"NOT ENABLE YET              echohl WarningMsg | echo ""Obj_Name"is up to date"
"NOT ENABLE YET          endif
"NOT ENABLE YET      else
"NOT ENABLE YET          let s:Sou_Error = 1
"NOT ENABLE YET          echohl WarningMsg | echo " please choose the correct source file"
"NOT ENABLE YET      endif
"NOT ENABLE YET      exe ":setlocal makeprg=make"
"NOT ENABLE YET  endfunc
"NOT ENABLE YET  
"NOT ENABLE YET  func! Link()
"NOT ENABLE YET      call Compile()
"NOT ENABLE YET      if s:Sou_Error || s:LastShellReturn_C != 0
"NOT ENABLE YET          return
"NOT ENABLE YET      endif
"NOT ENABLE YET      let s:LastShellReturn_L = 0
"NOT ENABLE YET      let Sou = expand("%:p")
"NOT ENABLE YET      let Obj = expand("%:p:r").s:Obj_Extension
"NOT ENABLE YET      if g:iswindows
"NOT ENABLE YET          let Exe = expand("%:p:r").s:Exe_Extension
"NOT ENABLE YET          let Exe_Name = expand("%:p:t:r").s:Exe_Extension
"NOT ENABLE YET      else
"NOT ENABLE YET          let Exe = expand("%:p:r")
"NOT ENABLE YET          let Exe_Name = expand("%:p:t:r")
"NOT ENABLE YET      endif
"NOT ENABLE YET      let v:statusmsg = ''
"NOT ENABLE YET  	if filereadable(Obj) && (getftime(Obj) >= getftime(Sou))
"NOT ENABLE YET          redraw!
"NOT ENABLE YET          if !executable(Exe) || (executable(Exe) && getftime(Exe) < getftime(Obj))
"NOT ENABLE YET              if expand("%:e") == "c"
"NOT ENABLE YET                  setlocal makeprg=gcc\ -o\ %<\ %<.o
"NOT ENABLE YET                  echohl WarningMsg | echo " linking..."
"NOT ENABLE YET                  silent make
"NOT ENABLE YET              elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
"NOT ENABLE YET                  setlocal makeprg=g++\ -o\ %<\ %<.o
"NOT ENABLE YET                  echohl WarningMsg | echo " linking..."
"NOT ENABLE YET                  silent make
"NOT ENABLE YET              endif
"NOT ENABLE YET              redraw!
"NOT ENABLE YET              if v:shell_error != 0
"NOT ENABLE YET                  let s:LastShellReturn_L = v:shell_error
"NOT ENABLE YET              endif
"NOT ENABLE YET              if g:iswindows
"NOT ENABLE YET                  if s:LastShellReturn_L != 0
"NOT ENABLE YET                      exe ":bo cope"
"NOT ENABLE YET                      echohl WarningMsg | echo " linking failed"
"NOT ENABLE YET                  else
"NOT ENABLE YET                      if s:ShowWarning
"NOT ENABLE YET                          exe ":bo cw"
"NOT ENABLE YET                      endif
"NOT ENABLE YET                      echohl WarningMsg | echo " linking successful"
"NOT ENABLE YET                  endif
"NOT ENABLE YET              else
"NOT ENABLE YET                  if empty(v:statusmsg)
"NOT ENABLE YET                      echohl WarningMsg | echo " linking successful"
"NOT ENABLE YET                  else
"NOT ENABLE YET                      exe ":bo cope"
"NOT ENABLE YET                  endif
"NOT ENABLE YET              endif
"NOT ENABLE YET          else
"NOT ENABLE YET              echohl WarningMsg | echo ""Exe_Name"is up to date"
"NOT ENABLE YET          endif
"NOT ENABLE YET      endif
"NOT ENABLE YET      setlocal makeprg=make
"NOT ENABLE YET  endfunc
"NOT ENABLE YET  
"NOT ENABLE YET  func! Run()
"NOT ENABLE YET      let s:ShowWarning = 0
"NOT ENABLE YET      call Link()
"NOT ENABLE YET      let s:ShowWarning = 1
"NOT ENABLE YET      if s:Sou_Error || s:LastShellReturn_C != 0 || s:LastShellReturn_L != 0
"NOT ENABLE YET          return
"NOT ENABLE YET      endif
"NOT ENABLE YET      let Sou = expand("%:p")
"NOT ENABLE YET      let Obj = expand("%:p:r").s:Obj_Extension
"NOT ENABLE YET      if g:iswindows
"NOT ENABLE YET          let Exe = expand("%:p:r").s:Exe_Extension
"NOT ENABLE YET      else
"NOT ENABLE YET          let Exe = expand("%:p:r")
"NOT ENABLE YET      endif
"NOT ENABLE YET      if executable(Exe) && getftime(Exe) >= getftime(Obj) && getftime(Obj) >= getftime(Sou)
"NOT ENABLE YET          redraw!
"NOT ENABLE YET          echohl WarningMsg | echo " running..."
"NOT ENABLE YET          if g:iswindows
"NOT ENABLE YET              exe ":!%<.exe"
"NOT ENABLE YET          else
"NOT ENABLE YET              if g:isGUI
"NOT ENABLE YET                  exe ":!gnome-terminal -e ./%<"
"NOT ENABLE YET              else
"NOT ENABLE YET                  exe ":!./%<"
"NOT ENABLE YET              endif
"NOT ENABLE YET          endif
"NOT ENABLE YET          redraw!
"NOT ENABLE YET          echohl WarningMsg | echo " running finish"
"NOT ENABLE YET      endif
"NOT ENABLE YET  endfunc
"NOT ENABLE YET  

"==============================插件安装===============================
call plug#begin('~/.vim/plugged')
"""""""""""""""""""""""""vim-bookmark"""""""""""""""""""""""""
"https://blog.csdn.net/MDL13412/article/details/44081509 
Plug 'MattesGroeger/vim-bookmarks'
nmap <Leader><Leader> <Plug>BookmarkToggle
nmap <Leader>i <Plug>BookmarkAnnotate
nmap <Leader>a <Plug>BookmarkShowAll
nmap <Leader>j <Plug>BookmarkNext
nmap <Leader>k <Plug>BookmarkPrev
nmap <Leader>c <Plug>BookmarkClear
nmap <Leader>x <Plug>BookmarkClearAll
nmap <Leader>kk <Plug>BookmarkMoveUp
nmap <Leader>jj <Plug>BookmarkMoveDown
nmap <Leader>g <Plug>BookmarkMoveToLine


let g:bookmark_sign = '♥'
let g:bookmark_annotation_sign = '>>'
let g:bookmark_auto_close = 0     "打开书签后是否关闭quickfix
"""add the color for the bookmark //尝试很多，windows gvim 版本下并不work
let g:bookmark_highlight_lines = 1
let g:bookmark_no_default_key_mappings = 1
let g:bookmark_center = 1
"!!!!!!!!!!!Below information MUST!! put in the colorscheme files!!!!!
"!!!!!!!!!!!Below just for references
highlight BookmarkLine ctermbg=DarkGray ctermfg=none guibg=darkgreen  guifg=palegreen  

""""""""""""""""""nerdtree""""""""""""""""""""""""""""""""
""文件管理器
Plug 'scrooloose/nerdtree'
"autocmd vimenter * NERDTree  "自动开启Nerdtree
let g:NERDTreeWinSize = 35 "设定 NERDTree 视窗大小
"开启/关闭nerdtree快捷键
map <F2> :NERDTreeToggle<CR>
nmap <F2> :NERDTree<CR>
let NERDTreeShowBookmarks=1  " 开启Nerdtree自动显示Bookmarks
"打开vim时如果没有文件自动打开NERDTree
autocmd vimenter * if !argc()|NERDTree|endif
"当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"设置树的显示图标
let g:NERDTreeDirArrowExpandable = '>'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeIgnore=['\.pyc','\~$','\.swp']   " 过滤所有.pyc文件不显示
let g:NERDTreeShowLineNumbers=1  " 是否显示行号
let g:NERDTreeHidden=1     "不显示隐藏文件
"Making it prettier
" let NERDTreeMinimalUI = 1  ""remove the up a dir
let NERDTreeDirArrows = 1
let g:NERDTreeWinPos="left"
let g:NERDTreeChDirMode = 2  "Change current folder as root
"""""""""""""""""""""""nerdtree-git-plugin"""""""""""""""""""""""""
" add the file status base on git
Plug 'Xuyuanp/nerdtree-git-plugin'
let g:NERDTreeIndicatorMapCustom = {
			\ "Modified"  : "✹",
			\ "Staged"    : "✚",
			\ "Untracked" : "✭",
			\ "Renamed"   : "➜",
			\ "Unmerged"  : "═",
			\ "Deleted"   : "✖",
			\ "Dirty"     : "✗",
			\ "Clean"     : "✔︎",
			\ "Unknown"   : "?"
			\ }
"""""""""""""""""""""LIMELIGHT"""""""""""""""""""""""""""""
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'Gray'
let g:limelight_conceal_ctermfg = 240
" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'
" 包含的前后段的数量
let g:limelight_paragraph_span = 1
" Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1
" Goyo配置
let g:goyo_width =100
let g:goyo_height =100
let g:goyo_linenr = 0
" 进入goyo模式后自动触发limelight，退出则关闭
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
" limelight键盘映射
nmap <silent> <leader>g      :Goyo<CR>
xmap <silent> <leader>g      :Goyo<CR>

"""""""""""""""""""""""""tagbar"""""""""""""""""""""""""
Plug 'majutsushi/tagbar'

let g:tagbar_ctags_bin = 'ctags' " tagbar 依赖 ctags 插件
let g:tagbar_width     = 30      " 设置 tagbar 的宽度为 30 列，默认 40 列
let g:tagbar_autofocus = 1       " 打开 tagbar 时光标在 tagbar 页面内，默认在 vim 打开的文件内
let g:tagbar_left      = 1       " 让 tagbar 在页面左侧显示，默认右边
"let g:tagbar_sort      = 0       " 标签不排序，默认排序

" <leader>tb 打开 tagbar 窗口，在左侧栏显示
map <leader>tb :TagbarToggle<CR>

"""""""""""""""""""""""""taglist"""""""""""""""""""""""""
Plug 'vim-scripts/taglist.vim'

let Tlist_Show_One_File           = 1    " 只显示当前文件的tags
let Tlist_GainFocus_On_ToggleOpen = 1    " 打开 Tlist 窗口时，光标跳到 Tlist 窗口
let Tlist_Exit_OnlyWindow         = 1    " 如果 Tlist 窗口是最后一个窗口则退出 Vim
let Tlist_Use_Left_Window         = 1    " 在左侧窗口中显示
let Tlist_File_Fold_Auto_Close    = 1    " 自动折叠
let Tlist_Auto_Update             = 1    " 自动更新

" <leader>tl 打开 Tlist 窗口，在左侧栏显示
map <leader>tl :TlistToggle<CR>

""""""""""""""""""""""""indentline""""""""""""""""""""""""""
"自动连接对齐线,连接点需要额外安装东西FontForge
Plug 'Yggdroot/indentLine'
"ENABLE or disable is with command "IndentLinesEnable"
" Vim
"let g:indentLine_color_term = 239
" GVim
"let g:indentLine_color_gui = '#A4E57E'
" none X terminal
"let g:indentLine_color_tty_light = 7 " (default: 4)
"let g:indentLine_color_dark = 1 " (default: 2)
" Background (Vim, GVim)
"let g:indentLine_bgcolor_term = 202
"let g:indentLine_bgcolor_gui = '#FF5F00'
"let g:indentLine_char_list = ['|', '¦', '┆', '┊'] 
let g:indentLine_char_list = ['|', '¦'] 
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2
" let g:indentLine_setConceal = 0
"
"""""""""""""""""""""""""用python定义的pep8标准格式化文件””””””””””””””””””””””””
"  Plug 'tell-k/vim-autopep8'
"  autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
""  对齐
"  Plug 'junegunn/vim-easy-align'
"  " Start interactive EasyAlign in visual mode (e.g. vipga)
"  xmap ga <Plug>(EasyAlign)
"  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
"  nmap ga <Plug>(EasyAlign)

""""""""""""""""""""""""""""""""""""""""""""""""""
""自动括号?()[]{}
" 自动补全引号(单引号/双引号/反引号), 括号(()[]{})
Plug 'tpope/vim-surround'
""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'neoclide/coc.nvim', {'branch': 'release'}"
" "Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'} 
" 
"  TextEdit might fail if hidden is not set.
"  set hidden
"  " Some servers have issues with backup files, see #649.
"  set nobackup
"  set nowritebackup
"  " Give more space for displaying messages.
"  set cmdheight=2
"  " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
"  " delays and poor user experience.
"  set updatetime=300
"  " Don't pass messages to |ins-completion-menu|.
"  set shortmess+=c
"  " Always show the signcolumn, otherwise it would shift the text each time
"  " diagnostics appear/become resolved.
"  set signcolumn=yes
"  " Use tab for trigger completion with characters ahead and navigate.
"  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
"  " other plugin before putting this into your config.
"  inoremap <silent><expr> <TAB>
"        \ pumvisible() ? "\<C-n>" :
"        \ <SID>check_back_space() ? "\<TAB>" :
"        \ coc#refresh()
"  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"  
"  function! s:check_back_space() abort
"    let col = col('.') - 1
"    return !col || getline('.')[col - 1]  =~# '\s'
"  endfunction
"  
"  " Use <c-space> to trigger completion.
"  inoremap <silent><expr> <c-space> coc#refresh()
"  
"  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
"  " position. Coc only does snippet and additional edit on confirm.
"  if has('patch8.1.1068')
"    " Use `complete_info` if your (Neo)Vim version supports it.
"    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
"  else
"    imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"  endif
"  
"  " Use `[g` and `]g` to navigate diagnostics
"  nmap <silent> [g <Plug>(coc-diagnostic-prev)
"  nmap <silent> ]g <Plug>(coc-diagnostic-next)
"  
"  " GoTo code navigation.
"  nmap <silent> gd <Plug>(coc-definition)
"  nmap <silent> gy <Plug>(coc-type-definition)
"  nmap <silent> gi <Plug>(coc-implementation)
"  nmap <silent> gr <Plug>(coc-references)
"  
"  " Use K to show documentation in preview window.
"  nnoremap <silent> K :call <SID>show_documentation()<CR>
"  
"  function! s:show_documentation()
"    if (index(['vim','help'], &filetype) >= 0)
"      execute 'h '.expand('<cword>')
"    else
"      call CocAction('doHover')
"    endif
"  endfunction
"  
"  " Highlight the symbol and its references when holding the cursor.
"  autocmd CursorHold * silent call CocActionAsync('highlight')
"  
"  " Symbol renaming.
"  nmap <leader>rn <Plug>(coc-rename)
"  
"  " Formatting selected code.
"  xmap <leader>f  <Plug>(coc-format-selected)
"  nmap <leader>f  <Plug>(coc-format-selected)
"  
"  augroup mygroup
"    autocmd!
"    " Setup formatexpr specified filetype(s).
"    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"    " Update signature help on jump placeholder.
"    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"  augroup end
"  
"  " Applying codeAction to the selected region.
"  " Example: `<leader>aap` for current paragraph
"  xmap <leader>a  <Plug>(coc-codeaction-selected)
"  nmap <leader>a  <Plug>(coc-codeaction-selected)
"  
"  " Remap keys for applying codeAction to the current line.
"  nmap <leader>ac  <Plug>(coc-codeaction)
"  " Apply AutoFix to problem on the current line.
"  nmap <leader>qf  <Plug>(coc-fix-current)
"  
"  " Introduce function text object
"  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
"  xmap if <Plug>(coc-funcobj-i)
"  xmap af <Plug>(coc-funcobj-a)
"  omap if <Plug>(coc-funcobj-i)
"  omap af <Plug>(coc-funcobj-a)
"  
"  " Use <TAB> for selections ranges.
"  " NOTE: Requires 'textDocument/selectionRange' support from the language server.
"  " coc-tsserver, coc-python are the examples of servers that support it.
"  nmap <silent> <TAB> <Plug>(coc-range-select)
"  xmap <silent> <TAB> <Plug>(coc-range-select)
"  
"  " Add `:Format` command to format current buffer.
"  command! -nargs=0 Format :call CocAction('format')
"  
"  " Add `:Fold` command to fold current buffer.
"  command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"  
"  " Add `:OR` command for organize imports of the current buffer.
"  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
"  
"  " Add (Neo)Vim's native statusline support.
"  " NOTE: Please see `:h coc-status` for integrations with external plugins that
"  " provide custom statusline: lightline.vim, vim-airline.
"  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"  
"  " Mappings using CoCList:
"  " Show all diagnostics.
"  nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
"  " Manage extensions.
"  nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
"  " Show commands.
"  nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
"  " Find symbol of current document.
"  nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
"  " Search workspace symbols.
"  nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
"  " Do default action for next item.
"  nnoremap <silent> <space>j  :<C-u>CocNext<CR>
"  " Do default action for previous item.
"  nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
"  " Resume latest coc list.
"  nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
""""""""""""""""""""""""
" Plug 'tacahiroy/ctrlp-funky'
" nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
" nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
""""""""""""""""""""""""""""""""""""""""""""""""""
if (!g:isGUI)
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    
    " Vim 在与屏幕/键盘交互时使用的编码(取决于实际的终端的设定)        
    set encoding=utf-8
    set langmenu=zh_CN.UTF-8
    " 设置打开文件的编码格式  
    set fileencodings=ucs-bom,utf-8,gbk,cp936,gb18030,big5,euc-jp,euc-kr,latin1 
    set fileencoding=utf-8
    " 解决菜单乱码
    " source $VIMRUNTIME/delmenu.vim
    " source $VIMRUNTIME/menu.vim
    " 解决consle输出乱码
    " set termencoding = cp936  
    " 设置中文提示
    language messages zh_CN.utf-8 
    " 设置中文帮助
    set helplang=cn
    " 设置为双字宽显示，否则无法完整显示如:☆
    set ambiwidth=double
    " 总是显示状态栏 
    "set laststatus=2  "永远显示状态栏
    " let g:airline_powerline_fonts = 1   " 使用powerline打过补丁的字体
    let g:airline_theme="dark"      " 设置主题
    " 开启tabline
    let g:airline#extensions#tabline#enabled = 1      "tabline中当前buffer两端的分隔字符
    let g:airline#extensions#tabline#left_sep = ' '   "tabline中未激活buffer两端的分隔字符
    let g:airline#extensions#tabline#left_alt_sep = '|'      "tabline中buffer显示编号
    let g:airline#extensions#tabline#buffer_nr_show = 1      
    " 映射切换buffer的键位
    nnoremap [b :bp<CR>
    nnoremap ]b :bn<CR>
    " 设置字体 
    set guifont=Powerline_Consolas:h14:cANSI

    "Plug 'tpope/vim-fugitive'
endif    




call plug#end()
