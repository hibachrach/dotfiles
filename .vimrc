set nocompatible

call plug#begin('~/.local/share/nvim/plugged')

if has('nvim')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'fishbullet/deoplete-ruby', { 'do': ':UpdateRemotePlugins' }
	Plug 'zchee/deoplete-jedi'
endif

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " Fuzzy file search (hooked up to C-P for me)
Plug 'majutsushi/tagbar' " Show sidebar of tags a la IntelliJ or Eclipse
Plug 'critiqjo/vim-bufferline' " Enables tab-like list of buffers along top
Plug 'Townk/vim-autoclose' " Automatic closure of parens, braces, and brackets
Plug 'tpope/vim-commentary' " Easily (un)comment lines or blocks
Plug 'tpope/vim-fugitive' " Git wrapper for vim
Plug 'tpope/vim-sensible' " Reasonable vim defaults
Plug 'tpope/vim-surround' " Easily add surrounding characters to text objects
Plug 'tpope/vim-repeat' " Make `.` work like it should
Plug 'tpope/vim-endwise' " Automatically add `end` when in Ruby
Plug 'tpope/vim-unimpaired' " Pairs of useful keymappings
Plug 'tpope/vim-vinegar' " Improve netrw 
Plug 'tpope/vim-rails' " Additional rails help
Plug 'tpope/vim-dispatch' " Easily run builds and test in pop-out window
Plug 'mattn/emmet-vim' 
Plug 'airblade/vim-gitgutter' " Show changes in the left gutter
Plug 'junegunn/seoul256.vim' " A beautiful colorscheme!
Plug 'junegunn/vim-easy-align' " To easily align repeating structures
Plug 'vimwiki/vimwiki' " A wiki in vim
Plug 'jonstoler/werewolf.vim' " Changing colorscheme based on time
Plug 'mhinz/vim-startify' " Show useful menu on vim's startup
Plug 'christoomey/vim-tmux-navigator' " Enables vim-tmux nav with C-h/j/k/l keys
Plug 'itchyny/lightline.vim' " Extensible lightweight statusbar for vim
Plug 'edkolev/tmuxline.vim' " Customize tmux status bar in .vimrc
Plug 'edkolev/promptline.vim' " Customize shell prompt
Plug 'wsdjeg/vim-cheat' " Open ~/.cheat/ files easily in vim
Plug 'timakro/vim-searchant' " Highlight *all* of the matches in a search
Plug 'lervag/vimtex' " Vim plugin for working with .tex files
Plug 'w0rp/ale' " Asynchronous linter
Plug 'pangloss/vim-javascript'
Plug 'vim-ruby/vim-ruby'
Plug 'hail2u/vim-css3-syntax'
Plug 'nvie/vim-flake8' 
Plug 'fs111/pydoc.vim' 
Plug 'vim-scripts/django.vim'
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['latex'] " To ensure compatiblility with vimtex

" Required vim-plug
call plug#end()

" Neovim specific items
if has('nvim')
	set guicursor=
	set noshowcmd
	set nolazyredraw
endif

" Colors and other essentials
set number
set hidden
set tabstop=2
set shiftwidth=2
set cursorline
set noshowmode
syntax on
colo seoul256
let g:werewolf_day_themes = ['seoul256-light']
let g:werewolf_night_themes = ['seoul256']

" Keymappings
map <SPACE> <leader>
nmap <leader>T :enew<CR> " Allows buffers to hide
nmap <leader>l :bnext<CR> " Move to next buffer
nmap <leader>h :bprevious<CR> " Move to next buffer
nmap <leader>w :bp <BAR> bd #<CR> " Close current buffer and move to previous
nmap <leader>bl :ls<CR> " Show all open buffers and their statuses

" Escape from insert mode using `jj`
ino jj <Esc>l
" Escape from command mode using `jj`
cno jj <C-c>l
" Escape from visual mode usinv `v`
vno v <Esc>
map <C-J> <C-W>j<C-W>_ 
map <C-K> <C-W>k<C-W>_
map <leader>k 10k
map <leader>j 10j
" Make Y work like it's supposed to
map Y y$
let &colorcolumn=join(range(80,999),",")  " Sets cols >=79 to a different color

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

nnoremap <C-P> :FZF<CR>

" Keep undos after file closes 
set undofile
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000

" Eclim (Eclipse + Vim configuration)
let g:EclimCompletionMethod = 'omnifunc'

" Vimwiki configuration
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki',
			\'template_path': '~/Dropbox/vimwiki/templates/',
			\'template_default': 'default',
			\'template_ext': '.html',
			\'auto_export': 1,
			\'auto_toc': 0}]

" Vimtex configuration
augroup latexSurround
	autocmd!
	autocmd FileType tex call s:latexSurround()
augroup END

function! s:latexSurround()
	let b:surround_{char2nr("e")}
				\ = "\\begin{\1environment: \1}\n\t\r\n\\end{\1\1}"
	let b:surround_{char2nr("c")} = "\\\1command: \1{\r}"
endfunction

let g:vimtex_view_general_viewer
			\ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'

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

" lightline and bufferline configuration
set showtabline=2
let g:bufferline_active_buffer_left = ''
let g:bufferline_active_buffer_right = ''
let g:bufferline_show_bufnr = 0
let g:bufferline_fname_mod = ':~:.'
let g:bufferline_pathshorten = 1
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
			\  		},
			\ }
let lightline.enable = {
			\ 'statusline': 1,
			\ 'tabline': 1
			\}
function! MyBufferlineRefresh()
	call bufferline#refresh_status()
	let rlen = 4*tabpagenr('$') + len(&fenc) + 8
	call bufferline#trim_status_info(&columns - rlen)
	return ''
endfunction
function! LightLineFileformat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
	return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') :
	''
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
let g:promptline_preset = {
        \'a' : [ promptline#slices#cwd() ],
        \'b' : [ promptline#slices#vcs_branch(), promptline#slices#git_status() ],
        \'c' : [ promptline#slices#python_virtualenv() ],
        \'y' : [],
        \'warn' : [ promptline#slices#last_exit_code() ]}

let g:promptline_powerline_symbols = 0

" vim-flake8 configuration
autocmd BufWritepost *.py call Flake8()
let g:flake8_show_in_gutter = 1
let g:flake8_show_quickfix = 0

" GitGutter configuration
nmap <Leader>yp <Plug>GitGutterPreviewHunk
nmap <Leader>yr <Plug>GitGutterUndoHunk
nmap <Leader>yu <Plug>GitGutterUndoHunk
nmap <Leader>ys <Plug>GitGutterStageHunk

" Put all neovim
if has('nvim')
	" Deoplete configuration
	let g:deoplete#enable_at_startup = 1
	let g:deoplete#auto_refresh_delay = 200
	" Enable the use of <tab> as the autocomplete key
	inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
	inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
endif
