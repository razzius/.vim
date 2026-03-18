" TODO make it clean up plugins not being used any more
function! Package(url)
  let name = split(a:url, '/')[-1]
  let target = $HOME . '/.vim/pack/vendor/opt/' . name

  if !isdirectory(target)
    silent execute '!git clone --depth=1 ' . a:url . ' ' . target
  endif

  execute 'packadd! ' . name
endfunction

command! -nargs=1 Package :call Package(<q-args>)
