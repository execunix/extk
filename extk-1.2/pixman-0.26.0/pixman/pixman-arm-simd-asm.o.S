	CODE32

	EXPORT	|pixman_composite_add_8_8_asm_armv6|
	EXPORT	|pixman_composite_over_8888_8888_asm_armv6|
	EXPORT	|pixman_composite_over_8888_n_8888_asm_armv6|
	EXPORT	|pixman_composite_over_n_8_8888_asm_armv6|
	EXPORT	|pixman_scaled_nearest_scanline_0565_0565_SRC_asm_armv6|
	EXPORT	|pixman_scaled_nearest_scanline_8888_8888_SRC_asm_armv6|

	AREA	|.text|, CODE, ARM

|pixman_composite_add_8_8_asm_armv6| PROC
	DCD	0xe92d0ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp}
	DCD	0xe1a0a001 ;	mov	sl, r1
	DCD	0xe24dd004 ;	sub	sp, sp, #4
	DCD	0xe25aa001 ;	subs	sl, sl, #1
	DCD	0xe1a0b000 ;	mov	fp, r0
	DCD	0xe1a08002 ;	mov	r8, r2
	DCD	0xe58d3000 ;	str	r3, [sp]
	DCD	0xe59d7024 ;	ldr	r7, [sp, #36]	; 0x24
	DCD	0x3a000017 ;	bcc	84 <pixman_composite_add_8_8_asm_armv6+0x84>
	DCD	0xe35b0000 ;	cmp	fp, #0
	DCD	0x0a00000f ;	beq	6c <pixman_composite_add_8_8_asm_armv6+0x6c>
	DCD	0xe1883007 ;	orr	r3, r8, r7
	DCD	0xe3130003 ;	tst	r3, #3
	DCD	0x0a000015 ;	beq	90 <pixman_composite_add_8_8_asm_armv6+0x90>
	DCD	0xe1a01008 ;	mov	r1, r8
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe1a0c00b ;	mov	ip, fp
	DCD	0xea000001 ;	b	50 <pixman_composite_add_8_8_asm_armv6+0x50>
	DCD	0xe3130003 ;	tst	r3, #3
	DCD	0x0a000012 ;	beq	9c <pixman_composite_add_8_8_asm_armv6+0x9c>
	DCD	0xe4d02001 ;	ldrb	r2, [r0], #1
	DCD	0xe25cc001 ;	subs	ip, ip, #1
	DCD	0xe5d13000 ;	ldrb	r3, [r1]
	DCD	0xe6623f93 ;	uqadd8	r3, r2, r3
	DCD	0xe4c13001 ;	strb	r3, [r1], #1
	DCD	0xe1813000 ;	orr	r3, r1, r0
	DCD	0x1afffff6 ;	bne	48 <pixman_composite_add_8_8_asm_armv6+0x48>
	DCD	0xe59d3000 ;	ldr	r3, [sp]
	DCD	0xe0888003 ;	add	r8, r8, r3
	DCD	0xe59d3028 ;	ldr	r3, [sp, #40]	; 0x28
	DCD	0xe0877003 ;	add	r7, r7, r3
	DCD	0xe25aa001 ;	subs	sl, sl, #1
	DCD	0x2affffe7 ;	bcs	24 <pixman_composite_add_8_8_asm_armv6+0x24>
	DCD	0xe28dd004 ;	add	sp, sp, #4
	DCD	0xe8bd0ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp}
	DCD	0xe12fff1e ;	bx	lr
	;		8c: R_ARM_V4BX	*ABS*
	DCD	0xe1a0c00b ;	mov	ip, fp
	DCD	0xe1a01008 ;	mov	r1, r8
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe35c0003 ;	cmp	ip, #3
	DCD	0xc24c6004 ;	subgt	r6, ip, #4
	DCD	0xc1a0900c ;	movgt	r9, ip
	DCD	0xc1a05126 ;	lsrgt	r5, r6, #2
	DCD	0xc2853001 ;	addgt	r3, r5, #1
	DCD	0xc3a0c000 ;	movgt	ip, #0
	DCD	0xc1a04103 ;	lslgt	r4, r3, #2
	DCD	0xda00000d ;	ble	f4 <pixman_composite_add_8_8_asm_armv6+0xf4>
	DCD	0xe790300c ;	ldr	r3, [r0, ip]
	DCD	0xe791200c ;	ldr	r2, [r1, ip]
	DCD	0xe6633f92 ;	uqadd8	r3, r3, r2
	DCD	0xe781300c ;	str	r3, [r1, ip]
	DCD	0xe28cc004 ;	add	ip, ip, #4
	DCD	0xe15c0004 ;	cmp	ip, r4
	DCD	0x1afffff8 ;	bne	bc <pixman_composite_add_8_8_asm_armv6+0xbc>
	DCD	0xe2493004 ;	sub	r3, r9, #4
	DCD	0xe3c33003 ;	bic	r3, r3, #3
	DCD	0xe2833004 ;	add	r3, r3, #4
	DCD	0xe056c105 ;	subs	ip, r6, r5, lsl #2
	DCD	0xe0811003 ;	add	r1, r1, r3
	DCD	0xe0800003 ;	add	r0, r0, r3
	DCD	0x0affffdd ;	beq	6c <pixman_composite_add_8_8_asm_armv6+0x6c>
	DCD	0xe3a04000 ;	mov	r4, #0
	DCD	0xe7d13004 ;	ldrb	r3, [r1, r4]
	DCD	0xe7d02004 ;	ldrb	r2, [r0, r4]
	DCD	0xe6623f93 ;	uqadd8	r3, r2, r3
	DCD	0xe7c13004 ;	strb	r3, [r1, r4]
	DCD	0xe2844001 ;	add	r4, r4, #1
	DCD	0xe154000c ;	cmp	r4, ip
	DCD	0x1afffff8 ;	bne	f8 <pixman_composite_add_8_8_asm_armv6+0xf8>
	DCD	0xe59d3000 ;	ldr	r3, [sp]
	DCD	0xe0888003 ;	add	r8, r8, r3
	DCD	0xe59d3028 ;	ldr	r3, [sp, #40]	; 0x28
	DCD	0xe0877003 ;	add	r7, r7, r3
	DCD	0xeaffffd4 ;	b	7c <pixman_composite_add_8_8_asm_armv6+0x7c>
	ENDP  ; |pixman_composite_add_8_8_asm_armv6|

|pixman_composite_over_8888_8888_asm_armv6| PROC
	DCD	0xe92d0ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp}
	DCD	0xe24dd014 ;	sub	sp, sp, #20
	DCD	0xe3510000 ;	cmp	r1, #0
	DCD	0xe1a0c002 ;	mov	ip, r2
	DCD	0xe58d100c ;	str	r1, [sp, #12]
	DCD	0xe58d0010 ;	str	r0, [sp, #16]
	DCD	0xe59d2034 ;	ldr	r2, [sp, #52]	; 0x34
	DCD	0x0a000028 ;	beq	1ec <pixman_composite_over_8888_8888_asm_armv6+0xc4>
	DCD	0xe1a03103 ;	lsl	r3, r3, #2
	DCD	0xe58d3000 ;	str	r3, [sp]
	DCD	0xe59d3038 ;	ldr	r3, [sp, #56]	; 0x38
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe1a03103 ;	lsl	r3, r3, #2
	DCD	0xe58d3008 ;	str	r3, [sp, #8]
	DCD	0xe1a0b003 ;	mov	fp, r3
	DCD	0xea000000 ;	b	16c <pixman_composite_over_8888_8888_asm_armv6+0x44>
	DCD	0xe59db008 ;	ldr	fp, [sp, #8]
	DCD	0xe59d9000 ;	ldr	r9, [sp]
	DCD	0xe1a0000c ;	mov	r0, ip
	DCD	0xe08cc009 ;	add	ip, ip, r9
	DCD	0xe1a01002 ;	mov	r1, r2
	DCD	0xe58dc004 ;	str	ip, [sp, #4]
	DCD	0xe082200b ;	add	r2, r2, fp
	DCD	0xe59dc010 ;	ldr	ip, [sp, #16]
	DCD	0xe59f3504 ;	ldr	r3, [pc, #1284]	; 694 <pixman_scaled_nearest_scanline_8888_8888_SRC_asm_armv6+0x140>
	DCD	0xe59f9504 ;	ldr	r9, [pc, #1284]	; 698 <pixman_scaled_nearest_scanline_8888_8888_SRC_asm_armv6+0x144>
	DCD	0xe3a0b0ff ;	mov	fp, #255	; 0xff
	DCD	0xe35c0000 ;	cmp	ip, #0
	DCD	0x0a00000e ;	beq	1d8 <pixman_composite_over_8888_8888_asm_armv6+0xb0>
	DCD	0xe4915004 ;	ldr	r5, [r1], #4
	DCD	0xe5904000 ;	ldr	r4, [r0]
	DCD	0xe04b8c25 ;	sub	r8, fp, r5, lsr #24
	DCD	0xe6cf6074 ;	uxtb16	r6, r4
	DCD	0xe6cf7474 ;	uxtb16	r7, r4, ror #8
	DCD	0xe0263896 ;	mla	r6, r6, r8, r3
	DCD	0xe0273897 ;	mla	r7, r7, r8, r3
	DCD	0xe6c66476 ;	uxtab16	r6, r6, r6, ror #8
	DCD	0xe6c77477 ;	uxtab16	r7, r7, r7, ror #8
	DCD	0xe0077009 ;	and	r7, r7, r9
	DCD	0xe6c76476 ;	uxtab16	r6, r7, r6, ror #8
	DCD	0xe6665f95 ;	uqadd8	r5, r6, r5
	DCD	0xe4805004 ;	str	r5, [r0], #4
	DCD	0xe25cc001 ;	subs	ip, ip, #1
	DCD	0x1afffff0 ;	bne	19c <pixman_composite_over_8888_8888_asm_armv6+0x74>
	DCD	0xe59d300c ;	ldr	r3, [sp, #12]
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe15a0003 ;	cmp	sl, r3
	DCD	0xe59dc004 ;	ldr	ip, [sp, #4]
	DCD	0x1affffde ;	bne	168 <pixman_composite_over_8888_8888_asm_armv6+0x40>
	DCD	0xe28dd014 ;	add	sp, sp, #20
	DCD	0xe8bd0ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp}
	DCD	0xe12fff1e ;	bx	lr
	;		1f4: R_ARM_V4BX	*ABS*
	ENDP  ; |pixman_composite_over_8888_8888_asm_armv6|

|pixman_composite_over_8888_n_8888_asm_armv6| PROC
	DCD	0xe92d0ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp}
	DCD	0xe24dd01c ;	sub	sp, sp, #28
	DCD	0xe3510000 ;	cmp	r1, #0
	DCD	0xe58d100c ;	str	r1, [sp, #12]
	DCD	0xe5dd1047 ;	ldrb	r1, [sp, #71]	; 0x47
	DCD	0xe1a0c002 ;	mov	ip, r2
	DCD	0xe58d0010 ;	str	r0, [sp, #16]
	DCD	0xe59d203c ;	ldr	r2, [sp, #60]	; 0x3c
	DCD	0xe58d1018 ;	str	r1, [sp, #24]
	DCD	0x0a000034 ;	beq	2f4 <pixman_composite_over_8888_n_8888_asm_armv6+0xfc>
	DCD	0xe1a03103 ;	lsl	r3, r3, #2
	DCD	0xe58d3014 ;	str	r3, [sp, #20]
	DCD	0xe59d3040 ;	ldr	r3, [sp, #64]	; 0x40
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe1a03103 ;	lsl	r3, r3, #2
	DCD	0xe58d3008 ;	str	r3, [sp, #8]
	DCD	0xe1a0b003 ;	mov	fp, r3
	DCD	0xea000000 ;	b	244 <pixman_composite_over_8888_n_8888_asm_armv6+0x4c>
	DCD	0xe59db008 ;	ldr	fp, [sp, #8]
	DCD	0xe59d4014 ;	ldr	r4, [sp, #20]
	DCD	0xe1a0000c ;	mov	r0, ip
	DCD	0xe1a01002 ;	mov	r1, r2
	DCD	0xe08cc004 ;	add	ip, ip, r4
	DCD	0xe082200b ;	add	r2, r2, fp
	DCD	0xe58dc000 ;	str	ip, [sp]
	DCD	0xe58d2004 ;	str	r2, [sp, #4]
	DCD	0xe59dc010 ;	ldr	ip, [sp, #16]
	DCD	0xe59f2428 ;	ldr	r2, [pc, #1064]	; 694 <pixman_scaled_nearest_scanline_8888_8888_SRC_asm_armv6+0x140>
	DCD	0xe59d3018 ;	ldr	r3, [sp, #24]
	DCD	0xe3a0b0ff ;	mov	fp, #255	; 0xff
	DCD	0xe35c0000 ;	cmp	ip, #0
	DCD	0x0a000018 ;	beq	2dc <pixman_composite_over_8888_n_8888_asm_armv6+0xe4>
	DCD	0xe4915004 ;	ldr	r5, [r1], #4
	DCD	0xe5904000 ;	ldr	r4, [r0]
	DCD	0xe6cf6075 ;	uxtb16	r6, r5
	DCD	0xe6cf7475 ;	uxtb16	r7, r5, ror #8
	DCD	0xe0262396 ;	mla	r6, r6, r3, r2
	DCD	0xe0272397 ;	mla	r7, r7, r3, r2
	DCD	0xe6c66476 ;	uxtab16	r6, r6, r6, ror #8
	DCD	0xe6c77477 ;	uxtab16	r7, r7, r7, ror #8
	DCD	0xe6cf6476 ;	uxtb16	r6, r6, ror #8
	DCD	0xe6cf7477 ;	uxtb16	r7, r7, ror #8
	DCD	0xe1865407 ;	orr	r5, r6, r7, lsl #8
	DCD	0xe6cf6074 ;	uxtb16	r6, r4
	DCD	0xe6cf7474 ;	uxtb16	r7, r4, ror #8
	DCD	0xe04b8c25 ;	sub	r8, fp, r5, lsr #24
	DCD	0xe0262896 ;	mla	r6, r6, r8, r2
	DCD	0xe0272897 ;	mla	r7, r7, r8, r2
	DCD	0xe6c66476 ;	uxtab16	r6, r6, r6, ror #8
	DCD	0xe6c77477 ;	uxtab16	r7, r7, r7, ror #8
	DCD	0xe6cf6476 ;	uxtb16	r6, r6, ror #8
	DCD	0xe6cf7477 ;	uxtb16	r7, r7, ror #8
	DCD	0xe1866407 ;	orr	r6, r6, r7, lsl #8
	DCD	0xe6665f95 ;	uqadd8	r5, r6, r5
	DCD	0xe4805004 ;	str	r5, [r0], #4
	DCD	0xe25cc001 ;	subs	ip, ip, #1
	DCD	0x1affffe6 ;	bne	278 <pixman_composite_over_8888_n_8888_asm_armv6+0x80>
	DCD	0xe59d100c ;	ldr	r1, [sp, #12]
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xe59dc000 ;	ldr	ip, [sp]
	DCD	0xe59d2004 ;	ldr	r2, [sp, #4]
	DCD	0x1affffd2 ;	bne	240 <pixman_composite_over_8888_n_8888_asm_armv6+0x48>
	DCD	0xe28dd01c ;	add	sp, sp, #28
	DCD	0xe8bd0ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp}
	DCD	0xe12fff1e ;	bx	lr
	;		2fc: R_ARM_V4BX	*ABS*
	ENDP  ; |pixman_composite_over_8888_n_8888_asm_armv6|

|pixman_composite_over_n_8_8888_asm_armv6| PROC
	DCD	0xe92d0ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp}
	DCD	0xe24dd01c ;	sub	sp, sp, #28
	DCD	0xe3510000 ;	cmp	r1, #0
	DCD	0xe59d903c ;	ldr	r9, [sp, #60]	; 0x3c
	DCD	0xe58d100c ;	str	r1, [sp, #12]
	DCD	0xe3c914ff ;	bic	r1, r9, #-16777216	; 0xff000000
	DCD	0xe58d1014 ;	str	r1, [sp, #20]
	DCD	0xe1a0c002 ;	mov	ip, r2
	DCD	0xe1a01429 ;	lsr	r1, r9, #8
	DCD	0xe59d2014 ;	ldr	r2, [sp, #20]
	DCD	0xe3c114ff ;	bic	r1, r1, #-16777216	; 0xff000000
	DCD	0xe3c22cff ;	bic	r2, r2, #65280	; 0xff00
	DCD	0xe3c11cff ;	bic	r1, r1, #65280	; 0xff00
	DCD	0xe58d2014 ;	str	r2, [sp, #20]
	DCD	0xe58d0010 ;	str	r0, [sp, #16]
	DCD	0xe58d1004 ;	str	r1, [sp, #4]
	DCD	0xe59d2044 ;	ldr	r2, [sp, #68]	; 0x44
	DCD	0x0a00002f ;	beq	408 <pixman_composite_over_n_8_8888_asm_armv6+0x108>
	DCD	0xe1a03103 ;	lsl	r3, r3, #2
	DCD	0xe58d3018 ;	str	r3, [sp, #24]
	DCD	0xe3a00000 ;	mov	r0, #0
	DCD	0xea000000 ;	b	35c <pixman_composite_over_n_8_8888_asm_armv6+0x5c>
	DCD	0xe59d3018 ;	ldr	r3, [sp, #24]
	DCD	0xe59d4048 ;	ldr	r4, [sp, #72]	; 0x48
	DCD	0xe1a0a00c ;	mov	sl, ip
	DCD	0xe1a01002 ;	mov	r1, r2
	DCD	0xe08cc003 ;	add	ip, ip, r3
	DCD	0xe0822004 ;	add	r2, r2, r4
	DCD	0xe58dc008 ;	str	ip, [sp, #8]
	DCD	0xe58d2000 ;	str	r2, [sp]
	DCD	0xe59dc010 ;	ldr	ip, [sp, #16]
	DCD	0xe59fb310 ;	ldr	fp, [pc, #784]	; 694 <pixman_scaled_nearest_scanline_8888_8888_SRC_asm_armv6+0x140>
	DCD	0xe59d2004 ;	ldr	r2, [sp, #4]
	DCD	0xe59d3014 ;	ldr	r3, [sp, #20]
	DCD	0xe35c0000 ;	cmp	ip, #0
	DCD	0x0a000017 ;	beq	3f0 <pixman_composite_over_n_8_8888_asm_armv6+0xf0>
	DCD	0xe4d15001 ;	ldrb	r5, [r1], #1
	DCD	0xe59a4000 ;	ldr	r4, [sl]
	DCD	0xe026b593 ;	mla	r6, r3, r5, fp
	DCD	0xe027b592 ;	mla	r7, r2, r5, fp
	DCD	0xe6c66476 ;	uxtab16	r6, r6, r6, ror #8
	DCD	0xe6c77477 ;	uxtab16	r7, r7, r7, ror #8
	DCD	0xe6cf6476 ;	uxtb16	r6, r6, ror #8
	DCD	0xe6cf7477 ;	uxtb16	r7, r7, ror #8
	DCD	0xe1865407 ;	orr	r5, r6, r7, lsl #8
	DCD	0xe6cf6074 ;	uxtb16	r6, r4
	DCD	0xe6cf7474 ;	uxtb16	r7, r4, ror #8
	DCD	0xe1e08005 ;	mvn	r8, r5
	DCD	0xe1a08c28 ;	lsr	r8, r8, #24
	DCD	0xe026b896 ;	mla	r6, r6, r8, fp
	DCD	0xe027b897 ;	mla	r7, r7, r8, fp
	DCD	0xe6c66476 ;	uxtab16	r6, r6, r6, ror #8
	DCD	0xe6c77477 ;	uxtab16	r7, r7, r7, ror #8
	DCD	0xe6cf6476 ;	uxtb16	r6, r6, ror #8
	DCD	0xe6cf7477 ;	uxtb16	r7, r7, ror #8
	DCD	0xe1866407 ;	orr	r6, r6, r7, lsl #8
	DCD	0xe6665f95 ;	uqadd8	r5, r6, r5
	DCD	0xe48a5004 ;	str	r5, [sl], #4
	DCD	0xe25cc001 ;	subs	ip, ip, #1
	DCD	0x1affffe7 ;	bne	390 <pixman_composite_over_n_8_8888_asm_armv6+0x90>
	DCD	0xe59d400c ;	ldr	r4, [sp, #12]
	DCD	0xe2800001 ;	add	r0, r0, #1
	DCD	0xe1500004 ;	cmp	r0, r4
	DCD	0xe59dc008 ;	ldr	ip, [sp, #8]
	DCD	0xe59d2000 ;	ldr	r2, [sp]
	DCD	0x1affffd3 ;	bne	358 <pixman_composite_over_n_8_8888_asm_armv6+0x58>
	DCD	0xe28dd01c ;	add	sp, sp, #28
	DCD	0xe8bd0ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp}
	DCD	0xe12fff1e ;	bx	lr
	;		410: R_ARM_V4BX	*ABS*
	ENDP  ; |pixman_composite_over_n_8_8888_asm_armv6|

|pixman_scaled_nearest_scanline_0565_0565_SRC_asm_armv6| PROC
	DCD	0xe59dc000 ;	ldr	ip, [sp]
	DCD	0xe92d00f0 ;	push	{r4, r5, r6, r7}
	DCD	0xe3e06001 ;	mvn	r6, #1
	DCD	0xe00647a3 ;	and	r4, r6, r3, lsr #15
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe2500028 ;	subs	r0, r0, #40	; 0x28
	DCD	0xba000025 ;	blt	4c8 <pixman_scaled_nearest_scanline_0565_0565_SRC_asm_armv6+0xb4>
	DCD	0xe3a07050 ;	mov	r7, #80	; 0x50
	DCD	0xe027379c ;	mla	r7, ip, r7, r3
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xe087718c ;	add	r7, r7, ip, lsl #3
	DCD	0xe19240b4 ;	ldrh	r4, [r2, r4]
	DCD	0xe00657a3 ;	and	r5, r6, r3, lsr #15
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0c140b2 ;	strh	r4, [r1], #2
	DCD	0xe19250b5 ;	ldrh	r5, [r2, r5]
	DCD	0xe00647a3 ;	and	r4, r6, r3, lsr #15
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0c150b2 ;	strh	r5, [r1], #2
	DCD	0xe19240b4 ;	ldrh	r4, [r2, r4]
	DCD	0xe00657a3 ;	and	r5, r6, r3, lsr #15
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0c140b2 ;	strh	r4, [r1], #2
	DCD	0xe19250b5 ;	ldrh	r5, [r2, r5]
	DCD	0xe00647a3 ;	and	r4, r6, r3, lsr #15
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0c150b2 ;	strh	r5, [r1], #2
	DCD	0xe19240b4 ;	ldrh	r4, [r2, r4]
	DCD	0xe00657a3 ;	and	r5, r6, r3, lsr #15
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0c140b2 ;	strh	r4, [r1], #2
	DCD	0xe19250b5 ;	ldrh	r5, [r2, r5]
	DCD	0xe00647a3 ;	and	r4, r6, r3, lsr #15
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0c150b2 ;	strh	r5, [r1], #2
	DCD	0xe19240b4 ;	ldrh	r4, [r2, r4]
	DCD	0xe00657a3 ;	and	r5, r6, r3, lsr #15
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0c140b2 ;	strh	r4, [r1], #2
	DCD	0xe19250b5 ;	ldrh	r5, [r2, r5]
	DCD	0xe00647a3 ;	and	r4, r6, r3, lsr #15
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0c150b2 ;	strh	r5, [r1], #2
	DCD	0xf7d2f7a7 ;	pld	[r2, r7, lsr #15]
	DCD	0xaaffffdb ;	bge	438 <pixman_scaled_nearest_scanline_0565_0565_SRC_asm_armv6+0x24>
	DCD	0xe2900024 ;	adds	r0, r0, #36	; 0x24
	DCD	0xba000011 ;	blt	518 <pixman_scaled_nearest_scanline_0565_0565_SRC_asm_armv6+0x104>
	DCD	0xe19240b4 ;	ldrh	r4, [r2, r4]
	DCD	0xe00657a3 ;	and	r5, r6, r3, lsr #15
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0c140b2 ;	strh	r4, [r1], #2
	DCD	0xe19250b5 ;	ldrh	r5, [r2, r5]
	DCD	0xe00647a3 ;	and	r4, r6, r3, lsr #15
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0c150b2 ;	strh	r5, [r1], #2
	DCD	0xe19240b4 ;	ldrh	r4, [r2, r4]
	DCD	0xe00657a3 ;	and	r5, r6, r3, lsr #15
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0c140b2 ;	strh	r4, [r1], #2
	DCD	0xe19250b5 ;	ldrh	r5, [r2, r5]
	DCD	0xe00647a3 ;	and	r4, r6, r3, lsr #15
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0c150b2 ;	strh	r5, [r1], #2
	DCD	0xe2500004 ;	subs	r0, r0, #4
	DCD	0xaaffffed ;	bge	4d0 <pixman_scaled_nearest_scanline_0565_0565_SRC_asm_armv6+0xbc>
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000007 ;	beq	540 <pixman_scaled_nearest_scanline_0565_0565_SRC_asm_armv6+0x12c>
	DCD	0xe19240b4 ;	ldrh	r4, [r2, r4]
	DCD	0xe00657a3 ;	and	r5, r6, r3, lsr #15
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0c140b2 ;	strh	r4, [r1], #2
	DCD	0xe19250b5 ;	ldrh	r5, [r2, r5]
	DCD	0xe00647a3 ;	and	r4, r6, r3, lsr #15
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0c150b2 ;	strh	r5, [r1], #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x119240b4 ;	ldrhne	r4, [r2, r4]
	DCD	0x11c140b0 ;	strhne	r4, [r1]
	DCD	0xe8bd00f0 ;	pop	{r4, r5, r6, r7}
	DCD	0xe12fff1e ;	bx	lr
	;		550: R_ARM_V4BX	*ABS*
	ENDP  ; |pixman_scaled_nearest_scanline_0565_0565_SRC_asm_armv6|

|pixman_scaled_nearest_scanline_8888_8888_SRC_asm_armv6| PROC
	DCD	0xe59dc000 ;	ldr	ip, [sp]
	DCD	0xe92d00f0 ;	push	{r4, r5, r6, r7}
	DCD	0xe3e06003 ;	mvn	r6, #3
	DCD	0xe0064723 ;	and	r4, r6, r3, lsr #14
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe2500028 ;	subs	r0, r0, #40	; 0x28
	DCD	0xba000025 ;	blt	608 <pixman_scaled_nearest_scanline_8888_8888_SRC_asm_armv6+0xb4>
	DCD	0xe3a07030 ;	mov	r7, #48	; 0x30
	DCD	0xe027379c ;	mla	r7, ip, r7, r3
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xe087718c ;	add	r7, r7, ip, lsl #3
	DCD	0xe7924004 ;	ldr	r4, [r2, r4]
	DCD	0xe0065723 ;	and	r5, r6, r3, lsr #14
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe4814004 ;	str	r4, [r1], #4
	DCD	0xe7925005 ;	ldr	r5, [r2, r5]
	DCD	0xe0064723 ;	and	r4, r6, r3, lsr #14
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe4815004 ;	str	r5, [r1], #4
	DCD	0xe7924004 ;	ldr	r4, [r2, r4]
	DCD	0xe0065723 ;	and	r5, r6, r3, lsr #14
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe4814004 ;	str	r4, [r1], #4
	DCD	0xe7925005 ;	ldr	r5, [r2, r5]
	DCD	0xe0064723 ;	and	r4, r6, r3, lsr #14
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe4815004 ;	str	r5, [r1], #4
	DCD	0xe7924004 ;	ldr	r4, [r2, r4]
	DCD	0xe0065723 ;	and	r5, r6, r3, lsr #14
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe4814004 ;	str	r4, [r1], #4
	DCD	0xe7925005 ;	ldr	r5, [r2, r5]
	DCD	0xe0064723 ;	and	r4, r6, r3, lsr #14
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe4815004 ;	str	r5, [r1], #4
	DCD	0xe7924004 ;	ldr	r4, [r2, r4]
	DCD	0xe0065723 ;	and	r5, r6, r3, lsr #14
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe4814004 ;	str	r4, [r1], #4
	DCD	0xe7925005 ;	ldr	r5, [r2, r5]
	DCD	0xe0064723 ;	and	r4, r6, r3, lsr #14
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe4815004 ;	str	r5, [r1], #4
	DCD	0xf7d2f727 ;	pld	[r2, r7, lsr #14]
	DCD	0xaaffffdb ;	bge	578 <pixman_scaled_nearest_scanline_8888_8888_SRC_asm_armv6+0x24>
	DCD	0xe2900024 ;	adds	r0, r0, #36	; 0x24
	DCD	0xba000011 ;	blt	658 <pixman_scaled_nearest_scanline_8888_8888_SRC_asm_armv6+0x104>
	DCD	0xe7924004 ;	ldr	r4, [r2, r4]
	DCD	0xe0065723 ;	and	r5, r6, r3, lsr #14
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe4814004 ;	str	r4, [r1], #4
	DCD	0xe7925005 ;	ldr	r5, [r2, r5]
	DCD	0xe0064723 ;	and	r4, r6, r3, lsr #14
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe4815004 ;	str	r5, [r1], #4
	DCD	0xe7924004 ;	ldr	r4, [r2, r4]
	DCD	0xe0065723 ;	and	r5, r6, r3, lsr #14
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe4814004 ;	str	r4, [r1], #4
	DCD	0xe7925005 ;	ldr	r5, [r2, r5]
	DCD	0xe0064723 ;	and	r4, r6, r3, lsr #14
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe4815004 ;	str	r5, [r1], #4
	DCD	0xe2500004 ;	subs	r0, r0, #4
	DCD	0xaaffffed ;	bge	610 <pixman_scaled_nearest_scanline_8888_8888_SRC_asm_armv6+0xbc>
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000007 ;	beq	680 <pixman_scaled_nearest_scanline_8888_8888_SRC_asm_armv6+0x12c>
	DCD	0xe7924004 ;	ldr	r4, [r2, r4]
	DCD	0xe0065723 ;	and	r5, r6, r3, lsr #14
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe4814004 ;	str	r4, [r1], #4
	DCD	0xe7925005 ;	ldr	r5, [r2, r5]
	DCD	0xe0064723 ;	and	r4, r6, r3, lsr #14
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe4815004 ;	str	r5, [r1], #4
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x17924004 ;	ldrne	r4, [r2, r4]
	DCD	0x15814000 ;	strne	r4, [r1]
	DCD	0xe8bd00f0 ;	pop	{r4, r5, r6, r7}
	DCD	0xe12fff1e ;	bx	lr
	;		690: R_ARM_V4BX	*ABS*
	DCD	0x00800080 ;	addeq	r0, r0, r0, lsl #1
	DCD	0xff00ff00 ;			; <UNDEFINED> instruction: 0xff00ff00
	ENDP  ; |pixman_scaled_nearest_scanline_8888_8888_SRC_asm_armv6|

	END
