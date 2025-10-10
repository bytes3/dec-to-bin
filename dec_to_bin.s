.macro push, reg
  addi sp, sp, -8
  sd \reg, 0(sp)
.endm

.macro pop, reg
  ld \reg, 0(sp)
  addi sp, sp, 8
.endm

# ----------------------------------
.section .bss
  .equ DECSZ, 1024
  decimal: .skip DECSZ

.section .rodata
  prompt_string: .asciz "Decimal number: "
    promnt_len = . - prompt_string - 1

.section .text
  .equ SYS_WRITE, 64
  .equ SYS_READ, 63
  .equ SYS_EXIT, 93
  .equ STDOUT, 1
  .equ STDIN, 0

  .global _start
  _start:
    .option push
    .option norelax
      la gp, __global_pointer$
    .option pop

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
    mv t0, a0             # decimal number
    li t1, 0              # LSB value

    li t3, 63             # index current number
    li t4, -1
    li a1, 0
    .loop:
      srl t1, t0, t3      # decimal num >> index number
      andi t1, t1, 1      # bit mask 1 to get the LSB value

      mv a0, t1
      call butil

      blez a1, .loop_again

      # fixme: print the LSB after t0 = 0 index
      push a1
      call .print_number
      pop a1

      bge t3, t4, .loop_again

  .loop_again:
    addi t3, t3, -1    # t3--
    ble t3, t4, exit_ok
    j .loop

  .print_number:
    # buf[count]
    push a0

    la a7, SYS_WRITE
    la a0, STDOUT
    mv a1, sp

    li a2, 1
    ecall
    pop a0
    ret

  exit_ok:
    li   a7, 93   # SYS_exit
    li   a0, 0    # status = 0
    ecall

