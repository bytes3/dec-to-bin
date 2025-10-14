.SILENT:
default:
	rm -f ./dec_to_bin

	# riscv64-linux-gnu-as hello.s -o hello.o
	# riscv64-linux-gnu-gcc -o hello hello.o -nostdlib -static -g -ggdb

	# riscv64-linux-gnu-gcc -ggdb -static -o sum sum.c

	riscv64-linux-gnu-as -g atoi.s -o atoi.o
	riscv64-linux-gnu-as -g butil.s -o butil.o
	riscv64-linux-gnu-as -g dec_to_bin.s -o dec_to_bin.o

	riscv64-linux-gnu-gcc -o dec_to_bin atoi.o butil.o dec_to_bin.o -nostdlib -static -g -ggdb

	riscv64-linux-gnu-as -g chars_test.s -o chars_test.o
	riscv64-linux-gnu-gcc -o chars_test chars_test.o -nostdlib -static -g -ggdb

