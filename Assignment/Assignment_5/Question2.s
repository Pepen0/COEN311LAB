// Assignment number 5      
// CPU architectures       
// Penoelo Thibeaud, student id: 40212017

//Write a complete ARM assembly program to implement bubble sort algorithm of sorting a list of 
//n words stored consecutively in memory locations starting from ARRAY. 
//The program should include writing a subroutine bubble_sort whose input parameters 
//(n, ARRAY) are passed from the main program using the stack. 
//Use the bubble_sort algorithm given below:
//for(i = n-1; i > 0; i--) {
//  for(j = 1; j <= i; j++) {
//if(array[j-1] > array[j]){     //swap them    temp = array[j-1];    array[j-1] = array[j];    array[j] = temp; }
//  } }
//in arm assembly language

.syntax unified
.cpu cortex-m4
.thumb
.word 0x20000400 
.word 0x800000ed 
.space 0xe4 

.data
array: 
.word 0x00000001
.word 0x00000002
.word 0x00000003
.word 0x00000004
.word 0x00000005
.word 0x00000006
.word 0x00000007
.word 0x00000008
.word 0x00000009
.word 0x0000000a

.text
start:
    ldr r0, =array  
    mov r1, #10     
    bl bubble_sort  
    b .            

bubble_sort:
    push {r4-r7, lr} 

    mov r4, r0       
    mov r5, r1        

outer_loop:
    mov r6, #0       

inner_loop:
    cmp r6, r5        
    bge outer_loop_end

    // Load current and next elements
    ldr r0, [r4, r6, lsl #2]
    ldr r1, [r4, r6, lsl #2]!

    // Compare and swap if needed
    cmp r0, r1
    blt no_swap
    str r1, [r4, r6, lsl #2]
    sub r4, r4, #4
    str r0, [r4, r6, lsl #2]
    add r4, r4, #4

no_swap:
    add r6, r6, #1     
    b inner_loop     

outer_loop_end:
    sub r5, r5, #1     
    cmp r5, #0
    bgt outer_loop    

    pop {r4-r7, pc}   
