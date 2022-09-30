.data
	prompt: .asciz "Placing down or right? zero or one: "
	prompt1: .asciz "Place your Carrier\n"
	prompt2: .asciz "Place your BattleShip\n"
	prompt3: .asciz "Place your Cruiser\n"
	prompt4: .asciz "Place your Submarine\n"
	prompt5: .asciz "Place your Destroyer\n"
	promptx: .asciz "X coord zero to nine: "
	prompty: .asciz "Y coord zero to nine: "
	promptGet: .asciz "%d"
	promptGetx: .asciz "%d"
	promptTest: .asciz "\n%d\n"

.file "initBoard.c"
.text
.align 2
.global initBoard
.arm
.fpu vfp
.type initBoard, %function
initBoard:
@r1 has carrier value 1 
@I think r0 is r? and r3 is c
	push {r4-r11, lr}
	mov r8, r3  @our pointer
	mov r5, r1  @our ship
	push {r0-r3}

	@mov r2, #6  @ x
	@mov r3, #7  @ y
	@mul r2, r2, r6
	@mul r3, r3, r7
	@add r2, r2, r3 @r2 will be move
	@mov r1, #4 @ r0 has 0,0  r3 has they are the same lol
	@str r1, [r8, r2]
	@ldr r1, [r0]
	@bl .end @remove please
	bl .ship
	bl .end
.ship:
	cmp r5, #1
	beq .carrier
	cmp r5, #2
	beq .battleShip
	cmp r5, #3
	beq .cruiser
	cmp r5, #4
	beq .submarine
	cmp r5, #5
	beq .destroyer
.carrier:
	mov r9, #5 @size
	ldr r0, =prompt1 @place your carrier
	bl printf
	bl .shipGeneral
.battleShip:
	mov r9, #4 @size
	ldr r0, =prompt2 @place your battleship
	bl printf
	bl .shipGeneral
.cruiser:
	mov r9, #3
	ldr r0, =prompt3 @place your cruiser
	bl printf
	bl .shipGeneral
.submarine:
	mov r9, #3
	ldr r0, =prompt4 @place your submarine
	bl printf
	bl .shipGeneral
.destroyer:
	mov r9, #2
	ldr r0, =prompt5 @place your destroyer
	bl printf
	bl .shipGeneral
.shipGeneral:
	ldr r0, =prompt @down right
	bl printf
	ldr r0, =promptGet @%d
	
	mov r1, sp
	bl scanf
	ldr r1, [sp]
	mov r10, r1 @ IMPORTANT, UP DOWN LEFT RIGHT cmp later
	
	ldr r0, =promptx
	bl printf
	
	ldr r0, =promptGet
	mov r1, sp
	bl scanf @This is X
	ldr r1, [sp]
	mov r4, r1

	ldr r0, =prompty
	bl printf

 	ldr r0, =promptGet
	mov r1, sp
	bl scanf
	ldr r1, [sp]
	mov r3, r1
	
	mov r6, #4 @ col (x)
	mov r7, #40  @ row (y)	
	mul r6, r4, r6
	mul r7, r3, r7 @add check here for boundary and maybe other ships
	add r6, r6, r7 @r6 will be move
	cmp r10, #1
	beq .checkBDown
	cmp r10, #0	
	beq .checkBRight
	bl .shipGeneral
.checkBDown:@boundary check down
	cmp r4, #10
	bgt .shipGeneral
	cmp r4, #0
	blt .shipGeneral
	cmp r3, #0
	blt .shipGeneral
	add r3, r3, r9
	cmp r3, #9
	bgt .shipGeneral
	mov r3, r9
	bl .checkDown
.checkBRight:@boundary check right
	cmp r3, #10
	bgt .shipGeneral
	cmp r3, #0
	blt .shipGeneral
	cmp r4, #0
	blt .shipGeneral
	add r4, r4, r9
	cmp r4, #9
	bgt .shipGeneral
	mov r4, r9
	bl .checkRight
.checkRight:
	cmp r4, #0
	beq .loopright
	ldr r0, [r8, r6]
	add r3, r6, #40
	sub r4, r4, #1
	cmp r0, #6
	beq .checkRight
	bl .shipGeneral
.checkDown:@checkotherships
	cmp r3, #0
	beq .loopdown
	ldr r0, [r8, r6]
	add r4, r6, #40
	sub r3, r3, #1
	cmp r0, #6
	beq .checkDown
	bl .shipGeneral
.loopdown:
	cmp r9, #0
	beq .end
	str r5, [r8, r6]
	add r6, r6, #40
	sub r9, r9, #1
	bl .loopdown
.loopright:
	cmp r9, #0
	beq .end
	str r5, [r8, r6]
	add r6, r6, #4
	sub r9, r9, #1
	bl .loopright
.end:
	pop {r0-r3}
	pop {r4-r11, pc} @ return 

		
	
