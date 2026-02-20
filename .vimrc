" " Определение операционной системы
" if has('win16') || has('win32') || has('win64') || has('win95')
"     let os = 'windows'
" endif

:set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

" Count of lines between cursor and edge of the window
set scrolloff=7

" Стирать символы на backspace
set backspace=indent,eol,start
" Показывать текущую команду
set showcmd
" Возможность использовать мышь
set mouse=a
" Нумерация строк
set nu
set relativenumber
" Регистро-независимый поиск по умолчанию
set ignorecase
" Изменять поиск по мере печатания
set incsearch
" Включить режим вставки как в терминале
" Выключено, т.к. мешает автоматическим отступам
" set paste

" Настройка отступов
set shiftwidth=4
set smarttab
set smartindent
set expandtab

" Подсветка синтаксиса
syntax on
" Тип переноса
set ffs=unix,dos,mac
" Подсветка результатов поиска
set hls 
" Тёмный фон по умолчанию, для нормального отображения заднего фона в tmux
set bg=dark

" Кодировка
set fileencoding=utf-8
" На Windows с такой кодировкой появляются кракозябры при исполнении внешних 
" команд
set encoding=utf-8
" Чтобы этого не было, расскоментируйте строчку ниже
" set encoding=cp866

" Линия на 80 столбце
set colorcolumn=80

" Линия на 80 символах во всех .py файлах
" autocmd BufNewFile,BufRead *.py set colorcolumn=80 | highlight ColorColumn ctermbg=gray

" Линия на 120 столбце для java файлов
augroup java
    autocmd!
    autocmd BufNewFile,BufRead *.java set colorcolumn=120
augroup END

augroup cmd
    " Убираем линию в терминале, а также нумерацию
    execute printf("autocmd %s * setlocal colorcolumn= | setlocal nonu nornu", has('nvim') ? 'TermOpen' : 'TerminalOpen')
augroup END

" Форматирование
" set equalprg=clang-format\ -style=\"{BasedOnStyle:\ llvm,\ IndentWidth:\ 4}\"
" set equalprg=clang-format

" Показывать строку и столбец
set ruler

" Автоматически менять директорию на директорию файла
" set autochdir

" Уродливое форматирование для курса C++, LLVM и FP
augroup itmoformat
    autocmd!
    autocmd BufNewFile,BufRead ~/Documents/itmo/cpp/*.{h,cpp} setlocal shiftwidth=2
    autocmd BufNewFile,BufRead /Volumes/KINGSTON/projects/llvm-course-2/* setlocal shiftwidth=2
    autocmd BufNewFile,BufRead ~/Documents/itmo/llvm/*.{h,cpp,c} setlocal shiftwidth=2
    autocmd BufNewFile,BufRead ~/Documents/itmo/fp/*.{hs} setlocal shiftwidth=2
augroup END

augroup dbms
  autocmd!
  autocmd BufRead,BufNewFile ~/Documents/itmo/dbms/hw7/* set filetype=sql
augroup END

" This is default for clang-format
augroup cppformat
    autocmd!
    autocmd BufNewFile,BufRead *.{h,cpp} setlocal shiftwidth=2
augroup END


function SetupGo()
    setlocal noexpandtab
    setlocal tabstop=4
endfunction

" Уродливое форматирование для Go
augroup goformat
    autocmd!
    autocmd FileType go call SetupGo()
augroup END

if executable("zsh")
    set shell=zsh
endif

" CamelCaseMotion https://github.com/bkad/CamelCaseMotion

" Прыжки (w, b, e) по словам в camelCase и snake_case
" Сохраняем старые сочетания, добавив к ним <leader>
" noremap <leader>w w
" noremap <leader>b b
" noremap <leader>e e
" noremap <leader>ge ge

" Следующие сочетания работают плохо
" onoremap <leader>iw iw
" xnoremap <leader>iw iw  
" onoremap <leader>ib ib  
" xnoremap <leader>ib ib 
" onoremap <leader>ie ie 
" xnoremap <leader>ie ie 

" Заменяем стандартные сочетания (это неудобно, вариант лучше ниже)
" map <silent> w <Plug>CamelCaseMotion_w
" map <silent> b <Plug>CamelCaseMotion_b
" map <silent> e <Plug>CamelCaseMotion_e
" map <silent> ge <Plug>CamelCaseMotion_ge
" sunmap w
" sunmap b
" sunmap e
" sunmap ge

" omap <silent> iw <Plug>CamelCaseMotion_iw
" xmap <silent> iw <Plug>CamelCaseMotion_iw
" omap <silent> ib <Plug>CamelCaseMotion_ib
" xmap <silent> ib <Plug>CamelCaseMotion_ib
" omap <silent> ie <Plug>CamelCaseMotion_ie
" xmap <silent> ie <Plug>CamelCaseMotion_ie

" Текущий вариант
let g:camelcasemotion_key = '<leader>'

au FileType qf setlocal nonumber norelativenumber colorcolumn=

augroup opencl
  au!
  autocmd BufNewFile,BufRead *.cl   set syntax=c
augroup END

autocmd BufNewFile,BufRead *.ll :set filetype=llvm

if !has('nvim')
set termencoding=utf-8
if executable("ranger")
    function! RangeChooser()
        let temp = tempname()
        " The option "--choosefiles" was added in ranger 1.5.1. Use the next line
        " with ranger 1.4.2 through 1.5.0 instead.
        "exec 'silent !ranger --choosefile=' . shellescape(temp)
        if has("gui_running")
            exec 'silent !xterm -e ranger --choosefiles=' . shellescape(temp)
        else
            exec 'silent !ranger --choosefiles=' . shellescape(temp)
        endif
        if !filereadable(temp)
            redraw!
            " Nothing to read.
            return
        endif
        let names = readfile(temp)
        if empty(names)
            redraw!
            " Nothing to open.
            return
        endif
        " Edit the first item.
        exec 'edit ' . fnameescape(names[0])
        " Add any remaning items to the arg list/buffer list.
        for name in names[1:]
            exec 'argadd ' . fnameescape(name)
        endfor
        redraw!
    endfunction
    command! -bar RangerChooser call RangeChooser()
    nnoremap <leader>r :<C-U>RangerChooser<CR>
endif

call plug#begin()
  Plug 'prabirshrestha/vim-lsp'
  Plug 'puremourning/vimspector'
" Plug 'bkad/CamelCaseMotion'
call plug#end()

let g:lsp_diagnostics_virtual_text_align="right"
let g:lsp_diagnostics_virtual_text_wrap="truncate"
let g:lsp_diagnostics_echo_cursor=1

let g:vimspector_enable_mappings = 'HUMAN'

let g:lsp_semantic_enabled = 1

" Change highlight of symbol under cursor
hi link lspReference PmenuSbar

if executable('clangd')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'allowlist': ['cpp'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

endif
