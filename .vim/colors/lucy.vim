" -----------------------------------------------------------------------------
" Personal psychedellic color scheme
" -----------------------------------------------------------------------------

set background=dark

highlight clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "lucy"

" Magenta
hi Boolean ctermfg=197
hi Number ctermfg=197
hi Float ctermfg=197
hi Exception ctermfg=197

" Whites
hi Normal ctermfg=252
hi Comment ctermfg=245 cterm=italic
hi Question ctermfg=245
hi CursorLine ctermbg=235 cterm=none
hi VertSplit ctermfg=238 ctermbg=238
hi ColorColumn ctermbg=235
hi Character ctermfg=15

" Pink
hi Function ctermfg=128
hi Conditional ctermfg=128
hi Identifier ctermfg=128 cterm=none
hi Operator ctermfg=128
hi NonText ctermfg=128
hi Directory ctermfg=128 cterm=none
hi Keyword ctermfg=128
hi Statement ctermfg=128 cterm=none
hi Define ctermfg=128 cterm=bold
hi Label ctermfg=128
hi Special ctermfg=128

" Orange
hi ModeMsg ctermfg=202 cterm=bold
hi String ctermfg=202
hi LineNr ctermfg=202 ctermbg=233
hi CursorLineNr ctermfg=233 ctermbg=202 cterm=bold

" Green
hi Constant ctermfg=40
hi Type ctermfg=40 cterm=italic
hi Constant ctermfg=40
hi Type ctermfg=40 cterm=italic
hi Folded ctermfg=40 ctermbg=235
hi Delimiter ctermfg=40
hi StorageClass ctermfg=40

" Blue
hi Tag ctermfg=45
hi Typedef ctermfg=45
hi PreProc ctermfg=45 cterm=italic
hi Title ctermfg=45
hi Underlined ctermfg=45

" Not set yet
hi Debug ctermfg=226
hi DiffAdd ctermfg=226
hi DiffChange ctermfg=226
hi DiffDelete ctermfg=226
hi DiffText ctermfg=226
hi ErrorMsg ctermfg=226
hi FoldColumn ctermfg=226
hi IncSearch ctermfg=226
hi Macro ctermfg=226
hi MoreMsg ctermfg=226
hi PreCondit ctermfg=226
hi Repeat ctermfg=226
hi Search ctermfg=226
hi SpecialChar ctermfg=226
hi SpecialComment ctermfg=226
hi SpecialKey ctermfg=226
hi StatusLine ctermfg=226
hi StatusLineNC ctermfg=226
hi Structure ctermfg=226
hi Todo ctermfg=226
hi VisualNOS ctermfg=226
hi WarningMsg ctermfg=226
hi WildMenu ctermfg=226
