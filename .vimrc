highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4

set number ""行番号表示
syntax enable
"colorscheme ron
set tabstop=4
set autoindent
set smartindent
set expandtab
set shiftwidth=4
set incsearch
set ignorecase
set smartcase
set hlsearch
" カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set whichwrap=b,s,h,l,<,>,[,],~
set cursorline " カーソルラインをハイライト
set wildmenu " コマンドモードの補完
set history=5000 " 保存する履歴数

" ----------------- my key mapping ---------------------
nnoremap <Tab> >>
nnoremap <S-Tab> <<
nnoremap <ESC><ESC> :nohlsearch<ENTER>
nnoremap sv :vsplit<ENTER>
nnoremap ss :split<ENTER>
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l

inoremap { {}<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
"inoremap < <><LEFT>
inoremap [ []<LEFT>


" -------------------- functions ---------------------
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
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif


