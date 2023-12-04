

@directive section ----------------------------------------------
    .data@ used to define and initialise section

        db 0x41 @ use to define byte
        dd 0 @ use to define double word
        dw 0@ use to define word    

        @ number can be define in multiple ways (decimal, hexadecimal, binary)
        db 0x45 @ hexadecimal number are prefixed with 0x
        db 45h @ hexadecimal number are suffixed with h
        db 01010101b @ binary number are suffixed with b
        db 65 @ decimal number are not prefixed or suffixed

        @ representing character string 
        mystring: db "Hello World" @ db will put one character per byte

        @ access string and arrays
        mov clm mystring[6] @ clm will contain the character 'W'


    .bss @ used to define uninitialized data section of memory

        resb @ used to reserve byte of memory
        resw @ used to reserve word of memory
        resd @ used to reserve double word of memory

        @ example
        mystring: resb 32 @ reserve 32 bytes of memory for mystring



@ general code section ----------------------------------------------
    .text @ used to define code section

        org 0x7c00 @ used to set the origin of the program
        global _start @ used to define the entry point of the program and make it accessible to the linker and your entire program
        equ @ used to define constant, assign a value to the constant but dont give it a value
        $ @ used to get the current address of the program counter
        even @ used to align the next instruction on an even byte boundary

@ Assembly instructions ,flags and memory operations ----------------------------------------------

    @ adition --- affect Zero, Sign, Overflow, and Carry flags

        add @ add two numbers 
        adc @ add two numbers with carry 
        inc @ increment by 1 

    @ substraction --- affect Zero, Sign, Overflow, and Carry flags

        sub @ substract two numbers 
        sbb @ substract two numbers with borrow 
        dec @ decrement by 1 
        neg @ negate a number 

    @ multiplication  --- affect Overflow, and Carry flags

        mul @ multiply two unsign numbers
        mul bl @ multiplicate ax (8 bits) by bl (8 bits) and store the result in ax (16 bits)
        mul bx @ multiplicate ax (16 bits) by bx (16 bits) and store the result in dx:ax
            @ dx:ax (16 bits each) ,dx will contain the high order bits and ax will contain the low order bits

        imul @ multiply two numbers with signed numbers 
        smul @ multiply two numbers with signed numbers and store the result in a double word

    @ division --- does not update any flags, but can cause a divide by zero exception

        div @ divide two unsign numbers 
        div bl @ divide ax (16 bits) by bl (8 bits) and store the result in al (8 bits)
            @ the remainder in ah (8 bits)

        idiv @ divide two numbers with signed numbers
        sdiv @ divide two numbers with signed numbers and store the result in a double word

    @ compare --- affect Zero, Sign, Overflow, and Carry flags

        cmp @ compare two numbers, perform a substraction but dont store the result
            @ only update the flags
        cmn @ compare two numbers with negation

    @ exchange --- does not affect any flags

        xchg @ exchange two numbers 
             @ exchange the value of 2 registers or memory locations   
        bswap @ byte swap changes the order of the bytes in a register 
              @ big endian to little endian and vice versa

    @ data exchange --- does not affect any flags

        mov @ move data from one location to another
            @ move data from one register to another
            @ move data from memory to a register
            @ move data from a register to memory
            @ move data from one memory location to another
        xlat @ translate a byte in a table using the value in al as an index

    @ control and jumps 

        @ jump types
                @ intrasegment jump --- used to jump to a different location in the same code segment
                @ intersegment jump --- used to jump to a different code segment

        @ unconditional jump 
            @ jump operand type 
                @ short jump --- used to jump to a location within -128 to +127 bytes of the current location
                @ near jump --- used to jump to a location within -32768 to +32767 bytes of the current location
                @ far jump --- used to jump to a location anywhere in memory
                @ memory indirect jump --- used to jump to a location anywhere in memory
            
            jmp @ move the program counter to a new location no matter what

        @ conditional jump --- move the program counter to a new location if a condition is met    

            @ jump conditions

                jz @ jump if zero flag is set
                jnz @ jump if zero flag is not set
                jc @ jump if carry flag is set
                jnc @ jump if carry flag is not set
                jo @ jump if overflow flag is set
                jno @ jump if overflow flag is not set
                js @ jump if sign flag is set
                jns @ jump if sign flag is not set
                je @ jump if equal
                jne @ jump if not equal
                ja @ jump if above
                jae @ jump if above or equal
                jb @ jump if below
                jbe @ jump if below or equal
                jl @ jump if less
                jle @ jump if less or equal
                jg @ jump if greater
                jge @ jump if greater or equal
                jp @ jump if parity
                jnp @ jump if not parity
                jcxz @ jump if cx register is zero

        @ if- else branching 
            @ exemple using cmp and jump
                cmp ax, bx
                jz equal @ jump to equal label if ax is equal to bx
                jmp notequal @jump to notequal label if ax is not equal to bx



        @ loop --- used to repeat a block of code a certain number of times

            @ while loop exemple
                mov cx, 10 
                while: @ while label
                    dec cx @ decrement cx register by 1
                    jnz while @ jump to while label if cx register is not zero

            @ for loop exemple
                mov cx, 10 @ set cx register to 10
                for: @ for label
                    dec cx @ decrement cx register by 1
                    jnz for @ jump to for label if cx register is not zero

            @ do while loop exemple
                mov cx, 10 @ set cx register to 10
                do: @ do label
                    dec cx @ decrement cx register by 1
                    jnz do @ jump to do label if cx register is not zero

            loop @ loop while cx register is not zero
            loopz @ loop while cx register is not zero and zero flag is set
            loopnz @ loop while cx register is not zero and zero flag is not set

        @ procedure call
            call @ call a procedure

        @ procedure return
            ret @ return from a procedure
            iret @ return from an interrupt

        @ interrupt
            int @ generate a software interrupt
            into @ interrupt if overflow flag is set
            hlt @ halt the processor
        
        @ logical operations --- affect Zero, Sign, and Carry flags

            and @ logical and
            or @ logical or
            xor @ logical xor
            not @ logical not
            test @ logical and but dont store the result
            
            @ exemple of logical operations
                mov ax, 0x1234
                mov bx, 0x5678
                and ax, bx @ ax will contain 0x1230
                or ax, bx @ ax will contain 0x5678
                xor ax, bx @ ax will contain 0x4448
                not ax @ ax will contain 0xbbb7
                test ax, bx @ ax will contain 0x5678

        @ shift operations --- affect Zero, Sign, and Carry flags

            shl @ shift left
            shr @ shift right
            sar @ shift arithmetic right
            sal @ shift arithmetic left

        @ rotate operations --- affect Zero, Sign, and Carry flags

            rcl @ rotate left through carry
            rcr @ rotate right through carry
            rol @ rotate left
            ror @ rotate right
        
@ macro
    
        @ define a macro is like defining a function
            
            %macro name_of_macro number_of_arguments
                
                @ macro code ...

            %endmacro
    
        @ call a macro will copy the macro code and replace the arguments with the values you pass to the macro
            name_of_macro argument1, argument2, argument3
    
        @ exemple
            %macro print_string 2
                mov ah, 0x0e
                mov al, %1
                int 0x10
                mov al, %2
                int 0x10
            %endmacro
    
            print_string 'H', 'i'


@ subroutines

        @ The value of IP and CS are saved on the stack when a subroutine is called

        @ define a subroutine is like defining a function

            name_of_subroutine:
                    ret @ return from a subroutine, change the program counter to the address of the next instruction after the call instruction

        @ call a subroutine will copy the subroutine code and replace the arguments with the values you pass to the subroutine

            call name_of_subroutine

        @ Example
            
            my_subroutine:
                mov ax, 0x5678 
                ret

            @ ...

            call my_subroutine @ ax will contain the value 0x5678 because of subroutine
            mov bx, ax

@ Addressing modes ----------------------------------------------

        @ immediate addressing
        mov ax, 0x1234 @ move the value 0x1234 into ax

        @ register addressing
        mov ax, bx @ move the value of bx into ax