#include <dlfcn.h>
#include <gperftools/profiler.h>
#include <gperftools/heap-profiler.h>

#define UNUSED __attribute__((unused))

static void *handle;
static struct {
    int cpu;
    int heap;
} profiling;

char *profile_setup(char *args)
{
    if (!handle) {
        handle = dlopen(args, RTLD_LAZY);
        return !handle ? dlerror() : "";
    }
    return "";
}

char *profile_finish(char *args UNUSED)
{
    if (handle) {
        dlclose(handle);
        handle = NULL;
    }
    return "";
}

char *profile_start(char *args)
{
    // format: 'x:name' (x == 'c' or 'h')
    const char *name = &args[2];

    switch (args[0]) {
    case 'c': // cpu profiling
        if (!profiling.cpu) {
            profiling.cpu = 1;
            ProfilerStart(name);
            return "";
        }
        break;
    case 'h': // heap profiling
        if (!profiling.heap) {
            profiling.heap = 1;
            HeapProfilerStart(name);
            return "";
        }
        break;
    default:
        return "invalid type";
    }
    return "already started";
}

char *profile_stop(char *args)
{
    int stop_cpu = 0;
    int stop_heap = 0;

    switch (args[0]) {
    case 'c': // cpu profiling
        stop_cpu = 1;
        break;
    case 'h': // heap profiling
        stop_heap = 1;
        break;
    default:
        stop_cpu = stop_heap = 1;
        break;
    }
    if (stop_cpu && profiling.cpu) {
        profiling.cpu = 0;
        ProfilerStop();
        ProfilerFlush();
    }
    if (stop_heap && profiling.heap) {
        profiling.heap = 0;
        HeapProfilerStop();
    }
    return "";
}
