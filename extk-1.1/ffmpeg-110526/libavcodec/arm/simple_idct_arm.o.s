	CODE32

	EXPORT	|ff_simple_idct_arm|

	AREA	|.text|, CODE, ARM
|ff_simple_idct_arm| PROC
	DCD	0xe92d4ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, lr}
	DCD	0xe280e070 ;	add	lr, r0, #112	; 0x70
	DCD	0xe28fcfce ;	add	ip, pc, #824	; 0x338
	DCD	0xe24dd008 ;	sub	sp, sp, #8
	DCD	0xe58d0000 ;	str	r0, [sp]
	ENDP

|__row_loop| PROC
	DCD	0xe59e1000 ;	ldr	r1, [lr]
	DCD	0xe59e2004 ;	ldr	r2, [lr, #4]
	DCD	0xe59e3008 ;	ldr	r3, [lr, #8]
	DCD	0xe59e400c ;	ldr	r4, [lr, #12]
	DCD	0xe1845003 ;	orr	r5, r4, r3
	DCD	0xe1855002 ;	orr	r5, r5, r2
	DCD	0xe1956001 ;	orrs	r6, r5, r1
	DCD	0x0a000062 ;	beq	1c0 <__end_row_loop>
	DCD	0xe1a07841 ;	asr	r7, r1, #16
	DCD	0xe1de60f0 ;	ldrsh	r6, [lr]
	DCD	0xe1955007 ;	orrs	r5, r5, r7
	DCD	0x0a000056 ;	beq	1a0 <__almost_empty_row>
	ENDP

|__b_evaluation| PROC
	DCD	0xe59c8000 ;	ldr	r8, [ip]
	DCD	0xe1a02842 ;	asr	r2, r2, #16
	DCD	0xe0000798 ;	mul	r0, r8, r7
	DCD	0xe59c9008 ;	ldr	r9, [ip, #8]
	DCD	0xe59ca010 ;	ldr	sl, [ip, #16]
	DCD	0xe0010799 ;	mul	r1, r9, r7
	DCD	0xe59cb018 ;	ldr	fp, [ip, #24]
	DCD	0xe005079a ;	mul	r5, sl, r7
	DCD	0xe007079b ;	mul	r7, fp, r7
	DCD	0xe3320000 ;	teq	r2, #0
	DCD	0x10200299 ;	mlane	r0, r9, r2, r0
	DCD	0x12622000 ;	rsbne	r2, r2, #0
	DCD	0x1021129b ;	mlane	r1, fp, r2, r1
	DCD	0x10255298 ;	mlane	r5, r8, r2, r5
	DCD	0x1027729a ;	mlane	r7, sl, r2, r7
	DCD	0xe1932004 ;	orrs	r2, r3, r4
	DCD	0x0a00000d ;	beq	c0 <__a_evaluation>
	DCD	0xe1a03843 ;	asr	r3, r3, #16
	DCD	0xe3330000 ;	teq	r3, #0
	DCD	0x1020039a ;	mlane	r0, sl, r3, r0
	DCD	0xe1a04844 ;	asr	r4, r4, #16
	DCD	0x1025539b ;	mlane	r5, fp, r3, r5
	DCD	0x10277399 ;	mlane	r7, r9, r3, r7
	DCD	0x12633000 ;	rsbne	r3, r3, #0
	DCD	0x10211398 ;	mlane	r1, r8, r3, r1
	DCD	0xe3340000 ;	teq	r4, #0
	DCD	0x1020049b ;	mlane	r0, fp, r4, r0
	DCD	0x10255499 ;	mlane	r5, r9, r4, r5
	DCD	0x12644000 ;	rsbne	r4, r4, #0
	DCD	0x10277498 ;	mlane	r7, r8, r4, r7
	DCD	0x1021149a ;	mlane	r1, sl, r4, r1
	ENDP

|__a_evaluation| PROC
	DCD	0xe59c900c ;	ldr	r9, [ip, #12]
	DCD	0xe0060699 ;	mul	r6, r9, r6
	DCD	0xe59ca014 ;	ldr	sl, [ip, #20]
	DCD	0xe1de40f4 ;	ldrsh	r4, [lr, #4]
	DCD	0xe2866b01 ;	add	r6, r6, #1024	; 0x400
	DCD	0xe00b049a ;	mul	fp, sl, r4
	DCD	0xe59c8004 ;	ldr	r8, [ip, #4]
	DCD	0xe046300b ;	sub	r3, r6, fp
	DCD	0xe3320000 ;	teq	r2, #0
	DCD	0x0a000092 ;	beq	334 <__end_bef_a_evaluation>
	DCD	0xe086200b ;	add	r2, r6, fp
	DCD	0xe00b0498 ;	mul	fp, r8, r4
	DCD	0xe046400b ;	sub	r4, r6, fp
	DCD	0xe086600b ;	add	r6, r6, fp
	DCD	0xe1deb0f8 ;	ldrsh	fp, [lr, #8]
	DCD	0xe33b0000 ;	teq	fp, #0
	DCD	0x100b0b99 ;	mulne	fp, r9, fp
	DCD	0xe1de90fc ;	ldrsh	r9, [lr, #12]
	DCD	0x1086600b ;	addne	r6, r6, fp
	DCD	0x1042200b ;	subne	r2, r2, fp
	DCD	0x1043300b ;	subne	r3, r3, fp
	DCD	0x1084400b ;	addne	r4, r4, fp
	DCD	0xe3390000 ;	teq	r9, #0
	DCD	0x100b099a ;	mulne	fp, sl, r9
	DCD	0x1086600b ;	addne	r6, r6, fp
	DCD	0x100a0998 ;	mulne	sl, r8, r9
	DCD	0x1044400b ;	subne	r4, r4, fp
	DCD	0x1042200a ;	subne	r2, r2, sl
	DCD	0x1083300a ;	addne	r3, r3, sl
	ENDP

|__end_a_evaluation| PROC
	DCD	0xe0868000 ;	add	r8, r6, r0
	DCD	0xe0829001 ;	add	r9, r2, r1
	DCD	0xe59ca01c ;	ldr	sl, [ip, #28]
	DCD	0xe00a9289 ;	and	r9, sl, r9, lsl #5
	DCD	0xe1e0b00a ;	mvn	fp, sl
	DCD	0xe00b85c8 ;	and	r8, fp, r8, asr #11
	DCD	0xe1888009 ;	orr	r8, r8, r9
	DCD	0xe58e8000 ;	str	r8, [lr]
	DCD	0xe0838005 ;	add	r8, r3, r5
	DCD	0xe0849007 ;	add	r9, r4, r7
	DCD	0xe00a9289 ;	and	r9, sl, r9, lsl #5
	DCD	0xe00b85c8 ;	and	r8, fp, r8, asr #11
	DCD	0xe1888009 ;	orr	r8, r8, r9
	DCD	0xe58e8004 ;	str	r8, [lr, #4]
	DCD	0xe0448007 ;	sub	r8, r4, r7
	DCD	0xe0439005 ;	sub	r9, r3, r5
	DCD	0xe00a9289 ;	and	r9, sl, r9, lsl #5
	DCD	0xe00b85c8 ;	and	r8, fp, r8, asr #11
	DCD	0xe1888009 ;	orr	r8, r8, r9
	DCD	0xe58e8008 ;	str	r8, [lr, #8]
	DCD	0xe0428001 ;	sub	r8, r2, r1
	DCD	0xe0469000 ;	sub	r9, r6, r0
	DCD	0xe00a9289 ;	and	r9, sl, r9, lsl #5
	DCD	0xe00b85c8 ;	and	r8, fp, r8, asr #11
	DCD	0xe1888009 ;	orr	r8, r8, r9
	DCD	0xe58e800c ;	str	r8, [lr, #12]
	DCD	0xea000007 ;	b	1c0 <__end_row_loop>
	ENDP

|__almost_empty_row| PROC
	DCD	0xe3a08801 ;	mov	r8, #65536	; 0x10000
	DCD	0xe2488001 ;	sub	r8, r8, #1
	DCD	0xe0085186 ;	and	r5, r8, r6, lsl #3
	DCD	0xe1855805 ;	orr	r5, r5, r5, lsl #16
	DCD	0xe58e5000 ;	str	r5, [lr]
	DCD	0xe58e5004 ;	str	r5, [lr, #4]
	DCD	0xe58e5008 ;	str	r5, [lr, #8]
	DCD	0xe58e500c ;	str	r5, [lr, #12]
	ENDP

|__end_row_loop| PROC
	DCD	0xe59d0000 ;	ldr	r0, [sp]
	DCD	0xe130000e ;	teq	r0, lr
	DCD	0xe24ee010 ;	sub	lr, lr, #16
	DCD	0x1affff90 ;	bne	14 <__row_loop>
	DCD	0xe280e00e ;	add	lr, r0, #14
	ENDP

|__b_evaluation2| PROC
	DCD	0xe59c8000 ;	ldr	r8, [ip]
	DCD	0xe1de71f0 ;	ldrsh	r7, [lr, #16]
	DCD	0xe0000798 ;	mul	r0, r8, r7
	DCD	0xe59c9008 ;	ldr	r9, [ip, #8]
	DCD	0xe59ca010 ;	ldr	sl, [ip, #16]
	DCD	0xe0010799 ;	mul	r1, r9, r7
	DCD	0xe59cb018 ;	ldr	fp, [ip, #24]
	DCD	0xe005079a ;	mul	r5, sl, r7
	DCD	0xe1de23f0 ;	ldrsh	r2, [lr, #48]	; 0x30
	DCD	0xe007079b ;	mul	r7, fp, r7
	DCD	0xe3320000 ;	teq	r2, #0
	DCD	0x10200299 ;	mlane	r0, r9, r2, r0
	DCD	0x12622000 ;	rsbne	r2, r2, #0
	DCD	0x1021129b ;	mlane	r1, fp, r2, r1
	DCD	0x10255298 ;	mlane	r5, r8, r2, r5
	DCD	0x1027729a ;	mlane	r7, sl, r2, r7
	DCD	0xe1de35f0 ;	ldrsh	r3, [lr, #80]	; 0x50
	DCD	0xe3330000 ;	teq	r3, #0
	DCD	0x1020039a ;	mlane	r0, sl, r3, r0
	DCD	0x1025539b ;	mlane	r5, fp, r3, r5
	DCD	0x10277399 ;	mlane	r7, r9, r3, r7
	DCD	0x12633000 ;	rsbne	r3, r3, #0
	DCD	0xe1de47f0 ;	ldrsh	r4, [lr, #112]	; 0x70
	DCD	0x10211398 ;	mlane	r1, r8, r3, r1
	DCD	0xe3340000 ;	teq	r4, #0
	DCD	0x1020049b ;	mlane	r0, fp, r4, r0
	DCD	0x10255499 ;	mlane	r5, r9, r4, r5
	DCD	0x12644000 ;	rsbne	r4, r4, #0
	DCD	0x10277498 ;	mlane	r7, r8, r4, r7
	DCD	0x1021149a ;	mlane	r1, sl, r4, r1
	ENDP

|__a_evaluation2| PROC
	DCD	0xe1de60f0 ;	ldrsh	r6, [lr]
	DCD	0xe59c900c ;	ldr	r9, [ip, #12]
	DCD	0xe0060699 ;	mul	r6, r9, r6
	DCD	0xe59ca014 ;	ldr	sl, [ip, #20]
	DCD	0xe1de42f0 ;	ldrsh	r4, [lr, #32]
	DCD	0xe2866702 ;	add	r6, r6, #524288	; 0x80000
	DCD	0xe00b049a ;	mul	fp, sl, r4
	DCD	0xe59c8004 ;	ldr	r8, [ip, #4]
	DCD	0xe086200b ;	add	r2, r6, fp
	DCD	0xe046300b ;	sub	r3, r6, fp
	DCD	0xe00b0498 ;	mul	fp, r8, r4
	DCD	0xe046400b ;	sub	r4, r6, fp
	DCD	0xe086600b ;	add	r6, r6, fp
	DCD	0xe1deb4f0 ;	ldrsh	fp, [lr, #64]	; 0x40
	DCD	0xe33b0000 ;	teq	fp, #0
	DCD	0x100b0b99 ;	mulne	fp, r9, fp
	DCD	0x1086600b ;	addne	r6, r6, fp
	DCD	0x1042200b ;	subne	r2, r2, fp
	DCD	0x1043300b ;	subne	r3, r3, fp
	DCD	0xe1de96f0 ;	ldrsh	r9, [lr, #96]	; 0x60
	DCD	0x1084400b ;	addne	r4, r4, fp
	DCD	0xe3390000 ;	teq	r9, #0
	DCD	0x100b099a ;	mulne	fp, sl, r9
	DCD	0x1086600b ;	addne	r6, r6, fp
	DCD	0x100a0998 ;	mulne	sl, r8, r9
	DCD	0x1044400b ;	subne	r4, r4, fp
	DCD	0x1042200a ;	subne	r2, r2, sl
	DCD	0x1083300a ;	addne	r3, r3, sl
	ENDP

|__end_a_evaluation2| PROC
	DCD	0xe0868000 ;	add	r8, r6, r0
	DCD	0xe0829001 ;	add	r9, r2, r1
	DCD	0xe1a08a48 ;	asr	r8, r8, #20
	DCD	0xe1a09a49 ;	asr	r9, r9, #20
	DCD	0xe1ce80b0 ;	strh	r8, [lr]
	DCD	0xe1ce91b0 ;	strh	r9, [lr, #16]
	DCD	0xe0838005 ;	add	r8, r3, r5
	DCD	0xe0849007 ;	add	r9, r4, r7
	DCD	0xe1a08a48 ;	asr	r8, r8, #20
	DCD	0xe1a09a49 ;	asr	r9, r9, #20
	DCD	0xe1ce82b0 ;	strh	r8, [lr, #32]
	DCD	0xe1ce93b0 ;	strh	r9, [lr, #48]	; 0x30
	DCD	0xe0448007 ;	sub	r8, r4, r7
	DCD	0xe0439005 ;	sub	r9, r3, r5
	DCD	0xe1a08a48 ;	asr	r8, r8, #20
	DCD	0xe1a09a49 ;	asr	r9, r9, #20
	DCD	0xe1ce84b0 ;	strh	r8, [lr, #64]	; 0x40
	DCD	0xe1ce95b0 ;	strh	r9, [lr, #80]	; 0x50
	DCD	0xe0428001 ;	sub	r8, r2, r1
	DCD	0xe0469000 ;	sub	r9, r6, r0
	DCD	0xe1a08a48 ;	asr	r8, r8, #20
	DCD	0xe1a09a49 ;	asr	r9, r9, #20
	DCD	0xe1ce86b0 ;	strh	r8, [lr, #96]	; 0x60
	DCD	0xe1ce97b0 ;	strh	r9, [lr, #112]	; 0x70
	ENDP

|__end_col_loop| PROC
	DCD	0xe59d0000 ;	ldr	r0, [sp]
	DCD	0xe130000e ;	teq	r0, lr
	DCD	0xe24ee002 ;	sub	lr, lr, #2
	DCD	0x1affffa9 ;	bne	1d4 <__b_evaluation2>
	ENDP

|__end_simple_idct_arm| PROC
	DCD	0xe28dd008 ;	add	sp, sp, #8
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	ENDP

|__end_bef_a_evaluation| PROC
	DCD	0xe086200b ;	add	r2, r6, fp
	DCD	0xe00b0498 ;	mul	fp, r8, r4
	DCD	0xe046400b ;	sub	r4, r6, fp
	DCD	0xe086600b ;	add	r6, r6, fp
	DCD	0xeaffff7a ;	b	134 <__end_a_evaluation>
	ENDP

|__constant_ptr| PROC
	DCD	0x000058c5 ;	andeq	r5, r0, r5, asr #17
	DCD	0x0000539f ;	muleq	r0, pc, r3	; <UNPREDICTABLE>
	DCD	0x00004b42 ;	andeq	r4, r0, r2, asr #22
	DCD	0x00003fff ;	strdeq	r3, [r0], -pc	; <UNPREDICTABLE>
	DCD	0x00003249 ;	andeq	r3, r0, r9, asr #4
	DCD	0x000022a3 ;	andeq	r2, r0, r3, lsr #5
	DCD	0x000011a8 ;	andeq	r1, r0, r8, lsr #3
	DCD	0xffff0000 ;			; <UNDEFINED> instruction: 0xffff0000
	ENDP

	END
