.syntax unified 
.cpu cortex-m4 
.thumb 
.word 0x20000400 
.word 0x800000ed 
.space 0xe4 

.data
array: .byte 3, 2, 4, 1, 5, 6,  

.text
start:    

	ldr r0, =array  
	
	mov r1, #0     
	mov r2, #0      
	mov r3, #2  
    
	mul r4, r1, r3  
  
	add r4, r4, r2 
    
	ldrb r5, [r0, r4]  
	
   @==============================

   
	mov r2, #1    
    
	mul r4, r1, r3      

	add r4, r4, r2 
    
	ldrb r7, [r0, r4]  

   @==============================
   
	mov r1, #2      
	mov r2, #2    
    
	mul r4, r1, r3  

	add r4, r4, r2  
    
	ldrb r8, [r0, r4]  
   
stop: 
	b stop



