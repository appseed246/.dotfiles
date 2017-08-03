" --------------- dein setting ---------------
if !&compatible

  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" dein settings {{{
" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" プラグイン読み込み＆キャッシュ作成
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
let s:lazy_file = fnamemodify(expand('<sfile>'), ':h').'/dein_lazy.toml'

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#load_toml(s:toml_file, {'lazy': 0})
  call dein#load_toml(s:lazy_file, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}


" --------------------- setting -----------------------
set runtimepath+=~/.config/vim

" Neovim's python Provider
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

set noswapfile
nnoremap <Space> <Nop>
" let mapleader = "\<Space>"
let mapleader = ','

set encoding=utf8
set fileencoding=utf8

set history=5000 " 保存する履歴数

" display
set list "末尾の空白などの表示
set number "行番号表示
set cursorline " カーソルラインをハイライト
set colorcolumn=80
set laststatus=2
if has('conceal')
    set conceallevel=0 concealcursor= "jsonのクオートを常に表示
endif

" colorscheme
set t_Co=256
syntax enable
colorscheme lucario
set background=dark
highlight CursorLine cterm=underline ctermbg=none
highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4
highlight Search cterm=reverse ctermfg=white
highlight MatchParen ctermfg=119

" tab/indent"
set expandtab
set tabstop=4
set softtabstop=4
set autoindent
set smartindent
set shiftwidth=4

" search
set incsearch
set ignorecase
set smartcase
set hlsearch

" status line
set ruler "カーソルの現在位置を右下に表示
set showmode "現在のモードを表示
set showcmd "打ったコマンドを表示
set wildmenu " コマンドモードの補完
set noshowmode


" 保存時に行末の空白を削除
autocmd BufWritePre * :%s/\s\+$//ge

" カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set whichwrap=b,s,h,l,<,>,[,],~

" ----------------- key mapping ---------------------

" >>> normal mode
"nnoremap ; :
nnoremap <Tab> >>
nnoremap <S-Tab> <<
nnoremap <silent> <C-c><C-c> :nohlsearch<ENTER>
nnoremap <silent> <ESC><ESC> :nohlsearch<ENTER>
nnoremap <silent> <leader>v :split $MYVIMRC<CR>
nnoremap <silent> <leader>d :split ~/.dotfiles/nvim/dein.toml<CR>
nnoremap <silent> <leader>l :split ~/.dotfiles/nvim/dein_lazy.toml<CR>
nnoremap <silent> <leader>r :QuickRun<CR>
nnoremap <silent> <leader>o :only!<CR>

" split
nnoremap <silent> sv :vsplit<ENTER>
nnoremap <silent> ss :split<ENTER>
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sH <C-w>H
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap s0 <C-w>=
nnoremap j gj
nnoremap k gk

" >>> insert mode
inoremap <C-c> <ESC>
inoremap { {}<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap < <><LEFT>
inoremap [ []<LEFT>
inoremap <C-f> <Right>
inoremap <C-b> <Left>

" >>> visual mode
vnoremap <Tab> >
vnoremap <S-Tab> <

" comand line mode
" <C-a>, A: Move to head.
cnoremap <C-a>          <Home>
" <C-b>: previous char.
cnoremap <C-b>          <Left>
" <C-d>: delete char.
cnoremap <C-d>          <Del>
" <C-e>, E: move to end.
cnoremap <C-e>          <End>
" <C-f>: next char.
cnoremap <C-f>          <Right>
" <C-n>: next history.
cnoremap <C-n>          <Down>
" <C-p>: previous history.
cnoremap <C-p>          <Up>
" <C-y>: paste.
" cnoremap <C-y>          <C-r>*
" <C-g>: Exit.
cnoremap <C-g>          <C-c>



" -------------------- functions ---------------------
" 行末にセミコロンを追加
function! AppendChar()
    :let pos = getpos(".")
    :let text = ";"
    :execute ":normal A".text
    :call setpos('.', pos)
:endfunction
inoremap <C-l> <ESC>:call AppendChar()<CR>a


" 隣接した{}で改行したらインデント
function! IndentBraces()
    let nowletter = getline(".")[col(".")-1]    " 今いるカーソルの文字
    let beforeletter = getline(".")[col(".")-2] " 1つ前の文字

    " カーソルの位置の括弧が隣接している場合
    if nowletter == "}" && beforeletter == "{"
        "return "\n\n\<UP>\<RIGHT>\<TAB>"
        return "\n\n\<UP>\<TAB>"
        "return "\n\t\n\<UP>\<RIGHT>"
    else
        return "\n"
    endif
endfunction
" Enterに割り当て
inoremap <silent> <expr> <CR> IndentBraces()

" ペースト時に自動でインデント無効
if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif

" mouse available
if has('mouse')
    set mouse=a
endif

function! DeleteParenthesesAdjoin()
    let pos = col(".") - 1  " カーソルの位置．1からカウント
    let str = getline(".")  " カーソル行の文字列
    let parentLList = ["(", "[", "{", "\'", "\"", "\<"]
    let parentRList = [")", "]", "}", "\'", "\"", "\>"]
    let cnt = 0

    let output = ""

    " カーソルが行末の場合
    if pos == strlen(str)
        return "\b"
    endif
    for c in parentLList
        " カーソルの左右が同種の括弧
        if str[pos-1] == c && str[pos] == parentRList[cnt]
            call cursor(line("."), pos + 2)
            let output = "\b"
            break
        endif
        let cnt += 1
    endfor
    return output."\b"
endfunction
" BackSpaceに割り当て
inoremap <silent> <C-h> <C-R>=DeleteParenthesesAdjoin()<CR>

