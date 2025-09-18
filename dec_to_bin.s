.section .bss
  .equ BUFSZ, 32

  user_input:
    .skip BUFSZ

.section .rodata
  prompt_string: .ascii "Decimal number: "
  result_string: .ascii "\nResult: "

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

    la a1, user_input
    li a2, BUFSZ
    ecall
  print_message:
    la a7, SYS_WRITE
    la a0, STDOUT
    
    la a1, result_string
    li a2, 9
    ecall
  print_message_output:
    la a7, SYS_WRITE
    la a0, STDOUT
    
    la a1, user_input
    li a2, BUFSZ
    ecall
  exit_ok:
    li   a7, 93           # SYS_exit
    li   a0, 0            # status = 0
    ecall

