             "('-. .-.               .-')    .-') _
            "( OO )  /              ( OO ). (  OO) )
  ",----.    ,--. ,--. .-'),-----. (_)---\_)/     '._
 "'  .-./-') |  | |  |( OO'  .-.  '/    _ | |'--...__)
 "|  |_( O- )|   .|  |/   |  | |  |\  :` `. '--.  .--'
 "|  | .--, \|       |\_) |  |\|  | '..`''.)   |  |
"(|  | '. (_/|  .-.  |  \ |  | |  |.-._)   \   |  |
 "|  '--'  | |  | |  |   `'  '-'  '\       /   |  |
  "`------'  `--' `--'     `-----'  `-----'    `--'
" Ghost Vim Theme
" Author: Benjamin Hinchley
" License: WTFPL
"
" Inspired by and based off of:
" * https://github.com/robertmeta/nofrils
" * https://github.com/pbrisbin/vim-colors-off


hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="ghost"


" Colors
let s:black         = { "gui": "#121212", "cterm": "233" }
let s:bright_black  = { "gui": "#222222", "cterm": "235" }
let s:white         = { "gui": "#c0c0c0", "cterm": "7"   }
let s:bright_white  = { "gui": "#e4e4e4", "cterm": "254" }
let s:gray          = { "gui": "#7d7d7d", "cterm": "243" }
let s:bright_gray   = { "gui": "#a3a3a3", "cterm": "248" }
let s:blue          = { "gui": "#0087ff", "cterm": "33"  }
let s:red           = { "gui": "#ff0000", "cterm": "196" }
let s:yellow        = { "gui": "#d7ff00", "cterm": "190" }
let s:green         = { "gui": "#00ff00", "cterm": "46"  }
let s:pink          = { "gui": "#ff00ff", "cterm": "201" }
let s:cyan          = { "gui": "#00ffff", "cterm": "51"  }


" https://github.com/noahfrederick/vim-hemisu/
function! s:h(group, style)
  execute "highlight" a:group
        \ "guifg="   (has_key(a:style, "fg")    ? a:style.fg.gui   : "NONE")
        \ "guibg="   (has_key(a:style, "bg")    ? a:style.bg.gui   : "NONE")
        \ "guisp="   (has_key(a:style, "sp")    ? a:style.sp.gui   : "NONE")
        \ "gui="     (has_key(a:style, "gui")   ? a:style.gui      : "NONE")
        \ "ctermfg=" (has_key(a:style, "fg")    ? a:style.fg.cterm : "NONE")
        \ "ctermbg=" (has_key(a:style, "bg")    ? a:style.bg.cterm : "NONE")
        \ "cterm="   (has_key(a:style, "cterm") ? a:style.cterm    : "NONE")
endfunction

" TODO: Clean up file

" General
call s:h("Normal", {"bg": s:black, "fg": s:white})
call s:h("Comment", {"fg": s:gray})

call s:h("Cursor", {"bg": s:white, "fg": s:black})
hi! link CursorIM Cursor
call s:h("CursorLine", {"bg": s:bright_white, "fg": s:black})
hi! link CursorLineNr CursorLine

call s:h("LineNr", {"bg": s:black, "fg": s:gray})
hi! link SignColumn LineNr

hi! link ColorColumn CursorLineNr
hi! link NonText Comment

hi StatusLineNC   term=NONE	cterm=NONE	ctermfg=white	ctermbg=240	gui=NONE	guifg=#333333	guibg=#585858
hi! link VertSplit Normal

call s:h("Error", {"bg": s:red, "fg": s:bright_white, "cterm": "bold", "gui": "bold"})
hi! link ErrorMsg Error
call s:h("WarningMsg", {"bg": s:red})

"hi ModeMsg		    term=NONE	cterm=NONE	ctermfg=69	ctermbg=NONE	gui=NONE	guifg=#5F87FF	guibg=NONE
"hi MoreMsg		    term=NONE	cterm=NONE	ctermfg=69	ctermbg=NONE	gui=NONE	guifg=#5F87FF	guibg=NONE
"hi Question		    term=NONE	cterm=NONE	ctermfg=69	ctermbg=NONE	gui=NONE	guifg=#5F87FF	guibg=NONE
call s:h("Search", {"bg": s:white, "fg": s:black})
hi! link StatusLine Search
call s:h("Todo", {"fg": s:bright_gray, "cterm": "bold", "gui": "bold"})
"hi VisualNOS		  term=NONE	cterm=NONE	ctermfg=NONE	ctermbg=69	gui=NONE	guifg=NONE	guibg=#5F87FF


call s:h("Visual", {"bg": s:bright_black, "fg": s:white})
hi! link MatchParen Visual
hi! link WildMenu Visual

call s:h("DiffChange", {"bg": s:blue})
call s:h("DiffDelete", {"bg": s:red})
hi! link DiffText Normal

"hi SpellBad		  term=underline	cterm=underline	ctermfg=129	ctermbg=NONE	gui=underline	guifg=#af00ff	guibg=NONE
"hi SpellCap		  term=underline	cterm=underline	ctermfg=129	ctermbg=NONE	gui=underline	guifg=#af00ff	guibg=NONE
"hi SpellLocal   term=underline	cterm=underline	ctermfg=129	ctermbg=NONE	gui=underline	guifg=#af00ff	guibg=NONE
"hi SpellRare	  term=underline	cterm=underline	ctermfg=129	ctermbg=NONE	gui=underline	guifg=#af00ff	guibg=NONE

hi! link Menu Normal
call s:h("Pmenu", {"cterm": "reverse", "gui": "reverse"})
call s:h("PmenuSel", {"bg": s:gray, "fg": s:white})

hi! link TabLine      Normal
hi! link TabLineFill  Normal
hi! link TabLineSel   Normal

hi! link Tooltip Normal


" Syntax
hi! link Boolean          Normal
hi! link Character        Normal
hi! link Conceal          Normal
hi! link Conditional      Normal
hi! link Constant         Normal
hi! link Debug            Normal
hi! link Define           Normal
hi! link Delimiter        Normal
hi! link Directive        Normal
hi! link Exception        Normal
hi! link Float            Normal
hi! link Format           Normal
hi! link Function         Normal
hi! link Identifier       Normal
hi! link Ignore           Normal
hi! link Include          Normal
hi! link Keyword          Normal
hi! link Label            Normal
hi! link Macro            Normal
hi! link Number           Normal
hi! link Operator         Normal
hi! link PreCondit        Normal
hi! link PreProc          Normal
hi! link Repeat           Normal
hi! link SpecialChar      Normal
hi! link SpecialComment   Normal
hi! link Special          Normal
hi! link Statement        Normal
hi! link StorageClass     Normal
hi! link String           Normal
hi! link Structure        Normal
hi! link Tag              Normal
hi! link Title            Normal
hi! link Typedef          Normal
hi! link Type             Normal
hi! link Underlined       Normal


" git-gutter
hi link GitGutterAdd            LineNr
hi link GitGutterDelete         LineNr
hi link GitGutterChange         LineNr
hi link GitGutterChangeDelete   LineNr
