.syntax unified 
.cpu cortex-m4 
.thumb 
.word 0x20000400 
.word 0x800000ed 
.space 0xe4 

.data 
mick: .byte 2,3,4 
keith: .byte 5,6,7 
dot: .space 0x01 

.text 
start: 
	mov r4, #0 
	mov r5, #0 

loop: 
	ldr r0, =mick 
	ldrb r1, [r0, r5] 
	ldr r0, =keith 
	ldrb r2, [r0, r5] 
	mul r3, r1, r2 
	add r4, r4, r3 
	add r5, r5, #1 
	cmp r5, #3 
	blt loop 

	ldr r0, =dot 
	strb r4, [r0] 

stop: 
	b stop
