set runtimepath=
	\~/.vim,
	\$VIM/vimfiles,
	\$VIMRUNTIME,
	\$VIM/vimfiles/after,
	\~/.vim/after
if exists('vscode')
	set viminfo+=n~/.vim/nviminfo
else
	set viminfo+=n~/.vim/viminfo
endif

" #################### MAPPINGS ####################
let g:windowswap_map_keys = 0
"nnoremap <silent> <leader>y :call WindowSwap#MarkWindowSwap()<CR>
"nnoremap <silent> <leader>p :call WindowSwap#DoWindowSwap()<CR>
nnoremap <silent> <C-w>y :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <C-w>p :call WindowSwap#DoWindowSwap()<CR>

map <silent> <F3> :UndotreeToggle<CR>
map <silent> <F4> :NERDTreeToggle<CR>
map <silent> <expr> <F5> ':wa \| !' . g:build_cmd . '<CR>'

" change easymotion prefix from \\ to \
map <Leader> <Plug>(easymotion-prefix)

" Move to the next buffer
nmap <silent> <C-l> :bnext<CR>
tmap <silent> <C-l> <C-W>:bnext<CR>
" Move to the previous buffer
nmap <silent> <C-h> :bprevious<CR>
tmap <silent> <C-h> <C-W>:bprevious<CR>
" quit current buffer and move to previous
nmap <silent> <C-q> :b# \| bd#<CR>
tmap <silent> <C-q> <C-W>:b# \| bd#<CR>
nmap <silent> g<C-q> :b# \| bd!#<CR>
tmap <silent> g<C-q> <C-W>:b# \| bd!#<CR>

nmap <C-t> :term ++curwin<CR>
tmap <C-t> <C-W>:term ++curwin<CR>

nmap <C-S> :w<CR>
nmap <C-f> za
imap <C-z> <C-o>zz

nmap <C-Tab> :set et! et?<CR>

imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>

if !exists('vscode')
	" imap {<CR> {}<Left><CR>
	" inoremap { {}<Left>
	" inoremap ( ()<Left>
	" inoremap [ []<Left>
	" inoremap " ""<Left>
	" inoremap {} {}
	" inoremap () ()
	" inoremap [] []
	" inoremap "" ""

	" stop search highlighting on return in normal mode
	nnoremap <silent> <CR> :noh<CR><CR>
endif

" nmap <silent> <C-S> :new \| Startify<CR>

" ########## Coc ##########

autocmd FileType rust setlocal updatetime=100
autocmd FileType rust setlocal foldnestmax=2
autocmd FileType rust nnoremap <silent> <Esc> :call ShowDocumentation(0)<CR>

" nnoremap <silent> <Esc> :call CocActionAsync('highlight')<CR>

autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <F2> <Plug>(coc-rename)

inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#next(0) : "\<Tab>"
inoremap <silent><expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(0) : "\<S-Tab>"

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
" inoremap <silent><expr> <TAB>
"       \ coc#pum#visible() ? coc#pum#next(1) :
"       \ CheckBackspace() ? "\<Tab>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR>
			\ coc#pum#visible() ? coc#pum#confirm()
			\ : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation(1)<CR>

" Use C-J and C-K to scroll popups
nnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-j>"
nnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-k>"
inoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Down>"
inoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Up>"

function! ShowDocumentation(fallback_K)
	if CocAction('hasProvider', 'hover')
		call CocActionAsync('doHover')
	elseif a:fallback_K
		call feedkeys('K', 'in')
	endif
endfunction

let g:airline#extensions#coc#enabled = 1

function GetFoldLevel(lnum)
	let curpos = getcurpos()
	let old_line = curpos[1]
	let old_col = curpos[4]
	let view = winsaveview()

	let start_regex = '^\s*\(\(pub\)\?\s*\(fn\|enum\|struct\).*\|.*!\s*\){\s*$'

	let line = getline(a:lnum)
	let retval = "="
	if line =~ start_regex
		let retval = "a1"
	elseif line =~ '^\s*};\?\s*'
		let index = stridx(line, "}")
		call cursor(a:lnum, index)
		normal! %
		if getline(line(".")) =~ start_regex
			let retval = "s1"
		endif
	endif

	call cursor(old_line, old_col)
	call winrestview(view)
	return retval
endfunction
set foldmethod=expr
set foldexpr=GetFoldLevel(v:lnum)

" #########################

if exists('vscode')
	nmap j gj
	nmap k gk
	nnoremap <silent> za <Cmd>call VSCodeNotify('editor.toggleFold')<CR>
endif

" ##################################################

filetype on
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_hi_priority=2
let g:qs_enable=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#ignore_bufadd_pat = 'defx|gundo|nerd_tree|startify|tagbar|term://|undotree|vimfiler'
let g:airline#extensions#windowswap#enabled = 1

set number
set hidden
set incsearch
set hlsearch
" stop search highlighting turning on after a .vimrc reload
nohlsearch

set relativenumber
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

set shortmess-=S
set ch=2
set notimeout ttimeout
set splitbelow
set backspace=indent,eol,start
set updatetime=1000
" set completeopt=longest,menuone
set belloff=wildmode,error,cursor

call mkdir($HOME."/.vim/backup", "p")
call mkdir($HOME."/.vim/swap", "p")
call mkdir($HOME."/.vim/undo", "p")

set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo/
set undofile

set sessionoptions-=globals
set sessionoptions-=localoptions
set sessionoptions-=options
set sessionoptions-=resize
" set sessionoptions-=buffers

set fileformat=unix

set expandtab
set tabstop=4
set shiftwidth=4
" set foldmethod=syntax
set foldcolumn=4

function CalculateTab()
	let &l:listchars="tab:\|\ ,trail:-,extends:»,precedes:«"
	if &l:expandtab
		let l:spaces = repeat("\ ", &shiftwidth - 1)
		let &l:listchars .= ",leadmultispace:\|"
		let &l:listchars .= l:spaces
	endif
endfunction

set list
augroup recalculatetab
	au!
	au CursorHold,BufWinEnter,WinEnter * call CalculateTab()
augroup END

augroup autofoldcolumn
	au!
	au CursorHold,BufWinEnter,WinEnter * AutoOrigamiFoldColumn
augroup END

" #################### STARTIFY ####################
let g:startify_session_persistence = 1
let g:startify_session_before_save = [
	\'silent! tabdo NERDTreeClose',
	\'silent! tabdo UndotreeHide',
	\]
let g:startify_change_to_vcs_root = 1
let g:startify_bookmarks = [{'v': '~/.vimrc'}, {'g': '~/.gvimrc'}, {'~': '~'}]
let g:startify_skiplist = ['doc\\.*\.txt$',]
let g:startify_session_autoload = 1
let g:startify_lists = [
	\{ 'type': 'sessions',  'header': ['   Sessions']       },
	\{ 'type': 'files',     'header': ['   MRU']            },
	\{ 'type': 'bookmarks', 'header': ['   Bookmarks']      },
	\{ 'type': 'commands',  'header': ['   Commands']       },
	\]
	" \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
" ##################################################

let g:highlightedyank_highlight_duration = 400

"set mouse=
cabbr <expr> %% expand('%:p:h')
cabbr wso w \| so %
cabbr .. e %:p:h
cabbr S Startify
cabbr \|S \| Startify
cabbr qh windo if &ft == 'help' \| q \| endif
cabbr qha tabdo windo if &ft == 'help' \| q \| endif
" cabbr B let g:build_cmd = input("build_command: ")

command -nargs=? BuildCmd if len(<q-args>) | let g:build_cmd = <q-args> | else | let g:build_cmd = input("build command: ") | endif

command RemoveTrailingWhitespace %s/\s\+$//e

" required for vim-airline
set encoding=utf-8

" vim-plug
" ##########################################################################
call plug#begin('~/.vim/plugged')

if !exists('vscode')
	Plug 'rust-lang/rust.vim'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}
	" Plug 'ycm-core/YouCompleteMe'
	Plug 'jclsn/glow.vim'
	Plug 'vimsence/vimsence'
	Plug 'ryanoasis/vim-devicons'
	Plug 'preservim/nerdtree'
endif
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mbbill/undotree'
"Plug 'stillwwater/wincap.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'justinmk/vim-sneak'
Plug 'unblevable/quick-scope'
Plug 'mhinz/vim-startify'
Plug 'wesQ3/vim-windowswap'
Plug 'benknoble/vim-auto-origami'
Plug 'tpope/vim-sleuth'
Plug 'machakann/vim-highlightedyank'

call plug#end()
" ##########################################################################
call airline#parts#define_accent('linenr', 'none')
call airline#parts#define_accent('maxlinenr', 'none')
let g:airline_section_z = airline#section#create(['windowswap', 'obsession', '%p%%', 'linenr', 'maxlinenr', 'colnr'])
" ##########################################################################

" NOT WHAT I DID IDK HOW THIS WORKS OR REALLY WHAT IT DOES!!

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
	set diffexpr=MyDiff()
endif
function MyDiff()
	let opt = '-a --binary '
	if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
	if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
	let arg1 = v:fname_in
	if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
	let arg1 = substitute(arg1, '!', '\!', 'g')
	let arg2 = v:fname_new
	if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
	let arg2 = substitute(arg2, '!', '\!', 'g')
	let arg3 = v:fname_out
	if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
	let arg3 = substitute(arg3, '!', '\!', 'g')
	if $VIMRUNTIME =~ ' '
		if &sh =~ '\<cmd'
			if empty(&shellxquote)
				let l:shxq_sav = ''
				set shellxquote&
			endif
			let cmd = '"' . $VIMRUNTIME . '\diff"'
		else
			let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
		endif
	else
		let cmd = $VIMRUNTIME . '\diff'
	endif
	let cmd = substitute(cmd, '!', '\!', 'g')
	silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
	if exists('l:shxq_sav')
		let &shellxquote=l:shxq_sav
	endif
endfunction

