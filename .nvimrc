call plug#begin('~/.local/share/nvim/plugged')

" Enforcing sane behavior
Plug 'tpope/vim-sensible'    " Reasonable vim defaults
Plug 'tpope/vim-repeat'      " Make `.` work like it should
Plug 'tpope/vim-endwise'     " Automatically add `end` when in Ruby
Plug 'Townk/vim-autoclose'   " Automatic closure of parens, braces, and brackets
Plug 'timakro/vim-searchant' " Highlight *all* of the matches in a search

" UI - Plugins that don't *do* anything but display information
Plug 'critiqjo/vim-bufferline' " Enables tab-like list of buffers along top
Plug 'itchyny/lightline.vim'   " Extensible lightweight statusbar for vim
Plug 'junegunn/seoul256.vim'   " A beautiful colorscheme!
Plug 'junegunn/vim-peekaboo'   " To see vim register contents during reg access

" File Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'   " Fuzzy file search (hooked up to C-P for me)
Plug 'majutsushi/tagbar'  " Show sidebar of tags a la IntelliJ or Eclipse
Plug 'mhinz/vim-startify' " Show useful menu on vim's startup

" Editor Keybindings/Motions
Plug 'tpope/vim-unimpaired'       " Pairs of useful keymappings
Plug 'tpope/vim-commentary'       " Easily (un)comment lines or blocks
Plug 'wellle/targets.vim'         " Add additional text objects and related goodies
Plug 'junegunn/vim-easy-align'    " To easily align repeating structures
Plug 'tpope/vim-surround'         " Easily add surrounding characters to text objects
Plug 'tweekmonster/braceless.vim' " Manipulate blocks in indented languages

" Interfaces
Plug 'tpope/vim-eunuch'               " Adds nice Unix shortcuts to Vim
Plug 'tpope/vim-fugitive'             " Git wrapper for vim
Plug 'tpope/vim-rhubarb'              " Adds GitHub specific features to vim-fugitive
Plug 'janko-m/vim-test'               " Running tests in vim
Plug 'benmills/vimux'                 " Send commands to tmux panes from vim; used in vim-test
Plug 'airblade/vim-gitgutter'         " Show changes in the left gutter; stage individual hunks
Plug 'christoomey/vim-tmux-navigator' " Enables vim-tmux nav with C-h/j/k/l keys
Plug 'rizzatti/dash.vim'
Plug 'wsdjeg/vim-cheat'               " Open ~/.cheat/ files easily in vim

" Autocompletion
if has('nvim')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif

" Not for Vim - Plugins that don't have anything to do with vim (weird, right?)
Plug 'edkolev/tmuxline.vim' " Customize tmux status bar in .vimrc
Plug 'edkolev/promptline.vim' " Customize shell prompt

" Language/library specific plugins
Plug 'sheerun/vim-polyglot'
Plug 'w0rp/ale' " Asynchronous linter
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails' " Additional rails help
Plug 'pangloss/vim-javascript'
Plug 'fs111/pydoc.vim' 
Plug 'vim-scripts/django.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'lervag/vimtex' " Vim plugin for working with .tex files
Plug 'mattn/emmet-vim' " Easily input raw HTML
if has('nvim')
	Plug 'fishbullet/deoplete-ruby', { 'do': ':UpdateRemotePlugins' }
	Plug 'zchee/deoplete-jedi'
endif

" Misc. 
Plug 'vimwiki/vimwiki' " A wiki in vim

" Required vim-plug
call plug#end()

" Settings
set nocompatible            " Allow for settings that break from Vi (useless in nvim)
set number                  " Show line numbers
set hidden                  " Close windows without closing buffers
set expandtab               " Expand each press of <TAB> to appropriate number of spaces
set tabstop=2               " Number of spaces each tab corresponds to
set shiftwidth=2            " Number of spaces to indent to when using autoformatting
set cursorline              " Highlight the line the cursor is on
set ignorecase              " Ignore case when searching
set smartcase               " Add case sensitivity if any capital letters; requires ignorecase
set noshowmode              " Don't show the mode (INSERT, VISUAL, etc.) on the last line
set splitright              " So new splits open on the right
set undofile                " Keep undos in a file
set undodir=$HOME/.vim/undo " Sets undo file director
set undolevels=1000         " Max number of changes that can be undone
set undoreload=10000        " Save files <10,000 lines as an undo before executing :e!
set showtabline=2           " Always show tab list; utilized by bufferline to show buffers
set mouse+=a
if &term =~ '^xterm'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

colorscheme seoul256
let &colorcolumn=join(range(80,999),",")  " Sets cols >=79 to a different color

" Neovim specific items
if has('nvim')
	set guicursor=   " Disable cursor styling
	set noshowcmd    " Don't show command in last line of screen
	set nolazyredraw " We'll see...
endif

" Keymappings

nmap <SPACE> <leader>
vmap <SPACE> <leader>
" Move to next buffer
nmap <leader>l :bnext<CR>
" Move to previous buffer
nmap <leader>h :bprevious<CR>
" Close current buffer and move to previous
nmap <leader>w :bp <BAR> bd #<CR>
" Easily edit .[n]vimrc
nnoremap <leader>ve :vsplit $MYVIMRC<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>
" Navigate based on visual line breaks
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
" Escape from insert & command mode using `jj`
inoremap jj <Esc>l
cnoremap jj <C-c>l
" Escape from visual mode using `v`
vnoremap v <Esc>
nnoremap <C-J> <C-W>j<C-W>_ 
nnoremap <C-K> <C-W>k<C-W>_
nnoremap <leader>k 10k
nnoremap <leader>j 10j
vnoremap <leader>k 10k
vnoremap <leader>j 10j
" Make Y work like it's supposed to
nnoremap Y y$

if has('nvim')
	" Use `<TAB>` to scroll through pop-up menu
	inoremap <expr><TAB> pumvisible() ? "\<C-N>" : "\<TAB>"
	inoremap <expr><S-TAB> pumvisible() ? "\<C-P>" : "\<S-TAB>"
endif

" ---------------------
" PLUGIN CONFIGURATIONS
" ---------------------

" vim-autoclose configuration
let g:AutoCloseExpandSpace = 0 " Make iabbrev work again


" bufferline configuration
let g:bufferline_active_buffer_left = ''
let g:bufferline_active_buffer_right = ''
let g:bufferline_show_bufnr = 0
let g:bufferline_fname_mod = ':~:.'
let g:bufferline_pathshorten = 1

function! MyBufferlineRefresh()
	call bufferline#refresh_status()
	let rlen = 4*tabpagenr('$') + len(&fenc) + 8
	call bufferline#trim_status_info(&columns - rlen)
	return ''
endfunction


" lightline configuration
let g:lightline = {
			\  'colorscheme': 'seoul256',
			\  'active':{
			\		'left': [ [ 'mode', 'paste' ], ['fugitive', 'filename'], ['ctrlpmark'] ],
			\		'right': [ ['lineinfo' ] , ['filetype'], ['fileencoding'], ]
			\  },
			\  'tab': {
			\    'active': ['tabnum'],
			\    'inactive': ['tabnum']
			\  },
			\  'tabline': {
			\ 	 	'left': [ ['tabs'], ['bufferline'] ],
			\  		'right': [ ['fileencoding'] ]
			\  },
			\  'component': {
			\		'readonly': '%{&readonly?"⭤ ":""}',
			\   	'bufferline': '%{MyBufferlineRefresh()}' . bufferline#get_status_string('TabLineSel', 'LightLineLeft_tabline_tabsel_1'),
			\   	'fileencoding': '%{&fenc}',
			\  },
			\  'component_function': {
			\		'ctrlpmark': 'CtrlPMark',
			\		'fugitive': 'LightLineFugitive',
			\		'filename': 'LightLineFilename',
      \   'mode': 'LightLineMode'
			\  		},
			\ }
let lightline.enable = {
			\ 'statusline': 1,
			\ 'tabline': 1
			\}

function! LightLineFileformat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
	return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
	return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
	let fname = expand('%:t')
	return fname == '__Tagbar__' ? 'Tagbar' :
				\ fname == 'ControlP' ? 'CtrlP' :
				\ fname == '__Gundo__' ? 'Gundo' :
				\ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
				\ fname =~ 'NERD_tree' ? 'NERDTree' :
				\ &ft == 'unite' ? 'Unite' :
				\ &ft == 'vimfiler' ? 'VimFiler' :
				\ &ft == 'vimshell' ? 'VimShell' :
				\ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightLineFugitive()
	try
		if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
			let mark = ''  " edit here for cool mark
			let _ = fugitive#head()
			return _ !=# '' ? mark._ : ''
		endif
	catch
	endtry
	return ''
endfunction


" fzf.vim configuration
nnoremap <C-P> :FZF<CR>
nnoremap <Leader>a :Ag<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <C-M> :Buffers<CR>
nnoremap <C-N> :Lines<CR>


" vim-easy-align configuration
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
" for aligning Ruby rocket-style hashes
let g:easy_align_delimiters = { ';': { 'pattern': ':', 'left_margin': 1, 'right_margin': 0 } }


" braceless configuration
autocmd FileType haml,coffee BracelessEnable +indent


" vim-fugitive configuration
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>ga :Gcommit --amend<CR>
nnoremap <Leader>gp :Gpush<CR>
nnoremap <Leader>gfp :Gpush -f<CR>


" vim-test configuration
let test#strategy = "vimux"
nnoremap <Leader>tn :TestNearest<CR>
nnoremap <Leader>tl :TestLast<CR>
nnoremap <Leader>tf :TestFile<CR>



" vimux configuration
let VimuxUseNearest = 0


" vim-gitgutter configuration
nmap <Leader>yp <Plug>GitGutterPreviewHunk
nmap <Leader>yr <Plug>GitGutterUndoHunk
nmap <Leader>yu <Plug>GitGutterUndoHunk
nmap <Leader>ys <Plug>GitGutterStageHunk


" deoplete configuration
if has('nvim')
	let g:deoplete#enable_at_startup = 1
	let g:deoplete#auto_refresh_delay = 200
endif


" tmuxline configuration
let g:tmuxline_powerline_separators = 0
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#W',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'y'    : '%a %D',
      \'z'    : '%I:%M %p'
	  \}


" promptline configuration
let g:promptline_theme = 'lightline'
let g:promptline_preset = {
        \'a' : [ promptline#slices#cwd() ],
        \'b' : [ promptline#slices#vcs_branch(), promptline#slices#git_status() ],
        \'c' : [ promptline#slices#python_virtualenv() ],
        \'y' : [],
        \'warn' : [ promptline#slices#last_exit_code() ]}

let g:promptline_powerline_symbols = 0


" polyglot configuration
let g:polyglot_disabled = ['latex'] " To ensure compatiblility with vimtex

" ale configuration
nmap <silent> <leader>n <Plug>(ale_previous_wrap)
nmap <silent> <leader>p <Plug>(ale_next_wrap)

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_fixers = {
\   'ruby': [
\       'rubocop'
\   ],
\}


" vim-ruby configuration
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1 
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1


" vimtex configuration
let g:vimtex_view_general_viewer
			\ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'
augroup latexSurround
	autocmd!
	autocmd FileType tex call s:latexSurround()
augroup END

function! s:latexSurround()
	let b:surround_{char2nr("e")}
				\ = "\\begin{\1environment: \1}\n\t\r\n\\end{\1\1}"
	let b:surround_{char2nr("c")} = "\\\1command: \1{\r}"
endfunction

" This adds a callback hook that updates Skim after compilation
let g:vimtex_latexmk_continuous = 1
let g:vimtex_latexmk_callback_hooks = ['UpdateSkim']
function! UpdateSkim(status)
	if !a:status | return | endif

	let l:out = b:vimtex.out()
	let l:cmd = [g:vimtex_view_general_viewer, '-r']
	if !empty(system('pgrep Skim'))
		call extend(l:cmd, ['-g'])
	endif
	if has('nvim')
		call jobstart(l:cmd + [line('.'), l:out])
	elseif has('job')
		call job_start(l:cmd + [line('.'), l:out])
	else
		call system(join(l:cmd + [line('.'), shellescape(l:out)], ' '))
	endif
endfunction


" Vimwiki configuration
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki',
			\'template_path': '~/Dropbox/vimwiki/templates/',
			\'template_default': 'default',
			\'template_ext': '.html',
			\'auto_export': 1,
			\'auto_toc': 0}]
