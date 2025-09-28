.section .bss
  .equ DECSZ, 1024
  decimal: .skip DECSZ

.section .rodata
  prompt_string: .ascii "Decimal number: "

.section .text
  .equ SYS_WRITE, 64
  .equ SYS_READ, 63
  .equ SYS_EXIT, 93
  .equ STDOUT, 1
  .equ STDIN, 0

  .global _start
  _start:
    la a7, SYS_WRITE
    la a0, STDOUT

    la a1, prompt_string
    li a2, 16
    ecall
  get_decimal:
    la a7, SYS_READ
    la a0, STDIN

    la a1, decimal
    li a2, DECSZ
    ecall
  convert_ascii_to_decimal:
    la a0, decimal
    call atoi
  convert_number_to_binary:
    mv t0, a0 # decimal number
    li t1, 0  # LSB value

    li t2, 1 # for sub, decreased by 1
    li t3, 7 # index current number
    .loop:
      srl t1, t0, t3 # decimal num >> index number
      andi t1, t1, 1 # bit mask 1 to get the LSB value

      addi sp, sp, -16
      sd t0, 0(sp)
      sd t1, 8(sp)

      mv a0, t1
      call butil

      ld t0, 0(sp)
      ld t1, 8(sp)
      addi sp, sp, 16

      # buf[count]
      addi sp, sp, -8
      sd a0, 0(sp)

      la a7, SYS_WRITE
      la a0, STDOUT
      addi a1, sp, 0
      addi sp, sp, 8
      li a2, 1
      ecall
      
      sub t3, t3, t2 # t3--
      bgez t3, .loop
  exit_ok:
    li   a7, 93           # SYS_exit
    li   a0, 0            # status = 0
    ecall

