setlocal regexpengine=2
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal textwidth=120
setlocal colorcolumn=121

" Fix files with prettier, and then ESLint.
" let b:ale_fixers = ['prettier']
" eslint is too slow!
let b:ale_fixers = ['prettier', 'eslint']
