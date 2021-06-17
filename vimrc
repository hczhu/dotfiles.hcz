"----- Tips ------
":%s/\<\([A-Z]\)\>/tag_\1/g                Regular expression back reference
"a3yy                                      Copy the following 3 lines to buffer a
"ap                                        Paste the buffer a.
"\r                                        new line
":10go                                     jump to the position of byte offset 10
":%s/^\([^a-z]\+\)\([a-z]\+\)/\1\U\2       Replace the first lower word to upper 
"%g/^zhuhcheng/s/$/zhucheng                Append 'zhucheng' to the line starting with 'zhucheng'
"%s/^/\=repeat(' ', 10)                    Insert 10 whitespaces in the front of every line.
" #                                        search for the previous instance of the word under the cursor
"-----------------
"let $BASH_ENV="~/.bashrc"
syntax on
set smartindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set number
set encoding=utf-8

set showmatch
set hlsearch
hi Search ctermbg=LightYellow ctermfg=Black
set tags=./tags;/

filetype plugin on
syntax on
set foldmethod=indent
"au FileType js,php,cc,lex,cpp,h,proto,borg,y set foldmethod=indent
"au FileType python,py,js,php,cc,lex,cpp highlight Folded guibg=blue guifg=green
"set foldlevelstart=30
set scrolloff=100
"Use clipboard as default copy
set clipboard=unnamedplus

map I{ iaa<Esc>hr{lr}a
au FileType go,bash,html,js,php,cc,lex,cpp,c,java,python,bash imap "" ""<Esc>ha
au FileType go,bash,html,js,php,cc,lex,cpp,c,java,python,bash imap () ()<Esc>ha
au FileType go,bash,html,js,php,cc,lex,cpp,c,java,python,bash imap [] []<Esc>ha
au FileType go,bash,html,js,php,cc,lex,cpp,c,java,python,bash imap <> <><Esc>ha
au FileType go,bash,html,js,php,cc,lex,cpp,c,java,python,bash imap '' ''<Esc>ha
au FileType go,js,cc,lex,cpp,c,java imap { {<CR>}<Esc>O
au FileType bash imap {} {}<Esc>ha
"au FileType js,php,cpp,c,java,python,bash map <C-r> :!gedit %<CR>
map <F6> <Esc>elDyyp0dwi<BS> = vars.<Esc>j
au FileType js,php,cpp,python,bash map <F3> <Esc>0dwi<BS><Esc>
"au FileType js,php,cpp,python,bash map <F4> 0dwi<BS><CR><Esc>

au FileType js,php,cpp map <C-y> :w<CR>:!g++ % -O3 $GCC_FLAGS ${GTEST_LIBS} -o %:r && ./%:r
au FileType js,php,cpp map <C-u> :w<CR>:!g++ % -ggdb3 -DDEBUG $GCC_FLAGS ${GTEST_LIBS} -o %:r && ./%:r

au FileType js,php,cpp,c,python,bash map <F5> :!./%:r
au FileType js,php,python,bash map <F5> :!./%
"
"au FileType js,php,cpp map <C-u> :w<CR>:!g++ -o %:r -O2 -DNDEBUG -lprofiler -lpthread %;echo "No debug\!\!\!"
"au FileType js,php,cpp map <C-u> :w<CR>:!g++ -o %:r -O2 -DNDEBUG %;echo "No debug\!\!\!"<CR>
"au FileType js,php,c map <C-u> :w<CR>:!gcc -o %:r -O2 -DNDEBUG -lpthread %;echo "No debug\!\!\!"


"au FileType js,php,java map <C-u> :w<CR>:!javac %<CR>
au FileType js,php,java map <F6> :!java -enableassertions -Xmx1024M %:r
" check spell
"
au FileType tex map <C-b> :w<CR>:!pdflatex %<CR>
"au FileType js,php,tex map <C-r> :w<CR>:!acroread %:r.pdf<CR>
"au FileType js,php,tex imap {} {}<Esc>ha
"au FileType js,php,tex imap [] []<Esc>ha
"au FileType js,php,tex imap () ()<Esc>ha
"au FileType js,php,tex imap $$ $$<Esc>ha
"au FileType js,php,tex set spell
" autocmd BufNewFile,BufRead *.html,*htm set spell
command Sb vert sb
command Cs !echo '<cword>' | aspell -a
command Rg !rg -B3 -A3 <cword> %:h/
command Ls !ls -l <cfile>
command Number %s/\([0-9]\)[0-9]\{3\}\([^0-9]\|$\)/\1K\2/g | %s/\([0-9]\)[0-9]\{3\}K/\1M/g | %s/\([0-9]\)[0-9]\{3\}M/\1G/g | %s/\([0-9]\)[0-9]\{3\}G/\1T/g | %s/\([0-9]\)[0-9]\{3\}T/\1P/g


command Fl !grep "^DEFINE_[a-zA-Z0-9]\+($(echo <cword> | sed 's/FLAGS_//')" % -A 3
" Create a variable name for type: AaaBbbCaa ===> aaa_bbb_ccc
map Va wbveyea <CR><Esc>O<Esc>p:.s/\([a-z]\)\([A-Z]\)/\1_\2/g<CR>VuA <Esc>JkJ
map Vc wbve:s/_\([a-z]\)/\u\1/g<CR>
map Fl wbiFLAGS_<Esc>
"map <C-s> :!look <cword>
"command Backup !suffix=`date | tr ' ' '-'`; echo $suffix; cp % .%-$suffix 

"" When editing a file, always jump to the last known cursor position.
"" Don't do it when the position is invalid or when inside an event handler
"" (happens when dropping a file on gvim).
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm'\"")|else | exe "norm $" | endif | endif 

map <F1> <C-l>

"hilight too long line
au FileType cc,h set colorcolumn=81,82,83,84
" So what, I can't type...
nmap :W :w
nmap :X :x
nmap :Q :q

" Don't use Ex mode, use Q for formatting
map Q gq

"set spell
set nospell

"set path
"set path+=../
"set path+=./
"Only search current directory.
"let g:ctrlp_working_path_mode = 'c'
let g:ctrlp_working_path_mode = ''
let g:ctrlp_user_command = 'echo %s > /dev/null; find . -type f -not -name ".*"'
let g:ctrlp_clear_cache_on_exit = 0

"Auto save the file which is being edited when vim loses focus.
au FocusLost * silent! wa

command GenerateTags !ctags -R *
command TermCat term cat "#1"

"automatic completion & correction
iab zhuhcheng@ zhuhcheng@gmail.com

"python formater
autocmd FileType *.py smap = :autopep8

let g:clang_formater = "/usr/bin/clang-format"
let g:clang_formater_py = "/usr/local/bin/clang-format.py"

if !empty(glob(g:clang_formater_py))
  execute "au FileType cpp,cc,h,tcc,c vmap = :py3file " .g:clang_formater_py . "<CR>"
elseif !empty(glob(g:clang_formater))
  execute "au FileType cpp,cc,h,tcc,c vmap = :" .g:clang_formater . "<CR>"
endif

"au FileType cc,cpp,c,h,hpp vmap = :!clang-format
"au FileType cc,cpp,c,h,hpp vmap = :!clang-format<CR>


au BufNewFile *.cc,*.cpp :r !cat $HOME/.template.cpp 2> /dev/null
:command! -nargs=* -complete=shellcmd Bash vert new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>

autocmd FileType python,py setlocal tabstop=4

autocmd FileType javascript,js,jsx setlocal shiftwidth=4 tabstop=4

" make :!cmd behaves the same as in Shell
" set shellcmdflag=-ic

" Turn off auto indent triggered by : in a Python file
autocmd FileType python setlocal indentkeys-=<:>
autocmd FileType python setlocal indentkeys-=:

command! Black !black -l 80 %
command! Gofmt !gofmt -w %

" fj for escape
imap fj <Esc>

" ctags
map <C-]> :vsp <CR>:exec("ts ".expand("<cword>"))<CR>

" \s to substitue the word under the cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" Doesn't work as intended
command! -nargs=1 Bname r !exec("echo"  .expand("#<f-args>"))
" Current buffer name
command! Bn r !echo "#"
command! Bn1 r !echo "#1"
command! Bn2 r !echo "#2"
command! Bn3 r !echo "#3"
command! Bn4 r !echo "#4"
command! Bn5 r !echo "#5"
command! Bn6 r !echo "#6"
command! Bn7 r !echo "#7"
command! Bn8 r !echo "#8"
command! Bn9 r !echo "#9"
command! Bn10 r !echo "#10"
command! Bn11 r !echo "#11"
command! Bn12 r !echo "#12"
command! Bn13 r !echo "#13"
command! Bn14 r !echo "#14"
command! Bn15 r !echo "#15"
