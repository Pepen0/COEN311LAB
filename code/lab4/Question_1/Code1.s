@ Ted Obuchowicz 
@ May 29, 2023 
@ simple_loop.s 
@ adds a list of 5 numbers stored in memory

.syntax unified 
.cpu cortex-m4 
.thumb

.word 0x20000400 
.word 0x800000ed 
.space 0xe4

.data 
@ declare your data here 
num:   .byte  1,2,3,4,5 @ declare 5 bytes of data starting                         
                        @ at address  num 
sum:   .space 0x01      @ reserve 1 byte of RAM  without                         
                        @any initialization 

.text 
start: 
mov r0, #0   @ r0 used to hold running sum, clear it to zero 
ldr r1, =num @ load starting address of num into r1 
mov r2, #5   @ r2 used as a counter to keep track of how              
             @ many numbers from the list have been added up

@ we make use of register indirect addressing and conditional jumps 
@ to setup a loop to add up the 5 numbers

top:    ldrb r3, [r1]   @ get number from memory, store in r3      
        add r0, r0, r3  @ sum = sum + number from list
        add r1, r1, #1  @ make r1 point to the next number in the list
        sub r2, r2, #1  @ decrement the loop counter      
        cmp r2, #0      @ check to if end of list
        bne top         @ branch to top of loop if not at end of list
        ldr r1, =sum    @ load r1 with address of sum and store                      
                        @ the sum into memory      
        strb r0, [r1]

stop:   b stop 
.end
