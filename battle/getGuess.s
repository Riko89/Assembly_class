.data
	promptx: .asciz "Guess X: "
	prompty: .asciz "Guess Y: "
	promptGet: .asciz "%d"
	prompt7: .asciz "Invalid Guess(Or you already hit there)\n"
	promptM: .asciz "Miss!\n"
	.file "getGuess.c"
	.text
	.align 2
	.global getGuess
	.arm
	.fpu vfp
	.type getGuess, %function
getGuess:
	push {r1-r10, lr}
	mov r8, r0
	bl .guess


.guess:
	ldr r0, =promptx
	bl printf
	ldr r0, =promptGet
	mov r1, sp
	bl scanf
	ldr r1, [sp]
	mov r4, r1 @ x
	ldr r0, =prompty
	bl printf
	ldr r0, =promptGet
	mov r1, sp
	bl scanf
	ldr r1, [sp]
	mov r5, r1 @y
	
	cmp r5, #0
	blt .hitAlready
	cmp r5, #9
	bgt .hitAlready
	cmp r4, #0
	blt .hitAlready
	cmp r4, #9
	bgt .hitAlready
	
	mov r6, #40 @ y
	mov r7, #4 @ x
	
	mul r4, r4, r7
	mul r5, r5, r6
	add r4, r4, r5
	
	ldr r2, [r8, r4]
	
	cmp r2, #7
	beq .hitAlready
	cmp r2, #1
	beq .hit1
	cmp r2, #2
	beq .hit2
	cmp r2, #3
	beq .hit3
	cmp r2, #4
	beq .hit4
	cmp r2, #5
	beq .hit5
	bl .miss
.hitAlready:
	ldr r0, =prompt7
	bl printf
	bl .guess
.hit1:
	mov r9, #7
	str r9, [r8, r4]
	mov r0, #1
	bl .end
.hit2:
	mov r9, #7
	str r9, [r8, r4]
	mov r0, #2
	bl .end
.hit3:
	mov r9, #7
	str r9, [r8, r4]
	mov r0, #3
	bl .end
.hit4:
	mov r9, #7
	str r9, [r8, r4]
	mov r0, #4
	bl .end
.hit5:
	mov r9, #7
	str r9, [r8, r4]
	mov r0, #5
	bl .end
.miss:
	ldr r0, =promptM
	bl printf
	mov r0, #0
	bl .end
.end:
	pop {r1-r10, pc}
