@ Assignment number 5      
@ CPU architectures       
@ Penoelo Thibeaud, student id: 40212017

@ Rewrite the ARM assembly program to calculate prime number (as given in the class notes) 
@ in the form of a macro. This program counts prime numbers in an array using macro. 
@ The array ends with a 0 to indicate end of the array. The program takes every 
@ element in the array, calls a macro ChkPrime to check if this element is prime, 
@ then adds 1 to the counter. The macro shall have 2 parameters: 
@ array element (the number) as input, and returns 1 if the number is prime or 0 if it is not. 
@ The count of prime numbers is saved in memory location “result”.
@ Arm assenbly code

.syntax unified
.cpu cortex-m4
.thumb

.data
array: .word 145,6,15,4,7,5,101,8,9,105,11,47,12,0  // The array of numbers ending with 0
result: .word 0  // Location to store the count of prime numbers

.text
.global _start

.macro ChkPrime, inputNumber, outputFlag
    mov r4, #2             // r4 is the starting divisor
    udiv r5, \inputNumber, r4 // r5 = \inputNumber / 2, the max value for checking
    mov \outputFlag, #1    // Assume it's a prime by setting the flag to 1

    prime_check_loop:
        cmp r4, r5         // If we've reached half the number, it's a prime
        bhi prime_check_done
        udiv r6, \inputNumber, r4 // Divide the input number by r4
        mul r7, r6, r4     // Multiply the quotient by r4
        cmp r7, \inputNumber // If the product is equal to the input number, it's not prime
        beq not_prime
        add r4, r4, #1     // Increment the divisor and continue
        b prime_check_loop

    not_prime:
        mov \outputFlag, #0 // Set the flag to 0 if not prime

    prime_check_done:
.endm

_start:
    ldr r0, =array    // Address of the array
    mov r2, #0        // Initialize the prime count

    // Loop through the array
    loop:
        ldr r3, [r0], #4  // Load the next number from the array
        cmp r3, #0
        beq finish        // If the number is 0, we reached the end
        ChkPrime r3, r1   // Call the ChkPrime macro
        add r2, r2, r1    // Add the result of the macro to r2 (prime count)
        b loop

    finish:
        ldr r0, =result   // Get the address of the result
        str r2, [r0]      // Store the prime count

    b .                  // End of the program
