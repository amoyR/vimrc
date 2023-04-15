" Tab系
" Tabキーを押した際にタブ文字の代わりにスペースを入れる
set expandtab
" 自動インデントでずれる幅
set shiftwidth=2
" タブキー押下時に挿入される文字幅を指定
set softtabstop=2
" ファイル内にあるタブ文字の表示幅
set tabstop=2

" ツールバーを非表示にする
set guioptions-=T
" 対応する括弧を強調表示
set showmatch
" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent
" 不可視文字を可視化(タブが「▸-」と表示される)
"set list listchars=tab:\▸\-
" yでコピーした時にクリップボードに入る
set guioptions+=a
" 行番号を表示
set number
" マウスの使用を有効化(全てのモードにて) 
set mouse=a
" Foldingの無効化
set nofoldenable

set hlsearch

" for 'ryanoasis/vim-devicons'
set encoding=UTF-8

"CompletionでCtrl-Oで決定後、Normalモードに移行
imap <C-O> <C-O><Esc><Esc>
"CompletionでEnterで決定後、改行を入れない
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" yank to clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard
  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/amoyr/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/Users/amoyr/.vim/dein')

" Let dein manage dein
" Required:
call dein#add('/Users/amoyr/.vim/dein/repos/github.com/Shougo/dein.vim')

" Add or remove your plugins here like this:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')

call dein#add('scrooloose/nerdtree')

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------


" NERDTree settings
function MyNerdTreeToggle()
  if &filetype == 'nerdtree'
    :NERDTreeToggle
  else
    :NERDTreeFind
  endif
endfunction
nnoremap <silent><C-e> :call MyNerdTreeToggle() <CR>

augroup myvimrc
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l*    lwindow
augroup END

" Fix E568: duplicate cscope database not added
" http://thoughtsolo.blogspot.com/2014/02/cscope-issue-duplicate-cscope-database.html
set nocscopeverbose 

"nnoremap <C-p> <Esc>:set paste! paste?<CR>i

" Binary
"バイナリ編集(xxd)モード（vim -b での起動、または *.bin ファイルを開くと発動）
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre   *.bin let &binary=1
  autocmd BufReadPre   *.img let &binary=1
  autocmd BufReadPost  *     if  &binary   | silent   %!xxd -g 1
  autocmd BufReadPost  *     set ft=xxd    | endif
  autocmd BufWritePre  *     if  &binary   | execute '%!xxd -r' | endif
  autocmd BufWritePost *     if  &binary   | silent   %!xxd -g 1
  autocmd BufWritePost *     set nomod     | endif
augroup END

" 全角スペース・行末のスペース・タブの可視化
if has("syntax")
    syntax on
    " PODバグ対策
    syn sync fromstart
 
    function! ActivateInvisibleIndicator()
        " 下の行の"　"は全角スペース
        syntax match InvisibleJISX0208Space "　" display containedin=ALL
        highlight InvisibleJISX0208Space term=underline ctermbg=Blue guibg=darkgray gui=underline
        "syntax match InvisibleTrailedSpace "[ \t]\+$" display containedin=ALL
        "highlight InvisibleTrailedSpace term=underline ctermbg=Red guibg=NONE gui=undercurl guisp=darkorange
        "syntax match InvisibleTab "\t" display containedin=ALL
        "highlight InvisibleTab term=underline ctermbg=white gui=undercurl guisp=darkslategray
    endfunction
 
    augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
    augroup END
endif


