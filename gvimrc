set background=dark

set guioptions+=d " dark mode
set guioptions-=T " no toolbar
set guioptions-=m " no menu
set guioptions-=r " no right scrollbar
set guioptions-=l " no left scrollbar
set guioptions-=L " no left scrollbar even when vertically split
set guioptions-=e " no gui tabs (only console)
set guioptions+=a " visual mode allows copying to external clipboard
set guioptions+=c " use console dialogs instead of popup dialogs

set lines=999 columns=999 " maximise screen

set guicursor=
	\a:Cursor,
	\n-v:block,
	\c-ci-i:ver25,
	\r-cr:hor20,
	\a:blinkon0,
	\o:blinkwait1-blinkoff150-blinkon175,

set termguicolors
" defaults from :echo term_getansicolors(N)
let g:ansi_colors = [
	\'#000000', '#e00000', '#00e000', '#e0e000', '#0000e0', '#e000e0', '#00e0e0', '#e0e0e0',
	\'#808080', '#ff4040', '#40ff40', '#ffff40', '#4040ff', '#ff40ff', '#40ffff', '#ffffff']
let g:ansi_colors[4] = '#4040ff'
let g:ansi_colors[12] = '#8080ff'

let g:terminal_ansi_colors = g:ansi_colors

hi QuickScopePrimary gui=underline gui=standout
hi QuickScopeSecondary gui=underline
hi HighlightedyankRegion guibg=yellow4

" augroup qs_colors
"   autocmd!
"   autocmd ColorScheme * highlight QuickScopePrimary gui=underline
"   autocmd ColorScheme * highlight QuickScopeSecondary gui=underline
" augroup END

if has('win32')
	set guifont=RobotoMono_Nerd_Font_Mono:h12
else
	set guifont=RobotoMono\ Nerd\ Font\ Mono
endif

" ########## vim-airline ##########
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_symbols = {
	\'linenr': ' :',
	\'modified': '+',
	\'whitespace': '☲',
	\'branch': '',
	\'ellipsis': '...',
	\'paste': 'PASTE',
	\'maxlinenr': '☰ ',
	\'readonly': '',
	\'spell': 'SPELL',
	\'space': ' ',
	\'dirty': '⚡',
	\'colnr': ' :',
	\'keymap': 'Keymap:',
	\'crypt': '🔒',
	\'notexists': 'Ɇ'
	\}
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
" #################################

hi Normal                 ctermfg=white guifg=white  guibg=black

hi Pmenu guibg=#292929
hi PmenuSel guibg=gray
hi SignColumns guibg=black

hi TabLineFill guifg=#000000 guibg=#000000
hi TabLine gui=NONE
hi Folded guibg=gray10
hi FoldColumn guibg=gray10
hi SignColumn guibg=gray15
hi SpecialKey guifg='royalblue4'

"hi SpecialKey     term=bold ctermfg=4
"hi NonText        term=bold cterm=bold ctermfg=4
"hi Directory      term=bold ctermfg=4
"hi ErrorMsg       term=standout cterm=bold ctermfg=7 ctermbg=1
"hi IncSearch      term=reverse cterm=reverse
"hi Search         term=reverse ctermfg=0 ctermbg=3
"hi MoreMsg        term=bold ctermfg=2
"hi ModeMsg        term=bold cterm=bold
"hi LineNr         term=underline ctermfg=3
"hi Question       term=standout ctermfg=2
"hi StatusLine     term=bold,reverse cterm=bold,reverse
"hi StatusLineNC   term=reverse cterm=reverse
"hi VertSplit      term=reverse cterm=reverse
"hi Title          term=bold ctermfg=5
"hi Visual         term=reverse cterm=reverse
"hi WarningMsg     term=standout ctermfg=1
"hi WildMenu       term=standout ctermfg=0 ctermbg=3
"hi Folded         term=standout ctermfg=4 ctermbg=7
"hi FoldColumn     term=standout ctermfg=4 ctermbg=7
"hi DiffAdd        term=bold ctermbg=1
"hi DiffChange     term=bold ctermbg=5
"hi DiffDelete     term=bold cterm=bold ctermfg=4 ctermbg=6
"hi DiffText       term=reverse cterm=bold ctermbg=1
"hi SignColumn     term=standout ctermfg=4 ctermbg=7
"hi SpellBad       term=reverse ctermbg=1
"hi SpellCap       term=reverse ctermbg=4
"hi SpellRare      term=reverse ctermbg=5
"hi SpellLocal     term=underline ctermbg=6
"hi Pmenu          ctermbg=5
"hi PmenuSel       ctermbg=7
"hi PmenuSbar      ctermbg=7
"hi PmenuThumb     cterm=reverse
"hi TabLine        term=underline cterm=underline ctermfg=0 ctermbg=7
"hi TabLineSel     term=bold cterm=bold
"hi TabLineFill    term=reverse cterm=reverse
"hi CursorColumn   term=reverse ctermbg=7
"hi CursorLine     term=underline cterm=underline gui=underline guibg=black
"hi MatchParen     term=reverse ctermbg=6
"hi Comment        term=bold ctermfg=4
"hi Constant       term=underline ctermfg=1 guifg=red
"hi Special        term=bold ctermfg=3
"hi Identifier     term=underline ctermfg=6
"hi Statement      term=bold ctermfg=3 guifg=darkyellow
"hi PreProc        term=underline ctermfg=5 guifg=magenta
"hi Type           term=underline ctermfg=2
"hi Underlined     term=underline cterm=underline ctermfg=5
"hi Ignore         cterm=bold ctermfg=7
"hi Error          term=reverse cterm=bold ctermfg=7 ctermbg=1
"hi Todo           term=standout ctermfg=0 ctermbg=3
