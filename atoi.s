.data
my_string: .ascii "13345\0"  # Input string with null terminator

.text
.global _start
_start:
    # Load address of the string into a0
    la a0, my_string
    # Call the atoi_helper function
    call atoi_helper

    # Exit program (example)
    li   a7, 93
    li   a0, 0
    ecall

# Function to convert string to integer (atoi)
# Input: a0 = pointer to the null-terminated string
# Output: a1 = the resulting integer
atoi_helper:
    mv a1, zero       # Initialize result to 0
    li t0, '0'        # ASCII value of '0'
    li t1, 10         # Constant 10 for multiplication

.loop:
    lb t2, 0(a0)      # Load byte (character) from string
    beqz t2, .end_loop # If zero (null terminator), branch to end

    # Check if it's a digit
    blt t2, t0, .end_loop # If less than '0' string, not a digit

    # Convert ASCII digit to integer
    sub t3, t2, t0    # t3 = digit - '0'

    # Update result: result = (result * 10) + digit_value
    # Using mul:
    mul a1, a1, t1    # a1 = result * 10
    add a1, a1, t3    # a1 = (result * 10) + digit_value

    # Move to next character
    # Step to the next ascii memory position
    # EX: 70029 (1xxxx) -> 70030 (x3xxx), from my_string "13345"
    addi a0, a0, 1 

    j .loop           # Jump back to loop start

.end_loop:
    mv a0, a1
    ret
