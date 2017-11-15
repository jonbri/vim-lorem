" lorum.vim - print to current buffer sample text

" don't load twice
if exists("g:loaded_lorum") || &cp || v:version < 700
  finish
endif
let g:loaded_lorum = 1

" Return a carriage-return delimited string of lorum filename's.
" Used for auto-completion
function! ListLorums(A,B,C)
  function! Trans(A)
    return "\"" . substitute(a:A,'.*lorums/\(.*\)$','\1','g') . "\""
  endfunction

  let l:lorums=split(globpath(&rtp, 'lorums/*'))
  let l:lorumsShort=map(l:lorums, 'Trans(v:val)')
  return join(l:lorumsShort,"\n")
endfunction

" main invocation function
function! InvokeLorum(type)
  let g:targetPath=globpath(&rtp, "**/lorums/".a:type)
  if g:targetPath == ''
    echom "lorum not found for ".a:type
  else
    let g:targetFile=split(g:targetPath, '\n')[0]
    execute "read".g:targetFile
    redraw
    echom "read ".g:targetFile
  endif
endfunction

command! -complete=custom,ListLorums -nargs=1 -bang Lorum
    \ :call InvokeLorum(<args>)

