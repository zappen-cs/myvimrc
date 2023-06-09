let mapleader = ";"
" 设置行号
set nu
" 关闭兼容模式，不兼容vi
set nocompatible              " 这是必需的
filetype off                  " 这是必需的

" 在此设置运行时路径
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.fzf

" vundle初始化
call vundle#begin()

" 让 Vundle 管理 Vundle, 这是必须的
Plugin 'VundleVim/Vundle.vim'

" 自动补全插件
Plugin 'Valloric/YouCompleteMe'
" tagbar
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
"Plugin 'w0rp/ale'
Plugin 'vim-airline/vim-airline'
"Plugin 'ludovicchabant/vim-gutentags'
Plugin 'luochen1990/rainbow'

" leaderf
Plugin 'Yggdroot/LeaderF'

" fzf
Plugin 'junegunn/fzf.vim'
" 安装apt-get install silversearcher-ag

"每个插件都应该在这一行之前
call vundle#end()            " 这是必需的
filetype plugin indent on    " 这是必需的


" -------------------------------------------------------- YouCompleteMe ------------------------------------------------------------------
" 声明默认配置文件
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py' 

let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']  
let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']

" 从第2个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=2                 

" 在注释输入中也能补全
let g:ycm_complete_in_comments = 1                          

" 在字符串输入中也能补全
let g:ycm_complete_in_strings = 1                           

" 注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 1 

" 禁用语法检查
let g:ycm_show_diagnostics_ui = 0                           

" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>" |            " 回车即选中当前项

" 跳转到定义处
nnoremap <c-j> :YcmCompleter GoToDefinitionElseDeclaration<CR>|     
" ---------------------------------------------------------- end --------------------------------------------------------------------------

"---------------------------------------------------------- Tagbar ------------------------------------------------------------------------
let g:tagbar_width=20
" 打开xx文件时自动打开tagbar
" autocmd BufReadPost *.cpp,*.c,*.h,*.cc,*.cxx call tagbar#autoopen()
nmap <Leader>t :TagbarToggle<CR>

" NetRedTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
nmap <leader>n :NERDTreeToggle<CR>
let NERDTreeWinSize=20
" 窗口是否显示行号
let NERDTreeShowLineNumbers=0
let NERDTreeAutoCenter=1
let NERDTreeShowBookmarks=1

" ale
" 自定义error和warning
"let g:ale_sign_error = 'x'
"let g:ale_sign_warning = 'w'
"let g:ale_set_highlights = 0
""let g:ale_sign_column_always = 1
"let g:ale_statusline_format = ['   %d', '   %d', '   OK']
"let g:ale_echo_msg_format = '[%linter%] %code: %%s'

" airline
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1      "tabline中当前buffer两端的分隔字符
"----------airline------------
""let g:airline#extensions#tabline#left_sep = ''
""let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#buffer_nr_show = 1        "显示buffer编号
let g:airline#extensions#tabline#buffer_nr_format = '%s:'
let g:airline#extensions#battery#enabled = 1
""let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''


"let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
"let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
"let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
"let g:gutentags_ctags_extra_args += ['--c-kinds=+px']



" ---------------------------- LeaderF ---------------------------
let g:Lf_WindowPosition = 'popup'                          "使能浮动窗口，需要Vim 8.1.1615以上版本。
let g:Lf_PreviewInPopup = 1                                "使能按ctrl p键在弹出窗口中预览结果。

" 文件搜索
nnoremap <silent> <leader>ff :Leaderf file<CR>				
"函数搜索（仅当前文件里）。
nnoremap <silent> <leader>fh :Leaderf function<CR>
" 模糊搜索，很强大的功能，迅速秒搜
nnoremap <silent> <Leader>fg :Leaderf rg<CR>


" 设置自动补全括号
inoremap ' ''<ESC>i
inoremap " ""<ESC>i
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
" inoremap < <><ESC>i
inoremap { {<CR>}<ESC>O
inoremap } {}<ESC>i
 "设置跳出自动补全的括号
 func SkipPair()
 	 if getline('.')[col('.') - 1] == '>' || getline('.')[col('.') - 1] == ')' || getline('.')[col('.') - 1] == ']' || getline('.')[col('.') - 1] == '"' || getline('.')[col('.') - 1] == "'" || getline('.')[col('.') - 1] == '}'
  	       return "\<ESC>la"
         else
               return "\t"
         endif
endfunc
" 将tab键绑定为跳出括号
inoremap <TAB> <c-r>=SkipPair()<CR>
""au BufWinLeave * silent mkview
""au BufWinEnter * silent loadview

" 将esc键映射为jj键
inoremap jj <ESC>
inoremap <c-/> /*  */<ESC>i<ESC>i<ESC>i
inoremap <c-'> "<ESC>a
inoremap <c-8> /*<ESC>o<ESC>o/<ESC>ka<space>
" 自动生成开头注释
autocmd BufNewFile *.sh,*py,*c exec ":.call SetTitle()"
func SetTitle()
	if expand("%:e") == 'sh'
		call setline(1,"#!/bin/bash")
		call setline(2,"#***********************************************")
		call setline(3,"#Author:       zappen")
		call setline(4,"#Mail:         zp935675863@gmail.com")
		call setline(5,"#Date:         ".strftime("%Y-%m-%d"))
		call setline(6,"#FileName:     ".expand("%"))
		call setline(7,"#***********************************************")
		call setline(8,"")
		call setline(9,"")
	endif
	if expand("%:e") == 'py'
		call setline(1,"'''")
		call setline(2,"-*- coding: utf-8 -*-")
		call setline(3,"@Author:   zappen")
		call setline(4,"@Mail:     zp935675863@gmail.com")
		call setline(5,"@Date:     ".strftime("%Y-%m-%d"))
		call setline(6,"@FileName: ".expand("%"))
		call setline(7,"'''")
		call setline(8,"")
		call setline(9,"")
	endif
	if expand("%:e") == 'c'
		call setline(1,"/*")
		call setline(2," ***********************************************")
		call setline(3,"")
		call setline(4,"@Author:   zappen")
		call setline(5,"@Mail:     zp935675863@gmail.com")
		call setline(6,"@Date:     ".strftime("%Y-%m-%d"))
		call setline(7,"@FileName: ".expand("%"))
		call setline(8," ***********************************************")
		call setline(9,"*/")
		call setline(10,"")
		call setline(11,"")
	endif
endfunc
autocmd BufNewFile * normal G

autocmd BufNewFile *.html exec ":.call SetHtmlTemplates()"
func SetHtmlTemplates()
	call setline(1, "<!DOCTYPE html>")
	call setline(2, "<html lang=\"en\">")
	call setline(3, "<head>")
	call setline(4, "        <meta charset=\"UTF-8\">")
	call setline(5, "        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">")
	call setline(6, "        <meta=\"viewport\" content=\"width=device-width, initial-scale=1.0\">")
	call setline(7, "        <title>Title</title>")
	call setline(8, "</head>")
	call setline(9, "<body>")
	call setline(10, "")
	call setline(11, "")
	call setline(12,"</body>")
	call setline(13,"</html>")
endfunc


"自动加载cscope
if has("cscope")
	set csprg=/usr/bin/cscope
	set csto=1
	set cst
	set nocsverb
	"add any database in current directory
	if filereadable("cscope.out")
		cs add cscope.out
	endif
	set csverb
endif

" 是否使用quickfix窗口来显示cscope结果
set cscopequickfix=s-,g-,c-,d-,i-,t-,e-
nnoremap <Leader>cw	:cw<CR>

" 查找c语言符号(symbol),即查找函数名、宏、枚举值等出现的地方
" find this C symbol
nmap <C-k>s :cs find s <C-R>=expand("<cword>")<CR><CR>

" 查找函数名、宏、枚举值等被定义的地方
" find this global definition
nmap <C-k>g :cs find g <C-R>=expand("<cword>")<CR><CR>

" 查找本函数调用的函数
" find functions called by this function
nmap <C-k>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" 查找调用本函数的函数
" find functions calling this function
nmap <C-k>c :cs find c <C-R>=expand("<cword>")<CR><CR>

" 查找指定的字符串
" find this text string	
nmap <C-k>t :cs find t <C-R>=expand("<cword>")<CR><CR>

" find this egrep pattern
nmap <C-k>e :cs find e <C-R>=expand("<cword>")<CR><CR>

" 查找并打开文件，类似于vim的find功能
" find this file 
nmap <C-k>f :cs find f <C-R>=expand("<cword>")<CR><CR>

" 查找包含本文件的文件
" find files #including this file
nmap <C-k>i :cs find i ^<C-R>=expand("<cword>")<CR>$<CR>



" 重新打开文件时回到上次停留的位置
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


func DeleteBoth()
	if (getline('.')[col('.') - 2] == '(' && getline('.')[col('.') - 1] == ')')||(getline('.')[col('.') - 2] == '[' && getline('.')[col('.') - 1] == ']') || (getline('.')[col('.') - 2] == '"' && getline('.')[col('.') - 1] == '"') ||(getline('.')[col('.') - 2] == "'" && getline('.')[col('.') - 1] == "'") || (getline('.')[col('.') - 2] == '{' && getline('.')[col('.') - 1] == '}')||(getline('.')[col('.') - 2] == '<' && getline('.')[col('.') - 1] == '>')
		return "\<ESC>2s"
	else
		return "\<BS>"
	endif
endfunc
inoremap <BS> <c-r>=DeleteBoth()<CR>

autocmd CursorMoved,CursorMovedI * call CentreCursor()
function! CentreCursor()
    let pos = getpos(".")
    normal! zz
    call setpos(".", pos)
endfunction

" 设置tab长度，并自动缩进
set tabstop=4
set shiftwidth=4
set autoindent

" 中文乱码
set termencoding=utf-8
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,gbk,cp936,gb2312,gb18030

" 不产生.swp
set noswapfile

set ignorecase "设置默认大小写不敏感查找

" 行首与行末
nmap <Leader>bb 0
nmap <Leader>e $

" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" 搜索时大小写不敏感
set ignorecase


" 定义快捷键 关闭当前分割窗口
nmap <Leader>q :q<CR>
" 定义快捷键
nmap <Leader>w :w<CR>

" 打开文件
"nmap <Leader>e :e<Space>
" 不关闭文件推出
nmap <Leader>z <C-Z>
" 水平分隔
nmap <Leader>s :Sex<CR>
" 竖直分隔
nmap <Leader>v :Vex<CR>

" 向左
nnoremap <Leader>h <C-W><C-H>
" 向右
nnoremap <Leader>l <C-W><C-L>
" 向上
nnoremap <Leader>k <C-W><C-K>
" 向下
nnoremap <Leader>j <C-W><C-J>

" 设置快捷键gs遍历各分割窗口。快捷键速记法：goto the next spilt window
nnoremap <Leader>bp :bp<CR>
nnoremap <Leader>bn :bn<CR>
" 删除缓冲区
nnoremap <Leader>bd	:bd<CR>

set hls

