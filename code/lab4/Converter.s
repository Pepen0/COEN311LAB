.syntax unified
.cpu cortex-m4
.thumb
.word 0x20000400 
.word 0x800000ed 
.space 0xe4 

.data
message: .ascii "juMping JAck flaSh #1"
lastchar: .byte 0  

.text
start:
    ldr r0, =message

convert_loop:
    ldrb r1, [r0]     
    cmp r1, #0          
    beq end_conversion   

    cmp r1, #'a'        
    blt next_char        
    cmp r1, #'z'       
    bgt next_char        

    sub r1, r1, #32   
    strb r1, [r0]        

next_char:
    add r0, r0, #1      
    b convert_loop        

end_conversion:
    b end_conversion      

