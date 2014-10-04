let s:vimperf_dllpath = expand('<sfile>:p:r') . '.so'

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

function! vimperf#start(profout)
  call s:libcall('profile_start', a:profout)
endfunction

function! vimperf#stop()
  call s:libcall('profile_stop')
endfunction
