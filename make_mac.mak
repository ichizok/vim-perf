# for Mac.

TARGET = lib/vimperf.so
SRC = src/perf.c
ARCHS =
CPPFLAGS = -I/usr/local/include
CFLAGS = -O2 -W -Wall -Wno-unused -Wno-unused-parameter -bundle -fPIC $(foreach ARCH,$(ARCHS),-arch $(ARCH))
LDFLAGS = -L/usr/local/lib -lprofiler -ltcmalloc

all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $(TARGET) $(SRC) $(LDFLAGS)

.PHONY : clean
clean:
	-rm -f $(TARGET)
