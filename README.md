# Vim performance profiler, powered by gperftools

You can use gperftools via Vim script in order to profile Vim.

## Requirements

* [gperftools](https://code.google.com/p/gperftools/)
* Vim; built with `WE_ARE_PROFILING` macro

## Build Vim

Set `-DWE_ARE_PROFILING` to `CPPFLAGS`.

```
$ cd /path/to/vim
$ export CPPFLAGS=-DWE_ARE_PROFILING
$ ./configure --with-features=huge ...
$ make
```

## Build vim-perf library

```
$ cd /path/to/vim-perf
$ make
```

## Usage

```vim
set rtp+=/path/to/vim-perf

" load vim-perf library 
call vimperf#setup()

" start profiling
call vimperf#start("/path/to/result.out")

" ... profiling area ...

" stop profiling
call vimperf#stop()

" unload vim-perf library
call vimperf#finish()
```

