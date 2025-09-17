.SILENT:
default:
	rm -f ./dec_to_bin

	# riscv64-linux-gnu-as hello.s -o hello.o
	# riscv64-linux-gnu-gcc -o hello hello.o -nostdlib -static -g -ggdb

	# riscv64-linux-gnu-gcc -ggdb -static -o sum sum.c

	riscv64-linux-gnu-as tf.s -o tf.o
	riscv64-linux-gnu-gcc -o tf tf.o -nostdlib -static -g -ggdb

	riscv64-linux-gnu-as dec_to_bin.s -o dec_to_bin.o
	riscv64-linux-gnu-gcc -o dec_to_bin dec_to_bin.o -nostdlib -static -g -ggdb

	rm -f ./dec_to_bin.o
