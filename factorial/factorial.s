.data
	prompt: .asciz "Enter a number"
	prompt1: .asciz "%d"
	prompt3: .asciz "%03d"
	debug: .asciz "bug\n"
	LIST:
	.equ	SIZE,16
	.equ	CARRY,0
	.equ	SUM,4
	.equ	NEXT,8
	.equ	PREV,12
	
	.file "factorial.c" 
	.text
	.align 2
	.global factorial
	.arm
	.fpu vfp
	.syntax unified
	.type factorial,%function
factorial:
	push {r1-r12, lr}
	mov r7, r0
	sub sp, sp, SIZE
	mov r0, #1
	str r0, [sp,SUM]
	mov r0, #0
	str r0, [sp,CARRY]
	str r0, [sp,NEXT]
	str r0, [sp,PREV]
	mov r6, #1
	bl .start
.start:
	mov r4, sp
	add r6, r6, #1
	cmp r6, r7
	bgt .printStart
	bl .mult
.mult:
	ldr r5,[r4,SUM]
	mul r5,r5,r6
	str r5,[r4,SUM]
	@getnext
	ldr r5,[r4,NEXT]
	mov r4, r5
	cmp r5, #0
	beq .initCarryStart
	bl .mult
.initCarryStart:
	mov r8, sp
	bl .carryStart
.carryStart:
	@check for carry, use r8, r9, r10
	ldr r9,[r8,SUM]
	cmp r9,#1000 
	bge .carryinit
	@else next list
	bl .nextListCarry
.nextListCarry:
	ldr r10,[r8,NEXT]
	mov r8, r10
	cmp r8, #0
	beq .addSumStart
	bl .carryStart
.carryinit:
	@thisis confirmedcarry
	@r8 list,r9 has r8 sum 
	mov r11,#0
	bl .carry
.carry:
	sub r9,#1000
	add r11, r11, #1
	cmp r9,#1000
	blt .storeCarry
	bl .carry
.storeCarry:
	@r9, r11 have new sum and carry
	str r9,[r8,SUM]
	str r11,[r8,CARRY]
	bl .carryStart
.overFlowStart:
	mov r9, r3
	mov r2, #0
	@ldr r0,=debug
	@bl printf
	bl .subtract
.subtract:
	sub r9,#1000
	add r2, r2, #1
	cmp r9,#1000
	blt .storeOverFlow
	bl .subtract
.storeOverFlow:
	str r9,[r10,SUM]
	ldr r9,[r10,CARRY]
	add r2, r2, r9
	str r2,[r10,CARRY]
	mov r2, #0
	str r2, [r8,CARRY]
	bl .addSum  	
.addSumStart:
	mov r8, sp
	bl .addSum
.addSum:
	ldr r9,[r8,CARRY]
	ldr r10,[r8,NEXT]
	cmp r10, #0
	beq .addNewListStart
	bl .part2
	@come back here
	@r10 has next
.part2:
	ldr r3,[r10,SUM]
	add r3,r3,r9
	cmp r3,#1000
	bgt .overFlowStart
	str r3,[r10,SUM]
	mov r2, #0
	str r2, [r8,CARRY]
	mov r8, r10
	bl .addSum
.addNewListStart:
	cmp r9, #0
	beq .start
	@if carry isn't greater than mult, next list
	bl .addNewList
.addNewList:
	mov r0, SIZE
	bl malloc
	mov r2, #0
	str r2,[r8,CARRY]
	str r9,[r0,SUM]
	str r2,[r0,CARRY]
	str r2,[r0,NEXT]
	str r8,[r0,PREV]
	str r0,[r8,NEXT]
	mov r8, r0
	bl .addSum
.printStart:
	mov r2, sp
	ldr r3,[r2,NEXT]
	bl .getEnd
.getEnd:
	cmp r3,#0
	beq .print1
	ldr r4,[r3,NEXT]
	mov r2, r3 @lag pointer r2
	mov r3, r4
	bl .getEnd
.print1:
	mov r4, r2
	ldr r3,[r2,SUM]
	mov r1, r3
	ldr r0,=prompt1
	bl printf
	ldr r5,[r4,PREV]
	mov r2, r5
	cmp r5,#0
	beq .end
	bl .print2
.print2:	
	mov r4, r2
	ldr r3,[r2,SUM]
	mov r1, r3
	ldr r0,=prompt3
	bl printf
	ldr r5,[r4,PREV]
	mov r2, r5
	mov r3, r2
	cmp r5,#0
	beq .end
	bl .print2
.end:
	add sp, sp, SIZE
	pop {r1-r12, pc}
	@mov lr, r12
	@bx lr	

	
