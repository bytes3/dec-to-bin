.text
.global butil
butil:
    beqz a0, .zero
    bnez a0, .one

  .zero:
    li a0, '0'
    ret

  .one:
    li a0, '1'
    li a1, 1
    ret
