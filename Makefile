BUILDDIR=build
BUILD_BIN_DIR=build/bin

.SILENT:

default:
	rm -f $(BUILD_BIN_DIR)/dec_to_bin
	mkdir -p $(BUILDDIR)
	mkdir -p $(BUILD_BIN_DIR)

	riscv64-linux-gnu-as -g atoi.s -o $(BUILDDIR)/atoi.o
	riscv64-linux-gnu-as -g butil.s -o $(BUILDDIR)/butil.o
	riscv64-linux-gnu-as -g dec_to_bin.s -o $(BUILDDIR)/dec_to_bin.o

	riscv64-linux-gnu-gcc -o $(BUILD_BIN_DIR)/dec_to_bin \
		$(BUILDDIR)/atoi.o \
		$(BUILDDIR)/butil.o \
		$(BUILDDIR)/dec_to_bin.o \
		-nostdlib -static -g -ggdb

.PHONY: clean
clean:
	rm -fr $(BUILDDIR)
	echo "All cleared"

