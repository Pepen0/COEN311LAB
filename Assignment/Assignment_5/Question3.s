// Assignment number 5      
// CPU architectures       
// Penoelo Thibeaud, student id: 40212017

//Rewrite the ARM assembly program to calculate prime number (as given in the class notes) 
//in the form of a macro. This program counts prime numbers in an array using macro. 
//The array ends with a 0 to indicate end of the array. The program takes every 
//element in the array, calls a macro ChkPrime to check if this element is prime, 
//then adds 1 to the counter. The macro shall have 2 parameters: 
//array element (the number) as input, and returns 1 if the number is prime or 0 if it is not. 
//The count of prime numbers is saved in memory location “result”.
//Arm assenbly code

.syntax unified
.cpu cortex-m4
.thumb
.word 0x20000400 
.word 0x800000ed 
.space 0xe4 

.data
.align 2
array: .word 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 0
result: .word 0

.text
.global _start
_start:
    ldr r0, =array    // Load address of array into r0
    ldr r1, =result   // Load address of result into r1
    mov r2, #0        // Initialize prime count to 0

main_loop:
    ldr r3, [r0], #4  // Load next array element and increment address by 4 (word size)
    cmp r3, #0
    beq end           // If the element is 0, end the loop
    mov r4, r3        // Copy element to r4 to pass to ChkPrime
    bl ChkPrime       // Call ChkPrime subroutine
    cmp r0, #1
    addeq r2, r2, #1  // If r0 is 1 (prime), increment prime count in r2
    b main_loop

end:
    str r2, [r1]      // Store prime count in result
    b .

ChkPrime:
    push {r4-r7, lr}  // Save context
    cmp r4, #2        // Check if the number is less than 2 (not prime)
    blt end_not_prime
    mov r5, #2        // Initialize divisor to 2

prime_loop:
    cmp r5, r4        // Compare divisor with the number
    bge end_prime     // If divisor >= number, it's a prime number
    mov r6, r4
    sdiv r6, r6, r5   // Divide number by divisor
    mul r7, r6, r5    // Multiply quotient by divisor
    cmp r7, r4        // Check if original number equals the multiplication result
    beq end_not_prime // If equal, number is divisible by divisor (not prime)
    add r5, r5, #1    // Increment divisor
    b prime_loop

end_prime:
    mov r0, #1        // Mark as prime
    pop {r4-r7, pc}

end_not_prime:
    mov r0, #0        // Mark as not prime
    pop {r4-r7, pc}
