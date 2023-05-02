" -----
" Custom options
" -----

" use system clipboard
set clipboard=unnamed

" -----
" Custom keybinds
" -----

" Define space as somewhat leader key
unmap <Space>

" Better end and start movements
nmap H ^
nmap L $

" Navigate visual lines rather than logical ones
nmap j gj
nmap k gk


" -----
" Implementation of default keybinds
" -----

" gt and gT
exmap nextTab obcommand workspace:next-tab
exmap prevTab obcommand workspace:previous-tab
nmap gt :nextTab
nmap gT :prevTab

" Emulate folds
exmap unfoldall obcommand editor:unfold-all
exmap togglefold obcommand editor:toggle-fold
exmap foldall obcommand editor:fold-all
exmap foldless obcommand editor:fold-less
exmap foldmore obcommand editor:fold-more
nmap zo :togglefold
nmap zc :togglefold
nmap za :togglefold
nmap zm :foldmore
nmap zM :foldall
nmap zr :foldless
nmap zR :unfoldall

" Spell check
exmap contextMenu obcommand editor:context-menu
nmap z= :contextMenu
vmap z= :contextMenu

" Close buffer
exmap wq obcommand workspace:close
exmap q obcommand workspace:close

" Open links
exmap openLink obcommand editor:follow-link
nmap gx :openLink

" -----
" Telescope stuff
" -----

" Command palette
exmap teleScope obcommand command-palette:open
map <Space>tl :teleScope

" Colorscheme changer
exmap changeColor obcommand theme:switch 
map <Space>cl :changeColor

" Find files
exmap findFiles obcommand global-search:open
map <Space>ff :findFiles

" -----
" Toggle Stuff
" -----

" Toggle view 
exmap togglePreview obcommand editor:toggle-source
map <Space>pv :togglePreview

" editor:toggle-bold
" editor:toggle-italics
" editor:toggle-strikethrough
" editor:toggle-code
" editor:toggle-blockquote
" editor:toggle-checklist-status

" -----
" Misc
" -----

" Edit note title
exmap editTitle obcommand workspace:edit-file-title
map <Space>et :editTitle

" Insert current date or time
exmap insDate obcommand insert-current-date
exmap insTime obcommand insert-current-time
map <Space>dt :insDate

" Insert a callout
exmap insCall obcommand editor:insert-callout
map <Space>cl :insCall
