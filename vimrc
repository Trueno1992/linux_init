set nocompatible              " required
filetype on                   " 侦测文件类型
filetype plugin on            " 为特定文件类型载入相关缩进文件

if exists('$TMUX')
  set term=screen-256color
endif

"以下是ctags的设置
set tags=./tags
set tags=./tags,tags;$HOME             "(从当前目录开始一直往上层目录查找tags文件，直到$HOME)
let Tlist_Sort_Type = "name"           " 按照名称排序  
let Tlist_Use_Right_Window = 1         " 在右侧显示窗口  
let Tlist_Compart_Format = 1           " 压缩方式  
let Tlist_Exist_OnlyWindow = 1         " 如果只有一个buffer，kill窗口也kill掉buffer  
let Tlist_File_Fold_Auto_Close = 0     " 不要关闭其他文件的tags  
let Tlist_Enable_Fold_Column = 0       " 不要显示折叠树  
let Tlist_Show_One_File=1              " 不同时显示多个文件的tag，只显示当前文件的
autocmd FileType h,cpp,cc,c set tags+=/usr/include/tags
autocmd FileType h,cpp,cc,c set tags+=/home/admin/.vim/cpp_tags
map  <F5> :!ctags -R --c++-kinds=+px --fields=+iaS --exclude=data/* --exclude=_external/* --exclude=build/* --exclude=logs/* --extra=+q . <CR><CR> :TlistUpdate<CR>        "按下F5重新生成tag文件，并更新taglist
imap <F5> <ESC>:!ctags -R --c++-kinds=+px --fields=+iaS --exclude=data/* --exclude=_external/* --exclude=build/* --exclude=logs/* --extra=+q . <CR><CR> :TlistUpdate<CR>   "按下F5重新生成tag文件，并更新taglist

"以下是taglist的设置
nmap <F12> :Tlist<CR><CR> 00<CR>
let Tlist_Auto_Open=0                  "默认打开Taglist
let Tlist_Ctags_Cmd = '/usr/bin/ctags' "ctag的安装路径
let Tlist_Show_One_File = 1            "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1          "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window = 1         "在右侧窗口中显示taglist窗口

" mru 的配置
nmap ff :MRU<CR>
let MRU_Include_Files = '\.c$\|\.h$\|\.cpp$\|\.hpp$\|.jce$\|.py$\|.log$\|.txt$|.json$'
let MRU_Window_Height = 35     "窗口高度
let MRU_Max_Menu_Entries = 35  "窗口中展示条数
let MRU_Max_Entries = 100
let MRU_Auto_Close = 1

" tabedit 配置
nmap <C-h> <ESC>:tabp<CR>
nmap <C-l> <ESC>:tabn<CR>
nmap <C-n> <ESC>:tabedit 
nmap g0 <ESC>:tabn 0<CR>
nmap g1 <ESC>:tabn 1<CR>
nmap g2 <ESC>:tabn 2<CR>
nmap g3 <ESC>:tabn 3<CR>
nmap g4 <ESC>:tabn 4<CR>
nmap g5 <ESC>:tabn 5<CR>
nmap g6 <ESC>:tabn 6<CR>
nmap g7 <ESC>:tabn 7<CR>
nmap g8 <ESC>:tabn 8<CR>
nmap g9 <ESC>:tabn 9<CR>
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let wn = ''
        let t = tabpagenr()
        let i = 1 
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' . i . 'T' 
            let s .= (i == t ? '%1*' : '%2*')
            let s .= ' ' 
            let wn = tabpagewinnr(i,'$')

            let s .= (i== t ? '%#TabNumSel#' : '%#TabNum#')
            let s .= i
            if tabpagewinnr(i,'$') > 1 
                let s .= '.' 
                let s .= (i== t ? '%#TabWinNumSel#' : '%#TabWinNum#')
                let s .= (tabpagewinnr(i,'$') > 1 ? wn : '') 
            end
            let s .= ' %*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let bufnr = buflist[winnr - 1]
            let file = bufname(bufnr)
            let buftype = getbufvar(bufnr,'buftype')
            if buftype == 'nofile'
                if file =~ '\/.'
                    let file = substitute(file,'.*\/\ze.','','')
                endif
            else
                let file = fnamemodify(file,':p:t')
            endif
            if file == ''
                let file = '[No Name]'
            endif
            let s .= file
            "let s .= (i == t ? '%m' : '')
            let i = i + 1 
        endwhile
        let s .= '%T%#TabLineFill#%='
        return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
endif
set tabpagemax=15
hi TabLineSel term=bold cterm=bold ctermfg=16 ctermbg=229
hi TabWinNumSel term=bold cterm=bold ctermfg=90 ctermbg=229
hi TabNumSel term=bold cterm=bold ctermfg=16 ctermbg=229
hi TabLine term=underline ctermfg=16 ctermbg=145
hi TabWinNum term=bold cterm=bold ctermfg=90 ctermbg=145
hi TabNum term=bold cterm=bold ctermfg=16 ctermbg=145

" 以下是lookupfile
let g:LookupFile_MinPatLength = 2               "最少输入2个字符才开始查找
let g:LookupFile_PreserveLastPattern = 0        "不保存上次查找的字符串
let g:LookupFile_PreservePatternHistory = 1     "保存查找历史
let g:LookupFile_AlwaysAcceptFirst = 1          "回车打开第一个匹配项目
let g:LookupFile_AllowNewFiles = 0              "不允许创建不存在的文件
if filereadable("./filenametags")                "设置tag文件的名字
    let g:LookupFile_TagExpr = '"./filenametags"'
endif
map  <F6> :!sh ~/.vim/sh/genfiletags.sh<CR><CR>

" a.vim
" :A 头文件／源文件切换
" :AS 分割窗后并切换头/源文件(切割为上下两个窗口)
" :AV 垂直切割窗口后切换头/源文件(切割为左右两个窗口)
" :AT 新建Vim标签式窗口后切换
" :AN 在多个匹配文件间循环切换
" 将光标所在处单词作为文件名打开
" :IH 切换至光标所在文件
" :IHS 分割窗口后切换至光标所在文件(指将光标所在处单词作为文件名打开)
" :IHV 垂直分割窗口后切换
" :IHT 新建标签式窗口后切换
" :IHN 在多个匹配文件间循环切换

" 以下是cscope 的配置
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set csverb
    set cspc=3
    "add any database in current dir
    let cscope_file=findfile("cscope.out",".;")
    let cscope_pre=matchstr(cscope_file,".*/")

    if filereadable("cscope.out")
        "cs add cscope.out
    else
        "else search cscope.out elsewhere
        if !empty(cscope_file) && filereadable(cscope_file)
            set nocsverb
            exe "cs add" cscope_file cscope_pre
            set csverb
        endif
    endif
endif

let g:neocomplcache_enable_at_startup = 1
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab
set autoindent
set backspace=indent,eol,start
set numberwidth=1   " 去掉行号前的空格
set history=500     " keep 50 lines of command line history
set ruler           " show the cursor position all the time
set showcmd         " display incomplete commands
set incsearch       " do incremental searching
set number
au FileType cpp,cc,c,h set cindent
au FileType python :set number
au FileType python :set foldmethod=syntax
au FileType python :set smartindent

"set ignorecase


"注释插件nerdcommenter
"\ca 转换注释的方式，比如： /**/和//
"\cm 对被选区域用一对注释符进行注释，前面的注释对每一行都会添加注释
"\cc 注释当前行和选中行
"\cu 取消注释
"\cs "添加性感的注释，代码开头介绍部分通常使用该注释

syntax on
set hlsearch

set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

:set viminfo='1000,<500
"colorscheme darkblue
hi Type ctermfg =Blue
hi MatchParen ctermbg=Blue guibg=lightblue
hi Comment ctermfg =gray
highlight Pmenu ctermbg=darkred
highlight PmenuSel ctermbg=red ctermfg=yellow

nmap ~ :nohlsearch<CR>

"nmap 44  <C-w>l
"nmap 33  <C-w>h
"nmap 11  <C-w>k
"nmap 22  <C-w>j
nmap 00 <C-w><C-w>

"autocmd VimEnter *, exec Init()
"func Init()
"    if &filetype == ''
"        :MRU
"    endif
"endfunc

nmap ge $
nmap ga _
nnoremap -dd "_dd
nnoremap -dw "_dw
nnoremap -d$ "_d$

set wildmenu
set wildmode=longest:full,full

"set t_ti=
"set t_te=

"nmap <left>  25h
"nmap <right> 25l
"nmap <down>  25j
"nmap <up>    25k

highlight ExtraWhitespace ctermbg=red guibg=darkgreen
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$\| \+\ze\t/

au FileType c,cc,cpp,h setlocal dict+=~/.vim/dict/cpp.dict
au FileType c,cc,cpp,h setlocal dict+=~/.vim/dict/cpp2.dict
au FileType cpp,cc,c,h setlocal dict+=~/.vim/dict/cpp_tags.dict
"au FileType cpp,cc,c,h setlocal dict+=./tags
"au FileType cpp,cc,c,h setlocal dict+=../tags
"au FileType cpp,cc,c,h setlocal dict+=../../tags
let now_file  = expand('%:p')
if filereadable(now_file)
endif
