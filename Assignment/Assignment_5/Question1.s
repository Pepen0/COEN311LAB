// Assignment number 5      
// CPU architectures       
// Penoelo Thibeaud, student id: 40212017

//Question 1)
//Write a subroutine STRCAT to concatenate two strings. 
//The main program passes the addresses of both the strings by registers to the subroutine. 
//The second string is concatenated to the first string. 
//Note to reserve extra memory space after the first string to hold the resulting concatenated string. 
//The subroutine STRCAT is to be called twice by the main program. 
//in Arm assembly language

.syntax unified
.cpu cortex-m4
.thumb

.data
str1: .asciz "Hello "  
str2: .asciz "World!"

.text
.global _start
_start:
    ldr r0, =str1   
    ldr r1, =str2  
    // first call
    bl STRCAT    
    //will result in str1 = "Hello World!"  
    //Will result in str2 = "World!"   
    
    // second call 
    bl STRCAT 
    //will result in str1 = "Hello World!World!"
    //Will result in str2 = "World!"  

    b .           

STRCAT:
    push {lr}     

    // find end of str1
    find_end_str1:
        ldrb r2, [r0]  
        adds r0, r0, #1 
        cmp r2, #0      
    bne find_end_str1 

    // decrement r0 to point to the last character of str1
    subs r0, r0, #1  

    // copy str2 to str1
    copy_str2:
        ldrb r2, [r1], #1 
        strb r2, [r0], #1  
        cmp r2, #0          
    bne copy_str2       
    
    pop {lr}       
bx lr          
