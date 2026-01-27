	CODE32

	IMPORT	|ff_vp56_norm_shift|
	IMPORT	|ff_vp8_dct_cat_prob|

	EXPORT	|ff_decode_block_coeffs_armv6|

	AREA	|.text|, CODE, ARM
|ff_decode_block_coeffs_armv6| PROC
	DCD	0xe92d4ff3 ;	push	{r0, r1, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	DCD	0xe59fe4ec ;	ldr	lr, [pc, #1260]	; 4f8 <ff_decode_block_coeffs_armv6+0x4f8>
	DCD	0xe1cd42dc ;	ldrd	r4, [sp, #44]	; 0x2c
	DCD	0xe3530000 ;	cmp	r3, #0
	DCD	0xe595b000 ;	ldr	fp, [r5]
	DCD	0xe89000e0 ;	ldm	r0, {r5, r6, r7}
	DCD	0x168bb85b ;	pkhtbne	fp, fp, fp, asr #16
	DCD	0xe5908010 ;	ldr	r8, [r0, #16]
	DCD	0xe7de9005 ;	ldrb	r9, [lr, r5]
	DCD	0xe2833001 ;	add	r3, r3, #1
	DCD	0xe5d40001 ;	ldrb	r0, [r4, #1]
	DCD	0xe0966009 ;	adds	r6, r6, r9
	DCD	0xe1a08918 ;	lsl	r8, r8, r9
	DCD	0xe1a09915 ;	lsl	r9, r5, r9
	DCD	0xe2605c01 ;	rsb	r5, r0, #256	; 0x100
	DCD	0x20d7a0b2 ;	ldrhcs	sl, [r7], #2
	DCD	0xe1055089 ;	smlabb	r5, r9, r0, r5
	DCD	0x26bfafba ;	rev16cs	sl, sl
	DCD	0x2188861a ;	orrcs	r8, r8, sl, lsl r6
	DCD	0x22466010 ;	subcs	r6, r6, #16
	DCD	0xe1a05425 ;	lsr	r5, r5, #8
	DCD	0xe1580805 ;	cmp	r8, r5, lsl #16
	DCD	0xa0488805 ;	subge	r8, r8, r5, lsl #16
	DCD	0xa0495005 ;	subge	r5, r9, r5
	DCD	0xba000041 ;	blt	16c <ff_decode_block_coeffs_armv6+0x16c>
	DCD	0xe7de9005 ;	ldrb	r9, [lr, r5]
	DCD	0xe5d40002 ;	ldrb	r0, [r4, #2]
	DCD	0xe0966009 ;	adds	r6, r6, r9
	DCD	0xe1a08918 ;	lsl	r8, r8, r9
	DCD	0xe1a09915 ;	lsl	r9, r5, r9
	DCD	0xe2605c01 ;	rsb	r5, r0, #256	; 0x100
	DCD	0x20d7a0b2 ;	ldrhcs	sl, [r7], #2
	DCD	0xe1055089 ;	smlabb	r5, r9, r0, r5
	DCD	0x26bfafba ;	rev16cs	sl, sl
	DCD	0x2188861a ;	orrcs	r8, r8, sl, lsl r6
	DCD	0x22466010 ;	subcs	r6, r6, #16
	DCD	0xe1a05425 ;	lsr	r5, r5, #8
	DCD	0xe1580805 ;	cmp	r8, r5, lsl #16
	DCD	0xa0488805 ;	subge	r8, r8, r5, lsl #16
	DCD	0xa0495005 ;	subge	r5, r9, r5
	DCD	0xe7de9005 ;	ldrb	r9, [lr, r5]
	DCD	0xaa000036 ;	bge	184 <ff_decode_block_coeffs_armv6+0x184>
	DCD	0xe0834283 ;	add	r4, r3, r3, lsl #5
	DCD	0xe6bfc07b ;	sxth	ip, fp
	DCD	0xe0824004 ;	add	r4, r2, r4
	DCD	0xe0966009 ;	adds	r6, r6, r9
	DCD	0xe284400b ;	add	r4, r4, #11
	DCD	0xe1a08918 ;	lsl	r8, r8, r9
	DCD	0x20d7a0b2 ;	ldrhcs	sl, [r7], #2
	DCD	0xe1a09915 ;	lsl	r9, r5, r9
	DCD	0xe3a05080 ;	mov	r5, #128	; 0x80
	DCD	0x26bfafba ;	rev16cs	sl, sl
	DCD	0xe0855389 ;	add	r5, r5, r9, lsl #7
	DCD	0x2188861a ;	orrcs	r8, r8, sl, lsl r6
	DCD	0x22466010 ;	subcs	r6, r6, #16
	DCD	0xe1a05425 ;	lsr	r5, r5, #8
	DCD	0xe1580805 ;	cmp	r8, r5, lsl #16
	DCD	0xe59fa410 ;	ldr	sl, [pc, #1040]	; 4fc <ff_decode_block_coeffs_armv6+0x4fc>
	DCD	0xa0488805 ;	subge	r8, r8, r5, lsl #16
	DCD	0xa0495005 ;	subge	r5, r9, r5
	DCD	0xe7daa003 ;	ldrb	sl, [sl, r3]
	DCD	0xa26cc000 ;	rsbge	ip, ip, #0
	DCD	0xe3530010 ;	cmp	r3, #16
	DCD	0xe181c0ba ;	strh	ip, [r1, sl]
	DCD	0xaa000010 ;	bge	148 <ff_decode_block_coeffs_armv6+0x148>
	DCD	0xe7de9005 ;	ldrb	r9, [lr, r5]
	DCD	0xe5d40000 ;	ldrb	r0, [r4]
	DCD	0xe0966009 ;	adds	r6, r6, r9
	DCD	0xe1a08918 ;	lsl	r8, r8, r9
	DCD	0xe1a09915 ;	lsl	r9, r5, r9
	DCD	0xe2605c01 ;	rsb	r5, r0, #256	; 0x100
	DCD	0x20d7a0b2 ;	ldrhcs	sl, [r7], #2
	DCD	0xe1055089 ;	smlabb	r5, r9, r0, r5
	DCD	0x26bfafba ;	rev16cs	sl, sl
	DCD	0x2188861a ;	orrcs	r8, r8, sl, lsl r6
	DCD	0x22466010 ;	subcs	r6, r6, #16
	DCD	0xe1a05425 ;	lsr	r5, r5, #8
	DCD	0xe1580805 ;	cmp	r8, r5, lsl #16
	DCD	0xa0488805 ;	subge	r8, r8, r5, lsl #16
	DCD	0xa0495005 ;	subge	r5, r9, r5
	DCD	0xe68bb85b ;	pkhtb	fp, fp, fp, asr #16
	DCD	0xaaffffb5 ;	bge	20 <ff_decode_block_coeffs_armv6+0x20>
	DCD	0xe59d0000 ;	ldr	r0, [sp]
	DCD	0xe590900c ;	ldr	r9, [r0, #12]
	DCD	0xe1570009 ;	cmp	r7, r9
	DCD	0x81a07009 ;	movhi	r7, r9
	DCD	0xe88000e0 ;	stm	r0, {r5, r6, r7}
	DCD	0xe5808010 ;	str	r8, [r0, #16]
	DCD	0xe28dd008 ;	add	sp, sp, #8
	DCD	0xe1a00003 ;	mov	r0, r3
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	DCD	0xe0834283 ;	add	r4, r3, r3, lsl #5
	DCD	0xe3530010 ;	cmp	r3, #16
	DCD	0xe0824004 ;	add	r4, r2, r4
	DCD	0xe68bb85b ;	pkhtb	fp, fp, fp, asr #16
	DCD	0x1affffa7 ;	bne	20 <ff_decode_block_coeffs_armv6+0x20>
	DCD	0xeafffff0 ;	b	148 <ff_decode_block_coeffs_armv6+0x148>
	DCD	0xe5d40003 ;	ldrb	r0, [r4, #3]
	DCD	0xe0966009 ;	adds	r6, r6, r9
	DCD	0xe1a08918 ;	lsl	r8, r8, r9
	DCD	0xe1a09915 ;	lsl	r9, r5, r9
	DCD	0xe2605c01 ;	rsb	r5, r0, #256	; 0x100
	DCD	0x20d7a0b2 ;	ldrhcs	sl, [r7], #2
	DCD	0xe1055089 ;	smlabb	r5, r9, r0, r5
	DCD	0x26bfafba ;	rev16cs	sl, sl
	DCD	0x2188861a ;	orrcs	r8, r8, sl, lsl r6
	DCD	0x22466010 ;	subcs	r6, r6, #16
	DCD	0xe1a05425 ;	lsr	r5, r5, #8
	DCD	0xe1580805 ;	cmp	r8, r5, lsl #16
	DCD	0xa0488805 ;	subge	r8, r8, r5, lsl #16
	DCD	0xa0495005 ;	subge	r5, r9, r5
	DCD	0xe7de9005 ;	ldrb	r9, [lr, r5]
	DCD	0xaa000022 ;	bge	250 <ff_decode_block_coeffs_armv6+0x250>
	DCD	0xe3a0c002 ;	mov	ip, #2
	DCD	0xe5d40004 ;	ldrb	r0, [r4, #4]
	DCD	0xe0966009 ;	adds	r6, r6, r9
	DCD	0xe1a08918 ;	lsl	r8, r8, r9
	DCD	0xe1a09915 ;	lsl	r9, r5, r9
	DCD	0xe2605c01 ;	rsb	r5, r0, #256	; 0x100
	DCD	0x20d7a0b2 ;	ldrhcs	sl, [r7], #2
	DCD	0xe1055089 ;	smlabb	r5, r9, r0, r5
	DCD	0x26bfafba ;	rev16cs	sl, sl
	DCD	0x2188861a ;	orrcs	r8, r8, sl, lsl r6
	DCD	0x22466010 ;	subcs	r6, r6, #16
	DCD	0xe1a05425 ;	lsr	r5, r5, #8
	DCD	0xe1580805 ;	cmp	r8, r5, lsl #16
	DCD	0xa0488805 ;	subge	r8, r8, r5, lsl #16
	DCD	0xa0495005 ;	subge	r5, r9, r5
	DCD	0xa28cc001 ;	addge	ip, ip, #1
	DCD	0xe7de9005 ;	ldrb	r9, [lr, r5]
	DCD	0xba0000a2 ;	blt	498 <ff_decode_block_coeffs_armv6+0x498>
	DCD	0xe5d40005 ;	ldrb	r0, [r4, #5]
	DCD	0xe0966009 ;	adds	r6, r6, r9
	DCD	0xe1a08918 ;	lsl	r8, r8, r9
	DCD	0xe1a09915 ;	lsl	r9, r5, r9
	DCD	0xe2605c01 ;	rsb	r5, r0, #256	; 0x100
	DCD	0x20d7a0b2 ;	ldrhcs	sl, [r7], #2
	DCD	0xe1055089 ;	smlabb	r5, r9, r0, r5
	DCD	0x26bfafba ;	rev16cs	sl, sl
	DCD	0x2188861a ;	orrcs	r8, r8, sl, lsl r6
	DCD	0x22466010 ;	subcs	r6, r6, #16
	DCD	0xe1a05425 ;	lsr	r5, r5, #8
	DCD	0xe1580805 ;	cmp	r8, r5, lsl #16
	DCD	0xa0488805 ;	subge	r8, r8, r5, lsl #16
	DCD	0xa0495005 ;	subge	r5, r9, r5
	DCD	0xa28cc001 ;	addge	ip, ip, #1
	DCD	0xe7de9005 ;	ldrb	r9, [lr, r5]
	DCD	0xea000091 ;	b	498 <ff_decode_block_coeffs_armv6+0x498>
	DCD	0xe5d40006 ;	ldrb	r0, [r4, #6]
	DCD	0xe0966009 ;	adds	r6, r6, r9
	DCD	0xe1a08918 ;	lsl	r8, r8, r9
	DCD	0xe1a09915 ;	lsl	r9, r5, r9
	DCD	0xe2605c01 ;	rsb	r5, r0, #256	; 0x100
	DCD	0x20d7a0b2 ;	ldrhcs	sl, [r7], #2
	DCD	0xe1055089 ;	smlabb	r5, r9, r0, r5
	DCD	0x26bfafba ;	rev16cs	sl, sl
	DCD	0x2188861a ;	orrcs	r8, r8, sl, lsl r6
	DCD	0x22466010 ;	subcs	r6, r6, #16
	DCD	0xe1a05425 ;	lsr	r5, r5, #8
	DCD	0xe1580805 ;	cmp	r8, r5, lsl #16
	DCD	0xa0488805 ;	subge	r8, r8, r5, lsl #16
	DCD	0xa0495005 ;	subge	r5, r9, r5
	DCD	0xe7de9005 ;	ldrb	r9, [lr, r5]
	DCD	0xaa000043 ;	bge	3a0 <ff_decode_block_coeffs_armv6+0x3a0>
	DCD	0xe5d40007 ;	ldrb	r0, [r4, #7]
	DCD	0xe0966009 ;	adds	r6, r6, r9
	DCD	0xe1a08918 ;	lsl	r8, r8, r9
	DCD	0xe1a09915 ;	lsl	r9, r5, r9
	DCD	0xe2605c01 ;	rsb	r5, r0, #256	; 0x100
	DCD	0x20d7a0b2 ;	ldrhcs	sl, [r7], #2
	DCD	0xe1055089 ;	smlabb	r5, r9, r0, r5
	DCD	0x26bfafba ;	rev16cs	sl, sl
	DCD	0x2188861a ;	orrcs	r8, r8, sl, lsl r6
	DCD	0x22466010 ;	subcs	r6, r6, #16
	DCD	0xe1a05425 ;	sr	r5, r5, #8
	DCD	0xe1580805 ;	cmp	r8, r5, lsl #16
	DCD	0xa0488805 ;	subge	r8, r8, r5, lsl #16
	DCD	0xa0495005 ;	subge	r5, r9, r5
	DCD	0xe7de9005 ;	ldrb	r9, [lr, r5]
	DCD	0xaa000011 ;	bge	318 <ff_decode_block_coeffs_armv6+0x318>
	DCD	0xe3a0c005 ;	mov	ip, #5
	DCD	0xe3a0009f ;	mov	r0, #159	; 0x9f
	DCD	0xe0966009 ;	adds	r6, r6, r9
	DCD	0xe1a08918 ;	lsl	r8, r8, r9
	DCD	0xe1a09915 ;	lsl	r9, r5, r9
	DCD	0xe2605c01 ;	rsb	r5, r0, #256	; 0x100
	DCD	0x20d7a0b2 ;	ldrhcs	sl, [r7], #2
	DCD	0xe1055089 ;	smlabb	r5, r9, r0, r5
	DCD	0x26bfafba ;	rev16cs	sl, sl
	DCD	0x2188861a ;	orrcs	r8, r8, sl, lsl r6
	DCD	0x22466010 ;	subcs	r6, r6, #16
	DCD	0xe1a05425 ;	lsr	r5, r5, #8
	DCD	0xe1580805 ;	cmp	r8, r5, lsl #16
	DCD	0xa0488805 ;	subge	r8, r8, r5, lsl #16
	DCD	0xa0495005 ;	subge	r5, r9, r5
	DCD	0xa28cc001 ;	addge	ip, ip, #1
	DCD	0xe7de9005 ;	ldrb	r9, [lr, r5]
	DCD	0xea00005f ;	b	498 <ff_decode_block_coeffs_armv6+0x498>
	DCD	0xe3a0c007 ;	mov	ip, #7
	DCD	0xe3a000a5 ;	mov	r0, #165	; 0xa5
	DCD	0xe0966009 ;	adds	r6, r6, r9
	DCD	0xe1a08918 ;	lsl	r8, r8, r9
	DCD	0xe1a09915 ;	lsl	r9, r5, r9
	DCD	0xe2605c01 ;	rsb	r5, r0, #256	; 0x100
	DCD	0x20d7a0b2 ;	ldrhcs	sl, [r7], #2
	DCD	0xe1055089 ;	smlabb	r5, r9, r0, r5
	DCD	0x26bfafba ;	rev16cs	sl, sl
	DCD	0x2188861a ;	orrcs	r8, r8, sl, lsl r6
	DCD	0x22466010 ;	subcs	r6, r6, #16
	DCD	0xe1a05425 ;	lsr	r5, r5, #8
	DCD	0xe1580805 ;	cmp	r8, r5, lsl #16
	DCD	0xa0488805 ;	subge	r8, r8, r5, lsl #16
	DCD	0xa0495005 ;	subge	r5, r9, r5
	DCD	0xa28cc002 ;	addge	ip, ip, #2
	DCD	0xe7de9005 ;	ldrb	r9, [lr, r5]
	DCD	0xe3a00091 ;	mov	r0, #145	; 0x91
	DCD	0xe0966009 ;	adds	r6, r6, r9
	DCD	0xe1a08918 ;	lsl	r8, r8, r9
	DCD	0xe1a09915 ;	lsl	r9, r5, r9
	DCD	0xe2605c01 ;	rsb	r5, r0, #256	; 0x100
	DCD	0x20d7a0b2 ;	ldrhcs	sl, [r7], #2
	DCD	0xe1055089 ;	smlabb	r5, r9, r0, r5
	DCD	0x26bfafba ;	rev16cs	sl, sl
	DCD	0x2188861a ;	orrcs	r8, r8, sl, lsl r6
	DCD	0x22466010 ;	subcs	r6, r6, #16
	DCD	0xe1a05425 ;	lsr	r5, r5, #8
	DCD	0xe1580805 ;	cmp	r8, r5, lsl #16
	DCD	0xa0488805 ;	subge	r8, r8, r5, lsl #16
	DCD	0xa0495005 ;	subge	r5, r9, r5
	DCD	0xa28cc001 ;	addge	ip, ip, #1
	DCD	0xe7de9005 ;	ldrb	r9, [lr, r5]
	DCD	0xea00003d ;	b	498 <ff_decode_block_coeffs_armv6+0x498>
	DCD	0xe5d40008 ;	ldrb	r0, [r4, #8]
	DCD	0xe0966009 ;	adds	r6, r6, r9
	DCD	0xe1a08918 ;	lsl	r8, r8, r9
	DCD	0xe1a09915 ;	lsl	r9, r5, r9
	DCD	0xe2605c01 ;	rsb	r5, r0, #256	; 0x100
	DCD	0x20d7a0b2 ;	ldrhcs	sl, [r7], #2
	DCD	0xe1055089 ;	smlabb	r5, r9, r0, r5
	DCD	0x26bfafba ;	rev16cs	sl, sl
	DCD	0x2188861a ;	orrcs	r8, r8, sl, lsl r6
	DCD	0x22466010 ;	subcs	r6, r6, #16
	DCD	0xe1a05425 ;	lsr	r5, r5, #8
	DCD	0xe1580805 ;	cmp	r8, r5, lsl #16
	DCD	0xa0488805 ;	subge	r8, r8, r5, lsl #16
	DCD	0xa0495005 ;	subge	r5, r9, r5
	DCD	0xa2844001 ;	addge	r4, r4, #1
	DCD	0xe7de9005 ;	ldrb	r9, [lr, r5]
	DCD	0xa3a0c002 ;	movge	ip, #2
	DCD	0xb3a0c000 ;	movlt	ip, #0
	DCD	0xe5d40009 ;	ldrb	r0, [r4, #9]
	DCD	0xe0966009 ;	adds	r6, r6, r9
	DCD	0xe1a08918 ;	lsl	r8, r8, r9
	DCD	0xe1a09915 ;	lsl	r9, r5, r9
	DCD	0xe2605c01 ;	rsb	r5, r0, #256	; 0x100
	DCD	0x20d7a0b2 ;	ldrhcs	sl, [r7], #2
	DCD	0xe1055089 ;	smlabb	r5, r9, r0, r5
	DCD	0x26bfafba ;	rev16cs	sl, sl
	DCD	0x2188861a ;	orrcs	r8, r8, sl, lsl r6
	DCD	0x22466010 ;	subcs	r6, r6, #16
	DCD	0xe1a05425 ;	lsr	r5, r5, #8
	DCD	0xe1580805 ;	cmp	r8, r5, lsl #16
	DCD	0xa0488805 ;	subge	r8, r8, r5, lsl #16
	DCD	0xa0495005 ;	subge	r5, r9, r5
	DCD	0xe3a09008 ;	mov	r9, #8
	DCD	0xa28cc001 ;	addge	ip, ip, #1
	DCD	0xe59f40d0 ;	ldr	r4, [pc, #208]	; 500 <ff_decode_block_coeffs_armv6+0x500>
	DCD	0xe1a09c19 ;	lsl	r9, r9, ip
	DCD	0xe794410c ;	ldr	r4, [r4, ip, lsl #2]
	DCD	0xe289c003 ;	add	ip, r9, #3
	DCD	0xe3a01000 ;	mov	r1, #0
	DCD	0xe4d40001 ;	ldrb	r0, [r4], #1
	DCD	0xe7de9005 ;	ldrb	r9, [lr, r5]
	DCD	0xe1a01081 ;	lsl	r1, r1, #1
	DCD	0xe0966009 ;	adds	r6, r6, r9
	DCD	0xe1a08918 ;	lsl	r8, r8, r9
	DCD	0xe1a09915 ;	lsl	r9, r5, r9
	DCD	0xe2605c01 ;	rsb	r5, r0, #256	; 0x100
	DCD	0x20d7a0b2 ;	ldrhcs	sl, [r7], #2
	DCD	0xe1055089 ;	smlabb	r5, r9, r0, r5
	DCD	0x26bfafba ;	rev16cs	sl, sl
	DCD	0x2188861a ;	orrcs	r8, r8, sl, lsl r6
	DCD	0x22466010 ;	subcs	r6, r6, #16
	DCD	0xe1a05425 ;	lsr	r5, r5, #8
	DCD	0xe1580805 ;	cmp	r8, r5, lsl #16
	DCD	0xa0488805 ;	subge	r8, r8, r5, lsl #16
	DCD	0xa0495005 ;	subge	r5, r9, r5
	DCD	0xe4d40001 ;	ldrb	r0, [r4], #1
	DCD	0xa2811001 ;	addge	r1, r1, #1
	DCD	0xe3500000 ;	cmp	r0, #0
	DCD	0x1affffec ;	bne	440 <ff_decode_block_coeffs_armv6+0x440>
	DCD	0xe7de9005 ;	ldrb	r9, [lr, r5]
	DCD	0xe08cc001 ;	add	ip, ip, r1
	DCD	0xe59d1004 ;	ldr	r1, [sp, #4]
	DCD	0xe0834283 ;	add	r4, r3, r3, lsl #5
	DCD	0xe0824004 ;	add	r4, r2, r4
	DCD	0xe2844016 ;	add	r4, r4, #22
	DCD	0xe0966009 ;	adds	r6, r6, r9
	DCD	0xe1a08918 ;	lsl	r8, r8, r9
	DCD	0xe1a09915 ;	lsl	r9, r5, r9
	DCD	0x20d7a0b2 ;	ldrhcs	sl, [r7], #2
	DCD	0xe3a05080 ;	mov	r5, #128	; 0x80
	DCD	0x26bfafba ;	rev16cs	sl, sl
	DCD	0xe0855389 ;	add	r5, r5, r9, lsl #7
	DCD	0x2188861a ;	orrcs	r8, r8, sl, lsl r6
	DCD	0x22466010 ;	subcs	r6, r6, #16
	DCD	0xe1a05425 ;	lsr	r5, r5, #8
	DCD	0xe1580805 ;	cmp	r8, r5, lsl #16
	DCD	0xa0488805 ;	subge	r8, r8, r5, lsl #16
	DCD	0xa0495005 ;	subge	r5, r9, r5
	DCD	0xa26cc000 ;	rsbge	ip, ip, #0
	DCD	0xe16c0b8c ;	smulbb	ip, ip, fp
	DCD	0xe59f9014 ;	ldr	r9, [pc, #20]	; 4fc <ff_decode_block_coeffs_armv6+0x4fc>
	DCD	0xe7d99003 ;	ldrb	r9, [r9, r3]
	DCD	0xe3530010 ;	cmp	r3, #16
	DCD	0xe181c0b9 ;	strh	ip, [r1, r9]
	DCD	0xaaffff14 ;	bge	148 <ff_decode_block_coeffs_armv6+0x148>
	DCD	0xeaffff02 ;	b	104 <ff_decode_block_coeffs_armv6+0x104>
	DCD	|ff_vp56_norm_shift| ; 0x00000000 ;	andeq	r0, r0, r0
;		4f8: R_ARM_ABS32	ff_vp56_norm_shift
	DCD	|zigzag_scan| ; 0xffffffff ;			; <UNDEFINED> instruction: 0xffffffff
;		4fc: R_ARM_ABS32	.rodata
	DCD	|ff_vp8_dct_cat_prob| ; 0x00000000 ;	andeq	r0, r0, r0
;		500: R_ARM_ABS32	ff_vp8_dct_cat_prob
	ENDP  ; |ff_decode_block_coeffs_armv6|

	AREA	|.rdata|, DATA, READONLY
|zigzag_scan|
	DCD	0x10080200 ;	andne	r0, r8, r0, lsl #4
	DCD	0x0c06040a ;	cfstrseq	mvf0, [r6], {10}
	DCD	0x141a1812 ;	ldrne	r1, [sl], #-2066	; 0xfffff7ee
	DCD	0x1e1c160e ;	cfmsub32ne	mvax0, mvfx1, mvfx12, mvfx14

	END
