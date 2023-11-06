@ Ted Obuchowicz
@ Oct. 12, 2022
@ add_from_mem.s

.syntax unified
.cpu cortex-m4
.thumb

.word 0x20000400
.word 0x800000ed
.space 0xe4

.data
mick: .byte 0x01 @ reserve 1 byte of RAM and initialize it to 01
keith: .byte 0x02 @ reserve 1 byte of RAM and initialize it to 02
result: .space 0x01 @ reserve 1 byte of RAM without any
	@initialization

.text
start:
	ldr r0, =mick @ load address of mick into r0
	ldrb r1, [r0] @ load r1 with memory byte contents of mick
	ldr r0, =keith @ load address of keith into r0
	ldrb r2, [r0] @ load r2 with memory byte contents of keith
	add r3, r2, r1 @ r3 = r2 + r1
	ldr r0, =result @ load address of result into r0
	strb r3, [r0] @ store sum into memory at location result
stop: b stop
