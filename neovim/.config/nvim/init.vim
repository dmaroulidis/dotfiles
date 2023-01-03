" BASIC SETUP
" enter the current millenium
set nocompatible

" enable syntax and plugins (for netrw)
syntax on
filetype plugin on

" Other
set number relativenumber
set encoding=utf-8

" Set keymap and language related options
set keymap=greek_utf-8
" Don't use lmap by default
set iminsert=0
set imsearch=-1

" Set smartindent and autoindent
set smartindent

" FINDING FILES:

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

set wildmode=longest,list,full

set splitbelow splitright

" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy

" THINGS TO CONSIDER:
" - :b lets you autocomplete any open buffer

" TAG JUMPING:

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .

" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" FILE BROWSING:

" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" NOW WE CAN:
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings

" KEYBOARD SHORTCUTS:
noremap <silent> <C-S>    :update<CR>
vnoremap <silent> <C-S>   <C-C>:update<CR>
inoremap <silent> <C-S>   <C-O>:update<CR>

noremap <C-X>             :xit<CR>
vnoremap <C-X>            <C-C>:xit<CR>
inoremap <C-X>            <C-O>:xit<CR>
" map t to enable text writing options (spell, textwidth)
noremap \	:set textwidth=70<CR>:set spelllang=el,en<CR>:set spell<CR>
" run current line as shell command
noremap Q	!!bash<CR>
