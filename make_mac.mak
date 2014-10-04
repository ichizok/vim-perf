# for Mac.

TARGET=autoload/vimperf.so
SRC=autoload/perf.c
ARCHS=
CFLAGS=-O2 -W -Wall -Wno-unused -Wno-unused-parameter -bundle -fPIC $(foreach ARCH,$(ARCHS),-arch $(ARCH))
LDFLAGS=

all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRC) $(LDFLAGS)

.PHONY : clean
clean:
	-rm -f $(TARGET)
