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
    call print_prompt
    
    # get decimal from the user
    la a7, SYS_READ
    la a0, STDIN
    la a1, user_input

    li a2, BUFSZ
    ecall
    blez a0, exit_ok     # if a0 <= 0, exit

    call print_output_number_p1
    call print_output_number_p2
    call exit_ok

  print_prompt:
    la a7, SYS_WRITE
    la a0, STDOUT

    la a1, prompt_string
    li a2, 16
    ecall
    ret

  print_output_number_p1:
    la a7, SYS_WRITE
    la a0, STDOUT
    
    la a1, result_string
    li a2, 9
    ecall
    ret

  print_output_number_p2:
    la a7, SYS_WRITE
    la a0, STDOUT
    
    la a1, user_input
    li a2, BUFSZ
    ecall
    ret

  exit_ok:
    li   a7, 93           # SYS_exit
    li   a0, 0            # status = 0
    ecall
