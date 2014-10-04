# for Mac.

TARGET=autoload/vimperf.so
SRC=autoload/perf.c
ARCHS=
CPPFLAGS=-I/usr/local/include
CFLAGS=-O2 -W -Wall -Wno-unused -Wno-unused-parameter -bundle -fPIC $(foreach ARCH,$(ARCHS),-arch $(ARCH))
LDFLAGS=-L/usr/local/lib -lprofiler

all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $(TARGET) $(SRC) $(LDFLAGS)

.PHONY : clean
clean:
	-rm -f $(TARGET)
