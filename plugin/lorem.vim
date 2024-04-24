" lorem.vim - print to current buffer sample text

" don't load twice
if exists("g:loaded_lorem") || &cp || v:version < 700
  finish
endif
let g:loaded_lorem = 1

" Return a carriage-return delimited string of lorem filename's.
" Used for auto-completion
function! ListLorems(A,B,C)
  function! Trans(A)
    return "\"" . substitute(a:A,'.*lorems/\(.*\)$','\1','g') . "\""
  endfunction

  let l:lorems=split(globpath(&rtp, 'lorems/*'))
  let l:loremsShort=map(l:lorems, 'Trans(v:val)')
  return join(l:loremsShort,"\n")
endfunction

" main invocation function
function! InvokeLorem(type)
  let g:targetPath=globpath(&rtp, "**/lorems/".a:type)
  if g:targetPath == ''
    echom "lorem not found for ".a:type
  else
    let g:targetFile=split(g:targetPath, '\n')[0]
    execute "read".g:targetFile
    redraw
    echom "read ".g:targetFile
    :0d_
  endif
endfunction

command! -complete=custom,ListLorems -nargs=1 -bang Lorem
    \ :call InvokeLorem(<args>)

