" Enable clipboard support
set clipboard=unnamedplus

" Fallback if clipboard doesn't work
if has('clipboard')
    set clipboard=unnamedplus
else
    " Use xclip as fallback
    vnoremap <C-c> :w !xclip -selection clipboard<CR><CR>
    nnoremap <C-v> :r !xclip -selection clipboard -o<CR>
endif
