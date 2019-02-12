let s:vimperf_dllpath = expand('<sfile>:p:h:h') . '/lib/vimperf.so'

if !filereadable(s:vimperf_dllpath)
  echoerr 'You must build vimperf.so'
  finish
endif

function! s:libcall(func, ...)
  let result = libcall(s:vimperf_dllpath, a:func, get(a:000, 0, ''))
  if result !=# ''
    throw result
  endif
endfunction

function! vimperf#setup()
  call s:libcall('profile_setup', s:vimperf_dllpath)
endfunction

function! vimperf#finish()
  call s:libcall('profile_finish')
endfunction

function! s:check_type(type)
  if a:type !~# '^\%\(cpu\|heap\)$'
    echoerr printf('Invalid type: "%s"', a:type)
    echomsg 'You can specify "cpu" or "heap"'
    return 0
  endif
  return 1
endfunction

function! vimperf#start(profout, ...)
  let type = get(a:000, 0, 'cpu')
  if s:check_type(type)
    call s:libcall('profile_start', type[0] . ':' . a:profout)
  endif
endfunction

function! vimperf#stop(...)
  let type = get(a:000, 0, '')
  if !type || s:check_type(type)
    call s:libcall('profile_stop', type)
  endif
endfunction
