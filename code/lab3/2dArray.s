.syntax unified
.cpu cortex-m4
.thumb

.global start
.data
.word 0x20000400  
.word 0x800000ed  
.space 0xe4       

array: .byte 3,2,4,1,5,6  @ 2D array with 3 rows and 2 columns.

.text
start:
    ldr r0, =array          @ initialise array.
    mov r5, #0              @ loop counter = 0.

loop:
   
    add r1, r5, #0          @ Row index
    mov r2, #0              @ Column index
    mov r6, #2              @ Move the multiplier into a register

    @ Calculate ((row_index * number_of_columns) + column_index)
    mul r3, r1, r6          @ r3 = row_index * 2 (since we have 2 columns per row).
    add r3, r3, r2          @ r3 = offset from the start of the array 

    @ Access the element using register indirect with offset addressing mode.

    ldrb r4, [r0, r3]       @ r4= array[r1][r2] - looks for the byte at the offset
    
    
    @ Increment the loop counter and check if we've done 3 iterations.
    add r5, r5, #1
    cmp r5, #3
    blt loop                @ loop if r5 is lower than 3

    b .                     @ infinite loop
