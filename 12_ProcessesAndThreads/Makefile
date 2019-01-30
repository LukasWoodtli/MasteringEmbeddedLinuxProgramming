CC      = gcc
CCFLAGS = -lrt -lpthread


SOURCES := $(wildcard *.c)
TARGETS := $(patsubst %.c, %, $(SOURCES))

BUILDDIR = build

all: $(TARGETS)

$(TARGETS): %: %.c
	mkdir -p $(BUILDDIR)
	$(CC) $< -o $(BUILDDIR)/$@ $(CCFLAGS)

clean:
	rm -rf *.o $(TARGETS) $(BUILDDIR)


test:$(TARGETS)
	./$(BUILDDIR)/1_fork
