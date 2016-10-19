#include <dlfcn.h>
#include <gperftools/profiler.h>

#define UNUSED __attribute__((unused))

static void *handle;
static int profiling;

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
    if (profiling) {
        return "already started";
    }
    profiling = 1;
    ProfilerStart(args);
    return "";
}

char *profile_stop(char *args UNUSED)
{
    if (profiling) {
        ProfilerStop();
        ProfilerFlush();
        profiling = 0;
    }
    return "";
}
