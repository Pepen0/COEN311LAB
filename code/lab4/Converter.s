.syntax unified
.cpu cortex-m4
.thumb

.word 0x20000400 
.word 0x800000ed 
.space 0xe4

.data
array: .byte 'j','A','c','K' ,' ', 'f', 'L', 'a', 'S', 'h','#', '1', 0

.text
start:
    ldr r0, =array  @ Load array into r0

    ldrb r2, [r0]       @ Load the current byte
    cmp r2, #0          @if (arrray[i]=="\0")
    beq the_end         @       goto the_end;

    cmp r2, #'a'        @ if(array[i]<'a')
    blt next_char       @       goto next_char;
    cmp r2, #'z'        @ if(array[i]>'z')
    bgt next_char       @       goto next_char;

    sub r2, r2, #32     @ array[i]= array[i]-32;

    strb r2, [r0]   @ Save the new value at r0

next_char:
    add r0, r0, #1      @ i++;
    b start             @ goto start

the_end: b the_end             @ Infinite loop to stop execution

.end
