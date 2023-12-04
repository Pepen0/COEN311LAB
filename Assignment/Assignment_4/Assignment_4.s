// Assignment number 4, week 8      
// Penoelo Thibeaud 40212017
// Anjali Agarwal, student id: 123456

// Question 3

.syntax unified
.cpu cortex-m4
.thumb

.global start
.data
Array1: .byte 'h', 'e', 'l', 'l', 'o', 0  
Array2: .space 6                         

.text
start:
    ldr r0, =Array1  
    ldr r1, =Array2 
    mov r5, #0      

loop:
    ldrb r2, [r0, r5]  
    strb r2, [r1, r5]  
    
    cmp r2, #0         
    beq end        
    
    add r5, r5, #1     
    b loop         

end:
    b .                


// Question 4

//A.

.syntax unified
.cpu cortex-m4
.thumb

.global start
.text

start:
    CMP R0, R1
    BEQ end  

loop:
    CMP R0, R1
    BGT sub_a      
    BLT sub_b      

sub_a:
    SUB R0, R0, R1 
    B loop     

sub_b:
    SUB R1, R1, R0 
    B loop  

end:
    b end        


//B.

.syntax unified
.cpu cortex-m4
.thumb

.global start
.text

start:
    CMP R0, R1
    beq end    

loop:
    CMP R0, R1
    subgt R0, R0, R1 
    sublt R1, R1, R0 
    bne loop     

end:
    b end       


// Question 5

.syntax unified
.cpu cortex-m4
.thumb

.global start
.data
FOUND: .word 0x00000000 

.text
start:
    ldr r0, =0xA000      
    ldr r1, =0xB000     
    mov r3, #100        
    ldr r2, =FOUND      

loop:
    ldrb r4, [r0], #1   
    ldrb r5, [r1], #1  
    cmp r4, r5          
    bne unequal      
    subs r3, r3, #1      
    bne loop    

    
    mov r4, #0
    str r4, [r2]
    b end        

unequal:
    
    sub r0, r0, #1       
    str r0, [r2]    

end:
    b end           
