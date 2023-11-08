.syntax unified
.cpu cortex-m4
.thumb

.data
message: .ascii "juMping JAck flaSh #1"
lastchar: .byte 0  ; This represents the NULL character to indicate the end of the string

.text
.global start
start:
    ldr r0, =message  ; Load the address of the message into r0

convert_loop:
    ldrb r1, [r0]         ; Load the current byte
    cmp r1, #0            ; Compare the current byte to NULL
    beq end_conversion    ; If byte is NULL, we've reached the end

    cmp r1, #'a'          ; Compare with 'a' to find the lower bound
    blt next_char         ; If less, it is not a lowercase letter
    cmp r1, #'z'          ; Compare with 'z' to check the upper bound
    bgt next_char         ; If greater, it is not a lowercase letter

    sub r1, r1, #32       ; Convert to uppercase by subtracting 32
    strb r1, [r0]         ; Store back the converted character

next_char:
    add r0, r0, #1        ; Increment the pointer to the next character
    b convert_loop        ; Continue the loop

end_conversion:
    b end_conversion      ; End of the program, enter an infinite loop

.end
