

"Bundle
set nocompatible                " be iMproved
filetype off                    " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

"my Bundle here:
"
" original repos on github
Bundle 'ctrlpvim/ctrlp.vim'
    let g:ctrlp_custom_ignore = {
        \ 'dir':  '\v[\/]\.(git|hg|svn)$',
        \ 'file': '\v\.(exe|so|dll|zip|lnk)$',
        \ 'link': '',
        \ }
    let g:ctrlp_working_path_mode='ra'
    let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:20'
    let g:ctrlp_mruf_max=500
    let g:ctrlp_max_files=500
    let g:ctrlp_follow_symlinks=0

Bundle 'jiangmiao/auto-pairs'
Bundle 'ervandew/supertab'
    let g:SuperTabDefaultCompletionType = "<C-n>"
Bundle 'honza/vim-snippets'
Bundle 'SirVer/ultisnips'
" UltiSnips
    let g:UltiSnipsExpandTrigger="<Tab>"
    let g:UltiSnipsListSnippets="<C-l>"
    let g:UltiSnipsJumpForwardTrigger="<C-j>"
    let g:UltiSnipsJumpBackwardTrigger="<C-k>"
    let g:UltiSnipsSnippetDirectories=['bundle/vim-snippets/UltiSnips']

Bundle 'scrooloose/syntastic'
    let mapleader=","
    map	<leader>n	:lnext<CR>
    map	<leader>p	:lprevious<CR>
    "Recommended settings
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
    let g:syntastic_loc_list_height = 5
    "checker settings
    let g:syntastic_c_compiler_options = ''
    let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libstdc++'
    let g:syntastic_cpp_include_dirs = ['usr/include/']
    let g:syntastic_cpp_remove_include_errors = 1
    let g:syntastic_cpp_check_header = 1
    let g:syntastic_python_checkers = ['pyflakes']
    let g:syntastic_javascript_checkers = ['eslint', 'jsl', 'jshint']
    "let g:syntastic_ignore_file=['.*\.py$']
    "set error or warning signs
    let g:syntastic_error_symbol = '>>'
    let g:syntastic_warning_symbol = '!'
    "whether to show balloons
    let g:syntastic_enable_balloons = 1

Bundle 'Lokaltog/vim-easymotion'
    " Easymotion
    " let g:EasyMotion_leader_key=','
    let g:EasyMotion_smartcase = 1

Bundle 'majutsushi/tagbar'
    nmap <leader>tb :TagbarToggle<CR>  " ,tb 開啟tagbar窗口
    let g:tagbar_autofocus = 1

"..................................
" vim-scripts repos
Bundle 'wolfpython/cscope_map.vim'
    set cscopequickfix=s-,c-,d-,i-,t-,e-
"
"..................................
" non github repos
" Bundle 'git://git.wincent.com/command-t.git'
"......................................



"my vim setting
set nu
syntax enable
syntax on
set background=dark
set t_Co=256
set cursorline
set hlsearch
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set cindent
set ignorecase
set showcmd
set wildmenu
set novisualbell
set encoding=utf-8
set fileencodings=utf-8
set tags=./tags,../tags

let mapleader=","

inoremap jj		<ESC>
inoremap fj		<END>
map      fj		<END>
inoremap ff     <Right>
inoremap jf     <Esc>I
map      jf     I
inoremap {		{<CR><CR>}<ESC>kI
inoremap <C-j>	<Down>
inoremap <C-k>  <Up>
inoremap <C-h>	<Left>
inoremap <C-l>	<Right>
map		 <leader>q	:q<CR>
map		 <leader>a	:shell<CR>
"map      <CR>   i<CR><ESC>

" 全選+複製
" map		<C-A>		ggVGY
" map!	<C-A><ESC>	ggVGY
map		<C-I>		mmG=gg`mzz
inoremap ZZ     <Esc>ZZ

" ,s 一鍵保存
func! SaveFile()
    exec "w"
endfunc
map <leader>s :call SaveFile()<CR>
imap <leader>s <ESC>:call SaveFile()<CR>
vmap <leader>s <ESC>:call SaveFile()<CR>

"Compile and Run
autocmd filetype python nnoremap <F5> :w <bar> exec '!python3 '.shellescape('%')<CR>
autocmd filetype c nnoremap <F5> :w <bar> exec '!gcc '.shellescape('%').' && ./a.out'<CR>
autocmd filetype cpp nnoremap <F5> :w <bar> exec '!g++ '.shellescape('%').' && ./a.out'<CR>

"新建.c,.h,.sh,.java文件，自動插入文件頭 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java,*.py exec ":call SetTitle()" 
""定義函数SetTitle，自動插入文件頭 
func SetTitle() 
    "如果文件類型為.sh文件 
    if &filetype == 'sh' 
        call setline(1,"\#!/bin/bash") 
        call append(line("."), "") 
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python3")
        call append(line("."),"# coding=utf-8")
        call append(line(".")+1, "") 

"    elseif &filetype == 'mkd'
"        call setline(1,"<head><meta charset=\"UTF-8\"></head>")
    else 
        call setline(1, "/*************************************************************************") 
        call append(line("."),   "  > File Name: ".expand("%")) 
        call append(line(".")+1, "  > Description: Ex. in K&R") 
        call append(line(".")+2, "  > Author: Chen, Guan-Yu") 
        call append(line(".")+3, "  > Created Time: ".strftime("%c")) 
        call append(line(".")+4, " ************************************************************************/") 
        call append(line(".")+5, "")
    endif
    if expand("%:e") == 'cpp'
        call append(line(".")+6, "#include<iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include <stdio.h>")
        call append(line(".")+7, "")
    endif
    if expand("%:e") == 'h'
        call append(line(".")+6, "#ifndef _".toupper(expand("%:r"))."_H")
        call append(line(".")+7, "#define _".toupper(expand("%:r"))."_H")
        call append(line(".")+8, "#endif")
    endif
    if &filetype == 'java'
        call append(line(".")+6,"public class ".expand("%:r"))
        call append(line(".")+7,"")
    endif
    "新建文件後，自動定位到文件末尾
endfunc 
autocmd BufNewFile * normal G

colorscheme molokai-phoenix
hi Normal ctermbg=none
