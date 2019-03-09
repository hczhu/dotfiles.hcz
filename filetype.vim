" Ruby
au BufRead,BufNewFile *.ru set filetype=ruby
au BufRead,BufNewFile *.rb set filetype=ruby
au BufRead,BufNewFile *.json_builder set filetype=ruby

" Haml
au BufRead,BufNewFile *.haml set filetype=haml

" Erlang
au BufRead,BufNewFile *.app.src set filetype=erlang
au BufRead,BufNewFile *.config set filetype=erlang
au BufRead,BufNewFile *.hrl set filetype=erlang
au FileType erlang set indentexpr=

" Haskell
au BufRead,BufNewFile *.hs set filetype=haskell
au FileType haskell set includeexpr=substitute(v:fname,'\\.','/','g')

" Perl
au BufRead,BufNewFile *.pl set filetype=perl
au BufRead,BufNewFile *.pm set filetype=perl
au FileType perl set iskeyword=@,48-57,_,192-255,:

" SCSS
au BufRead,BufNewFile *.scss set filetype=scss

" PHP
au BufRead,BufNewFile *.phps set filetype=php
au BufRead,BufNewFile *.thtml set filetype=php

" Coffee
au BufRead,BufNewFile *.coffee set filetype=coffee

" Nginx
au BufRead,BufNewFile config/nginx/*.conf set filetype=nginx

" YAML
au BufRead,BufNewFile *.yaml set filetype=yaml
au BufRead,BufNewFile *.yml set filetype=yaml

au FileType yaml set indentexpr=

au BufRead,BufNewFile *.html set filetype=html

au BufRead,BufNewFile *.test set filetype=test

" C++
au BufRead,BufNewFile *.cpp,*.cc,*.h,*.hpp set filetype=cpp

" Python
au BufRead,BufNewFile *.py set filetype=python

" Bash
au BufRead,BufNewFile *.sh set filetype=bash

" Javascript
au BufRead,BufNewFile *.js set filetype=js

" Go
au BufRead,BufNewFile *.go set filetype=go
