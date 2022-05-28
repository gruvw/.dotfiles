" ~/.vimrc

" Vim plug
call plug#begin('~/.vim/plugged')
" Plug 'sirver/ultisnips'
"     let g:UltiSnipsExpandTrigger = '<nop>'
"     let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
" Plug 'lervag/vimtex'
" 	let g:tex_flavor='latex'
" 	let g:vimtex_quickfix_mode=0
" 	set conceallevel=1
" 	let g:tex_conceal='abdmg'
" 	let g:vimtex_view_method = 'zathura'
" Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
    " let g:livepreview_engine = 'latexmk'
    " let g:livepreview_previewer = 'zathura'
Plug 'itchyny/lightline.vim'
    let g:lightline = {'colorscheme': 'seoul256'}
Plug 'phanviet/vim-monokai-pro'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
    let g:coc_snippet_next = '<tab>'
Plug 'plasticboy/vim-markdown'
    let g:vim_markdown_folding_style_pythonic = 1
    let g:vim_markdown_fenced_languages = ['python=py']
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdcommenter'
call plug#end()

" Own settings
set encoding=utf8
set noerrorbells
set mouse=a
set ruler
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set showcmd
set noswapfile
set incsearch
set background=dark
set termguicolors
colorscheme monokai_pro
hi Normal guibg=#222222 ctermbg=NONE
highlight NonText guibg=NONE ctermbg=NONE
" hi CursorLine guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE
hi CursorLineNR cterm=bold
set cursorline
" insert mode cursor shape |
let &t_SI = "\e[5 q"
" normal mode cursor shape block
let &t_EI = "\e[0 q"
" replace moed cursor shape _
let &t_SR = "\e[3 q"
set laststatus=2
map <C-_> <Plug>NERDCommenterToggle
filetype plugin on
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=124 guifg=#af0000 gui=underline
set nofoldenable

" Spell check
augroup spellchecker
    autocmd!
    autocmd FileType FileType latex,tex,md,markdown setlocal spell
augroup END
set spelllang=en_us,fr
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Space for easymotion
map <Space> <Leader><Leader>

" Rebind esc to jk
imap jk <Esc>

" Visual mode surround
" map vs vS

" Turn relative line numbers on
:set number relativenumber

" coc.nvim
set hidden
set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=number
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<C-g>u\<TAB>"
inoremap <silent><expr> <NUL> coc#refresh()

" Lightline transparent background in statusbar (https://github.com/itchyny/lightline.vim/issues/168)
autocmd VimEnter * call SetupLightlineColors()
function SetupLightlineColors() abort
  let l:palette = lightline#palette()
  let l:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  let l:palette.inactive.middle = l:palette.normal.middle
  let l:palette.tabline.middle = l:palette.normal.middle
  call lightline#colorscheme()
endfunction

" Explorer (netrw)
let g:netrw_bufsettings = 'noma nomod nu nowrap ro nobl'
let g:netrw_keepdir = 0 " cd to current dir
let g:netrw_banner = 0
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_localcopydircmd = 'cp -r'
hi! link netrwMarkFile Search
function! NetrwMapping()
  nmap <buffer> H u
  nmap <buffer> h -^
  nmap <buffer> l <CR>
  nmap <buffer> . gh
  nmap <buffer> P <C-w>z
  nmap <buffer> <TAB> mf
  nmap <buffer> <S-TAB> mF
  " New file
  nmap <buffer> ff %:w<CR>:buffer #<CR>
endfunction

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

" Saved macro
let @f = 'F"ifjkf";' " Python transform string into formatted literal
