.syntax unified
.cpu cortex-m4
.thumb

.data
message: .ascii "juMping JAck flaSh #1"
lastchar: .byte 0  @ NULL since last char would be a byte full of 0

.text
.global start
start:
    ldr r0, =message  @ Load the address of the message into r0 -> for(i in message) array[i]=message[i]

convert_loop:
    ldrb r1, [r0]         @ x=array[i]
    cmp r1, #0            @ if(x==0)
    beq end_conversion    @     goto end_conversion -> end loop

    cmp r1, #'a'          @ if(x<'a')
    blt next_char         @ goto next_char ->skip itteration
    cmp r1, #'z'          @ if (x>'z')
    bgt next_char         @ goto next_char ->skip itteration

    sub r1, r1, #32       @ x=x-32
    strb r1, [r0]         @ array[i]=x

next_char:
    add r0, r0, #1        @ i++
    b convert_loop        @ repeat loop

end_conversion:
    b end_conversion      @ End of the program, enter an infinite loop

.end
