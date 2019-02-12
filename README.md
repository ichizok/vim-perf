# Vim performance profiler, powered by gperftools

You can use gperftools via Vim script in order to profile Vim.

## Requirements

* [gperftools](https://github.com/gperftools/gperftools)
* Vim; built with `WE_ARE_PROFILING` macro

If you'd like to use heap profiler, you have to link libtcmalloc to Vim before starting.

On Linux, you can use `LD_PRELOAD`.

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

" start cpu profiling
call vimperf#start("/path/to/result.out")

" or heap profiling
call vimperf#start("/path/to/result", "heap")

" ... profiling area ...

" stop profiling
call vimperf#stop()

" unload vim-perf library
call vimperf#finish()
```

