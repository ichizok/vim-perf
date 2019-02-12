# for *nix platform.

TARGET = lib/vimperf.so
SRC = src/perf.c
CFLAGS = -W -O2 -Wall -Wno-unused -Wno-unused-parameter -std=gnu99 -pedantic -shared -fPIC
LDFLAGS = -lprofiler -ltcmalloc

all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRC) $(LDFLAGS)

clean:
	rm -f $(TARGET)
