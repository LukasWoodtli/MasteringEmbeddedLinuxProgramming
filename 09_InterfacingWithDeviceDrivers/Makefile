THIS_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

LINUXDIR := $(THIS_DIR)/../04_Kernel/linux-stable/

# The `obj-m := dummy.o` code will invoke the kernel build rule to take the
# source file, `dummy.c`, and create kernel module, `dummy.ko`.
obj-m := dummy.o

all:
	make ARCH=arm CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf- -C $(LINUXDIR) M=$(shell pwd)

clean:
	make -C $(LINUXDIR) M=$(shell pwd) clean
