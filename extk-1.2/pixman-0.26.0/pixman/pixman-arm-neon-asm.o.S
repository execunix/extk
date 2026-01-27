	CODE32

	EXPORT	|pixman_composite_over_8888_0565_asm_neon|
	EXPORT	|pixman_composite_over_n_0565_asm_neon|
	EXPORT	|pixman_composite_src_8888_0565_asm_neon|
	EXPORT	|pixman_composite_src_0565_8888_asm_neon|
	EXPORT	|pixman_composite_add_8_8_asm_neon|
	EXPORT	|pixman_composite_add_8888_8888_asm_neon|
	EXPORT	|pixman_composite_scanline_add_asm_neon|
	EXPORT	|pixman_composite_scanline_out_reverse_asm_neon|
	EXPORT	|pixman_composite_over_8888_8888_asm_neon|
	EXPORT	|pixman_composite_scanline_over_asm_neon|
	EXPORT	|pixman_composite_over_n_8888_asm_neon|
	EXPORT	|pixman_composite_over_reverse_n_8888_asm_neon|
	EXPORT	|pixman_composite_over_8888_8_0565_asm_neon|
	EXPORT	|pixman_composite_over_n_8_0565_asm_neon|
	EXPORT	|pixman_composite_over_8888_n_0565_asm_neon|
	EXPORT	|pixman_composite_src_0565_0565_asm_neon|
	EXPORT	|pixman_composite_src_n_8_asm_neon|
	EXPORT	|pixman_composite_src_n_0565_asm_neon|
	EXPORT	|pixman_composite_src_n_8888_asm_neon|
	EXPORT	|pixman_composite_src_8888_8888_asm_neon|
	EXPORT	|pixman_composite_src_x888_8888_asm_neon|
	EXPORT	|pixman_composite_src_n_8_8888_asm_neon|
	EXPORT	|pixman_composite_src_n_8_8_asm_neon|
	EXPORT	|pixman_composite_over_n_8_8888_asm_neon|
	EXPORT	|pixman_composite_over_n_8_8_asm_neon|
	EXPORT	|pixman_composite_over_n_8888_8888_ca_asm_neon|
	EXPORT	|pixman_composite_over_n_8888_0565_ca_asm_neon|
	EXPORT	|pixman_composite_in_n_8_asm_neon|
	EXPORT	|pixman_composite_add_n_8_8_asm_neon|
	EXPORT	|pixman_composite_add_8_8_8_asm_neon|
	EXPORT	|pixman_composite_add_8888_8888_8888_asm_neon|
	EXPORT	|pixman_composite_scanline_add_mask_asm_neon|
	EXPORT	|pixman_composite_add_8888_8_8888_asm_neon|
	EXPORT	|pixman_composite_add_n_8_8888_asm_neon|
	EXPORT	|pixman_composite_add_8888_n_8888_asm_neon|
	EXPORT	|pixman_composite_scanline_out_reverse_mask_asm_neon|
	EXPORT	|pixman_composite_over_8888_n_8888_asm_neon|
	EXPORT	|pixman_composite_over_8888_8888_8888_asm_neon|
	EXPORT	|pixman_composite_scanline_over_mask_asm_neon|
	EXPORT	|pixman_composite_over_8888_8_8888_asm_neon|
	EXPORT	|pixman_composite_src_0888_0888_asm_neon|
	EXPORT	|pixman_composite_src_0888_8888_rev_asm_neon|
	EXPORT	|pixman_composite_src_0888_0565_rev_asm_neon|
	EXPORT	|pixman_composite_src_pixbuf_8888_asm_neon|
	EXPORT	|pixman_composite_src_rpixbuf_8888_asm_neon|
	EXPORT	|pixman_composite_over_0565_8_0565_asm_neon|
	EXPORT	|pixman_composite_over_0565_n_0565_asm_neon|
	EXPORT	|pixman_composite_add_0565_8_0565_asm_neon|
	EXPORT	|pixman_composite_out_reverse_8_0565_asm_neon|
	EXPORT	|pixman_composite_out_reverse_8_8888_asm_neon|
	EXPORT	|pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon|
	EXPORT	|pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon|
	EXPORT	|pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon|
	EXPORT	|pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon|
	EXPORT	|pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon|
	EXPORT	|pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon|
	EXPORT	|pixman_scaled_bilinear_scanline_8888_8888_SRC_asm_neon|
	EXPORT	|pixman_scaled_bilinear_scanline_8888_0565_SRC_asm_neon|
	EXPORT	|pixman_scaled_bilinear_scanline_0565_x888_SRC_asm_neon|
	EXPORT	|pixman_scaled_bilinear_scanline_0565_0565_SRC_asm_neon|

	AREA	|.text|, CODE, ARM

|pixman_composite_over_8888_0565_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a07000 ;	mov	r7, r0
	DCD	0xba000135 ;	blt	50c <pixman_composite_over_8888_0565_asm_neon+0x50c>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba0000db ;	blt	3ac <pixman_composite_over_8888_0565_asm_neon+0x3ac>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000041 ;	beq	14c <pixman_composite_over_8888_0565_asm_neon+0x14c>
	DCD	0xe3160002 ;	tst	r6, #2
	DCD	0x0a000003 ;	beq	5c <pixman_composite_over_8888_0565_asm_neon+0x5c>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf4a6444d ;	vld1.16	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000004 ;	beq	78 <pixman_composite_over_8888_0565_asm_neon+0x78>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xf4a6448d ;	vld1.16	{d4[2]}, [r6]!
	DCD	0xf4a644cd ;	vld1.16	{d4[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000003 ;	beq	90 <pixman_composite_over_8888_0565_asm_neon+0x90>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xf426575d ;	vld1.16	{d5}, [r6 :64]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c34c06 ;	vmull.u8	q10, d3, d6
	DCD	0xf3c36c07 ;	vmull.u8	q11, d3, d7
	DCD	0xf3c38c2e ;	vmull.u8	q12, d3, d30
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf3986276 ;	vrshr.u16	q3, q11, #8
	DCD	0xf3d8e278 ;	vrshr.u16	q15, q12, #8
	DCD	0xf3c444aa ;	vraddhn.i16	d20, q10, q13
	DCD	0xf3c67486 ;	vraddhn.i16	d23, q11, q3
	DCD	0xf3c864ae ;	vraddhn.i16	d22, q12, q15
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xa7fc8083 ;	ldrbge	r8, [ip, r3, lsl #1]!
	DCD	0xf3420034 ;	vqadd.u8	d16, d2, d20
	DCD	0xf3402076 ;	vqadd.u8	q9, q0, q11
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3120002 ;	tst	r2, #2
	DCD	0x0a000000 ;	beq	130 <pixman_composite_over_8888_0565_asm_neon+0x130>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000001 ;	beq	140 <pixman_composite_over_8888_0565_asm_neon+0x140>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	14c <pixman_composite_over_8888_0565_asm_neon+0x14c>
	DCD	0xf442d75d ;	vst1.16	{d29}, [r2 :64]!
	DCD	0xf4264a6d ;	vld1.16	{d4-d5}, [r6 :128]!
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c34c06 ;	vmull.u8	q10, d3, d6
	DCD	0xf3c36c07 ;	vmull.u8	q11, d3, d7
	DCD	0xf3c38c2e ;	vmull.u8	q12, d3, d30
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf3986276 ;	vrshr.u16	q3, q11, #8
	DCD	0xf3d8e278 ;	vrshr.u16	q15, q12, #8
	DCD	0xf3c444aa ;	vraddhn.i16	d20, q10, q13
	DCD	0xf3c67486 ;	vraddhn.i16	d23, q11, q3
	DCD	0xf3c864ae ;	vraddhn.i16	d22, q12, q15
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xa7fc8083 ;	ldrbge	r8, [ip, r3, lsl #1]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba000026 ;	blt	264 <pixman_composite_over_8888_0565_asm_neon+0x264>
	DCD	0xf3420034 ;	vqadd.u8	d16, d2, d20
	DCD	0xf4264a6d ;	vld1.16	{d4-d5}, [r6 :128]!
	DCD	0xf3402076 ;	vqadd.u8	q9, q0, q11
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c34c06 ;	vmull.u8	q10, d3, d6
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf3c36c07 ;	vmull.u8	q11, d3, d7
	DCD	0xf3c38c2e ;	vmull.u8	q12, d3, d30
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xf3986276 ;	vrshr.u16	q3, q11, #8
	DCD	0xf3d8e278 ;	vrshr.u16	q15, q12, #8
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xf3c444aa ;	vraddhn.i16	d20, q10, q13
	DCD	0xf3c67486 ;	vraddhn.i16	d23, q11, q3
	DCD	0xa7fc8083 ;	ldrbge	r8, [ip, r3, lsl #1]!
	DCD	0xf3c864ae ;	vraddhn.i16	d22, q12, q15
	DCD	0xf442ca6d ;	vst1.16	{d28-d29}, [r2 :128]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffd8 ;	bge	1c8 <pixman_composite_over_8888_0565_asm_neon+0x1c8>
	DCD	0xf3420034 ;	vqadd.u8	d16, d2, d20
	DCD	0xf3402076 ;	vqadd.u8	q9, q0, q11
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xf442ca6d ;	vst1.16	{d28-d29}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00003e ;	beq	388 <pixman_composite_over_8888_0565_asm_neon+0x388>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000002 ;	beq	2a0 <pixman_composite_over_8888_0565_asm_neon+0x2a0>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xf426575d ;	vld1.16	{d5}, [r6 :64]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000003 ;	beq	2b8 <pixman_composite_over_8888_0565_asm_neon+0x2b8>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xf4a6448d ;	vld1.16	{d4[2]}, [r6]!
	DCD	0xf4a644cd ;	vld1.16	{d4[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	2cc <pixman_composite_over_8888_0565_asm_neon+0x2cc>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf4a6444d ;	vld1.16	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c34c06 ;	vmull.u8	q10, d3, d6
	DCD	0xf3c36c07 ;	vmull.u8	q11, d3, d7
	DCD	0xf3c38c2e ;	vmull.u8	q12, d3, d30
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf3986276 ;	vrshr.u16	q3, q11, #8
	DCD	0xf3d8e278 ;	vrshr.u16	q15, q12, #8
	DCD	0xf3c444aa ;	vraddhn.i16	d20, q10, q13
	DCD	0xf3c67486 ;	vraddhn.i16	d23, q11, q3
	DCD	0xf3c864ae ;	vraddhn.i16	d22, q12, q15
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xa7fc8083 ;	ldrbge	r8, [ip, r3, lsl #1]!
	DCD	0xf3420034 ;	vqadd.u8	d16, d2, d20
	DCD	0xf3402076 ;	vqadd.u8	q9, q0, q11
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	36c <pixman_composite_over_8888_0565_asm_neon+0x36c>
	DCD	0xf442d75d ;	vst1.16	{d29}, [r2 :64]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	37c <pixman_composite_over_8888_0565_asm_neon+0x37c>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	388 <pixman_composite_over_8888_0565_asm_neon+0x388>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff24 ;	bge	3c <pixman_composite_over_8888_0565_asm_neon+0x3c>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000019 ;	beq	41c <pixman_composite_over_8888_0565_asm_neon+0x41c>
	DCD	0xf4264a4d ;	vld1.16	{d4-d5}, [r6]!
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c34c06 ;	vmull.u8	q10, d3, d6
	DCD	0xf3c36c07 ;	vmull.u8	q11, d3, d7
	DCD	0xf3c38c2e ;	vmull.u8	q12, d3, d30
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf3986276 ;	vrshr.u16	q3, q11, #8
	DCD	0xf3d8e278 ;	vrshr.u16	q15, q12, #8
	DCD	0xf3c444aa ;	vraddhn.i16	d20, q10, q13
	DCD	0xf3c67486 ;	vraddhn.i16	d23, q11, q3
	DCD	0xf3c864ae ;	vraddhn.i16	d22, q12, q15
	DCD	0xf3420034 ;	vqadd.u8	d16, d2, d20
	DCD	0xf3402076 ;	vqadd.u8	q9, q0, q11
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xf442ca4d ;	vst1.16	{d28-d29}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000031 ;	beq	4ec <pixman_composite_over_8888_0565_asm_neon+0x4ec>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000001 ;	beq	434 <pixman_composite_over_8888_0565_asm_neon+0x434>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xf426574d ;	vld1.16	{d5}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000002 ;	beq	448 <pixman_composite_over_8888_0565_asm_neon+0x448>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xf4a6448d ;	vld1.16	{d4[2]}, [r6]!
	DCD	0xf4a644cd ;	vld1.16	{d4[3]}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	458 <pixman_composite_over_8888_0565_asm_neon+0x458>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf4a6444d ;	vld1.16	{d4[1]}, [r6]!
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c34c06 ;	vmull.u8	q10, d3, d6
	DCD	0xf3c36c07 ;	vmull.u8	q11, d3, d7
	DCD	0xf3c38c2e ;	vmull.u8	q12, d3, d30
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf3986276 ;	vrshr.u16	q3, q11, #8
	DCD	0xf3d8e278 ;	vrshr.u16	q15, q12, #8
	DCD	0xf3c444aa ;	vraddhn.i16	d20, q10, q13
	DCD	0xf3c67486 ;	vraddhn.i16	d23, q11, q3
	DCD	0xf3c864ae ;	vraddhn.i16	d22, q12, q15
	DCD	0xf3420034 ;	vqadd.u8	d16, d2, d20
	DCD	0xf3402076 ;	vqadd.u8	q9, q0, q11
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	4d0 <pixman_composite_over_8888_0565_asm_neon+0x4d0>
	DCD	0xf442d74d ;	vst1.16	{d29}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	4e0 <pixman_composite_over_8888_0565_asm_neon+0x4e0>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	4ec <pixman_composite_over_8888_0565_asm_neon+0x4ec>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffa7 ;	bge	3ac <pixman_composite_over_8888_0565_asm_neon+0x3ac>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_over_8888_0565_asm_neon|

|pixman_composite_over_n_0565_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xe28d8028 ;	add	r8, sp, #40	; 0x28
	DCD	0xf4a8380f ;	vld1.32	{d3[0]}, [r8]
	DCD	0xf3b10c03 ;	vdup.8	d0, d3[0]
	DCD	0xf3b31c03 ;	vdup.8	d1, d3[1]
	DCD	0xf3b52c03 ;	vdup.8	d2, d3[2]
	DCD	0xf3b73c03 ;	vdup.8	d3, d3[3]
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a07000 ;	mov	r7, r0
	DCD	0xba00010b ;	blt	988 <pixman_composite_over_n_0565_asm_neon+0x478>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba0000bd ;	blt	858 <pixman_composite_over_n_0565_asm_neon+0x348>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000037 ;	beq	648 <pixman_composite_over_n_0565_asm_neon+0x138>
	DCD	0xe3160002 ;	tst	r6, #2
	DCD	0x0a000002 ;	beq	57c <pixman_composite_over_n_0565_asm_neon+0x6c>
	DCD	0xf4a6444d ;	vld1.16	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000003 ;	beq	594 <pixman_composite_over_n_0565_asm_neon+0x84>
	DCD	0xf4a6448d ;	vld1.16	{d4[2]}, [r6]!
	DCD	0xf4a644cd ;	vld1.16	{d4[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000002 ;	beq	5a8 <pixman_composite_over_n_0565_asm_neon+0x98>
	DCD	0xf426575d ;	vld1.16	{d5}, [r6 :64]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c34c06 ;	vmull.u8	q10, d3, d6
	DCD	0xf3c36c07 ;	vmull.u8	q11, d3, d7
	DCD	0xf3c38c2e ;	vmull.u8	q12, d3, d30
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf3986276 ;	vrshr.u16	q3, q11, #8
	DCD	0xf3d8e278 ;	vrshr.u16	q15, q12, #8
	DCD	0xf3c444aa ;	vraddhn.i16	d20, q10, q13
	DCD	0xf3c67486 ;	vraddhn.i16	d23, q11, q3
	DCD	0xf3c864ae ;	vraddhn.i16	d22, q12, q15
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc8083 ;	ldrbge	r8, [ip, r3, lsl #1]!
	DCD	0xf3420034 ;	vqadd.u8	d16, d2, d20
	DCD	0xf3402076 ;	vqadd.u8	q9, q0, q11
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3120002 ;	tst	r2, #2
	DCD	0x0a000000 ;	beq	62c <pixman_composite_over_n_0565_asm_neon+0x11c>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000001 ;	beq	63c <pixman_composite_over_n_0565_asm_neon+0x12c>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	648 <pixman_composite_over_n_0565_asm_neon+0x138>
	DCD	0xf442d75d ;	vst1.16	{d29}, [r2 :64]!
	DCD	0xf4264a6d ;	vld1.16	{d4-d5}, [r6 :128]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c34c06 ;	vmull.u8	q10, d3, d6
	DCD	0xf3c36c07 ;	vmull.u8	q11, d3, d7
	DCD	0xf3c38c2e ;	vmull.u8	q12, d3, d30
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf3986276 ;	vrshr.u16	q3, q11, #8
	DCD	0xf3d8e278 ;	vrshr.u16	q15, q12, #8
	DCD	0xf3c444aa ;	vraddhn.i16	d20, q10, q13
	DCD	0xf3c67486 ;	vraddhn.i16	d23, q11, q3
	DCD	0xf3c864ae ;	vraddhn.i16	d22, q12, q15
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc8083 ;	ldrbge	r8, [ip, r3, lsl #1]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba000022 ;	blt	740 <pixman_composite_over_n_0565_asm_neon+0x230>
	DCD	0xf3420034 ;	vqadd.u8	d16, d2, d20
	DCD	0xf3402076 ;	vqadd.u8	q9, q0, q11
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xf4264a6d ;	vld1.16	{d4-d5}, [r6 :128]!
	DCD	0xf442ca6d ;	vst1.16	{d28-d29}, [r2 :128]!
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c34c06 ;	vmull.u8	q10, d3, d6
	DCD	0xf3c36c07 ;	vmull.u8	q11, d3, d7
	DCD	0xf3c38c2e ;	vmull.u8	q12, d3, d30
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf3986276 ;	vrshr.u16	q3, q11, #8
	DCD	0xf3d8e278 ;	vrshr.u16	q15, q12, #8
	DCD	0xf3c444aa ;	vraddhn.i16	d20, q10, q13
	DCD	0xf3c67486 ;	vraddhn.i16	d23, q11, q3
	DCD	0xf3c864ae ;	vraddhn.i16	d22, q12, q15
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc8083 ;	ldrbge	r8, [ip, r3, lsl #1]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffdc ;	bge	6b4 <pixman_composite_over_n_0565_asm_neon+0x1a4>
	DCD	0xf3420034 ;	vqadd.u8	d16, d2, d20
	DCD	0xf3402076 ;	vqadd.u8	q9, q0, q11
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xf442ca6d ;	vst1.16	{d28-d29}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000034 ;	beq	83c <pixman_composite_over_n_0565_asm_neon+0x32c>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000001 ;	beq	778 <pixman_composite_over_n_0565_asm_neon+0x268>
	DCD	0xf426575d ;	vld1.16	{d5}, [r6 :64]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000002 ;	beq	78c <pixman_composite_over_n_0565_asm_neon+0x27c>
	DCD	0xf4a6448d ;	vld1.16	{d4[2]}, [r6]!
	DCD	0xf4a644cd ;	vld1.16	{d4[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	79c <pixman_composite_over_n_0565_asm_neon+0x28c>
	DCD	0xf4a6444d ;	vld1.16	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c34c06 ;	vmull.u8	q10, d3, d6
	DCD	0xf3c36c07 ;	vmull.u8	q11, d3, d7
	DCD	0xf3c38c2e ;	vmull.u8	q12, d3, d30
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf3986276 ;	vrshr.u16	q3, q11, #8
	DCD	0xf3d8e278 ;	vrshr.u16	q15, q12, #8
	DCD	0xf3c444aa ;	vraddhn.i16	d20, q10, q13
	DCD	0xf3c67486 ;	vraddhn.i16	d23, q11, q3
	DCD	0xf3c864ae ;	vraddhn.i16	d22, q12, q15
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc8083 ;	ldrbge	r8, [ip, r3, lsl #1]!
	DCD	0xf3420034 ;	vqadd.u8	d16, d2, d20
	DCD	0xf3402076 ;	vqadd.u8	q9, q0, q11
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	820 <pixman_composite_over_n_0565_asm_neon+0x310>
	DCD	0xf442d75d ;	vst1.16	{d29}, [r2 :64]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	830 <pixman_composite_over_n_0565_asm_neon+0x320>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	83c <pixman_composite_over_n_0565_asm_neon+0x32c>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff42 ;	bge	560 <pixman_composite_over_n_0565_asm_neon+0x50>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000017 ;	beq	8c0 <pixman_composite_over_n_0565_asm_neon+0x3b0>
	DCD	0xf4264a4d ;	vld1.16	{d4-d5}, [r6]!
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c34c06 ;	vmull.u8	q10, d3, d6
	DCD	0xf3c36c07 ;	vmull.u8	q11, d3, d7
	DCD	0xf3c38c2e ;	vmull.u8	q12, d3, d30
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf3986276 ;	vrshr.u16	q3, q11, #8
	DCD	0xf3d8e278 ;	vrshr.u16	q15, q12, #8
	DCD	0xf3c444aa ;	vraddhn.i16	d20, q10, q13
	DCD	0xf3c67486 ;	vraddhn.i16	d23, q11, q3
	DCD	0xf3c864ae ;	vraddhn.i16	d22, q12, q15
	DCD	0xf3420034 ;	vqadd.u8	d16, d2, d20
	DCD	0xf3402076 ;	vqadd.u8	q9, q0, q11
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xf442ca4d ;	vst1.16	{d28-d29}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000029 ;	beq	970 <pixman_composite_over_n_0565_asm_neon+0x460>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	8d4 <pixman_composite_over_n_0565_asm_neon+0x3c4>
	DCD	0xf426574d ;	vld1.16	{d5}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	8e4 <pixman_composite_over_n_0565_asm_neon+0x3d4>
	DCD	0xf4a6448d ;	vld1.16	{d4[2]}, [r6]!
	DCD	0xf4a644cd ;	vld1.16	{d4[3]}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	8f0 <pixman_composite_over_n_0565_asm_neon+0x3e0>
	DCD	0xf4a6444d ;	vld1.16	{d4[1]}, [r6]!
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c34c06 ;	vmull.u8	q10, d3, d6
	DCD	0xf3c36c07 ;	vmull.u8	q11, d3, d7
	DCD	0xf3c38c2e ;	vmull.u8	q12, d3, d30
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf3986276 ;	vrshr.u16	q3, q11, #8
	DCD	0xf3d8e278 ;	vrshr.u16	q15, q12, #8
	DCD	0xf3c444aa ;	vraddhn.i16	d20, q10, q13
	DCD	0xf3c67486 ;	vraddhn.i16	d23, q11, q3
	DCD	0xf3c864ae ;	vraddhn.i16	d22, q12, q15
	DCD	0xf3420034 ;	vqadd.u8	d16, d2, d20
	DCD	0xf3402076 ;	vqadd.u8	q9, q0, q11
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	954 <pixman_composite_over_n_0565_asm_neon+0x444>
	DCD	0xf442d74d ;	vst1.16	{d29}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	964 <pixman_composite_over_n_0565_asm_neon+0x454>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	970 <pixman_composite_over_n_0565_asm_neon+0x460>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffb3 ;	bge	858 <pixman_composite_over_n_0565_asm_neon+0x348>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_over_n_0565_asm_neon|

|pixman_composite_src_8888_0565_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe2499006 ;	sub	r9, r9, #6
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a07000 ;	mov	r7, r0
	DCD	0xba0000b5 ;	blt	c98 <pixman_composite_src_8888_0565_asm_neon+0x30c>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba000084 ;	blt	bdc <pixman_composite_src_8888_0565_asm_neon+0x250>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a00002c ;	beq	a84 <pixman_composite_src_8888_0565_asm_neon+0xf8>
	DCD	0xe3160002 ;	tst	r6, #2
	DCD	0x0a000003 ;	beq	9e8 <pixman_composite_src_8888_0565_asm_neon+0x5c>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xe2866002 ;	add	r6, r6, #2
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000003 ;	beq	a00 <pixman_composite_src_8888_0565_asm_neon+0x74>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xe2866004 ;	add	r6, r6, #4
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000003 ;	beq	a18 <pixman_composite_src_8888_0565_asm_neon+0x8c>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xe2866008 ;	add	r6, r6, #8
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3f20301 ;	vshll.i8	q8, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3f22300 ;	vshll.i8	q9, d0, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3120002 ;	tst	r2, #2
	DCD	0x0a000000 ;	beq	a68 <pixman_composite_src_8888_0565_asm_neon+0xdc>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000001 ;	beq	a78 <pixman_composite_src_8888_0565_asm_neon+0xec>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	a84 <pixman_composite_src_8888_0565_asm_neon+0xf8>
	DCD	0xf442d75d ;	vst1.16	{d29}, [r2 :64]!
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf3f20301 ;	vshll.i8	q8, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3f22300 ;	vshll.i8	q9, d0, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba000011 ;	blt	b08 <pixman_composite_src_8888_0565_asm_neon+0x17c>
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf3f20301 ;	vshll.i8	q8, d1, #8
	DCD	0xf442ca6d ;	vst1.16	{d28-d29}, [r2 :128]!
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xf3f22300 ;	vshll.i8	q9, d0, #8
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffed ;	bge	ac0 <pixman_composite_src_8888_0565_asm_neon+0x134>
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xf442ca6d ;	vst1.16	{d28-d29}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000026 ;	beq	bb8 <pixman_composite_src_8888_0565_asm_neon+0x22c>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000001 ;	beq	b2c <pixman_composite_src_8888_0565_asm_neon+0x1a0>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	b3c <pixman_composite_src_8888_0565_asm_neon+0x1b0>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	b4c <pixman_composite_src_8888_0565_asm_neon+0x1c0>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3f20301 ;	vshll.i8	q8, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3f22300 ;	vshll.i8	q9, d0, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	b9c <pixman_composite_src_8888_0565_asm_neon+0x210>
	DCD	0xf442d75d ;	vst1.16	{d29}, [r2 :64]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	bac <pixman_composite_src_8888_0565_asm_neon+0x220>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	bb8 <pixman_composite_src_8888_0565_asm_neon+0x22c>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff7b ;	bge	9c8 <pixman_composite_src_8888_0565_asm_neon+0x3c>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000006 ;	beq	c00 <pixman_composite_src_8888_0565_asm_neon+0x274>
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xf3f20301 ;	vshll.i8	q8, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3f22300 ;	vshll.i8	q9, d0, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xf442ca4d ;	vst1.16	{d28-d29}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00001b ;	beq	c78 <pixman_composite_src_8888_0565_asm_neon+0x2ec>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	c14 <pixman_composite_src_8888_0565_asm_neon+0x288>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	c20 <pixman_composite_src_8888_0565_asm_neon+0x294>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	c2c <pixman_composite_src_8888_0565_asm_neon+0x2a0>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3f20301 ;	vshll.i8	q8, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3f22300 ;	vshll.i8	q9, d0, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	c5c <pixman_composite_src_8888_0565_asm_neon+0x2d0>
	DCD	0xf442d74d ;	vst1.16	{d29}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	c6c <pixman_composite_src_8888_0565_asm_neon+0x2e0>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	c78 <pixman_composite_src_8888_0565_asm_neon+0x2ec>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffd0 ;	bge	bdc <pixman_composite_src_8888_0565_asm_neon+0x250>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_src_8888_0565_asm_neon|

|pixman_composite_src_0565_8888_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe2499006 ;	sub	r9, r9, #6
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a07000 ;	mov	r7, r0
	DCD	0xba0000bd ;	blt	fc8 <pixman_composite_src_0565_8888_asm_neon+0x32c>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba000088 ;	blt	efc <pixman_composite_src_0565_8888_asm_neon+0x260>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a00002a ;	beq	d8c <pixman_composite_src_0565_8888_asm_neon+0xf0>
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000003 ;	beq	cf8 <pixman_composite_src_0565_8888_asm_neon+0x5c>
	DCD	0xf4a4044d ;	vld1.16	{d0[1]}, [r4]!
	DCD	0xe2866004 ;	add	r6, r6, #4
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000004 ;	beq	d14 <pixman_composite_src_0565_8888_asm_neon+0x78>
	DCD	0xf4a4048d ;	vld1.16	{d0[2]}, [r4]!
	DCD	0xf4a404cd ;	vld1.16	{d0[3]}, [r4]!
	DCD	0xe2866008 ;	add	r6, r6, #8
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xf424174d ;	vld1.16	{d1}, [r4]!
	DCD	0xe2866010 ;	add	r6, r6, #16
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf2c8e810 ;	vshrn.i16	d30, q0, #8
	DCD	0xf2cdd810 ;	vshrn.i16	d29, q0, #3
	DCD	0xf3950550 ;	vsli.16	q0, q0, #5
	DCD	0xf3c7fe1f ;	vmov.i8	d31, #255	; 0xff
	DCD	0xf3cbe43e ;	vsri.8	d30, d30, #5
	DCD	0xf3cad43d ;	vsri.8	d29, d29, #6
	DCD	0xf2cec810 ;	vshrn.i16	d28, q0, #2
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf08a ;	pld	[fp, sl, lsl #1]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8085 ;	ldrbge	r8, [fp, r5, lsl #1]!
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000000 ;	beq	d7c <pixman_composite_src_0565_8888_asm_neon+0xe0>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	d88 <pixman_composite_src_0565_8888_asm_neon+0xec>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xf4240a4d ;	vld1.16	{d0-d1}, [r4]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf2c8e810 ;	vshrn.i16	d30, q0, #8
	DCD	0xf2cdd810 ;	vshrn.i16	d29, q0, #3
	DCD	0xf3950550 ;	vsli.16	q0, q0, #5
	DCD	0xf3c7fe1f ;	vmov.i8	d31, #255	; 0xff
	DCD	0xf3cbe43e ;	vsri.8	d30, d30, #5
	DCD	0xf3cad43d ;	vsri.8	d29, d29, #6
	DCD	0xf2cec810 ;	vshrn.i16	d28, q0, #2
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf08a ;	pld	[fp, sl, lsl #1]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8085 ;	ldrbge	r8, [fp, r5, lsl #1]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba000013 ;	blt	e28 <pixman_composite_src_0565_8888_asm_neon+0x18c>
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xf4240a4d ;	vld1.16	{d0-d1}, [r4]!
	DCD	0xf2c8e810 ;	vshrn.i16	d30, q0, #8
	DCD	0xf2cdd810 ;	vshrn.i16	d29, q0, #3
	DCD	0xf3950550 ;	vsli.16	q0, q0, #5
	DCD	0xf3c7fe1f ;	vmov.i8	d31, #255	; 0xff
	DCD	0xf3cbe43e ;	vsri.8	d30, d30, #5
	DCD	0xf3cad43d ;	vsri.8	d29, d29, #6
	DCD	0xf2cec810 ;	vshrn.i16	d28, q0, #2
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf08a ;	pld	[fp, sl, lsl #1]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8085 ;	ldrbge	r8, [fp, r5, lsl #1]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffeb ;	bge	dd8 <pixman_composite_src_0565_8888_asm_neon+0x13c>
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000028 ;	beq	ed8 <pixman_composite_src_0565_8888_asm_neon+0x23c>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000001 ;	beq	e44 <pixman_composite_src_0565_8888_asm_neon+0x1a8>
	DCD	0xf424174d ;	vld1.16	{d1}, [r4]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000002 ;	beq	e58 <pixman_composite_src_0565_8888_asm_neon+0x1bc>
	DCD	0xf4a4048d ;	vld1.16	{d0[2]}, [r4]!
	DCD	0xf4a404cd ;	vld1.16	{d0[3]}, [r4]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	e68 <pixman_composite_src_0565_8888_asm_neon+0x1cc>
	DCD	0xf4a4044d ;	vld1.16	{d0[1]}, [r4]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf2c8e810 ;	vshrn.i16	d30, q0, #8
	DCD	0xf2cdd810 ;	vshrn.i16	d29, q0, #3
	DCD	0xf3950550 ;	vsli.16	q0, q0, #5
	DCD	0xf3c7fe1f ;	vmov.i8	d31, #255	; 0xff
	DCD	0xf3cbe43e ;	vsri.8	d30, d30, #5
	DCD	0xf3cad43d ;	vsri.8	d29, d29, #6
	DCD	0xf2cec810 ;	vshrn.i16	d28, q0, #2
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf08a ;	pld	[fp, sl, lsl #1]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8085 ;	ldrbge	r8, [fp, r5, lsl #1]!
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	ec0 <pixman_composite_src_0565_8888_asm_neon+0x224>
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	ecc <pixman_composite_src_0565_8888_asm_neon+0x230>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	ed8 <pixman_composite_src_0565_8888_asm_neon+0x23c>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844085 ;	add	r4, r4, r5, lsl #1
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444080 ;	sub	r4, r4, r0, lsl #1
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff77 ;	bge	cd8 <pixman_composite_src_0565_8888_asm_neon+0x3c>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000008 ;	beq	f28 <pixman_composite_src_0565_8888_asm_neon+0x28c>
	DCD	0xf4240a4d ;	vld1.16	{d0-d1}, [r4]!
	DCD	0xf2c8e810 ;	vshrn.i16	d30, q0, #8
	DCD	0xf2cdd810 ;	vshrn.i16	d29, q0, #3
	DCD	0xf3950550 ;	vsli.16	q0, q0, #5
	DCD	0xf3c7fe1f ;	vmov.i8	d31, #255	; 0xff
	DCD	0xf3cbe43e ;	vsri.8	d30, d30, #5
	DCD	0xf3cad43d ;	vsri.8	d29, d29, #6
	DCD	0xf2cec810 ;	vshrn.i16	d28, q0, #2
	DCD	0xf442c00d ;	vst4.8	{d28-d31}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00001d ;	beq	fa8 <pixman_composite_src_0565_8888_asm_neon+0x30c>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	f3c <pixman_composite_src_0565_8888_asm_neon+0x2a0>
	DCD	0xf424174d ;	vld1.16	{d1}, [r4]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	f4c <pixman_composite_src_0565_8888_asm_neon+0x2b0>
	DCD	0xf4a4048d ;	vld1.16	{d0[2]}, [r4]!
	DCD	0xf4a404cd ;	vld1.16	{d0[3]}, [r4]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	f58 <pixman_composite_src_0565_8888_asm_neon+0x2bc>
	DCD	0xf4a4044d ;	vld1.16	{d0[1]}, [r4]!
	DCD	0xf2c8e810 ;	vshrn.i16	d30, q0, #8
	DCD	0xf2cdd810 ;	vshrn.i16	d29, q0, #3
	DCD	0xf3950550 ;	vsli.16	q0, q0, #5
	DCD	0xf3c7fe1f ;	vmov.i8	d31, #255	; 0xff
	DCD	0xf3cbe43e ;	vsri.8	d30, d30, #5
	DCD	0xf3cad43d ;	vsri.8	d29, d29, #6
	DCD	0xf2cec810 ;	vshrn.i16	d28, q0, #2
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	f90 <pixman_composite_src_0565_8888_asm_neon+0x2f4>
	DCD	0xf442ea8d ;	vst1.32	{d30-d31}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	f9c <pixman_composite_src_0565_8888_asm_neon+0x300>
	DCD	0xf442d78d ;	vst1.32	{d29}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	fa8 <pixman_composite_src_0565_8888_asm_neon+0x30c>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844085 ;	add	r4, r4, r5, lsl #1
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444080 ;	sub	r4, r4, r0, lsl #1
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffcc ;	bge	efc <pixman_composite_src_0565_8888_asm_neon+0x260>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_src_0565_8888_asm_neon|

|pixman_composite_add_8_8_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe2499006 ;	sub	r9, r9, #6
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a07000 ;	mov	r7, r0
	DCD	0xba0000f5 ;	blt	13d8 <pixman_composite_add_8_8_asm_neon+0x40c>
	DCD	0xe3500040 ;	cmp	r0, #64	; 0x40
	DCD	0xba0000b1 ;	blt	12d0 <pixman_composite_add_8_8_asm_neon+0x304>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000040 ;	beq	1114 <pixman_composite_add_8_8_asm_neon+0x148>
	DCD	0xe3160001 ;	tst	r6, #1
	DCD	0x0a000003 ;	beq	1028 <pixman_composite_add_8_8_asm_neon+0x5c>
	DCD	0xf4a4002d ;	vld1.8	{d0[1]}, [r4]!
	DCD	0xf4a6402d ;	vld1.8	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160002 ;	tst	r6, #2
	DCD	0x0a000005 ;	beq	1048 <pixman_composite_add_8_8_asm_neon+0x7c>
	DCD	0xf4a4004d ;	vld1.8	{d0[2]}, [r4]!
	DCD	0xf4a4006d ;	vld1.8	{d0[3]}, [r4]!
	DCD	0xf4a6404d ;	vld1.8	{d4[2]}, [r6]!
	DCD	0xf4a6406d ;	vld1.8	{d4[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000009 ;	beq	1078 <pixman_composite_add_8_8_asm_neon+0xac>
	DCD	0xf4a4008d ;	vld1.8	{d0[4]}, [r4]!
	DCD	0xf4a400ad ;	vld1.8	{d0[5]}, [r4]!
	DCD	0xf4a400cd ;	vld1.8	{d0[6]}, [r4]!
	DCD	0xf4a400ed ;	vld1.8	{d0[7]}, [r4]!
	DCD	0xf4a6408d ;	vld1.8	{d4[4]}, [r6]!
	DCD	0xf4a640ad ;	vld1.8	{d4[5]}, [r6]!
	DCD	0xf4a640cd ;	vld1.8	{d4[6]}, [r6]!
	DCD	0xf4a640ed ;	vld1.8	{d4[7]}, [r6]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000003 ;	beq	1090 <pixman_composite_add_8_8_asm_neon+0xc4>
	DCD	0xf424170d ;	vld1.8	{d1}, [r4]!
	DCD	0xf426571d ;	vld1.8	{d5}, [r6 :64]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe2400008 ;	sub	r0, r0, #8
	DCD	0xf4242a0d ;	vld1.8	{d2-d3}, [r4]!
	DCD	0xf4266a2d ;	vld1.8	{d6-d7}, [r6 :128]!
	DCD	0xe28aa010 ;	add	sl, sl, #16
	DCD	0xe2400010 ;	sub	r0, r0, #16
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa020 ;	addne	sl, sl, #32
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf00a ;	pld	[fp, sl]
	DCD	0xf7dcf00a ;	pld	[ip, sl]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8005 ;	ldrbge	r8, [fp, r5]!
	DCD	0xa7fc8003 ;	ldrbge	r8, [ip, r3]!
	DCD	0xe3120001 ;	tst	r2, #1
	DCD	0x0a000000 ;	beq	10dc <pixman_composite_add_8_8_asm_neon+0x110>
	DCD	0xf4c2c02d ;	vst1.8	{d28[1]}, [r2]!
	DCD	0xe3120002 ;	tst	r2, #2
	DCD	0x0a000001 ;	beq	10ec <pixman_composite_add_8_8_asm_neon+0x120>
	DCD	0xf4c2c04d ;	vst1.8	{d28[2]}, [r2]!
	DCD	0xf4c2c06d ;	vst1.8	{d28[3]}, [r2]!
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000003 ;	beq	1104 <pixman_composite_add_8_8_asm_neon+0x138>
	DCD	0xf4c2c08d ;	vst1.8	{d28[4]}, [r2]!
	DCD	0xf4c2c0ad ;	vst1.8	{d28[5]}, [r2]!
	DCD	0xf4c2c0cd ;	vst1.8	{d28[6]}, [r2]!
	DCD	0xf4c2c0ed ;	vst1.8	{d28[7]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	1110 <pixman_composite_add_8_8_asm_neon+0x144>
	DCD	0xf442d71d ;	vst1.8	{d29}, [r2 :64]!
	DCD	0xf442ea2d ;	vst1.8	{d30-d31}, [r2 :128]!
	DCD	0xf426422d ;	vld1.8	{d4-d7}, [r6 :128]!
	DCD	0xf424020d ;	vld1.8	{d0-d3}, [r4]!
	DCD	0xe28aa020 ;	add	sl, sl, #32
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa020 ;	addne	sl, sl, #32
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf00a ;	pld	[fp, sl]
	DCD	0xf7dcf00a ;	pld	[ip, sl]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8005 ;	ldrbge	r8, [fp, r5]!
	DCD	0xa7fc8003 ;	ldrbge	r8, [ip, r3]!
	DCD	0xe2500040 ;	subs	r0, r0, #64	; 0x40
	DCD	0xba000011 ;	blt	11a0 <pixman_composite_add_8_8_asm_neon+0x1d4>
	DCD	0xf424020d ;	vld1.8	{d0-d3}, [r4]!
	DCD	0xe28aa020 ;	add	sl, sl, #32
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0xf426422d ;	vld1.8	{d4-d7}, [r6 :128]!
	DCD	0x128aa020 ;	addne	sl, sl, #32
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xf442c22d ;	vst1.8	{d28-d31}, [r2 :128]!
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf00a ;	pld	[fp, sl]
	DCD	0xf7dcf00a ;	pld	[ip, sl]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xa7fb8005 ;	ldrbge	r8, [fp, r5]!
	DCD	0xa7fc8003 ;	ldrbge	r8, [ip, r3]!
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xe2500020 ;	subs	r0, r0, #32
	DCD	0xaaffffed ;	bge	1158 <pixman_composite_add_8_8_asm_neon+0x18c>
	DCD	0xf442c22d ;	vst1.8	{d28-d31}, [r2 :128]!
	DCD	0xe310001f ;	tst	r0, #31
	DCD	0x0a00003f ;	beq	12ac <pixman_composite_add_8_8_asm_neon+0x2e0>
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000002 ;	beq	11c0 <pixman_composite_add_8_8_asm_neon+0x1f4>
	DCD	0xf4242a0d ;	vld1.8	{d2-d3}, [r4]!
	DCD	0xf4266a2d ;	vld1.8	{d6-d7}, [r6 :128]!
	DCD	0xe28aa010 ;	add	sl, sl, #16
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000002 ;	beq	11d4 <pixman_composite_add_8_8_asm_neon+0x208>
	DCD	0xf424170d ;	vld1.8	{d1}, [r4]!
	DCD	0xf426571d ;	vld1.8	{d5}, [r6 :64]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000008 ;	beq	1200 <pixman_composite_add_8_8_asm_neon+0x234>
	DCD	0xf4a4008d ;	vld1.8	{d0[4]}, [r4]!
	DCD	0xf4a400ad ;	vld1.8	{d0[5]}, [r4]!
	DCD	0xf4a400cd ;	vld1.8	{d0[6]}, [r4]!
	DCD	0xf4a400ed ;	vld1.8	{d0[7]}, [r4]!
	DCD	0xf4a6408d ;	vld1.8	{d4[4]}, [r6]!
	DCD	0xf4a640ad ;	vld1.8	{d4[5]}, [r6]!
	DCD	0xf4a640cd ;	vld1.8	{d4[6]}, [r6]!
	DCD	0xf4a640ed ;	vld1.8	{d4[7]}, [r6]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000004 ;	beq	121c <pixman_composite_add_8_8_asm_neon+0x250>
	DCD	0xf4a4004d ;	vld1.8	{d0[2]}, [r4]!
	DCD	0xf4a4006d ;	vld1.8	{d0[3]}, [r4]!
	DCD	0xf4a6404d ;	vld1.8	{d4[2]}, [r6]!
	DCD	0xf4a6406d ;	vld1.8	{d4[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	1230 <pixman_composite_add_8_8_asm_neon+0x264>
	DCD	0xf4a4002d ;	vld1.8	{d0[1]}, [r4]!
	DCD	0xf4a6402d ;	vld1.8	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa020 ;	addne	sl, sl, #32
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf00a ;	pld	[fp, sl]
	DCD	0xf7dcf00a ;	pld	[ip, sl]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8005 ;	ldrbge	r8, [fp, r5]!
	DCD	0xa7fc8003 ;	ldrbge	r8, [ip, r3]!
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000000 ;	beq	126c <pixman_composite_add_8_8_asm_neon+0x2a0>
	DCD	0xf442ea2d ;	vst1.8	{d30-d31}, [r2 :128]!
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000000 ;	beq	1278 <pixman_composite_add_8_8_asm_neon+0x2ac>
	DCD	0xf442d71d ;	vst1.8	{d29}, [r2 :64]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000003 ;	beq	1290 <pixman_composite_add_8_8_asm_neon+0x2c4>
	DCD	0xf4c2c08d ;	vst1.8	{d28[4]}, [r2]!
	DCD	0xf4c2c0ad ;	vst1.8	{d28[5]}, [r2]!
	DCD	0xf4c2c0cd ;	vst1.8	{d28[6]}, [r2]!
	DCD	0xf4c2c0ed ;	vst1.8	{d28[7]}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	12a0 <pixman_composite_add_8_8_asm_neon+0x2d4>
	DCD	0xf4c2c04d ;	vst1.8	{d28[2]}, [r2]!
	DCD	0xf4c2c06d ;	vst1.8	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	12ac <pixman_composite_add_8_8_asm_neon+0x2e0>
	DCD	0xf4c2c02d ;	vst1.8	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822003 ;	add	r2, r2, r3
	DCD	0xe0844005 ;	add	r4, r4, r5
	DCD	0xe0422000 ;	sub	r2, r2, r0
	DCD	0xe0444000 ;	sub	r4, r4, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff4e ;	bge	1008 <pixman_composite_add_8_8_asm_neon+0x3c>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100020 ;	tst	r0, #32
	DCD	0x0a000004 ;	beq	12ec <pixman_composite_add_8_8_asm_neon+0x320>
	DCD	0xf426420d ;	vld1.8	{d4-d7}, [r6]!
	DCD	0xf424020d ;	vld1.8	{d0-d3}, [r4]!
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xf442c20d ;	vst1.8	{d28-d31}, [r2]!
	DCD	0xe310001f ;	tst	r0, #31
	DCD	0x0a000030 ;	beq	13b8 <pixman_composite_add_8_8_asm_neon+0x3ec>
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000001 ;	beq	1304 <pixman_composite_add_8_8_asm_neon+0x338>
	DCD	0xf4242a0d ;	vld1.8	{d2-d3}, [r4]!
	DCD	0xf4266a0d ;	vld1.8	{d6-d7}, [r6]!
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000001 ;	beq	1314 <pixman_composite_add_8_8_asm_neon+0x348>
	DCD	0xf424170d ;	vld1.8	{d1}, [r4]!
	DCD	0xf426570d ;	vld1.8	{d5}, [r6]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000007 ;	beq	133c <pixman_composite_add_8_8_asm_neon+0x370>
	DCD	0xf4a4008d ;	vld1.8	{d0[4]}, [r4]!
	DCD	0xf4a400ad ;	vld1.8	{d0[5]}, [r4]!
	DCD	0xf4a400cd ;	vld1.8	{d0[6]}, [r4]!
	DCD	0xf4a400ed ;	vld1.8	{d0[7]}, [r4]!
	DCD	0xf4a6408d ;	vld1.8	{d4[4]}, [r6]!
	DCD	0xf4a640ad ;	vld1.8	{d4[5]}, [r6]!
	DCD	0xf4a640cd ;	vld1.8	{d4[6]}, [r6]!
	DCD	0xf4a640ed ;	vld1.8	{d4[7]}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000003 ;	beq	1354 <pixman_composite_add_8_8_asm_neon+0x388>
	DCD	0xf4a4004d ;	vld1.8	{d0[2]}, [r4]!
	DCD	0xf4a4006d ;	vld1.8	{d0[3]}, [r4]!
	DCD	0xf4a6404d ;	vld1.8	{d4[2]}, [r6]!
	DCD	0xf4a6406d ;	vld1.8	{d4[3]}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	1364 <pixman_composite_add_8_8_asm_neon+0x398>
	DCD	0xf4a4002d ;	vld1.8	{d0[1]}, [r4]!
	DCD	0xf4a6402d ;	vld1.8	{d4[1]}, [r6]!
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000000 ;	beq	1378 <pixman_composite_add_8_8_asm_neon+0x3ac>
	DCD	0xf442ea0d ;	vst1.8	{d30-d31}, [r2]!
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000000 ;	beq	1384 <pixman_composite_add_8_8_asm_neon+0x3b8>
	DCD	0xf442d70d ;	vst1.8	{d29}, [r2]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000003 ;	beq	139c <pixman_composite_add_8_8_asm_neon+0x3d0>
	DCD	0xf4c2c08d ;	vst1.8	{d28[4]}, [r2]!
	DCD	0xf4c2c0ad ;	vst1.8	{d28[5]}, [r2]!
	DCD	0xf4c2c0cd ;	vst1.8	{d28[6]}, [r2]!
	DCD	0xf4c2c0ed ;	vst1.8	{d28[7]}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	13ac <pixman_composite_add_8_8_asm_neon+0x3e0>
	DCD	0xf4c2c04d ;	vst1.8	{d28[2]}, [r2]!
	DCD	0xf4c2c06d ;	vst1.8	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	13b8 <pixman_composite_add_8_8_asm_neon+0x3ec>
	DCD	0xf4c2c02d ;	vst1.8	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822003 ;	add	r2, r2, r3
	DCD	0xe0844005 ;	add	r4, r4, r5
	DCD	0xe0422000 ;	sub	r2, r2, r0
	DCD	0xe0444000 ;	sub	r4, r4, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffbd ;	bge	12d0 <pixman_composite_add_8_8_asm_neon+0x304>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_add_8_8_asm_neon|

|pixman_composite_add_8888_8888_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe2499006 ;	sub	r9, r9, #6
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a07000 ;	mov	r7, r0
	DCD	0xba0000a1 ;	blt	1698 <pixman_composite_add_8888_8888_asm_neon+0x2bc>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba000077 ;	blt	15f8 <pixman_composite_add_8888_8888_asm_neon+0x21c>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000022 ;	beq	14ac <pixman_composite_add_8888_8888_asm_neon+0xd0>
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000003 ;	beq	1438 <pixman_composite_add_8888_8888_asm_neon+0x5c>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000003 ;	beq	1450 <pixman_composite_add_8888_8888_asm_neon+0x74>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000000 ;	beq	149c <pixman_composite_add_8888_8888_asm_neon+0xc0>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	14a8 <pixman_composite_add_8888_8888_asm_neon+0xcc>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xf42642ad ;	vld1.32	{d4-d7}, [r6 :128]!
	DCD	0xf424028d ;	vld1.32	{d0-d3}, [r4]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba000011 ;	blt	1538 <pixman_composite_add_8888_8888_asm_neon+0x15c>
	DCD	0xf424028d ;	vld1.32	{d0-d3}, [r4]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0xf42642ad ;	vld1.32	{d4-d7}, [r6 :128]!
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xf442c2ad ;	vst1.32	{d28-d31}, [r2 :128]!
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffed ;	bge	14f0 <pixman_composite_add_8888_8888_asm_neon+0x114>
	DCD	0xf442c2ad ;	vst1.32	{d28-d31}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000023 ;	beq	15d4 <pixman_composite_add_8888_8888_asm_neon+0x1f8>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000002 ;	beq	1558 <pixman_composite_add_8888_8888_asm_neon+0x17c>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000002 ;	beq	156c <pixman_composite_add_8888_8888_asm_neon+0x190>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	1580 <pixman_composite_add_8888_8888_asm_neon+0x1a4>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	15bc <pixman_composite_add_8888_8888_asm_neon+0x1e0>
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	15c8 <pixman_composite_add_8888_8888_asm_neon+0x1ec>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	15d4 <pixman_composite_add_8888_8888_asm_neon+0x1f8>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff88 ;	bge	1418 <pixman_composite_add_8888_8888_asm_neon+0x3c>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000004 ;	beq	1614 <pixman_composite_add_8888_8888_asm_neon+0x238>
	DCD	0xf426428d ;	vld1.32	{d4-d7}, [r6]!
	DCD	0xf424028d ;	vld1.32	{d0-d3}, [r4]!
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xf442c28d ;	vst1.32	{d28-d31}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000016 ;	beq	1678 <pixman_composite_add_8888_8888_asm_neon+0x29c>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000001 ;	beq	162c <pixman_composite_add_8888_8888_asm_neon+0x250>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xf4266a8d ;	vld1.32	{d6-d7}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	163c <pixman_composite_add_8888_8888_asm_neon+0x260>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xf426578d ;	vld1.32	{d5}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	164c <pixman_composite_add_8888_8888_asm_neon+0x270>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	1660 <pixman_composite_add_8888_8888_asm_neon+0x284>
	DCD	0xf442ea8d ;	vst1.32	{d30-d31}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	166c <pixman_composite_add_8888_8888_asm_neon+0x290>
	DCD	0xf442d78d ;	vst1.32	{d29}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	1678 <pixman_composite_add_8888_8888_asm_neon+0x29c>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffd7 ;	bge	15f8 <pixman_composite_add_8888_8888_asm_neon+0x21c>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_add_8888_8888_asm_neon|

|pixman_composite_scanline_add_asm_neon| PROC
	DCD	0xe1a0c001 ;	mov	ip, r1
	DCD	0xe3500008 ;	cmp	r0, #8
	DCD	0xba000041 ;	blt	17b0 <pixman_composite_scanline_add_asm_neon+0x114>
	DCD	0xe31c000f ;	tst	ip, #15
	DCD	0x0a000015 ;	beq	1708 <pixman_composite_scanline_add_asm_neon+0x6c>
	DCD	0xe31c0004 ;	tst	ip, #4
	DCD	0x0a000002 ;	beq	16c4 <pixman_composite_scanline_add_asm_neon+0x28>
	DCD	0xf4a2088d ;	vld1.32	{d0[1]}, [r2]!
	DCD	0xf4ac488d ;	vld1.32	{d4[1]}, [ip]!
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe31c0008 ;	tst	ip, #8
	DCD	0x0a000002 ;	beq	16d8 <pixman_composite_scanline_add_asm_neon+0x3c>
	DCD	0xf422178d ;	vld1.32	{d1}, [r2]!
	DCD	0xf42c579d ;	vld1.32	{d5}, [ip :64]!
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xf4222a8d ;	vld1.32	{d2-d3}, [r2]!
	DCD	0xf42c6aad ;	vld1.32	{d6-d7}, [ip :128]!
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xe3110004 ;	tst	r1, #4
	DCD	0x0a000000 ;	beq	16f8 <pixman_composite_scanline_add_asm_neon+0x5c>
	DCD	0xf4c1c88d ;	vst1.32	{d28[1]}, [r1]!
	DCD	0xe3110008 ;	tst	r1, #8
	DCD	0x0a000000 ;	beq	1704 <pixman_composite_scanline_add_asm_neon+0x68>
	DCD	0xf441d79d ;	vst1.32	{d29}, [r1 :64]!
	DCD	0xf441eaad ;	vst1.32	{d30-d31}, [r1 :128]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xba00000d ;	blt	1748 <pixman_composite_scanline_add_asm_neon+0xac>
	DCD	0xf42c42ad ;	vld1.32	{d4-d7}, [ip :128]!
	DCD	0xf422028d ;	vld1.32	{d0-d3}, [r2]!
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xba000006 ;	blt	1744 <pixman_composite_scanline_add_asm_neon+0xa8>
	DCD	0xf422028d ;	vld1.32	{d0-d3}, [r2]!
	DCD	0xf42c42ad ;	vld1.32	{d4-d7}, [ip :128]!
	DCD	0xf441c2ad ;	vst1.32	{d28-d31}, [r1 :128]!
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaafffff8 ;	bge	1728 <pixman_composite_scanline_add_asm_neon+0x8c>
	DCD	0xf441c2ad ;	vst1.32	{d28-d31}, [r1 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000016 ;	beq	17ac <pixman_composite_scanline_add_asm_neon+0x110>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000001 ;	beq	1760 <pixman_composite_scanline_add_asm_neon+0xc4>
	DCD	0xf4222a8d ;	vld1.32	{d2-d3}, [r2]!
	DCD	0xf42c6aad ;	vld1.32	{d6-d7}, [ip :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	1770 <pixman_composite_scanline_add_asm_neon+0xd4>
	DCD	0xf422178d ;	vld1.32	{d1}, [r2]!
	DCD	0xf42c579d ;	vld1.32	{d5}, [ip :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	1780 <pixman_composite_scanline_add_asm_neon+0xe4>
	DCD	0xf4a2088d ;	vld1.32	{d0[1]}, [r2]!
	DCD	0xf4ac488d ;	vld1.32	{d4[1]}, [ip]!
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	1794 <pixman_composite_scanline_add_asm_neon+0xf8>
	DCD	0xf441eaad ;	vst1.32	{d30-d31}, [r1 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	17a0 <pixman_composite_scanline_add_asm_neon+0x104>
	DCD	0xf441d79d ;	vst1.32	{d29}, [r1 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	17ac <pixman_composite_scanline_add_asm_neon+0x110>
	DCD	0xf4c1c88d ;	vst1.32	{d28[1]}, [r1]!
	DCD	0xe12fff1e ;	bx	lr
	;		17ac: R_ARM_V4BX	*ABS*
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000016 ;	beq	1814 <pixman_composite_scanline_add_asm_neon+0x178>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000001 ;	beq	17c8 <pixman_composite_scanline_add_asm_neon+0x12c>
	DCD	0xf4222a8d ;	vld1.32	{d2-d3}, [r2]!
	DCD	0xf42c6a8d ;	vld1.32	{d6-d7}, [ip]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	17d8 <pixman_composite_scanline_add_asm_neon+0x13c>
	DCD	0xf422178d ;	vld1.32	{d1}, [r2]!
	DCD	0xf42c578d ;	vld1.32	{d5}, [ip]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	17e8 <pixman_composite_scanline_add_asm_neon+0x14c>
	DCD	0xf4a2088d ;	vld1.32	{d0[1]}, [r2]!
	DCD	0xf4ac488d ;	vld1.32	{d4[1]}, [ip]!
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	17fc <pixman_composite_scanline_add_asm_neon+0x160>
	DCD	0xf441ea8d ;	vst1.32	{d30-d31}, [r1]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	1808 <pixman_composite_scanline_add_asm_neon+0x16c>
	DCD	0xf441d78d ;	vst1.32	{d29}, [r1]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	1814 <pixman_composite_scanline_add_asm_neon+0x178>
	DCD	0xf4c1c88d ;	vst1.32	{d28[1]}, [r1]!
	DCD	0xe12fff1e ;	bx	lr
	;		1814: R_ARM_V4BX	*ABS*
	ENDP  ; |pixman_composite_scanline_add_asm_neon|

|pixman_composite_scanline_out_reverse_asm_neon| PROC
	DCD	0xe1a0c001 ;	mov	ip, r1
	DCD	0xe3500008 ;	cmp	r0, #8
	DCD	0xba000085 ;	blt	1a3c <pixman_composite_scanline_out_reverse_asm_neon+0x224>
	DCD	0xe31c000f ;	tst	ip, #15
	DCD	0x0a00002c ;	beq	18e0 <pixman_composite_scanline_out_reverse_asm_neon+0xc8>
	DCD	0xe31c0004 ;	tst	ip, #4
	DCD	0x0a000002 ;	beq	1840 <pixman_composite_scanline_out_reverse_asm_neon+0x28>
	DCD	0xf4a2088d ;	vld1.32	{d0[1]}, [r2]!
	DCD	0xf4ac488d ;	vld1.32	{d4[1]}, [ip]!
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe31c0008 ;	tst	ip, #8
	DCD	0x0a000002 ;	beq	1854 <pixman_composite_scanline_out_reverse_asm_neon+0x3c>
	DCD	0xf422178d ;	vld1.32	{d1}, [r2]!
	DCD	0xf42c579d ;	vld1.32	{d5}, [ip :64]!
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xf4222a8d ;	vld1.32	{d2-d3}, [r2]!
	DCD	0xf42c6aad ;	vld1.32	{d6-d7}, [ip :128]!
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3110004 ;	tst	r1, #4
	DCD	0x0a000000 ;	beq	18d0 <pixman_composite_scanline_out_reverse_asm_neon+0xb8>
	DCD	0xf4c1c88d ;	vst1.32	{d28[1]}, [r1]!
	DCD	0xe3110008 ;	tst	r1, #8
	DCD	0x0a000000 ;	beq	18dc <pixman_composite_scanline_out_reverse_asm_neon+0xc4>
	DCD	0xf441d79d ;	vst1.32	{d29}, [r1 :64]!
	DCD	0xf441eaad ;	vst1.32	{d30-d31}, [r1 :128]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xba000023 ;	blt	1978 <pixman_composite_scanline_out_reverse_asm_neon+0x160>
	DCD	0xf42c402d ;	vld4.8	{d4-d7}, [ip :128]!
	DCD	0xf422000d ;	vld4.8	{d0-d3}, [r2]!
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xba000011 ;	blt	1954 <pixman_composite_scanline_out_reverse_asm_neon+0x13c>
	DCD	0xf42c402d ;	vld4.8	{d4-d7}, [ip :128]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf422000d ;	vld4.8	{d0-d3}, [r2]!
	DCD	0xf3f06583 ;	vmvn	d22, d3
	DCD	0xf441c02d ;	vst4.8	{d28-d31}, [r1 :128]!
	DCD	0xf3c60c84 ;	vmull.u8	q8, d22, d4
	DCD	0xf3c62c85 ;	vmull.u8	q9, d22, d5
	DCD	0xf3c64c86 ;	vmull.u8	q10, d22, d6
	DCD	0xf3c66c87 ;	vmull.u8	q11, d22, d7
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffed ;	bge	190c <pixman_composite_scanline_out_reverse_asm_neon+0xf4>
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf441c02d ;	vst4.8	{d28-d31}, [r1 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00002d ;	beq	1a38 <pixman_composite_scanline_out_reverse_asm_neon+0x220>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000001 ;	beq	1990 <pixman_composite_scanline_out_reverse_asm_neon+0x178>
	DCD	0xf4222a8d ;	vld1.32	{d2-d3}, [r2]!
	DCD	0xf42c6aad ;	vld1.32	{d6-d7}, [ip :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	19a0 <pixman_composite_scanline_out_reverse_asm_neon+0x188>
	DCD	0xf422178d ;	vld1.32	{d1}, [r2]!
	DCD	0xf42c579d ;	vld1.32	{d5}, [ip :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	19b0 <pixman_composite_scanline_out_reverse_asm_neon+0x198>
	DCD	0xf4a2088d ;	vld1.32	{d0[1]}, [r2]!
	DCD	0xf4ac488d ;	vld1.32	{d4[1]}, [ip]!
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	1a20 <pixman_composite_scanline_out_reverse_asm_neon+0x208>
	DCD	0xf441eaad ;	vst1.32	{d30-d31}, [r1 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	1a2c <pixman_composite_scanline_out_reverse_asm_neon+0x214>
	DCD	0xf441d79d ;	vst1.32	{d29}, [r1 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	1a38 <pixman_composite_scanline_out_reverse_asm_neon+0x220>
	DCD	0xf4c1c88d ;	vst1.32	{d28[1]}, [r1]!
	DCD	0xe12fff1e ;	bx	lr
	;		1a38: R_ARM_V4BX	*ABS*
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00002d ;	beq	1afc <pixman_composite_scanline_out_reverse_asm_neon+0x2e4>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000001 ;	beq	1a54 <pixman_composite_scanline_out_reverse_asm_neon+0x23c>
	DCD	0xf4222a8d ;	vld1.32	{d2-d3}, [r2]!
	DCD	0xf42c6a8d ;	vld1.32	{d6-d7}, [ip]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	1a64 <pixman_composite_scanline_out_reverse_asm_neon+0x24c>
	DCD	0xf422178d ;	vld1.32	{d1}, [r2]!
	DCD	0xf42c578d ;	vld1.32	{d5}, [ip]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	1a74 <pixman_composite_scanline_out_reverse_asm_neon+0x25c>
	DCD	0xf4a2088d ;	vld1.32	{d0[1]}, [r2]!
	DCD	0xf4ac488d ;	vld1.32	{d4[1]}, [ip]!
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	1ae4 <pixman_composite_scanline_out_reverse_asm_neon+0x2cc>
	DCD	0xf441ea8d ;	vst1.32	{d30-d31}, [r1]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	1af0 <pixman_composite_scanline_out_reverse_asm_neon+0x2d8>
	DCD	0xf441d78d ;	vst1.32	{d29}, [r1]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	1afc <pixman_composite_scanline_out_reverse_asm_neon+0x2e4>
	DCD	0xf4c1c88d ;	vst1.32	{d28[1]}, [r1]!
	DCD	0xe12fff1e ;	bx	lr
	;		1afc: R_ARM_V4BX	*ABS*
	ENDP  ; |pixman_composite_scanline_out_reverse_asm_neon|

|pixman_composite_over_8888_8888_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a07000 ;	mov	r7, r0
	DCD	0xba000113 ;	blt	1f84 <pixman_composite_over_8888_8888_asm_neon+0x484>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba0000c3 ;	blt	1e4c <pixman_composite_over_8888_8888_asm_neon+0x34c>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a00003b ;	beq	1c34 <pixman_composite_over_8888_8888_asm_neon+0x134>
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000003 ;	beq	1b5c <pixman_composite_over_8888_8888_asm_neon+0x5c>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000003 ;	beq	1b74 <pixman_composite_over_8888_8888_asm_neon+0x74>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000000 ;	beq	1c24 <pixman_composite_over_8888_8888_asm_neon+0x124>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	1c30 <pixman_composite_over_8888_8888_asm_neon+0x130>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xf426402d ;	vld4.8	{d4-d7}, [r6 :128]!
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba00001e ;	blt	1d00 <pixman_composite_over_8888_8888_asm_neon+0x200>
	DCD	0xf426402d ;	vld4.8	{d4-d7}, [r6 :128]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf3f06583 ;	vmvn	d22, d3
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xf3c60c84 ;	vmull.u8	q8, d22, d4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xf3c62c85 ;	vmull.u8	q9, d22, d5
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xf3c64c86 ;	vmull.u8	q10, d22, d6
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xf3c66c87 ;	vmull.u8	q11, d22, d7
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffe0 ;	bge	1c84 <pixman_composite_over_8888_8888_asm_neon+0x184>
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00003c ;	beq	1e28 <pixman_composite_over_8888_8888_asm_neon+0x328>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000002 ;	beq	1d48 <pixman_composite_over_8888_8888_asm_neon+0x248>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000002 ;	beq	1d5c <pixman_composite_over_8888_8888_asm_neon+0x25c>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	1d70 <pixman_composite_over_8888_8888_asm_neon+0x270>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	1e10 <pixman_composite_over_8888_8888_asm_neon+0x310>
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	1e1c <pixman_composite_over_8888_8888_asm_neon+0x31c>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	1e28 <pixman_composite_over_8888_8888_asm_neon+0x328>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff3c ;	bge	1b3c <pixman_composite_over_8888_8888_asm_neon+0x3c>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000011 ;	beq	1e9c <pixman_composite_over_8888_8888_asm_neon+0x39c>
	DCD	0xf426400d ;	vld4.8	{d4-d7}, [r6]!
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf442c00d ;	vst4.8	{d28-d31}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00002f ;	beq	1f64 <pixman_composite_over_8888_8888_asm_neon+0x464>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000001 ;	beq	1eb4 <pixman_composite_over_8888_8888_asm_neon+0x3b4>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xf4266a8d ;	vld1.32	{d6-d7}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	1ec4 <pixman_composite_over_8888_8888_asm_neon+0x3c4>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xf426578d ;	vld1.32	{d5}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	1ed4 <pixman_composite_over_8888_8888_asm_neon+0x3d4>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	1f4c <pixman_composite_over_8888_8888_asm_neon+0x44c>
	DCD	0xf442ea8d ;	vst1.32	{d30-d31}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	1f58 <pixman_composite_over_8888_8888_asm_neon+0x458>
	DCD	0xf442d78d ;	vst1.32	{d29}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	1f64 <pixman_composite_over_8888_8888_asm_neon+0x464>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffb1 ;	bge	1e4c <pixman_composite_over_8888_8888_asm_neon+0x34c>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_over_8888_8888_asm_neon|

|pixman_composite_scanline_over_asm_neon| PROC
	DCD	0xe1a0c001 ;	mov	ip, r1
	DCD	0xe3500008 ;	cmp	r0, #8
	DCD	0xba00008d ;	blt	21cc <pixman_composite_scanline_over_asm_neon+0x244>
	DCD	0xe31c000f ;	tst	ip, #15
	DCD	0x0a00002e ;	beq	2058 <pixman_composite_scanline_over_asm_neon+0xd0>
	DCD	0xe31c0004 ;	tst	ip, #4
	DCD	0x0a000002 ;	beq	1fb0 <pixman_composite_scanline_over_asm_neon+0x28>
	DCD	0xf4a2088d ;	vld1.32	{d0[1]}, [r2]!
	DCD	0xf4ac488d ;	vld1.32	{d4[1]}, [ip]!
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe31c0008 ;	tst	ip, #8
	DCD	0x0a000002 ;	beq	1fc4 <pixman_composite_scanline_over_asm_neon+0x3c>
	DCD	0xf422178d ;	vld1.32	{d1}, [r2]!
	DCD	0xf42c579d ;	vld1.32	{d5}, [ip :64]!
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xf4222a8d ;	vld1.32	{d2-d3}, [r2]!
	DCD	0xf42c6aad ;	vld1.32	{d6-d7}, [ip :128]!
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3110004 ;	tst	r1, #4
	DCD	0x0a000000 ;	beq	2048 <pixman_composite_scanline_over_asm_neon+0xc0>
	DCD	0xf4c1c88d ;	vst1.32	{d28[1]}, [r1]!
	DCD	0xe3110008 ;	tst	r1, #8
	DCD	0x0a000000 ;	beq	2054 <pixman_composite_scanline_over_asm_neon+0xcc>
	DCD	0xf441d79d ;	vst1.32	{d29}, [r1 :64]!
	DCD	0xf441eaad ;	vst1.32	{d30-d31}, [r1 :128]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xba000027 ;	blt	2100 <pixman_composite_scanline_over_asm_neon+0x178>
	DCD	0xf42c402d ;	vld4.8	{d4-d7}, [ip :128]!
	DCD	0xf422000d ;	vld4.8	{d0-d3}, [r2]!
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xba000013 ;	blt	20d4 <pixman_composite_scanline_over_asm_neon+0x14c>
	DCD	0xf42c402d ;	vld4.8	{d4-d7}, [ip :128]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf422000d ;	vld4.8	{d0-d3}, [r2]!
	DCD	0xf3f06583 ;	vmvn	d22, d3
	DCD	0xf441c02d ;	vst4.8	{d28-d31}, [r1 :128]!
	DCD	0xf3c60c84 ;	vmull.u8	q8, d22, d4
	DCD	0xf3c62c85 ;	vmull.u8	q9, d22, d5
	DCD	0xf3c64c86 ;	vmull.u8	q10, d22, d6
	DCD	0xf3c66c87 ;	vmull.u8	q11, d22, d7
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffeb ;	bge	2084 <pixman_composite_scanline_over_asm_neon+0xfc>
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf441c02d ;	vst4.8	{d28-d31}, [r1 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00002f ;	beq	21c8 <pixman_composite_scanline_over_asm_neon+0x240>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000001 ;	beq	2118 <pixman_composite_scanline_over_asm_neon+0x190>
	DCD	0xf4222a8d ;	vld1.32	{d2-d3}, [r2]!
	DCD	0xf42c6aad ;	vld1.32	{d6-d7}, [ip :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	2128 <pixman_composite_scanline_over_asm_neon+0x1a0>
	DCD	0xf422178d ;	vld1.32	{d1}, [r2]!
	DCD	0xf42c579d ;	vld1.32	{d5}, [ip :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	2138 <pixman_composite_scanline_over_asm_neon+0x1b0>
	DCD	0xf4a2088d ;	vld1.32	{d0[1]}, [r2]!
	DCD	0xf4ac488d ;	vld1.32	{d4[1]}, [ip]!
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	21b0 <pixman_composite_scanline_over_asm_neon+0x228>
	DCD	0xf441eaad ;	vst1.32	{d30-d31}, [r1 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	21bc <pixman_composite_scanline_over_asm_neon+0x234>
	DCD	0xf441d79d ;	vst1.32	{d29}, [r1 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	21c8 <pixman_composite_scanline_over_asm_neon+0x240>
	DCD	0xf4c1c88d ;	vst1.32	{d28[1]}, [r1]!
	DCD	0xe12fff1e ;	bx	lr
	;		21c8: R_ARM_V4BX	*ABS*
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00002f ;	beq	2294 <pixman_composite_scanline_over_asm_neon+0x30c>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000001 ;	beq	21e4 <pixman_composite_scanline_over_asm_neon+0x25c>
	DCD	0xf4222a8d ;	vld1.32	{d2-d3}, [r2]!
	DCD	0xf42c6a8d ;	vld1.32	{d6-d7}, [ip]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	21f4 <pixman_composite_scanline_over_asm_neon+0x26c>
	DCD	0xf422178d ;	vld1.32	{d1}, [r2]!
	DCD	0xf42c578d ;	vld1.32	{d5}, [ip]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	2204 <pixman_composite_scanline_over_asm_neon+0x27c>
	DCD	0xf4a2088d ;	vld1.32	{d0[1]}, [r2]!
	DCD	0xf4ac488d ;	vld1.32	{d4[1]}, [ip]!
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	227c <pixman_composite_scanline_over_asm_neon+0x2f4>
	DCD	0xf441ea8d ;	vst1.32	{d30-d31}, [r1]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	2288 <pixman_composite_scanline_over_asm_neon+0x300>
	DCD	0xf441d78d ;	vst1.32	{d29}, [r1]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	2294 <pixman_composite_scanline_over_asm_neon+0x30c>
	DCD	0xf4c1c88d ;	vst1.32	{d28[1]}, [r1]!
	DCD	0xe12fff1e ;	bx	lr
	;		2294: R_ARM_V4BX	*ABS*
	ENDP  ; |pixman_composite_scanline_over_asm_neon|

|pixman_composite_over_n_8888_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xe28d8028 ;	add	r8, sp, #40	; 0x28
	DCD	0xf4a8380f ;	vld1.32	{d3[0]}, [r8]
	DCD	0xf3b10c03 ;	vdup.8	d0, d3[0]
	DCD	0xf3b31c03 ;	vdup.8	d1, d3[1]
	DCD	0xf3b52c03 ;	vdup.8	d2, d3[2]
	DCD	0xf3b73c03 ;	vdup.8	d3, d3[3]
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a07000 ;	mov	r7, r0
	DCD	0xba0000ee ;	blt	269c <pixman_composite_over_n_8888_asm_neon+0x404>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba0000a8 ;	blt	258c <pixman_composite_over_n_8888_asm_neon+0x2f4>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000032 ;	beq	23bc <pixman_composite_over_n_8888_asm_neon+0x124>
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000002 ;	beq	2304 <pixman_composite_over_n_8888_asm_neon+0x6c>
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000002 ;	beq	2318 <pixman_composite_over_n_8888_asm_neon+0x80>
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000000 ;	beq	23ac <pixman_composite_over_n_8888_asm_neon+0x114>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	23b8 <pixman_composite_over_n_8888_asm_neon+0x120>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xf426402d ;	vld4.8	{d4-d7}, [r6 :128]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba00001a ;	blt	246c <pixman_composite_over_n_8888_asm_neon+0x1d4>
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3984274 ;	vrshr.u16	q2, q10, #8
	DCD	0xf3986276 ;	vrshr.u16	q3, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c4e424 ;	vraddhn.i16	d30, q2, q10
	DCD	0xf3c6f426 ;	vraddhn.i16	d31, q3, q11
	DCD	0xf426402d ;	vld4.8	{d4-d7}, [r6 :128]!
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffe4 ;	bge	2400 <pixman_composite_over_n_8888_asm_neon+0x168>
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000033 ;	beq	2570 <pixman_composite_over_n_8888_asm_neon+0x2d8>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000001 ;	beq	24b0 <pixman_composite_over_n_8888_asm_neon+0x218>
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	24c0 <pixman_composite_over_n_8888_asm_neon+0x228>
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	24d0 <pixman_composite_over_n_8888_asm_neon+0x238>
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	2558 <pixman_composite_over_n_8888_asm_neon+0x2c0>
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	2564 <pixman_composite_over_n_8888_asm_neon+0x2cc>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	2570 <pixman_composite_over_n_8888_asm_neon+0x2d8>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff57 ;	bge	22e8 <pixman_composite_over_n_8888_asm_neon+0x50>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000010 ;	beq	25d8 <pixman_composite_over_n_8888_asm_neon+0x340>
	DCD	0xf426400d ;	vld4.8	{d4-d7}, [r6]!
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf442c00d ;	vst4.8	{d28-d31}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000028 ;	beq	2684 <pixman_composite_over_n_8888_asm_neon+0x3ec>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	25ec <pixman_composite_over_n_8888_asm_neon+0x354>
	DCD	0xf4266a8d ;	vld1.32	{d6-d7}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	25f8 <pixman_composite_over_n_8888_asm_neon+0x360>
	DCD	0xf426578d ;	vld1.32	{d5}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	2604 <pixman_composite_over_n_8888_asm_neon+0x36c>
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	266c <pixman_composite_over_n_8888_asm_neon+0x3d4>
	DCD	0xf442ea8d ;	vst1.32	{d30-d31}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	2678 <pixman_composite_over_n_8888_asm_neon+0x3e0>
	DCD	0xf442d78d ;	vst1.32	{d29}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	2684 <pixman_composite_over_n_8888_asm_neon+0x3ec>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffbb ;	bge	258c <pixman_composite_over_n_8888_asm_neon+0x2f4>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_over_n_8888_asm_neon|

|pixman_composite_over_reverse_n_8888_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xe28d8028 ;	add	r8, sp, #40	; 0x28
	DCD	0xf4a8780f ;	vld1.32	{d7[0]}, [r8]
	DCD	0xf3b14c07 ;	vdup.8	d4, d7[0]
	DCD	0xf3b35c07 ;	vdup.8	d5, d7[1]
	DCD	0xf3b56c07 ;	vdup.8	d6, d7[2]
	DCD	0xf3b77c07 ;	vdup.8	d7, d7[3]
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a07000 ;	mov	r7, r0
	DCD	0xba0000ef ;	blt	2aa4 <pixman_composite_over_reverse_n_8888_asm_neon+0x404>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba0000a9 ;	blt	2994 <pixman_composite_over_reverse_n_8888_asm_neon+0x2f4>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000032 ;	beq	27c0 <pixman_composite_over_reverse_n_8888_asm_neon+0x120>
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000002 ;	beq	2708 <pixman_composite_over_reverse_n_8888_asm_neon+0x68>
	DCD	0xf4a6088d ;	vld1.32	{d0[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000002 ;	beq	271c <pixman_composite_over_reverse_n_8888_asm_neon+0x7c>
	DCD	0xf426179d ;	vld1.32	{d1}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xf4262aad ;	vld1.32	{d2-d3}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000000 ;	beq	27b0 <pixman_composite_over_reverse_n_8888_asm_neon+0x110>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	27bc <pixman_composite_over_reverse_n_8888_asm_neon+0x11c>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xf426002d ;	vld4.8	{d0-d3}, [r6 :128]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba00001b ;	blt	2874 <pixman_composite_over_reverse_n_8888_asm_neon+0x1d4>
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf426002d ;	vld4.8	{d0-d3}, [r6 :128]!
	DCD	0xf3f06583 ;	vmvn	d22, d3
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xf3c60c84 ;	vmull.u8	q8, d22, d4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xf3c62c85 ;	vmull.u8	q9, d22, d5
	DCD	0xf3c64c86 ;	vmull.u8	q10, d22, d6
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xf3c66c87 ;	vmull.u8	q11, d22, d7
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffe3 ;	bge	2804 <pixman_composite_over_reverse_n_8888_asm_neon+0x164>
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000033 ;	beq	2978 <pixman_composite_over_reverse_n_8888_asm_neon+0x2d8>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000001 ;	beq	28b8 <pixman_composite_over_reverse_n_8888_asm_neon+0x218>
	DCD	0xf4262aad ;	vld1.32	{d2-d3}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	28c8 <pixman_composite_over_reverse_n_8888_asm_neon+0x228>
	DCD	0xf426179d ;	vld1.32	{d1}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	28d8 <pixman_composite_over_reverse_n_8888_asm_neon+0x238>
	DCD	0xf4a6088d ;	vld1.32	{d0[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	2960 <pixman_composite_over_reverse_n_8888_asm_neon+0x2c0>
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	296c <pixman_composite_over_reverse_n_8888_asm_neon+0x2cc>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	2978 <pixman_composite_over_reverse_n_8888_asm_neon+0x2d8>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff56 ;	bge	26ec <pixman_composite_over_reverse_n_8888_asm_neon+0x4c>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000010 ;	beq	29e0 <pixman_composite_over_reverse_n_8888_asm_neon+0x340>
	DCD	0xf426000d ;	vld4.8	{d0-d3}, [r6]!
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf442c00d ;	vst4.8	{d28-d31}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000028 ;	beq	2a8c <pixman_composite_over_reverse_n_8888_asm_neon+0x3ec>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	29f4 <pixman_composite_over_reverse_n_8888_asm_neon+0x354>
	DCD	0xf4262a8d ;	vld1.32	{d2-d3}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	2a00 <pixman_composite_over_reverse_n_8888_asm_neon+0x360>
	DCD	0xf426178d ;	vld1.32	{d1}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	2a0c <pixman_composite_over_reverse_n_8888_asm_neon+0x36c>
	DCD	0xf4a6088d ;	vld1.32	{d0[1]}, [r6]!
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	2a74 <pixman_composite_over_reverse_n_8888_asm_neon+0x3d4>
	DCD	0xf442ea8d ;	vst1.32	{d30-d31}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	2a80 <pixman_composite_over_reverse_n_8888_asm_neon+0x3e0>
	DCD	0xf442d78d ;	vst1.32	{d29}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	2a8c <pixman_composite_over_reverse_n_8888_asm_neon+0x3ec>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffbb ;	bge	2994 <pixman_composite_over_reverse_n_8888_asm_neon+0x2f4>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_over_reverse_n_8888_asm_neon|

|pixman_composite_over_8888_8_0565_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe59d7030 ;	ldr	r7, [sp, #48]	; 0x30
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe59d8034 ;	ldr	r8, [sp, #52]	; 0x34
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xed2d8b10 ;	vpush	{d8-d15}
	DCD	0xe92d0003 ;	push	{r0, r1}
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe58d1004 ;	str	r1, [sp, #4]
	DCD	0xba0001a9 ;	blt	3194 <pixman_composite_over_8888_8_0565_asm_neon+0x6ec>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba00012c ;	blt	2fa8 <pixman_composite_over_8888_8_0565_asm_neon+0x500>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000057 ;	beq	2c5c <pixman_composite_over_8888_8_0565_asm_neon+0x1b4>
	DCD	0xe3160002 ;	tst	r6, #2
	DCD	0x0a000004 ;	beq	2b18 <pixman_composite_over_8888_8_0565_asm_neon+0x70>
	DCD	0xf4a4888d ;	vld1.32	{d8[1]}, [r4]!
	DCD	0xf4e7802d ;	vld1.8	{d24[1]}, [r7]!
	DCD	0xf4a6444d ;	vld1.16	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000006 ;	beq	2b3c <pixman_composite_over_8888_8_0565_asm_neon+0x94>
	DCD	0xf424978d ;	vld1.32	{d9}, [r4]!
	DCD	0xf4e7804d ;	vld1.8	{d24[2]}, [r7]!
	DCD	0xf4e7806d ;	vld1.8	{d24[3]}, [r7]!
	DCD	0xf4a6448d ;	vld1.16	{d4[2]}, [r6]!
	DCD	0xf4a644cd ;	vld1.16	{d4[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000007 ;	beq	2b64 <pixman_composite_over_8888_8_0565_asm_neon+0xbc>
	DCD	0xf424aa8d ;	vld1.32	{d10-d11}, [r4]!
	DCD	0xf4e7808d ;	vld1.8	{d24[4]}, [r7]!
	DCD	0xf4e780ad ;	vld1.8	{d24[5]}, [r7]!
	DCD	0xf4e780cd ;	vld1.8	{d24[6]}, [r7]!
	DCD	0xf4e780ed ;	vld1.8	{d24[7]}, [r7]!
	DCD	0xf426575d ;	vld1.16	{d5}, [r6 :64]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b28109 ;	vuzp.8	d8, d9
	DCD	0xf3b2a10b ;	vuzp.8	d10, d11
	DCD	0xf3b2910b ;	vuzp.8	d9, d11
	DCD	0xf3b2810a ;	vuzp.8	d8, d10
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3882c89 ;	vmull.u8	q1, d24, d9
	DCD	0xf388cc8a ;	vmull.u8	q6, d24, d10
	DCD	0xf388ec8b ;	vmull.u8	q7, d24, d11
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d82252 ;	vrshr.u16	q9, q1, #8
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38c2424 ;	vraddhn.i16	d2, q6, q10
	DCD	0xf38e3426 ;	vraddhn.i16	d3, q7, q11
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c30c06 ;	vmull.u8	q8, d3, d6
	DCD	0xf3c32c07 ;	vmull.u8	q9, d3, d7
	DCD	0xf3c34c2e ;	vmull.u8	q10, d3, d30
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1105 ;	ldrbge	r1, [fp, r5, lsl #2]!
	DCD	0xa7fc1083 ;	ldrbge	r1, [ip, r3, lsl #1]!
	DCD	0xa7fe1008 ;	ldrbge	r1, [lr, r8]!
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d86272 ;	vrshr.u16	q11, q9, #8
	DCD	0xf3d8e274 ;	vrshr.u16	q15, q10, #8
	DCD	0xf3c004aa ;	vraddhn.i16	d16, q8, q13
	DCD	0xf3c2b4a6 ;	vraddhn.i16	d27, q9, q11
	DCD	0xf3c4a4ae ;	vraddhn.i16	d26, q10, q15
	DCD	0xf3420030 ;	vqadd.u8	d16, d2, d16
	DCD	0xf340207a ;	vqadd.u8	q9, q0, q13
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3120002 ;	tst	r2, #2
	DCD	0x0a000000 ;	beq	2c40 <pixman_composite_over_8888_8_0565_asm_neon+0x198>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000001 ;	beq	2c50 <pixman_composite_over_8888_8_0565_asm_neon+0x1a8>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	2c5c <pixman_composite_over_8888_8_0565_asm_neon+0x1b4>
	DCD	0xf442d75d ;	vst1.16	{d29}, [r2 :64]!
	DCD	0xf4264a6d ;	vld1.16	{d4-d5}, [r6 :128]!
	DCD	0xf424800d ;	vld4.8	{d8-d11}, [r4]!
	DCD	0xf467870d ;	vld1.8	{d24}, [r7]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3882c89 ;	vmull.u8	q1, d24, d9
	DCD	0xf388cc8a ;	vmull.u8	q6, d24, d10
	DCD	0xf388ec8b ;	vmull.u8	q7, d24, d11
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d82252 ;	vrshr.u16	q9, q1, #8
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38c2424 ;	vraddhn.i16	d2, q6, q10
	DCD	0xf38e3426 ;	vraddhn.i16	d3, q7, q11
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c30c06 ;	vmull.u8	q8, d3, d6
	DCD	0xf3c32c07 ;	vmull.u8	q9, d3, d7
	DCD	0xf3c34c2e ;	vmull.u8	q10, d3, d30
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1105 ;	ldrbge	r1, [fp, r5, lsl #2]!
	DCD	0xa7fc1083 ;	ldrbge	r1, [ip, r3, lsl #1]!
	DCD	0xa7fe1008 ;	ldrbge	r1, [lr, r8]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba000036 ;	blt	2ddc <pixman_composite_over_8888_8_0565_asm_neon+0x334>
	DCD	0xf4264a6d ;	vld1.16	{d4-d5}, [r6 :128]!
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf467870d ;	vld1.8	{d24}, [r7]!
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf424800d ;	vld4.8	{d8-d11}, [r4]!
	DCD	0xf388cc8a ;	vmull.u8	q6, d24, d10
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d86272 ;	vrshr.u16	q11, q9, #8
	DCD	0xf3d8e274 ;	vrshr.u16	q15, q10, #8
	DCD	0xf3c004aa ;	vraddhn.i16	d16, q8, q13
	DCD	0xf3c2b4a6 ;	vraddhn.i16	d27, q9, q11
	DCD	0xf3c4a4ae ;	vraddhn.i16	d26, q10, q15
	DCD	0xf3420030 ;	vqadd.u8	d16, d2, d16
	DCD	0xf3882c89 ;	vmull.u8	q1, d24, d9
	DCD	0xf340207a ;	vqadd.u8	q9, q0, q13
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf388ec8b ;	vmull.u8	q7, d24, d11
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1105 ;	ldrbge	r1, [fp, r5, lsl #2]!
	DCD	0xa7fc1083 ;	ldrbge	r1, [ip, r3, lsl #1]!
	DCD	0xa7fe1008 ;	ldrbge	r1, [lr, r8]!
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d82252 ;	vrshr.u16	q9, q1, #8
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38c2424 ;	vraddhn.i16	d2, q6, q10
	DCD	0xf38e3426 ;	vraddhn.i16	d3, q7, q11
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf442ca6d ;	vst1.16	{d28-d29}, [r2 :128]!
	DCD	0xf3c30c06 ;	vmull.u8	q8, d3, d6
	DCD	0xf3c32c07 ;	vmull.u8	q9, d3, d7
	DCD	0xf3c34c2e ;	vmull.u8	q10, d3, d30
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffc8 ;	bge	2d00 <pixman_composite_over_8888_8_0565_asm_neon+0x258>
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d86272 ;	vrshr.u16	q11, q9, #8
	DCD	0xf3d8e274 ;	vrshr.u16	q15, q10, #8
	DCD	0xf3c004aa ;	vraddhn.i16	d16, q8, q13
	DCD	0xf3c2b4a6 ;	vraddhn.i16	d27, q9, q11
	DCD	0xf3c4a4ae ;	vraddhn.i16	d26, q10, q15
	DCD	0xf3420030 ;	vqadd.u8	d16, d2, d16
	DCD	0xf340207a ;	vqadd.u8	q9, q0, q13
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xf442ca6d ;	vst1.16	{d28-d29}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000054 ;	beq	2f70 <pixman_composite_over_8888_8_0565_asm_neon+0x4c8>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000006 ;	beq	2e40 <pixman_composite_over_8888_8_0565_asm_neon+0x398>
	DCD	0xf424aa8d ;	vld1.32	{d10-d11}, [r4]!
	DCD	0xf4e7808d ;	vld1.8	{d24[4]}, [r7]!
	DCD	0xf4e780ad ;	vld1.8	{d24[5]}, [r7]!
	DCD	0xf4e780cd ;	vld1.8	{d24[6]}, [r7]!
	DCD	0xf4e780ed ;	vld1.8	{d24[7]}, [r7]!
	DCD	0xf426575d ;	vld1.16	{d5}, [r6 :64]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000005 ;	beq	2e60 <pixman_composite_over_8888_8_0565_asm_neon+0x3b8>
	DCD	0xf424978d ;	vld1.32	{d9}, [r4]!
	DCD	0xf4e7804d ;	vld1.8	{d24[2]}, [r7]!
	DCD	0xf4e7806d ;	vld1.8	{d24[3]}, [r7]!
	DCD	0xf4a6448d ;	vld1.16	{d4[2]}, [r6]!
	DCD	0xf4a644cd ;	vld1.16	{d4[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000003 ;	beq	2e78 <pixman_composite_over_8888_8_0565_asm_neon+0x3d0>
	DCD	0xf4a4888d ;	vld1.32	{d8[1]}, [r4]!
	DCD	0xf4e7802d ;	vld1.8	{d24[1]}, [r7]!
	DCD	0xf4a6444d ;	vld1.16	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf3b28109 ;	vuzp.8	d8, d9
	DCD	0xf3b2a10b ;	vuzp.8	d10, d11
	DCD	0xf3b2910b ;	vuzp.8	d9, d11
	DCD	0xf3b2810a ;	vuzp.8	d8, d10
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3882c89 ;	vmull.u8	q1, d24, d9
	DCD	0xf388cc8a ;	vmull.u8	q6, d24, d10
	DCD	0xf388ec8b ;	vmull.u8	q7, d24, d11
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d82252 ;	vrshr.u16	q9, q1, #8
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38c2424 ;	vraddhn.i16	d2, q6, q10
	DCD	0xf38e3426 ;	vraddhn.i16	d3, q7, q11
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c30c06 ;	vmull.u8	q8, d3, d6
	DCD	0xf3c32c07 ;	vmull.u8	q9, d3, d7
	DCD	0xf3c34c2e ;	vmull.u8	q10, d3, d30
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1105 ;	ldrbge	r1, [fp, r5, lsl #2]!
	DCD	0xa7fc1083 ;	ldrbge	r1, [ip, r3, lsl #1]!
	DCD	0xa7fe1008 ;	ldrbge	r1, [lr, r8]!
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d86272 ;	vrshr.u16	q11, q9, #8
	DCD	0xf3d8e274 ;	vrshr.u16	q15, q10, #8
	DCD	0xf3c004aa ;	vraddhn.i16	d16, q8, q13
	DCD	0xf3c2b4a6 ;	vraddhn.i16	d27, q9, q11
	DCD	0xf3c4a4ae ;	vraddhn.i16	d26, q10, q15
	DCD	0xf3420030 ;	vqadd.u8	d16, d2, d16
	DCD	0xf340207a ;	vqadd.u8	q9, q0, q13
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	2f54 <pixman_composite_over_8888_8_0565_asm_neon+0x4ac>
	DCD	0xf442d75d ;	vst1.16	{d29}, [r2 :64]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	2f64 <pixman_composite_over_8888_8_0565_asm_neon+0x4bc>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	2f70 <pixman_composite_over_8888_8_0565_asm_neon+0x4c8>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe1cd00d0 ;	ldrd	r0, [sp]
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0877008 ;	add	r7, r7, r8
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe0477000 ;	sub	r7, r7, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe58d1004 ;	str	r1, [sp, #4]
	DCD	0xaafffed5 ;	bge	2af4 <pixman_composite_over_8888_8_0565_asm_neon+0x4c>
	DCD	0xe8bd0003 ;	pop	{r0, r1}
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000026 ;	beq	304c <pixman_composite_over_8888_8_0565_asm_neon+0x5a4>
	DCD	0xf4264a4d ;	vld1.16	{d4-d5}, [r6]!
	DCD	0xf424800d ;	vld4.8	{d8-d11}, [r4]!
	DCD	0xf467870d ;	vld1.8	{d24}, [r7]!
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3882c89 ;	vmull.u8	q1, d24, d9
	DCD	0xf388cc8a ;	vmull.u8	q6, d24, d10
	DCD	0xf388ec8b ;	vmull.u8	q7, d24, d11
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d82252 ;	vrshr.u16	q9, q1, #8
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38c2424 ;	vraddhn.i16	d2, q6, q10
	DCD	0xf38e3426 ;	vraddhn.i16	d3, q7, q11
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c30c06 ;	vmull.u8	q8, d3, d6
	DCD	0xf3c32c07 ;	vmull.u8	q9, d3, d7
	DCD	0xf3c34c2e ;	vmull.u8	q10, d3, d30
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d86272 ;	vrshr.u16	q11, q9, #8
	DCD	0xf3d8e274 ;	vrshr.u16	q15, q10, #8
	DCD	0xf3c004aa ;	vraddhn.i16	d16, q8, q13
	DCD	0xf3c2b4a6 ;	vraddhn.i16	d27, q9, q11
	DCD	0xf3c4a4ae ;	vraddhn.i16	d26, q10, q15
	DCD	0xf3420030 ;	vqadd.u8	d16, d2, d16
	DCD	0xf340207a ;	vqadd.u8	q9, q0, q13
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xf442ca4d ;	vst1.16	{d28-d29}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000044 ;	beq	3168 <pixman_composite_over_8888_8_0565_asm_neon+0x6c0>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000005 ;	beq	3074 <pixman_composite_over_8888_8_0565_asm_neon+0x5cc>
	DCD	0xf424aa8d ;	vld1.32	{d10-d11}, [r4]!
	DCD	0xf4e7808d ;	vld1.8	{d24[4]}, [r7]!
	DCD	0xf4e780ad ;	vld1.8	{d24[5]}, [r7]!
	DCD	0xf4e780cd ;	vld1.8	{d24[6]}, [r7]!
	DCD	0xf4e780ed ;	vld1.8	{d24[7]}, [r7]!
	DCD	0xf426574d ;	vld1.16	{d5}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000004 ;	beq	3090 <pixman_composite_over_8888_8_0565_asm_neon+0x5e8>
	DCD	0xf424978d ;	vld1.32	{d9}, [r4]!
	DCD	0xf4e7804d ;	vld1.8	{d24[2]}, [r7]!
	DCD	0xf4e7806d ;	vld1.8	{d24[3]}, [r7]!
	DCD	0xf4a6448d ;	vld1.16	{d4[2]}, [r6]!
	DCD	0xf4a644cd ;	vld1.16	{d4[3]}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	30a4 <pixman_composite_over_8888_8_0565_asm_neon+0x5fc>
	DCD	0xf4a4888d ;	vld1.32	{d8[1]}, [r4]!
	DCD	0xf4e7802d ;	vld1.8	{d24[1]}, [r7]!
	DCD	0xf4a6444d ;	vld1.16	{d4[1]}, [r6]!
	DCD	0xf3b28109 ;	vuzp.8	d8, d9
	DCD	0xf3b2a10b ;	vuzp.8	d10, d11
	DCD	0xf3b2910b ;	vuzp.8	d9, d11
	DCD	0xf3b2810a ;	vuzp.8	d8, d10
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3882c89 ;	vmull.u8	q1, d24, d9
	DCD	0xf388cc8a ;	vmull.u8	q6, d24, d10
	DCD	0xf388ec8b ;	vmull.u8	q7, d24, d11
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d82252 ;	vrshr.u16	q9, q1, #8
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38c2424 ;	vraddhn.i16	d2, q6, q10
	DCD	0xf38e3426 ;	vraddhn.i16	d3, q7, q11
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c30c06 ;	vmull.u8	q8, d3, d6
	DCD	0xf3c32c07 ;	vmull.u8	q9, d3, d7
	DCD	0xf3c34c2e ;	vmull.u8	q10, d3, d30
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d86272 ;	vrshr.u16	q11, q9, #8
	DCD	0xf3d8e274 ;	vrshr.u16	q15, q10, #8
	DCD	0xf3c004aa ;	vraddhn.i16	d16, q8, q13
	DCD	0xf3c2b4a6 ;	vraddhn.i16	d27, q9, q11
	DCD	0xf3c4a4ae ;	vraddhn.i16	d26, q10, q15
	DCD	0xf3420030 ;	vqadd.u8	d16, d2, d16
	DCD	0xf340207a ;	vqadd.u8	q9, q0, q13
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	314c <pixman_composite_over_8888_8_0565_asm_neon+0x6a4>
	DCD	0xf442d74d ;	vst1.16	{d29}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	315c <pixman_composite_over_8888_8_0565_asm_neon+0x6b4>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	3168 <pixman_composite_over_8888_8_0565_asm_neon+0x6c0>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe1cd00d0 ;	ldrd	r0, [sp]
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0877008 ;	add	r7, r7, r8
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe0477000 ;	sub	r7, r7, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe58d1004 ;	str	r1, [sp, #4]
	DCD	0xaaffff84 ;	bge	2fa8 <pixman_composite_over_8888_8_0565_asm_neon+0x500>
	DCD	0xe8bd0003 ;	pop	{r0, r1}
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_over_8888_8_0565_asm_neon|

|pixman_composite_over_n_8_0565_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d7030 ;	ldr	r7, [sp, #48]	; 0x30
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d8034 ;	ldr	r8, [sp, #52]	; 0x34
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xe28d5028 ;	add	r5, sp, #40	; 0x28
	DCD	0xed2d8b10 ;	vpush	{d8-d15}
	DCD	0xf4a5b80f ;	vld1.32	{d11[0]}, [r5]
	DCD	0xf3b18c0b ;	vdup.8	d8, d11[0]
	DCD	0xf3b39c0b ;	vdup.8	d9, d11[1]
	DCD	0xf3b5ac0b ;	vdup.8	d10, d11[2]
	DCD	0xf3b7bc0b ;	vdup.8	d11, d11[3]
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a04000 ;	mov	r4, r0
	DCD	0xba00017e ;	blt	37ec <pixman_composite_over_n_8_0565_asm_neon+0x64c>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba00010c ;	blt	362c <pixman_composite_over_n_8_0565_asm_neon+0x48c>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a00004d ;	beq	3338 <pixman_composite_over_n_8_0565_asm_neon+0x198>
	DCD	0xe3160002 ;	tst	r6, #2
	DCD	0x0a000003 ;	beq	3218 <pixman_composite_over_n_8_0565_asm_neon+0x78>
	DCD	0xf4e7802d ;	vld1.8	{d24[1]}, [r7]!
	DCD	0xf4a6444d ;	vld1.16	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000005 ;	beq	3238 <pixman_composite_over_n_8_0565_asm_neon+0x98>
	DCD	0xf4e7804d ;	vld1.8	{d24[2]}, [r7]!
	DCD	0xf4e7806d ;	vld1.8	{d24[3]}, [r7]!
	DCD	0xf4a6448d ;	vld1.16	{d4[2]}, [r6]!
	DCD	0xf4a644cd ;	vld1.16	{d4[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000006 ;	beq	325c <pixman_composite_over_n_8_0565_asm_neon+0xbc>
	DCD	0xf4e7808d ;	vld1.8	{d24[4]}, [r7]!
	DCD	0xf4e780ad ;	vld1.8	{d24[5]}, [r7]!
	DCD	0xf4e780cd ;	vld1.8	{d24[6]}, [r7]!
	DCD	0xf4e780ed ;	vld1.8	{d24[7]}, [r7]!
	DCD	0xf426575d ;	vld1.16	{d5}, [r6 :64]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3882c89 ;	vmull.u8	q1, d24, d9
	DCD	0xf388cc8a ;	vmull.u8	q6, d24, d10
	DCD	0xf388ec8b ;	vmull.u8	q7, d24, d11
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d82252 ;	vrshr.u16	q9, q1, #8
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38c2424 ;	vraddhn.i16	d2, q6, q10
	DCD	0xf38e3426 ;	vraddhn.i16	d3, q7, q11
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c30c06 ;	vmull.u8	q8, d3, d6
	DCD	0xf3c32c07 ;	vmull.u8	q9, d3, d7
	DCD	0xf3c34c2e ;	vmull.u8	q10, d3, d30
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc5083 ;	ldrbge	r5, [ip, r3, lsl #1]!
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d86272 ;	vrshr.u16	q11, q9, #8
	DCD	0xf3d8e274 ;	vrshr.u16	q15, q10, #8
	DCD	0xf3c004aa ;	vraddhn.i16	d16, q8, q13
	DCD	0xf3c2b4a6 ;	vraddhn.i16	d27, q9, q11
	DCD	0xf3c4a4ae ;	vraddhn.i16	d26, q10, q15
	DCD	0xf3420030 ;	vqadd.u8	d16, d2, d16
	DCD	0xf340207a ;	vqadd.u8	q9, q0, q13
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3120002 ;	tst	r2, #2
	DCD	0x0a000000 ;	beq	331c <pixman_composite_over_n_8_0565_asm_neon+0x17c>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000001 ;	beq	332c <pixman_composite_over_n_8_0565_asm_neon+0x18c>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	3338 <pixman_composite_over_n_8_0565_asm_neon+0x198>
	DCD	0xf442d75d ;	vst1.16	{d29}, [r2 :64]!
	DCD	0xf4264a6d ;	vld1.16	{d4-d5}, [r6 :128]!
	DCD	0xf467870d ;	vld1.8	{d24}, [r7]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3882c89 ;	vmull.u8	q1, d24, d9
	DCD	0xf388cc8a ;	vmull.u8	q6, d24, d10
	DCD	0xf388ec8b ;	vmull.u8	q7, d24, d11
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d82252 ;	vrshr.u16	q9, q1, #8
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38c2424 ;	vraddhn.i16	d2, q6, q10
	DCD	0xf38e3426 ;	vraddhn.i16	d3, q7, q11
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c30c06 ;	vmull.u8	q8, d3, d6
	DCD	0xf3c32c07 ;	vmull.u8	q9, d3, d7
	DCD	0xf3c34c2e ;	vmull.u8	q10, d3, d30
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc5083 ;	ldrbge	r5, [ip, r3, lsl #1]!
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba000032 ;	blt	3498 <pixman_composite_over_n_8_0565_asm_neon+0x2f8>
	DCD	0xf4264a6d ;	vld1.16	{d4-d5}, [r6 :128]!
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf467870d ;	vld1.8	{d24}, [r7]!
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf388cc8a ;	vmull.u8	q6, d24, d10
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d86272 ;	vrshr.u16	q11, q9, #8
	DCD	0xf3d8e274 ;	vrshr.u16	q15, q10, #8
	DCD	0xf3c004aa ;	vraddhn.i16	d16, q8, q13
	DCD	0xf3c2b4a6 ;	vraddhn.i16	d27, q9, q11
	DCD	0xf3c4a4ae ;	vraddhn.i16	d26, q10, q15
	DCD	0xf3420030 ;	vqadd.u8	d16, d2, d16
	DCD	0xf3882c89 ;	vmull.u8	q1, d24, d9
	DCD	0xf340207a ;	vqadd.u8	q9, q0, q13
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf388ec8b ;	vmull.u8	q7, d24, d11
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc5083 ;	ldrbge	r5, [ip, r3, lsl #1]!
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d82252 ;	vrshr.u16	q9, q1, #8
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38c2424 ;	vraddhn.i16	d2, q6, q10
	DCD	0xf38e3426 ;	vraddhn.i16	d3, q7, q11
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf442ca6d ;	vst1.16	{d28-d29}, [r2 :128]!
	DCD	0xf3c30c06 ;	vmull.u8	q8, d3, d6
	DCD	0xf3c32c07 ;	vmull.u8	q9, d3, d7
	DCD	0xf3c34c2e ;	vmull.u8	q10, d3, d30
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffcc ;	bge	33cc <pixman_composite_over_n_8_0565_asm_neon+0x22c>
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d86272 ;	vrshr.u16	q11, q9, #8
	DCD	0xf3d8e274 ;	vrshr.u16	q15, q10, #8
	DCD	0xf3c004aa ;	vraddhn.i16	d16, q8, q13
	DCD	0xf3c2b4a6 ;	vraddhn.i16	d27, q9, q11
	DCD	0xf3c4a4ae ;	vraddhn.i16	d26, q10, q15
	DCD	0xf3420030 ;	vqadd.u8	d16, d2, d16
	DCD	0xf340207a ;	vqadd.u8	q9, q0, q13
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xf442ca6d ;	vst1.16	{d28-d29}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00004a ;	beq	3604 <pixman_composite_over_n_8_0565_asm_neon+0x464>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000005 ;	beq	34f8 <pixman_composite_over_n_8_0565_asm_neon+0x358>
	DCD	0xf4e7808d ;	vld1.8	{d24[4]}, [r7]!
	DCD	0xf4e780ad ;	vld1.8	{d24[5]}, [r7]!
	DCD	0xf4e780cd ;	vld1.8	{d24[6]}, [r7]!
	DCD	0xf4e780ed ;	vld1.8	{d24[7]}, [r7]!
	DCD	0xf426575d ;	vld1.16	{d5}, [r6 :64]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000004 ;	beq	3514 <pixman_composite_over_n_8_0565_asm_neon+0x374>
	DCD	0xf4e7804d ;	vld1.8	{d24[2]}, [r7]!
	DCD	0xf4e7806d ;	vld1.8	{d24[3]}, [r7]!
	DCD	0xf4a6448d ;	vld1.16	{d4[2]}, [r6]!
	DCD	0xf4a644cd ;	vld1.16	{d4[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	3528 <pixman_composite_over_n_8_0565_asm_neon+0x388>
	DCD	0xf4e7802d ;	vld1.8	{d24[1]}, [r7]!
	DCD	0xf4a6444d ;	vld1.16	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3882c89 ;	vmull.u8	q1, d24, d9
	DCD	0xf388cc8a ;	vmull.u8	q6, d24, d10
	DCD	0xf388ec8b ;	vmull.u8	q7, d24, d11
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d82252 ;	vrshr.u16	q9, q1, #8
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38c2424 ;	vraddhn.i16	d2, q6, q10
	DCD	0xf38e3426 ;	vraddhn.i16	d3, q7, q11
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c30c06 ;	vmull.u8	q8, d3, d6
	DCD	0xf3c32c07 ;	vmull.u8	q9, d3, d7
	DCD	0xf3c34c2e ;	vmull.u8	q10, d3, d30
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc5083 ;	ldrbge	r5, [ip, r3, lsl #1]!
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d86272 ;	vrshr.u16	q11, q9, #8
	DCD	0xf3d8e274 ;	vrshr.u16	q15, q10, #8
	DCD	0xf3c004aa ;	vraddhn.i16	d16, q8, q13
	DCD	0xf3c2b4a6 ;	vraddhn.i16	d27, q9, q11
	DCD	0xf3c4a4ae ;	vraddhn.i16	d26, q10, q15
	DCD	0xf3420030 ;	vqadd.u8	d16, d2, d16
	DCD	0xf340207a ;	vqadd.u8	q9, q0, q13
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	35e8 <pixman_composite_over_n_8_0565_asm_neon+0x448>
	DCD	0xf442d75d ;	vst1.16	{d29}, [r2 :64]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	35f8 <pixman_composite_over_n_8_0565_asm_neon+0x458>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	3604 <pixman_composite_over_n_8_0565_asm_neon+0x464>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe1a00004 ;	mov	r0, r4
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0877008 ;	add	r7, r7, r8
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe0477000 ;	sub	r7, r7, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaafffef4 ;	bge	31f8 <pixman_composite_over_n_8_0565_asm_neon+0x58>
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000025 ;	beq	36cc <pixman_composite_over_n_8_0565_asm_neon+0x52c>
	DCD	0xf4264a4d ;	vld1.16	{d4-d5}, [r6]!
	DCD	0xf467870d ;	vld1.8	{d24}, [r7]!
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3882c89 ;	vmull.u8	q1, d24, d9
	DCD	0xf388cc8a ;	vmull.u8	q6, d24, d10
	DCD	0xf388ec8b ;	vmull.u8	q7, d24, d11
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d82252 ;	vrshr.u16	q9, q1, #8
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38c2424 ;	vraddhn.i16	d2, q6, q10
	DCD	0xf38e3426 ;	vraddhn.i16	d3, q7, q11
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c30c06 ;	vmull.u8	q8, d3, d6
	DCD	0xf3c32c07 ;	vmull.u8	q9, d3, d7
	DCD	0xf3c34c2e ;	vmull.u8	q10, d3, d30
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d86272 ;	vrshr.u16	q11, q9, #8
	DCD	0xf3d8e274 ;	vrshr.u16	q15, q10, #8
	DCD	0xf3c004aa ;	vraddhn.i16	d16, q8, q13
	DCD	0xf3c2b4a6 ;	vraddhn.i16	d27, q9, q11
	DCD	0xf3c4a4ae ;	vraddhn.i16	d26, q10, q15
	DCD	0xf3420030 ;	vqadd.u8	d16, d2, d16
	DCD	0xf340207a ;	vqadd.u8	q9, q0, q13
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xf442ca4d ;	vst1.16	{d28-d29}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00003d ;	beq	37cc <pixman_composite_over_n_8_0565_asm_neon+0x62c>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000004 ;	beq	36f0 <pixman_composite_over_n_8_0565_asm_neon+0x550>
	DCD	0xf4e7808d ;	vld1.8	{d24[4]}, [r7]!
	DCD	0xf4e780ad ;	vld1.8	{d24[5]}, [r7]!
	DCD	0xf4e780cd ;	vld1.8	{d24[6]}, [r7]!
	DCD	0xf4e780ed ;	vld1.8	{d24[7]}, [r7]!
	DCD	0xf426574d ;	vld1.16	{d5}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000003 ;	beq	3708 <pixman_composite_over_n_8_0565_asm_neon+0x568>
	DCD	0xf4e7804d ;	vld1.8	{d24[2]}, [r7]!
	DCD	0xf4e7806d ;	vld1.8	{d24[3]}, [r7]!
	DCD	0xf4a6448d ;	vld1.16	{d4[2]}, [r6]!
	DCD	0xf4a644cd ;	vld1.16	{d4[3]}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	3718 <pixman_composite_over_n_8_0565_asm_neon+0x578>
	DCD	0xf4e7802d ;	vld1.8	{d24[1]}, [r7]!
	DCD	0xf4a6444d ;	vld1.16	{d4[1]}, [r6]!
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3882c89 ;	vmull.u8	q1, d24, d9
	DCD	0xf388cc8a ;	vmull.u8	q6, d24, d10
	DCD	0xf388ec8b ;	vmull.u8	q7, d24, d11
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d82252 ;	vrshr.u16	q9, q1, #8
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38c2424 ;	vraddhn.i16	d2, q6, q10
	DCD	0xf38e3426 ;	vraddhn.i16	d3, q7, q11
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c30c06 ;	vmull.u8	q8, d3, d6
	DCD	0xf3c32c07 ;	vmull.u8	q9, d3, d7
	DCD	0xf3c34c2e ;	vmull.u8	q10, d3, d30
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d86272 ;	vrshr.u16	q11, q9, #8
	DCD	0xf3d8e274 ;	vrshr.u16	q15, q10, #8
	DCD	0xf3c004aa ;	vraddhn.i16	d16, q8, q13
	DCD	0xf3c2b4a6 ;	vraddhn.i16	d27, q9, q11
	DCD	0xf3c4a4ae ;	vraddhn.i16	d26, q10, q15
	DCD	0xf3420030 ;	vqadd.u8	d16, d2, d16
	DCD	0xf340207a ;	vqadd.u8	q9, q0, q13
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	37b0 <pixman_composite_over_n_8_0565_asm_neon+0x610>
	DCD	0xf442d74d ;	vst1.16	{d29}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	37c0 <pixman_composite_over_n_8_0565_asm_neon+0x620>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	37cc <pixman_composite_over_n_8_0565_asm_neon+0x62c>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe1a00004 ;	mov	r0, r4
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0877008 ;	add	r7, r7, r8
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe0477000 ;	sub	r7, r7, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff8f ;	bge	362c <pixman_composite_over_n_8_0565_asm_neon+0x48c>
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_over_n_8_0565_asm_neon|

|pixman_composite_over_8888_n_0565_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xe28d8030 ;	add	r8, sp, #48	; 0x30
	DCD	0xed2d8b10 ;	vpush	{d8-d15}
	DCD	0xf4e8880f ;	vld1.32	{d24[0]}, [r8]
	DCD	0xf3f78c28 ;	vdup.8	d24, d24[3]
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a07000 ;	mov	r7, r0
	DCD	0xba00017e ;	blt	3e34 <pixman_composite_over_8888_n_0565_asm_neon+0x640>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba00010c ;	blt	3c74 <pixman_composite_over_8888_n_0565_asm_neon+0x480>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a00004d ;	beq	3980 <pixman_composite_over_8888_n_0565_asm_neon+0x18c>
	DCD	0xe3160002 ;	tst	r6, #2
	DCD	0x0a000003 ;	beq	3860 <pixman_composite_over_8888_n_0565_asm_neon+0x6c>
	DCD	0xf4a4888d ;	vld1.32	{d8[1]}, [r4]!
	DCD	0xf4a6444d ;	vld1.16	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000004 ;	beq	387c <pixman_composite_over_8888_n_0565_asm_neon+0x88>
	DCD	0xf424978d ;	vld1.32	{d9}, [r4]!
	DCD	0xf4a6448d ;	vld1.16	{d4[2]}, [r6]!
	DCD	0xf4a644cd ;	vld1.16	{d4[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000003 ;	beq	3894 <pixman_composite_over_8888_n_0565_asm_neon+0xa0>
	DCD	0xf424aa8d ;	vld1.32	{d10-d11}, [r4]!
	DCD	0xf426575d ;	vld1.16	{d5}, [r6 :64]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b28109 ;	vuzp.8	d8, d9
	DCD	0xf3b2a10b ;	vuzp.8	d10, d11
	DCD	0xf3b2910b ;	vuzp.8	d9, d11
	DCD	0xf3b2810a ;	vuzp.8	d8, d10
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3882c89 ;	vmull.u8	q1, d24, d9
	DCD	0xf388cc8a ;	vmull.u8	q6, d24, d10
	DCD	0xf388ec8b ;	vmull.u8	q7, d24, d11
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d82252 ;	vrshr.u16	q9, q1, #8
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38c2424 ;	vraddhn.i16	d2, q6, q10
	DCD	0xf38e3426 ;	vraddhn.i16	d3, q7, q11
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c30c06 ;	vmull.u8	q8, d3, d6
	DCD	0xf3c32c07 ;	vmull.u8	q9, d3, d7
	DCD	0xf3c34c2e ;	vmull.u8	q10, d3, d30
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xa7fc8083 ;	ldrbge	r8, [ip, r3, lsl #1]!
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d86272 ;	vrshr.u16	q11, q9, #8
	DCD	0xf3d8e274 ;	vrshr.u16	q15, q10, #8
	DCD	0xf3c004aa ;	vraddhn.i16	d16, q8, q13
	DCD	0xf3c2b4a6 ;	vraddhn.i16	d27, q9, q11
	DCD	0xf3c4a4ae ;	vraddhn.i16	d26, q10, q15
	DCD	0xf3420030 ;	vqadd.u8	d16, d2, d16
	DCD	0xf340207a ;	vqadd.u8	q9, q0, q13
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3120002 ;	tst	r2, #2
	DCD	0x0a000000 ;	beq	3964 <pixman_composite_over_8888_n_0565_asm_neon+0x170>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000001 ;	beq	3974 <pixman_composite_over_8888_n_0565_asm_neon+0x180>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	3980 <pixman_composite_over_8888_n_0565_asm_neon+0x18c>
	DCD	0xf442d75d ;	vst1.16	{d29}, [r2 :64]!
	DCD	0xf4264a6d ;	vld1.16	{d4-d5}, [r6 :128]!
	DCD	0xf424800d ;	vld4.8	{d8-d11}, [r4]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3882c89 ;	vmull.u8	q1, d24, d9
	DCD	0xf388cc8a ;	vmull.u8	q6, d24, d10
	DCD	0xf388ec8b ;	vmull.u8	q7, d24, d11
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d82252 ;	vrshr.u16	q9, q1, #8
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38c2424 ;	vraddhn.i16	d2, q6, q10
	DCD	0xf38e3426 ;	vraddhn.i16	d3, q7, q11
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c30c06 ;	vmull.u8	q8, d3, d6
	DCD	0xf3c32c07 ;	vmull.u8	q9, d3, d7
	DCD	0xf3c34c2e ;	vmull.u8	q10, d3, d30
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xa7fc8083 ;	ldrbge	r8, [ip, r3, lsl #1]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba000032 ;	blt	3ae0 <pixman_composite_over_8888_n_0565_asm_neon+0x2ec>
	DCD	0xf4264a6d ;	vld1.16	{d4-d5}, [r6 :128]!
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf424800d ;	vld4.8	{d8-d11}, [r4]!
	DCD	0xf388cc8a ;	vmull.u8	q6, d24, d10
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d86272 ;	vrshr.u16	q11, q9, #8
	DCD	0xf3d8e274 ;	vrshr.u16	q15, q10, #8
	DCD	0xf3c004aa ;	vraddhn.i16	d16, q8, q13
	DCD	0xf3c2b4a6 ;	vraddhn.i16	d27, q9, q11
	DCD	0xf3c4a4ae ;	vraddhn.i16	d26, q10, q15
	DCD	0xf3420030 ;	vqadd.u8	d16, d2, d16
	DCD	0xf3882c89 ;	vmull.u8	q1, d24, d9
	DCD	0xf340207a ;	vqadd.u8	q9, q0, q13
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf388ec8b ;	vmull.u8	q7, d24, d11
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xa7fc8083 ;	ldrbge	r8, [ip, r3, lsl #1]!
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d82252 ;	vrshr.u16	q9, q1, #8
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38c2424 ;	vraddhn.i16	d2, q6, q10
	DCD	0xf38e3426 ;	vraddhn.i16	d3, q7, q11
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf442ca6d ;	vst1.16	{d28-d29}, [r2 :128]!
	DCD	0xf3c30c06 ;	vmull.u8	q8, d3, d6
	DCD	0xf3c32c07 ;	vmull.u8	q9, d3, d7
	DCD	0xf3c34c2e ;	vmull.u8	q10, d3, d30
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffcc ;	bge	3a14 <pixman_composite_over_8888_n_0565_asm_neon+0x220>
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d86272 ;	vrshr.u16	q11, q9, #8
	DCD	0xf3d8e274 ;	vrshr.u16	q15, q10, #8
	DCD	0xf3c004aa ;	vraddhn.i16	d16, q8, q13
	DCD	0xf3c2b4a6 ;	vraddhn.i16	d27, q9, q11
	DCD	0xf3c4a4ae ;	vraddhn.i16	d26, q10, q15
	DCD	0xf3420030 ;	vqadd.u8	d16, d2, d16
	DCD	0xf340207a ;	vqadd.u8	q9, q0, q13
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xf442ca6d ;	vst1.16	{d28-d29}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00004a ;	beq	3c4c <pixman_composite_over_8888_n_0565_asm_neon+0x458>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000002 ;	beq	3b34 <pixman_composite_over_8888_n_0565_asm_neon+0x340>
	DCD	0xf424aa8d ;	vld1.32	{d10-d11}, [r4]!
	DCD	0xf426575d ;	vld1.16	{d5}, [r6 :64]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000003 ;	beq	3b4c <pixman_composite_over_8888_n_0565_asm_neon+0x358>
	DCD	0xf424978d ;	vld1.32	{d9}, [r4]!
	DCD	0xf4a6448d ;	vld1.16	{d4[2]}, [r6]!
	DCD	0xf4a644cd ;	vld1.16	{d4[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	3b60 <pixman_composite_over_8888_n_0565_asm_neon+0x36c>
	DCD	0xf4a4888d ;	vld1.32	{d8[1]}, [r4]!
	DCD	0xf4a6444d ;	vld1.16	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf3b28109 ;	vuzp.8	d8, d9
	DCD	0xf3b2a10b ;	vuzp.8	d10, d11
	DCD	0xf3b2910b ;	vuzp.8	d9, d11
	DCD	0xf3b2810a ;	vuzp.8	d8, d10
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3882c89 ;	vmull.u8	q1, d24, d9
	DCD	0xf388cc8a ;	vmull.u8	q6, d24, d10
	DCD	0xf388ec8b ;	vmull.u8	q7, d24, d11
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d82252 ;	vrshr.u16	q9, q1, #8
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38c2424 ;	vraddhn.i16	d2, q6, q10
	DCD	0xf38e3426 ;	vraddhn.i16	d3, q7, q11
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c30c06 ;	vmull.u8	q8, d3, d6
	DCD	0xf3c32c07 ;	vmull.u8	q9, d3, d7
	DCD	0xf3c34c2e ;	vmull.u8	q10, d3, d30
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xa7fc8083 ;	ldrbge	r8, [ip, r3, lsl #1]!
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d86272 ;	vrshr.u16	q11, q9, #8
	DCD	0xf3d8e274 ;	vrshr.u16	q15, q10, #8
	DCD	0xf3c004aa ;	vraddhn.i16	d16, q8, q13
	DCD	0xf3c2b4a6 ;	vraddhn.i16	d27, q9, q11
	DCD	0xf3c4a4ae ;	vraddhn.i16	d26, q10, q15
	DCD	0xf3420030 ;	vqadd.u8	d16, d2, d16
	DCD	0xf340207a ;	vqadd.u8	q9, q0, q13
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	3c30 <pixman_composite_over_8888_n_0565_asm_neon+0x43c>
	DCD	0xf442d75d ;	vst1.16	{d29}, [r2 :64]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	3c40 <pixman_composite_over_8888_n_0565_asm_neon+0x44c>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	3c4c <pixman_composite_over_8888_n_0565_asm_neon+0x458>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaafffef4 ;	bge	3840 <pixman_composite_over_8888_n_0565_asm_neon+0x4c>
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000025 ;	beq	3d14 <pixman_composite_over_8888_n_0565_asm_neon+0x520>
	DCD	0xf4264a4d ;	vld1.16	{d4-d5}, [r6]!
	DCD	0xf424800d ;	vld4.8	{d8-d11}, [r4]!
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3882c89 ;	vmull.u8	q1, d24, d9
	DCD	0xf388cc8a ;	vmull.u8	q6, d24, d10
	DCD	0xf388ec8b ;	vmull.u8	q7, d24, d11
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d82252 ;	vrshr.u16	q9, q1, #8
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38c2424 ;	vraddhn.i16	d2, q6, q10
	DCD	0xf38e3426 ;	vraddhn.i16	d3, q7, q11
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c30c06 ;	vmull.u8	q8, d3, d6
	DCD	0xf3c32c07 ;	vmull.u8	q9, d3, d7
	DCD	0xf3c34c2e ;	vmull.u8	q10, d3, d30
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d86272 ;	vrshr.u16	q11, q9, #8
	DCD	0xf3d8e274 ;	vrshr.u16	q15, q10, #8
	DCD	0xf3c004aa ;	vraddhn.i16	d16, q8, q13
	DCD	0xf3c2b4a6 ;	vraddhn.i16	d27, q9, q11
	DCD	0xf3c4a4ae ;	vraddhn.i16	d26, q10, q15
	DCD	0xf3420030 ;	vqadd.u8	d16, d2, d16
	DCD	0xf340207a ;	vqadd.u8	q9, q0, q13
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xf442ca4d ;	vst1.16	{d28-d29}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00003d ;	beq	3e14 <pixman_composite_over_8888_n_0565_asm_neon+0x620>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000001 ;	beq	3d2c <pixman_composite_over_8888_n_0565_asm_neon+0x538>
	DCD	0xf424aa8d ;	vld1.32	{d10-d11}, [r4]!
	DCD	0xf426574d ;	vld1.16	{d5}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000002 ;	beq	3d40 <pixman_composite_over_8888_n_0565_asm_neon+0x54c>
	DCD	0xf424978d ;	vld1.32	{d9}, [r4]!
	DCD	0xf4a6448d ;	vld1.16	{d4[2]}, [r6]!
	DCD	0xf4a644cd ;	vld1.16	{d4[3]}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	3d50 <pixman_composite_over_8888_n_0565_asm_neon+0x55c>
	DCD	0xf4a4888d ;	vld1.32	{d8[1]}, [r4]!
	DCD	0xf4a6444d ;	vld1.16	{d4[1]}, [r6]!
	DCD	0xf3b28109 ;	vuzp.8	d8, d9
	DCD	0xf3b2a10b ;	vuzp.8	d10, d11
	DCD	0xf3b2910b ;	vuzp.8	d9, d11
	DCD	0xf3b2810a ;	vuzp.8	d8, d10
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3882c89 ;	vmull.u8	q1, d24, d9
	DCD	0xf388cc8a ;	vmull.u8	q6, d24, d10
	DCD	0xf388ec8b ;	vmull.u8	q7, d24, d11
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d82252 ;	vrshr.u16	q9, q1, #8
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38c2424 ;	vraddhn.i16	d2, q6, q10
	DCD	0xf38e3426 ;	vraddhn.i16	d3, q7, q11
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c30c06 ;	vmull.u8	q8, d3, d6
	DCD	0xf3c32c07 ;	vmull.u8	q9, d3, d7
	DCD	0xf3c34c2e ;	vmull.u8	q10, d3, d30
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d86272 ;	vrshr.u16	q11, q9, #8
	DCD	0xf3d8e274 ;	vrshr.u16	q15, q10, #8
	DCD	0xf3c004aa ;	vraddhn.i16	d16, q8, q13
	DCD	0xf3c2b4a6 ;	vraddhn.i16	d27, q9, q11
	DCD	0xf3c4a4ae ;	vraddhn.i16	d26, q10, q15
	DCD	0xf3420030 ;	vqadd.u8	d16, d2, d16
	DCD	0xf340207a ;	vqadd.u8	q9, q0, q13
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	3df8 <pixman_composite_over_8888_n_0565_asm_neon+0x604>
	DCD	0xf442d74d ;	vst1.16	{d29}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	3e08 <pixman_composite_over_8888_n_0565_asm_neon+0x614>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	3e14 <pixman_composite_over_8888_n_0565_asm_neon+0x620>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff8f ;	bge	3c74 <pixman_composite_over_8888_n_0565_asm_neon+0x480>
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_over_8888_n_0565_asm_neon|

|pixman_composite_src_0565_0565_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe2499006 ;	sub	r9, r9, #6
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a07000 ;	mov	r7, r0
	DCD	0xba0000a0 ;	blt	40f4 <pixman_composite_src_0565_0565_asm_neon+0x2b8>
	DCD	0xe3500020 ;	cmp	r0, #32
	DCD	0xba000076 ;	blt	4054 <pixman_composite_src_0565_0565_asm_neon+0x218>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000029 ;	beq	3f28 <pixman_composite_src_0565_0565_asm_neon+0xec>
	DCD	0xe3160002 ;	tst	r6, #2
	DCD	0x0a000003 ;	beq	3e98 <pixman_composite_src_0565_0565_asm_neon+0x5c>
	DCD	0xf4a4044d ;	vld1.16	{d0[1]}, [r4]!
	DCD	0xe2866002 ;	add	r6, r6, #2
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000004 ;	beq	3eb4 <pixman_composite_src_0565_0565_asm_neon+0x78>
	DCD	0xf4a4048d ;	vld1.16	{d0[2]}, [r4]!
	DCD	0xf4a404cd ;	vld1.16	{d0[3]}, [r4]!
	DCD	0xe2866004 ;	add	r6, r6, #4
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000003 ;	beq	3ecc <pixman_composite_src_0565_0565_asm_neon+0x90>
	DCD	0xf424174d ;	vld1.16	{d1}, [r4]!
	DCD	0xe2866008 ;	add	r6, r6, #8
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf4242a4d ;	vld1.16	{d2-d3}, [r4]!
	DCD	0xe2866010 ;	add	r6, r6, #16
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe2400008 ;	sub	r0, r0, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa010 ;	addne	sl, sl, #16
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf08a ;	pld	[fp, sl, lsl #1]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8085 ;	ldrbge	r8, [fp, r5, lsl #1]!
	DCD	0xe3120002 ;	tst	r2, #2
	DCD	0x0a000000 ;	beq	3f08 <pixman_composite_src_0565_0565_asm_neon+0xcc>
	DCD	0xf482044d ;	vst1.16	{d0[1]}, [r2]!
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000001 ;	beq	3f18 <pixman_composite_src_0565_0565_asm_neon+0xdc>
	DCD	0xf482048d ;	vst1.16	{d0[2]}, [r2]!
	DCD	0xf48204cd ;	vst1.16	{d0[3]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	3f24 <pixman_composite_src_0565_0565_asm_neon+0xe8>
	DCD	0xf402175d ;	vst1.16	{d1}, [r2 :64]!
	DCD	0xf4022a6d ;	vst1.16	{d2-d3}, [r2 :128]!
	DCD	0xf424024d ;	vld1.16	{d0-d3}, [r4]!
	DCD	0xe28aa010 ;	add	sl, sl, #16
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa010 ;	addne	sl, sl, #16
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf08a ;	pld	[fp, sl, lsl #1]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8085 ;	ldrbge	r8, [fp, r5, lsl #1]!
	DCD	0xe2500020 ;	subs	r0, r0, #32
	DCD	0xba00000c ;	blt	3f8c <pixman_composite_src_0565_0565_asm_neon+0x150>
	DCD	0xf402026d ;	vst1.16	{d0-d3}, [r2 :128]!
	DCD	0xf424024d ;	vld1.16	{d0-d3}, [r4]!
	DCD	0xe28aa010 ;	add	sl, sl, #16
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa010 ;	addne	sl, sl, #16
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf08a ;	pld	[fp, sl, lsl #1]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8085 ;	ldrbge	r8, [fp, r5, lsl #1]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xaafffff2 ;	bge	3f58 <pixman_composite_src_0565_0565_asm_neon+0x11c>
	DCD	0xf402026d ;	vst1.16	{d0-d3}, [r2 :128]!
	DCD	0xe310000f ;	tst	r0, #15
	DCD	0x0a000025 ;	beq	4030 <pixman_composite_src_0565_0565_asm_neon+0x1f4>
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000001 ;	beq	3fa8 <pixman_composite_src_0565_0565_asm_neon+0x16c>
	DCD	0xf4242a4d ;	vld1.16	{d2-d3}, [r4]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000001 ;	beq	3fb8 <pixman_composite_src_0565_0565_asm_neon+0x17c>
	DCD	0xf424174d ;	vld1.16	{d1}, [r4]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000002 ;	beq	3fcc <pixman_composite_src_0565_0565_asm_neon+0x190>
	DCD	0xf4a4048d ;	vld1.16	{d0[2]}, [r4]!
	DCD	0xf4a404cd ;	vld1.16	{d0[3]}, [r4]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	3fdc <pixman_composite_src_0565_0565_asm_neon+0x1a0>
	DCD	0xf4a4044d ;	vld1.16	{d0[1]}, [r4]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa010 ;	addne	sl, sl, #16
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf08a ;	pld	[fp, sl, lsl #1]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8085 ;	ldrbge	r8, [fp, r5, lsl #1]!
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000000 ;	beq	4008 <pixman_composite_src_0565_0565_asm_neon+0x1cc>
	DCD	0xf4022a6d ;	vst1.16	{d2-d3}, [r2 :128]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	4014 <pixman_composite_src_0565_0565_asm_neon+0x1d8>
	DCD	0xf402175d ;	vst1.16	{d1}, [r2 :64]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	4024 <pixman_composite_src_0565_0565_asm_neon+0x1e8>
	DCD	0xf482048d ;	vst1.16	{d0[2]}, [r2]!
	DCD	0xf48204cd ;	vst1.16	{d0[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	4030 <pixman_composite_src_0565_0565_asm_neon+0x1f4>
	DCD	0xf482044d ;	vst1.16	{d0[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0844085 ;	add	r4, r4, r5, lsl #1
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe0444080 ;	sub	r4, r4, r0, lsl #1
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff89 ;	bge	3e78 <pixman_composite_src_0565_0565_asm_neon+0x3c>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000001 ;	beq	4064 <pixman_composite_src_0565_0565_asm_neon+0x228>
	DCD	0xf424024d ;	vld1.16	{d0-d3}, [r4]!
	DCD	0xf402024d ;	vst1.16	{d0-d3}, [r2]!
	DCD	0xe310000f ;	tst	r0, #15
	DCD	0x0a000019 ;	beq	40d4 <pixman_composite_src_0565_0565_asm_neon+0x298>
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000000 ;	beq	4078 <pixman_composite_src_0565_0565_asm_neon+0x23c>
	DCD	0xf4242a4d ;	vld1.16	{d2-d3}, [r4]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	4084 <pixman_composite_src_0565_0565_asm_neon+0x248>
	DCD	0xf424174d ;	vld1.16	{d1}, [r4]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	4094 <pixman_composite_src_0565_0565_asm_neon+0x258>
	DCD	0xf4a4048d ;	vld1.16	{d0[2]}, [r4]!
	DCD	0xf4a404cd ;	vld1.16	{d0[3]}, [r4]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	40a0 <pixman_composite_src_0565_0565_asm_neon+0x264>
	DCD	0xf4a4044d ;	vld1.16	{d0[1]}, [r4]!
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000000 ;	beq	40ac <pixman_composite_src_0565_0565_asm_neon+0x270>
	DCD	0xf4022a4d ;	vst1.16	{d2-d3}, [r2]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	40b8 <pixman_composite_src_0565_0565_asm_neon+0x27c>
	DCD	0xf402174d ;	vst1.16	{d1}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	40c8 <pixman_composite_src_0565_0565_asm_neon+0x28c>
	DCD	0xf482048d ;	vst1.16	{d0[2]}, [r2]!
	DCD	0xf48204cd ;	vst1.16	{d0[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	40d4 <pixman_composite_src_0565_0565_asm_neon+0x298>
	DCD	0xf482044d ;	vst1.16	{d0[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0844085 ;	add	r4, r4, r5, lsl #1
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe0444080 ;	sub	r4, r4, r0, lsl #1
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffd7 ;	bge	4054 <pixman_composite_src_0565_0565_asm_neon+0x218>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_src_0565_0565_asm_neon|

|pixman_composite_src_n_8_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe28dc028 ;	add	ip, sp, #40	; 0x28
	DCD	0xf4ac080f ;	vld1.32	{d0[0]}, [ip]
	DCD	0xf3880590 ;	vsli.64	d0, d0, #8
	DCD	0xf3900590 ;	vsli.64	d0, d0, #16
	DCD	0xf3a00590 ;	vsli.64	d0, d0, #32
	DCD	0xf2201110 ;	vorr	d1, d0, d0
	DCD	0xf2202150 ;	vorr	q1, q0, q0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a0a000 ;	mov	sl, r0
	DCD	0xba00007a ;	blt	4314 <pixman_composite_src_n_8_asm_neon+0x21c>
	DCD	0xe3500040 ;	cmp	r0, #64	; 0x40
	DCD	0xba000050 ;	blt	4274 <pixman_composite_src_n_8_asm_neon+0x17c>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000022 ;	beq	41c4 <pixman_composite_src_n_8_asm_neon+0xcc>
	DCD	0xe3160001 ;	tst	r6, #1
	DCD	0x0a000001 ;	beq	4148 <pixman_composite_src_n_8_asm_neon+0x50>
	DCD	0xe2866001 ;	add	r6, r6, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160002 ;	tst	r6, #2
	DCD	0x0a000001 ;	beq	4158 <pixman_composite_src_n_8_asm_neon+0x60>
	DCD	0xe2866002 ;	add	r6, r6, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000001 ;	beq	4168 <pixman_composite_src_n_8_asm_neon+0x70>
	DCD	0xe2866004 ;	add	r6, r6, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000001 ;	beq	4178 <pixman_composite_src_n_8_asm_neon+0x80>
	DCD	0xe2866008 ;	add	r6, r6, #8
	DCD	0xe2400008 ;	sub	r0, r0, #8
	DCD	0xe2866010 ;	add	r6, r6, #16
	DCD	0xe2400010 ;	sub	r0, r0, #16
	DCD	0xe3120001 ;	tst	r2, #1
	DCD	0x0a000000 ;	beq	418c <pixman_composite_src_n_8_asm_neon+0x94>
	DCD	0xf482002d ;	vst1.8	{d0[1]}, [r2]!
	DCD	0xe3120002 ;	tst	r2, #2
	DCD	0x0a000001 ;	beq	419c <pixman_composite_src_n_8_asm_neon+0xa4>
	DCD	0xf482004d ;	vst1.8	{d0[2]}, [r2]!
	DCD	0xf482006d ;	vst1.8	{d0[3]}, [r2]!
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000003 ;	beq	41b4 <pixman_composite_src_n_8_asm_neon+0xbc>
	DCD	0xf482008d ;	vst1.8	{d0[4]}, [r2]!
	DCD	0xf48200ad ;	vst1.8	{d0[5]}, [r2]!
	DCD	0xf48200cd ;	vst1.8	{d0[6]}, [r2]!
	DCD	0xf48200ed ;	vst1.8	{d0[7]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	41c0 <pixman_composite_src_n_8_asm_neon+0xc8>
	DCD	0xf402171d ;	vst1.8	{d1}, [r2 :64]!
	DCD	0xf4022a2d ;	vst1.8	{d2-d3}, [r2 :128]!
	DCD	0xe2500040 ;	subs	r0, r0, #64	; 0x40
	DCD	0xba000002 ;	blt	41d8 <pixman_composite_src_n_8_asm_neon+0xe0>
	DCD	0xf402022d ;	vst1.8	{d0-d3}, [r2 :128]!
	DCD	0xe2500020 ;	subs	r0, r0, #32
	DCD	0xaafffffc ;	bge	41cc <pixman_composite_src_n_8_asm_neon+0xd4>
	DCD	0xf402022d ;	vst1.8	{d0-d3}, [r2 :128]!
	DCD	0xe310001f ;	tst	r0, #31
	DCD	0x0a00001c ;	beq	4258 <pixman_composite_src_n_8_asm_neon+0x160>
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0affffff ;	beq	41ec <pixman_composite_src_n_8_asm_neon+0xf4>
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0affffff ;	beq	41f4 <pixman_composite_src_n_8_asm_neon+0xfc>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0affffff ;	beq	41fc <pixman_composite_src_n_8_asm_neon+0x104>
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0affffff ;	beq	4204 <pixman_composite_src_n_8_asm_neon+0x10c>
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0affffff ;	beq	420c <pixman_composite_src_n_8_asm_neon+0x114>
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000000 ;	beq	4218 <pixman_composite_src_n_8_asm_neon+0x120>
	DCD	0xf4022a2d ;	vst1.8	{d2-d3}, [r2 :128]!
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000000 ;	beq	4224 <pixman_composite_src_n_8_asm_neon+0x12c>
	DCD	0xf402171d ;	vst1.8	{d1}, [r2 :64]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000003 ;	beq	423c <pixman_composite_src_n_8_asm_neon+0x144>
	DCD	0xf482008d ;	vst1.8	{d0[4]}, [r2]!
	DCD	0xf48200ad ;	vst1.8	{d0[5]}, [r2]!
	DCD	0xf48200cd ;	vst1.8	{d0[6]}, [r2]!
	DCD	0xf48200ed ;	vst1.8	{d0[7]}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	424c <pixman_composite_src_n_8_asm_neon+0x154>
	DCD	0xf482004d ;	vst1.8	{d0[2]}, [r2]!
	DCD	0xf482006d ;	vst1.8	{d0[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	4258 <pixman_composite_src_n_8_asm_neon+0x160>
	DCD	0xf482002d ;	vst1.8	{d0[1]}, [r2]!
	DCD	0xe1a0000a ;	mov	r0, sl
	DCD	0xe0822003 ;	add	r2, r2, r3
	DCD	0xe0422000 ;	sub	r2, r2, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffaf ;	bge	4130 <pixman_composite_src_n_8_asm_neon+0x38>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100020 ;	tst	r0, #32
	DCD	0x0a000000 ;	beq	4280 <pixman_composite_src_n_8_asm_neon+0x188>
	DCD	0xf402020d ;	vst1.8	{d0-d3}, [r2]!
	DCD	0xe310001f ;	tst	r0, #31
	DCD	0x0a00001c ;	beq	42fc <pixman_composite_src_n_8_asm_neon+0x204>
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0affffff ;	beq	4290 <pixman_composite_src_n_8_asm_neon+0x198>
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0affffff ;	beq	4298 <pixman_composite_src_n_8_asm_neon+0x1a0>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0affffff ;	beq	42a0 <pixman_composite_src_n_8_asm_neon+0x1a8>
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0affffff ;	beq	42a8 <pixman_composite_src_n_8_asm_neon+0x1b0>
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0affffff ;	beq	42b0 <pixman_composite_src_n_8_asm_neon+0x1b8>
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000000 ;	beq	42bc <pixman_composite_src_n_8_asm_neon+0x1c4>
	DCD	0xf4022a0d ;	vst1.8	{d2-d3}, [r2]!
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000000 ;	beq	42c8 <pixman_composite_src_n_8_asm_neon+0x1d0>
	DCD	0xf402170d ;	vst1.8	{d1}, [r2]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000003 ;	beq	42e0 <pixman_composite_src_n_8_asm_neon+0x1e8>
	DCD	0xf482008d ;	vst1.8	{d0[4]}, [r2]!
	DCD	0xf48200ad ;	vst1.8	{d0[5]}, [r2]!
	DCD	0xf48200cd ;	vst1.8	{d0[6]}, [r2]!
	DCD	0xf48200ed ;	vst1.8	{d0[7]}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	42f0 <pixman_composite_src_n_8_asm_neon+0x1f8>
	DCD	0xf482004d ;	vst1.8	{d0[2]}, [r2]!
	DCD	0xf482006d ;	vst1.8	{d0[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	42fc <pixman_composite_src_n_8_asm_neon+0x204>
	DCD	0xf482002d ;	vst1.8	{d0[1]}, [r2]!
	DCD	0xe1a0000a ;	mov	r0, sl
	DCD	0xe0822003 ;	add	r2, r2, r3
	DCD	0xe0422000 ;	sub	r2, r2, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffd7 ;	bge	4274 <pixman_composite_src_n_8_asm_neon+0x17c>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_src_n_8_asm_neon|

|pixman_composite_src_n_0565_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe28dc028 ;	add	ip, sp, #40	; 0x28
	DCD	0xf4ac080f ;	vld1.32	{d0[0]}, [ip]
	DCD	0xf3900590 ;	vsli.64	d0, d0, #16
	DCD	0xf3a00590 ;	vsli.64	d0, d0, #32
	DCD	0xf2201110 ;	vorr	d1, d0, d0
	DCD	0xf2202150 ;	vorr	q1, q0, q0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a0a000 ;	mov	sl, r0
	DCD	0xba000060 ;	blt	44c8 <pixman_composite_src_n_0565_asm_neon+0x1b0>
	DCD	0xe3500020 ;	cmp	r0, #32
	DCD	0xba00003e ;	blt	4448 <pixman_composite_src_n_0565_asm_neon+0x130>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000018 ;	beq	43b8 <pixman_composite_src_n_0565_asm_neon+0xa0>
	DCD	0xe3160002 ;	tst	r6, #2
	DCD	0x0a000001 ;	beq	4364 <pixman_composite_src_n_0565_asm_neon+0x4c>
	DCD	0xe2866002 ;	add	r6, r6, #2
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000001 ;	beq	4374 <pixman_composite_src_n_0565_asm_neon+0x5c>
	DCD	0xe2866004 ;	add	r6, r6, #4
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000001 ;	beq	4384 <pixman_composite_src_n_0565_asm_neon+0x6c>
	DCD	0xe2866008 ;	add	r6, r6, #8
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xe2866010 ;	add	r6, r6, #16
	DCD	0xe2400008 ;	sub	r0, r0, #8
	DCD	0xe3120002 ;	tst	r2, #2
	DCD	0x0a000000 ;	beq	4398 <pixman_composite_src_n_0565_asm_neon+0x80>
	DCD	0xf482044d ;	vst1.16	{d0[1]}, [r2]!
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000001 ;	beq	43a8 <pixman_composite_src_n_0565_asm_neon+0x90>
	DCD	0xf482048d ;	vst1.16	{d0[2]}, [r2]!
	DCD	0xf48204cd ;	vst1.16	{d0[3]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	43b4 <pixman_composite_src_n_0565_asm_neon+0x9c>
	DCD	0xf402175d ;	vst1.16	{d1}, [r2 :64]!
	DCD	0xf4022a6d ;	vst1.16	{d2-d3}, [r2 :128]!
	DCD	0xe2500020 ;	subs	r0, r0, #32
	DCD	0xba000002 ;	blt	43cc <pixman_composite_src_n_0565_asm_neon+0xb4>
	DCD	0xf402026d ;	vst1.16	{d0-d3}, [r2 :128]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xaafffffc ;	bge	43c0 <pixman_composite_src_n_0565_asm_neon+0xa8>
	DCD	0xf402026d ;	vst1.16	{d0-d3}, [r2 :128]!
	DCD	0xe310000f ;	tst	r0, #15
	DCD	0x0a000014 ;	beq	442c <pixman_composite_src_n_0565_asm_neon+0x114>
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0affffff ;	beq	43e0 <pixman_composite_src_n_0565_asm_neon+0xc8>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0affffff ;	beq	43e8 <pixman_composite_src_n_0565_asm_neon+0xd0>
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0affffff ;	beq	43f0 <pixman_composite_src_n_0565_asm_neon+0xd8>
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0affffff ;	beq	43f8 <pixman_composite_src_n_0565_asm_neon+0xe0>
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000000 ;	beq	4404 <pixman_composite_src_n_0565_asm_neon+0xec>
	DCD	0xf4022a6d ;	vst1.16	{d2-d3}, [r2 :128]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	4410 <pixman_composite_src_n_0565_asm_neon+0xf8>
	DCD	0xf402175d ;	vst1.16	{d1}, [r2 :64]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	4420 <pixman_composite_src_n_0565_asm_neon+0x108>
	DCD	0xf482048d ;	vst1.16	{d0[2]}, [r2]!
	DCD	0xf48204cd ;	vst1.16	{d0[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	442c <pixman_composite_src_n_0565_asm_neon+0x114>
	DCD	0xf482044d ;	vst1.16	{d0[1]}, [r2]!
	DCD	0xe1a0000a ;	mov	r0, sl
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffc1 ;	bge	434c <pixman_composite_src_n_0565_asm_neon+0x34>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000000 ;	beq	4454 <pixman_composite_src_n_0565_asm_neon+0x13c>
	DCD	0xf402024d ;	vst1.16	{d0-d3}, [r2]!
	DCD	0xe310000f ;	tst	r0, #15
	DCD	0x0a000014 ;	beq	44b0 <pixman_composite_src_n_0565_asm_neon+0x198>
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0affffff ;	beq	4464 <pixman_composite_src_n_0565_asm_neon+0x14c>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0affffff ;	beq	446c <pixman_composite_src_n_0565_asm_neon+0x154>
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0affffff ;	beq	4474 <pixman_composite_src_n_0565_asm_neon+0x15c>
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0affffff ;	beq	447c <pixman_composite_src_n_0565_asm_neon+0x164>
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000000 ;	beq	4488 <pixman_composite_src_n_0565_asm_neon+0x170>
	DCD	0xf4022a4d ;	vst1.16	{d2-d3}, [r2]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	4494 <pixman_composite_src_n_0565_asm_neon+0x17c>
	DCD	0xf402174d ;	vst1.16	{d1}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	44a4 <pixman_composite_src_n_0565_asm_neon+0x18c>
	DCD	0xf482048d ;	vst1.16	{d0[2]}, [r2]!
	DCD	0xf48204cd ;	vst1.16	{d0[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	44b0 <pixman_composite_src_n_0565_asm_neon+0x198>
	DCD	0xf482044d ;	vst1.16	{d0[1]}, [r2]!
	DCD	0xe1a0000a ;	mov	r0, sl
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffdf ;	bge	4448 <pixman_composite_src_n_0565_asm_neon+0x130>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_src_n_0565_asm_neon|

|pixman_composite_src_n_8888_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe28dc028 ;	add	ip, sp, #40	; 0x28
	DCD	0xf4ac080f ;	vld1.32	{d0[0]}, [ip]
	DCD	0xf3a00590 ;	vsli.64	d0, d0, #32
	DCD	0xf2201110 ;	vorr	d1, d0, d0
	DCD	0xf2202150 ;	vorr	q1, q0, q0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a0a000 ;	mov	sl, r0
	DCD	0xba00004c ;	blt	4628 <pixman_composite_src_n_8888_asm_neon+0x15c>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba000030 ;	blt	45c0 <pixman_composite_src_n_8888_asm_neon+0xf4>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000010 ;	beq	4548 <pixman_composite_src_n_8888_asm_neon+0x7c>
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000001 ;	beq	4514 <pixman_composite_src_n_8888_asm_neon+0x48>
	DCD	0xe2866004 ;	add	r6, r6, #4
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000001 ;	beq	4524 <pixman_composite_src_n_8888_asm_neon+0x58>
	DCD	0xe2866008 ;	add	r6, r6, #8
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe2866010 ;	add	r6, r6, #16
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000000 ;	beq	4538 <pixman_composite_src_n_8888_asm_neon+0x6c>
	DCD	0xf482088d ;	vst1.32	{d0[1]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	4544 <pixman_composite_src_n_8888_asm_neon+0x78>
	DCD	0xf402179d ;	vst1.32	{d1}, [r2 :64]!
	DCD	0xf4022aad ;	vst1.32	{d2-d3}, [r2 :128]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba000002 ;	blt	455c <pixman_composite_src_n_8888_asm_neon+0x90>
	DCD	0xf40202ad ;	vst1.32	{d0-d3}, [r2 :128]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaafffffc ;	bge	4550 <pixman_composite_src_n_8888_asm_neon+0x84>
	DCD	0xf40202ad ;	vst1.32	{d0-d3}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00000e ;	beq	45a4 <pixman_composite_src_n_8888_asm_neon+0xd8>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0affffff ;	beq	4570 <pixman_composite_src_n_8888_asm_neon+0xa4>
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0affffff ;	beq	4578 <pixman_composite_src_n_8888_asm_neon+0xac>
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0affffff ;	beq	4580 <pixman_composite_src_n_8888_asm_neon+0xb4>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	458c <pixman_composite_src_n_8888_asm_neon+0xc0>
	DCD	0xf4022aad ;	vst1.32	{d2-d3}, [r2 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	4598 <pixman_composite_src_n_8888_asm_neon+0xcc>
	DCD	0xf402179d ;	vst1.32	{d1}, [r2 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	45a4 <pixman_composite_src_n_8888_asm_neon+0xd8>
	DCD	0xf482088d ;	vst1.32	{d0[1]}, [r2]!
	DCD	0xe1a0000a ;	mov	r0, sl
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffcf ;	bge	44fc <pixman_composite_src_n_8888_asm_neon+0x30>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000000 ;	beq	45cc <pixman_composite_src_n_8888_asm_neon+0x100>
	DCD	0xf402028d ;	vst1.32	{d0-d3}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00000e ;	beq	4610 <pixman_composite_src_n_8888_asm_neon+0x144>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0affffff ;	beq	45dc <pixman_composite_src_n_8888_asm_neon+0x110>
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0affffff ;	beq	45e4 <pixman_composite_src_n_8888_asm_neon+0x118>
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0affffff ;	beq	45ec <pixman_composite_src_n_8888_asm_neon+0x120>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	45f8 <pixman_composite_src_n_8888_asm_neon+0x12c>
	DCD	0xf4022a8d ;	vst1.32	{d2-d3}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	4604 <pixman_composite_src_n_8888_asm_neon+0x138>
	DCD	0xf402178d ;	vst1.32	{d1}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	4610 <pixman_composite_src_n_8888_asm_neon+0x144>
	DCD	0xf482088d ;	vst1.32	{d0[1]}, [r2]!
	DCD	0xe1a0000a ;	mov	r0, sl
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffe5 ;	bge	45c0 <pixman_composite_src_n_8888_asm_neon+0xf4>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_src_n_8888_asm_neon|

|pixman_composite_src_8888_8888_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe2499006 ;	sub	r9, r9, #6
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a07000 ;	mov	r7, r0
	DCD	0xba000084 ;	blt	4874 <pixman_composite_src_8888_8888_asm_neon+0x248>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba000062 ;	blt	47f4 <pixman_composite_src_8888_8888_asm_neon+0x1c8>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a00001e ;	beq	46ec <pixman_composite_src_8888_8888_asm_neon+0xc0>
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000003 ;	beq	4688 <pixman_composite_src_8888_8888_asm_neon+0x5c>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xe2866004 ;	add	r6, r6, #4
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000003 ;	beq	46a0 <pixman_composite_src_8888_8888_asm_neon+0x74>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xe2866008 ;	add	r6, r6, #8
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xe2866010 ;	add	r6, r6, #16
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000000 ;	beq	46dc <pixman_composite_src_8888_8888_asm_neon+0xb0>
	DCD	0xf482088d ;	vst1.32	{d0[1]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	46e8 <pixman_composite_src_8888_8888_asm_neon+0xbc>
	DCD	0xf402179d ;	vst1.32	{d1}, [r2 :64]!
	DCD	0xf4022aad ;	vst1.32	{d2-d3}, [r2 :128]!
	DCD	0xf424028d ;	vld1.32	{d0-d3}, [r4]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba00000c ;	blt	4750 <pixman_composite_src_8888_8888_asm_neon+0x124>
	DCD	0xf40202ad ;	vst1.32	{d0-d3}, [r2 :128]!
	DCD	0xf424028d ;	vld1.32	{d0-d3}, [r4]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaafffff2 ;	bge	471c <pixman_composite_src_8888_8888_asm_neon+0xf0>
	DCD	0xf40202ad ;	vst1.32	{d0-d3}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00001c ;	beq	47d0 <pixman_composite_src_8888_8888_asm_neon+0x1a4>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000001 ;	beq	476c <pixman_composite_src_8888_8888_asm_neon+0x140>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	477c <pixman_composite_src_8888_8888_asm_neon+0x150>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	478c <pixman_composite_src_8888_8888_asm_neon+0x160>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	47b8 <pixman_composite_src_8888_8888_asm_neon+0x18c>
	DCD	0xf4022aad ;	vst1.32	{d2-d3}, [r2 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	47c4 <pixman_composite_src_8888_8888_asm_neon+0x198>
	DCD	0xf402179d ;	vst1.32	{d1}, [r2 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	47d0 <pixman_composite_src_8888_8888_asm_neon+0x1a4>
	DCD	0xf482088d ;	vst1.32	{d0[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff9d ;	bge	4668 <pixman_composite_src_8888_8888_asm_neon+0x3c>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000001 ;	beq	4804 <pixman_composite_src_8888_8888_asm_neon+0x1d8>
	DCD	0xf424028d ;	vld1.32	{d0-d3}, [r4]!
	DCD	0xf402028d ;	vst1.32	{d0-d3}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000011 ;	beq	4854 <pixman_composite_src_8888_8888_asm_neon+0x228>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	4818 <pixman_composite_src_8888_8888_asm_neon+0x1ec>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	4824 <pixman_composite_src_8888_8888_asm_neon+0x1f8>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	4830 <pixman_composite_src_8888_8888_asm_neon+0x204>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	483c <pixman_composite_src_8888_8888_asm_neon+0x210>
	DCD	0xf4022a8d ;	vst1.32	{d2-d3}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	4848 <pixman_composite_src_8888_8888_asm_neon+0x21c>
	DCD	0xf402178d ;	vst1.32	{d1}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	4854 <pixman_composite_src_8888_8888_asm_neon+0x228>
	DCD	0xf482088d ;	vst1.32	{d0[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffdf ;	bge	47f4 <pixman_composite_src_8888_8888_asm_neon+0x1c8>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_src_8888_8888_asm_neon|

|pixman_composite_src_x888_8888_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe2499006 ;	sub	r9, r9, #6
	DCD	0xf3874e5f ;	vmov.i8	q2, #255	; 0xff
	DCD	0xf2b84554 ;	vshl.s32	q2, q2, #24
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a07000 ;	mov	r7, r0
	DCD	0xba000090 ;	blt	4af8 <pixman_composite_src_x888_8888_asm_neon+0x280>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba00006a ;	blt	4a68 <pixman_composite_src_x888_8888_asm_neon+0x1f0>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000020 ;	beq	4948 <pixman_composite_src_x888_8888_asm_neon+0xd0>
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000003 ;	beq	48dc <pixman_composite_src_x888_8888_asm_neon+0x64>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xe2866004 ;	add	r6, r6, #4
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000003 ;	beq	48f4 <pixman_composite_src_x888_8888_asm_neon+0x7c>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xe2866008 ;	add	r6, r6, #8
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xe2866010 ;	add	r6, r6, #16
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf2200154 ;	vorr	q0, q0, q2
	DCD	0xf2222154 ;	vorr	q1, q1, q2
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000000 ;	beq	4938 <pixman_composite_src_x888_8888_asm_neon+0xc0>
	DCD	0xf482088d ;	vst1.32	{d0[1]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	4944 <pixman_composite_src_x888_8888_asm_neon+0xcc>
	DCD	0xf402179d ;	vst1.32	{d1}, [r2 :64]!
	DCD	0xf4022aad ;	vst1.32	{d2-d3}, [r2 :128]!
	DCD	0xf424028d ;	vld1.32	{d0-d3}, [r4]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf2200154 ;	vorr	q0, q0, q2
	DCD	0xf2222154 ;	vorr	q1, q1, q2
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba00000e ;	blt	49bc <pixman_composite_src_x888_8888_asm_neon+0x144>
	DCD	0xf40202ad ;	vst1.32	{d0-d3}, [r2 :128]!
	DCD	0xf424028d ;	vld1.32	{d0-d3}, [r4]!
	DCD	0xf2200154 ;	vorr	q0, q0, q2
	DCD	0xf2222154 ;	vorr	q1, q1, q2
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaafffff0 ;	bge	4980 <pixman_composite_src_x888_8888_asm_neon+0x108>
	DCD	0xf40202ad ;	vst1.32	{d0-d3}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00001e ;	beq	4a44 <pixman_composite_src_x888_8888_asm_neon+0x1cc>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000001 ;	beq	49d8 <pixman_composite_src_x888_8888_asm_neon+0x160>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	49e8 <pixman_composite_src_x888_8888_asm_neon+0x170>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	49f8 <pixman_composite_src_x888_8888_asm_neon+0x180>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf2200154 ;	vorr	q0, q0, q2
	DCD	0xf2222154 ;	vorr	q1, q1, q2
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	4a2c <pixman_composite_src_x888_8888_asm_neon+0x1b4>
	DCD	0xf4022aad ;	vst1.32	{d2-d3}, [r2 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	4a38 <pixman_composite_src_x888_8888_asm_neon+0x1c0>
	DCD	0xf402179d ;	vst1.32	{d1}, [r2 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	4a44 <pixman_composite_src_x888_8888_asm_neon+0x1cc>
	DCD	0xf482088d ;	vst1.32	{d0[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff95 ;	bge	48bc <pixman_composite_src_x888_8888_asm_neon+0x44>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000003 ;	beq	4a80 <pixman_composite_src_x888_8888_asm_neon+0x208>
	DCD	0xf424028d ;	vld1.32	{d0-d3}, [r4]!
	DCD	0xf2200154 ;	vorr	q0, q0, q2
	DCD	0xf2222154 ;	vorr	q1, q1, q2
	DCD	0xf402028d ;	vst1.32	{d0-d3}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000013 ;	beq	4ad8 <pixman_composite_src_x888_8888_asm_neon+0x260>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	4a94 <pixman_composite_src_x888_8888_asm_neon+0x21c>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	4aa0 <pixman_composite_src_x888_8888_asm_neon+0x228>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	4aac <pixman_composite_src_x888_8888_asm_neon+0x234>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf2200154 ;	vorr	q0, q0, q2
	DCD	0xf2222154 ;	vorr	q1, q1, q2
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	4ac0 <pixman_composite_src_x888_8888_asm_neon+0x248>
	DCD	0xf4022a8d ;	vst1.32	{d2-d3}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	4acc <pixman_composite_src_x888_8888_asm_neon+0x254>
	DCD	0xf402178d ;	vst1.32	{d1}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	4ad8 <pixman_composite_src_x888_8888_asm_neon+0x260>
	DCD	0xf482088d ;	vst1.32	{d0[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffdb ;	bge	4a68 <pixman_composite_src_x888_8888_asm_neon+0x1f0>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_src_x888_8888_asm_neon|

|pixman_composite_src_n_8_8888_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d7030 ;	ldr	r7, [sp, #48]	; 0x30
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d8034 ;	ldr	r8, [sp, #52]	; 0x34
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xe28d5028 ;	add	r5, sp, #40	; 0x28
	DCD	0xf4a5380f ;	vld1.32	{d3[0]}, [r5]
	DCD	0xf3b10c03 ;	vdup.8	d0, d3[0]
	DCD	0xf3b31c03 ;	vdup.8	d1, d3[1]
	DCD	0xf3b52c03 ;	vdup.8	d2, d3[2]
	DCD	0xf3b73c03 ;	vdup.8	d3, d3[3]
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a04000 ;	mov	r4, r0
	DCD	0xba0000e4 ;	blt	4edc <pixman_composite_src_n_8_8888_asm_neon+0x3e0>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba0000a2 ;	blt	4ddc <pixman_composite_src_n_8_8888_asm_neon+0x2e0>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000032 ;	beq	4c24 <pixman_composite_src_n_8_8888_asm_neon+0x128>
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000003 ;	beq	4b70 <pixman_composite_src_n_8_8888_asm_neon+0x74>
	DCD	0xf4e7802d ;	vld1.8	{d24[1]}, [r7]!
	DCD	0xe2866004 ;	add	r6, r6, #4
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000004 ;	beq	4b8c <pixman_composite_src_n_8_8888_asm_neon+0x90>
	DCD	0xf4e7804d ;	vld1.8	{d24[2]}, [r7]!
	DCD	0xf4e7806d ;	vld1.8	{d24[3]}, [r7]!
	DCD	0xe2866008 ;	add	r6, r6, #8
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xf4e7808d ;	vld1.8	{d24[4]}, [r7]!
	DCD	0xf4e780ad ;	vld1.8	{d24[5]}, [r7]!
	DCD	0xf4e780cd ;	vld1.8	{d24[6]}, [r7]!
	DCD	0xf4e780ed ;	vld1.8	{d24[7]}, [r7]!
	DCD	0xe2866010 ;	add	r6, r6, #16
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3c80c80 ;	vmull.u8	q8, d24, d0
	DCD	0xf3c82c81 ;	vmull.u8	q9, d24, d1
	DCD	0xf3c84c82 ;	vmull.u8	q10, d24, d2
	DCD	0xf3c86c83 ;	vmull.u8	q11, d24, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000000 ;	beq	4c14 <pixman_composite_src_n_8_8888_asm_neon+0x118>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	4c20 <pixman_composite_src_n_8_8888_asm_neon+0x124>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xf467870d ;	vld1.8	{d24}, [r7]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf3c80c80 ;	vmull.u8	q8, d24, d0
	DCD	0xf3c82c81 ;	vmull.u8	q9, d24, d1
	DCD	0xf3c84c82 ;	vmull.u8	q10, d24, d2
	DCD	0xf3c86c83 ;	vmull.u8	q11, d24, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba000018 ;	blt	4cd8 <pixman_composite_src_n_8_8888_asm_neon+0x1dc>
	DCD	0xf467870d ;	vld1.8	{d24}, [r7]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf3c80c80 ;	vmull.u8	q8, d24, d0
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xf3c82c81 ;	vmull.u8	q9, d24, d1
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xf3c84c82 ;	vmull.u8	q10, d24, d2
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xf3c86c83 ;	vmull.u8	q11, d24, d3
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffe6 ;	bge	4c74 <pixman_composite_src_n_8_8888_asm_neon+0x178>
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000030 ;	beq	4db8 <pixman_composite_src_n_8_8888_asm_neon+0x2bc>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000004 ;	beq	4d10 <pixman_composite_src_n_8_8888_asm_neon+0x214>
	DCD	0xf4e7808d ;	vld1.8	{d24[4]}, [r7]!
	DCD	0xf4e780ad ;	vld1.8	{d24[5]}, [r7]!
	DCD	0xf4e780cd ;	vld1.8	{d24[6]}, [r7]!
	DCD	0xf4e780ed ;	vld1.8	{d24[7]}, [r7]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000002 ;	beq	4d24 <pixman_composite_src_n_8_8888_asm_neon+0x228>
	DCD	0xf4e7804d ;	vld1.8	{d24[2]}, [r7]!
	DCD	0xf4e7806d ;	vld1.8	{d24[3]}, [r7]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	4d34 <pixman_composite_src_n_8_8888_asm_neon+0x238>
	DCD	0xf4e7802d ;	vld1.8	{d24[1]}, [r7]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf3c80c80 ;	vmull.u8	q8, d24, d0
	DCD	0xf3c82c81 ;	vmull.u8	q9, d24, d1
	DCD	0xf3c84c82 ;	vmull.u8	q10, d24, d2
	DCD	0xf3c86c83 ;	vmull.u8	q11, d24, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	4da0 <pixman_composite_src_n_8_8888_asm_neon+0x2a4>
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	4dac <pixman_composite_src_n_8_8888_asm_neon+0x2b0>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	4db8 <pixman_composite_src_n_8_8888_asm_neon+0x2bc>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00004 ;	mov	r0, r4
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0877008 ;	add	r7, r7, r8
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0477000 ;	sub	r7, r7, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff5d ;	bge	4b50 <pixman_composite_src_n_8_8888_asm_neon+0x54>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a00000d ;	beq	4e1c <pixman_composite_src_n_8_8888_asm_neon+0x320>
	DCD	0xf467870d ;	vld1.8	{d24}, [r7]!
	DCD	0xf3c80c80 ;	vmull.u8	q8, d24, d0
	DCD	0xf3c82c81 ;	vmull.u8	q9, d24, d1
	DCD	0xf3c84c82 ;	vmull.u8	q10, d24, d2
	DCD	0xf3c86c83 ;	vmull.u8	q11, d24, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf442c00d ;	vst4.8	{d28-d31}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000025 ;	beq	4ebc <pixman_composite_src_n_8_8888_asm_neon+0x3c0>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000003 ;	beq	4e3c <pixman_composite_src_n_8_8888_asm_neon+0x340>
	DCD	0xf4e7808d ;	vld1.8	{d24[4]}, [r7]!
	DCD	0xf4e780ad ;	vld1.8	{d24[5]}, [r7]!
	DCD	0xf4e780cd ;	vld1.8	{d24[6]}, [r7]!
	DCD	0xf4e780ed ;	vld1.8	{d24[7]}, [r7]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	4e4c <pixman_composite_src_n_8_8888_asm_neon+0x350>
	DCD	0xf4e7804d ;	vld1.8	{d24[2]}, [r7]!
	DCD	0xf4e7806d ;	vld1.8	{d24[3]}, [r7]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	4e58 <pixman_composite_src_n_8_8888_asm_neon+0x35c>
	DCD	0xf4e7802d ;	vld1.8	{d24[1]}, [r7]!
	DCD	0xf3c80c80 ;	vmull.u8	q8, d24, d0
	DCD	0xf3c82c81 ;	vmull.u8	q9, d24, d1
	DCD	0xf3c84c82 ;	vmull.u8	q10, d24, d2
	DCD	0xf3c86c83 ;	vmull.u8	q11, d24, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	4ea4 <pixman_composite_src_n_8_8888_asm_neon+0x3a8>
	DCD	0xf442ea8d ;	vst1.32	{d30-d31}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	4eb0 <pixman_composite_src_n_8_8888_asm_neon+0x3b4>
	DCD	0xf442d78d ;	vst1.32	{d29}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	4ebc <pixman_composite_src_n_8_8888_asm_neon+0x3c0>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00004 ;	mov	r0, r4
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0877008 ;	add	r7, r7, r8
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0477000 ;	sub	r7, r7, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffbf ;	bge	4ddc <pixman_composite_src_n_8_8888_asm_neon+0x2e0>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_src_n_8_8888_asm_neon|

|pixman_composite_src_n_8_8_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d7030 ;	ldr	r7, [sp, #48]	; 0x30
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d8034 ;	ldr	r8, [sp, #52]	; 0x34
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xe28d5028 ;	add	r5, sp, #40	; 0x28
	DCD	0xf4e5080f ;	vld1.32	{d16[0]}, [r5]
	DCD	0xf3f70c20 ;	vdup.8	d16, d16[3]
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a04000 ;	mov	r4, r0
	DCD	0xba000110 ;	blt	5364 <pixman_composite_src_n_8_8_asm_neon+0x484>
	DCD	0xe3500040 ;	cmp	r0, #64	; 0x40
	DCD	0xba0000c2 ;	blt	5234 <pixman_composite_src_n_8_8_asm_neon+0x354>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000044 ;	beq	5044 <pixman_composite_src_n_8_8_asm_neon+0x164>
	DCD	0xe3160001 ;	tst	r6, #1
	DCD	0x0a000003 ;	beq	4f48 <pixman_composite_src_n_8_8_asm_neon+0x68>
	DCD	0xf4e7802d ;	vld1.8	{d24[1]}, [r7]!
	DCD	0xe2866001 ;	add	r6, r6, #1
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160002 ;	tst	r6, #2
	DCD	0x0a000004 ;	beq	4f64 <pixman_composite_src_n_8_8_asm_neon+0x84>
	DCD	0xf4e7804d ;	vld1.8	{d24[2]}, [r7]!
	DCD	0xf4e7806d ;	vld1.8	{d24[3]}, [r7]!
	DCD	0xe2866002 ;	add	r6, r6, #2
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000006 ;	beq	4f88 <pixman_composite_src_n_8_8_asm_neon+0xa8>
	DCD	0xf4e7808d ;	vld1.8	{d24[4]}, [r7]!
	DCD	0xf4e780ad ;	vld1.8	{d24[5]}, [r7]!
	DCD	0xf4e780cd ;	vld1.8	{d24[6]}, [r7]!
	DCD	0xf4e780ed ;	vld1.8	{d24[7]}, [r7]!
	DCD	0xe2866004 ;	add	r6, r6, #4
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000003 ;	beq	4fa0 <pixman_composite_src_n_8_8_asm_neon+0xc0>
	DCD	0xf467970d ;	vld1.8	{d25}, [r7]!
	DCD	0xe2866008 ;	add	r6, r6, #8
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe2400008 ;	sub	r0, r0, #8
	DCD	0xf467aa0d ;	vld1.8	{d26-d27}, [r7]!
	DCD	0xe2866010 ;	add	r6, r6, #16
	DCD	0xe28aa010 ;	add	sl, sl, #16
	DCD	0xe2400010 ;	sub	r0, r0, #16
	DCD	0xf3880ca0 ;	vmull.u8	q0, d24, d16
	DCD	0xf3892ca0 ;	vmull.u8	q1, d25, d16
	DCD	0xf38a4ca0 ;	vmull.u8	q2, d26, d16
	DCD	0xf38b6ca0 ;	vmull.u8	q3, d27, d16
	DCD	0xf3980350 ;	vrsra.u16	q0, q0, #8
	DCD	0xf3982352 ;	vrsra.u16	q1, q1, #8
	DCD	0xf3984354 ;	vrsra.u16	q2, q2, #8
	DCD	0xf3986356 ;	vrsra.u16	q3, q3, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa020 ;	addne	sl, sl, #32
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xf2c8c850 ;	vrshrn.i16	d28, q0, #8
	DCD	0xf2c8d852 ;	vrshrn.i16	d29, q1, #8
	DCD	0xf2c8e854 ;	vrshrn.i16	d30, q2, #8
	DCD	0xf2c8f856 ;	vrshrn.i16	d31, q3, #8
	DCD	0xe3120001 ;	tst	r2, #1
	DCD	0x0a000000 ;	beq	500c <pixman_composite_src_n_8_8_asm_neon+0x12c>
	DCD	0xf4c2c02d ;	vst1.8	{d28[1]}, [r2]!
	DCD	0xe3120002 ;	tst	r2, #2
	DCD	0x0a000001 ;	beq	501c <pixman_composite_src_n_8_8_asm_neon+0x13c>
	DCD	0xf4c2c04d ;	vst1.8	{d28[2]}, [r2]!
	DCD	0xf4c2c06d ;	vst1.8	{d28[3]}, [r2]!
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000003 ;	beq	5034 <pixman_composite_src_n_8_8_asm_neon+0x154>
	DCD	0xf4c2c08d ;	vst1.8	{d28[4]}, [r2]!
	DCD	0xf4c2c0ad ;	vst1.8	{d28[5]}, [r2]!
	DCD	0xf4c2c0cd ;	vst1.8	{d28[6]}, [r2]!
	DCD	0xf4c2c0ed ;	vst1.8	{d28[7]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	5040 <pixman_composite_src_n_8_8_asm_neon+0x160>
	DCD	0xf442d71d ;	vst1.8	{d29}, [r2 :64]!
	DCD	0xf442ea2d ;	vst1.8	{d30-d31}, [r2 :128]!
	DCD	0xf467820d ;	vld1.8	{d24-d27}, [r7]!
	DCD	0xe28aa020 ;	add	sl, sl, #32
	DCD	0xf3880ca0 ;	vmull.u8	q0, d24, d16
	DCD	0xf3892ca0 ;	vmull.u8	q1, d25, d16
	DCD	0xf38a4ca0 ;	vmull.u8	q2, d26, d16
	DCD	0xf38b6ca0 ;	vmull.u8	q3, d27, d16
	DCD	0xf3980350 ;	vrsra.u16	q0, q0, #8
	DCD	0xf3982352 ;	vrsra.u16	q1, q1, #8
	DCD	0xf3984354 ;	vrsra.u16	q2, q2, #8
	DCD	0xf3986356 ;	vrsra.u16	q3, q3, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa020 ;	addne	sl, sl, #32
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xe2500040 ;	subs	r0, r0, #64	; 0x40
	DCD	0xba000018 ;	blt	50f8 <pixman_composite_src_n_8_8_asm_neon+0x218>
	DCD	0xf467820d ;	vld1.8	{d24-d27}, [r7]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf2c8c850 ;	vrshrn.i16	d28, q0, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0xf2c8d852 ;	vrshrn.i16	d29, q1, #8
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0xf2c8e854 ;	vrshrn.i16	d30, q2, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xf2c8f856 ;	vrshrn.i16	d31, q3, #8
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf3880ca0 ;	vmull.u8	q0, d24, d16
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xf3892ca0 ;	vmull.u8	q1, d25, d16
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xf38a4ca0 ;	vmull.u8	q2, d26, d16
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xf38b6ca0 ;	vmull.u8	q3, d27, d16
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xf442c22d ;	vst1.8	{d28-d31}, [r2 :128]!
	DCD	0xf3980350 ;	vrsra.u16	q0, q0, #8
	DCD	0xf3982352 ;	vrsra.u16	q1, q1, #8
	DCD	0xf3984354 ;	vrsra.u16	q2, q2, #8
	DCD	0xf3986356 ;	vrsra.u16	q3, q3, #8
	DCD	0xe2500020 ;	subs	r0, r0, #32
	DCD	0xaaffffe6 ;	bge	5094 <pixman_composite_src_n_8_8_asm_neon+0x1b4>
	DCD	0xf2c8c850 ;	vrshrn.i16	d28, q0, #8
	DCD	0xf2c8d852 ;	vrshrn.i16	d29, q1, #8
	DCD	0xf2c8e854 ;	vrshrn.i16	d30, q2, #8
	DCD	0xf2c8f856 ;	vrshrn.i16	d31, q3, #8
	DCD	0xf442c22d ;	vst1.8	{d28-d31}, [r2 :128]!
	DCD	0xe310001f ;	tst	r0, #31
	DCD	0x0a00003e ;	beq	5210 <pixman_composite_src_n_8_8_asm_neon+0x330>
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000001 ;	beq	5124 <pixman_composite_src_n_8_8_asm_neon+0x244>
	DCD	0xf467aa0d ;	vld1.8	{d26-d27}, [r7]!
	DCD	0xe28aa010 ;	add	sl, sl, #16
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000001 ;	beq	5134 <pixman_composite_src_n_8_8_asm_neon+0x254>
	DCD	0xf467970d ;	vld1.8	{d25}, [r7]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000004 ;	beq	5150 <pixman_composite_src_n_8_8_asm_neon+0x270>
	DCD	0xf4e7808d ;	vld1.8	{d24[4]}, [r7]!
	DCD	0xf4e780ad ;	vld1.8	{d24[5]}, [r7]!
	DCD	0xf4e780cd ;	vld1.8	{d24[6]}, [r7]!
	DCD	0xf4e780ed ;	vld1.8	{d24[7]}, [r7]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000002 ;	beq	5164 <pixman_composite_src_n_8_8_asm_neon+0x284>
	DCD	0xf4e7804d ;	vld1.8	{d24[2]}, [r7]!
	DCD	0xf4e7806d ;	vld1.8	{d24[3]}, [r7]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	5174 <pixman_composite_src_n_8_8_asm_neon+0x294>
	DCD	0xf4e7802d ;	vld1.8	{d24[1]}, [r7]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf3880ca0 ;	vmull.u8	q0, d24, d16
	DCD	0xf3892ca0 ;	vmull.u8	q1, d25, d16
	DCD	0xf38a4ca0 ;	vmull.u8	q2, d26, d16
	DCD	0xf38b6ca0 ;	vmull.u8	q3, d27, d16
	DCD	0xf3980350 ;	vrsra.u16	q0, q0, #8
	DCD	0xf3982352 ;	vrsra.u16	q1, q1, #8
	DCD	0xf3984354 ;	vrsra.u16	q2, q2, #8
	DCD	0xf3986356 ;	vrsra.u16	q3, q3, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa020 ;	addne	sl, sl, #32
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xf2c8c850 ;	vrshrn.i16	d28, q0, #8
	DCD	0xf2c8d852 ;	vrshrn.i16	d29, q1, #8
	DCD	0xf2c8e854 ;	vrshrn.i16	d30, q2, #8
	DCD	0xf2c8f856 ;	vrshrn.i16	d31, q3, #8
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000000 ;	beq	51d0 <pixman_composite_src_n_8_8_asm_neon+0x2f0>
	DCD	0xf442ea2d ;	vst1.8	{d30-d31}, [r2 :128]!
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000000 ;	beq	51dc <pixman_composite_src_n_8_8_asm_neon+0x2fc>
	DCD	0xf442d71d ;	vst1.8	{d29}, [r2 :64]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000003 ;	beq	51f4 <pixman_composite_src_n_8_8_asm_neon+0x314>
	DCD	0xf4c2c08d ;	vst1.8	{d28[4]}, [r2]!
	DCD	0xf4c2c0ad ;	vst1.8	{d28[5]}, [r2]!
	DCD	0xf4c2c0cd ;	vst1.8	{d28[6]}, [r2]!
	DCD	0xf4c2c0ed ;	vst1.8	{d28[7]}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	5204 <pixman_composite_src_n_8_8_asm_neon+0x324>
	DCD	0xf4c2c04d ;	vst1.8	{d28[2]}, [r2]!
	DCD	0xf4c2c06d ;	vst1.8	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	5210 <pixman_composite_src_n_8_8_asm_neon+0x330>
	DCD	0xf4c2c02d ;	vst1.8	{d28[1]}, [r2]!
	DCD	0xe1a00004 ;	mov	r0, r4
	DCD	0xe0822003 ;	add	r2, r2, r3
	DCD	0xe0877008 ;	add	r7, r7, r8
	DCD	0xe0422000 ;	sub	r2, r2, r0
	DCD	0xe0477000 ;	sub	r7, r7, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff3d ;	bge	4f28 <pixman_composite_src_n_8_8_asm_neon+0x48>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100020 ;	tst	r0, #32
	DCD	0x0a00000d ;	beq	5274 <pixman_composite_src_n_8_8_asm_neon+0x394>
	DCD	0xf467820d ;	vld1.8	{d24-d27}, [r7]!
	DCD	0xf3880ca0 ;	vmull.u8	q0, d24, d16
	DCD	0xf3892ca0 ;	vmull.u8	q1, d25, d16
	DCD	0xf38a4ca0 ;	vmull.u8	q2, d26, d16
	DCD	0xf38b6ca0 ;	vmull.u8	q3, d27, d16
	DCD	0xf3980350 ;	vrsra.u16	q0, q0, #8
	DCD	0xf3982352 ;	vrsra.u16	q1, q1, #8
	DCD	0xf3984354 ;	vrsra.u16	q2, q2, #8
	DCD	0xf3986356 ;	vrsra.u16	q3, q3, #8
	DCD	0xf2c8c850 ;	vrshrn.i16	d28, q0, #8
	DCD	0xf2c8d852 ;	vrshrn.i16	d29, q1, #8
	DCD	0xf2c8e854 ;	vrshrn.i16	d30, q2, #8
	DCD	0xf2c8f856 ;	vrshrn.i16	d31, q3, #8
	DCD	0xf442c20d ;	vst1.8	{d28-d31}, [r2]!
	DCD	0xe310001f ;	tst	r0, #31
	DCD	0x0a000031 ;	beq	5344 <pixman_composite_src_n_8_8_asm_neon+0x464>
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000000 ;	beq	5288 <pixman_composite_src_n_8_8_asm_neon+0x3a8>
	DCD	0xf467aa0d ;	vld1.8	{d26-d27}, [r7]!
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000000 ;	beq	5294 <pixman_composite_src_n_8_8_asm_neon+0x3b4>
	DCD	0xf467970d ;	vld1.8	{d25}, [r7]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000003 ;	beq	52ac <pixman_composite_src_n_8_8_asm_neon+0x3cc>
	DCD	0xf4e7808d ;	vld1.8	{d24[4]}, [r7]!
	DCD	0xf4e780ad ;	vld1.8	{d24[5]}, [r7]!
	DCD	0xf4e780cd ;	vld1.8	{d24[6]}, [r7]!
	DCD	0xf4e780ed ;	vld1.8	{d24[7]}, [r7]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	52bc <pixman_composite_src_n_8_8_asm_neon+0x3dc>
	DCD	0xf4e7804d ;	vld1.8	{d24[2]}, [r7]!
	DCD	0xf4e7806d ;	vld1.8	{d24[3]}, [r7]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	52c8 <pixman_composite_src_n_8_8_asm_neon+0x3e8>
	DCD	0xf4e7802d ;	vld1.8	{d24[1]}, [r7]!
	DCD	0xf3880ca0 ;	vmull.u8	q0, d24, d16
	DCD	0xf3892ca0 ;	vmull.u8	q1, d25, d16
	DCD	0xf38a4ca0 ;	vmull.u8	q2, d26, d16
	DCD	0xf38b6ca0 ;	vmull.u8	q3, d27, d16
	DCD	0xf3980350 ;	vrsra.u16	q0, q0, #8
	DCD	0xf3982352 ;	vrsra.u16	q1, q1, #8
	DCD	0xf3984354 ;	vrsra.u16	q2, q2, #8
	DCD	0xf3986356 ;	vrsra.u16	q3, q3, #8
	DCD	0xf2c8c850 ;	vrshrn.i16	d28, q0, #8
	DCD	0xf2c8d852 ;	vrshrn.i16	d29, q1, #8
	DCD	0xf2c8e854 ;	vrshrn.i16	d30, q2, #8
	DCD	0xf2c8f856 ;	vrshrn.i16	d31, q3, #8
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000000 ;	beq	5304 <pixman_composite_src_n_8_8_asm_neon+0x424>
	DCD	0xf442ea0d ;	vst1.8	{d30-d31}, [r2]!
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000000 ;	beq	5310 <pixman_composite_src_n_8_8_asm_neon+0x430>
	DCD	0xf442d70d ;	vst1.8	{d29}, [r2]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000003 ;	beq	5328 <pixman_composite_src_n_8_8_asm_neon+0x448>
	DCD	0xf4c2c08d ;	vst1.8	{d28[4]}, [r2]!
	DCD	0xf4c2c0ad ;	vst1.8	{d28[5]}, [r2]!
	DCD	0xf4c2c0cd ;	vst1.8	{d28[6]}, [r2]!
	DCD	0xf4c2c0ed ;	vst1.8	{d28[7]}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	5338 <pixman_composite_src_n_8_8_asm_neon+0x458>
	DCD	0xf4c2c04d ;	vst1.8	{d28[2]}, [r2]!
	DCD	0xf4c2c06d ;	vst1.8	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	5344 <pixman_composite_src_n_8_8_asm_neon+0x464>
	DCD	0xf4c2c02d ;	vst1.8	{d28[1]}, [r2]!
	DCD	0xe1a00004 ;	mov	r0, r4
	DCD	0xe0822003 ;	add	r2, r2, r3
	DCD	0xe0877008 ;	add	r7, r7, r8
	DCD	0xe0422000 ;	sub	r2, r2, r0
	DCD	0xe0477000 ;	sub	r7, r7, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffb3 ;	bge	5234 <pixman_composite_src_n_8_8_asm_neon+0x354>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_src_n_8_8_asm_neon|

|pixman_composite_over_n_8_8888_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d7030 ;	ldr	r7, [sp, #48]	; 0x30
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d8034 ;	ldr	r8, [sp, #52]	; 0x34
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xe28d5028 ;	add	r5, sp, #40	; 0x28
	DCD	0xed2d8b10 ;	vpush	{d8-d15}
	DCD	0xf4a5b80f ;	vld1.32	{d11[0]}, [r5]
	DCD	0xf3b18c0b ;	vdup.8	d8, d11[0]
	DCD	0xf3b39c0b ;	vdup.8	d9, d11[1]
	DCD	0xf3b5ac0b ;	vdup.8	d10, d11[2]
	DCD	0xf3b7bc0b ;	vdup.8	d11, d11[3]
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a04000 ;	mov	r4, r0
	DCD	0xba00015c ;	blt	592c <pixman_composite_over_n_8_8888_asm_neon+0x5c4>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba0000f4 ;	blt	5794 <pixman_composite_over_n_8_8888_asm_neon+0x42c>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000047 ;	beq	54e8 <pixman_composite_over_n_8_8888_asm_neon+0x180>
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000003 ;	beq	53e0 <pixman_composite_over_n_8_8888_asm_neon+0x78>
	DCD	0xf4e7802d ;	vld1.8	{d24[1]}, [r7]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000004 ;	beq	53fc <pixman_composite_over_n_8_8888_asm_neon+0x94>
	DCD	0xf4e7804d ;	vld1.8	{d24[2]}, [r7]!
	DCD	0xf4e7806d ;	vld1.8	{d24[3]}, [r7]!
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xf4e7808d ;	vld1.8	{d24[4]}, [r7]!
	DCD	0xf4e780ad ;	vld1.8	{d24[5]}, [r7]!
	DCD	0xf4e780cd ;	vld1.8	{d24[6]}, [r7]!
	DCD	0xf4e780ed ;	vld1.8	{d24[7]}, [r7]!
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf388cc88 ;	vmull.u8	q6, d24, d8
	DCD	0xf388ec89 ;	vmull.u8	q7, d24, d9
	DCD	0xf3c80c8a ;	vmull.u8	q8, d24, d10
	DCD	0xf3c82c8b ;	vmull.u8	q9, d24, d11
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3d88270 ;	vrshr.u16	q12, q8, #8
	DCD	0xf3d8a272 ;	vrshr.u16	q13, q9, #8
	DCD	0xf38c0424 ;	vraddhn.i16	d0, q6, q10
	DCD	0xf38e1426 ;	vraddhn.i16	d1, q7, q11
	DCD	0xf38024a8 ;	vraddhn.i16	d2, q8, q12
	DCD	0xf38234aa ;	vraddhn.i16	d3, q9, q13
	DCD	0xf3f09583 ;	vmvn	d25, d3
	DCD	0xf3c90c84 ;	vmull.u8	q8, d25, d4
	DCD	0xf3c92c85 ;	vmull.u8	q9, d25, d5
	DCD	0xf3c94c86 ;	vmull.u8	q10, d25, d6
	DCD	0xf3c96c87 ;	vmull.u8	q11, d25, d7
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc5103 ;	ldrbge	r5, [ip, r3, lsl #2]!
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf398c274 ;	vrshr.u16	q6, q10, #8
	DCD	0xf398e276 ;	vrshr.u16	q7, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3cce424 ;	vraddhn.i16	d30, q6, q10
	DCD	0xf3cef426 ;	vraddhn.i16	d31, q7, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000000 ;	beq	54d8 <pixman_composite_over_n_8_8888_asm_neon+0x170>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	54e4 <pixman_composite_over_n_8_8888_asm_neon+0x17c>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xf426402d ;	vld4.8	{d4-d7}, [r6 :128]!
	DCD	0xf467870d ;	vld1.8	{d24}, [r7]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf388cc88 ;	vmull.u8	q6, d24, d8
	DCD	0xf388ec89 ;	vmull.u8	q7, d24, d9
	DCD	0xf3c80c8a ;	vmull.u8	q8, d24, d10
	DCD	0xf3c82c8b ;	vmull.u8	q9, d24, d11
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3d88270 ;	vrshr.u16	q12, q8, #8
	DCD	0xf3d8a272 ;	vrshr.u16	q13, q9, #8
	DCD	0xf38c0424 ;	vraddhn.i16	d0, q6, q10
	DCD	0xf38e1426 ;	vraddhn.i16	d1, q7, q11
	DCD	0xf38024a8 ;	vraddhn.i16	d2, q8, q12
	DCD	0xf38234aa ;	vraddhn.i16	d3, q9, q13
	DCD	0xf3f09583 ;	vmvn	d25, d3
	DCD	0xf3c90c84 ;	vmull.u8	q8, d25, d4
	DCD	0xf3c92c85 ;	vmull.u8	q9, d25, d5
	DCD	0xf3c94c86 ;	vmull.u8	q10, d25, d6
	DCD	0xf3c96c87 ;	vmull.u8	q11, d25, d7
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc5103 ;	ldrbge	r5, [ip, r3, lsl #2]!
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba00002a ;	blt	5614 <pixman_composite_over_n_8_8888_asm_neon+0x2ac>
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf426402d ;	vld4.8	{d4-d7}, [r6 :128]!
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf467870d ;	vld1.8	{d24}, [r7]!
	DCD	0xf398c274 ;	vrshr.u16	q6, q10, #8
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf398e276 ;	vrshr.u16	q7, q11, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xf3cce424 ;	vraddhn.i16	d30, q6, q10
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf3cef426 ;	vraddhn.i16	d31, q7, q11
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf388cc88 ;	vmull.u8	q6, d24, d8
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xf388ec89 ;	vmull.u8	q7, d24, d9
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xf3c80c8a ;	vmull.u8	q8, d24, d10
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xf3c82c8b ;	vmull.u8	q9, d24, d11
	DCD	0xa7fc5103 ;	ldrbge	r5, [ip, r3, lsl #2]!
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3d88270 ;	vrshr.u16	q12, q8, #8
	DCD	0xf3d8a272 ;	vrshr.u16	q13, q9, #8
	DCD	0xf38c0424 ;	vraddhn.i16	d0, q6, q10
	DCD	0xf38e1426 ;	vraddhn.i16	d1, q7, q11
	DCD	0xf38024a8 ;	vraddhn.i16	d2, q8, q12
	DCD	0xf38234aa ;	vraddhn.i16	d3, q9, q13
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xf3f09583 ;	vmvn	d25, d3
	DCD	0xf3c90c84 ;	vmull.u8	q8, d25, d4
	DCD	0xf3c92c85 ;	vmull.u8	q9, d25, d5
	DCD	0xf3c94c86 ;	vmull.u8	q10, d25, d6
	DCD	0xf3c96c87 ;	vmull.u8	q11, d25, d7
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffd4 ;	bge	5568 <pixman_composite_over_n_8_8888_asm_neon+0x200>
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf398c274 ;	vrshr.u16	q6, q10, #8
	DCD	0xf398e276 ;	vrshr.u16	q7, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3cce424 ;	vraddhn.i16	d30, q6, q10
	DCD	0xf3cef426 ;	vraddhn.i16	d31, q7, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000048 ;	beq	576c <pixman_composite_over_n_8_8888_asm_neon+0x404>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000005 ;	beq	5668 <pixman_composite_over_n_8_8888_asm_neon+0x300>
	DCD	0xf4e7808d ;	vld1.8	{d24[4]}, [r7]!
	DCD	0xf4e780ad ;	vld1.8	{d24[5]}, [r7]!
	DCD	0xf4e780cd ;	vld1.8	{d24[6]}, [r7]!
	DCD	0xf4e780ed ;	vld1.8	{d24[7]}, [r7]!
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000003 ;	beq	5680 <pixman_composite_over_n_8_8888_asm_neon+0x318>
	DCD	0xf4e7804d ;	vld1.8	{d24[2]}, [r7]!
	DCD	0xf4e7806d ;	vld1.8	{d24[3]}, [r7]!
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	5694 <pixman_composite_over_n_8_8888_asm_neon+0x32c>
	DCD	0xf4e7802d ;	vld1.8	{d24[1]}, [r7]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf388cc88 ;	vmull.u8	q6, d24, d8
	DCD	0xf388ec89 ;	vmull.u8	q7, d24, d9
	DCD	0xf3c80c8a ;	vmull.u8	q8, d24, d10
	DCD	0xf3c82c8b ;	vmull.u8	q9, d24, d11
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3d88270 ;	vrshr.u16	q12, q8, #8
	DCD	0xf3d8a272 ;	vrshr.u16	q13, q9, #8
	DCD	0xf38c0424 ;	vraddhn.i16	d0, q6, q10
	DCD	0xf38e1426 ;	vraddhn.i16	d1, q7, q11
	DCD	0xf38024a8 ;	vraddhn.i16	d2, q8, q12
	DCD	0xf38234aa ;	vraddhn.i16	d3, q9, q13
	DCD	0xf3f09583 ;	vmvn	d25, d3
	DCD	0xf3c90c84 ;	vmull.u8	q8, d25, d4
	DCD	0xf3c92c85 ;	vmull.u8	q9, d25, d5
	DCD	0xf3c94c86 ;	vmull.u8	q10, d25, d6
	DCD	0xf3c96c87 ;	vmull.u8	q11, d25, d7
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc5103 ;	ldrbge	r5, [ip, r3, lsl #2]!
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf398c274 ;	vrshr.u16	q6, q10, #8
	DCD	0xf398e276 ;	vrshr.u16	q7, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3cce424 ;	vraddhn.i16	d30, q6, q10
	DCD	0xf3cef426 ;	vraddhn.i16	d31, q7, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	5754 <pixman_composite_over_n_8_8888_asm_neon+0x3ec>
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	5760 <pixman_composite_over_n_8_8888_asm_neon+0x3f8>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	576c <pixman_composite_over_n_8_8888_asm_neon+0x404>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00004 ;	mov	r0, r4
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0877008 ;	add	r7, r7, r8
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0477000 ;	sub	r7, r7, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff0c ;	bge	53c0 <pixman_composite_over_n_8_8888_asm_neon+0x58>
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a00001d ;	beq	5814 <pixman_composite_over_n_8_8888_asm_neon+0x4ac>
	DCD	0xf426400d ;	vld4.8	{d4-d7}, [r6]!
	DCD	0xf467870d ;	vld1.8	{d24}, [r7]!
	DCD	0xf388cc88 ;	vmull.u8	q6, d24, d8
	DCD	0xf388ec89 ;	vmull.u8	q7, d24, d9
	DCD	0xf3c80c8a ;	vmull.u8	q8, d24, d10
	DCD	0xf3c82c8b ;	vmull.u8	q9, d24, d11
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3d88270 ;	vrshr.u16	q12, q8, #8
	DCD	0xf3d8a272 ;	vrshr.u16	q13, q9, #8
	DCD	0xf38c0424 ;	vraddhn.i16	d0, q6, q10
	DCD	0xf38e1426 ;	vraddhn.i16	d1, q7, q11
	DCD	0xf38024a8 ;	vraddhn.i16	d2, q8, q12
	DCD	0xf38234aa ;	vraddhn.i16	d3, q9, q13
	DCD	0xf3f09583 ;	vmvn	d25, d3
	DCD	0xf3c90c84 ;	vmull.u8	q8, d25, d4
	DCD	0xf3c92c85 ;	vmull.u8	q9, d25, d5
	DCD	0xf3c94c86 ;	vmull.u8	q10, d25, d6
	DCD	0xf3c96c87 ;	vmull.u8	q11, d25, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf398c274 ;	vrshr.u16	q6, q10, #8
	DCD	0xf398e276 ;	vrshr.u16	q7, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3cce424 ;	vraddhn.i16	d30, q6, q10
	DCD	0xf3cef426 ;	vraddhn.i16	d31, q7, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf442c00d ;	vst4.8	{d28-d31}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00003b ;	beq	590c <pixman_composite_over_n_8_8888_asm_neon+0x5a4>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000004 ;	beq	5838 <pixman_composite_over_n_8_8888_asm_neon+0x4d0>
	DCD	0xf4e7808d ;	vld1.8	{d24[4]}, [r7]!
	DCD	0xf4e780ad ;	vld1.8	{d24[5]}, [r7]!
	DCD	0xf4e780cd ;	vld1.8	{d24[6]}, [r7]!
	DCD	0xf4e780ed ;	vld1.8	{d24[7]}, [r7]!
	DCD	0xf4266a8d ;	vld1.32	{d6-d7}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000002 ;	beq	584c <pixman_composite_over_n_8_8888_asm_neon+0x4e4>
	DCD	0xf4e7804d ;	vld1.8	{d24[2]}, [r7]!
	DCD	0xf4e7806d ;	vld1.8	{d24[3]}, [r7]!
	DCD	0xf426578d ;	vld1.32	{d5}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	585c <pixman_composite_over_n_8_8888_asm_neon+0x4f4>
	DCD	0xf4e7802d ;	vld1.8	{d24[1]}, [r7]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf388cc88 ;	vmull.u8	q6, d24, d8
	DCD	0xf388ec89 ;	vmull.u8	q7, d24, d9
	DCD	0xf3c80c8a ;	vmull.u8	q8, d24, d10
	DCD	0xf3c82c8b ;	vmull.u8	q9, d24, d11
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3d88270 ;	vrshr.u16	q12, q8, #8
	DCD	0xf3d8a272 ;	vrshr.u16	q13, q9, #8
	DCD	0xf38c0424 ;	vraddhn.i16	d0, q6, q10
	DCD	0xf38e1426 ;	vraddhn.i16	d1, q7, q11
	DCD	0xf38024a8 ;	vraddhn.i16	d2, q8, q12
	DCD	0xf38234aa ;	vraddhn.i16	d3, q9, q13
	DCD	0xf3f09583 ;	vmvn	d25, d3
	DCD	0xf3c90c84 ;	vmull.u8	q8, d25, d4
	DCD	0xf3c92c85 ;	vmull.u8	q9, d25, d5
	DCD	0xf3c94c86 ;	vmull.u8	q10, d25, d6
	DCD	0xf3c96c87 ;	vmull.u8	q11, d25, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf398c274 ;	vrshr.u16	q6, q10, #8
	DCD	0xf398e276 ;	vrshr.u16	q7, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3cce424 ;	vraddhn.i16	d30, q6, q10
	DCD	0xf3cef426 ;	vraddhn.i16	d31, q7, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	58f4 <pixman_composite_over_n_8_8888_asm_neon+0x58c>
	DCD	0xf442ea8d ;	vst1.32	{d30-d31}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	5900 <pixman_composite_over_n_8_8888_asm_neon+0x598>
	DCD	0xf442d78d ;	vst1.32	{d29}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	590c <pixman_composite_over_n_8_8888_asm_neon+0x5a4>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00004 ;	mov	r0, r4
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0877008 ;	add	r7, r7, r8
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0477000 ;	sub	r7, r7, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff99 ;	bge	5794 <pixman_composite_over_n_8_8888_asm_neon+0x42c>
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_over_n_8_8888_asm_neon|

|pixman_composite_over_n_8_8_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d7030 ;	ldr	r7, [sp, #48]	; 0x30
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d8034 ;	ldr	r8, [sp, #52]	; 0x34
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xe28d5028 ;	add	r5, sp, #40	; 0x28
	DCD	0xed2d8b10 ;	vpush	{d8-d15}
	DCD	0xf4a5880f ;	vld1.32	{d8[0]}, [r5]
	DCD	0xf3b78c08 ;	vdup.8	d8, d8[3]
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a04000 ;	mov	r4, r0
	DCD	0xba000192 ;	blt	5fc4 <pixman_composite_over_n_8_8_asm_neon+0x690>
	DCD	0xe3500040 ;	cmp	r0, #64	; 0x40
	DCD	0xba00011a ;	blt	5dec <pixman_composite_over_n_8_8_asm_neon+0x4b8>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a00005a ;	beq	5af4 <pixman_composite_over_n_8_8_asm_neon+0x1c0>
	DCD	0xe3160001 ;	tst	r6, #1
	DCD	0x0a000003 ;	beq	59a0 <pixman_composite_over_n_8_8_asm_neon+0x6c>
	DCD	0xf4e7802d ;	vld1.8	{d24[1]}, [r7]!
	DCD	0xf4a6402d ;	vld1.8	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160002 ;	tst	r6, #2
	DCD	0x0a000005 ;	beq	59c0 <pixman_composite_over_n_8_8_asm_neon+0x8c>
	DCD	0xf4e7804d ;	vld1.8	{d24[2]}, [r7]!
	DCD	0xf4e7806d ;	vld1.8	{d24[3]}, [r7]!
	DCD	0xf4a6404d ;	vld1.8	{d4[2]}, [r6]!
	DCD	0xf4a6406d ;	vld1.8	{d4[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000009 ;	beq	59f0 <pixman_composite_over_n_8_8_asm_neon+0xbc>
	DCD	0xf4e7808d ;	vld1.8	{d24[4]}, [r7]!
	DCD	0xf4e780ad ;	vld1.8	{d24[5]}, [r7]!
	DCD	0xf4e780cd ;	vld1.8	{d24[6]}, [r7]!
	DCD	0xf4e780ed ;	vld1.8	{d24[7]}, [r7]!
	DCD	0xf4a6408d ;	vld1.8	{d4[4]}, [r6]!
	DCD	0xf4a640ad ;	vld1.8	{d4[5]}, [r6]!
	DCD	0xf4a640cd ;	vld1.8	{d4[6]}, [r6]!
	DCD	0xf4a640ed ;	vld1.8	{d4[7]}, [r6]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000003 ;	beq	5a08 <pixman_composite_over_n_8_8_asm_neon+0xd4>
	DCD	0xf467970d ;	vld1.8	{d25}, [r7]!
	DCD	0xf426571d ;	vld1.8	{d5}, [r6 :64]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe2400008 ;	sub	r0, r0, #8
	DCD	0xf467aa0d ;	vld1.8	{d26-d27}, [r7]!
	DCD	0xf4266a2d ;	vld1.8	{d6-d7}, [r6 :128]!
	DCD	0xe28aa010 ;	add	sl, sl, #16
	DCD	0xe2400010 ;	sub	r0, r0, #16
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3892c88 ;	vmull.u8	q1, d25, d8
	DCD	0xf38acc88 ;	vmull.u8	q6, d26, d8
	DCD	0xf38bec88 ;	vmull.u8	q7, d27, d8
	DCD	0xf3d84250 ;	vrshr.u16	q10, q0, #8
	DCD	0xf3d86252 ;	vrshr.u16	q11, q1, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8a25e ;	vrshr.u16	q13, q7, #8
	DCD	0xf3800424 ;	vraddhn.i16	d0, q0, q10
	DCD	0xf3821426 ;	vraddhn.i16	d1, q1, q11
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38e342a ;	vraddhn.i16	d3, q7, q13
	DCD	0xf3f085c0 ;	vmvn	q12, q0
	DCD	0xf3f0a5c2 ;	vmvn	q13, q1
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c92c85 ;	vmull.u8	q9, d25, d5
	DCD	0xf3ca4c86 ;	vmull.u8	q10, d26, d6
	DCD	0xf3cb6c87 ;	vmull.u8	q11, d27, d7
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa020 ;	addne	sl, sl, #32
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7dcf00a ;	pld	[ip, sl]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc5003 ;	ldrbge	r5, [ip, r3]!
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xe3120001 ;	tst	r2, #1
	DCD	0x0a000000 ;	beq	5abc <pixman_composite_over_n_8_8_asm_neon+0x188>
	DCD	0xf4c2c02d ;	vst1.8	{d28[1]}, [r2]!
	DCD	0xe3120002 ;	tst	r2, #2
	DCD	0x0a000001 ;	beq	5acc <pixman_composite_over_n_8_8_asm_neon+0x198>
	DCD	0xf4c2c04d ;	vst1.8	{d28[2]}, [r2]!
	DCD	0xf4c2c06d ;	vst1.8	{d28[3]}, [r2]!
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000003 ;	beq	5ae4 <pixman_composite_over_n_8_8_asm_neon+0x1b0>
	DCD	0xf4c2c08d ;	vst1.8	{d28[4]}, [r2]!
	DCD	0xf4c2c0ad ;	vst1.8	{d28[5]}, [r2]!
	DCD	0xf4c2c0cd ;	vst1.8	{d28[6]}, [r2]!
	DCD	0xf4c2c0ed ;	vst1.8	{d28[7]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	5af0 <pixman_composite_over_n_8_8_asm_neon+0x1bc>
	DCD	0xf442d71d ;	vst1.8	{d29}, [r2 :64]!
	DCD	0xf442ea2d ;	vst1.8	{d30-d31}, [r2 :128]!
	DCD	0xf426422d ;	vld1.8	{d4-d7}, [r6 :128]!
	DCD	0xf467820d ;	vld1.8	{d24-d27}, [r7]!
	DCD	0xe28aa020 ;	add	sl, sl, #32
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3892c88 ;	vmull.u8	q1, d25, d8
	DCD	0xf38acc88 ;	vmull.u8	q6, d26, d8
	DCD	0xf38bec88 ;	vmull.u8	q7, d27, d8
	DCD	0xf3d84250 ;	vrshr.u16	q10, q0, #8
	DCD	0xf3d86252 ;	vrshr.u16	q11, q1, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8a25e ;	vrshr.u16	q13, q7, #8
	DCD	0xf3800424 ;	vraddhn.i16	d0, q0, q10
	DCD	0xf3821426 ;	vraddhn.i16	d1, q1, q11
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38e342a ;	vraddhn.i16	d3, q7, q13
	DCD	0xf3f085c0 ;	vmvn	q12, q0
	DCD	0xf3f0a5c2 ;	vmvn	q13, q1
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c92c85 ;	vmull.u8	q9, d25, d5
	DCD	0xf3ca4c86 ;	vmull.u8	q10, d26, d6
	DCD	0xf3cb6c87 ;	vmull.u8	q11, d27, d7
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa020 ;	addne	sl, sl, #32
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7dcf00a ;	pld	[ip, sl]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc5003 ;	ldrbge	r5, [ip, r3]!
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xe2500040 ;	subs	r0, r0, #64	; 0x40
	DCD	0xba00002b ;	blt	5c28 <pixman_composite_over_n_8_8_asm_neon+0x2f4>
	DCD	0xf426422d ;	vld1.8	{d4-d7}, [r6 :128]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf467820d ;	vld1.8	{d24-d27}, [r7]!
	DCD	0xe28aa020 ;	add	sl, sl, #32
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa020 ;	addne	sl, sl, #32
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7dcf00a ;	pld	[ip, sl]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc5003 ;	ldrbge	r5, [ip, r3]!
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xf442c22d ;	vst1.8	{d28-d31}, [r2 :128]!
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3892c88 ;	vmull.u8	q1, d25, d8
	DCD	0xf38acc88 ;	vmull.u8	q6, d26, d8
	DCD	0xf38bec88 ;	vmull.u8	q7, d27, d8
	DCD	0xf3d84250 ;	vrshr.u16	q10, q0, #8
	DCD	0xf3d86252 ;	vrshr.u16	q11, q1, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8a25e ;	vrshr.u16	q13, q7, #8
	DCD	0xf3800424 ;	vraddhn.i16	d0, q0, q10
	DCD	0xf3821426 ;	vraddhn.i16	d1, q1, q11
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38e342a ;	vraddhn.i16	d3, q7, q13
	DCD	0xf3f085c0 ;	vmvn	q12, q0
	DCD	0xf3f0a5c2 ;	vmvn	q13, q1
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c92c85 ;	vmull.u8	q9, d25, d5
	DCD	0xf3ca4c86 ;	vmull.u8	q10, d26, d6
	DCD	0xf3cb6c87 ;	vmull.u8	q11, d27, d7
	DCD	0xe2500020 ;	subs	r0, r0, #32
	DCD	0xaaffffd3 ;	bge	5b78 <pixman_composite_over_n_8_8_asm_neon+0x244>
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf442c22d ;	vst1.8	{d28-d31}, [r2 :128]!
	DCD	0xe310001f ;	tst	r0, #31
	DCD	0x0a000059 ;	beq	5dc4 <pixman_composite_over_n_8_8_asm_neon+0x490>
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000002 ;	beq	5c70 <pixman_composite_over_n_8_8_asm_neon+0x33c>
	DCD	0xf467aa0d ;	vld1.8	{d26-d27}, [r7]!
	DCD	0xf4266a2d ;	vld1.8	{d6-d7}, [r6 :128]!
	DCD	0xe28aa010 ;	add	sl, sl, #16
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000002 ;	beq	5c84 <pixman_composite_over_n_8_8_asm_neon+0x350>
	DCD	0xf467970d ;	vld1.8	{d25}, [r7]!
	DCD	0xf426571d ;	vld1.8	{d5}, [r6 :64]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000008 ;	beq	5cb0 <pixman_composite_over_n_8_8_asm_neon+0x37c>
	DCD	0xf4e7808d ;	vld1.8	{d24[4]}, [r7]!
	DCD	0xf4e780ad ;	vld1.8	{d24[5]}, [r7]!
	DCD	0xf4e780cd ;	vld1.8	{d24[6]}, [r7]!
	DCD	0xf4e780ed ;	vld1.8	{d24[7]}, [r7]!
	DCD	0xf4a6408d ;	vld1.8	{d4[4]}, [r6]!
	DCD	0xf4a640ad ;	vld1.8	{d4[5]}, [r6]!
	DCD	0xf4a640cd ;	vld1.8	{d4[6]}, [r6]!
	DCD	0xf4a640ed ;	vld1.8	{d4[7]}, [r6]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000004 ;	beq	5ccc <pixman_composite_over_n_8_8_asm_neon+0x398>
	DCD	0xf4e7804d ;	vld1.8	{d24[2]}, [r7]!
	DCD	0xf4e7806d ;	vld1.8	{d24[3]}, [r7]!
	DCD	0xf4a6404d ;	vld1.8	{d4[2]}, [r6]!
	DCD	0xf4a6406d ;	vld1.8	{d4[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	5ce0 <pixman_composite_over_n_8_8_asm_neon+0x3ac>
	DCD	0xf4e7802d ;	vld1.8	{d24[1]}, [r7]!
	DCD	0xf4a6402d ;	vld1.8	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3892c88 ;	vmull.u8	q1, d25, d8
	DCD	0xf38acc88 ;	vmull.u8	q6, d26, d8
	DCD	0xf38bec88 ;	vmull.u8	q7, d27, d8
	DCD	0xf3d84250 ;	vrshr.u16	q10, q0, #8
	DCD	0xf3d86252 ;	vrshr.u16	q11, q1, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8a25e ;	vrshr.u16	q13, q7, #8
	DCD	0xf3800424 ;	vraddhn.i16	d0, q0, q10
	DCD	0xf3821426 ;	vraddhn.i16	d1, q1, q11
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38e342a ;	vraddhn.i16	d3, q7, q13
	DCD	0xf3f085c0 ;	vmvn	q12, q0
	DCD	0xf3f0a5c2 ;	vmvn	q13, q1
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c92c85 ;	vmull.u8	q9, d25, d5
	DCD	0xf3ca4c86 ;	vmull.u8	q10, d26, d6
	DCD	0xf3cb6c87 ;	vmull.u8	q11, d27, d7
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa020 ;	addne	sl, sl, #32
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7dcf00a ;	pld	[ip, sl]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc5003 ;	ldrbge	r5, [ip, r3]!
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000000 ;	beq	5d84 <pixman_composite_over_n_8_8_asm_neon+0x450>
	DCD	0xf442ea2d ;	vst1.8	{d30-d31}, [r2 :128]!
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000000 ;	beq	5d90 <pixman_composite_over_n_8_8_asm_neon+0x45c>
	DCD	0xf442d71d ;	vst1.8	{d29}, [r2 :64]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000003 ;	beq	5da8 <pixman_composite_over_n_8_8_asm_neon+0x474>
	DCD	0xf4c2c08d ;	vst1.8	{d28[4]}, [r2]!
	DCD	0xf4c2c0ad ;	vst1.8	{d28[5]}, [r2]!
	DCD	0xf4c2c0cd ;	vst1.8	{d28[6]}, [r2]!
	DCD	0xf4c2c0ed ;	vst1.8	{d28[7]}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	5db8 <pixman_composite_over_n_8_8_asm_neon+0x484>
	DCD	0xf4c2c04d ;	vst1.8	{d28[2]}, [r2]!
	DCD	0xf4c2c06d ;	vst1.8	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	5dc4 <pixman_composite_over_n_8_8_asm_neon+0x490>
	DCD	0xf4c2c02d ;	vst1.8	{d28[1]}, [r2]!
	DCD	0xe1a00004 ;	mov	r0, r4
	DCD	0xe0822003 ;	add	r2, r2, r3
	DCD	0xe0877008 ;	add	r7, r7, r8
	DCD	0xe0422000 ;	sub	r2, r2, r0
	DCD	0xe0477000 ;	sub	r7, r7, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaafffee6 ;	bge	5980 <pixman_composite_over_n_8_8_asm_neon+0x4c>
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100020 ;	tst	r0, #32
	DCD	0x0a00001e ;	beq	5e70 <pixman_composite_over_n_8_8_asm_neon+0x53c>
	DCD	0xf426420d ;	vld1.8	{d4-d7}, [r6]!
	DCD	0xf467820d ;	vld1.8	{d24-d27}, [r7]!
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3892c88 ;	vmull.u8	q1, d25, d8
	DCD	0xf38acc88 ;	vmull.u8	q6, d26, d8
	DCD	0xf38bec88 ;	vmull.u8	q7, d27, d8
	DCD	0xf3d84250 ;	vrshr.u16	q10, q0, #8
	DCD	0xf3d86252 ;	vrshr.u16	q11, q1, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8a25e ;	vrshr.u16	q13, q7, #8
	DCD	0xf3800424 ;	vraddhn.i16	d0, q0, q10
	DCD	0xf3821426 ;	vraddhn.i16	d1, q1, q11
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38e342a ;	vraddhn.i16	d3, q7, q13
	DCD	0xf3f085c0 ;	vmvn	q12, q0
	DCD	0xf3f0a5c2 ;	vmvn	q13, q1
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c92c85 ;	vmull.u8	q9, d25, d5
	DCD	0xf3ca4c86 ;	vmull.u8	q10, d26, d6
	DCD	0xf3cb6c87 ;	vmull.u8	q11, d27, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf442c20d ;	vst1.8	{d28-d31}, [r2]!
	DCD	0xe310001f ;	tst	r0, #31
	DCD	0x0a00004a ;	beq	5fa4 <pixman_composite_over_n_8_8_asm_neon+0x670>
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000001 ;	beq	5e88 <pixman_composite_over_n_8_8_asm_neon+0x554>
	DCD	0xf467aa0d ;	vld1.8	{d26-d27}, [r7]!
	DCD	0xf4266a0d ;	vld1.8	{d6-d7}, [r6]!
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000001 ;	beq	5e98 <pixman_composite_over_n_8_8_asm_neon+0x564>
	DCD	0xf467970d ;	vld1.8	{d25}, [r7]!
	DCD	0xf426570d ;	vld1.8	{d5}, [r6]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000007 ;	beq	5ec0 <pixman_composite_over_n_8_8_asm_neon+0x58c>
	DCD	0xf4e7808d ;	vld1.8	{d24[4]}, [r7]!
	DCD	0xf4e780ad ;	vld1.8	{d24[5]}, [r7]!
	DCD	0xf4e780cd ;	vld1.8	{d24[6]}, [r7]!
	DCD	0xf4e780ed ;	vld1.8	{d24[7]}, [r7]!
	DCD	0xf4a6408d ;	vld1.8	{d4[4]}, [r6]!
	DCD	0xf4a640ad ;	vld1.8	{d4[5]}, [r6]!
	DCD	0xf4a640cd ;	vld1.8	{d4[6]}, [r6]!
	DCD	0xf4a640ed ;	vld1.8	{d4[7]}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000003 ;	beq	5ed8 <pixman_composite_over_n_8_8_asm_neon+0x5a4>
	DCD	0xf4e7804d ;	vld1.8	{d24[2]}, [r7]!
	DCD	0xf4e7806d ;	vld1.8	{d24[3]}, [r7]!
	DCD	0xf4a6404d ;	vld1.8	{d4[2]}, [r6]!
	DCD	0xf4a6406d ;	vld1.8	{d4[3]}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	5ee8 <pixman_composite_over_n_8_8_asm_neon+0x5b4>
	DCD	0xf4e7802d ;	vld1.8	{d24[1]}, [r7]!
	DCD	0xf4a6402d ;	vld1.8	{d4[1]}, [r6]!
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3892c88 ;	vmull.u8	q1, d25, d8
	DCD	0xf38acc88 ;	vmull.u8	q6, d26, d8
	DCD	0xf38bec88 ;	vmull.u8	q7, d27, d8
	DCD	0xf3d84250 ;	vrshr.u16	q10, q0, #8
	DCD	0xf3d86252 ;	vrshr.u16	q11, q1, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8a25e ;	vrshr.u16	q13, q7, #8
	DCD	0xf3800424 ;	vraddhn.i16	d0, q0, q10
	DCD	0xf3821426 ;	vraddhn.i16	d1, q1, q11
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38e342a ;	vraddhn.i16	d3, q7, q13
	DCD	0xf3f085c0 ;	vmvn	q12, q0
	DCD	0xf3f0a5c2 ;	vmvn	q13, q1
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c92c85 ;	vmull.u8	q9, d25, d5
	DCD	0xf3ca4c86 ;	vmull.u8	q10, d26, d6
	DCD	0xf3cb6c87 ;	vmull.u8	q11, d27, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000000 ;	beq	5f64 <pixman_composite_over_n_8_8_asm_neon+0x630>
	DCD	0xf442ea0d ;	vst1.8	{d30-d31}, [r2]!
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000000 ;	beq	5f70 <pixman_composite_over_n_8_8_asm_neon+0x63c>
	DCD	0xf442d70d ;	vst1.8	{d29}, [r2]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000003 ;	beq	5f88 <pixman_composite_over_n_8_8_asm_neon+0x654>
	DCD	0xf4c2c08d ;	vst1.8	{d28[4]}, [r2]!
	DCD	0xf4c2c0ad ;	vst1.8	{d28[5]}, [r2]!
	DCD	0xf4c2c0cd ;	vst1.8	{d28[6]}, [r2]!
	DCD	0xf4c2c0ed ;	vst1.8	{d28[7]}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	5f98 <pixman_composite_over_n_8_8_asm_neon+0x664>
	DCD	0xf4c2c04d ;	vst1.8	{d28[2]}, [r2]!
	DCD	0xf4c2c06d ;	vst1.8	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	5fa4 <pixman_composite_over_n_8_8_asm_neon+0x670>
	DCD	0xf4c2c02d ;	vst1.8	{d28[1]}, [r2]!
	DCD	0xe1a00004 ;	mov	r0, r4
	DCD	0xe0822003 ;	add	r2, r2, r3
	DCD	0xe0877008 ;	add	r7, r7, r8
	DCD	0xe0422000 ;	sub	r2, r2, r0
	DCD	0xe0477000 ;	sub	r7, r7, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff89 ;	bge	5dec <pixman_composite_over_n_8_8_asm_neon+0x4b8>
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_over_n_8_8_asm_neon|

|pixman_composite_over_n_8888_8888_ca_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d7030 ;	ldr	r7, [sp, #48]	; 0x30
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d8034 ;	ldr	r8, [sp, #52]	; 0x34
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xe28d5028 ;	add	r5, sp, #40	; 0x28
	DCD	0xed2d8b10 ;	vpush	{d8-d15}
	DCD	0xf4a5b80f ;	vld1.32	{d11[0]}, [r5]
	DCD	0xf3b18c0b ;	vdup.8	d8, d11[0]
	DCD	0xf3b39c0b ;	vdup.8	d9, d11[1]
	DCD	0xf3b5ac0b ;	vdup.8	d10, d11[2]
	DCD	0xf3b7bc0b ;	vdup.8	d11, d11[3]
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a04000 ;	mov	r4, r0
	DCD	0xba00019e ;	blt	6698 <pixman_composite_over_n_8888_8888_ca_asm_neon+0x6cc>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba000120 ;	blt	64a8 <pixman_composite_over_n_8888_8888_ca_asm_neon+0x4dc>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000052 ;	beq	6178 <pixman_composite_over_n_8888_8888_ca_asm_neon+0x1ac>
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000003 ;	beq	6044 <pixman_composite_over_n_8888_8888_ca_asm_neon+0x78>
	DCD	0xf4e7888d ;	vld1.32	{d24[1]}, [r7]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000003 ;	beq	605c <pixman_composite_over_n_8888_8888_ca_asm_neon+0x90>
	DCD	0xf467978d ;	vld1.32	{d25}, [r7]!
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xf467aa8d ;	vld1.32	{d26-d27}, [r7]!
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3f28129 ;	vuzp.8	d24, d25
	DCD	0xf3f2a12b ;	vuzp.8	d26, d27
	DCD	0xf3f2912b ;	vuzp.8	d25, d27
	DCD	0xf3f2812a ;	vuzp.8	d24, d26
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3892c89 ;	vmull.u8	q1, d25, d9
	DCD	0xf38acc8a ;	vmull.u8	q6, d26, d10
	DCD	0xf38bec8b ;	vmull.u8	q7, d27, d11
	DCD	0xf3cb2c29 ;	vmull.u8	q9, d11, d25
	DCD	0xf3cb8c28 ;	vmull.u8	q12, d11, d24
	DCD	0xf3cbac2a ;	vmull.u8	q13, d11, d26
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d84252 ;	vrshr.u16	q10, q1, #8
	DCD	0xf3d8625c ;	vrshr.u16	q11, q6, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821424 ;	vraddhn.i16	d1, q1, q10
	DCD	0xf38c2426 ;	vraddhn.i16	d2, q6, q11
	DCD	0xf3d86278 ;	vrshr.u16	q11, q12, #8
	DCD	0xf3d80272 ;	vrshr.u16	q8, q9, #8
	DCD	0xf398c27a ;	vrshr.u16	q6, q13, #8
	DCD	0xf3d8425e ;	vrshr.u16	q10, q7, #8
	DCD	0xf3c884a6 ;	vraddhn.i16	d24, q12, q11
	DCD	0xf3c294a0 ;	vraddhn.i16	d25, q9, q8
	DCD	0xf3caa48c ;	vraddhn.i16	d26, q13, q6
	DCD	0xf38e3424 ;	vraddhn.i16	d3, q7, q10
	DCD	0xf3f085e8 ;	vmvn	q12, q12
	DCD	0xf3f0a5aa ;	vmvn	d26, d26
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c92c85 ;	vmull.u8	q9, d25, d5
	DCD	0xf3f0b583 ;	vmvn	d27, d3
	DCD	0xf3ca4c86 ;	vmull.u8	q10, d26, d6
	DCD	0xf3cb6c87 ;	vmull.u8	q11, d27, d7
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf7def10a ;	pld	[lr, sl, lsl #2]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc5103 ;	ldrbge	r5, [ip, r3, lsl #2]!
	DCD	0xa7fe5108 ;	ldrbge	r5, [lr, r8, lsl #2]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf398c274 ;	vrshr.u16	q6, q10, #8
	DCD	0xf398e276 ;	vrshr.u16	q7, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3cce424 ;	vraddhn.i16	d30, q6, q10
	DCD	0xf3cef426 ;	vraddhn.i16	d31, q7, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000000 ;	beq	6168 <pixman_composite_over_n_8888_8888_ca_asm_neon+0x19c>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	6174 <pixman_composite_over_n_8888_8888_ca_asm_neon+0x1a8>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xf426402d ;	vld4.8	{d4-d7}, [r6 :128]!
	DCD	0xf467800d ;	vld4.8	{d24-d27}, [r7]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3892c89 ;	vmull.u8	q1, d25, d9
	DCD	0xf38acc8a ;	vmull.u8	q6, d26, d10
	DCD	0xf38bec8b ;	vmull.u8	q7, d27, d11
	DCD	0xf3cb2c29 ;	vmull.u8	q9, d11, d25
	DCD	0xf3cb8c28 ;	vmull.u8	q12, d11, d24
	DCD	0xf3cbac2a ;	vmull.u8	q13, d11, d26
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d84252 ;	vrshr.u16	q10, q1, #8
	DCD	0xf3d8625c ;	vrshr.u16	q11, q6, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821424 ;	vraddhn.i16	d1, q1, q10
	DCD	0xf38c2426 ;	vraddhn.i16	d2, q6, q11
	DCD	0xf3d86278 ;	vrshr.u16	q11, q12, #8
	DCD	0xf3d80272 ;	vrshr.u16	q8, q9, #8
	DCD	0xf398c27a ;	vrshr.u16	q6, q13, #8
	DCD	0xf3d8425e ;	vrshr.u16	q10, q7, #8
	DCD	0xf3c884a6 ;	vraddhn.i16	d24, q12, q11
	DCD	0xf3c294a0 ;	vraddhn.i16	d25, q9, q8
	DCD	0xf3caa48c ;	vraddhn.i16	d26, q13, q6
	DCD	0xf38e3424 ;	vraddhn.i16	d3, q7, q10
	DCD	0xf3f085e8 ;	vmvn	q12, q12
	DCD	0xf3f0a5aa ;	vmvn	d26, d26
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c92c85 ;	vmull.u8	q9, d25, d5
	DCD	0xf3f0b583 ;	vmvn	d27, d3
	DCD	0xf3ca4c86 ;	vmull.u8	q10, d26, d6
	DCD	0xf3cb6c87 ;	vmull.u8	q11, d27, d7
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf7def10a ;	pld	[lr, sl, lsl #2]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc5103 ;	ldrbge	r5, [ip, r3, lsl #2]!
	DCD	0xa7fe5108 ;	ldrbge	r5, [lr, r8, lsl #2]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba000035 ;	blt	62fc <pixman_composite_over_n_8888_8888_ca_asm_neon+0x330>
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf426402d ;	vld4.8	{d4-d7}, [r6 :128]!
	DCD	0xf398c274 ;	vrshr.u16	q6, q10, #8
	DCD	0xf398e276 ;	vrshr.u16	q7, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3cce424 ;	vraddhn.i16	d30, q6, q10
	DCD	0xf3cef426 ;	vraddhn.i16	d31, q7, q11
	DCD	0xf467800d ;	vld4.8	{d24-d27}, [r7]!
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf7def10a ;	pld	[lr, sl, lsl #2]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc5103 ;	ldrbge	r5, [ip, r3, lsl #2]!
	DCD	0xa7fe5108 ;	ldrbge	r5, [lr, r8, lsl #2]!
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3892c89 ;	vmull.u8	q1, d25, d9
	DCD	0xf38acc8a ;	vmull.u8	q6, d26, d10
	DCD	0xf38bec8b ;	vmull.u8	q7, d27, d11
	DCD	0xf3cb2c29 ;	vmull.u8	q9, d11, d25
	DCD	0xf3cb8c28 ;	vmull.u8	q12, d11, d24
	DCD	0xf3cbac2a ;	vmull.u8	q13, d11, d26
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d84252 ;	vrshr.u16	q10, q1, #8
	DCD	0xf3d8625c ;	vrshr.u16	q11, q6, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821424 ;	vraddhn.i16	d1, q1, q10
	DCD	0xf38c2426 ;	vraddhn.i16	d2, q6, q11
	DCD	0xf3d86278 ;	vrshr.u16	q11, q12, #8
	DCD	0xf3d80272 ;	vrshr.u16	q8, q9, #8
	DCD	0xf398c27a ;	vrshr.u16	q6, q13, #8
	DCD	0xf3d8425e ;	vrshr.u16	q10, q7, #8
	DCD	0xf3c884a6 ;	vraddhn.i16	d24, q12, q11
	DCD	0xf3c294a0 ;	vraddhn.i16	d25, q9, q8
	DCD	0xf3caa48c ;	vraddhn.i16	d26, q13, q6
	DCD	0xf38e3424 ;	vraddhn.i16	d3, q7, q10
	DCD	0xf3f085e8 ;	vmvn	q12, q12
	DCD	0xf3f0a5aa ;	vmvn	d26, d26
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c92c85 ;	vmull.u8	q9, d25, d5
	DCD	0xf3f0b583 ;	vmvn	d27, d3
	DCD	0xf3ca4c86 ;	vmull.u8	q10, d26, d6
	DCD	0xf3cb6c87 ;	vmull.u8	q11, d27, d7
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffc9 ;	bge	6224 <pixman_composite_over_n_8888_8888_ca_asm_neon+0x258>
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf398c274 ;	vrshr.u16	q6, q10, #8
	DCD	0xf398e276 ;	vrshr.u16	q7, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3cce424 ;	vraddhn.i16	d30, q6, q10
	DCD	0xf3cef426 ;	vraddhn.i16	d31, q7, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000053 ;	beq	6480 <pixman_composite_over_n_8888_8888_ca_asm_neon+0x4b4>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000002 ;	beq	6344 <pixman_composite_over_n_8888_8888_ca_asm_neon+0x378>
	DCD	0xf467aa8d ;	vld1.32	{d26-d27}, [r7]!
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000002 ;	beq	6358 <pixman_composite_over_n_8888_8888_ca_asm_neon+0x38c>
	DCD	0xf467978d ;	vld1.32	{d25}, [r7]!
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	636c <pixman_composite_over_n_8888_8888_ca_asm_neon+0x3a0>
	DCD	0xf4e7888d ;	vld1.32	{d24[1]}, [r7]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf3f28129 ;	vuzp.8	d24, d25
	DCD	0xf3f2a12b ;	vuzp.8	d26, d27
	DCD	0xf3f2912b ;	vuzp.8	d25, d27
	DCD	0xf3f2812a ;	vuzp.8	d24, d26
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3892c89 ;	vmull.u8	q1, d25, d9
	DCD	0xf38acc8a ;	vmull.u8	q6, d26, d10
	DCD	0xf38bec8b ;	vmull.u8	q7, d27, d11
	DCD	0xf3cb2c29 ;	vmull.u8	q9, d11, d25
	DCD	0xf3cb8c28 ;	vmull.u8	q12, d11, d24
	DCD	0xf3cbac2a ;	vmull.u8	q13, d11, d26
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d84252 ;	vrshr.u16	q10, q1, #8
	DCD	0xf3d8625c ;	vrshr.u16	q11, q6, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821424 ;	vraddhn.i16	d1, q1, q10
	DCD	0xf38c2426 ;	vraddhn.i16	d2, q6, q11
	DCD	0xf3d86278 ;	vrshr.u16	q11, q12, #8
	DCD	0xf3d80272 ;	vrshr.u16	q8, q9, #8
	DCD	0xf398c27a ;	vrshr.u16	q6, q13, #8
	DCD	0xf3d8425e ;	vrshr.u16	q10, q7, #8
	DCD	0xf3c884a6 ;	vraddhn.i16	d24, q12, q11
	DCD	0xf3c294a0 ;	vraddhn.i16	d25, q9, q8
	DCD	0xf3caa48c ;	vraddhn.i16	d26, q13, q6
	DCD	0xf38e3424 ;	vraddhn.i16	d3, q7, q10
	DCD	0xf3f085e8 ;	vmvn	q12, q12
	DCD	0xf3f0a5aa ;	vmvn	d26, d26
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c92c85 ;	vmull.u8	q9, d25, d5
	DCD	0xf3f0b583 ;	vmvn	d27, d3
	DCD	0xf3ca4c86 ;	vmull.u8	q10, d26, d6
	DCD	0xf3cb6c87 ;	vmull.u8	q11, d27, d7
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf7def10a ;	pld	[lr, sl, lsl #2]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc5103 ;	ldrbge	r5, [ip, r3, lsl #2]!
	DCD	0xa7fe5108 ;	ldrbge	r5, [lr, r8, lsl #2]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf398c274 ;	vrshr.u16	q6, q10, #8
	DCD	0xf398e276 ;	vrshr.u16	q7, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3cce424 ;	vraddhn.i16	d30, q6, q10
	DCD	0xf3cef426 ;	vraddhn.i16	d31, q7, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	6468 <pixman_composite_over_n_8888_8888_ca_asm_neon+0x49c>
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	6474 <pixman_composite_over_n_8888_8888_ca_asm_neon+0x4a8>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	6480 <pixman_composite_over_n_8888_8888_ca_asm_neon+0x4b4>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00004 ;	mov	r0, r4
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0877108 ;	add	r7, r7, r8, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0477100 ;	sub	r7, r7, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaafffee0 ;	bge	6024 <pixman_composite_over_n_8888_8888_ca_asm_neon+0x58>
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000028 ;	beq	6554 <pixman_composite_over_n_8888_8888_ca_asm_neon+0x588>
	DCD	0xf426400d ;	vld4.8	{d4-d7}, [r6]!
	DCD	0xf467800d ;	vld4.8	{d24-d27}, [r7]!
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3892c89 ;	vmull.u8	q1, d25, d9
	DCD	0xf38acc8a ;	vmull.u8	q6, d26, d10
	DCD	0xf38bec8b ;	vmull.u8	q7, d27, d11
	DCD	0xf3cb2c29 ;	vmull.u8	q9, d11, d25
	DCD	0xf3cb8c28 ;	vmull.u8	q12, d11, d24
	DCD	0xf3cbac2a ;	vmull.u8	q13, d11, d26
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d84252 ;	vrshr.u16	q10, q1, #8
	DCD	0xf3d8625c ;	vrshr.u16	q11, q6, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821424 ;	vraddhn.i16	d1, q1, q10
	DCD	0xf38c2426 ;	vraddhn.i16	d2, q6, q11
	DCD	0xf3d86278 ;	vrshr.u16	q11, q12, #8
	DCD	0xf3d80272 ;	vrshr.u16	q8, q9, #8
	DCD	0xf398c27a ;	vrshr.u16	q6, q13, #8
	DCD	0xf3d8425e ;	vrshr.u16	q10, q7, #8
	DCD	0xf3c884a6 ;	vraddhn.i16	d24, q12, q11
	DCD	0xf3c294a0 ;	vraddhn.i16	d25, q9, q8
	DCD	0xf3caa48c ;	vraddhn.i16	d26, q13, q6
	DCD	0xf38e3424 ;	vraddhn.i16	d3, q7, q10
	DCD	0xf3f085e8 ;	vmvn	q12, q12
	DCD	0xf3f0a5aa ;	vmvn	d26, d26
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c92c85 ;	vmull.u8	q9, d25, d5
	DCD	0xf3f0b583 ;	vmvn	d27, d3
	DCD	0xf3ca4c86 ;	vmull.u8	q10, d26, d6
	DCD	0xf3cb6c87 ;	vmull.u8	q11, d27, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf398c274 ;	vrshr.u16	q6, q10, #8
	DCD	0xf398e276 ;	vrshr.u16	q7, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3cce424 ;	vraddhn.i16	d30, q6, q10
	DCD	0xf3cef426 ;	vraddhn.i16	d31, q7, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf442c00d ;	vst4.8	{d28-d31}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000046 ;	beq	6678 <pixman_composite_over_n_8888_8888_ca_asm_neon+0x6ac>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000001 ;	beq	656c <pixman_composite_over_n_8888_8888_ca_asm_neon+0x5a0>
	DCD	0xf467aa8d ;	vld1.32	{d26-d27}, [r7]!
	DCD	0xf4266a8d ;	vld1.32	{d6-d7}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	657c <pixman_composite_over_n_8888_8888_ca_asm_neon+0x5b0>
	DCD	0xf467978d ;	vld1.32	{d25}, [r7]!
	DCD	0xf426578d ;	vld1.32	{d5}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	658c <pixman_composite_over_n_8888_8888_ca_asm_neon+0x5c0>
	DCD	0xf4e7888d ;	vld1.32	{d24[1]}, [r7]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xf3f28129 ;	vuzp.8	d24, d25
	DCD	0xf3f2a12b ;	vuzp.8	d26, d27
	DCD	0xf3f2912b ;	vuzp.8	d25, d27
	DCD	0xf3f2812a ;	vuzp.8	d24, d26
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3892c89 ;	vmull.u8	q1, d25, d9
	DCD	0xf38acc8a ;	vmull.u8	q6, d26, d10
	DCD	0xf38bec8b ;	vmull.u8	q7, d27, d11
	DCD	0xf3cb2c29 ;	vmull.u8	q9, d11, d25
	DCD	0xf3cb8c28 ;	vmull.u8	q12, d11, d24
	DCD	0xf3cbac2a ;	vmull.u8	q13, d11, d26
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d84252 ;	vrshr.u16	q10, q1, #8
	DCD	0xf3d8625c ;	vrshr.u16	q11, q6, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821424 ;	vraddhn.i16	d1, q1, q10
	DCD	0xf38c2426 ;	vraddhn.i16	d2, q6, q11
	DCD	0xf3d86278 ;	vrshr.u16	q11, q12, #8
	DCD	0xf3d80272 ;	vrshr.u16	q8, q9, #8
	DCD	0xf398c27a ;	vrshr.u16	q6, q13, #8
	DCD	0xf3d8425e ;	vrshr.u16	q10, q7, #8
	DCD	0xf3c884a6 ;	vraddhn.i16	d24, q12, q11
	DCD	0xf3c294a0 ;	vraddhn.i16	d25, q9, q8
	DCD	0xf3caa48c ;	vraddhn.i16	d26, q13, q6
	DCD	0xf38e3424 ;	vraddhn.i16	d3, q7, q10
	DCD	0xf3f085e8 ;	vmvn	q12, q12
	DCD	0xf3f0a5aa ;	vmvn	d26, d26
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c92c85 ;	vmull.u8	q9, d25, d5
	DCD	0xf3f0b583 ;	vmvn	d27, d3
	DCD	0xf3ca4c86 ;	vmull.u8	q10, d26, d6
	DCD	0xf3cb6c87 ;	vmull.u8	q11, d27, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf398c274 ;	vrshr.u16	q6, q10, #8
	DCD	0xf398e276 ;	vrshr.u16	q7, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3cce424 ;	vraddhn.i16	d30, q6, q10
	DCD	0xf3cef426 ;	vraddhn.i16	d31, q7, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	6660 <pixman_composite_over_n_8888_8888_ca_asm_neon+0x694>
	DCD	0xf442ea8d ;	vst1.32	{d30-d31}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	666c <pixman_composite_over_n_8888_8888_ca_asm_neon+0x6a0>
	DCD	0xf442d78d ;	vst1.32	{d29}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	6678 <pixman_composite_over_n_8888_8888_ca_asm_neon+0x6ac>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00004 ;	mov	r0, r4
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0877108 ;	add	r7, r7, r8, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0477100 ;	sub	r7, r7, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff83 ;	bge	64a8 <pixman_composite_over_n_8888_8888_ca_asm_neon+0x4dc>
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_over_n_8888_8888_ca_asm_neon|

|pixman_composite_over_n_8888_0565_ca_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d7030 ;	ldr	r7, [sp, #48]	; 0x30
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d8034 ;	ldr	r8, [sp, #52]	; 0x34
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xe28d5028 ;	add	r5, sp, #40	; 0x28
	DCD	0xed2d8b10 ;	vpush	{d8-d15}
	DCD	0xf4a5b80f ;	vld1.32	{d11[0]}, [r5]
	DCD	0xf3b18c0b ;	vdup.8	d8, d11[0]
	DCD	0xf3b39c0b ;	vdup.8	d9, d11[1]
	DCD	0xf3b5ac0b ;	vdup.8	d10, d11[2]
	DCD	0xf3b7bc0b ;	vdup.8	d11, d11[3]
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a04000 ;	mov	r4, r0
	DCD	0xba0001a8 ;	blt	6d94 <pixman_composite_over_n_8888_0565_ca_asm_neon+0x6f4>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba000128 ;	blt	6b9c <pixman_composite_over_n_8888_0565_ca_asm_neon+0x4fc>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000054 ;	beq	6854 <pixman_composite_over_n_8888_0565_ca_asm_neon+0x1b4>
	DCD	0xe3160002 ;	tst	r6, #2
	DCD	0x0a000003 ;	beq	6718 <pixman_composite_over_n_8888_0565_ca_asm_neon+0x78>
	DCD	0xf4e7888d ;	vld1.32	{d24[1]}, [r7]!
	DCD	0xf4a6444d ;	vld1.16	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000004 ;	beq	6734 <pixman_composite_over_n_8888_0565_ca_asm_neon+0x94>
	DCD	0xf467978d ;	vld1.32	{d25}, [r7]!
	DCD	0xf4a6448d ;	vld1.16	{d4[2]}, [r6]!
	DCD	0xf4a644cd ;	vld1.16	{d4[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000003 ;	beq	674c <pixman_composite_over_n_8888_0565_ca_asm_neon+0xac>
	DCD	0xf467aa8d ;	vld1.32	{d26-d27}, [r7]!
	DCD	0xf426575d ;	vld1.16	{d5}, [r6 :64]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3f28129 ;	vuzp.8	d24, d25
	DCD	0xf3f2a12b ;	vuzp.8	d26, d27
	DCD	0xf3f2912b ;	vuzp.8	d25, d27
	DCD	0xf3f2812a ;	vuzp.8	d24, d26
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3892c89 ;	vmull.u8	q1, d25, d9
	DCD	0xf38acc8a ;	vmull.u8	q6, d26, d10
	DCD	0xf3cb2c29 ;	vmull.u8	q9, d11, d25
	DCD	0xf3cb8c28 ;	vmull.u8	q12, d11, d24
	DCD	0xf3cbac2a ;	vmull.u8	q13, d11, d26
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d84252 ;	vrshr.u16	q10, q1, #8
	DCD	0xf3d8625c ;	vrshr.u16	q11, q6, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821424 ;	vraddhn.i16	d1, q1, q10
	DCD	0xf38c2426 ;	vraddhn.i16	d2, q6, q11
	DCD	0xf3d86278 ;	vrshr.u16	q11, q12, #8
	DCD	0xf3d80272 ;	vrshr.u16	q8, q9, #8
	DCD	0xf398c27a ;	vrshr.u16	q6, q13, #8
	DCD	0xf3c884a6 ;	vraddhn.i16	d24, q12, q11
	DCD	0xf3c294a0 ;	vraddhn.i16	d25, q9, q8
	DCD	0xf2cd1814 ;	vshrn.i16	d17, q2, #3
	DCD	0xf2c82814 ;	vshrn.i16	d18, q2, #8
	DCD	0xf3caa48c ;	vraddhn.i16	d26, q13, q6
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3cb2432 ;	vsri.8	d18, d18, #5
	DCD	0xf3ca1431 ;	vsri.8	d17, d17, #6
	DCD	0xf3f085e8 ;	vmvn	q12, q12
	DCD	0xf2ce0814 ;	vshrn.i16	d16, q2, #2
	DCD	0xf3f0a5aa ;	vmvn	d26, d26
	DCD	0xf380cca8 ;	vmull.u8	q6, d16, d24
	DCD	0xf381eca9 ;	vmull.u8	q7, d17, d25
	DCD	0xf3c26caa ;	vmull.u8	q11, d18, d26
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xf7def10a ;	pld	[lr, sl, lsl #2]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc5083 ;	ldrbge	r5, [ip, r3, lsl #1]!
	DCD	0xa7fe5108 ;	ldrbge	r5, [lr, r8, lsl #2]!
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8c25e ;	vrshr.u16	q14, q7, #8
	DCD	0xf3d8e276 ;	vrshr.u16	q15, q11, #8
	DCD	0xf3c4048c ;	vraddhn.i16	d16, q10, q6
	DCD	0xf3cc148e ;	vraddhn.i16	d17, q14, q7
	DCD	0xf3ce24a6 ;	vraddhn.i16	d18, q15, q11
	DCD	0xf3400070 ;	vqadd.u8	q8, q0, q8
	DCD	0xf3422032 ;	vqadd.u8	d18, d2, d18
	DCD	0xf3f2c322 ;	vshll.i8	q14, d18, #8
	DCD	0xf3f24321 ;	vshll.i8	q10, d17, #8
	DCD	0xf3f2e320 ;	vshll.i8	q15, d16, #8
	DCD	0xf3dbc474 ;	vsri.16	q14, q10, #5
	DCD	0xf3d5c47e ;	vsri.16	q14, q15, #11
	DCD	0xe3120002 ;	tst	r2, #2
	DCD	0x0a000000 ;	beq	6838 <pixman_composite_over_n_8888_0565_ca_asm_neon+0x198>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000001 ;	beq	6848 <pixman_composite_over_n_8888_0565_ca_asm_neon+0x1a8>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	6854 <pixman_composite_over_n_8888_0565_ca_asm_neon+0x1b4>
	DCD	0xf442d75d ;	vst1.16	{d29}, [r2 :64]!
	DCD	0xf4264a6d ;	vld1.16	{d4-d5}, [r6 :128]!
	DCD	0xf467800d ;	vld4.8	{d24-d27}, [r7]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3892c89 ;	vmull.u8	q1, d25, d9
	DCD	0xf38acc8a ;	vmull.u8	q6, d26, d10
	DCD	0xf3cb2c29 ;	vmull.u8	q9, d11, d25
	DCD	0xf3cb8c28 ;	vmull.u8	q12, d11, d24
	DCD	0xf3cbac2a ;	vmull.u8	q13, d11, d26
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d84252 ;	vrshr.u16	q10, q1, #8
	DCD	0xf3d8625c ;	vrshr.u16	q11, q6, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821424 ;	vraddhn.i16	d1, q1, q10
	DCD	0xf38c2426 ;	vraddhn.i16	d2, q6, q11
	DCD	0xf3d86278 ;	vrshr.u16	q11, q12, #8
	DCD	0xf3d80272 ;	vrshr.u16	q8, q9, #8
	DCD	0xf398c27a ;	vrshr.u16	q6, q13, #8
	DCD	0xf3c884a6 ;	vraddhn.i16	d24, q12, q11
	DCD	0xf3c294a0 ;	vraddhn.i16	d25, q9, q8
	DCD	0xf2cd1814 ;	vshrn.i16	d17, q2, #3
	DCD	0xf2c82814 ;	vshrn.i16	d18, q2, #8
	DCD	0xf3caa48c ;	vraddhn.i16	d26, q13, q6
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3cb2432 ;	vsri.8	d18, d18, #5
	DCD	0xf3ca1431 ;	vsri.8	d17, d17, #6
	DCD	0xf3f085e8 ;	vmvn	q12, q12
	DCD	0xf2ce0814 ;	vshrn.i16	d16, q2, #2
	DCD	0xf3f0a5aa ;	vmvn	d26, d26
	DCD	0xf380cca8 ;	vmull.u8	q6, d16, d24
	DCD	0xf381eca9 ;	vmull.u8	q7, d17, d25
	DCD	0xf3c26caa ;	vmull.u8	q11, d18, d26
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xf7def10a ;	pld	[lr, sl, lsl #2]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc5083 ;	ldrbge	r5, [ip, r3, lsl #1]!
	DCD	0xa7fe5108 ;	ldrbge	r5, [lr, r8, lsl #2]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba000039 ;	blt	69ec <pixman_composite_over_n_8888_0565_ca_asm_neon+0x34c>
	DCD	0xf467800d ;	vld4.8	{d24-d27}, [r7]!
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8c25e ;	vrshr.u16	q14, q7, #8
	DCD	0xf4264a6d ;	vld1.16	{d4-d5}, [r6 :128]!
	DCD	0xf3d8e276 ;	vrshr.u16	q15, q11, #8
	DCD	0xf3c4048c ;	vraddhn.i16	d16, q10, q6
	DCD	0xf3cc148e ;	vraddhn.i16	d17, q14, q7
	DCD	0xf3ce64a6 ;	vraddhn.i16	d22, q15, q11
	DCD	0xf38acc8a ;	vmull.u8	q6, d26, d10
	DCD	0xf3400070 ;	vqadd.u8	q8, q0, q8
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3426036 ;	vqadd.u8	d22, d2, d22
	DCD	0xf3892c89 ;	vmull.u8	q1, d25, d9
	DCD	0xf3f2c326 ;	vshll.i8	q14, d22, #8
	DCD	0xf3f24321 ;	vshll.i8	q10, d17, #8
	DCD	0xf3f2e320 ;	vshll.i8	q15, d16, #8
	DCD	0xf3cb2c29 ;	vmull.u8	q9, d11, d25
	DCD	0xf3dbc474 ;	vsri.16	q14, q10, #5
	DCD	0xf3cb8c28 ;	vmull.u8	q12, d11, d24
	DCD	0xf3cbac2a ;	vmull.u8	q13, d11, d26
	DCD	0xf3d5c47e ;	vsri.16	q14, q15, #11
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xf7def10a ;	pld	[lr, sl, lsl #2]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc5083 ;	ldrbge	r5, [ip, r3, lsl #1]!
	DCD	0xa7fe5108 ;	ldrbge	r5, [lr, r8, lsl #2]!
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d84252 ;	vrshr.u16	q10, q1, #8
	DCD	0xf3d8625c ;	vrshr.u16	q11, q6, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821424 ;	vraddhn.i16	d1, q1, q10
	DCD	0xf38c2426 ;	vraddhn.i16	d2, q6, q11
	DCD	0xf3d86278 ;	vrshr.u16	q11, q12, #8
	DCD	0xf3d80272 ;	vrshr.u16	q8, q9, #8
	DCD	0xf398c27a ;	vrshr.u16	q6, q13, #8
	DCD	0xf3c884a6 ;	vraddhn.i16	d24, q12, q11
	DCD	0xf3c294a0 ;	vraddhn.i16	d25, q9, q8
	DCD	0xf2cd1814 ;	vshrn.i16	d17, q2, #3
	DCD	0xf2c82814 ;	vshrn.i16	d18, q2, #8
	DCD	0xf3caa48c ;	vraddhn.i16	d26, q13, q6
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3ca1431 ;	vsri.8	d17, d17, #6
	DCD	0xf3cb2432 ;	vsri.8	d18, d18, #5
	DCD	0xf3f085e8 ;	vmvn	q12, q12
	DCD	0xf2ce0814 ;	vshrn.i16	d16, q2, #2
	DCD	0xf3f0a5aa ;	vmvn	d26, d26
	DCD	0xf381eca9 ;	vmull.u8	q7, d17, d25
	DCD	0xf380cca8 ;	vmull.u8	q6, d16, d24
	DCD	0xf3c26caa ;	vmull.u8	q11, d18, d26
	DCD	0xf442ca6d ;	vst1.16	{d28-d29}, [r2 :128]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffc5 ;	bge	6904 <pixman_composite_over_n_8888_0565_ca_asm_neon+0x264>
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8c25e ;	vrshr.u16	q14, q7, #8
	DCD	0xf3d8e276 ;	vrshr.u16	q15, q11, #8
	DCD	0xf3c4048c ;	vraddhn.i16	d16, q10, q6
	DCD	0xf3cc148e ;	vraddhn.i16	d17, q14, q7
	DCD	0xf3ce24a6 ;	vraddhn.i16	d18, q15, q11
	DCD	0xf3400070 ;	vqadd.u8	q8, q0, q8
	DCD	0xf3422032 ;	vqadd.u8	d18, d2, d18
	DCD	0xf3f2c322 ;	vshll.i8	q14, d18, #8
	DCD	0xf3f24321 ;	vshll.i8	q10, d17, #8
	DCD	0xf3f2e320 ;	vshll.i8	q15, d16, #8
	DCD	0xf3dbc474 ;	vsri.16	q14, q10, #5
	DCD	0xf3d5c47e ;	vsri.16	q14, q15, #11
	DCD	0xf442ca6d ;	vst1.16	{d28-d29}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000051 ;	beq	6b74 <pixman_composite_over_n_8888_0565_ca_asm_neon+0x4d4>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000002 ;	beq	6a40 <pixman_composite_over_n_8888_0565_ca_asm_neon+0x3a0>
	DCD	0xf467aa8d ;	vld1.32	{d26-d27}, [r7]!
	DCD	0xf426575d ;	vld1.16	{d5}, [r6 :64]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000003 ;	beq	6a58 <pixman_composite_over_n_8888_0565_ca_asm_neon+0x3b8>
	DCD	0xf467978d ;	vld1.32	{d25}, [r7]!
	DCD	0xf4a6448d ;	vld1.16	{d4[2]}, [r6]!
	DCD	0xf4a644cd ;	vld1.16	{d4[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	6a6c <pixman_composite_over_n_8888_0565_ca_asm_neon+0x3cc>
	DCD	0xf4e7888d ;	vld1.32	{d24[1]}, [r7]!
	DCD	0xf4a6444d ;	vld1.16	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf3f28129 ;	vuzp.8	d24, d25
	DCD	0xf3f2a12b ;	vuzp.8	d26, d27
	DCD	0xf3f2912b ;	vuzp.8	d25, d27
	DCD	0xf3f2812a ;	vuzp.8	d24, d26
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3892c89 ;	vmull.u8	q1, d25, d9
	DCD	0xf38acc8a ;	vmull.u8	q6, d26, d10
	DCD	0xf3cb2c29 ;	vmull.u8	q9, d11, d25
	DCD	0xf3cb8c28 ;	vmull.u8	q12, d11, d24
	DCD	0xf3cbac2a ;	vmull.u8	q13, d11, d26
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d84252 ;	vrshr.u16	q10, q1, #8
	DCD	0xf3d8625c ;	vrshr.u16	q11, q6, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821424 ;	vraddhn.i16	d1, q1, q10
	DCD	0xf38c2426 ;	vraddhn.i16	d2, q6, q11
	DCD	0xf3d86278 ;	vrshr.u16	q11, q12, #8
	DCD	0xf3d80272 ;	vrshr.u16	q8, q9, #8
	DCD	0xf398c27a ;	vrshr.u16	q6, q13, #8
	DCD	0xf3c884a6 ;	vraddhn.i16	d24, q12, q11
	DCD	0xf3c294a0 ;	vraddhn.i16	d25, q9, q8
	DCD	0xf2cd1814 ;	vshrn.i16	d17, q2, #3
	DCD	0xf2c82814 ;	vshrn.i16	d18, q2, #8
	DCD	0xf3caa48c ;	vraddhn.i16	d26, q13, q6
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3cb2432 ;	vsri.8	d18, d18, #5
	DCD	0xf3ca1431 ;	vsri.8	d17, d17, #6
	DCD	0xf3f085e8 ;	vmvn	q12, q12
	DCD	0xf2ce0814 ;	vshrn.i16	d16, q2, #2
	DCD	0xf3f0a5aa ;	vmvn	d26, d26
	DCD	0xf380cca8 ;	vmull.u8	q6, d16, d24
	DCD	0xf381eca9 ;	vmull.u8	q7, d17, d25
	DCD	0xf3c26caa ;	vmull.u8	q11, d18, d26
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xf7def10a ;	pld	[lr, sl, lsl #2]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc5083 ;	ldrbge	r5, [ip, r3, lsl #1]!
	DCD	0xa7fe5108 ;	ldrbge	r5, [lr, r8, lsl #2]!
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8c25e ;	vrshr.u16	q14, q7, #8
	DCD	0xf3d8e276 ;	vrshr.u16	q15, q11, #8
	DCD	0xf3c4048c ;	vraddhn.i16	d16, q10, q6
	DCD	0xf3cc148e ;	vraddhn.i16	d17, q14, q7
	DCD	0xf3ce24a6 ;	vraddhn.i16	d18, q15, q11
	DCD	0xf3400070 ;	vqadd.u8	q8, q0, q8
	DCD	0xf3422032 ;	vqadd.u8	d18, d2, d18
	DCD	0xf3f2c322 ;	vshll.i8	q14, d18, #8
	DCD	0xf3f24321 ;	vshll.i8	q10, d17, #8
	DCD	0xf3f2e320 ;	vshll.i8	q15, d16, #8
	DCD	0xf3dbc474 ;	vsri.16	q14, q10, #5
	DCD	0xf3d5c47e ;	vsri.16	q14, q15, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	6b58 <pixman_composite_over_n_8888_0565_ca_asm_neon+0x4b8>
	DCD	0xf442d75d ;	vst1.16	{d29}, [r2 :64]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	6b68 <pixman_composite_over_n_8888_0565_ca_asm_neon+0x4c8>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	6b74 <pixman_composite_over_n_8888_0565_ca_asm_neon+0x4d4>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe1a00004 ;	mov	r0, r4
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0877108 ;	add	r7, r7, r8, lsl #2
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe0477100 ;	sub	r7, r7, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaafffed8 ;	bge	66f8 <pixman_composite_over_n_8888_0565_ca_asm_neon+0x58>
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a00002c ;	beq	6c58 <pixman_composite_over_n_8888_0565_ca_asm_neon+0x5b8>
	DCD	0xf4264a4d ;	vld1.16	{d4-d5}, [r6]!
	DCD	0xf467800d ;	vld4.8	{d24-d27}, [r7]!
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3892c89 ;	vmull.u8	q1, d25, d9
	DCD	0xf38acc8a ;	vmull.u8	q6, d26, d10
	DCD	0xf3cb2c29 ;	vmull.u8	q9, d11, d25
	DCD	0xf3cb8c28 ;	vmull.u8	q12, d11, d24
	DCD	0xf3cbac2a ;	vmull.u8	q13, d11, d26
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d84252 ;	vrshr.u16	q10, q1, #8
	DCD	0xf3d8625c ;	vrshr.u16	q11, q6, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821424 ;	vraddhn.i16	d1, q1, q10
	DCD	0xf38c2426 ;	vraddhn.i16	d2, q6, q11
	DCD	0xf3d86278 ;	vrshr.u16	q11, q12, #8
	DCD	0xf3d80272 ;	vrshr.u16	q8, q9, #8
	DCD	0xf398c27a ;	vrshr.u16	q6, q13, #8
	DCD	0xf3c884a6 ;	vraddhn.i16	d24, q12, q11
	DCD	0xf3c294a0 ;	vraddhn.i16	d25, q9, q8
	DCD	0xf2cd1814 ;	vshrn.i16	d17, q2, #3
	DCD	0xf2c82814 ;	vshrn.i16	d18, q2, #8
	DCD	0xf3caa48c ;	vraddhn.i16	d26, q13, q6
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3cb2432 ;	vsri.8	d18, d18, #5
	DCD	0xf3ca1431 ;	vsri.8	d17, d17, #6
	DCD	0xf3f085e8 ;	vmvn	q12, q12
	DCD	0xf2ce0814 ;	vshrn.i16	d16, q2, #2
	DCD	0xf3f0a5aa ;	vmvn	d26, d26
	DCD	0xf380cca8 ;	vmull.u8	q6, d16, d24
	DCD	0xf381eca9 ;	vmull.u8	q7, d17, d25
	DCD	0xf3c26caa ;	vmull.u8	q11, d18, d26
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8c25e ;	vrshr.u16	q14, q7, #8
	DCD	0xf3d8e276 ;	vrshr.u16	q15, q11, #8
	DCD	0xf3c4048c ;	vraddhn.i16	d16, q10, q6
	DCD	0xf3cc148e ;	vraddhn.i16	d17, q14, q7
	DCD	0xf3ce24a6 ;	vraddhn.i16	d18, q15, q11
	DCD	0xf3400070 ;	vqadd.u8	q8, q0, q8
	DCD	0xf3422032 ;	vqadd.u8	d18, d2, d18
	DCD	0xf3f2c322 ;	vshll.i8	q14, d18, #8
	DCD	0xf3f24321 ;	vshll.i8	q10, d17, #8
	DCD	0xf3f2e320 ;	vshll.i8	q15, d16, #8
	DCD	0xf3dbc474 ;	vsri.16	q14, q10, #5
	DCD	0xf3d5c47e ;	vsri.16	q14, q15, #11
	DCD	0xf442ca4d ;	vst1.16	{d28-d29}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000044 ;	beq	6d74 <pixman_composite_over_n_8888_0565_ca_asm_neon+0x6d4>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000001 ;	beq	6c70 <pixman_composite_over_n_8888_0565_ca_asm_neon+0x5d0>
	DCD	0xf467aa8d ;	vld1.32	{d26-d27}, [r7]!
	DCD	0xf426574d ;	vld1.16	{d5}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000002 ;	beq	6c84 <pixman_composite_over_n_8888_0565_ca_asm_neon+0x5e4>
	DCD	0xf467978d ;	vld1.32	{d25}, [r7]!
	DCD	0xf4a6448d ;	vld1.16	{d4[2]}, [r6]!
	DCD	0xf4a644cd ;	vld1.16	{d4[3]}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	6c94 <pixman_composite_over_n_8888_0565_ca_asm_neon+0x5f4>
	DCD	0xf4e7888d ;	vld1.32	{d24[1]}, [r7]!
	DCD	0xf4a6444d ;	vld1.16	{d4[1]}, [r6]!
	DCD	0xf3f28129 ;	vuzp.8	d24, d25
	DCD	0xf3f2a12b ;	vuzp.8	d26, d27
	DCD	0xf3f2912b ;	vuzp.8	d25, d27
	DCD	0xf3f2812a ;	vuzp.8	d24, d26
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3892c89 ;	vmull.u8	q1, d25, d9
	DCD	0xf38acc8a ;	vmull.u8	q6, d26, d10
	DCD	0xf3cb2c29 ;	vmull.u8	q9, d11, d25
	DCD	0xf3cb8c28 ;	vmull.u8	q12, d11, d24
	DCD	0xf3cbac2a ;	vmull.u8	q13, d11, d26
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d84252 ;	vrshr.u16	q10, q1, #8
	DCD	0xf3d8625c ;	vrshr.u16	q11, q6, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821424 ;	vraddhn.i16	d1, q1, q10
	DCD	0xf38c2426 ;	vraddhn.i16	d2, q6, q11
	DCD	0xf3d86278 ;	vrshr.u16	q11, q12, #8
	DCD	0xf3d80272 ;	vrshr.u16	q8, q9, #8
	DCD	0xf398c27a ;	vrshr.u16	q6, q13, #8
	DCD	0xf3c884a6 ;	vraddhn.i16	d24, q12, q11
	DCD	0xf3c294a0 ;	vraddhn.i16	d25, q9, q8
	DCD	0xf2cd1814 ;	vshrn.i16	d17, q2, #3
	DCD	0xf2c82814 ;	vshrn.i16	d18, q2, #8
	DCD	0xf3caa48c ;	vraddhn.i16	d26, q13, q6
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3cb2432 ;	vsri.8	d18, d18, #5
	DCD	0xf3ca1431 ;	vsri.8	d17, d17, #6
	DCD	0xf3f085e8 ;	vmvn	q12, q12
	DCD	0xf2ce0814 ;	vshrn.i16	d16, q2, #2
	DCD	0xf3f0a5aa ;	vmvn	d26, d26
	DCD	0xf380cca8 ;	vmull.u8	q6, d16, d24
	DCD	0xf381eca9 ;	vmull.u8	q7, d17, d25
	DCD	0xf3c26caa ;	vmull.u8	q11, d18, d26
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8c25e ;	vrshr.u16	q14, q7, #8
	DCD	0xf3d8e276 ;	vrshr.u16	q15, q11, #8
	DCD	0xf3c4048c ;	vraddhn.i16	d16, q10, q6
	DCD	0xf3cc148e ;	vraddhn.i16	d17, q14, q7
	DCD	0xf3ce24a6 ;	vraddhn.i16	d18, q15, q11
	DCD	0xf3400070 ;	vqadd.u8	q8, q0, q8
	DCD	0xf3422032 ;	vqadd.u8	d18, d2, d18
	DCD	0xf3f2c322 ;	vshll.i8	q14, d18, #8
	DCD	0xf3f24321 ;	vshll.i8	q10, d17, #8
	DCD	0xf3f2e320 ;	vshll.i8	q15, d16, #8
	DCD	0xf3dbc474 ;	vsri.16	q14, q10, #5
	DCD	0xf3d5c47e ;	vsri.16	q14, q15, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	6d58 <pixman_composite_over_n_8888_0565_ca_asm_neon+0x6b8>
	DCD	0xf442d74d ;	vst1.16	{d29}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	6d68 <pixman_composite_over_n_8888_0565_ca_asm_neon+0x6c8>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	6d74 <pixman_composite_over_n_8888_0565_ca_asm_neon+0x6d4>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe1a00004 ;	mov	r0, r4
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0877108 ;	add	r7, r7, r8, lsl #2
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe0477100 ;	sub	r7, r7, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff81 ;	bge	6b9c <pixman_composite_over_n_8888_0565_ca_asm_neon+0x4fc>
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_over_n_8888_0565_ca_asm_neon|

|pixman_composite_in_n_8_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xe28d8028 ;	add	r8, sp, #40	; 0x28
	DCD	0xf4a8380f ;	vld1.32	{d3[0]}, [r8]
	DCD	0xf3b73c03 ;	vdup.8	d3, d3[3]
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a07000 ;	mov	r7, r0
	DCD	0xba000107 ;	blt	71f4 <pixman_composite_in_n_8_asm_neon+0x458>
	DCD	0xe3500040 ;	cmp	r0, #64	; 0x40
	DCD	0xba0000bb ;	blt	70cc <pixman_composite_in_n_8_asm_neon+0x330>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a00003f ;	beq	6ee4 <pixman_composite_in_n_8_asm_neon+0x148>
	DCD	0xe3160001 ;	tst	r6, #1
	DCD	0x0a000002 ;	beq	6df8 <pixman_composite_in_n_8_asm_neon+0x5c>
	DCD	0xf4a6402d ;	vld1.8	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160002 ;	tst	r6, #2
	DCD	0x0a000003 ;	beq	6e10 <pixman_composite_in_n_8_asm_neon+0x74>
	DCD	0xf4a6404d ;	vld1.8	{d4[2]}, [r6]!
	DCD	0xf4a6406d ;	vld1.8	{d4[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000005 ;	beq	6e30 <pixman_composite_in_n_8_asm_neon+0x94>
	DCD	0xf4a6408d ;	vld1.8	{d4[4]}, [r6]!
	DCD	0xf4a640ad ;	vld1.8	{d4[5]}, [r6]!
	DCD	0xf4a640cd ;	vld1.8	{d4[6]}, [r6]!
	DCD	0xf4a640ed ;	vld1.8	{d4[7]}, [r6]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000002 ;	beq	6e44 <pixman_composite_in_n_8_asm_neon+0xa8>
	DCD	0xf426571d ;	vld1.8	{d5}, [r6 :64]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe2400008 ;	sub	r0, r0, #8
	DCD	0xf4266a2d ;	vld1.8	{d6-d7}, [r6 :128]!
	DCD	0xe28aa010 ;	add	sl, sl, #16
	DCD	0xe2400010 ;	sub	r0, r0, #16
	DCD	0xf3c40c03 ;	vmull.u8	q8, d4, d3
	DCD	0xf3c52c03 ;	vmull.u8	q9, d5, d3
	DCD	0xf3c64c03 ;	vmull.u8	q10, d6, d3
	DCD	0xf3c76c03 ;	vmull.u8	q11, d7, d3
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa020 ;	addne	sl, sl, #32
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dcf00a ;	pld	[ip, sl]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc8003 ;	ldrbge	r8, [ip, r3]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3c0c4ac ;	vraddhn.i16	d28, q8, q14
	DCD	0xf3c2d4ae ;	vraddhn.i16	d29, q9, q15
	DCD	0xf3c4e4a8 ;	vraddhn.i16	d30, q10, q12
	DCD	0xf3c6f4aa ;	vraddhn.i16	d31, q11, q13
	DCD	0xe3120001 ;	tst	r2, #1
	DCD	0x0a000000 ;	beq	6eac <pixman_composite_in_n_8_asm_neon+0x110>
	DCD	0xf4c2c02d ;	vst1.8	{d28[1]}, [r2]!
	DCD	0xe3120002 ;	tst	r2, #2
	DCD	0x0a000001 ;	beq	6ebc <pixman_composite_in_n_8_asm_neon+0x120>
	DCD	0xf4c2c04d ;	vst1.8	{d28[2]}, [r2]!
	DCD	0xf4c2c06d ;	vst1.8	{d28[3]}, [r2]!
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000003 ;	beq	6ed4 <pixman_composite_in_n_8_asm_neon+0x138>
	DCD	0xf4c2c08d ;	vst1.8	{d28[4]}, [r2]!
	DCD	0xf4c2c0ad ;	vst1.8	{d28[5]}, [r2]!
	DCD	0xf4c2c0cd ;	vst1.8	{d28[6]}, [r2]!
	DCD	0xf4c2c0ed ;	vst1.8	{d28[7]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	6ee0 <pixman_composite_in_n_8_asm_neon+0x144>
	DCD	0xf442d71d ;	vst1.8	{d29}, [r2 :64]!
	DCD	0xf442ea2d ;	vst1.8	{d30-d31}, [r2 :128]!
	DCD	0xf426422d ;	vld1.8	{d4-d7}, [r6 :128]!
	DCD	0xe28aa020 ;	add	sl, sl, #32
	DCD	0xf3c40c03 ;	vmull.u8	q8, d4, d3
	DCD	0xf3c52c03 ;	vmull.u8	q9, d5, d3
	DCD	0xf3c64c03 ;	vmull.u8	q10, d6, d3
	DCD	0xf3c76c03 ;	vmull.u8	q11, d7, d3
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa020 ;	addne	sl, sl, #32
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dcf00a ;	pld	[ip, sl]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc8003 ;	ldrbge	r8, [ip, r3]!
	DCD	0xe2500040 ;	subs	r0, r0, #64	; 0x40
	DCD	0xba000018 ;	blt	6f88 <pixman_composite_in_n_8_asm_neon+0x1ec>
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3c0c4ac ;	vraddhn.i16	d28, q8, q14
	DCD	0xf3c2d4ae ;	vraddhn.i16	d29, q9, q15
	DCD	0xf3c4e4a8 ;	vraddhn.i16	d30, q10, q12
	DCD	0xf3c6f4aa ;	vraddhn.i16	d31, q11, q13
	DCD	0xf426422d ;	vld1.8	{d4-d7}, [r6 :128]!
	DCD	0xe28aa020 ;	add	sl, sl, #32
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa020 ;	addne	sl, sl, #32
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dcf00a ;	pld	[ip, sl]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc8003 ;	ldrbge	r8, [ip, r3]!
	DCD	0xf3c40c03 ;	vmull.u8	q8, d4, d3
	DCD	0xf3c52c03 ;	vmull.u8	q9, d5, d3
	DCD	0xf3c64c03 ;	vmull.u8	q10, d6, d3
	DCD	0xf3c76c03 ;	vmull.u8	q11, d7, d3
	DCD	0xf442c22d ;	vst1.8	{d28-d31}, [r2 :128]!
	DCD	0xe2500020 ;	subs	r0, r0, #32
	DCD	0xaaffffe6 ;	bge	6f24 <pixman_composite_in_n_8_asm_neon+0x188>
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3c0c4ac ;	vraddhn.i16	d28, q8, q14
	DCD	0xf3c2d4ae ;	vraddhn.i16	d29, q9, q15
	DCD	0xf3c4e4a8 ;	vraddhn.i16	d30, q10, q12
	DCD	0xf3c6f4aa ;	vraddhn.i16	d31, q11, q13
	DCD	0xf442c22d ;	vst1.8	{d28-d31}, [r2 :128]!
	DCD	0xe310001f ;	tst	r0, #31
	DCD	0x0a00003e ;	beq	70b0 <pixman_composite_in_n_8_asm_neon+0x314>
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000001 ;	beq	6fc4 <pixman_composite_in_n_8_asm_neon+0x228>
	DCD	0xf4266a2d ;	vld1.8	{d6-d7}, [r6 :128]!
	DCD	0xe28aa010 ;	add	sl, sl, #16
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000001 ;	beq	6fd4 <pixman_composite_in_n_8_asm_neon+0x238>
	DCD	0xf426571d ;	vld1.8	{d5}, [r6 :64]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000004 ;	beq	6ff0 <pixman_composite_in_n_8_asm_neon+0x254>
	DCD	0xf4a6408d ;	vld1.8	{d4[4]}, [r6]!
	DCD	0xf4a640ad ;	vld1.8	{d4[5]}, [r6]!
	DCD	0xf4a640cd ;	vld1.8	{d4[6]}, [r6]!
	DCD	0xf4a640ed ;	vld1.8	{d4[7]}, [r6]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000002 ;	beq	7004 <pixman_composite_in_n_8_asm_neon+0x268>
	DCD	0xf4a6404d ;	vld1.8	{d4[2]}, [r6]!
	DCD	0xf4a6406d ;	vld1.8	{d4[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	7014 <pixman_composite_in_n_8_asm_neon+0x278>
	DCD	0xf4a6402d ;	vld1.8	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf3c40c03 ;	vmull.u8	q8, d4, d3
	DCD	0xf3c52c03 ;	vmull.u8	q9, d5, d3
	DCD	0xf3c64c03 ;	vmull.u8	q10, d6, d3
	DCD	0xf3c76c03 ;	vmull.u8	q11, d7, d3
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa020 ;	addne	sl, sl, #32
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dcf00a ;	pld	[ip, sl]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc8003 ;	ldrbge	r8, [ip, r3]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3c0c4ac ;	vraddhn.i16	d28, q8, q14
	DCD	0xf3c2d4ae ;	vraddhn.i16	d29, q9, q15
	DCD	0xf3c4e4a8 ;	vraddhn.i16	d30, q10, q12
	DCD	0xf3c6f4aa ;	vraddhn.i16	d31, q11, q13
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000000 ;	beq	7070 <pixman_composite_in_n_8_asm_neon+0x2d4>
	DCD	0xf442ea2d ;	vst1.8	{d30-d31}, [r2 :128]!
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000000 ;	beq	707c <pixman_composite_in_n_8_asm_neon+0x2e0>
	DCD	0xf442d71d ;	vst1.8	{d29}, [r2 :64]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000003 ;	beq	7094 <pixman_composite_in_n_8_asm_neon+0x2f8>
	DCD	0xf4c2c08d ;	vst1.8	{d28[4]}, [r2]!
	DCD	0xf4c2c0ad ;	vst1.8	{d28[5]}, [r2]!
	DCD	0xf4c2c0cd ;	vst1.8	{d28[6]}, [r2]!
	DCD	0xf4c2c0ed ;	vst1.8	{d28[7]}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	70a4 <pixman_composite_in_n_8_asm_neon+0x308>
	DCD	0xf4c2c04d ;	vst1.8	{d28[2]}, [r2]!
	DCD	0xf4c2c06d ;	vst1.8	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	70b0 <pixman_composite_in_n_8_asm_neon+0x314>
	DCD	0xf4c2c02d ;	vst1.8	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822003 ;	add	r2, r2, r3
	DCD	0xe0422000 ;	sub	r2, r2, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff44 ;	bge	6ddc <pixman_composite_in_n_8_asm_neon+0x40>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100020 ;	tst	r0, #32
	DCD	0x0a00000d ;	beq	710c <pixman_composite_in_n_8_asm_neon+0x370>
	DCD	0xf426420d ;	vld1.8	{d4-d7}, [r6]!
	DCD	0xf3c40c03 ;	vmull.u8	q8, d4, d3
	DCD	0xf3c52c03 ;	vmull.u8	q9, d5, d3
	DCD	0xf3c64c03 ;	vmull.u8	q10, d6, d3
	DCD	0xf3c76c03 ;	vmull.u8	q11, d7, d3
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3c0c4ac ;	vraddhn.i16	d28, q8, q14
	DCD	0xf3c2d4ae ;	vraddhn.i16	d29, q9, q15
	DCD	0xf3c4e4a8 ;	vraddhn.i16	d30, q10, q12
	DCD	0xf3c6f4aa ;	vraddhn.i16	d31, q11, q13
	DCD	0xf442c20d ;	vst1.8	{d28-d31}, [r2]!
	DCD	0xe310001f ;	tst	r0, #31
	DCD	0x0a000031 ;	beq	71dc <pixman_composite_in_n_8_asm_neon+0x440>
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000000 ;	beq	7120 <pixman_composite_in_n_8_asm_neon+0x384>
	DCD	0xf4266a0d ;	vld1.8	{d6-d7}, [r6]!
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000000 ;	beq	712c <pixman_composite_in_n_8_asm_neon+0x390>
	DCD	0xf426570d ;	vld1.8	{d5}, [r6]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000003 ;	beq	7144 <pixman_composite_in_n_8_asm_neon+0x3a8>
	DCD	0xf4a6408d ;	vld1.8	{d4[4]}, [r6]!
	DCD	0xf4a640ad ;	vld1.8	{d4[5]}, [r6]!
	DCD	0xf4a640cd ;	vld1.8	{d4[6]}, [r6]!
	DCD	0xf4a640ed ;	vld1.8	{d4[7]}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	7154 <pixman_composite_in_n_8_asm_neon+0x3b8>
	DCD	0xf4a6404d ;	vld1.8	{d4[2]}, [r6]!
	DCD	0xf4a6406d ;	vld1.8	{d4[3]}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	7160 <pixman_composite_in_n_8_asm_neon+0x3c4>
	DCD	0xf4a6402d ;	vld1.8	{d4[1]}, [r6]!
	DCD	0xf3c40c03 ;	vmull.u8	q8, d4, d3
	DCD	0xf3c52c03 ;	vmull.u8	q9, d5, d3
	DCD	0xf3c64c03 ;	vmull.u8	q10, d6, d3
	DCD	0xf3c76c03 ;	vmull.u8	q11, d7, d3
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3c0c4ac ;	vraddhn.i16	d28, q8, q14
	DCD	0xf3c2d4ae ;	vraddhn.i16	d29, q9, q15
	DCD	0xf3c4e4a8 ;	vraddhn.i16	d30, q10, q12
	DCD	0xf3c6f4aa ;	vraddhn.i16	d31, q11, q13
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000000 ;	beq	719c <pixman_composite_in_n_8_asm_neon+0x400>
	DCD	0xf442ea0d ;	vst1.8	{d30-d31}, [r2]!
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000000 ;	beq	71a8 <pixman_composite_in_n_8_asm_neon+0x40c>
	DCD	0xf442d70d ;	vst1.8	{d29}, [r2]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000003 ;	beq	71c0 <pixman_composite_in_n_8_asm_neon+0x424>
	DCD	0xf4c2c08d ;	vst1.8	{d28[4]}, [r2]!
	DCD	0xf4c2c0ad ;	vst1.8	{d28[5]}, [r2]!
	DCD	0xf4c2c0cd ;	vst1.8	{d28[6]}, [r2]!
	DCD	0xf4c2c0ed ;	vst1.8	{d28[7]}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	71d0 <pixman_composite_in_n_8_asm_neon+0x434>
	DCD	0xf4c2c04d ;	vst1.8	{d28[2]}, [r2]!
	DCD	0xf4c2c06d ;	vst1.8	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	71dc <pixman_composite_in_n_8_asm_neon+0x440>
	DCD	0xf4c2c02d ;	vst1.8	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822003 ;	add	r2, r2, r3
	DCD	0xe0422000 ;	sub	r2, r2, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffb5 ;	bge	70cc <pixman_composite_in_n_8_asm_neon+0x330>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_in_n_8_asm_neon|

|pixman_composite_add_n_8_8_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d7030 ;	ldr	r7, [sp, #48]	; 0x30
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d8034 ;	ldr	r8, [sp, #52]	; 0x34
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xe28d5028 ;	add	r5, sp, #40	; 0x28
	DCD	0xed2d8b10 ;	vpush	{d8-d15}
	DCD	0xf4a5b80f ;	vld1.32	{d11[0]}, [r5]
	DCD	0xf3b7bc0b ;	vdup.8	d11, d11[3]
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a04000 ;	mov	r4, r0
	DCD	0xba00013e ;	blt	7738 <pixman_composite_add_n_8_8_asm_neon+0x540>
	DCD	0xe3500040 ;	cmp	r0, #64	; 0x40
	DCD	0xba0000e2 ;	blt	75d0 <pixman_composite_add_n_8_8_asm_neon+0x3d8>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a00004c ;	beq	7380 <pixman_composite_add_n_8_8_asm_neon+0x188>
	DCD	0xe3160001 ;	tst	r6, #1
	DCD	0x0a000003 ;	beq	7264 <pixman_composite_add_n_8_8_asm_neon+0x6c>
	DCD	0xf4e7802d ;	vld1.8	{d24[1]}, [r7]!
	DCD	0xf4a6402d ;	vld1.8	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160002 ;	tst	r6, #2
	DCD	0x0a000005 ;	beq	7284 <pixman_composite_add_n_8_8_asm_neon+0x8c>
	DCD	0xf4e7804d ;	vld1.8	{d24[2]}, [r7]!
	DCD	0xf4e7806d ;	vld1.8	{d24[3]}, [r7]!
	DCD	0xf4a6404d ;	vld1.8	{d4[2]}, [r6]!
	DCD	0xf4a6406d ;	vld1.8	{d4[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000009 ;	beq	72b4 <pixman_composite_add_n_8_8_asm_neon+0xbc>
	DCD	0xf4e7808d ;	vld1.8	{d24[4]}, [r7]!
	DCD	0xf4e780ad ;	vld1.8	{d24[5]}, [r7]!
	DCD	0xf4e780cd ;	vld1.8	{d24[6]}, [r7]!
	DCD	0xf4e780ed ;	vld1.8	{d24[7]}, [r7]!
	DCD	0xf4a6408d ;	vld1.8	{d4[4]}, [r6]!
	DCD	0xf4a640ad ;	vld1.8	{d4[5]}, [r6]!
	DCD	0xf4a640cd ;	vld1.8	{d4[6]}, [r6]!
	DCD	0xf4a640ed ;	vld1.8	{d4[7]}, [r6]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000003 ;	beq	72cc <pixman_composite_add_n_8_8_asm_neon+0xd4>
	DCD	0xf467970d ;	vld1.8	{d25}, [r7]!
	DCD	0xf426571d ;	vld1.8	{d5}, [r6 :64]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe2400008 ;	sub	r0, r0, #8
	DCD	0xf467aa0d ;	vld1.8	{d26-d27}, [r7]!
	DCD	0xf4266a2d ;	vld1.8	{d6-d7}, [r6 :128]!
	DCD	0xe28aa010 ;	add	sl, sl, #16
	DCD	0xe2400010 ;	sub	r0, r0, #16
	DCD	0xf3880c8b ;	vmull.u8	q0, d24, d11
	DCD	0xf3892c8b ;	vmull.u8	q1, d25, d11
	DCD	0xf38acc8b ;	vmull.u8	q6, d26, d11
	DCD	0xf38bec8b ;	vmull.u8	q7, d27, d11
	DCD	0xf3d84250 ;	vrshr.u16	q10, q0, #8
	DCD	0xf3d86252 ;	vrshr.u16	q11, q1, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8a25e ;	vrshr.u16	q13, q7, #8
	DCD	0xf3800424 ;	vraddhn.i16	d0, q0, q10
	DCD	0xf3821426 ;	vraddhn.i16	d1, q1, q11
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38e342a ;	vraddhn.i16	d3, q7, q13
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa020 ;	addne	sl, sl, #32
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7dcf00a ;	pld	[ip, sl]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc5003 ;	ldrbge	r5, [ip, r3]!
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xe3120001 ;	tst	r2, #1
	DCD	0x0a000000 ;	beq	7348 <pixman_composite_add_n_8_8_asm_neon+0x150>
	DCD	0xf4c2c02d ;	vst1.8	{d28[1]}, [r2]!
	DCD	0xe3120002 ;	tst	r2, #2
	DCD	0x0a000001 ;	beq	7358 <pixman_composite_add_n_8_8_asm_neon+0x160>
	DCD	0xf4c2c04d ;	vst1.8	{d28[2]}, [r2]!
	DCD	0xf4c2c06d ;	vst1.8	{d28[3]}, [r2]!
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000003 ;	beq	7370 <pixman_composite_add_n_8_8_asm_neon+0x178>
	DCD	0xf4c2c08d ;	vst1.8	{d28[4]}, [r2]!
	DCD	0xf4c2c0ad ;	vst1.8	{d28[5]}, [r2]!
	DCD	0xf4c2c0cd ;	vst1.8	{d28[6]}, [r2]!
	DCD	0xf4c2c0ed ;	vst1.8	{d28[7]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	737c <pixman_composite_add_n_8_8_asm_neon+0x184>
	DCD	0xf442d71d ;	vst1.8	{d29}, [r2 :64]!
	DCD	0xf442ea2d ;	vst1.8	{d30-d31}, [r2 :128]!
	DCD	0xf426422d ;	vld1.8	{d4-d7}, [r6 :128]!
	DCD	0xf467820d ;	vld1.8	{d24-d27}, [r7]!
	DCD	0xe28aa020 ;	add	sl, sl, #32
	DCD	0xf3880c8b ;	vmull.u8	q0, d24, d11
	DCD	0xf3892c8b ;	vmull.u8	q1, d25, d11
	DCD	0xf38acc8b ;	vmull.u8	q6, d26, d11
	DCD	0xf38bec8b ;	vmull.u8	q7, d27, d11
	DCD	0xf3d84250 ;	vrshr.u16	q10, q0, #8
	DCD	0xf3d86252 ;	vrshr.u16	q11, q1, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8a25e ;	vrshr.u16	q13, q7, #8
	DCD	0xf3800424 ;	vraddhn.i16	d0, q0, q10
	DCD	0xf3821426 ;	vraddhn.i16	d1, q1, q11
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38e342a ;	vraddhn.i16	d3, q7, q13
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa020 ;	addne	sl, sl, #32
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7dcf00a ;	pld	[ip, sl]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc5003 ;	ldrbge	r5, [ip, r3]!
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xe2500040 ;	subs	r0, r0, #64	; 0x40
	DCD	0xba00001d ;	blt	746c <pixman_composite_add_n_8_8_asm_neon+0x274>
	DCD	0xf442c22d ;	vst1.8	{d28-d31}, [r2 :128]!
	DCD	0xf426422d ;	vld1.8	{d4-d7}, [r6 :128]!
	DCD	0xf467820d ;	vld1.8	{d24-d27}, [r7]!
	DCD	0xe28aa020 ;	add	sl, sl, #32
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa020 ;	addne	sl, sl, #32
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7dcf00a ;	pld	[ip, sl]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc5003 ;	ldrbge	r5, [ip, r3]!
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xf3880c8b ;	vmull.u8	q0, d24, d11
	DCD	0xf3892c8b ;	vmull.u8	q1, d25, d11
	DCD	0xf38acc8b ;	vmull.u8	q6, d26, d11
	DCD	0xf38bec8b ;	vmull.u8	q7, d27, d11
	DCD	0xf3d84250 ;	vrshr.u16	q10, q0, #8
	DCD	0xf3d86252 ;	vrshr.u16	q11, q1, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8a25e ;	vrshr.u16	q13, q7, #8
	DCD	0xf3800424 ;	vraddhn.i16	d0, q0, q10
	DCD	0xf3821426 ;	vraddhn.i16	d1, q1, q11
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38e342a ;	vraddhn.i16	d3, q7, q13
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xe2500020 ;	subs	r0, r0, #32
	DCD	0xaaffffe1 ;	bge	73f4 <pixman_composite_add_n_8_8_asm_neon+0x1fc>
	DCD	0xf442c22d ;	vst1.8	{d28-d31}, [r2 :128]!
	DCD	0xe310001f ;	tst	r0, #31
	DCD	0x0a00004b ;	beq	75a8 <pixman_composite_add_n_8_8_asm_neon+0x3b0>
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000002 ;	beq	748c <pixman_composite_add_n_8_8_asm_neon+0x294>
	DCD	0xf467aa0d ;	vld1.8	{d26-d27}, [r7]!
	DCD	0xf4266a2d ;	vld1.8	{d6-d7}, [r6 :128]!
	DCD	0xe28aa010 ;	add	sl, sl, #16
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000002 ;	beq	74a0 <pixman_composite_add_n_8_8_asm_neon+0x2a8>
	DCD	0xf467970d ;	vld1.8	{d25}, [r7]!
	DCD	0xf426571d ;	vld1.8	{d5}, [r6 :64]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000008 ;	beq	74cc <pixman_composite_add_n_8_8_asm_neon+0x2d4>
	DCD	0xf4e7808d ;	vld1.8	{d24[4]}, [r7]!
	DCD	0xf4e780ad ;	vld1.8	{d24[5]}, [r7]!
	DCD	0xf4e780cd ;	vld1.8	{d24[6]}, [r7]!
	DCD	0xf4e780ed ;	vld1.8	{d24[7]}, [r7]!
	DCD	0xf4a6408d ;	vld1.8	{d4[4]}, [r6]!
	DCD	0xf4a640ad ;	vld1.8	{d4[5]}, [r6]!
	DCD	0xf4a640cd ;	vld1.8	{d4[6]}, [r6]!
	DCD	0xf4a640ed ;	vld1.8	{d4[7]}, [r6]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000004 ;	beq	74e8 <pixman_composite_add_n_8_8_asm_neon+0x2f0>
	DCD	0xf4e7804d ;	vld1.8	{d24[2]}, [r7]!
	DCD	0xf4e7806d ;	vld1.8	{d24[3]}, [r7]!
	DCD	0xf4a6404d ;	vld1.8	{d4[2]}, [r6]!
	DCD	0xf4a6406d ;	vld1.8	{d4[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	74fc <pixman_composite_add_n_8_8_asm_neon+0x304>
	DCD	0xf4e7802d ;	vld1.8	{d24[1]}, [r7]!
	DCD	0xf4a6402d ;	vld1.8	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf3880c8b ;	vmull.u8	q0, d24, d11
	DCD	0xf3892c8b ;	vmull.u8	q1, d25, d11
	DCD	0xf38acc8b ;	vmull.u8	q6, d26, d11
	DCD	0xf38bec8b ;	vmull.u8	q7, d27, d11
	DCD	0xf3d84250 ;	vrshr.u16	q10, q0, #8
	DCD	0xf3d86252 ;	vrshr.u16	q11, q1, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8a25e ;	vrshr.u16	q13, q7, #8
	DCD	0xf3800424 ;	vraddhn.i16	d0, q0, q10
	DCD	0xf3821426 ;	vraddhn.i16	d1, q1, q11
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38e342a ;	vraddhn.i16	d3, q7, q13
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa020 ;	addne	sl, sl, #32
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7dcf00a ;	pld	[ip, sl]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc5003 ;	ldrbge	r5, [ip, r3]!
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000000 ;	beq	7568 <pixman_composite_add_n_8_8_asm_neon+0x370>
	DCD	0xf442ea2d ;	vst1.8	{d30-d31}, [r2 :128]!
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000000 ;	beq	7574 <pixman_composite_add_n_8_8_asm_neon+0x37c>
	DCD	0xf442d71d ;	vst1.8	{d29}, [r2 :64]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000003 ;	beq	758c <pixman_composite_add_n_8_8_asm_neon+0x394>
	DCD	0xf4c2c08d ;	vst1.8	{d28[4]}, [r2]!
	DCD	0xf4c2c0ad ;	vst1.8	{d28[5]}, [r2]!
	DCD	0xf4c2c0cd ;	vst1.8	{d28[6]}, [r2]!
	DCD	0xf4c2c0ed ;	vst1.8	{d28[7]}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	759c <pixman_composite_add_n_8_8_asm_neon+0x3a4>
	DCD	0xf4c2c04d ;	vst1.8	{d28[2]}, [r2]!
	DCD	0xf4c2c06d ;	vst1.8	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	75a8 <pixman_composite_add_n_8_8_asm_neon+0x3b0>
	DCD	0xf4c2c02d ;	vst1.8	{d28[1]}, [r2]!
	DCD	0xe1a00004 ;	mov	r0, r4
	DCD	0xe0822003 ;	add	r2, r2, r3
	DCD	0xe0877008 ;	add	r7, r7, r8
	DCD	0xe0422000 ;	sub	r2, r2, r0
	DCD	0xe0477000 ;	sub	r7, r7, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff1e ;	bge	7244 <pixman_composite_add_n_8_8_asm_neon+0x4c>
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100020 ;	tst	r0, #32
	DCD	0x0a000010 ;	beq	761c <pixman_composite_add_n_8_8_asm_neon+0x424>
	DCD	0xf426420d ;	vld1.8	{d4-d7}, [r6]!
	DCD	0xf467820d ;	vld1.8	{d24-d27}, [r7]!
	DCD	0xf3880c8b ;	vmull.u8	q0, d24, d11
	DCD	0xf3892c8b ;	vmull.u8	q1, d25, d11
	DCD	0xf38acc8b ;	vmull.u8	q6, d26, d11
	DCD	0xf38bec8b ;	vmull.u8	q7, d27, d11
	DCD	0xf3d84250 ;	vrshr.u16	q10, q0, #8
	DCD	0xf3d86252 ;	vrshr.u16	q11, q1, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8a25e ;	vrshr.u16	q13, q7, #8
	DCD	0xf3800424 ;	vraddhn.i16	d0, q0, q10
	DCD	0xf3821426 ;	vraddhn.i16	d1, q1, q11
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38e342a ;	vraddhn.i16	d3, q7, q13
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xf442c20d ;	vst1.8	{d28-d31}, [r2]!
	DCD	0xe310001f ;	tst	r0, #31
	DCD	0x0a00003c ;	beq	7718 <pixman_composite_add_n_8_8_asm_neon+0x520>
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000001 ;	beq	7634 <pixman_composite_add_n_8_8_asm_neon+0x43c>
	DCD	0xf467aa0d ;	vld1.8	{d26-d27}, [r7]!
	DCD	0xf4266a0d ;	vld1.8	{d6-d7}, [r6]!
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000001 ;	beq	7644 <pixman_composite_add_n_8_8_asm_neon+0x44c>
	DCD	0xf467970d ;	vld1.8	{d25}, [r7]!
	DCD	0xf426570d ;	vld1.8	{d5}, [r6]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000007 ;	beq	766c <pixman_composite_add_n_8_8_asm_neon+0x474>
	DCD	0xf4e7808d ;	vld1.8	{d24[4]}, [r7]!
	DCD	0xf4e780ad ;	vld1.8	{d24[5]}, [r7]!
	DCD	0xf4e780cd ;	vld1.8	{d24[6]}, [r7]!
	DCD	0xf4e780ed ;	vld1.8	{d24[7]}, [r7]!
	DCD	0xf4a6408d ;	vld1.8	{d4[4]}, [r6]!
	DCD	0xf4a640ad ;	vld1.8	{d4[5]}, [r6]!
	DCD	0xf4a640cd ;	vld1.8	{d4[6]}, [r6]!
	DCD	0xf4a640ed ;	vld1.8	{d4[7]}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000003 ;	beq	7684 <pixman_composite_add_n_8_8_asm_neon+0x48c>
	DCD	0xf4e7804d ;	vld1.8	{d24[2]}, [r7]!
	DCD	0xf4e7806d ;	vld1.8	{d24[3]}, [r7]!
	DCD	0xf4a6404d ;	vld1.8	{d4[2]}, [r6]!
	DCD	0xf4a6406d ;	vld1.8	{d4[3]}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	7694 <pixman_composite_add_n_8_8_asm_neon+0x49c>
	DCD	0xf4e7802d ;	vld1.8	{d24[1]}, [r7]!
	DCD	0xf4a6402d ;	vld1.8	{d4[1]}, [r6]!
	DCD	0xf3880c8b ;	vmull.u8	q0, d24, d11
	DCD	0xf3892c8b ;	vmull.u8	q1, d25, d11
	DCD	0xf38acc8b ;	vmull.u8	q6, d26, d11
	DCD	0xf38bec8b ;	vmull.u8	q7, d27, d11
	DCD	0xf3d84250 ;	vrshr.u16	q10, q0, #8
	DCD	0xf3d86252 ;	vrshr.u16	q11, q1, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8a25e ;	vrshr.u16	q13, q7, #8
	DCD	0xf3800424 ;	vraddhn.i16	d0, q0, q10
	DCD	0xf3821426 ;	vraddhn.i16	d1, q1, q11
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38e342a ;	vraddhn.i16	d3, q7, q13
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000000 ;	beq	76d8 <pixman_composite_add_n_8_8_asm_neon+0x4e0>
	DCD	0xf442ea0d ;	vst1.8	{d30-d31}, [r2]!
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000000 ;	beq	76e4 <pixman_composite_add_n_8_8_asm_neon+0x4ec>
	DCD	0xf442d70d ;	vst1.8	{d29}, [r2]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000003 ;	beq	76fc <pixman_composite_add_n_8_8_asm_neon+0x504>
	DCD	0xf4c2c08d ;	vst1.8	{d28[4]}, [r2]!
	DCD	0xf4c2c0ad ;	vst1.8	{d28[5]}, [r2]!
	DCD	0xf4c2c0cd ;	vst1.8	{d28[6]}, [r2]!
	DCD	0xf4c2c0ed ;	vst1.8	{d28[7]}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	770c <pixman_composite_add_n_8_8_asm_neon+0x514>
	DCD	0xf4c2c04d ;	vst1.8	{d28[2]}, [r2]!
	DCD	0xf4c2c06d ;	vst1.8	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	7718 <pixman_composite_add_n_8_8_asm_neon+0x520>
	DCD	0xf4c2c02d ;	vst1.8	{d28[1]}, [r2]!
	DCD	0xe1a00004 ;	mov	r0, r4
	DCD	0xe0822003 ;	add	r2, r2, r3
	DCD	0xe0877008 ;	add	r7, r7, r8
	DCD	0xe0422000 ;	sub	r2, r2, r0
	DCD	0xe0477000 ;	sub	r7, r7, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffa5 ;	bge	75d0 <pixman_composite_add_n_8_8_asm_neon+0x3d8>
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_add_n_8_8_asm_neon|

|pixman_composite_add_8_8_8_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe59d7030 ;	ldr	r7, [sp, #48]	; 0x30
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe59d8034 ;	ldr	r8, [sp, #52]	; 0x34
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xe92d0003 ;	push	{r0, r1}
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe58d1004 ;	str	r1, [sp, #4]
	DCD	0xba00016e ;	blt	7d3c <pixman_composite_add_8_8_8_asm_neon+0x5fc>
	DCD	0xe3500040 ;	cmp	r0, #64	; 0x40
	DCD	0xba000105 ;	blt	7ba0 <pixman_composite_add_8_8_8_asm_neon+0x460>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000058 ;	beq	78f4 <pixman_composite_add_8_8_8_asm_neon+0x1b4>
	DCD	0xe3160001 ;	tst	r6, #1
	DCD	0x0a000004 ;	beq	77ac <pixman_composite_add_8_8_8_asm_neon+0x6c>
	DCD	0xf4a4002d ;	vld1.8	{d0[1]}, [r4]!
	DCD	0xf4e7802d ;	vld1.8	{d24[1]}, [r7]!
	DCD	0xf4a6402d ;	vld1.8	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160002 ;	tst	r6, #2
	DCD	0x0a000007 ;	beq	77d4 <pixman_composite_add_8_8_8_asm_neon+0x94>
	DCD	0xf4a4004d ;	vld1.8	{d0[2]}, [r4]!
	DCD	0xf4a4006d ;	vld1.8	{d0[3]}, [r4]!
	DCD	0xf4e7804d ;	vld1.8	{d24[2]}, [r7]!
	DCD	0xf4e7806d ;	vld1.8	{d24[3]}, [r7]!
	DCD	0xf4a6404d ;	vld1.8	{d4[2]}, [r6]!
	DCD	0xf4a6406d ;	vld1.8	{d4[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a00000d ;	beq	7814 <pixman_composite_add_8_8_8_asm_neon+0xd4>
	DCD	0xf4a4008d ;	vld1.8	{d0[4]}, [r4]!
	DCD	0xf4a400ad ;	vld1.8	{d0[5]}, [r4]!
	DCD	0xf4a400cd ;	vld1.8	{d0[6]}, [r4]!
	DCD	0xf4a400ed ;	vld1.8	{d0[7]}, [r4]!
	DCD	0xf4e7808d ;	vld1.8	{d24[4]}, [r7]!
	DCD	0xf4e780ad ;	vld1.8	{d24[5]}, [r7]!
	DCD	0xf4e780cd ;	vld1.8	{d24[6]}, [r7]!
	DCD	0xf4e780ed ;	vld1.8	{d24[7]}, [r7]!
	DCD	0xf4a6408d ;	vld1.8	{d4[4]}, [r6]!
	DCD	0xf4a640ad ;	vld1.8	{d4[5]}, [r6]!
	DCD	0xf4a640cd ;	vld1.8	{d4[6]}, [r6]!
	DCD	0xf4a640ed ;	vld1.8	{d4[7]}, [r6]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000004 ;	beq	7830 <pixman_composite_add_8_8_8_asm_neon+0xf0>
	DCD	0xf424170d ;	vld1.8	{d1}, [r4]!
	DCD	0xf467970d ;	vld1.8	{d25}, [r7]!
	DCD	0xf426571d ;	vld1.8	{d5}, [r6 :64]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe2400008 ;	sub	r0, r0, #8
	DCD	0xf4242a0d ;	vld1.8	{d2-d3}, [r4]!
	DCD	0xf467aa0d ;	vld1.8	{d26-d27}, [r7]!
	DCD	0xf4266a2d ;	vld1.8	{d6-d7}, [r6 :128]!
	DCD	0xe28aa010 ;	add	sl, sl, #16
	DCD	0xe2400010 ;	sub	r0, r0, #16
	DCD	0xf3c80c80 ;	vmull.u8	q8, d24, d0
	DCD	0xf3c92c81 ;	vmull.u8	q9, d25, d1
	DCD	0xf3ca4c82 ;	vmull.u8	q10, d26, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3980270 ;	vrshr.u16	q0, q8, #8
	DCD	0xf3982272 ;	vrshr.u16	q1, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38824a4 ;	vraddhn.i16	d2, q12, q10
	DCD	0xf38a34a6 ;	vraddhn.i16	d3, q13, q11
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa020 ;	addne	sl, sl, #32
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf00a ;	pld	[fp, sl]
	DCD	0xf7dcf00a ;	pld	[ip, sl]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1005 ;	ldrbge	r1, [fp, r5]!
	DCD	0xa7fc1003 ;	ldrbge	r1, [ip, r3]!
	DCD	0xa7fe1008 ;	ldrbge	r1, [lr, r8]!
	DCD	0xe3120001 ;	tst	r2, #1
	DCD	0x0a000000 ;	beq	78bc <pixman_composite_add_8_8_8_asm_neon+0x17c>
	DCD	0xf4c2c02d ;	vst1.8	{d28[1]}, [r2]!
	DCD	0xe3120002 ;	tst	r2, #2
	DCD	0x0a000001 ;	beq	78cc <pixman_composite_add_8_8_8_asm_neon+0x18c>
	DCD	0xf4c2c04d ;	vst1.8	{d28[2]}, [r2]!
	DCD	0xf4c2c06d ;	vst1.8	{d28[3]}, [r2]!
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000003 ;	beq	78e4 <pixman_composite_add_8_8_8_asm_neon+0x1a4>
	DCD	0xf4c2c08d ;	vst1.8	{d28[4]}, [r2]!
	DCD	0xf4c2c0ad ;	vst1.8	{d28[5]}, [r2]!
	DCD	0xf4c2c0cd ;	vst1.8	{d28[6]}, [r2]!
	DCD	0xf4c2c0ed ;	vst1.8	{d28[7]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	78f0 <pixman_composite_add_8_8_8_asm_neon+0x1b0>
	DCD	0xf442d71d ;	vst1.8	{d29}, [r2 :64]!
	DCD	0xf442ea2d ;	vst1.8	{d30-d31}, [r2 :128]!
	DCD	0xf426422d ;	vld1.8	{d4-d7}, [r6 :128]!
	DCD	0xf424020d ;	vld1.8	{d0-d3}, [r4]!
	DCD	0xf467820d ;	vld1.8	{d24-d27}, [r7]!
	DCD	0xe28aa020 ;	add	sl, sl, #32
	DCD	0xf3c80c80 ;	vmull.u8	q8, d24, d0
	DCD	0xf3c92c81 ;	vmull.u8	q9, d25, d1
	DCD	0xf3ca4c82 ;	vmull.u8	q10, d26, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3980270 ;	vrshr.u16	q0, q8, #8
	DCD	0xf3982272 ;	vrshr.u16	q1, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38824a4 ;	vraddhn.i16	d2, q12, q10
	DCD	0xf38a34a6 ;	vraddhn.i16	d3, q13, q11
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa020 ;	addne	sl, sl, #32
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf00a ;	pld	[fp, sl]
	DCD	0xf7dcf00a ;	pld	[ip, sl]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1005 ;	ldrbge	r1, [fp, r5]!
	DCD	0xa7fc1003 ;	ldrbge	r1, [ip, r3]!
	DCD	0xa7fe1008 ;	ldrbge	r1, [lr, r8]!
	DCD	0xe2500040 ;	subs	r0, r0, #64	; 0x40
	DCD	0xba000021 ;	blt	7a00 <pixman_composite_add_8_8_8_asm_neon+0x2c0>
	DCD	0xf442c22d ;	vst1.8	{d28-d31}, [r2 :128]!
	DCD	0xf426422d ;	vld1.8	{d4-d7}, [r6 :128]!
	DCD	0xf467820d ;	vld1.8	{d24-d27}, [r7]!
	DCD	0xf424020d ;	vld1.8	{d0-d3}, [r4]!
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe28aa020 ;	add	sl, sl, #32
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa020 ;	addne	sl, sl, #32
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf00a ;	pld	[fp, sl]
	DCD	0xf7dcf00a ;	pld	[ip, sl]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1005 ;	ldrbge	r1, [fp, r5]!
	DCD	0xa7fc1003 ;	ldrbge	r1, [ip, r3]!
	DCD	0xa7fe1008 ;	ldrbge	r1, [lr, r8]!
	DCD	0xf3c80c80 ;	vmull.u8	q8, d24, d0
	DCD	0xf3c92c81 ;	vmull.u8	q9, d25, d1
	DCD	0xf3ca4c82 ;	vmull.u8	q10, d26, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3980270 ;	vrshr.u16	q0, q8, #8
	DCD	0xf3982272 ;	vrshr.u16	q1, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38824a4 ;	vraddhn.i16	d2, q12, q10
	DCD	0xf38a34a6 ;	vraddhn.i16	d3, q13, q11
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xe2500020 ;	subs	r0, r0, #32
	DCD	0xaaffffdd ;	bge	7978 <pixman_composite_add_8_8_8_asm_neon+0x238>
	DCD	0xf442c22d ;	vst1.8	{d28-d31}, [r2 :128]!
	DCD	0xe310001f ;	tst	r0, #31
	DCD	0x0a000057 ;	beq	7b6c <pixman_composite_add_8_8_8_asm_neon+0x42c>
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000003 ;	beq	7a24 <pixman_composite_add_8_8_8_asm_neon+0x2e4>
	DCD	0xf4242a0d ;	vld1.8	{d2-d3}, [r4]!
	DCD	0xf467aa0d ;	vld1.8	{d26-d27}, [r7]!
	DCD	0xf4266a2d ;	vld1.8	{d6-d7}, [r6 :128]!
	DCD	0xe28aa010 ;	add	sl, sl, #16
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000003 ;	beq	7a3c <pixman_composite_add_8_8_8_asm_neon+0x2fc>
	DCD	0xf424170d ;	vld1.8	{d1}, [r4]!
	DCD	0xf467970d ;	vld1.8	{d25}, [r7]!
	DCD	0xf426571d ;	vld1.8	{d5}, [r6 :64]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a00000c ;	beq	7a78 <pixman_composite_add_8_8_8_asm_neon+0x338>
	DCD	0xf4a4008d ;	vld1.8	{d0[4]}, [r4]!
	DCD	0xf4a400ad ;	vld1.8	{d0[5]}, [r4]!
	DCD	0xf4a400cd ;	vld1.8	{d0[6]}, [r4]!
	DCD	0xf4a400ed ;	vld1.8	{d0[7]}, [r4]!
	DCD	0xf4e7808d ;	vld1.8	{d24[4]}, [r7]!
	DCD	0xf4e780ad ;	vld1.8	{d24[5]}, [r7]!
	DCD	0xf4e780cd ;	vld1.8	{d24[6]}, [r7]!
	DCD	0xf4e780ed ;	vld1.8	{d24[7]}, [r7]!
	DCD	0xf4a6408d ;	vld1.8	{d4[4]}, [r6]!
	DCD	0xf4a640ad ;	vld1.8	{d4[5]}, [r6]!
	DCD	0xf4a640cd ;	vld1.8	{d4[6]}, [r6]!
	DCD	0xf4a640ed ;	vld1.8	{d4[7]}, [r6]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000006 ;	beq	7a9c <pixman_composite_add_8_8_8_asm_neon+0x35c>
	DCD	0xf4a4004d ;	vld1.8	{d0[2]}, [r4]!
	DCD	0xf4a4006d ;	vld1.8	{d0[3]}, [r4]!
	DCD	0xf4e7804d ;	vld1.8	{d24[2]}, [r7]!
	DCD	0xf4e7806d ;	vld1.8	{d24[3]}, [r7]!
	DCD	0xf4a6404d ;	vld1.8	{d4[2]}, [r6]!
	DCD	0xf4a6406d ;	vld1.8	{d4[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000003 ;	beq	7ab4 <pixman_composite_add_8_8_8_asm_neon+0x374>
	DCD	0xf4a4002d ;	vld1.8	{d0[1]}, [r4]!
	DCD	0xf4e7802d ;	vld1.8	{d24[1]}, [r7]!
	DCD	0xf4a6402d ;	vld1.8	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf3c80c80 ;	vmull.u8	q8, d24, d0
	DCD	0xf3c92c81 ;	vmull.u8	q9, d25, d1
	DCD	0xf3ca4c82 ;	vmull.u8	q10, d26, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3980270 ;	vrshr.u16	q0, q8, #8
	DCD	0xf3982272 ;	vrshr.u16	q1, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38824a4 ;	vraddhn.i16	d2, q12, q10
	DCD	0xf38a34a6 ;	vraddhn.i16	d3, q13, q11
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa020 ;	addne	sl, sl, #32
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf00a ;	pld	[fp, sl]
	DCD	0xf7dcf00a ;	pld	[ip, sl]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1005 ;	ldrbge	r1, [fp, r5]!
	DCD	0xa7fc1003 ;	ldrbge	r1, [ip, r3]!
	DCD	0xa7fe1008 ;	ldrbge	r1, [lr, r8]!
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000000 ;	beq	7b2c <pixman_composite_add_8_8_8_asm_neon+0x3ec>
	DCD	0xf442ea2d ;	vst1.8	{d30-d31}, [r2 :128]!
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000000 ;	beq	7b38 <pixman_composite_add_8_8_8_asm_neon+0x3f8>
	DCD	0xf442d71d ;	vst1.8	{d29}, [r2 :64]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000003 ;	beq	7b50 <pixman_composite_add_8_8_8_asm_neon+0x410>
	DCD	0xf4c2c08d ;	vst1.8	{d28[4]}, [r2]!
	DCD	0xf4c2c0ad ;	vst1.8	{d28[5]}, [r2]!
	DCD	0xf4c2c0cd ;	vst1.8	{d28[6]}, [r2]!
	DCD	0xf4c2c0ed ;	vst1.8	{d28[7]}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	7b60 <pixman_composite_add_8_8_8_asm_neon+0x420>
	DCD	0xf4c2c04d ;	vst1.8	{d28[2]}, [r2]!
	DCD	0xf4c2c06d ;	vst1.8	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	7b6c <pixman_composite_add_8_8_8_asm_neon+0x42c>
	DCD	0xf4c2c02d ;	vst1.8	{d28[1]}, [r2]!
	DCD	0xe1cd00d0 ;	ldrd	r0, [sp]
	DCD	0xe0822003 ;	add	r2, r2, r3
	DCD	0xe0844005 ;	add	r4, r4, r5
	DCD	0xe0877008 ;	add	r7, r7, r8
	DCD	0xe0422000 ;	sub	r2, r2, r0
	DCD	0xe0444000 ;	sub	r4, r4, r0
	DCD	0xe0477000 ;	sub	r7, r7, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe58d1004 ;	str	r1, [sp, #4]
	DCD	0xaafffefb ;	bge	7788 <pixman_composite_add_8_8_8_asm_neon+0x48>
	DCD	0xe8bd0003 ;	pop	{r0, r1}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100020 ;	tst	r0, #32
	DCD	0x0a000011 ;	beq	7bf0 <pixman_composite_add_8_8_8_asm_neon+0x4b0>
	DCD	0xf426420d ;	vld1.8	{d4-d7}, [r6]!
	DCD	0xf424020d ;	vld1.8	{d0-d3}, [r4]!
	DCD	0xf467820d ;	vld1.8	{d24-d27}, [r7]!
	DCD	0xf3c80c80 ;	vmull.u8	q8, d24, d0
	DCD	0xf3c92c81 ;	vmull.u8	q9, d25, d1
	DCD	0xf3ca4c82 ;	vmull.u8	q10, d26, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3980270 ;	vrshr.u16	q0, q8, #8
	DCD	0xf3982272 ;	vrshr.u16	q1, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38824a4 ;	vraddhn.i16	d2, q12, q10
	DCD	0xf38a34a6 ;	vraddhn.i16	d3, q13, q11
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xf442c20d ;	vst1.8	{d28-d31}, [r2]!
	DCD	0xe310001f ;	tst	r0, #31
	DCD	0x0a000045 ;	beq	7d10 <pixman_composite_add_8_8_8_asm_neon+0x5d0>
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000002 ;	beq	7c0c <pixman_composite_add_8_8_8_asm_neon+0x4cc>
	DCD	0xf4242a0d ;	vld1.8	{d2-d3}, [r4]!
	DCD	0xf467aa0d ;	vld1.8	{d26-d27}, [r7]!
	DCD	0xf4266a0d ;	vld1.8	{d6-d7}, [r6]!
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000002 ;	beq	7c20 <pixman_composite_add_8_8_8_asm_neon+0x4e0>
	DCD	0xf424170d ;	vld1.8	{d1}, [r4]!
	DCD	0xf467970d ;	vld1.8	{d25}, [r7]!
	DCD	0xf426570d ;	vld1.8	{d5}, [r6]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a00000b ;	beq	7c58 <pixman_composite_add_8_8_8_asm_neon+0x518>
	DCD	0xf4a4008d ;	vld1.8	{d0[4]}, [r4]!
	DCD	0xf4a400ad ;	vld1.8	{d0[5]}, [r4]!
	DCD	0xf4a400cd ;	vld1.8	{d0[6]}, [r4]!
	DCD	0xf4a400ed ;	vld1.8	{d0[7]}, [r4]!
	DCD	0xf4e7808d ;	vld1.8	{d24[4]}, [r7]!
	DCD	0xf4e780ad ;	vld1.8	{d24[5]}, [r7]!
	DCD	0xf4e780cd ;	vld1.8	{d24[6]}, [r7]!
	DCD	0xf4e780ed ;	vld1.8	{d24[7]}, [r7]!
	DCD	0xf4a6408d ;	vld1.8	{d4[4]}, [r6]!
	DCD	0xf4a640ad ;	vld1.8	{d4[5]}, [r6]!
	DCD	0xf4a640cd ;	vld1.8	{d4[6]}, [r6]!
	DCD	0xf4a640ed ;	vld1.8	{d4[7]}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000005 ;	beq	7c78 <pixman_composite_add_8_8_8_asm_neon+0x538>
	DCD	0xf4a4004d ;	vld1.8	{d0[2]}, [r4]!
	DCD	0xf4a4006d ;	vld1.8	{d0[3]}, [r4]!
	DCD	0xf4e7804d ;	vld1.8	{d24[2]}, [r7]!
	DCD	0xf4e7806d ;	vld1.8	{d24[3]}, [r7]!
	DCD	0xf4a6404d ;	vld1.8	{d4[2]}, [r6]!
	DCD	0xf4a6406d ;	vld1.8	{d4[3]}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	7c8c <pixman_composite_add_8_8_8_asm_neon+0x54c>
	DCD	0xf4a4002d ;	vld1.8	{d0[1]}, [r4]!
	DCD	0xf4e7802d ;	vld1.8	{d24[1]}, [r7]!
	DCD	0xf4a6402d ;	vld1.8	{d4[1]}, [r6]!
	DCD	0xf3c80c80 ;	vmull.u8	q8, d24, d0
	DCD	0xf3c92c81 ;	vmull.u8	q9, d25, d1
	DCD	0xf3ca4c82 ;	vmull.u8	q10, d26, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3980270 ;	vrshr.u16	q0, q8, #8
	DCD	0xf3982272 ;	vrshr.u16	q1, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38824a4 ;	vraddhn.i16	d2, q12, q10
	DCD	0xf38a34a6 ;	vraddhn.i16	d3, q13, q11
	DCD	0xf340c054 ;	vqadd.u8	q14, q0, q2
	DCD	0xf342e056 ;	vqadd.u8	q15, q1, q3
	DCD	0xe3100010 ;	tst	r0, #16
	DCD	0x0a000000 ;	beq	7cd0 <pixman_composite_add_8_8_8_asm_neon+0x590>
	DCD	0xf442ea0d ;	vst1.8	{d30-d31}, [r2]!
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000000 ;	beq	7cdc <pixman_composite_add_8_8_8_asm_neon+0x59c>
	DCD	0xf442d70d ;	vst1.8	{d29}, [r2]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000003 ;	beq	7cf4 <pixman_composite_add_8_8_8_asm_neon+0x5b4>
	DCD	0xf4c2c08d ;	vst1.8	{d28[4]}, [r2]!
	DCD	0xf4c2c0ad ;	vst1.8	{d28[5]}, [r2]!
	DCD	0xf4c2c0cd ;	vst1.8	{d28[6]}, [r2]!
	DCD	0xf4c2c0ed ;	vst1.8	{d28[7]}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	7d04 <pixman_composite_add_8_8_8_asm_neon+0x5c4>
	DCD	0xf4c2c04d ;	vst1.8	{d28[2]}, [r2]!
	DCD	0xf4c2c06d ;	vst1.8	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	7d10 <pixman_composite_add_8_8_8_asm_neon+0x5d0>
	DCD	0xf4c2c02d ;	vst1.8	{d28[1]}, [r2]!
	DCD	0xe1cd00d0 ;	ldrd	r0, [sp]
	DCD	0xe0822003 ;	add	r2, r2, r3
	DCD	0xe0844005 ;	add	r4, r4, r5
	DCD	0xe0877008 ;	add	r7, r7, r8
	DCD	0xe0422000 ;	sub	r2, r2, r0
	DCD	0xe0444000 ;	sub	r4, r4, r0
	DCD	0xe0477000 ;	sub	r7, r7, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe58d1004 ;	str	r1, [sp, #4]
	DCD	0xaaffff98 ;	bge	7ba0 <pixman_composite_add_8_8_8_asm_neon+0x460>
	DCD	0xe8bd0003 ;	pop	{r0, r1}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_add_8_8_8_asm_neon|

|pixman_composite_add_8888_8888_8888_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe59d7030 ;	ldr	r7, [sp, #48]	; 0x30
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe59d8034 ;	ldr	r8, [sp, #52]	; 0x34
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe2499006 ;	sub	r9, r9, #6
	DCD	0xe92d0003 ;	push	{r0, r1}
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe58d1004 ;	str	r1, [sp, #4]
	DCD	0xba000138 ;	blt	8268 <pixman_composite_add_8888_8888_8888_asm_neon+0x524>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba0000df ;	blt	810c <pixman_composite_add_8888_8888_8888_asm_neon+0x3c8>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000044 ;	beq	7ea8 <pixman_composite_add_8888_8888_8888_asm_neon+0x164>
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000004 ;	beq	7db0 <pixman_composite_add_8888_8888_8888_asm_neon+0x6c>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf4e7888d ;	vld1.32	{d24[1]}, [r7]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000004 ;	beq	7dcc <pixman_composite_add_8888_8888_8888_asm_neon+0x88>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xf467978d ;	vld1.32	{d25}, [r7]!
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xf467aa8d ;	vld1.32	{d26-d27}, [r7]!
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3f28129 ;	vuzp.8	d24, d25
	DCD	0xf3f2a12b ;	vuzp.8	d26, d27
	DCD	0xf3f2912b ;	vuzp.8	d25, d27
	DCD	0xf3f2812a ;	vuzp.8	d24, d26
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf7def10a ;	pld	[lr, sl, lsl #2]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1105 ;	ldrbge	r1, [fp, r5, lsl #2]!
	DCD	0xa7fc1103 ;	ldrbge	r1, [ip, r3, lsl #2]!
	DCD	0xa7fe1108 ;	ldrbge	r1, [lr, r8, lsl #2]!
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000000 ;	beq	7e98 <pixman_composite_add_8888_8888_8888_asm_neon+0x154>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	7ea4 <pixman_composite_add_8888_8888_8888_asm_neon+0x160>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xf426402d ;	vld4.8	{d4-d7}, [r6 :128]!
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xf467800d ;	vld4.8	{d24-d27}, [r7]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf7def10a ;	pld	[lr, sl, lsl #2]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1105 ;	ldrbge	r1, [fp, r5, lsl #2]!
	DCD	0xa7fc1103 ;	ldrbge	r1, [ip, r3, lsl #2]!
	DCD	0xa7fe1108 ;	ldrbge	r1, [lr, r8, lsl #2]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba000021 ;	blt	7f9c <pixman_composite_add_8888_8888_8888_asm_neon+0x258>
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf467800d ;	vld4.8	{d24-d27}, [r7]!
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf426402d ;	vld4.8	{d4-d7}, [r6 :128]!
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf7def10a ;	pld	[lr, sl, lsl #2]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1105 ;	ldrbge	r1, [fp, r5, lsl #2]!
	DCD	0xa7fc1103 ;	ldrbge	r1, [ip, r3, lsl #2]!
	DCD	0xa7fe1108 ;	ldrbge	r1, [lr, r8, lsl #2]!
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffdd ;	bge	7f14 <pixman_composite_add_8888_8888_8888_asm_neon+0x1d0>
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000045 ;	beq	80d8 <pixman_composite_add_8888_8888_8888_asm_neon+0x394>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000003 ;	beq	7fd8 <pixman_composite_add_8888_8888_8888_asm_neon+0x294>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xf467aa8d ;	vld1.32	{d26-d27}, [r7]!
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000003 ;	beq	7ff0 <pixman_composite_add_8888_8888_8888_asm_neon+0x2ac>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xf467978d ;	vld1.32	{d25}, [r7]!
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000003 ;	beq	8008 <pixman_composite_add_8888_8888_8888_asm_neon+0x2c4>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf4e7888d ;	vld1.32	{d24[1]}, [r7]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3f28129 ;	vuzp.8	d24, d25
	DCD	0xf3f2a12b ;	vuzp.8	d26, d27
	DCD	0xf3f2912b ;	vuzp.8	d25, d27
	DCD	0xf3f2812a ;	vuzp.8	d24, d26
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf7def10a ;	pld	[lr, sl, lsl #2]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1105 ;	ldrbge	r1, [fp, r5, lsl #2]!
	DCD	0xa7fc1103 ;	ldrbge	r1, [ip, r3, lsl #2]!
	DCD	0xa7fe1108 ;	ldrbge	r1, [lr, r8, lsl #2]!
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	80c0 <pixman_composite_add_8888_8888_8888_asm_neon+0x37c>
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	80cc <pixman_composite_add_8888_8888_8888_asm_neon+0x388>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	80d8 <pixman_composite_add_8888_8888_8888_asm_neon+0x394>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1cd00d0 ;	ldrd	r0, [sp]
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0877108 ;	add	r7, r7, r8, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe0477100 ;	sub	r7, r7, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe58d1004 ;	str	r1, [sp, #4]
	DCD	0xaaffff21 ;	bge	7d8c <pixman_composite_add_8888_8888_8888_asm_neon+0x48>
	DCD	0xe8bd0003 ;	pop	{r0, r1}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000011 ;	beq	815c <pixman_composite_add_8888_8888_8888_asm_neon+0x418>
	DCD	0xf426400d ;	vld4.8	{d4-d7}, [r6]!
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xf467800d ;	vld4.8	{d24-d27}, [r7]!
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf442c00d ;	vst4.8	{d28-d31}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000035 ;	beq	823c <pixman_composite_add_8888_8888_8888_asm_neon+0x4f8>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000002 ;	beq	8178 <pixman_composite_add_8888_8888_8888_asm_neon+0x434>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xf467aa8d ;	vld1.32	{d26-d27}, [r7]!
	DCD	0xf4266a8d ;	vld1.32	{d6-d7}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000002 ;	beq	818c <pixman_composite_add_8888_8888_8888_asm_neon+0x448>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xf467978d ;	vld1.32	{d25}, [r7]!
	DCD	0xf426578d ;	vld1.32	{d5}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	81a0 <pixman_composite_add_8888_8888_8888_asm_neon+0x45c>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf4e7888d ;	vld1.32	{d24[1]}, [r7]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3f28129 ;	vuzp.8	d24, d25
	DCD	0xf3f2a12b ;	vuzp.8	d26, d27
	DCD	0xf3f2912b ;	vuzp.8	d25, d27
	DCD	0xf3f2812a ;	vuzp.8	d24, d26
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	8224 <pixman_composite_add_8888_8888_8888_asm_neon+0x4e0>
	DCD	0xf442ea8d ;	vst1.32	{d30-d31}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	8230 <pixman_composite_add_8888_8888_8888_asm_neon+0x4ec>
	DCD	0xf442d78d ;	vst1.32	{d29}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	823c <pixman_composite_add_8888_8888_8888_asm_neon+0x4f8>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1cd00d0 ;	ldrd	r0, [sp]
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0877108 ;	add	r7, r7, r8, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe0477100 ;	sub	r7, r7, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe58d1004 ;	str	r1, [sp, #4]
	DCD	0xaaffffa8 ;	bge	810c <pixman_composite_add_8888_8888_8888_asm_neon+0x3c8>
	DCD	0xe8bd0003 ;	pop	{r0, r1}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_add_8888_8888_8888_asm_neon|

|pixman_composite_scanline_add_mask_asm_neon| PROC
	DCD	0xe1a0c001 ;	mov	ip, r1
	DCD	0xe3500008 ;	cmp	r0, #8
	DCD	0xba000099 ;	blt	84e4 <pixman_composite_scanline_add_mask_asm_neon+0x274>
	DCD	0xe31c000f ;	tst	ip, #15
	DCD	0x0a000034 ;	beq	8358 <pixman_composite_scanline_add_mask_asm_neon+0xe8>
	DCD	0xe31c0004 ;	tst	ip, #4
	DCD	0x0a000003 ;	beq	829c <pixman_composite_scanline_add_mask_asm_neon+0x2c>
	DCD	0xf4a2088d ;	vld1.32	{d0[1]}, [r2]!
	DCD	0xf4e3888d ;	vld1.32	{d24[1]}, [r3]!
	DCD	0xf4ac488d ;	vld1.32	{d4[1]}, [ip]!
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe31c0008 ;	tst	ip, #8
	DCD	0x0a000003 ;	beq	82b4 <pixman_composite_scanline_add_mask_asm_neon+0x44>
	DCD	0xf422178d ;	vld1.32	{d1}, [r2]!
	DCD	0xf463978d ;	vld1.32	{d25}, [r3]!
	DCD	0xf42c579d ;	vld1.32	{d5}, [ip :64]!
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xf4222a8d ;	vld1.32	{d2-d3}, [r2]!
	DCD	0xf463aa8d ;	vld1.32	{d26-d27}, [r3]!
	DCD	0xf42c6aad ;	vld1.32	{d6-d7}, [ip :128]!
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3f28129 ;	vuzp.8	d24, d25
	DCD	0xf3f2a12b ;	vuzp.8	d26, d27
	DCD	0xf3f2912b ;	vuzp.8	d25, d27
	DCD	0xf3f2812a ;	vuzp.8	d24, d26
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3110004 ;	tst	r1, #4
	DCD	0x0a000000 ;	beq	8348 <pixman_composite_scanline_add_mask_asm_neon+0xd8>
	DCD	0xf4c1c88d ;	vst1.32	{d28[1]}, [r1]!
	DCD	0xe3110008 ;	tst	r1, #8
	DCD	0x0a000000 ;	beq	8354 <pixman_composite_scanline_add_mask_asm_neon+0xe4>
	DCD	0xf441d79d ;	vst1.32	{d29}, [r1 :64]!
	DCD	0xf441eaad ;	vst1.32	{d30-d31}, [r1 :128]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xba000027 ;	blt	8400 <pixman_composite_scanline_add_mask_asm_neon+0x190>
	DCD	0xf42c402d ;	vld4.8	{d4-d7}, [ip :128]!
	DCD	0xf422000d ;	vld4.8	{d0-d3}, [r2]!
	DCD	0xf463800d ;	vld4.8	{d24-d27}, [r3]!
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xba000013 ;	blt	83e4 <pixman_composite_scanline_add_mask_asm_neon+0x174>
	DCD	0xf422000d ;	vld4.8	{d0-d3}, [r2]!
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf463800d ;	vld4.8	{d24-d27}, [r3]!
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf42c402d ;	vld4.8	{d4-d7}, [ip :128]!
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf441c02d ;	vst4.8	{d28-d31}, [r1 :128]!
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffeb ;	bge	8394 <pixman_composite_scanline_add_mask_asm_neon+0x124>
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf441c02d ;	vst4.8	{d28-d31}, [r1 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000035 ;	beq	84e0 <pixman_composite_scanline_add_mask_asm_neon+0x270>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000002 ;	beq	841c <pixman_composite_scanline_add_mask_asm_neon+0x1ac>
	DCD	0xf4222a8d ;	vld1.32	{d2-d3}, [r2]!
	DCD	0xf463aa8d ;	vld1.32	{d26-d27}, [r3]!
	DCD	0xf42c6aad ;	vld1.32	{d6-d7}, [ip :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000002 ;	beq	8430 <pixman_composite_scanline_add_mask_asm_neon+0x1c0>
	DCD	0xf422178d ;	vld1.32	{d1}, [r2]!
	DCD	0xf463978d ;	vld1.32	{d25}, [r3]!
	DCD	0xf42c579d ;	vld1.32	{d5}, [ip :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	8444 <pixman_composite_scanline_add_mask_asm_neon+0x1d4>
	DCD	0xf4a2088d ;	vld1.32	{d0[1]}, [r2]!
	DCD	0xf4e3888d ;	vld1.32	{d24[1]}, [r3]!
	DCD	0xf4ac488d ;	vld1.32	{d4[1]}, [ip]!
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3f28129 ;	vuzp.8	d24, d25
	DCD	0xf3f2a12b ;	vuzp.8	d26, d27
	DCD	0xf3f2912b ;	vuzp.8	d25, d27
	DCD	0xf3f2812a ;	vuzp.8	d24, d26
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	84c8 <pixman_composite_scanline_add_mask_asm_neon+0x258>
	DCD	0xf441eaad ;	vst1.32	{d30-d31}, [r1 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	84d4 <pixman_composite_scanline_add_mask_asm_neon+0x264>
	DCD	0xf441d79d ;	vst1.32	{d29}, [r1 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	84e0 <pixman_composite_scanline_add_mask_asm_neon+0x270>
	DCD	0xf4c1c88d ;	vst1.32	{d28[1]}, [r1]!
	DCD	0xe12fff1e ;	bx	lr
	;		84e0: R_ARM_V4BX	*ABS*
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000035 ;	beq	85c4 <pixman_composite_scanline_add_mask_asm_neon+0x354>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000002 ;	beq	8500 <pixman_composite_scanline_add_mask_asm_neon+0x290>
	DCD	0xf4222a8d ;	vld1.32	{d2-d3}, [r2]!
	DCD	0xf463aa8d ;	vld1.32	{d26-d27}, [r3]!
	DCD	0xf42c6a8d ;	vld1.32	{d6-d7}, [ip]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000002 ;	beq	8514 <pixman_composite_scanline_add_mask_asm_neon+0x2a4>
	DCD	0xf422178d ;	vld1.32	{d1}, [r2]!
	DCD	0xf463978d ;	vld1.32	{d25}, [r3]!
	DCD	0xf42c578d ;	vld1.32	{d5}, [ip]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	8528 <pixman_composite_scanline_add_mask_asm_neon+0x2b8>
	DCD	0xf4a2088d ;	vld1.32	{d0[1]}, [r2]!
	DCD	0xf4e3888d ;	vld1.32	{d24[1]}, [r3]!
	DCD	0xf4ac488d ;	vld1.32	{d4[1]}, [ip]!
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3f28129 ;	vuzp.8	d24, d25
	DCD	0xf3f2a12b ;	vuzp.8	d26, d27
	DCD	0xf3f2912b ;	vuzp.8	d25, d27
	DCD	0xf3f2812a ;	vuzp.8	d24, d26
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	85ac <pixman_composite_scanline_add_mask_asm_neon+0x33c>
	DCD	0xf441ea8d ;	vst1.32	{d30-d31}, [r1]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	85b8 <pixman_composite_scanline_add_mask_asm_neon+0x348>
	DCD	0xf441d78d ;	vst1.32	{d29}, [r1]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	85c4 <pixman_composite_scanline_add_mask_asm_neon+0x354>
	DCD	0xf4c1c88d ;	vst1.32	{d28[1]}, [r1]!
	DCD	0xe12fff1e ;	bx	lr
	;		85c4: R_ARM_V4BX	*ABS*
	ENDP  ; |pixman_composite_scanline_add_mask_asm_neon|

|pixman_composite_add_8888_8_8888_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe59d7030 ;	ldr	r7, [sp, #48]	; 0x30
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe59d8034 ;	ldr	r8, [sp, #52]	; 0x34
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xe92d0003 ;	push	{r0, r1}
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe58d1004 ;	str	r1, [sp, #4]
	DCD	0xba000138 ;	blt	8aec <pixman_composite_add_8888_8_8888_asm_neon+0x524>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba0000df ;	blt	8990 <pixman_composite_add_8888_8_8888_asm_neon+0x3c8>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000044 ;	beq	872c <pixman_composite_add_8888_8_8888_asm_neon+0x164>
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000004 ;	beq	8634 <pixman_composite_add_8888_8_8888_asm_neon+0x6c>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf4e7b02d ;	vld1.8	{d27[1]}, [r7]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000005 ;	beq	8654 <pixman_composite_add_8888_8_8888_asm_neon+0x8c>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xf4e7b04d ;	vld1.8	{d27[2]}, [r7]!
	DCD	0xf4e7b06d ;	vld1.8	{d27[3]}, [r7]!
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xf4e7b08d ;	vld1.8	{d27[4]}, [r7]!
	DCD	0xf4e7b0ad ;	vld1.8	{d27[5]}, [r7]!
	DCD	0xf4e7b0cd ;	vld1.8	{d27[6]}, [r7]!
	DCD	0xf4e7b0ed ;	vld1.8	{d27[7]}, [r7]!
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1105 ;	ldrbge	r1, [fp, r5, lsl #2]!
	DCD	0xa7fc1103 ;	ldrbge	r1, [ip, r3, lsl #2]!
	DCD	0xa7fe1008 ;	ldrbge	r1, [lr, r8]!
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000000 ;	beq	871c <pixman_composite_add_8888_8_8888_asm_neon+0x154>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	8728 <pixman_composite_add_8888_8_8888_asm_neon+0x160>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xf426402d ;	vld4.8	{d4-d7}, [r6 :128]!
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xf467b70d ;	vld1.8	{d27}, [r7]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1105 ;	ldrbge	r1, [fp, r5, lsl #2]!
	DCD	0xa7fc1103 ;	ldrbge	r1, [ip, r3, lsl #2]!
	DCD	0xa7fe1008 ;	ldrbge	r1, [lr, r8]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba000021 ;	blt	8820 <pixman_composite_add_8888_8_8888_asm_neon+0x258>
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf467b70d ;	vld1.8	{d27}, [r7]!
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf426402d ;	vld4.8	{d4-d7}, [r6 :128]!
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1105 ;	ldrbge	r1, [fp, r5, lsl #2]!
	DCD	0xa7fc1103 ;	ldrbge	r1, [ip, r3, lsl #2]!
	DCD	0xa7fe1008 ;	ldrbge	r1, [lr, r8]!
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffdd ;	bge	8798 <pixman_composite_add_8888_8_8888_asm_neon+0x1d0>
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000045 ;	beq	895c <pixman_composite_add_8888_8_8888_asm_neon+0x394>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000006 ;	beq	8868 <pixman_composite_add_8888_8_8888_asm_neon+0x2a0>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xf4e7b08d ;	vld1.8	{d27[4]}, [r7]!
	DCD	0xf4e7b0ad ;	vld1.8	{d27[5]}, [r7]!
	DCD	0xf4e7b0cd ;	vld1.8	{d27[6]}, [r7]!
	DCD	0xf4e7b0ed ;	vld1.8	{d27[7]}, [r7]!
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000004 ;	beq	8884 <pixman_composite_add_8888_8_8888_asm_neon+0x2bc>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xf4e7b04d ;	vld1.8	{d27[2]}, [r7]!
	DCD	0xf4e7b06d ;	vld1.8	{d27[3]}, [r7]!
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000003 ;	beq	889c <pixman_composite_add_8888_8_8888_asm_neon+0x2d4>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf4e7b02d ;	vld1.8	{d27[1]}, [r7]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1105 ;	ldrbge	r1, [fp, r5, lsl #2]!
	DCD	0xa7fc1103 ;	ldrbge	r1, [ip, r3, lsl #2]!
	DCD	0xa7fe1008 ;	ldrbge	r1, [lr, r8]!
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	8944 <pixman_composite_add_8888_8_8888_asm_neon+0x37c>
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	8950 <pixman_composite_add_8888_8_8888_asm_neon+0x388>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	895c <pixman_composite_add_8888_8_8888_asm_neon+0x394>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1cd00d0 ;	ldrd	r0, [sp]
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0877008 ;	add	r7, r7, r8
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe0477000 ;	sub	r7, r7, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe58d1004 ;	str	r1, [sp, #4]
	DCD	0xaaffff21 ;	bge	8610 <pixman_composite_add_8888_8_8888_asm_neon+0x48>
	DCD	0xe8bd0003 ;	pop	{r0, r1}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000011 ;	beq	89e0 <pixman_composite_add_8888_8_8888_asm_neon+0x418>
	DCD	0xf426400d ;	vld4.8	{d4-d7}, [r6]!
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xf467b70d ;	vld1.8	{d27}, [r7]!
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf442c00d ;	vst4.8	{d28-d31}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000035 ;	beq	8ac0 <pixman_composite_add_8888_8_8888_asm_neon+0x4f8>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000005 ;	beq	8a08 <pixman_composite_add_8888_8_8888_asm_neon+0x440>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xf4e7b08d ;	vld1.8	{d27[4]}, [r7]!
	DCD	0xf4e7b0ad ;	vld1.8	{d27[5]}, [r7]!
	DCD	0xf4e7b0cd ;	vld1.8	{d27[6]}, [r7]!
	DCD	0xf4e7b0ed ;	vld1.8	{d27[7]}, [r7]!
	DCD	0xf4266a8d ;	vld1.32	{d6-d7}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000003 ;	beq	8a20 <pixman_composite_add_8888_8_8888_asm_neon+0x458>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xf4e7b04d ;	vld1.8	{d27[2]}, [r7]!
	DCD	0xf4e7b06d ;	vld1.8	{d27[3]}, [r7]!
	DCD	0xf426578d ;	vld1.32	{d5}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	8a34 <pixman_composite_add_8888_8_8888_asm_neon+0x46c>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf4e7b02d ;	vld1.8	{d27[1]}, [r7]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	8aa8 <pixman_composite_add_8888_8_8888_asm_neon+0x4e0>
	DCD	0xf442ea8d ;	vst1.32	{d30-d31}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	8ab4 <pixman_composite_add_8888_8_8888_asm_neon+0x4ec>
	DCD	0xf442d78d ;	vst1.32	{d29}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	8ac0 <pixman_composite_add_8888_8_8888_asm_neon+0x4f8>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1cd00d0 ;	ldrd	r0, [sp]
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0877008 ;	add	r7, r7, r8
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe0477000 ;	sub	r7, r7, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe58d1004 ;	str	r1, [sp, #4]
	DCD	0xaaffffa8 ;	bge	8990 <pixman_composite_add_8888_8_8888_asm_neon+0x3c8>
	DCD	0xe8bd0003 ;	pop	{r0, r1}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_add_8888_8_8888_asm_neon|

|pixman_composite_add_n_8_8888_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d7030 ;	ldr	r7, [sp, #48]	; 0x30
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d8034 ;	ldr	r8, [sp, #52]	; 0x34
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xe28d5028 ;	add	r5, sp, #40	; 0x28
	DCD	0xf4a5380f ;	vld1.32	{d3[0]}, [r5]
	DCD	0xf3b10c03 ;	vdup.8	d0, d3[0]
	DCD	0xf3b31c03 ;	vdup.8	d1, d3[1]
	DCD	0xf3b52c03 ;	vdup.8	d2, d3[2]
	DCD	0xf3b73c03 ;	vdup.8	d3, d3[3]
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a04000 ;	mov	r4, r0
	DCD	0xba00010d ;	blt	8f78 <pixman_composite_add_n_8_8888_asm_neon+0x484>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba0000bf ;	blt	8e48 <pixman_composite_add_n_8_8888_asm_neon+0x354>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a00003a ;	beq	8c3c <pixman_composite_add_n_8_8888_asm_neon+0x148>
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000003 ;	beq	8b68 <pixman_composite_add_n_8_8888_asm_neon+0x74>
	DCD	0xf4e7b02d ;	vld1.8	{d27[1]}, [r7]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000004 ;	beq	8b84 <pixman_composite_add_n_8_8888_asm_neon+0x90>
	DCD	0xf4e7b04d ;	vld1.8	{d27[2]}, [r7]!
	DCD	0xf4e7b06d ;	vld1.8	{d27[3]}, [r7]!
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xf4e7b08d ;	vld1.8	{d27[4]}, [r7]!
	DCD	0xf4e7b0ad ;	vld1.8	{d27[5]}, [r7]!
	DCD	0xf4e7b0cd ;	vld1.8	{d27[6]}, [r7]!
	DCD	0xf4e7b0ed ;	vld1.8	{d27[7]}, [r7]!
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc5103 ;	ldrbge	r5, [ip, r3, lsl #2]!
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000000 ;	beq	8c2c <pixman_composite_add_n_8_8888_asm_neon+0x138>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	8c38 <pixman_composite_add_n_8_8888_asm_neon+0x144>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xf426402d ;	vld4.8	{d4-d7}, [r6 :128]!
	DCD	0xf467b70d ;	vld1.8	{d27}, [r7]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc5103 ;	ldrbge	r5, [ip, r3, lsl #2]!
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba00001d ;	blt	8d10 <pixman_composite_add_n_8_8888_asm_neon+0x21c>
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf467b70d ;	vld1.8	{d27}, [r7]!
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf426402d ;	vld4.8	{d4-d7}, [r6 :128]!
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc5103 ;	ldrbge	r5, [ip, r3, lsl #2]!
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffe1 ;	bge	8c98 <pixman_composite_add_n_8_8888_asm_neon+0x1a4>
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00003b ;	beq	8e24 <pixman_composite_add_n_8_8888_asm_neon+0x330>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000005 ;	beq	8d54 <pixman_composite_add_n_8_8888_asm_neon+0x260>
	DCD	0xf4e7b08d ;	vld1.8	{d27[4]}, [r7]!
	DCD	0xf4e7b0ad ;	vld1.8	{d27[5]}, [r7]!
	DCD	0xf4e7b0cd ;	vld1.8	{d27[6]}, [r7]!
	DCD	0xf4e7b0ed ;	vld1.8	{d27[7]}, [r7]!
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000003 ;	beq	8d6c <pixman_composite_add_n_8_8888_asm_neon+0x278>
	DCD	0xf4e7b04d ;	vld1.8	{d27[2]}, [r7]!
	DCD	0xf4e7b06d ;	vld1.8	{d27[3]}, [r7]!
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	8d80 <pixman_composite_add_n_8_8888_asm_neon+0x28c>
	DCD	0xf4e7b02d ;	vld1.8	{d27[1]}, [r7]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0004 ;	cmp	sl, r4
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa004 ;	subge	sl, sl, r4
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fc5103 ;	ldrbge	r5, [ip, r3, lsl #2]!
	DCD	0xa7fe5008 ;	ldrbge	r5, [lr, r8]!
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	8e0c <pixman_composite_add_n_8_8888_asm_neon+0x318>
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	8e18 <pixman_composite_add_n_8_8888_asm_neon+0x324>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	8e24 <pixman_composite_add_n_8_8888_asm_neon+0x330>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00004 ;	mov	r0, r4
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0877008 ;	add	r7, r7, r8
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0477000 ;	sub	r7, r7, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff40 ;	bge	8b48 <pixman_composite_add_n_8_8888_asm_neon+0x54>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000010 ;	beq	8e94 <pixman_composite_add_n_8_8888_asm_neon+0x3a0>
	DCD	0xf426400d ;	vld4.8	{d4-d7}, [r6]!
	DCD	0xf467b70d ;	vld1.8	{d27}, [r7]!
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf442c00d ;	vst4.8	{d28-d31}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00002e ;	beq	8f58 <pixman_composite_add_n_8_8888_asm_neon+0x464>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000004 ;	beq	8eb8 <pixman_composite_add_n_8_8888_asm_neon+0x3c4>
	DCD	0xf4e7b08d ;	vld1.8	{d27[4]}, [r7]!
	DCD	0xf4e7b0ad ;	vld1.8	{d27[5]}, [r7]!
	DCD	0xf4e7b0cd ;	vld1.8	{d27[6]}, [r7]!
	DCD	0xf4e7b0ed ;	vld1.8	{d27[7]}, [r7]!
	DCD	0xf4266a8d ;	vld1.32	{d6-d7}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000002 ;	beq	8ecc <pixman_composite_add_n_8_8888_asm_neon+0x3d8>
	DCD	0xf4e7b04d ;	vld1.8	{d27[2]}, [r7]!
	DCD	0xf4e7b06d ;	vld1.8	{d27[3]}, [r7]!
	DCD	0xf426578d ;	vld1.32	{d5}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	8edc <pixman_composite_add_n_8_8888_asm_neon+0x3e8>
	DCD	0xf4e7b02d ;	vld1.8	{d27[1]}, [r7]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	8f40 <pixman_composite_add_n_8_8888_asm_neon+0x44c>
	DCD	0xf442ea8d ;	vst1.32	{d30-d31}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	8f4c <pixman_composite_add_n_8_8888_asm_neon+0x458>
	DCD	0xf442d78d ;	vst1.32	{d29}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	8f58 <pixman_composite_add_n_8_8888_asm_neon+0x464>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00004 ;	mov	r0, r4
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0877008 ;	add	r7, r7, r8
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0477000 ;	sub	r7, r7, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffb3 ;	bge	8e48 <pixman_composite_add_n_8_8888_asm_neon+0x354>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_add_n_8_8888_asm_neon|

|pixman_composite_add_8888_n_8888_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xe28d8030 ;	add	r8, sp, #48	; 0x30
	DCD	0xf4e8b80f ;	vld1.32	{d27[0]}, [r8]
	DCD	0xf3f7bc2b ;	vdup.8	d27, d27[3]
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a07000 ;	mov	r7, r0
	DCD	0xba00010d ;	blt	93f4 <pixman_composite_add_8888_n_8888_asm_neon+0x478>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba0000bf ;	blt	92c4 <pixman_composite_add_8888_n_8888_asm_neon+0x348>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a00003a ;	beq	90b8 <pixman_composite_add_8888_n_8888_asm_neon+0x13c>
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000003 ;	beq	8fe4 <pixman_composite_add_8888_n_8888_asm_neon+0x68>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000003 ;	beq	8ffc <pixman_composite_add_8888_n_8888_asm_neon+0x80>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000000 ;	beq	90a8 <pixman_composite_add_8888_n_8888_asm_neon+0x12c>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	90b4 <pixman_composite_add_8888_n_8888_asm_neon+0x138>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xf426402d ;	vld4.8	{d4-d7}, [r6 :128]!
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba00001d ;	blt	918c <pixman_composite_add_8888_n_8888_asm_neon+0x210>
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf426402d ;	vld4.8	{d4-d7}, [r6 :128]!
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffe1 ;	bge	9114 <pixman_composite_add_8888_n_8888_asm_neon+0x198>
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00003b ;	beq	92a0 <pixman_composite_add_8888_n_8888_asm_neon+0x324>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000002 ;	beq	91c4 <pixman_composite_add_8888_n_8888_asm_neon+0x248>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000002 ;	beq	91d8 <pixman_composite_add_8888_n_8888_asm_neon+0x25c>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	91ec <pixman_composite_add_8888_n_8888_asm_neon+0x270>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	9288 <pixman_composite_add_8888_n_8888_asm_neon+0x30c>
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	9294 <pixman_composite_add_8888_n_8888_asm_neon+0x318>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	92a0 <pixman_composite_add_8888_n_8888_asm_neon+0x324>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff40 ;	bge	8fc4 <pixman_composite_add_8888_n_8888_asm_neon+0x48>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000010 ;	beq	9310 <pixman_composite_add_8888_n_8888_asm_neon+0x394>
	DCD	0xf426400d ;	vld4.8	{d4-d7}, [r6]!
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf442c00d ;	vst4.8	{d28-d31}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00002e ;	beq	93d4 <pixman_composite_add_8888_n_8888_asm_neon+0x458>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000001 ;	beq	9328 <pixman_composite_add_8888_n_8888_asm_neon+0x3ac>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xf4266a8d ;	vld1.32	{d6-d7}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	9338 <pixman_composite_add_8888_n_8888_asm_neon+0x3bc>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xf426578d ;	vld1.32	{d5}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	9348 <pixman_composite_add_8888_n_8888_asm_neon+0x3cc>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cb0c80 ;	vmull.u8	q8, d27, d0
	DCD	0xf3cb2c81 ;	vmull.u8	q9, d27, d1
	DCD	0xf3cb4c82 ;	vmull.u8	q10, d27, d2
	DCD	0xf3cb6c83 ;	vmull.u8	q11, d27, d3
	DCD	0xf3d80370 ;	vrsra.u16	q8, q8, #8
	DCD	0xf3d82372 ;	vrsra.u16	q9, q9, #8
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xf2c8c870 ;	vrshrn.i16	d28, q8, #8
	DCD	0xf2c8d872 ;	vrshrn.i16	d29, q9, #8
	DCD	0xf2c8e874 ;	vrshrn.i16	d30, q10, #8
	DCD	0xf2c8f876 ;	vrshrn.i16	d31, q11, #8
	DCD	0xf344c07c ;	vqadd.u8	q14, q2, q14
	DCD	0xf346e07e ;	vqadd.u8	q15, q3, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	93bc <pixman_composite_add_8888_n_8888_asm_neon+0x440>
	DCD	0xf442ea8d ;	vst1.32	{d30-d31}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	93c8 <pixman_composite_add_8888_n_8888_asm_neon+0x44c>
	DCD	0xf442d78d ;	vst1.32	{d29}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	93d4 <pixman_composite_add_8888_n_8888_asm_neon+0x458>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffb3 ;	bge	92c4 <pixman_composite_add_8888_n_8888_asm_neon+0x348>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_add_8888_n_8888_asm_neon|

|pixman_composite_scanline_out_reverse_mask_asm_neon| PROC
	DCD	0xed2d8b10 ;	vpush	{d8-d15}
	DCD	0xe1a0c001 ;	mov	ip, r1
	DCD	0xe3500008 ;	cmp	r0, #8
	DCD	0xba0000c6 ;	blt	9724 <pixman_composite_scanline_out_reverse_mask_asm_neon+0x32c>
	DCD	0xe31c000f ;	tst	ip, #15
	DCD	0x0a00003f ;	beq	9510 <pixman_composite_scanline_out_reverse_mask_asm_neon+0x118>
	DCD	0xe31c0004 ;	tst	ip, #4
	DCD	0x0a000003 ;	beq	9428 <pixman_composite_scanline_out_reverse_mask_asm_neon+0x30>
	DCD	0xf4a2088d ;	vld1.32	{d0[1]}, [r2]!
	DCD	0xf4a3c88d ;	vld1.32	{d12[1]}, [r3]!
	DCD	0xf4ac488d ;	vld1.32	{d4[1]}, [ip]!
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe31c0008 ;	tst	ip, #8
	DCD	0x0a000003 ;	beq	9440 <pixman_composite_scanline_out_reverse_mask_asm_neon+0x48>
	DCD	0xf422178d ;	vld1.32	{d1}, [r2]!
	DCD	0xf423d78d ;	vld1.32	{d13}, [r3]!
	DCD	0xf42c579d ;	vld1.32	{d5}, [ip :64]!
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xf4222a8d ;	vld1.32	{d2-d3}, [r2]!
	DCD	0xf423ea8d ;	vld1.32	{d14-d15}, [r3]!
	DCD	0xf42c6aad ;	vld1.32	{d6-d7}, [ip :128]!
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b2c10d ;	vuzp.8	d12, d13
	DCD	0xf3b2e10f ;	vuzp.8	d14, d15
	DCD	0xf3b2d10f ;	vuzp.8	d13, d15
	DCD	0xf3b2c10e ;	vuzp.8	d12, d14
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3110004 ;	tst	r1, #4
	DCD	0x0a000000 ;	beq	9500 <pixman_composite_scanline_out_reverse_mask_asm_neon+0x108>
	DCD	0xf4c1c88d ;	vst1.32	{d28[1]}, [r1]!
	DCD	0xe3110008 ;	tst	r1, #8
	DCD	0x0a000000 ;	beq	950c <pixman_composite_scanline_out_reverse_mask_asm_neon+0x114>
	DCD	0xf441d79d ;	vst1.32	{d29}, [r1 :64]!
	DCD	0xf441eaad ;	vst1.32	{d30-d31}, [r1 :128]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xba00003d ;	blt	9610 <pixman_composite_scanline_out_reverse_mask_asm_neon+0x218>
	DCD	0xf42c402d ;	vld4.8	{d4-d7}, [ip :128]!
	DCD	0xf422000d ;	vld4.8	{d0-d3}, [r2]!
	DCD	0xf423c00d ;	vld4.8	{d12-d15}, [r3]!
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xba00001e ;	blt	95ec <pixman_composite_scanline_out_reverse_mask_asm_neon+0x1f4>
	DCD	0xf42c402d ;	vld4.8	{d4-d7}, [ip :128]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf422000d ;	vld4.8	{d0-d3}, [r2]!
	DCD	0xf423c00d ;	vld4.8	{d12-d15}, [r3]!
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf441c02d ;	vst4.8	{d28-d31}, [r1 :128]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffe0 ;	bge	9570 <pixman_composite_scanline_out_reverse_mask_asm_neon+0x178>
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf441c02d ;	vst4.8	{d28-d31}, [r1 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000040 ;	beq	971c <pixman_composite_scanline_out_reverse_mask_asm_neon+0x324>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000002 ;	beq	962c <pixman_composite_scanline_out_reverse_mask_asm_neon+0x234>
	DCD	0xf4222a8d ;	vld1.32	{d2-d3}, [r2]!
	DCD	0xf423ea8d ;	vld1.32	{d14-d15}, [r3]!
	DCD	0xf42c6aad ;	vld1.32	{d6-d7}, [ip :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000002 ;	beq	9640 <pixman_composite_scanline_out_reverse_mask_asm_neon+0x248>
	DCD	0xf422178d ;	vld1.32	{d1}, [r2]!
	DCD	0xf423d78d ;	vld1.32	{d13}, [r3]!
	DCD	0xf42c579d ;	vld1.32	{d5}, [ip :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	9654 <pixman_composite_scanline_out_reverse_mask_asm_neon+0x25c>
	DCD	0xf4a2088d ;	vld1.32	{d0[1]}, [r2]!
	DCD	0xf4a3c88d ;	vld1.32	{d12[1]}, [r3]!
	DCD	0xf4ac488d ;	vld1.32	{d4[1]}, [ip]!
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b2c10d ;	vuzp.8	d12, d13
	DCD	0xf3b2e10f ;	vuzp.8	d14, d15
	DCD	0xf3b2d10f ;	vuzp.8	d13, d15
	DCD	0xf3b2c10e ;	vuzp.8	d12, d14
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	9704 <pixman_composite_scanline_out_reverse_mask_asm_neon+0x30c>
	DCD	0xf441eaad ;	vst1.32	{d30-d31}, [r1 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	9710 <pixman_composite_scanline_out_reverse_mask_asm_neon+0x318>
	DCD	0xf441d79d ;	vst1.32	{d29}, [r1 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	971c <pixman_composite_scanline_out_reverse_mask_asm_neon+0x324>
	DCD	0xf4c1c88d ;	vst1.32	{d28[1]}, [r1]!
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe12fff1e ;	bx	lr
	;		9720: R_ARM_V4BX	*ABS*
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000040 ;	beq	9830 <pixman_composite_scanline_out_reverse_mask_asm_neon+0x438>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000002 ;	beq	9740 <pixman_composite_scanline_out_reverse_mask_asm_neon+0x348>
	DCD	0xf4222a8d ;	vld1.32	{d2-d3}, [r2]!
	DCD	0xf423ea8d ;	vld1.32	{d14-d15}, [r3]!
	DCD	0xf42c6a8d ;	vld1.32	{d6-d7}, [ip]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000002 ;	beq	9754 <pixman_composite_scanline_out_reverse_mask_asm_neon+0x35c>
	DCD	0xf422178d ;	vld1.32	{d1}, [r2]!
	DCD	0xf423d78d ;	vld1.32	{d13}, [r3]!
	DCD	0xf42c578d ;	vld1.32	{d5}, [ip]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	9768 <pixman_composite_scanline_out_reverse_mask_asm_neon+0x370>
	DCD	0xf4a2088d ;	vld1.32	{d0[1]}, [r2]!
	DCD	0xf4a3c88d ;	vld1.32	{d12[1]}, [r3]!
	DCD	0xf4ac488d ;	vld1.32	{d4[1]}, [ip]!
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b2c10d ;	vuzp.8	d12, d13
	DCD	0xf3b2e10f ;	vuzp.8	d14, d15
	DCD	0xf3b2d10f ;	vuzp.8	d13, d15
	DCD	0xf3b2c10e ;	vuzp.8	d12, d14
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	9818 <pixman_composite_scanline_out_reverse_mask_asm_neon+0x420>
	DCD	0xf441ea8d ;	vst1.32	{d30-d31}, [r1]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	9824 <pixman_composite_scanline_out_reverse_mask_asm_neon+0x42c>
	DCD	0xf441d78d ;	vst1.32	{d29}, [r1]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	9830 <pixman_composite_scanline_out_reverse_mask_asm_neon+0x438>
	DCD	0xf4c1c88d ;	vst1.32	{d28[1]}, [r1]!
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe12fff1e ;	bx	lr
	;		9834: R_ARM_V4BX	*ABS*
	ENDP  ; |pixman_composite_scanline_out_reverse_mask_asm_neon|

|pixman_composite_over_8888_n_8888_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xe28d8030 ;	add	r8, sp, #48	; 0x30
	DCD	0xed2d8b10 ;	vpush	{d8-d15}
	DCD	0xf4a8f80f ;	vld1.32	{d15[0]}, [r8]
	DCD	0xf3b7fc0f ;	vdup.8	d15, d15[3]
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a07000 ;	mov	r7, r0
	DCD	0xba00015c ;	blt	9df0 <pixman_composite_over_8888_n_8888_asm_neon+0x5b8>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba0000f4 ;	blt	9c58 <pixman_composite_over_8888_n_8888_asm_neon+0x420>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000047 ;	beq	99ac <pixman_composite_over_8888_n_8888_asm_neon+0x174>
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000003 ;	beq	98a4 <pixman_composite_over_8888_n_8888_asm_neon+0x6c>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000003 ;	beq	98bc <pixman_composite_over_8888_n_8888_asm_neon+0x84>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000000 ;	beq	999c <pixman_composite_over_8888_n_8888_asm_neon+0x164>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	99a8 <pixman_composite_over_8888_n_8888_asm_neon+0x170>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xf426402d ;	vld4.8	{d4-d7}, [r6 :128]!
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba00002a ;	blt	9ad8 <pixman_composite_over_8888_n_8888_asm_neon+0x2a0>
	DCD	0xf426402d ;	vld4.8	{d4-d7}, [r6 :128]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffd4 ;	bge	9a2c <pixman_composite_over_8888_n_8888_asm_neon+0x1f4>
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000048 ;	beq	9c30 <pixman_composite_over_8888_n_8888_asm_neon+0x3f8>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000002 ;	beq	9b20 <pixman_composite_over_8888_n_8888_asm_neon+0x2e8>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000002 ;	beq	9b34 <pixman_composite_over_8888_n_8888_asm_neon+0x2fc>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	9b48 <pixman_composite_over_8888_n_8888_asm_neon+0x310>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	9c18 <pixman_composite_over_8888_n_8888_asm_neon+0x3e0>
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	9c24 <pixman_composite_over_8888_n_8888_asm_neon+0x3ec>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	9c30 <pixman_composite_over_8888_n_8888_asm_neon+0x3f8>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff0c ;	bge	9884 <pixman_composite_over_8888_n_8888_asm_neon+0x4c>
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a00001d ;	beq	9cd8 <pixman_composite_over_8888_n_8888_asm_neon+0x4a0>
	DCD	0xf426400d ;	vld4.8	{d4-d7}, [r6]!
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf442c00d ;	vst4.8	{d28-d31}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00003b ;	beq	9dd0 <pixman_composite_over_8888_n_8888_asm_neon+0x598>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000001 ;	beq	9cf0 <pixman_composite_over_8888_n_8888_asm_neon+0x4b8>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xf4266a8d ;	vld1.32	{d6-d7}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	9d00 <pixman_composite_over_8888_n_8888_asm_neon+0x4c8>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xf426578d ;	vld1.32	{d5}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	9d10 <pixman_composite_over_8888_n_8888_asm_neon+0x4d8>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	9db8 <pixman_composite_over_8888_n_8888_asm_neon+0x580>
	DCD	0xf442ea8d ;	vst1.32	{d30-d31}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	9dc4 <pixman_composite_over_8888_n_8888_asm_neon+0x58c>
	DCD	0xf442d78d ;	vst1.32	{d29}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	9dd0 <pixman_composite_over_8888_n_8888_asm_neon+0x598>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff99 ;	bge	9c58 <pixman_composite_over_8888_n_8888_asm_neon+0x420>
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_over_8888_n_8888_asm_neon|

|pixman_composite_over_8888_8888_8888_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe59d7030 ;	ldr	r7, [sp, #48]	; 0x30
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe59d8034 ;	ldr	r8, [sp, #52]	; 0x34
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xed2d8b10 ;	vpush	{d8-d15}
	DCD	0xe92d0003 ;	push	{r0, r1}
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe58d1004 ;	str	r1, [sp, #4]
	DCD	0xba000187 ;	blt	a45c <pixman_composite_over_8888_8888_8888_asm_neon+0x664>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba000114 ;	blt	a298 <pixman_composite_over_8888_8888_8888_asm_neon+0x4a0>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000051 ;	beq	9f94 <pixman_composite_over_8888_8888_8888_asm_neon+0x19c>
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000004 ;	beq	9e68 <pixman_composite_over_8888_8888_8888_asm_neon+0x70>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf4a7c88d ;	vld1.32	{d12[1]}, [r7]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000004 ;	beq	9e84 <pixman_composite_over_8888_8888_8888_asm_neon+0x8c>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xf427d78d ;	vld1.32	{d13}, [r7]!
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xf427ea8d ;	vld1.32	{d14-d15}, [r7]!
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b2c10d ;	vuzp.8	d12, d13
	DCD	0xf3b2e10f ;	vuzp.8	d14, d15
	DCD	0xf3b2d10f ;	vuzp.8	d13, d15
	DCD	0xf3b2c10e ;	vuzp.8	d12, d14
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf7def10a ;	pld	[lr, sl, lsl #2]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1105 ;	ldrbge	r1, [fp, r5, lsl #2]!
	DCD	0xa7fc1103 ;	ldrbge	r1, [ip, r3, lsl #2]!
	DCD	0xa7fe1108 ;	ldrbge	r1, [lr, r8, lsl #2]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000000 ;	beq	9f84 <pixman_composite_over_8888_8888_8888_asm_neon+0x18c>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	9f90 <pixman_composite_over_8888_8888_8888_asm_neon+0x198>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xf426402d ;	vld4.8	{d4-d7}, [r6 :128]!
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xf427c00d ;	vld4.8	{d12-d15}, [r7]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf7def10a ;	pld	[lr, sl, lsl #2]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1105 ;	ldrbge	r1, [fp, r5, lsl #2]!
	DCD	0xa7fc1103 ;	ldrbge	r1, [ip, r3, lsl #2]!
	DCD	0xa7fe1108 ;	ldrbge	r1, [lr, r8, lsl #2]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba00002e ;	blt	a0e0 <pixman_composite_over_8888_8888_8888_asm_neon+0x2e8>
	DCD	0xf426402d ;	vld4.8	{d4-d7}, [r6 :128]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf7def10a ;	pld	[lr, sl, lsl #2]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1105 ;	ldrbge	r1, [fp, r5, lsl #2]!
	DCD	0xa7fc1103 ;	ldrbge	r1, [ip, r3, lsl #2]!
	DCD	0xa7fe1108 ;	ldrbge	r1, [lr, r8, lsl #2]!
	DCD	0xf427c00d ;	vld4.8	{d12-d15}, [r7]!
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffd0 ;	bge	a024 <pixman_composite_over_8888_8888_8888_asm_neon+0x22c>
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000052 ;	beq	a260 <pixman_composite_over_8888_8888_8888_asm_neon+0x468>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000003 ;	beq	a12c <pixman_composite_over_8888_8888_8888_asm_neon+0x334>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xf427ea8d ;	vld1.32	{d14-d15}, [r7]!
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000003 ;	beq	a144 <pixman_composite_over_8888_8888_8888_asm_neon+0x34c>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xf427d78d ;	vld1.32	{d13}, [r7]!
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000003 ;	beq	a15c <pixman_composite_over_8888_8888_8888_asm_neon+0x364>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf4a7c88d ;	vld1.32	{d12[1]}, [r7]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b2c10d ;	vuzp.8	d12, d13
	DCD	0xf3b2e10f ;	vuzp.8	d14, d15
	DCD	0xf3b2d10f ;	vuzp.8	d13, d15
	DCD	0xf3b2c10e ;	vuzp.8	d12, d14
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf7def10a ;	pld	[lr, sl, lsl #2]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1105 ;	ldrbge	r1, [fp, r5, lsl #2]!
	DCD	0xa7fc1103 ;	ldrbge	r1, [ip, r3, lsl #2]!
	DCD	0xa7fe1108 ;	ldrbge	r1, [lr, r8, lsl #2]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	a248 <pixman_composite_over_8888_8888_8888_asm_neon+0x450>
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	a254 <pixman_composite_over_8888_8888_8888_asm_neon+0x45c>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	a260 <pixman_composite_over_8888_8888_8888_asm_neon+0x468>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1cd00d0 ;	ldrd	r0, [sp]
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0877108 ;	add	r7, r7, r8, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe0477100 ;	sub	r7, r7, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe58d1004 ;	str	r1, [sp, #4]
	DCD	0xaafffeed ;	bge	9e44 <pixman_composite_over_8888_8888_8888_asm_neon+0x4c>
	DCD	0xe8bd0003 ;	pop	{r0, r1}
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a00001e ;	beq	a31c <pixman_composite_over_8888_8888_8888_asm_neon+0x524>
	DCD	0xf426400d ;	vld4.8	{d4-d7}, [r6]!
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xf427c00d ;	vld4.8	{d12-d15}, [r7]!
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf442c00d ;	vst4.8	{d28-d31}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000042 ;	beq	a430 <pixman_composite_over_8888_8888_8888_asm_neon+0x638>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000002 ;	beq	a338 <pixman_composite_over_8888_8888_8888_asm_neon+0x540>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xf427ea8d ;	vld1.32	{d14-d15}, [r7]!
	DCD	0xf4266a8d ;	vld1.32	{d6-d7}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000002 ;	beq	a34c <pixman_composite_over_8888_8888_8888_asm_neon+0x554>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xf427d78d ;	vld1.32	{d13}, [r7]!
	DCD	0xf426578d ;	vld1.32	{d5}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	a360 <pixman_composite_over_8888_8888_8888_asm_neon+0x568>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf4a7c88d ;	vld1.32	{d12[1]}, [r7]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b2c10d ;	vuzp.8	d12, d13
	DCD	0xf3b2e10f ;	vuzp.8	d14, d15
	DCD	0xf3b2d10f ;	vuzp.8	d13, d15
	DCD	0xf3b2c10e ;	vuzp.8	d12, d14
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	a418 <pixman_composite_over_8888_8888_8888_asm_neon+0x620>
	DCD	0xf442ea8d ;	vst1.32	{d30-d31}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	a424 <pixman_composite_over_8888_8888_8888_asm_neon+0x62c>
	DCD	0xf442d78d ;	vst1.32	{d29}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	a430 <pixman_composite_over_8888_8888_8888_asm_neon+0x638>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1cd00d0 ;	ldrd	r0, [sp]
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0877108 ;	add	r7, r7, r8, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe0477100 ;	sub	r7, r7, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe58d1004 ;	str	r1, [sp, #4]
	DCD	0xaaffff8e ;	bge	a298 <pixman_composite_over_8888_8888_8888_asm_neon+0x4a0>
	DCD	0xe8bd0003 ;	pop	{r0, r1}
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_over_8888_8888_8888_asm_neon|

|pixman_composite_scanline_over_mask_asm_neon| PROC
	DCD	0xed2d8b10 ;	vpush	{d8-d15}
	DCD	0xe1a0c001 ;	mov	ip, r1
	DCD	0xe3500008 ;	cmp	r0, #8
	DCD	0xba0000ce ;	blt	a7b4 <pixman_composite_scanline_over_mask_asm_neon+0x34c>
	DCD	0xe31c000f ;	tst	ip, #15
	DCD	0x0a000041 ;	beq	a588 <pixman_composite_scanline_over_mask_asm_neon+0x120>
	DCD	0xe31c0004 ;	tst	ip, #4
	DCD	0x0a000003 ;	beq	a498 <pixman_composite_scanline_over_mask_asm_neon+0x30>
	DCD	0xf4a2088d ;	vld1.32	{d0[1]}, [r2]!
	DCD	0xf4a3c88d ;	vld1.32	{d12[1]}, [r3]!
	DCD	0xf4ac488d ;	vld1.32	{d4[1]}, [ip]!
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe31c0008 ;	tst	ip, #8
	DCD	0x0a000003 ;	beq	a4b0 <pixman_composite_scanline_over_mask_asm_neon+0x48>
	DCD	0xf422178d ;	vld1.32	{d1}, [r2]!
	DCD	0xf423d78d ;	vld1.32	{d13}, [r3]!
	DCD	0xf42c579d ;	vld1.32	{d5}, [ip :64]!
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xf4222a8d ;	vld1.32	{d2-d3}, [r2]!
	DCD	0xf423ea8d ;	vld1.32	{d14-d15}, [r3]!
	DCD	0xf42c6aad ;	vld1.32	{d6-d7}, [ip :128]!
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b2c10d ;	vuzp.8	d12, d13
	DCD	0xf3b2e10f ;	vuzp.8	d14, d15
	DCD	0xf3b2d10f ;	vuzp.8	d13, d15
	DCD	0xf3b2c10e ;	vuzp.8	d12, d14
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3110004 ;	tst	r1, #4
	DCD	0x0a000000 ;	beq	a578 <pixman_composite_scanline_over_mask_asm_neon+0x110>
	DCD	0xf4c1c88d ;	vst1.32	{d28[1]}, [r1]!
	DCD	0xe3110008 ;	tst	r1, #8
	DCD	0x0a000000 ;	beq	a584 <pixman_composite_scanline_over_mask_asm_neon+0x11c>
	DCD	0xf441d79d ;	vst1.32	{d29}, [r1 :64]!
	DCD	0xf441eaad ;	vst1.32	{d30-d31}, [r1 :128]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xba000041 ;	blt	a698 <pixman_composite_scanline_over_mask_asm_neon+0x230>
	DCD	0xf42c402d ;	vld4.8	{d4-d7}, [ip :128]!
	DCD	0xf422000d ;	vld4.8	{d0-d3}, [r2]!
	DCD	0xf423c00d ;	vld4.8	{d12-d15}, [r3]!
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xba000020 ;	blt	a66c <pixman_composite_scanline_over_mask_asm_neon+0x204>
	DCD	0xf42c402d ;	vld4.8	{d4-d7}, [ip :128]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf422000d ;	vld4.8	{d0-d3}, [r2]!
	DCD	0xf423c00d ;	vld4.8	{d12-d15}, [r3]!
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf441c02d ;	vst4.8	{d28-d31}, [r1 :128]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffde ;	bge	a5e8 <pixman_composite_scanline_over_mask_asm_neon+0x180>
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf441c02d ;	vst4.8	{d28-d31}, [r1 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000042 ;	beq	a7ac <pixman_composite_scanline_over_mask_asm_neon+0x344>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000002 ;	beq	a6b4 <pixman_composite_scanline_over_mask_asm_neon+0x24c>
	DCD	0xf4222a8d ;	vld1.32	{d2-d3}, [r2]!
	DCD	0xf423ea8d ;	vld1.32	{d14-d15}, [r3]!
	DCD	0xf42c6aad ;	vld1.32	{d6-d7}, [ip :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000002 ;	beq	a6c8 <pixman_composite_scanline_over_mask_asm_neon+0x260>
	DCD	0xf422178d ;	vld1.32	{d1}, [r2]!
	DCD	0xf423d78d ;	vld1.32	{d13}, [r3]!
	DCD	0xf42c579d ;	vld1.32	{d5}, [ip :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	a6dc <pixman_composite_scanline_over_mask_asm_neon+0x274>
	DCD	0xf4a2088d ;	vld1.32	{d0[1]}, [r2]!
	DCD	0xf4a3c88d ;	vld1.32	{d12[1]}, [r3]!
	DCD	0xf4ac488d ;	vld1.32	{d4[1]}, [ip]!
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b2c10d ;	vuzp.8	d12, d13
	DCD	0xf3b2e10f ;	vuzp.8	d14, d15
	DCD	0xf3b2d10f ;	vuzp.8	d13, d15
	DCD	0xf3b2c10e ;	vuzp.8	d12, d14
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	a794 <pixman_composite_scanline_over_mask_asm_neon+0x32c>
	DCD	0xf441eaad ;	vst1.32	{d30-d31}, [r1 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	a7a0 <pixman_composite_scanline_over_mask_asm_neon+0x338>
	DCD	0xf441d79d ;	vst1.32	{d29}, [r1 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	a7ac <pixman_composite_scanline_over_mask_asm_neon+0x344>
	DCD	0xf4c1c88d ;	vst1.32	{d28[1]}, [r1]!
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe12fff1e ;	bx	lr
	;		a7b0: R_ARM_V4BX	*ABS*
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000042 ;	beq	a8c8 <pixman_composite_scanline_over_mask_asm_neon+0x460>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000002 ;	beq	a7d0 <pixman_composite_scanline_over_mask_asm_neon+0x368>
	DCD	0xf4222a8d ;	vld1.32	{d2-d3}, [r2]!
	DCD	0xf423ea8d ;	vld1.32	{d14-d15}, [r3]!
	DCD	0xf42c6a8d ;	vld1.32	{d6-d7}, [ip]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000002 ;	beq	a7e4 <pixman_composite_scanline_over_mask_asm_neon+0x37c>
	DCD	0xf422178d ;	vld1.32	{d1}, [r2]!
	DCD	0xf423d78d ;	vld1.32	{d13}, [r3]!
	DCD	0xf42c578d ;	vld1.32	{d5}, [ip]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	a7f8 <pixman_composite_scanline_over_mask_asm_neon+0x390>
	DCD	0xf4a2088d ;	vld1.32	{d0[1]}, [r2]!
	DCD	0xf4a3c88d ;	vld1.32	{d12[1]}, [r3]!
	DCD	0xf4ac488d ;	vld1.32	{d4[1]}, [ip]!
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b2c10d ;	vuzp.8	d12, d13
	DCD	0xf3b2e10f ;	vuzp.8	d14, d15
	DCD	0xf3b2d10f ;	vuzp.8	d13, d15
	DCD	0xf3b2c10e ;	vuzp.8	d12, d14
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	a8b0 <pixman_composite_scanline_over_mask_asm_neon+0x448>
	DCD	0xf441ea8d ;	vst1.32	{d30-d31}, [r1]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	a8bc <pixman_composite_scanline_over_mask_asm_neon+0x454>
	DCD	0xf441d78d ;	vst1.32	{d29}, [r1]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	a8c8 <pixman_composite_scanline_over_mask_asm_neon+0x460>
	DCD	0xf4c1c88d ;	vst1.32	{d28[1]}, [r1]!
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe12fff1e ;	bx	lr
	;		a8cc: R_ARM_V4BX	*ABS*
	ENDP  ; |pixman_composite_scanline_over_mask_asm_neon|

|pixman_composite_over_8888_8_8888_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe59d7030 ;	ldr	r7, [sp, #48]	; 0x30
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe59d8034 ;	ldr	r8, [sp, #52]	; 0x34
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xed2d8b10 ;	vpush	{d8-d15}
	DCD	0xe92d0003 ;	push	{r0, r1}
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe58d1004 ;	str	r1, [sp, #4]
	DCD	0xba000187 ;	blt	af34 <pixman_composite_over_8888_8_8888_asm_neon+0x664>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba000114 ;	blt	ad70 <pixman_composite_over_8888_8_8888_asm_neon+0x4a0>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000051 ;	beq	aa6c <pixman_composite_over_8888_8_8888_asm_neon+0x19c>
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000004 ;	beq	a940 <pixman_composite_over_8888_8_8888_asm_neon+0x70>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf4a7f02d ;	vld1.8	{d15[1]}, [r7]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000005 ;	beq	a960 <pixman_composite_over_8888_8_8888_asm_neon+0x90>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xf4a7f04d ;	vld1.8	{d15[2]}, [r7]!
	DCD	0xf4a7f06d ;	vld1.8	{d15[3]}, [r7]!
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xf4a7f08d ;	vld1.8	{d15[4]}, [r7]!
	DCD	0xf4a7f0ad ;	vld1.8	{d15[5]}, [r7]!
	DCD	0xf4a7f0cd ;	vld1.8	{d15[6]}, [r7]!
	DCD	0xf4a7f0ed ;	vld1.8	{d15[7]}, [r7]!
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1105 ;	ldrbge	r1, [fp, r5, lsl #2]!
	DCD	0xa7fc1103 ;	ldrbge	r1, [ip, r3, lsl #2]!
	DCD	0xa7fe1008 ;	ldrbge	r1, [lr, r8]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000000 ;	beq	aa5c <pixman_composite_over_8888_8_8888_asm_neon+0x18c>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	aa68 <pixman_composite_over_8888_8_8888_asm_neon+0x198>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xf426402d ;	vld4.8	{d4-d7}, [r6 :128]!
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xf427f70d ;	vld1.8	{d15}, [r7]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1105 ;	ldrbge	r1, [fp, r5, lsl #2]!
	DCD	0xa7fc1103 ;	ldrbge	r1, [ip, r3, lsl #2]!
	DCD	0xa7fe1008 ;	ldrbge	r1, [lr, r8]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba00002e ;	blt	abb8 <pixman_composite_over_8888_8_8888_asm_neon+0x2e8>
	DCD	0xf426402d ;	vld4.8	{d4-d7}, [r6 :128]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1105 ;	ldrbge	r1, [fp, r5, lsl #2]!
	DCD	0xa7fc1103 ;	ldrbge	r1, [ip, r3, lsl #2]!
	DCD	0xa7fe1008 ;	ldrbge	r1, [lr, r8]!
	DCD	0xf427f70d ;	vld1.8	{d15}, [r7]!
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffd0 ;	bge	aafc <pixman_composite_over_8888_8_8888_asm_neon+0x22c>
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000052 ;	beq	ad38 <pixman_composite_over_8888_8_8888_asm_neon+0x468>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000006 ;	beq	ac10 <pixman_composite_over_8888_8_8888_asm_neon+0x340>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xf4a7f08d ;	vld1.8	{d15[4]}, [r7]!
	DCD	0xf4a7f0ad ;	vld1.8	{d15[5]}, [r7]!
	DCD	0xf4a7f0cd ;	vld1.8	{d15[6]}, [r7]!
	DCD	0xf4a7f0ed ;	vld1.8	{d15[7]}, [r7]!
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000004 ;	beq	ac2c <pixman_composite_over_8888_8_8888_asm_neon+0x35c>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xf4a7f04d ;	vld1.8	{d15[2]}, [r7]!
	DCD	0xf4a7f06d ;	vld1.8	{d15[3]}, [r7]!
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000003 ;	beq	ac44 <pixman_composite_over_8888_8_8888_asm_neon+0x374>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf4a7f02d ;	vld1.8	{d15[1]}, [r7]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1105 ;	ldrbge	r1, [fp, r5, lsl #2]!
	DCD	0xa7fc1103 ;	ldrbge	r1, [ip, r3, lsl #2]!
	DCD	0xa7fe1008 ;	ldrbge	r1, [lr, r8]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	ad20 <pixman_composite_over_8888_8_8888_asm_neon+0x450>
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	ad2c <pixman_composite_over_8888_8_8888_asm_neon+0x45c>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	ad38 <pixman_composite_over_8888_8_8888_asm_neon+0x468>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1cd00d0 ;	ldrd	r0, [sp]
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0877008 ;	add	r7, r7, r8
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe0477000 ;	sub	r7, r7, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe58d1004 ;	str	r1, [sp, #4]
	DCD	0xaafffeed ;	bge	a91c <pixman_composite_over_8888_8_8888_asm_neon+0x4c>
	DCD	0xe8bd0003 ;	pop	{r0, r1}
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a00001e ;	beq	adf4 <pixman_composite_over_8888_8_8888_asm_neon+0x524>
	DCD	0xf426400d ;	vld4.8	{d4-d7}, [r6]!
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xf427f70d ;	vld1.8	{d15}, [r7]!
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf442c00d ;	vst4.8	{d28-d31}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000042 ;	beq	af08 <pixman_composite_over_8888_8_8888_asm_neon+0x638>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000005 ;	beq	ae1c <pixman_composite_over_8888_8_8888_asm_neon+0x54c>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xf4a7f08d ;	vld1.8	{d15[4]}, [r7]!
	DCD	0xf4a7f0ad ;	vld1.8	{d15[5]}, [r7]!
	DCD	0xf4a7f0cd ;	vld1.8	{d15[6]}, [r7]!
	DCD	0xf4a7f0ed ;	vld1.8	{d15[7]}, [r7]!
	DCD	0xf4266a8d ;	vld1.32	{d6-d7}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000003 ;	beq	ae34 <pixman_composite_over_8888_8_8888_asm_neon+0x564>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xf4a7f04d ;	vld1.8	{d15[2]}, [r7]!
	DCD	0xf4a7f06d ;	vld1.8	{d15[3]}, [r7]!
	DCD	0xf426578d ;	vld1.32	{d5}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	ae48 <pixman_composite_over_8888_8_8888_asm_neon+0x578>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf4a7f02d ;	vld1.8	{d15[1]}, [r7]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3cf0c03 ;	vmull.u8	q8, d15, d3
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38034aa ;	vraddhn.i16	d3, q8, q13
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	aef0 <pixman_composite_over_8888_8_8888_asm_neon+0x620>
	DCD	0xf442ea8d ;	vst1.32	{d30-d31}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	aefc <pixman_composite_over_8888_8_8888_asm_neon+0x62c>
	DCD	0xf442d78d ;	vst1.32	{d29}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	af08 <pixman_composite_over_8888_8_8888_asm_neon+0x638>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1cd00d0 ;	ldrd	r0, [sp]
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0877008 ;	add	r7, r7, r8
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe0477000 ;	sub	r7, r7, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe58d1004 ;	str	r1, [sp, #4]
	DCD	0xaaffff8e ;	bge	ad70 <pixman_composite_over_8888_8_8888_asm_neon+0x4a0>
	DCD	0xe8bd0003 ;	pop	{r0, r1}
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_over_8888_8_8888_asm_neon|

|pixman_composite_src_0888_0888_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe0455000 ;	sub	r5, r5, r0
	DCD	0xe0455080 ;	sub	r5, r5, r0, lsl #1
	DCD	0xe0433000 ;	sub	r3, r3, r0
	DCD	0xe0433080 ;	sub	r3, r3, r0, lsl #1
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a0a000 ;	mov	sl, r0
	DCD	0xba000055 ;	blt	b0c4 <pixman_composite_src_0888_0888_asm_neon+0x184>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba00002d ;	blt	b02c <pixman_composite_src_0888_0888_asm_neon+0xec>
	DCD	0xf424040d ;	vld3.8	{d0-d2}, [r4]!
	DCD	0xf5d4f0c0 ;	pld	[r4, #192]	; 0xc0
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba000004 ;	blt	af98 <pixman_composite_src_0888_0888_asm_neon+0x58>
	DCD	0xf402040d ;	vst3.8	{d0-d2}, [r2]!
	DCD	0xf424040d ;	vld3.8	{d0-d2}, [r4]!
	DCD	0xf5d4f0c0 ;	pld	[r4, #192]	; 0xc0
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaafffffa ;	bge	af84 <pixman_composite_src_0888_0888_asm_neon+0x44>
	DCD	0xf402040d ;	vst3.8	{d0-d2}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00001a ;	beq	b010 <pixman_composite_src_0888_0888_asm_neon+0xd0>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000003 ;	beq	afbc <pixman_composite_src_0888_0888_asm_neon+0x7c>
	DCD	0xf4a4028d ;	vld3.8	{d0[4],d1[4],d2[4]}, [r4]!
	DCD	0xf4a402ad ;	vld3.8	{d0[5],d1[5],d2[5]}, [r4]!
	DCD	0xf4a402cd ;	vld3.8	{d0[6],d1[6],d2[6]}, [r4]!
	DCD	0xf4a402ed ;	vld3.8	{d0[7],d1[7],d2[7]}, [r4]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	afcc <pixman_composite_src_0888_0888_asm_neon+0x8c>
	DCD	0xf4a4024d ;	vld3.8	{d0[2],d1[2],d2[2]}, [r4]!
	DCD	0xf4a4026d ;	vld3.8	{d0[3],d1[3],d2[3]}, [r4]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	afd8 <pixman_composite_src_0888_0888_asm_neon+0x98>
	DCD	0xf4a4022d ;	vld3.8	{d0[1],d1[1],d2[1]}, [r4]!
	DCD	0xf5d4f0c0 ;	pld	[r4, #192]	; 0xc0
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000003 ;	beq	aff4 <pixman_composite_src_0888_0888_asm_neon+0xb4>
	DCD	0xf482028d ;	vst3.8	{d0[4],d1[4],d2[4]}, [r2]!
	DCD	0xf48202ad ;	vst3.8	{d0[5],d1[5],d2[5]}, [r2]!
	DCD	0xf48202cd ;	vst3.8	{d0[6],d1[6],d2[6]}, [r2]!
	DCD	0xf48202ed ;	vst3.8	{d0[7],d1[7],d2[7]}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	b004 <pixman_composite_src_0888_0888_asm_neon+0xc4>
	DCD	0xf482024d ;	vst3.8	{d0[2],d1[2],d2[2]}, [r2]!
	DCD	0xf482026d ;	vst3.8	{d0[3],d1[3],d2[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	b010 <pixman_composite_src_0888_0888_asm_neon+0xd0>
	DCD	0xf482022d ;	vst3.8	{d0[1],d1[1],d2[1]}, [r2]!
	DCD	0xe1a0000a ;	mov	r0, sl
	DCD	0xe0822003 ;	add	r2, r2, r3
	DCD	0xe0844005 ;	add	r4, r4, r5
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffd2 ;	bge	af74 <pixman_composite_src_0888_0888_asm_neon+0x34>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000001 ;	beq	b03c <pixman_composite_src_0888_0888_asm_neon+0xfc>
	DCD	0xf424040d ;	vld3.8	{d0-d2}, [r4]!
	DCD	0xf402040d ;	vst3.8	{d0-d2}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000019 ;	beq	b0ac <pixman_composite_src_0888_0888_asm_neon+0x16c>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000003 ;	beq	b05c <pixman_composite_src_0888_0888_asm_neon+0x11c>
	DCD	0xf4a4028d ;	vld3.8	{d0[4],d1[4],d2[4]}, [r4]!
	DCD	0xf4a402ad ;	vld3.8	{d0[5],d1[5],d2[5]}, [r4]!
	DCD	0xf4a402cd ;	vld3.8	{d0[6],d1[6],d2[6]}, [r4]!
	DCD	0xf4a402ed ;	vld3.8	{d0[7],d1[7],d2[7]}, [r4]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	b06c <pixman_composite_src_0888_0888_asm_neon+0x12c>
	DCD	0xf4a4024d ;	vld3.8	{d0[2],d1[2],d2[2]}, [r4]!
	DCD	0xf4a4026d ;	vld3.8	{d0[3],d1[3],d2[3]}, [r4]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	b078 <pixman_composite_src_0888_0888_asm_neon+0x138>
	DCD	0xf4a4022d ;	vld3.8	{d0[1],d1[1],d2[1]}, [r4]!
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000003 ;	beq	b090 <pixman_composite_src_0888_0888_asm_neon+0x150>
	DCD	0xf482028d ;	vst3.8	{d0[4],d1[4],d2[4]}, [r2]!
	DCD	0xf48202ad ;	vst3.8	{d0[5],d1[5],d2[5]}, [r2]!
	DCD	0xf48202cd ;	vst3.8	{d0[6],d1[6],d2[6]}, [r2]!
	DCD	0xf48202ed ;	vst3.8	{d0[7],d1[7],d2[7]}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	b0a0 <pixman_composite_src_0888_0888_asm_neon+0x160>
	DCD	0xf482024d ;	vst3.8	{d0[2],d1[2],d2[2]}, [r2]!
	DCD	0xf482026d ;	vst3.8	{d0[3],d1[3],d2[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	b0ac <pixman_composite_src_0888_0888_asm_neon+0x16c>
	DCD	0xf482022d ;	vst3.8	{d0[1],d1[1],d2[1]}, [r2]!
	DCD	0xe1a0000a ;	mov	r0, sl
	DCD	0xe0822003 ;	add	r2, r2, r3
	DCD	0xe0844005 ;	add	r4, r4, r5
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffd9 ;	bge	b02c <pixman_composite_src_0888_0888_asm_neon+0xec>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_src_0888_0888_asm_neon|

|pixman_composite_src_0888_8888_rev_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe0455000 ;	sub	r5, r5, r0
	DCD	0xe0455080 ;	sub	r5, r5, r0, lsl #1
	DCD	0xf3033113 ;	veor	d3, d3, d3
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a0a000 ;	mov	sl, r0
	DCD	0xba00007c ;	blt	b2e4 <pixman_composite_src_0888_8888_rev_asm_neon+0x21c>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba000051 ;	blt	b240 <pixman_composite_src_0888_8888_rev_asm_neon+0x178>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a00001d ;	beq	b178 <pixman_composite_src_0888_8888_rev_asm_neon+0xb0>
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000002 ;	beq	b114 <pixman_composite_src_0888_8888_rev_asm_neon+0x4c>
	DCD	0xf4a4022d ;	vld3.8	{d0[1],d1[1],d2[1]}, [r4]!
	DCD	0xe2866004 ;	add	r6, r6, #4
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000003 ;	beq	b12c <pixman_composite_src_0888_8888_rev_asm_neon+0x64>
	DCD	0xf4a4024d ;	vld3.8	{d0[2],d1[2],d2[2]}, [r4]!
	DCD	0xf4a4026d ;	vld3.8	{d0[3],d1[3],d2[3]}, [r4]!
	DCD	0xe2866008 ;	add	r6, r6, #8
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xf4a4028d ;	vld3.8	{d0[4],d1[4],d2[4]}, [r4]!
	DCD	0xf4a402ad ;	vld3.8	{d0[5],d1[5],d2[5]}, [r4]!
	DCD	0xf4a402cd ;	vld3.8	{d0[6],d1[6],d2[6]}, [r4]!
	DCD	0xf4a402ed ;	vld3.8	{d0[7],d1[7],d2[7]}, [r4]!
	DCD	0xe2866010 ;	add	r6, r6, #16
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b20002 ;	vswp	d0, d2
	DCD	0xf5d4f0c0 ;	pld	[r4, #192]	; 0xc0
	DCD	0xf3b20182 ;	vzip.8	d0, d2
	DCD	0xf3b21183 ;	vzip.8	d1, d3
	DCD	0xf3b22183 ;	vzip.8	d2, d3
	DCD	0xf3b20181 ;	vzip.8	d0, d1
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000000 ;	beq	b168 <pixman_composite_src_0888_8888_rev_asm_neon+0xa0>
	DCD	0xf482088d ;	vst1.32	{d0[1]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	b174 <pixman_composite_src_0888_8888_rev_asm_neon+0xac>
	DCD	0xf402179d ;	vst1.32	{d1}, [r2 :64]!
	DCD	0xf4022aad ;	vst1.32	{d2-d3}, [r2 :128]!
	DCD	0xf424040d ;	vld3.8	{d0-d2}, [r4]!
	DCD	0xf3b20002 ;	vswp	d0, d2
	DCD	0xf5d4f0c0 ;	pld	[r4, #192]	; 0xc0
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba000005 ;	blt	b1a4 <pixman_composite_src_0888_8888_rev_asm_neon+0xdc>
	DCD	0xf402000d ;	vst4.8	{d0-d3}, [r2]!
	DCD	0xf424040d ;	vld3.8	{d0-d2}, [r4]!
	DCD	0xf3b20002 ;	vswp	d0, d2
	DCD	0xf5d4f0c0 ;	pld	[r4, #192]	; 0xc0
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaafffff9 ;	bge	b18c <pixman_composite_src_0888_8888_rev_asm_neon+0xc4>
	DCD	0xf402002d ;	vst4.8	{d0-d3}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00001b ;	beq	b220 <pixman_composite_src_0888_8888_rev_asm_neon+0x158>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000003 ;	beq	b1c8 <pixman_composite_src_0888_8888_rev_asm_neon+0x100>
	DCD	0xf4a4028d ;	vld3.8	{d0[4],d1[4],d2[4]}, [r4]!
	DCD	0xf4a402ad ;	vld3.8	{d0[5],d1[5],d2[5]}, [r4]!
	DCD	0xf4a402cd ;	vld3.8	{d0[6],d1[6],d2[6]}, [r4]!
	DCD	0xf4a402ed ;	vld3.8	{d0[7],d1[7],d2[7]}, [r4]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	b1d8 <pixman_composite_src_0888_8888_rev_asm_neon+0x110>
	DCD	0xf4a4024d ;	vld3.8	{d0[2],d1[2],d2[2]}, [r4]!
	DCD	0xf4a4026d ;	vld3.8	{d0[3],d1[3],d2[3]}, [r4]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	b1e4 <pixman_composite_src_0888_8888_rev_asm_neon+0x11c>
	DCD	0xf4a4022d ;	vld3.8	{d0[1],d1[1],d2[1]}, [r4]!
	DCD	0xf3b20002 ;	vswp	d0, d2
	DCD	0xf5d4f0c0 ;	pld	[r4, #192]	; 0xc0
	DCD	0xf3b20182 ;	vzip.8	d0, d2
	DCD	0xf3b21183 ;	vzip.8	d1, d3
	DCD	0xf3b22183 ;	vzip.8	d2, d3
	DCD	0xf3b20181 ;	vzip.8	d0, d1
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	b208 <pixman_composite_src_0888_8888_rev_asm_neon+0x140>
	DCD	0xf4022aad ;	vst1.32	{d2-d3}, [r2 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	b214 <pixman_composite_src_0888_8888_rev_asm_neon+0x14c>
	DCD	0xf402179d ;	vst1.32	{d1}, [r2 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	b220 <pixman_composite_src_0888_8888_rev_asm_neon+0x158>
	DCD	0xf482088d ;	vst1.32	{d0[1]}, [r2]!
	DCD	0xe1a0000a ;	mov	r0, sl
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844005 ;	add	r4, r4, r5
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffae ;	bge	b0f8 <pixman_composite_src_0888_8888_rev_asm_neon+0x30>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000002 ;	beq	b254 <pixman_composite_src_0888_8888_rev_asm_neon+0x18c>
	DCD	0xf424040d ;	vld3.8	{d0-d2}, [r4]!
	DCD	0xf3b20002 ;	vswp	d0, d2
	DCD	0xf402000d ;	vst4.8	{d0-d3}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00001a ;	beq	b2c8 <pixman_composite_src_0888_8888_rev_asm_neon+0x200>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000003 ;	beq	b274 <pixman_composite_src_0888_8888_rev_asm_neon+0x1ac>
	DCD	0xf4a4028d ;	vld3.8	{d0[4],d1[4],d2[4]}, [r4]!
	DCD	0xf4a402ad ;	vld3.8	{d0[5],d1[5],d2[5]}, [r4]!
	DCD	0xf4a402cd ;	vld3.8	{d0[6],d1[6],d2[6]}, [r4]!
	DCD	0xf4a402ed ;	vld3.8	{d0[7],d1[7],d2[7]}, [r4]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	b284 <pixman_composite_src_0888_8888_rev_asm_neon+0x1bc>
	DCD	0xf4a4024d ;	vld3.8	{d0[2],d1[2],d2[2]}, [r4]!
	DCD	0xf4a4026d ;	vld3.8	{d0[3],d1[3],d2[3]}, [r4]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	b290 <pixman_composite_src_0888_8888_rev_asm_neon+0x1c8>
	DCD	0xf4a4022d ;	vld3.8	{d0[1],d1[1],d2[1]}, [r4]!
	DCD	0xf3b20002 ;	vswp	d0, d2
	DCD	0xf3b20182 ;	vzip.8	d0, d2
	DCD	0xf3b21183 ;	vzip.8	d1, d3
	DCD	0xf3b22183 ;	vzip.8	d2, d3
	DCD	0xf3b20181 ;	vzip.8	d0, d1
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	b2b0 <pixman_composite_src_0888_8888_rev_asm_neon+0x1e8>
	DCD	0xf4022a8d ;	vst1.32	{d2-d3}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	b2bc <pixman_composite_src_0888_8888_rev_asm_neon+0x1f4>
	DCD	0xf402178d ;	vst1.32	{d1}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	b2c8 <pixman_composite_src_0888_8888_rev_asm_neon+0x200>
	DCD	0xf482088d ;	vst1.32	{d0[1]}, [r2]!
	DCD	0xe1a0000a ;	mov	r0, sl
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844005 ;	add	r4, r4, r5
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffd6 ;	bge	b240 <pixman_composite_src_0888_8888_rev_asm_neon+0x178>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_src_0888_8888_rev_asm_neon|

|pixman_composite_src_0888_0565_rev_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe0455000 ;	sub	r5, r5, r0
	DCD	0xe0455080 ;	sub	r5, r5, r0, lsl #1
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a0a000 ;	mov	sl, r0
	DCD	0xba00008f ;	blt	b54c <pixman_composite_src_0888_0565_rev_asm_neon+0x264>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba00005f ;	blt	b494 <pixman_composite_src_0888_0565_rev_asm_neon+0x1ac>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000022 ;	beq	b3a8 <pixman_composite_src_0888_0565_rev_asm_neon+0xc0>
	DCD	0xe3160002 ;	tst	r6, #2
	DCD	0x0a000002 ;	beq	b330 <pixman_composite_src_0888_0565_rev_asm_neon+0x48>
	DCD	0xf4a4022d ;	vld3.8	{d0[1],d1[1],d2[1]}, [r4]!
	DCD	0xe2866002 ;	add	r6, r6, #2
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000003 ;	beq	b348 <pixman_composite_src_0888_0565_rev_asm_neon+0x60>
	DCD	0xf4a4024d ;	vld3.8	{d0[2],d1[2],d2[2]}, [r4]!
	DCD	0xf4a4026d ;	vld3.8	{d0[3],d1[3],d2[3]}, [r4]!
	DCD	0xe2866004 ;	add	r6, r6, #4
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000005 ;	beq	b368 <pixman_composite_src_0888_0565_rev_asm_neon+0x80>
	DCD	0xf4a4028d ;	vld3.8	{d0[4],d1[4],d2[4]}, [r4]!
	DCD	0xf4a402ad ;	vld3.8	{d0[5],d1[5],d2[5]}, [r4]!
	DCD	0xf4a402cd ;	vld3.8	{d0[6],d1[6],d2[6]}, [r4]!
	DCD	0xf4a402ed ;	vld3.8	{d0[7],d1[7],d2[7]}, [r4]!
	DCD	0xe2866008 ;	add	r6, r6, #8
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3f20301 ;	vshll.i8	q8, d1, #8
	DCD	0xf3f22302 ;	vshll.i8	q9, d2, #8
	DCD	0xf5d4f0c0 ;	pld	[r4, #192]	; 0xc0
	DCD	0xf3f2c300 ;	vshll.i8	q14, d0, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3120002 ;	tst	r2, #2
	DCD	0x0a000000 ;	beq	b38c <pixman_composite_src_0888_0565_rev_asm_neon+0xa4>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000001 ;	beq	b39c <pixman_composite_src_0888_0565_rev_asm_neon+0xb4>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	b3a8 <pixman_composite_src_0888_0565_rev_asm_neon+0xc0>
	DCD	0xf442d75d ;	vst1.16	{d29}, [r2 :64]!
	DCD	0xf424040d ;	vld3.8	{d0-d2}, [r4]!
	DCD	0xf3f20301 ;	vshll.i8	q8, d1, #8
	DCD	0xf3f22302 ;	vshll.i8	q9, d2, #8
	DCD	0xf5d4f0c0 ;	pld	[r4, #192]	; 0xc0
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba000009 ;	blt	b3e8 <pixman_composite_src_0888_0565_rev_asm_neon+0x100>
	DCD	0xf3f2c300 ;	vshll.i8	q14, d0, #8
	DCD	0xf424040d ;	vld3.8	{d0-d2}, [r4]!
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xf3f20301 ;	vshll.i8	q8, d1, #8
	DCD	0xf442ca6d ;	vst1.16	{d28-d29}, [r2 :128]!
	DCD	0xf3f22302 ;	vshll.i8	q9, d2, #8
	DCD	0xf5d4f0c0 ;	pld	[r4, #192]	; 0xc0
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaafffff5 ;	bge	b3c0 <pixman_composite_src_0888_0565_rev_asm_neon+0xd8>
	DCD	0xf3f2c300 ;	vshll.i8	q14, d0, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xf442ca6d ;	vst1.16	{d28-d29}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00001c ;	beq	b474 <pixman_composite_src_0888_0565_rev_asm_neon+0x18c>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000003 ;	beq	b418 <pixman_composite_src_0888_0565_rev_asm_neon+0x130>
	DCD	0xf4a4028d ;	vld3.8	{d0[4],d1[4],d2[4]}, [r4]!
	DCD	0xf4a402ad ;	vld3.8	{d0[5],d1[5],d2[5]}, [r4]!
	DCD	0xf4a402cd ;	vld3.8	{d0[6],d1[6],d2[6]}, [r4]!
	DCD	0xf4a402ed ;	vld3.8	{d0[7],d1[7],d2[7]}, [r4]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	b428 <pixman_composite_src_0888_0565_rev_asm_neon+0x140>
	DCD	0xf4a4024d ;	vld3.8	{d0[2],d1[2],d2[2]}, [r4]!
	DCD	0xf4a4026d ;	vld3.8	{d0[3],d1[3],d2[3]}, [r4]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	b434 <pixman_composite_src_0888_0565_rev_asm_neon+0x14c>
	DCD	0xf4a4022d ;	vld3.8	{d0[1],d1[1],d2[1]}, [r4]!
	DCD	0xf3f20301 ;	vshll.i8	q8, d1, #8
	DCD	0xf3f22302 ;	vshll.i8	q9, d2, #8
	DCD	0xf5d4f0c0 ;	pld	[r4, #192]	; 0xc0
	DCD	0xf3f2c300 ;	vshll.i8	q14, d0, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	b458 <pixman_composite_src_0888_0565_rev_asm_neon+0x170>
	DCD	0xf442d75d ;	vst1.16	{d29}, [r2 :64]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	b468 <pixman_composite_src_0888_0565_rev_asm_neon+0x180>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	b474 <pixman_composite_src_0888_0565_rev_asm_neon+0x18c>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe1a0000a ;	mov	r0, sl
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0844005 ;	add	r4, r4, r5
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffa0 ;	bge	b314 <pixman_composite_src_0888_0565_rev_asm_neon+0x2c>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000006 ;	beq	b4b8 <pixman_composite_src_0888_0565_rev_asm_neon+0x1d0>
	DCD	0xf424040d ;	vld3.8	{d0-d2}, [r4]!
	DCD	0xf3f20301 ;	vshll.i8	q8, d1, #8
	DCD	0xf3f22302 ;	vshll.i8	q9, d2, #8
	DCD	0xf3f2c300 ;	vshll.i8	q14, d0, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xf442ca4d ;	vst1.16	{d28-d29}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00001b ;	beq	b530 <pixman_composite_src_0888_0565_rev_asm_neon+0x248>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000003 ;	beq	b4d8 <pixman_composite_src_0888_0565_rev_asm_neon+0x1f0>
	DCD	0xf4a4028d ;	vld3.8	{d0[4],d1[4],d2[4]}, [r4]!
	DCD	0xf4a402ad ;	vld3.8	{d0[5],d1[5],d2[5]}, [r4]!
	DCD	0xf4a402cd ;	vld3.8	{d0[6],d1[6],d2[6]}, [r4]!
	DCD	0xf4a402ed ;	vld3.8	{d0[7],d1[7],d2[7]}, [r4]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	b4e8 <pixman_composite_src_0888_0565_rev_asm_neon+0x200>
	DCD	0xf4a4024d ;	vld3.8	{d0[2],d1[2],d2[2]}, [r4]!
	DCD	0xf4a4026d ;	vld3.8	{d0[3],d1[3],d2[3]}, [r4]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	b4f4 <pixman_composite_src_0888_0565_rev_asm_neon+0x20c>
	DCD	0xf4a4022d ;	vld3.8	{d0[1],d1[1],d2[1]}, [r4]!
	DCD	0xf3f20301 ;	vshll.i8	q8, d1, #8
	DCD	0xf3f22302 ;	vshll.i8	q9, d2, #8
	DCD	0xf3f2c300 ;	vshll.i8	q14, d0, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	b514 <pixman_composite_src_0888_0565_rev_asm_neon+0x22c>
	DCD	0xf442d74d ;	vst1.16	{d29}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	b524 <pixman_composite_src_0888_0565_rev_asm_neon+0x23c>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	b530 <pixman_composite_src_0888_0565_rev_asm_neon+0x248>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe1a0000a ;	mov	r0, sl
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0844005 ;	add	r4, r4, r5
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffd1 ;	bge	b494 <pixman_composite_src_0888_0565_rev_asm_neon+0x1ac>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_src_0888_0565_rev_asm_neon|

|pixman_composite_src_pixbuf_8888_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe2499006 ;	sub	r9, r9, #6
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a07000 ;	mov	r7, r0
	DCD	0xba0000d8 ;	blt	b8e8 <pixman_composite_src_pixbuf_8888_asm_neon+0x398>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba00009a ;	blt	b7f8 <pixman_composite_src_pixbuf_8888_asm_neon+0x2a8>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000030 ;	beq	b658 <pixman_composite_src_pixbuf_8888_asm_neon+0x108>
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000003 ;	beq	b5ac <pixman_composite_src_pixbuf_8888_asm_neon+0x5c>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xe2866004 ;	add	r6, r6, #4
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000003 ;	beq	b5c4 <pixman_composite_src_pixbuf_8888_asm_neon+0x74>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xe2866008 ;	add	r6, r6, #8
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xe2866010 ;	add	r6, r6, #16
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3c30c00 ;	vmull.u8	q8, d3, d0
	DCD	0xf3c32c01 ;	vmull.u8	q9, d3, d1
	DCD	0xf3c34c02 ;	vmull.u8	q10, d3, d2
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3b2302f ;	vswp	d3, d31
	DCD	0xf3d88272 ;	vrshr.u16	q12, q9, #8
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf3c6e4a0 ;	vraddhn.i16	d30, q11, q8
	DCD	0xf3c8d4a2 ;	vraddhn.i16	d29, q12, q9
	DCD	0xf3cac4a4 ;	vraddhn.i16	d28, q13, q10
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000000 ;	beq	b648 <pixman_composite_src_pixbuf_8888_asm_neon+0xf8>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	b654 <pixman_composite_src_pixbuf_8888_asm_neon+0x104>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf3c30c00 ;	vmull.u8	q8, d3, d0
	DCD	0xf3c32c01 ;	vmull.u8	q9, d3, d1
	DCD	0xf3c34c02 ;	vmull.u8	q10, d3, d2
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba000016 ;	blt	b6f0 <pixman_composite_src_pixbuf_8888_asm_neon+0x1a0>
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3b2302f ;	vswp	d3, d31
	DCD	0xf3d88272 ;	vrshr.u16	q12, q9, #8
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xf3c6e4a0 ;	vraddhn.i16	d30, q11, q8
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xf3c8d4a2 ;	vraddhn.i16	d29, q12, q9
	DCD	0xf3cac4a4 ;	vraddhn.i16	d28, q13, q10
	DCD	0xf3c30c00 ;	vmull.u8	q8, d3, d0
	DCD	0xf3c32c01 ;	vmull.u8	q9, d3, d1
	DCD	0xf3c34c02 ;	vmull.u8	q10, d3, d2
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffe8 ;	bge	b694 <pixman_composite_src_pixbuf_8888_asm_neon+0x144>
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3b2302f ;	vswp	d3, d31
	DCD	0xf3d88272 ;	vrshr.u16	q12, q9, #8
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf3c6e4a0 ;	vraddhn.i16	d30, q11, q8
	DCD	0xf3c8d4a2 ;	vraddhn.i16	d29, q12, q9
	DCD	0xf3cac4a4 ;	vraddhn.i16	d28, q13, q10
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00002e ;	beq	b7d4 <pixman_composite_src_pixbuf_8888_asm_neon+0x284>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000001 ;	beq	b728 <pixman_composite_src_pixbuf_8888_asm_neon+0x1d8>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	b738 <pixman_composite_src_pixbuf_8888_asm_neon+0x1e8>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	b748 <pixman_composite_src_pixbuf_8888_asm_neon+0x1f8>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3c30c00 ;	vmull.u8	q8, d3, d0
	DCD	0xf3c32c01 ;	vmull.u8	q9, d3, d1
	DCD	0xf3c34c02 ;	vmull.u8	q10, d3, d2
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3b2302f ;	vswp	d3, d31
	DCD	0xf3d88272 ;	vrshr.u16	q12, q9, #8
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf3c6e4a0 ;	vraddhn.i16	d30, q11, q8
	DCD	0xf3c8d4a2 ;	vraddhn.i16	d29, q12, q9
	DCD	0xf3cac4a4 ;	vraddhn.i16	d28, q13, q10
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	b7bc <pixman_composite_src_pixbuf_8888_asm_neon+0x26c>
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	b7c8 <pixman_composite_src_pixbuf_8888_asm_neon+0x278>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	b7d4 <pixman_composite_src_pixbuf_8888_asm_neon+0x284>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff65 ;	bge	b58c <pixman_composite_src_pixbuf_8888_asm_neon+0x3c>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a00000b ;	beq	b830 <pixman_composite_src_pixbuf_8888_asm_neon+0x2e0>
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xf3c30c00 ;	vmull.u8	q8, d3, d0
	DCD	0xf3c32c01 ;	vmull.u8	q9, d3, d1
	DCD	0xf3c34c02 ;	vmull.u8	q10, d3, d2
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3b2302f ;	vswp	d3, d31
	DCD	0xf3d88272 ;	vrshr.u16	q12, q9, #8
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf3c6e4a0 ;	vraddhn.i16	d30, q11, q8
	DCD	0xf3c8d4a2 ;	vraddhn.i16	d29, q12, q9
	DCD	0xf3cac4a4 ;	vraddhn.i16	d28, q13, q10
	DCD	0xf442c00d ;	vst4.8	{d28-d31}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000023 ;	beq	b8c8 <pixman_composite_src_pixbuf_8888_asm_neon+0x378>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	b844 <pixman_composite_src_pixbuf_8888_asm_neon+0x2f4>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	b850 <pixman_composite_src_pixbuf_8888_asm_neon+0x300>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	b85c <pixman_composite_src_pixbuf_8888_asm_neon+0x30c>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3c30c00 ;	vmull.u8	q8, d3, d0
	DCD	0xf3c32c01 ;	vmull.u8	q9, d3, d1
	DCD	0xf3c34c02 ;	vmull.u8	q10, d3, d2
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3b2302f ;	vswp	d3, d31
	DCD	0xf3d88272 ;	vrshr.u16	q12, q9, #8
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf3c6e4a0 ;	vraddhn.i16	d30, q11, q8
	DCD	0xf3c8d4a2 ;	vraddhn.i16	d29, q12, q9
	DCD	0xf3cac4a4 ;	vraddhn.i16	d28, q13, q10
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	b8b0 <pixman_composite_src_pixbuf_8888_asm_neon+0x360>
	DCD	0xf442ea8d ;	vst1.32	{d30-d31}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	b8bc <pixman_composite_src_pixbuf_8888_asm_neon+0x36c>
	DCD	0xf442d78d ;	vst1.32	{d29}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	b8c8 <pixman_composite_src_pixbuf_8888_asm_neon+0x378>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffc3 ;	bge	b7f8 <pixman_composite_src_pixbuf_8888_asm_neon+0x2a8>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_src_pixbuf_8888_asm_neon|

|pixman_composite_src_rpixbuf_8888_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe2499006 ;	sub	r9, r9, #6
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a07000 ;	mov	r7, r0
	DCD	0xba0000d8 ;	blt	bc84 <pixman_composite_src_rpixbuf_8888_asm_neon+0x398>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba00009a ;	blt	bb94 <pixman_composite_src_rpixbuf_8888_asm_neon+0x2a8>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000030 ;	beq	b9f4 <pixman_composite_src_rpixbuf_8888_asm_neon+0x108>
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000003 ;	beq	b948 <pixman_composite_src_rpixbuf_8888_asm_neon+0x5c>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xe2866004 ;	add	r6, r6, #4
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000003 ;	beq	b960 <pixman_composite_src_rpixbuf_8888_asm_neon+0x74>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xe2866008 ;	add	r6, r6, #8
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xe2866010 ;	add	r6, r6, #16
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3c30c00 ;	vmull.u8	q8, d3, d0
	DCD	0xf3c32c01 ;	vmull.u8	q9, d3, d1
	DCD	0xf3c34c02 ;	vmull.u8	q10, d3, d2
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3b2302f ;	vswp	d3, d31
	DCD	0xf3d88272 ;	vrshr.u16	q12, q9, #8
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf3c6c4a0 ;	vraddhn.i16	d28, q11, q8
	DCD	0xf3c8d4a2 ;	vraddhn.i16	d29, q12, q9
	DCD	0xf3cae4a4 ;	vraddhn.i16	d30, q13, q10
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000000 ;	beq	b9e4 <pixman_composite_src_rpixbuf_8888_asm_neon+0xf8>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	b9f0 <pixman_composite_src_rpixbuf_8888_asm_neon+0x104>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf3c30c00 ;	vmull.u8	q8, d3, d0
	DCD	0xf3c32c01 ;	vmull.u8	q9, d3, d1
	DCD	0xf3c34c02 ;	vmull.u8	q10, d3, d2
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba000016 ;	blt	ba8c <pixman_composite_src_rpixbuf_8888_asm_neon+0x1a0>
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3b2302f ;	vswp	d3, d31
	DCD	0xf3d88272 ;	vrshr.u16	q12, q9, #8
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xf3c6c4a0 ;	vraddhn.i16	d28, q11, q8
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xf3c8d4a2 ;	vraddhn.i16	d29, q12, q9
	DCD	0xf3cae4a4 ;	vraddhn.i16	d30, q13, q10
	DCD	0xf3c30c00 ;	vmull.u8	q8, d3, d0
	DCD	0xf3c32c01 ;	vmull.u8	q9, d3, d1
	DCD	0xf3c34c02 ;	vmull.u8	q10, d3, d2
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffe8 ;	bge	ba30 <pixman_composite_src_rpixbuf_8888_asm_neon+0x144>
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3b2302f ;	vswp	d3, d31
	DCD	0xf3d88272 ;	vrshr.u16	q12, q9, #8
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf3c6c4a0 ;	vraddhn.i16	d28, q11, q8
	DCD	0xf3c8d4a2 ;	vraddhn.i16	d29, q12, q9
	DCD	0xf3cae4a4 ;	vraddhn.i16	d30, q13, q10
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00002e ;	beq	bb70 <pixman_composite_src_rpixbuf_8888_asm_neon+0x284>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000001 ;	beq	bac4 <pixman_composite_src_rpixbuf_8888_asm_neon+0x1d8>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	bad4 <pixman_composite_src_rpixbuf_8888_asm_neon+0x1e8>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	bae4 <pixman_composite_src_rpixbuf_8888_asm_neon+0x1f8>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3c30c00 ;	vmull.u8	q8, d3, d0
	DCD	0xf3c32c01 ;	vmull.u8	q9, d3, d1
	DCD	0xf3c34c02 ;	vmull.u8	q10, d3, d2
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf10a ;	pld	[fp, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8105 ;	ldrbge	r8, [fp, r5, lsl #2]!
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3b2302f ;	vswp	d3, d31
	DCD	0xf3d88272 ;	vrshr.u16	q12, q9, #8
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf3c6c4a0 ;	vraddhn.i16	d28, q11, q8
	DCD	0xf3c8d4a2 ;	vraddhn.i16	d29, q12, q9
	DCD	0xf3cae4a4 ;	vraddhn.i16	d30, q13, q10
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	bb58 <pixman_composite_src_rpixbuf_8888_asm_neon+0x26c>
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	bb64 <pixman_composite_src_rpixbuf_8888_asm_neon+0x278>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	bb70 <pixman_composite_src_rpixbuf_8888_asm_neon+0x284>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff65 ;	bge	b928 <pixman_composite_src_rpixbuf_8888_asm_neon+0x3c>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a00000b ;	beq	bbcc <pixman_composite_src_rpixbuf_8888_asm_neon+0x2e0>
	DCD	0xf424000d ;	vld4.8	{d0-d3}, [r4]!
	DCD	0xf3c30c00 ;	vmull.u8	q8, d3, d0
	DCD	0xf3c32c01 ;	vmull.u8	q9, d3, d1
	DCD	0xf3c34c02 ;	vmull.u8	q10, d3, d2
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3b2302f ;	vswp	d3, d31
	DCD	0xf3d88272 ;	vrshr.u16	q12, q9, #8
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf3c6c4a0 ;	vraddhn.i16	d28, q11, q8
	DCD	0xf3c8d4a2 ;	vraddhn.i16	d29, q12, q9
	DCD	0xf3cae4a4 ;	vraddhn.i16	d30, q13, q10
	DCD	0xf442c00d ;	vst4.8	{d28-d31}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000023 ;	beq	bc64 <pixman_composite_src_rpixbuf_8888_asm_neon+0x378>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	bbe0 <pixman_composite_src_rpixbuf_8888_asm_neon+0x2f4>
	DCD	0xf4242a8d ;	vld1.32	{d2-d3}, [r4]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	bbec <pixman_composite_src_rpixbuf_8888_asm_neon+0x300>
	DCD	0xf424178d ;	vld1.32	{d1}, [r4]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	bbf8 <pixman_composite_src_rpixbuf_8888_asm_neon+0x30c>
	DCD	0xf4a4088d ;	vld1.32	{d0[1]}, [r4]!
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3c30c00 ;	vmull.u8	q8, d3, d0
	DCD	0xf3c32c01 ;	vmull.u8	q9, d3, d1
	DCD	0xf3c34c02 ;	vmull.u8	q10, d3, d2
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3b2302f ;	vswp	d3, d31
	DCD	0xf3d88272 ;	vrshr.u16	q12, q9, #8
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf3c6c4a0 ;	vraddhn.i16	d28, q11, q8
	DCD	0xf3c8d4a2 ;	vraddhn.i16	d29, q12, q9
	DCD	0xf3cae4a4 ;	vraddhn.i16	d30, q13, q10
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	bc4c <pixman_composite_src_rpixbuf_8888_asm_neon+0x360>
	DCD	0xf442ea8d ;	vst1.32	{d30-d31}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	bc58 <pixman_composite_src_rpixbuf_8888_asm_neon+0x36c>
	DCD	0xf442d78d ;	vst1.32	{d29}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	bc64 <pixman_composite_src_rpixbuf_8888_asm_neon+0x378>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844105 ;	add	r4, r4, r5, lsl #2
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444100 ;	sub	r4, r4, r0, lsl #2
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffc3 ;	bge	bb94 <pixman_composite_src_rpixbuf_8888_asm_neon+0x2a8>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_src_rpixbuf_8888_asm_neon|

|pixman_composite_over_0565_8_0565_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe59d7030 ;	ldr	r7, [sp, #48]	; 0x30
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe59d8034 ;	ldr	r8, [sp, #52]	; 0x34
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xed2d8b10 ;	vpush	{d8-d15}
	DCD	0xe92d0003 ;	push	{r0, r1}
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe58d1004 ;	str	r1, [sp, #4]
	DCD	0xba0001b2 ;	blt	c398 <pixman_composite_over_0565_8_0565_asm_neon+0x710>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba000132 ;	blt	c1a0 <pixman_composite_over_0565_8_0565_asm_neon+0x518>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000057 ;	beq	be3c <pixman_composite_over_0565_8_0565_asm_neon+0x1b4>
	DCD	0xe3160002 ;	tst	r6, #2
	DCD	0x0a000004 ;	beq	bcf8 <pixman_composite_over_0565_8_0565_asm_neon+0x70>
	DCD	0xf4a4844d ;	vld1.16	{d8[1]}, [r4]!
	DCD	0xf4a7f02d ;	vld1.8	{d15[1]}, [r7]!
	DCD	0xf4a6a44d ;	vld1.16	{d10[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000007 ;	beq	bd20 <pixman_composite_over_0565_8_0565_asm_neon+0x98>
	DCD	0xf4a4848d ;	vld1.16	{d8[2]}, [r4]!
	DCD	0xf4a484cd ;	vld1.16	{d8[3]}, [r4]!
	DCD	0xf4a7f04d ;	vld1.8	{d15[2]}, [r7]!
	DCD	0xf4a7f06d ;	vld1.8	{d15[3]}, [r7]!
	DCD	0xf4a6a48d ;	vld1.16	{d10[2]}, [r6]!
	DCD	0xf4a6a4cd ;	vld1.16	{d10[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000007 ;	beq	bd48 <pixman_composite_over_0565_8_0565_asm_neon+0xc0>
	DCD	0xf424974d ;	vld1.16	{d9}, [r4]!
	DCD	0xf4a7f08d ;	vld1.8	{d15[4]}, [r7]!
	DCD	0xf4a7f0ad ;	vld1.8	{d15[5]}, [r7]!
	DCD	0xf4a7f0cd ;	vld1.8	{d15[6]}, [r7]!
	DCD	0xf4a7f0ed ;	vld1.8	{d15[7]}, [r7]!
	DCD	0xf426b75d ;	vld1.16	{d11}, [r6 :64]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf2882818 ;	vshrn.i16	d2, q4, #8
	DCD	0xf28d1818 ;	vshrn.i16	d1, q4, #3
	DCD	0xf3958558 ;	vsli.16	q4, q4, #5
	DCD	0xf38b2412 ;	vsri.8	d2, d2, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0818 ;	vshrn.i16	d0, q4, #2
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf3b0758f ;	vmvn	d7, d15
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3c70c04 ;	vmull.u8	q8, d7, d4
	DCD	0xf3c72c05 ;	vmull.u8	q9, d7, d5
	DCD	0xf3c7ac06 ;	vmull.u8	q13, d7, d6
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf08a ;	pld	[fp, sl, lsl #1]
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1085 ;	ldrbge	r1, [fp, r5, lsl #1]!
	DCD	0xa7fc1083 ;	ldrbge	r1, [ip, r3, lsl #1]!
	DCD	0xa7fe1008 ;	ldrbge	r1, [lr, r8]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d8827a ;	vrshr.u16	q12, q13, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4aa ;	vraddhn.i16	d30, q12, q13
	DCD	0xf300007c ;	vqadd.u8	q0, q0, q14
	DCD	0xf302207e ;	vqadd.u8	q1, q1, q15
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xe3120002 ;	tst	r2, #2
	DCD	0x0a000000 ;	beq	be20 <pixman_composite_over_0565_8_0565_asm_neon+0x198>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000001 ;	beq	be30 <pixman_composite_over_0565_8_0565_asm_neon+0x1a8>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	be3c <pixman_composite_over_0565_8_0565_asm_neon+0x1b4>
	DCD	0xf442d75d ;	vst1.16	{d29}, [r2 :64]!
	DCD	0xf426aa6d ;	vld1.16	{d10-d11}, [r6 :128]!
	DCD	0xf4248a4d ;	vld1.16	{d8-d9}, [r4]!
	DCD	0xf427f70d ;	vld1.8	{d15}, [r7]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf2882818 ;	vshrn.i16	d2, q4, #8
	DCD	0xf28d1818 ;	vshrn.i16	d1, q4, #3
	DCD	0xf3958558 ;	vsli.16	q4, q4, #5
	DCD	0xf38b2412 ;	vsri.8	d2, d2, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0818 ;	vshrn.i16	d0, q4, #2
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf3b0758f ;	vmvn	d7, d15
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3c70c04 ;	vmull.u8	q8, d7, d4
	DCD	0xf3c72c05 ;	vmull.u8	q9, d7, d5
	DCD	0xf3c7ac06 ;	vmull.u8	q13, d7, d6
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf08a ;	pld	[fp, sl, lsl #1]
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1085 ;	ldrbge	r1, [fp, r5, lsl #1]!
	DCD	0xa7fc1083 ;	ldrbge	r1, [ip, r3, lsl #1]!
	DCD	0xa7fe1008 ;	ldrbge	r1, [lr, r8]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba000039 ;	blt	bfd4 <pixman_composite_over_0565_8_0565_asm_neon+0x34c>
	DCD	0xf427f70d ;	vld1.8	{d15}, [r7]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d8827a ;	vrshr.u16	q12, q13, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4aa ;	vraddhn.i16	d30, q12, q13
	DCD	0xf300007c ;	vqadd.u8	q0, q0, q14
	DCD	0xf302207e ;	vqadd.u8	q1, q1, q15
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xf4248a4d ;	vld1.16	{d8-d9}, [r4]!
	DCD	0xf426aa6d ;	vld1.16	{d10-d11}, [r6 :128]!
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf08a ;	pld	[fp, sl, lsl #1]
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1085 ;	ldrbge	r1, [fp, r5, lsl #1]!
	DCD	0xa7fc1083 ;	ldrbge	r1, [ip, r3, lsl #1]!
	DCD	0xa7fe1008 ;	ldrbge	r1, [lr, r8]!
	DCD	0xf2882818 ;	vshrn.i16	d2, q4, #8
	DCD	0xf28d1818 ;	vshrn.i16	d1, q4, #3
	DCD	0xf3958558 ;	vsli.16	q4, q4, #5
	DCD	0xf38b2412 ;	vsri.8	d2, d2, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0818 ;	vshrn.i16	d0, q4, #2
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf3b0758f ;	vmvn	d7, d15
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3c70c04 ;	vmull.u8	q8, d7, d4
	DCD	0xf3c72c05 ;	vmull.u8	q9, d7, d5
	DCD	0xf3c7ac06 ;	vmull.u8	q13, d7, d6
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf442ca6d ;	vst1.16	{d28-d29}, [r2 :128]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffc5 ;	bge	beec <pixman_composite_over_0565_8_0565_asm_neon+0x264>
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d8827a ;	vrshr.u16	q12, q13, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4aa ;	vraddhn.i16	d30, q12, q13
	DCD	0xf300007c ;	vqadd.u8	q0, q0, q14
	DCD	0xf302207e ;	vqadd.u8	q1, q1, q15
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xf442ca6d ;	vst1.16	{d28-d29}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000054 ;	beq	c168 <pixman_composite_over_0565_8_0565_asm_neon+0x4e0>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000006 ;	beq	c038 <pixman_composite_over_0565_8_0565_asm_neon+0x3b0>
	DCD	0xf424974d ;	vld1.16	{d9}, [r4]!
	DCD	0xf4a7f08d ;	vld1.8	{d15[4]}, [r7]!
	DCD	0xf4a7f0ad ;	vld1.8	{d15[5]}, [r7]!
	DCD	0xf4a7f0cd ;	vld1.8	{d15[6]}, [r7]!
	DCD	0xf4a7f0ed ;	vld1.8	{d15[7]}, [r7]!
	DCD	0xf426b75d ;	vld1.16	{d11}, [r6 :64]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000006 ;	beq	c05c <pixman_composite_over_0565_8_0565_asm_neon+0x3d4>
	DCD	0xf4a4848d ;	vld1.16	{d8[2]}, [r4]!
	DCD	0xf4a484cd ;	vld1.16	{d8[3]}, [r4]!
	DCD	0xf4a7f04d ;	vld1.8	{d15[2]}, [r7]!
	DCD	0xf4a7f06d ;	vld1.8	{d15[3]}, [r7]!
	DCD	0xf4a6a48d ;	vld1.16	{d10[2]}, [r6]!
	DCD	0xf4a6a4cd ;	vld1.16	{d10[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000003 ;	beq	c074 <pixman_composite_over_0565_8_0565_asm_neon+0x3ec>
	DCD	0xf4a4844d ;	vld1.16	{d8[1]}, [r4]!
	DCD	0xf4a7f02d ;	vld1.8	{d15[1]}, [r7]!
	DCD	0xf4a6a44d ;	vld1.16	{d10[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf2882818 ;	vshrn.i16	d2, q4, #8
	DCD	0xf28d1818 ;	vshrn.i16	d1, q4, #3
	DCD	0xf3958558 ;	vsli.16	q4, q4, #5
	DCD	0xf38b2412 ;	vsri.8	d2, d2, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0818 ;	vshrn.i16	d0, q4, #2
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf3b0758f ;	vmvn	d7, d15
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3c70c04 ;	vmull.u8	q8, d7, d4
	DCD	0xf3c72c05 ;	vmull.u8	q9, d7, d5
	DCD	0xf3c7ac06 ;	vmull.u8	q13, d7, d6
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf08a ;	pld	[fp, sl, lsl #1]
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1085 ;	ldrbge	r1, [fp, r5, lsl #1]!
	DCD	0xa7fc1083 ;	ldrbge	r1, [ip, r3, lsl #1]!
	DCD	0xa7fe1008 ;	ldrbge	r1, [lr, r8]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d8827a ;	vrshr.u16	q12, q13, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4aa ;	vraddhn.i16	d30, q12, q13
	DCD	0xf300007c ;	vqadd.u8	q0, q0, q14
	DCD	0xf302207e ;	vqadd.u8	q1, q1, q15
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	c14c <pixman_composite_over_0565_8_0565_asm_neon+0x4c4>
	DCD	0xf442d75d ;	vst1.16	{d29}, [r2 :64]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	c15c <pixman_composite_over_0565_8_0565_asm_neon+0x4d4>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	c168 <pixman_composite_over_0565_8_0565_asm_neon+0x4e0>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe1cd00d0 ;	ldrd	r0, [sp]
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0844085 ;	add	r4, r4, r5, lsl #1
	DCD	0xe0877008 ;	add	r7, r7, r8
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe0444080 ;	sub	r4, r4, r0, lsl #1
	DCD	0xe0477000 ;	sub	r7, r7, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe58d1004 ;	str	r1, [sp, #4]
	DCD	0xaafffecf ;	bge	bcd4 <pixman_composite_over_0565_8_0565_asm_neon+0x4c>
	DCD	0xe8bd0003 ;	pop	{r0, r1}
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000029 ;	beq	c250 <pixman_composite_over_0565_8_0565_asm_neon+0x5c8>
	DCD	0xf426aa4d ;	vld1.16	{d10-d11}, [r6]!
	DCD	0xf4248a4d ;	vld1.16	{d8-d9}, [r4]!
	DCD	0xf427f70d ;	vld1.8	{d15}, [r7]!
	DCD	0xf2882818 ;	vshrn.i16	d2, q4, #8
	DCD	0xf28d1818 ;	vshrn.i16	d1, q4, #3
	DCD	0xf3958558 ;	vsli.16	q4, q4, #5
	DCD	0xf38b2412 ;	vsri.8	d2, d2, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0818 ;	vshrn.i16	d0, q4, #2
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf3b0758f ;	vmvn	d7, d15
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3c70c04 ;	vmull.u8	q8, d7, d4
	DCD	0xf3c72c05 ;	vmull.u8	q9, d7, d5
	DCD	0xf3c7ac06 ;	vmull.u8	q13, d7, d6
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d8827a ;	vrshr.u16	q12, q13, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4aa ;	vraddhn.i16	d30, q12, q13
	DCD	0xf300007c ;	vqadd.u8	q0, q0, q14
	DCD	0xf302207e ;	vqadd.u8	q1, q1, q15
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xf442ca4d ;	vst1.16	{d28-d29}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000044 ;	beq	c36c <pixman_composite_over_0565_8_0565_asm_neon+0x6e4>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000005 ;	beq	c278 <pixman_composite_over_0565_8_0565_asm_neon+0x5f0>
	DCD	0xf424974d ;	vld1.16	{d9}, [r4]!
	DCD	0xf4a7f08d ;	vld1.8	{d15[4]}, [r7]!
	DCD	0xf4a7f0ad ;	vld1.8	{d15[5]}, [r7]!
	DCD	0xf4a7f0cd ;	vld1.8	{d15[6]}, [r7]!
	DCD	0xf4a7f0ed ;	vld1.8	{d15[7]}, [r7]!
	DCD	0xf426b74d ;	vld1.16	{d11}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000005 ;	beq	c298 <pixman_composite_over_0565_8_0565_asm_neon+0x610>
	DCD	0xf4a4848d ;	vld1.16	{d8[2]}, [r4]!
	DCD	0xf4a484cd ;	vld1.16	{d8[3]}, [r4]!
	DCD	0xf4a7f04d ;	vld1.8	{d15[2]}, [r7]!
	DCD	0xf4a7f06d ;	vld1.8	{d15[3]}, [r7]!
	DCD	0xf4a6a48d ;	vld1.16	{d10[2]}, [r6]!
	DCD	0xf4a6a4cd ;	vld1.16	{d10[3]}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	c2ac <pixman_composite_over_0565_8_0565_asm_neon+0x624>
	DCD	0xf4a4844d ;	vld1.16	{d8[1]}, [r4]!
	DCD	0xf4a7f02d ;	vld1.8	{d15[1]}, [r7]!
	DCD	0xf4a6a44d ;	vld1.16	{d10[1]}, [r6]!
	DCD	0xf2882818 ;	vshrn.i16	d2, q4, #8
	DCD	0xf28d1818 ;	vshrn.i16	d1, q4, #3
	DCD	0xf3958558 ;	vsli.16	q4, q4, #5
	DCD	0xf38b2412 ;	vsri.8	d2, d2, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0818 ;	vshrn.i16	d0, q4, #2
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf3b0758f ;	vmvn	d7, d15
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3c70c04 ;	vmull.u8	q8, d7, d4
	DCD	0xf3c72c05 ;	vmull.u8	q9, d7, d5
	DCD	0xf3c7ac06 ;	vmull.u8	q13, d7, d6
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d8827a ;	vrshr.u16	q12, q13, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4aa ;	vraddhn.i16	d30, q12, q13
	DCD	0xf300007c ;	vqadd.u8	q0, q0, q14
	DCD	0xf302207e ;	vqadd.u8	q1, q1, q15
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	c350 <pixman_composite_over_0565_8_0565_asm_neon+0x6c8>
	DCD	0xf442d74d ;	vst1.16	{d29}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	c360 <pixman_composite_over_0565_8_0565_asm_neon+0x6d8>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	c36c <pixman_composite_over_0565_8_0565_asm_neon+0x6e4>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe1cd00d0 ;	ldrd	r0, [sp]
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0844085 ;	add	r4, r4, r5, lsl #1
	DCD	0xe0877008 ;	add	r7, r7, r8
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe0444080 ;	sub	r4, r4, r0, lsl #1
	DCD	0xe0477000 ;	sub	r7, r7, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe58d1004 ;	str	r1, [sp, #4]
	DCD	0xaaffff81 ;	bge	c1a0 <pixman_composite_over_0565_8_0565_asm_neon+0x518>
	DCD	0xe8bd0003 ;	pop	{r0, r1}
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_over_0565_8_0565_asm_neon|

|pixman_composite_over_0565_n_0565_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xe28d8030 ;	add	r8, sp, #48	; 0x30
	DCD	0xed2d8b10 ;	vpush	{d8-d15}
	DCD	0xf4a8f80f ;	vld1.32	{d15[0]}, [r8]
	DCD	0xf3b7fc0f ;	vdup.8	d15, d15[3]
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a07000 ;	mov	r7, r0
	DCD	0xba000187 ;	blt	ca08 <pixman_composite_over_0565_n_0565_asm_neon+0x664>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba000112 ;	blt	c83c <pixman_composite_over_0565_n_0565_asm_neon+0x498>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a00004d ;	beq	c530 <pixman_composite_over_0565_n_0565_asm_neon+0x18c>
	DCD	0xe3160002 ;	tst	r6, #2
	DCD	0x0a000003 ;	beq	c410 <pixman_composite_over_0565_n_0565_asm_neon+0x6c>
	DCD	0xf4a4844d ;	vld1.16	{d8[1]}, [r4]!
	DCD	0xf4a6a44d ;	vld1.16	{d10[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000005 ;	beq	c430 <pixman_composite_over_0565_n_0565_asm_neon+0x8c>
	DCD	0xf4a4848d ;	vld1.16	{d8[2]}, [r4]!
	DCD	0xf4a484cd ;	vld1.16	{d8[3]}, [r4]!
	DCD	0xf4a6a48d ;	vld1.16	{d10[2]}, [r6]!
	DCD	0xf4a6a4cd ;	vld1.16	{d10[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000003 ;	beq	c448 <pixman_composite_over_0565_n_0565_asm_neon+0xa4>
	DCD	0xf424974d ;	vld1.16	{d9}, [r4]!
	DCD	0xf426b75d ;	vld1.16	{d11}, [r6 :64]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf2882818 ;	vshrn.i16	d2, q4, #8
	DCD	0xf28d1818 ;	vshrn.i16	d1, q4, #3
	DCD	0xf3958558 ;	vsli.16	q4, q4, #5
	DCD	0xf38b2412 ;	vsri.8	d2, d2, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0818 ;	vshrn.i16	d0, q4, #2
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf3b0758f ;	vmvn	d7, d15
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3c70c04 ;	vmull.u8	q8, d7, d4
	DCD	0xf3c72c05 ;	vmull.u8	q9, d7, d5
	DCD	0xf3c7ac06 ;	vmull.u8	q13, d7, d6
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf08a ;	pld	[fp, sl, lsl #1]
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8085 ;	ldrbge	r8, [fp, r5, lsl #1]!
	DCD	0xa7fc8083 ;	ldrbge	r8, [ip, r3, lsl #1]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d8827a ;	vrshr.u16	q12, q13, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4aa ;	vraddhn.i16	d30, q12, q13
	DCD	0xf300007c ;	vqadd.u8	q0, q0, q14
	DCD	0xf302207e ;	vqadd.u8	q1, q1, q15
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xe3120002 ;	tst	r2, #2
	DCD	0x0a000000 ;	beq	c514 <pixman_composite_over_0565_n_0565_asm_neon+0x170>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000001 ;	beq	c524 <pixman_composite_over_0565_n_0565_asm_neon+0x180>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	c530 <pixman_composite_over_0565_n_0565_asm_neon+0x18c>
	DCD	0xf442d75d ;	vst1.16	{d29}, [r2 :64]!
	DCD	0xf426aa6d ;	vld1.16	{d10-d11}, [r6 :128]!
	DCD	0xf4248a4d ;	vld1.16	{d8-d9}, [r4]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf2882818 ;	vshrn.i16	d2, q4, #8
	DCD	0xf28d1818 ;	vshrn.i16	d1, q4, #3
	DCD	0xf3958558 ;	vsli.16	q4, q4, #5
	DCD	0xf38b2412 ;	vsri.8	d2, d2, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0818 ;	vshrn.i16	d0, q4, #2
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf3b0758f ;	vmvn	d7, d15
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3c70c04 ;	vmull.u8	q8, d7, d4
	DCD	0xf3c72c05 ;	vmull.u8	q9, d7, d5
	DCD	0xf3c7ac06 ;	vmull.u8	q13, d7, d6
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf08a ;	pld	[fp, sl, lsl #1]
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8085 ;	ldrbge	r8, [fp, r5, lsl #1]!
	DCD	0xa7fc8083 ;	ldrbge	r8, [ip, r3, lsl #1]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba000035 ;	blt	c6a8 <pixman_composite_over_0565_n_0565_asm_neon+0x304>
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d8827a ;	vrshr.u16	q12, q13, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4aa ;	vraddhn.i16	d30, q12, q13
	DCD	0xf300007c ;	vqadd.u8	q0, q0, q14
	DCD	0xf302207e ;	vqadd.u8	q1, q1, q15
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xf4248a4d ;	vld1.16	{d8-d9}, [r4]!
	DCD	0xf426aa6d ;	vld1.16	{d10-d11}, [r6 :128]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf08a ;	pld	[fp, sl, lsl #1]
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8085 ;	ldrbge	r8, [fp, r5, lsl #1]!
	DCD	0xa7fc8083 ;	ldrbge	r8, [ip, r3, lsl #1]!
	DCD	0xf2882818 ;	vshrn.i16	d2, q4, #8
	DCD	0xf28d1818 ;	vshrn.i16	d1, q4, #3
	DCD	0xf3958558 ;	vsli.16	q4, q4, #5
	DCD	0xf38b2412 ;	vsri.8	d2, d2, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0818 ;	vshrn.i16	d0, q4, #2
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf3b0758f ;	vmvn	d7, d15
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3c70c04 ;	vmull.u8	q8, d7, d4
	DCD	0xf3c72c05 ;	vmull.u8	q9, d7, d5
	DCD	0xf3c7ac06 ;	vmull.u8	q13, d7, d6
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf442ca6d ;	vst1.16	{d28-d29}, [r2 :128]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffc9 ;	bge	c5d0 <pixman_composite_over_0565_n_0565_asm_neon+0x22c>
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d8827a ;	vrshr.u16	q12, q13, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4aa ;	vraddhn.i16	d30, q12, q13
	DCD	0xf300007c ;	vqadd.u8	q0, q0, q14
	DCD	0xf302207e ;	vqadd.u8	q1, q1, q15
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xf442ca6d ;	vst1.16	{d28-d29}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00004a ;	beq	c814 <pixman_composite_over_0565_n_0565_asm_neon+0x470>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000002 ;	beq	c6fc <pixman_composite_over_0565_n_0565_asm_neon+0x358>
	DCD	0xf424974d ;	vld1.16	{d9}, [r4]!
	DCD	0xf426b75d ;	vld1.16	{d11}, [r6 :64]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000004 ;	beq	c718 <pixman_composite_over_0565_n_0565_asm_neon+0x374>
	DCD	0xf4a4848d ;	vld1.16	{d8[2]}, [r4]!
	DCD	0xf4a484cd ;	vld1.16	{d8[3]}, [r4]!
	DCD	0xf4a6a48d ;	vld1.16	{d10[2]}, [r6]!
	DCD	0xf4a6a4cd ;	vld1.16	{d10[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	c72c <pixman_composite_over_0565_n_0565_asm_neon+0x388>
	DCD	0xf4a4844d ;	vld1.16	{d8[1]}, [r4]!
	DCD	0xf4a6a44d ;	vld1.16	{d10[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf2882818 ;	vshrn.i16	d2, q4, #8
	DCD	0xf28d1818 ;	vshrn.i16	d1, q4, #3
	DCD	0xf3958558 ;	vsli.16	q4, q4, #5
	DCD	0xf38b2412 ;	vsri.8	d2, d2, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0818 ;	vshrn.i16	d0, q4, #2
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf3b0758f ;	vmvn	d7, d15
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3c70c04 ;	vmull.u8	q8, d7, d4
	DCD	0xf3c72c05 ;	vmull.u8	q9, d7, d5
	DCD	0xf3c7ac06 ;	vmull.u8	q13, d7, d6
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf08a ;	pld	[fp, sl, lsl #1]
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8085 ;	ldrbge	r8, [fp, r5, lsl #1]!
	DCD	0xa7fc8083 ;	ldrbge	r8, [ip, r3, lsl #1]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d8827a ;	vrshr.u16	q12, q13, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4aa ;	vraddhn.i16	d30, q12, q13
	DCD	0xf300007c ;	vqadd.u8	q0, q0, q14
	DCD	0xf302207e ;	vqadd.u8	q1, q1, q15
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	c7f8 <pixman_composite_over_0565_n_0565_asm_neon+0x454>
	DCD	0xf442d75d ;	vst1.16	{d29}, [r2 :64]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	c808 <pixman_composite_over_0565_n_0565_asm_neon+0x464>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	c814 <pixman_composite_over_0565_n_0565_asm_neon+0x470>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0844085 ;	add	r4, r4, r5, lsl #1
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe0444080 ;	sub	r4, r4, r0, lsl #1
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaafffeee ;	bge	c3f0 <pixman_composite_over_0565_n_0565_asm_neon+0x4c>
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000028 ;	beq	c8e8 <pixman_composite_over_0565_n_0565_asm_neon+0x544>
	DCD	0xf426aa4d ;	vld1.16	{d10-d11}, [r6]!
	DCD	0xf4248a4d ;	vld1.16	{d8-d9}, [r4]!
	DCD	0xf2882818 ;	vshrn.i16	d2, q4, #8
	DCD	0xf28d1818 ;	vshrn.i16	d1, q4, #3
	DCD	0xf3958558 ;	vsli.16	q4, q4, #5
	DCD	0xf38b2412 ;	vsri.8	d2, d2, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0818 ;	vshrn.i16	d0, q4, #2
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf3b0758f ;	vmvn	d7, d15
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3c70c04 ;	vmull.u8	q8, d7, d4
	DCD	0xf3c72c05 ;	vmull.u8	q9, d7, d5
	DCD	0xf3c7ac06 ;	vmull.u8	q13, d7, d6
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d8827a ;	vrshr.u16	q12, q13, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4aa ;	vraddhn.i16	d30, q12, q13
	DCD	0xf300007c ;	vqadd.u8	q0, q0, q14
	DCD	0xf302207e ;	vqadd.u8	q1, q1, q15
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xf442ca4d ;	vst1.16	{d28-d29}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00003d ;	beq	c9e8 <pixman_composite_over_0565_n_0565_asm_neon+0x644>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000001 ;	beq	c900 <pixman_composite_over_0565_n_0565_asm_neon+0x55c>
	DCD	0xf424974d ;	vld1.16	{d9}, [r4]!
	DCD	0xf426b74d ;	vld1.16	{d11}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000003 ;	beq	c918 <pixman_composite_over_0565_n_0565_asm_neon+0x574>
	DCD	0xf4a4848d ;	vld1.16	{d8[2]}, [r4]!
	DCD	0xf4a484cd ;	vld1.16	{d8[3]}, [r4]!
	DCD	0xf4a6a48d ;	vld1.16	{d10[2]}, [r6]!
	DCD	0xf4a6a4cd ;	vld1.16	{d10[3]}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	c928 <pixman_composite_over_0565_n_0565_asm_neon+0x584>
	DCD	0xf4a4844d ;	vld1.16	{d8[1]}, [r4]!
	DCD	0xf4a6a44d ;	vld1.16	{d10[1]}, [r6]!
	DCD	0xf2882818 ;	vshrn.i16	d2, q4, #8
	DCD	0xf28d1818 ;	vshrn.i16	d1, q4, #3
	DCD	0xf3958558 ;	vsli.16	q4, q4, #5
	DCD	0xf38b2412 ;	vsri.8	d2, d2, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0818 ;	vshrn.i16	d0, q4, #2
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf3b0758f ;	vmvn	d7, d15
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3c70c04 ;	vmull.u8	q8, d7, d4
	DCD	0xf3c72c05 ;	vmull.u8	q9, d7, d5
	DCD	0xf3c7ac06 ;	vmull.u8	q13, d7, d6
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d8827a ;	vrshr.u16	q12, q13, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4aa ;	vraddhn.i16	d30, q12, q13
	DCD	0xf300007c ;	vqadd.u8	q0, q0, q14
	DCD	0xf302207e ;	vqadd.u8	q1, q1, q15
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	c9cc <pixman_composite_over_0565_n_0565_asm_neon+0x628>
	DCD	0xf442d74d ;	vst1.16	{d29}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	c9dc <pixman_composite_over_0565_n_0565_asm_neon+0x638>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	c9e8 <pixman_composite_over_0565_n_0565_asm_neon+0x644>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0844085 ;	add	r4, r4, r5, lsl #1
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe0444080 ;	sub	r4, r4, r0, lsl #1
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff8c ;	bge	c83c <pixman_composite_over_0565_n_0565_asm_neon+0x498>
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_over_0565_n_0565_asm_neon|

|pixman_composite_add_0565_8_0565_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe59d7030 ;	ldr	r7, [sp, #48]	; 0x30
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe59d8034 ;	ldr	r8, [sp, #52]	; 0x34
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xed2d8b10 ;	vpush	{d8-d15}
	DCD	0xe92d0003 ;	push	{r0, r1}
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe58d1004 ;	str	r1, [sp, #4]
	DCD	0xba000176 ;	blt	d030 <pixman_composite_add_0565_8_0565_asm_neon+0x620>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba00010a ;	blt	ce88 <pixman_composite_add_0565_8_0565_asm_neon+0x478>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a00004d ;	beq	cb9c <pixman_composite_add_0565_8_0565_asm_neon+0x18c>
	DCD	0xe3160002 ;	tst	r6, #2
	DCD	0x0a000004 ;	beq	ca80 <pixman_composite_add_0565_8_0565_asm_neon+0x70>
	DCD	0xf4a4844d ;	vld1.16	{d8[1]}, [r4]!
	DCD	0xf4a7f02d ;	vld1.8	{d15[1]}, [r7]!
	DCD	0xf4a6a44d ;	vld1.16	{d10[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000007 ;	beq	caa8 <pixman_composite_add_0565_8_0565_asm_neon+0x98>
	DCD	0xf4a4848d ;	vld1.16	{d8[2]}, [r4]!
	DCD	0xf4a484cd ;	vld1.16	{d8[3]}, [r4]!
	DCD	0xf4a7f04d ;	vld1.8	{d15[2]}, [r7]!
	DCD	0xf4a7f06d ;	vld1.8	{d15[3]}, [r7]!
	DCD	0xf4a6a48d ;	vld1.16	{d10[2]}, [r6]!
	DCD	0xf4a6a4cd ;	vld1.16	{d10[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000007 ;	beq	cad0 <pixman_composite_add_0565_8_0565_asm_neon+0xc0>
	DCD	0xf424974d ;	vld1.16	{d9}, [r4]!
	DCD	0xf4a7f08d ;	vld1.8	{d15[4]}, [r7]!
	DCD	0xf4a7f0ad ;	vld1.8	{d15[5]}, [r7]!
	DCD	0xf4a7f0cd ;	vld1.8	{d15[6]}, [r7]!
	DCD	0xf4a7f0ed ;	vld1.8	{d15[7]}, [r7]!
	DCD	0xf426b75d ;	vld1.16	{d11}, [r6 :64]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf2882818 ;	vshrn.i16	d2, q4, #8
	DCD	0xf28d1818 ;	vshrn.i16	d1, q4, #3
	DCD	0xf3958558 ;	vsli.16	q4, q4, #5
	DCD	0xf38b2412 ;	vsri.8	d2, d2, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0818 ;	vshrn.i16	d0, q4, #2
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf08a ;	pld	[fp, sl, lsl #1]
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1085 ;	ldrbge	r1, [fp, r5, lsl #1]!
	DCD	0xa7fc1083 ;	ldrbge	r1, [ip, r3, lsl #1]!
	DCD	0xa7fe1008 ;	ldrbge	r1, [lr, r8]!
	DCD	0xf3000054 ;	vqadd.u8	q0, q0, q2
	DCD	0xf3022056 ;	vqadd.u8	q1, q1, q3
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xe3120002 ;	tst	r2, #2
	DCD	0x0a000000 ;	beq	cb80 <pixman_composite_add_0565_8_0565_asm_neon+0x170>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000001 ;	beq	cb90 <pixman_composite_add_0565_8_0565_asm_neon+0x180>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	cb9c <pixman_composite_add_0565_8_0565_asm_neon+0x18c>
	DCD	0xf442d75d ;	vst1.16	{d29}, [r2 :64]!
	DCD	0xf426aa6d ;	vld1.16	{d10-d11}, [r6 :128]!
	DCD	0xf4248a4d ;	vld1.16	{d8-d9}, [r4]!
	DCD	0xf427f70d ;	vld1.8	{d15}, [r7]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf2882818 ;	vshrn.i16	d2, q4, #8
	DCD	0xf28d1818 ;	vshrn.i16	d1, q4, #3
	DCD	0xf3958558 ;	vsli.16	q4, q4, #5
	DCD	0xf38b2412 ;	vsri.8	d2, d2, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0818 ;	vshrn.i16	d0, q4, #2
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf08a ;	pld	[fp, sl, lsl #1]
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1085 ;	ldrbge	r1, [fp, r5, lsl #1]!
	DCD	0xa7fc1083 ;	ldrbge	r1, [ip, r3, lsl #1]!
	DCD	0xa7fe1008 ;	ldrbge	r1, [lr, r8]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba00002f ;	blt	ccfc <pixman_composite_add_0565_8_0565_asm_neon+0x2ec>
	DCD	0xf427f70d ;	vld1.8	{d15}, [r7]!
	DCD	0xf3000054 ;	vqadd.u8	q0, q0, q2
	DCD	0xf3022056 ;	vqadd.u8	q1, q1, q3
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xf4248a4d ;	vld1.16	{d8-d9}, [r4]!
	DCD	0xf426aa6d ;	vld1.16	{d10-d11}, [r6 :128]!
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf08a ;	pld	[fp, sl, lsl #1]
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1085 ;	ldrbge	r1, [fp, r5, lsl #1]!
	DCD	0xa7fc1083 ;	ldrbge	r1, [ip, r3, lsl #1]!
	DCD	0xa7fe1008 ;	ldrbge	r1, [lr, r8]!
	DCD	0xf2882818 ;	vshrn.i16	d2, q4, #8
	DCD	0xf28d1818 ;	vshrn.i16	d1, q4, #3
	DCD	0xf3958558 ;	vsli.16	q4, q4, #5
	DCD	0xf38b2412 ;	vsri.8	d2, d2, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0818 ;	vshrn.i16	d0, q4, #2
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf442ca6d ;	vst1.16	{d28-d29}, [r2 :128]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffcf ;	bge	cc3c <pixman_composite_add_0565_8_0565_asm_neon+0x22c>
	DCD	0xf3000054 ;	vqadd.u8	q0, q0, q2
	DCD	0xf3022056 ;	vqadd.u8	q1, q1, q3
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xf442ca6d ;	vst1.16	{d28-d29}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00004a ;	beq	ce50 <pixman_composite_add_0565_8_0565_asm_neon+0x440>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000006 ;	beq	cd48 <pixman_composite_add_0565_8_0565_asm_neon+0x338>
	DCD	0xf424974d ;	vld1.16	{d9}, [r4]!
	DCD	0xf4a7f08d ;	vld1.8	{d15[4]}, [r7]!
	DCD	0xf4a7f0ad ;	vld1.8	{d15[5]}, [r7]!
	DCD	0xf4a7f0cd ;	vld1.8	{d15[6]}, [r7]!
	DCD	0xf4a7f0ed ;	vld1.8	{d15[7]}, [r7]!
	DCD	0xf426b75d ;	vld1.16	{d11}, [r6 :64]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000006 ;	beq	cd6c <pixman_composite_add_0565_8_0565_asm_neon+0x35c>
	DCD	0xf4a4848d ;	vld1.16	{d8[2]}, [r4]!
	DCD	0xf4a484cd ;	vld1.16	{d8[3]}, [r4]!
	DCD	0xf4a7f04d ;	vld1.8	{d15[2]}, [r7]!
	DCD	0xf4a7f06d ;	vld1.8	{d15[3]}, [r7]!
	DCD	0xf4a6a48d ;	vld1.16	{d10[2]}, [r6]!
	DCD	0xf4a6a4cd ;	vld1.16	{d10[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000003 ;	beq	cd84 <pixman_composite_add_0565_8_0565_asm_neon+0x374>
	DCD	0xf4a4844d ;	vld1.16	{d8[1]}, [r4]!
	DCD	0xf4a7f02d ;	vld1.8	{d15[1]}, [r7]!
	DCD	0xf4a6a44d ;	vld1.16	{d10[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf2882818 ;	vshrn.i16	d2, q4, #8
	DCD	0xf28d1818 ;	vshrn.i16	d1, q4, #3
	DCD	0xf3958558 ;	vsli.16	q4, q4, #5
	DCD	0xf38b2412 ;	vsri.8	d2, d2, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0818 ;	vshrn.i16	d0, q4, #2
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xe59d1000 ;	ldr	r1, [sp]
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0001 ;	cmp	sl, r1
	DCD	0xf7dbf08a ;	pld	[fp, sl, lsl #1]
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xf7def00a ;	pld	[lr, sl]
	DCD	0xa04aa001 ;	subge	sl, sl, r1
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb1085 ;	ldrbge	r1, [fp, r5, lsl #1]!
	DCD	0xa7fc1083 ;	ldrbge	r1, [ip, r3, lsl #1]!
	DCD	0xa7fe1008 ;	ldrbge	r1, [lr, r8]!
	DCD	0xf3000054 ;	vqadd.u8	q0, q0, q2
	DCD	0xf3022056 ;	vqadd.u8	q1, q1, q3
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	ce34 <pixman_composite_add_0565_8_0565_asm_neon+0x424>
	DCD	0xf442d75d ;	vst1.16	{d29}, [r2 :64]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	ce44 <pixman_composite_add_0565_8_0565_asm_neon+0x434>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	ce50 <pixman_composite_add_0565_8_0565_asm_neon+0x440>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe1cd00d0 ;	ldrd	r0, [sp]
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0844085 ;	add	r4, r4, r5, lsl #1
	DCD	0xe0877008 ;	add	r7, r7, r8
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe0444080 ;	sub	r4, r4, r0, lsl #1
	DCD	0xe0477000 ;	sub	r7, r7, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe58d1004 ;	str	r1, [sp, #4]
	DCD	0xaafffef7 ;	bge	ca5c <pixman_composite_add_0565_8_0565_asm_neon+0x4c>
	DCD	0xe8bd0003 ;	pop	{r0, r1}
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a00001f ;	beq	cf10 <pixman_composite_add_0565_8_0565_asm_neon+0x500>
	DCD	0xf426aa4d ;	vld1.16	{d10-d11}, [r6]!
	DCD	0xf4248a4d ;	vld1.16	{d8-d9}, [r4]!
	DCD	0xf427f70d ;	vld1.8	{d15}, [r7]!
	DCD	0xf2882818 ;	vshrn.i16	d2, q4, #8
	DCD	0xf28d1818 ;	vshrn.i16	d1, q4, #3
	DCD	0xf3958558 ;	vsli.16	q4, q4, #5
	DCD	0xf38b2412 ;	vsri.8	d2, d2, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0818 ;	vshrn.i16	d0, q4, #2
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3000054 ;	vqadd.u8	q0, q0, q2
	DCD	0xf3022056 ;	vqadd.u8	q1, q1, q3
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xf442ca4d ;	vst1.16	{d28-d29}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00003a ;	beq	d004 <pixman_composite_add_0565_8_0565_asm_neon+0x5f4>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000005 ;	beq	cf38 <pixman_composite_add_0565_8_0565_asm_neon+0x528>
	DCD	0xf424974d ;	vld1.16	{d9}, [r4]!
	DCD	0xf4a7f08d ;	vld1.8	{d15[4]}, [r7]!
	DCD	0xf4a7f0ad ;	vld1.8	{d15[5]}, [r7]!
	DCD	0xf4a7f0cd ;	vld1.8	{d15[6]}, [r7]!
	DCD	0xf4a7f0ed ;	vld1.8	{d15[7]}, [r7]!
	DCD	0xf426b74d ;	vld1.16	{d11}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000005 ;	beq	cf58 <pixman_composite_add_0565_8_0565_asm_neon+0x548>
	DCD	0xf4a4848d ;	vld1.16	{d8[2]}, [r4]!
	DCD	0xf4a484cd ;	vld1.16	{d8[3]}, [r4]!
	DCD	0xf4a7f04d ;	vld1.8	{d15[2]}, [r7]!
	DCD	0xf4a7f06d ;	vld1.8	{d15[3]}, [r7]!
	DCD	0xf4a6a48d ;	vld1.16	{d10[2]}, [r6]!
	DCD	0xf4a6a4cd ;	vld1.16	{d10[3]}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	cf6c <pixman_composite_add_0565_8_0565_asm_neon+0x55c>
	DCD	0xf4a4844d ;	vld1.16	{d8[1]}, [r4]!
	DCD	0xf4a7f02d ;	vld1.8	{d15[1]}, [r7]!
	DCD	0xf4a6a44d ;	vld1.16	{d10[1]}, [r6]!
	DCD	0xf2882818 ;	vshrn.i16	d2, q4, #8
	DCD	0xf28d1818 ;	vshrn.i16	d1, q4, #3
	DCD	0xf3958558 ;	vsli.16	q4, q4, #5
	DCD	0xf38b2412 ;	vsri.8	d2, d2, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0818 ;	vshrn.i16	d0, q4, #2
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3000054 ;	vqadd.u8	q0, q0, q2
	DCD	0xf3022056 ;	vqadd.u8	q1, q1, q3
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	cfe8 <pixman_composite_add_0565_8_0565_asm_neon+0x5d8>
	DCD	0xf442d74d ;	vst1.16	{d29}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	cff8 <pixman_composite_add_0565_8_0565_asm_neon+0x5e8>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	d004 <pixman_composite_add_0565_8_0565_asm_neon+0x5f4>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe1cd00d0 ;	ldrd	r0, [sp]
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0844085 ;	add	r4, r4, r5, lsl #1
	DCD	0xe0877008 ;	add	r7, r7, r8
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe0444080 ;	sub	r4, r4, r0, lsl #1
	DCD	0xe0477000 ;	sub	r7, r7, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe58d1004 ;	str	r1, [sp, #4]
	DCD	0xaaffff95 ;	bge	ce88 <pixman_composite_add_0565_8_0565_asm_neon+0x478>
	DCD	0xe8bd0003 ;	pop	{r0, r1}
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_add_0565_8_0565_asm_neon|

|pixman_composite_out_reverse_8_0565_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xed2d8b10 ;	vpush	{d8-d15}
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a07000 ;	mov	r7, r0
	DCD	0xba00012a ;	blt	d520 <pixman_composite_out_reverse_8_0565_asm_neon+0x4e4>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba0000d4 ;	blt	d3d0 <pixman_composite_out_reverse_8_0565_asm_neon+0x394>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a00003f ;	beq	d184 <pixman_composite_out_reverse_8_0565_asm_neon+0x148>
	DCD	0xe3160002 ;	tst	r6, #2
	DCD	0x0a000003 ;	beq	d09c <pixman_composite_out_reverse_8_0565_asm_neon+0x60>
	DCD	0xf4a4f02d ;	vld1.8	{d15[1]}, [r4]!
	DCD	0xf4a6a44d ;	vld1.16	{d10[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000005 ;	beq	d0bc <pixman_composite_out_reverse_8_0565_asm_neon+0x80>
	DCD	0xf4a4f04d ;	vld1.8	{d15[2]}, [r4]!
	DCD	0xf4a4f06d ;	vld1.8	{d15[3]}, [r4]!
	DCD	0xf4a6a48d ;	vld1.16	{d10[2]}, [r6]!
	DCD	0xf4a6a4cd ;	vld1.16	{d10[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000006 ;	beq	d0e0 <pixman_composite_out_reverse_8_0565_asm_neon+0xa4>
	DCD	0xf4a4f08d ;	vld1.8	{d15[4]}, [r4]!
	DCD	0xf4a4f0ad ;	vld1.8	{d15[5]}, [r4]!
	DCD	0xf4a4f0cd ;	vld1.8	{d15[6]}, [r4]!
	DCD	0xf4a4f0ed ;	vld1.8	{d15[7]}, [r4]!
	DCD	0xf426b75d ;	vld1.16	{d11}, [r6 :64]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf3f0858f ;	vmvn	d24, d15
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf00a ;	pld	[fp, sl]
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8005 ;	ldrbge	r8, [fp, r5]!
	DCD	0xa7fc8083 ;	ldrbge	r8, [ip, r3, lsl #1]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf38c04a0 ;	vraddhn.i16	d0, q14, q8
	DCD	0xf38e14a2 ;	vraddhn.i16	d1, q15, q9
	DCD	0xf38824a4 ;	vraddhn.i16	d2, q12, q10
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xe3120002 ;	tst	r2, #2
	DCD	0x0a000000 ;	beq	d168 <pixman_composite_out_reverse_8_0565_asm_neon+0x12c>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000001 ;	beq	d178 <pixman_composite_out_reverse_8_0565_asm_neon+0x13c>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	d184 <pixman_composite_out_reverse_8_0565_asm_neon+0x148>
	DCD	0xf442d75d ;	vst1.16	{d29}, [r2 :64]!
	DCD	0xf426aa6d ;	vld1.16	{d10-d11}, [r6 :128]!
	DCD	0xf424f70d ;	vld1.8	{d15}, [r4]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf3f0858f ;	vmvn	d24, d15
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf00a ;	pld	[fp, sl]
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8005 ;	ldrbge	r8, [fp, r5]!
	DCD	0xa7fc8083 ;	ldrbge	r8, [ip, r3, lsl #1]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba000024 ;	blt	d27c <pixman_composite_out_reverse_8_0565_asm_neon+0x240>
	DCD	0xf424f70d ;	vld1.8	{d15}, [r4]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf38c04a0 ;	vraddhn.i16	d0, q14, q8
	DCD	0xf38e14a2 ;	vraddhn.i16	d1, q15, q9
	DCD	0xf38824a4 ;	vraddhn.i16	d2, q12, q10
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xf426aa6d ;	vld1.16	{d10-d11}, [r6 :128]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf00a ;	pld	[fp, sl]
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8005 ;	ldrbge	r8, [fp, r5]!
	DCD	0xa7fc8083 ;	ldrbge	r8, [ip, r3, lsl #1]!
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf3f0858f ;	vmvn	d24, d15
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf442ca6d ;	vst1.16	{d28-d29}, [r2 :128]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffda ;	bge	d1e8 <pixman_composite_out_reverse_8_0565_asm_neon+0x1ac>
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf38c04a0 ;	vraddhn.i16	d0, q14, q8
	DCD	0xf38e14a2 ;	vraddhn.i16	d1, q15, q9
	DCD	0xf38824a4 ;	vraddhn.i16	d2, q12, q10
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xf442ca6d ;	vst1.16	{d28-d29}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00003c ;	beq	d3a8 <pixman_composite_out_reverse_8_0565_asm_neon+0x36c>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000005 ;	beq	d2d4 <pixman_composite_out_reverse_8_0565_asm_neon+0x298>
	DCD	0xf4a4f08d ;	vld1.8	{d15[4]}, [r4]!
	DCD	0xf4a4f0ad ;	vld1.8	{d15[5]}, [r4]!
	DCD	0xf4a4f0cd ;	vld1.8	{d15[6]}, [r4]!
	DCD	0xf4a4f0ed ;	vld1.8	{d15[7]}, [r4]!
	DCD	0xf426b75d ;	vld1.16	{d11}, [r6 :64]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000004 ;	beq	d2f0 <pixman_composite_out_reverse_8_0565_asm_neon+0x2b4>
	DCD	0xf4a4f04d ;	vld1.8	{d15[2]}, [r4]!
	DCD	0xf4a4f06d ;	vld1.8	{d15[3]}, [r4]!
	DCD	0xf4a6a48d ;	vld1.16	{d10[2]}, [r6]!
	DCD	0xf4a6a4cd ;	vld1.16	{d10[3]}, [r6]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	d304 <pixman_composite_out_reverse_8_0565_asm_neon+0x2c8>
	DCD	0xf4a4f02d ;	vld1.8	{d15[1]}, [r4]!
	DCD	0xf4a6a44d ;	vld1.16	{d10[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf3f0858f ;	vmvn	d24, d15
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf00a ;	pld	[fp, sl]
	DCD	0xf7dcf08a ;	pld	[ip, sl, lsl #1]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8005 ;	ldrbge	r8, [fp, r5]!
	DCD	0xa7fc8083 ;	ldrbge	r8, [ip, r3, lsl #1]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf38c04a0 ;	vraddhn.i16	d0, q14, q8
	DCD	0xf38e14a2 ;	vraddhn.i16	d1, q15, q9
	DCD	0xf38824a4 ;	vraddhn.i16	d2, q12, q10
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	d38c <pixman_composite_out_reverse_8_0565_asm_neon+0x350>
	DCD	0xf442d75d ;	vst1.16	{d29}, [r2 :64]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	d39c <pixman_composite_out_reverse_8_0565_asm_neon+0x360>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	d3a8 <pixman_composite_out_reverse_8_0565_asm_neon+0x36c>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0844005 ;	add	r4, r4, r5
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe0444000 ;	sub	r4, r4, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff2c ;	bge	d07c <pixman_composite_out_reverse_8_0565_asm_neon+0x40>
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000017 ;	beq	d438 <pixman_composite_out_reverse_8_0565_asm_neon+0x3fc>
	DCD	0xf426aa4d ;	vld1.16	{d10-d11}, [r6]!
	DCD	0xf424f70d ;	vld1.8	{d15}, [r4]!
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf3f0858f ;	vmvn	d24, d15
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf38c04a0 ;	vraddhn.i16	d0, q14, q8
	DCD	0xf38e14a2 ;	vraddhn.i16	d1, q15, q9
	DCD	0xf38824a4 ;	vraddhn.i16	d2, q12, q10
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xf442ca4d ;	vst1.16	{d28-d29}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00002f ;	beq	d500 <pixman_composite_out_reverse_8_0565_asm_neon+0x4c4>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000004 ;	beq	d45c <pixman_composite_out_reverse_8_0565_asm_neon+0x420>
	DCD	0xf4a4f08d ;	vld1.8	{d15[4]}, [r4]!
	DCD	0xf4a4f0ad ;	vld1.8	{d15[5]}, [r4]!
	DCD	0xf4a4f0cd ;	vld1.8	{d15[6]}, [r4]!
	DCD	0xf4a4f0ed ;	vld1.8	{d15[7]}, [r4]!
	DCD	0xf426b74d ;	vld1.16	{d11}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000003 ;	beq	d474 <pixman_composite_out_reverse_8_0565_asm_neon+0x438>
	DCD	0xf4a4f04d ;	vld1.8	{d15[2]}, [r4]!
	DCD	0xf4a4f06d ;	vld1.8	{d15[3]}, [r4]!
	DCD	0xf4a6a48d ;	vld1.16	{d10[2]}, [r6]!
	DCD	0xf4a6a4cd ;	vld1.16	{d10[3]}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	d484 <pixman_composite_out_reverse_8_0565_asm_neon+0x448>
	DCD	0xf4a4f02d ;	vld1.8	{d15[1]}, [r4]!
	DCD	0xf4a6a44d ;	vld1.16	{d10[1]}, [r6]!
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf3f0858f ;	vmvn	d24, d15
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf38c04a0 ;	vraddhn.i16	d0, q14, q8
	DCD	0xf38e14a2 ;	vraddhn.i16	d1, q15, q9
	DCD	0xf38824a4 ;	vraddhn.i16	d2, q12, q10
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	d4e4 <pixman_composite_out_reverse_8_0565_asm_neon+0x4a8>
	DCD	0xf442d74d ;	vst1.16	{d29}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	d4f4 <pixman_composite_out_reverse_8_0565_asm_neon+0x4b8>
	DCD	0xf4c2c48d ;	vst1.16	{d28[2]}, [r2]!
	DCD	0xf4c2c4cd ;	vst1.16	{d28[3]}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	d500 <pixman_composite_out_reverse_8_0565_asm_neon+0x4c4>
	DCD	0xf4c2c44d ;	vst1.16	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822083 ;	add	r2, r2, r3, lsl #1
	DCD	0xe0844005 ;	add	r4, r4, r5
	DCD	0xe0422080 ;	sub	r2, r2, r0, lsl #1
	DCD	0xe0444000 ;	sub	r4, r4, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffab ;	bge	d3d0 <pixman_composite_out_reverse_8_0565_asm_neon+0x394>
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_out_reverse_8_0565_asm_neon|

|pixman_composite_out_reverse_8_8888_asm_neon| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe59d4028 ;	ldr	r4, [sp, #40]	; 0x28
	DCD	0xe3a0a000 ;	mov	sl, #0
	DCD	0xe59d502c ;	ldr	r5, [sp, #44]	; 0x2c
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xe1a0b004 ;	mov	fp, r4
	DCD	0xe1a0c006 ;	mov	ip, r6
	DCD	0xe1a0e007 ;	mov	lr, r7
	DCD	0xe1a09201 ;	lsl	r9, r1, #4
	DCD	0xe249900b ;	sub	r9, r9, #11
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a07000 ;	mov	r7, r0
	DCD	0xba000107 ;	blt	d97c <pixman_composite_out_reverse_8_8888_asm_neon+0x454>
	DCD	0xe3500010 ;	cmp	r0, #16
	DCD	0xba0000bb ;	blt	d854 <pixman_composite_out_reverse_8_8888_asm_neon+0x32c>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000039 ;	beq	d654 <pixman_composite_out_reverse_8_8888_asm_neon+0x12c>
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000003 ;	beq	d584 <pixman_composite_out_reverse_8_8888_asm_neon+0x5c>
	DCD	0xf4a4002d ;	vld1.8	{d0[1]}, [r4]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000004 ;	beq	d5a0 <pixman_composite_out_reverse_8_8888_asm_neon+0x78>
	DCD	0xf4a4004d ;	vld1.8	{d0[2]}, [r4]!
	DCD	0xf4a4006d ;	vld1.8	{d0[3]}, [r4]!
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xf4a4008d ;	vld1.8	{d0[4]}, [r4]!
	DCD	0xf4a400ad ;	vld1.8	{d0[5]}, [r4]!
	DCD	0xf4a400cd ;	vld1.8	{d0[6]}, [r4]!
	DCD	0xf4a400ed ;	vld1.8	{d0[7]}, [r4]!
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3b01580 ;	vmvn	d1, d0
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3c12c05 ;	vmull.u8	q9, d1, d5
	DCD	0xf3c14c06 ;	vmull.u8	q10, d1, d6
	DCD	0xf3c16c07 ;	vmull.u8	q11, d1, d7
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf00a ;	pld	[fp, sl]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8005 ;	ldrbge	r8, [fp, r5]!
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3120004 ;	tst	r2, #4
	DCD	0x0a000000 ;	beq	d644 <pixman_composite_out_reverse_8_8888_asm_neon+0x11c>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe3120008 ;	tst	r2, #8
	DCD	0x0a000000 ;	beq	d650 <pixman_composite_out_reverse_8_8888_asm_neon+0x128>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xf426402d ;	vld4.8	{d4-d7}, [r6 :128]!
	DCD	0xf424070d ;	vld1.8	{d0}, [r4]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xf3b01580 ;	vmvn	d1, d0
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3c12c05 ;	vmull.u8	q9, d1, d5
	DCD	0xf3c14c06 ;	vmull.u8	q10, d1, d6
	DCD	0xf3c16c07 ;	vmull.u8	q11, d1, d7
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf00a ;	pld	[fp, sl]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8005 ;	ldrbge	r8, [fp, r5]!
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xe2500010 ;	subs	r0, r0, #16
	DCD	0xba00001c ;	blt	d718 <pixman_composite_out_reverse_8_8888_asm_neon+0x1f0>
	DCD	0xf424070d ;	vld1.8	{d0}, [r4]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf426402d ;	vld4.8	{d4-d7}, [r6 :128]!
	DCD	0xe28aa008 ;	add	sl, sl, #8
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf00a ;	pld	[fp, sl]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8005 ;	ldrbge	r8, [fp, r5]!
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xf3b01580 ;	vmvn	d1, d0
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3c12c05 ;	vmull.u8	q9, d1, d5
	DCD	0xf3c14c06 ;	vmull.u8	q10, d1, d6
	DCD	0xf3c16c07 ;	vmull.u8	q11, d1, d7
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffe2 ;	bge	d6a4 <pixman_composite_out_reverse_8_8888_asm_neon+0x17c>
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf442c02d ;	vst4.8	{d28-d31}, [r2 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00003a ;	beq	d830 <pixman_composite_out_reverse_8_8888_asm_neon+0x308>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000005 ;	beq	d764 <pixman_composite_out_reverse_8_8888_asm_neon+0x23c>
	DCD	0xf4a4008d ;	vld1.8	{d0[4]}, [r4]!
	DCD	0xf4a400ad ;	vld1.8	{d0[5]}, [r4]!
	DCD	0xf4a400cd ;	vld1.8	{d0[6]}, [r4]!
	DCD	0xf4a400ed ;	vld1.8	{d0[7]}, [r4]!
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe28aa004 ;	add	sl, sl, #4
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000003 ;	beq	d77c <pixman_composite_out_reverse_8_8888_asm_neon+0x254>
	DCD	0xf4a4004d ;	vld1.8	{d0[2]}, [r4]!
	DCD	0xf4a4006d ;	vld1.8	{d0[3]}, [r4]!
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe28aa002 ;	add	sl, sl, #2
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000002 ;	beq	d790 <pixman_composite_out_reverse_8_8888_asm_neon+0x268>
	DCD	0xf4a4002d ;	vld1.8	{d0[1]}, [r4]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xe28aa001 ;	add	sl, sl, #1
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3b01580 ;	vmvn	d1, d0
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3c12c05 ;	vmull.u8	q9, d1, d5
	DCD	0xf3c14c06 ;	vmull.u8	q10, d1, d6
	DCD	0xf3c16c07 ;	vmull.u8	q11, d1, d7
	DCD	0xe319000f ;	tst	r9, #15
	DCD	0x128aa008 ;	addne	sl, sl, #8
	DCD	0x12499001 ;	subne	r9, r9, #1
	DCD	0xe15a0007 ;	cmp	sl, r7
	DCD	0xf7dbf00a ;	pld	[fp, sl]
	DCD	0xf7dcf10a ;	pld	[ip, sl, lsl #2]
	DCD	0xa04aa007 ;	subge	sl, sl, r7
	DCD	0xa2599010 ;	subsge	r9, r9, #16
	DCD	0xa7fb8005 ;	ldrbge	r8, [fp, r5]!
	DCD	0xa7fc8103 ;	ldrbge	r8, [ip, r3, lsl #2]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	d818 <pixman_composite_out_reverse_8_8888_asm_neon+0x2f0>
	DCD	0xf442eaad ;	vst1.32	{d30-d31}, [r2 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	d824 <pixman_composite_out_reverse_8_8888_asm_neon+0x2fc>
	DCD	0xf442d79d ;	vst1.32	{d29}, [r2 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	d830 <pixman_composite_out_reverse_8_8888_asm_neon+0x308>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844005 ;	add	r4, r4, r5
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444000 ;	sub	r4, r4, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffff44 ;	bge	d564 <pixman_composite_out_reverse_8_8888_asm_neon+0x3c>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a00000f ;	beq	d89c <pixman_composite_out_reverse_8_8888_asm_neon+0x374>
	DCD	0xf426400d ;	vld4.8	{d4-d7}, [r6]!
	DCD	0xf424070d ;	vld1.8	{d0}, [r4]!
	DCD	0xf3b01580 ;	vmvn	d1, d0
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3c12c05 ;	vmull.u8	q9, d1, d5
	DCD	0xf3c14c06 ;	vmull.u8	q10, d1, d6
	DCD	0xf3c16c07 ;	vmull.u8	q11, d1, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf442c00d ;	vst4.8	{d28-d31}, [r2]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00002d ;	beq	d95c <pixman_composite_out_reverse_8_8888_asm_neon+0x434>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000004 ;	beq	d8c0 <pixman_composite_out_reverse_8_8888_asm_neon+0x398>
	DCD	0xf4a4008d ;	vld1.8	{d0[4]}, [r4]!
	DCD	0xf4a400ad ;	vld1.8	{d0[5]}, [r4]!
	DCD	0xf4a400cd ;	vld1.8	{d0[6]}, [r4]!
	DCD	0xf4a400ed ;	vld1.8	{d0[7]}, [r4]!
	DCD	0xf4266a8d ;	vld1.32	{d6-d7}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000002 ;	beq	d8d4 <pixman_composite_out_reverse_8_8888_asm_neon+0x3ac>
	DCD	0xf4a4004d ;	vld1.8	{d0[2]}, [r4]!
	DCD	0xf4a4006d ;	vld1.8	{d0[3]}, [r4]!
	DCD	0xf426578d ;	vld1.32	{d5}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000001 ;	beq	d8e4 <pixman_composite_out_reverse_8_8888_asm_neon+0x3bc>
	DCD	0xf4a4002d ;	vld1.8	{d0[1]}, [r4]!
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3b01580 ;	vmvn	d1, d0
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3c12c05 ;	vmull.u8	q9, d1, d5
	DCD	0xf3c14c06 ;	vmull.u8	q10, d1, d6
	DCD	0xf3c16c07 ;	vmull.u8	q11, d1, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	d944 <pixman_composite_out_reverse_8_8888_asm_neon+0x41c>
	DCD	0xf442ea8d ;	vst1.32	{d30-d31}, [r2]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	d950 <pixman_composite_out_reverse_8_8888_asm_neon+0x428>
	DCD	0xf442d78d ;	vst1.32	{d29}, [r2]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	d95c <pixman_composite_out_reverse_8_8888_asm_neon+0x434>
	DCD	0xf4c2c88d ;	vst1.32	{d28[1]}, [r2]!
	DCD	0xe1a00007 ;	mov	r0, r7
	DCD	0xe0822103 ;	add	r2, r2, r3, lsl #2
	DCD	0xe0844005 ;	add	r4, r4, r5
	DCD	0xe0422100 ;	sub	r2, r2, r0, lsl #2
	DCD	0xe0444000 ;	sub	r4, r4, r0
	DCD	0xe2511001 ;	subs	r1, r1, #1
	DCD	0xe1a06002 ;	mov	r6, r2
	DCD	0xaaffffb5 ;	bge	d854 <pixman_composite_out_reverse_8_8888_asm_neon+0x32c>
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP  ; |pixman_composite_out_reverse_8_8888_asm_neon|

|pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon| PROC
	DCD	0xe59dc000 ;	ldr	ip, [sp]
	DCD	0xe92d4070 ;	push	{r4, r5, r6, lr}
	DCD	0xe1a06001 ;	mov	r6, r1
	DCD	0xe3500008 ;	cmp	r0, #8
	DCD	0xba000105 ;	blt	ddac <pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon+0x42c>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000047 ;	beq	dabc <pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon+0x13c>
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000005 ;	beq	d9bc <pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon+0x3c>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a408bf ;	vld1.32	{d0[1]}, [r4 :32]
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000009 ;	beq	d9ec <pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon+0x6c>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4183f ;	vld1.32	{d1[0]}, [r4 :32]
	DCD	0xf4a518bf ;	vld1.32	{d1[1]}, [r5 :32]
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4283f ;	vld1.32	{d2[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5383f ;	vld1.32	{d3[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a428bf ;	vld1.32	{d2[1]}, [r4 :32]
	DCD	0xf4a538bf ;	vld1.32	{d3[1]}, [r5 :32]
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3110004 ;	tst	r1, #4
	DCD	0x0a000000 ;	beq	daac <pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon+0x12c>
	DCD	0xf4c1c88d ;	vst1.32	{d28[1]}, [r1]!
	DCD	0xe3110008 ;	tst	r1, #8
	DCD	0x0a000000 ;	beq	dab8 <pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon+0x138>
	DCD	0xf441d79d ;	vst1.32	{d29}, [r1 :64]!
	DCD	0xf441eaad ;	vst1.32	{d30-d31}, [r1 :128]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xba00006d ;	blt	dc7c <pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon+0x2fc>
	DCD	0xf426402d ;	vld4.8	{d4-d7}, [r6 :128]!
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4083f ;	vld1.32	{d0[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5183f ;	vld1.32	{d1[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a408bf ;	vld1.32	{d0[1]}, [r4 :32]
	DCD	0xf4a518bf ;	vld1.32	{d1[1]}, [r5 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4283f ;	vld1.32	{d2[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5383f ;	vld1.32	{d3[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a428bf ;	vld1.32	{d2[1]}, [r4 :32]
	DCD	0xf4a538bf ;	vld1.32	{d3[1]}, [r5 :32]
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xba000036 ;	blt	dc50 <pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon+0x2d0>
	DCD	0xf426402d ;	vld4.8	{d4-d7}, [r6 :128]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4083f ;	vld1.32	{d0[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5183f ;	vld1.32	{d1[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a408bf ;	vld1.32	{d0[1]}, [r4 :32]
	DCD	0xf4a518bf ;	vld1.32	{d1[1]}, [r5 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4283f ;	vld1.32	{d2[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5383f ;	vld1.32	{d3[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a428bf ;	vld1.32	{d2[1]}, [r4 :32]
	DCD	0xf4a538bf ;	vld1.32	{d3[1]}, [r5 :32]
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3f06583 ;	vmvn	d22, d3
	DCD	0xf441c02d ;	vst4.8	{d28-d31}, [r1 :128]!
	DCD	0xf3c60c84 ;	vmull.u8	q8, d22, d4
	DCD	0xf3c62c85 ;	vmull.u8	q9, d22, d5
	DCD	0xf3c64c86 ;	vmull.u8	q10, d22, d6
	DCD	0xf3c66c87 ;	vmull.u8	q11, d22, d7
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffc8 ;	bge	db74 <pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon+0x1f4>
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf441c02d ;	vst4.8	{d28-d31}, [r1 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000048 ;	beq	dda8 <pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon+0x428>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000010 ;	beq	dcd0 <pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon+0x350>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4283f ;	vld1.32	{d2[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5383f ;	vld1.32	{d3[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a428bf ;	vld1.32	{d2[1]}, [r4 :32]
	DCD	0xf4a538bf ;	vld1.32	{d3[1]}, [r5 :32]
	DCD	0xf4266aad ;	vld1.32	{d6-d7}, [r6 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000008 ;	beq	dcfc <pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon+0x37c>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4183f ;	vld1.32	{d1[0]}, [r4 :32]
	DCD	0xf4a518bf ;	vld1.32	{d1[1]}, [r5 :32]
	DCD	0xf426579d ;	vld1.32	{d5}, [r6 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000004 ;	beq	dd18 <pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon+0x398>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a408bf ;	vld1.32	{d0[1]}, [r4 :32]
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	dd90 <pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon+0x410>
	DCD	0xf441eaad ;	vst1.32	{d30-d31}, [r1 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	dd9c <pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon+0x41c>
	DCD	0xf441d79d ;	vst1.32	{d29}, [r1 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	dda8 <pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon+0x428>
	DCD	0xf4c1c88d ;	vst1.32	{d28[1]}, [r1]!
	DCD	0xe8bd8070 ;	pop	{r4, r5, r6, pc}
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000048 ;	beq	ded8 <pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon+0x558>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000010 ;	beq	de00 <pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon+0x480>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4283f ;	vld1.32	{d2[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5383f ;	vld1.32	{d3[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a428bf ;	vld1.32	{d2[1]}, [r4 :32]
	DCD	0xf4a538bf ;	vld1.32	{d3[1]}, [r5 :32]
	DCD	0xf4266a8d ;	vld1.32	{d6-d7}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000008 ;	beq	de2c <pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon+0x4ac>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4183f ;	vld1.32	{d1[0]}, [r4 :32]
	DCD	0xf4a518bf ;	vld1.32	{d1[1]}, [r5 :32]
	DCD	0xf426578d ;	vld1.32	{d5}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000004 ;	beq	de48 <pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon+0x4c8>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a408bf ;	vld1.32	{d0[1]}, [r4 :32]
	DCD	0xf4a6488d ;	vld1.32	{d4[1]}, [r6]!
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24105 ;	vuzp.8	d4, d5
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b25107 ;	vuzp.8	d5, d7
	DCD	0xf3b24106 ;	vuzp.8	d4, d6
	DCD	0xf3f08583 ;	vmvn	d24, d3
	DCD	0xf3c80c84 ;	vmull.u8	q8, d24, d4
	DCD	0xf3c82c85 ;	vmull.u8	q9, d24, d5
	DCD	0xf3c84c86 ;	vmull.u8	q10, d24, d6
	DCD	0xf3c86c87 ;	vmull.u8	q11, d24, d7
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d88274 ;	vrshr.u16	q12, q10, #8
	DCD	0xf3d8a276 ;	vrshr.u16	q13, q11, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4a4 ;	vraddhn.i16	d30, q12, q10
	DCD	0xf3caf4a6 ;	vraddhn.i16	d31, q13, q11
	DCD	0xf340c07c ;	vqadd.u8	q14, q0, q14
	DCD	0xf342e07e ;	vqadd.u8	q15, q1, q15
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	dec0 <pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon+0x540>
	DCD	0xf441ea8d ;	vst1.32	{d30-d31}, [r1]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	decc <pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon+0x54c>
	DCD	0xf441d78d ;	vst1.32	{d29}, [r1]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	ded8 <pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon+0x558>
	DCD	0xf4c1c88d ;	vst1.32	{d28[1]}, [r1]!
	DCD	0xe8bd8070 ;	pop	{r4, r5, r6, pc}
	ENDP  ; |pixman_scaled_nearest_scanline_8888_8888_OVER_asm_neon|

|pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon| PROC
	DCD	0xe59dc000 ;	ldr	ip, [sp]
	DCD	0xe92d4070 ;	push	{r4, r5, r6, lr}
	DCD	0xe1a06001 ;	mov	r6, r1
	DCD	0xe3500008 ;	cmp	r0, #8
	DCD	0xba00011d ;	blt	e368 <pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon+0x48c>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a00004d ;	beq	e030 <pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon+0x154>
	DCD	0xe3160002 ;	tst	r6, #2
	DCD	0x0a000005 ;	beq	df18 <pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon+0x3c>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a408bf ;	vld1.32	{d0[1]}, [r4 :32]
	DCD	0xf4a6444d ;	vld1.16	{d4[1]}, [r6]!
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a00000a ;	beq	df4c <pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon+0x70>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4183f ;	vld1.32	{d1[0]}, [r4 :32]
	DCD	0xf4a518bf ;	vld1.32	{d1[1]}, [r5 :32]
	DCD	0xf4a6448d ;	vld1.16	{d4[2]}, [r6]!
	DCD	0xf4a644cd ;	vld1.16	{d4[3]}, [r6]!
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000011 ;	beq	df9c <pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon+0xc0>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4283f ;	vld1.32	{d2[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5383f ;	vld1.32	{d3[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a428bf ;	vld1.32	{d2[1]}, [r4 :32]
	DCD	0xf4a538bf ;	vld1.32	{d3[1]}, [r5 :32]
	DCD	0xf426575d ;	vld1.16	{d5}, [r6 :64]!
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c34c06 ;	vmull.u8	q10, d3, d6
	DCD	0xf3c36c07 ;	vmull.u8	q11, d3, d7
	DCD	0xf3c38c2e ;	vmull.u8	q12, d3, d30
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf3986276 ;	vrshr.u16	q3, q11, #8
	DCD	0xf3d8e278 ;	vrshr.u16	q15, q12, #8
	DCD	0xf3c444aa ;	vraddhn.i16	d20, q10, q13
	DCD	0xf3c67486 ;	vraddhn.i16	d23, q11, q3
	DCD	0xf3c864ae ;	vraddhn.i16	d22, q12, q15
	DCD	0xf3420034 ;	vqadd.u8	d16, d2, d20
	DCD	0xf3402076 ;	vqadd.u8	q9, q0, q11
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3110002 ;	tst	r1, #2
	DCD	0x0a000000 ;	beq	e014 <pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon+0x138>
	DCD	0xf4c1c44d ;	vst1.16	{d28[1]}, [r1]!
	DCD	0xe3110004 ;	tst	r1, #4
	DCD	0x0a000001 ;	beq	e024 <pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon+0x148>
	DCD	0xf4c1c48d ;	vst1.16	{d28[2]}, [r1]!
	DCD	0xf4c1c4cd ;	vst1.16	{d28[3]}, [r1]!
	DCD	0xe3110008 ;	tst	r1, #8
	DCD	0x0a000000 ;	beq	e030 <pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon+0x154>
	DCD	0xf441d75d ;	vst1.16	{d29}, [r1 :64]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xba00007d ;	blt	e230 <pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon+0x354>
	DCD	0xf4264a6d ;	vld1.16	{d4-d5}, [r6 :128]!
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4083f ;	vld1.32	{d0[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5183f ;	vld1.32	{d1[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a408bf ;	vld1.32	{d0[1]}, [r4 :32]
	DCD	0xf4a518bf ;	vld1.32	{d1[1]}, [r5 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4283f ;	vld1.32	{d2[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5383f ;	vld1.32	{d3[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a428bf ;	vld1.32	{d2[1]}, [r4 :32]
	DCD	0xf4a538bf ;	vld1.32	{d3[1]}, [r5 :32]
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c34c06 ;	vmull.u8	q10, d3, d6
	DCD	0xf3c36c07 ;	vmull.u8	q11, d3, d7
	DCD	0xf3c38c2e ;	vmull.u8	q12, d3, d30
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf3986276 ;	vrshr.u16	q3, q11, #8
	DCD	0xf3d8e278 ;	vrshr.u16	q15, q12, #8
	DCD	0xf3c444aa ;	vraddhn.i16	d20, q10, q13
	DCD	0xf3c67486 ;	vraddhn.i16	d23, q11, q3
	DCD	0xf3c864ae ;	vraddhn.i16	d22, q12, q15
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xba00003e ;	blt	e210 <pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon+0x334>
	DCD	0xf3420034 ;	vqadd.u8	d16, d2, d20
	DCD	0xf4264a6d ;	vld1.16	{d4-d5}, [r6 :128]!
	DCD	0xf3402076 ;	vqadd.u8	q9, q0, q11
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4083f ;	vld1.32	{d0[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5183f ;	vld1.32	{d1[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a408bf ;	vld1.32	{d0[1]}, [r4 :32]
	DCD	0xf4a518bf ;	vld1.32	{d1[1]}, [r5 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4283f ;	vld1.32	{d2[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5383f ;	vld1.32	{d3[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a428bf ;	vld1.32	{d2[1]}, [r4 :32]
	DCD	0xf4a538bf ;	vld1.32	{d3[1]}, [r5 :32]
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c34c06 ;	vmull.u8	q10, d3, d6
	DCD	0xf3c36c07 ;	vmull.u8	q11, d3, d7
	DCD	0xf3c38c2e ;	vmull.u8	q12, d3, d30
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf3986276 ;	vrshr.u16	q3, q11, #8
	DCD	0xf3d8e278 ;	vrshr.u16	q15, q12, #8
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xf3c444aa ;	vraddhn.i16	d20, q10, q13
	DCD	0xf3c67486 ;	vraddhn.i16	d23, q11, q3
	DCD	0xf3c864ae ;	vraddhn.i16	d22, q12, q15
	DCD	0xf441ca6d ;	vst1.16	{d28-d29}, [r1 :128]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffc0 ;	bge	e114 <pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon+0x238>
	DCD	0xf3420034 ;	vqadd.u8	d16, d2, d20
	DCD	0xf3402076 ;	vqadd.u8	q9, q0, q11
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xf441ca6d ;	vst1.16	{d28-d29}, [r1 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00004a ;	beq	e364 <pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon+0x488>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000010 ;	beq	e284 <pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon+0x3a8>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4283f ;	vld1.32	{d2[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5383f ;	vld1.32	{d3[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a428bf ;	vld1.32	{d2[1]}, [r4 :32]
	DCD	0xf4a538bf ;	vld1.32	{d3[1]}, [r5 :32]
	DCD	0xf426575d ;	vld1.16	{d5}, [r6 :64]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000009 ;	beq	e2b4 <pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon+0x3d8>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4183f ;	vld1.32	{d1[0]}, [r4 :32]
	DCD	0xf4a518bf ;	vld1.32	{d1[1]}, [r5 :32]
	DCD	0xf4a6448d ;	vld1.16	{d4[2]}, [r6]!
	DCD	0xf4a644cd ;	vld1.16	{d4[3]}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000004 ;	beq	e2d0 <pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon+0x3f4>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a408bf ;	vld1.32	{d0[1]}, [r4 :32]
	DCD	0xf4a6444d ;	vld1.16	{d4[1]}, [r6]!
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c34c06 ;	vmull.u8	q10, d3, d6
	DCD	0xf3c36c07 ;	vmull.u8	q11, d3, d7
	DCD	0xf3c38c2e ;	vmull.u8	q12, d3, d30
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf3986276 ;	vrshr.u16	q3, q11, #8
	DCD	0xf3d8e278 ;	vrshr.u16	q15, q12, #8
	DCD	0xf3c444aa ;	vraddhn.i16	d20, q10, q13
	DCD	0xf3c67486 ;	vraddhn.i16	d23, q11, q3
	DCD	0xf3c864ae ;	vraddhn.i16	d22, q12, q15
	DCD	0xf3420034 ;	vqadd.u8	d16, d2, d20
	DCD	0xf3402076 ;	vqadd.u8	q9, q0, q11
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	e348 <pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon+0x46c>
	DCD	0xf441d75d ;	vst1.16	{d29}, [r1 :64]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	e358 <pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon+0x47c>
	DCD	0xf4c1c48d ;	vst1.16	{d28[2]}, [r1]!
	DCD	0xf4c1c4cd ;	vst1.16	{d28[3]}, [r1]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	e364 <pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon+0x488>
	DCD	0xf4c1c44d ;	vst1.16	{d28[1]}, [r1]!
	DCD	0xe8bd8070 ;	pop	{r4, r5, r6, pc}
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00004a ;	beq	e49c <pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon+0x5c0>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000010 ;	beq	e3bc <pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon+0x4e0>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4283f ;	vld1.32	{d2[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5383f ;	vld1.32	{d3[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a428bf ;	vld1.32	{d2[1]}, [r4 :32]
	DCD	0xf4a538bf ;	vld1.32	{d3[1]}, [r5 :32]
	DCD	0xf426574d ;	vld1.16	{d5}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000009 ;	beq	e3ec <pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon+0x510>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4183f ;	vld1.32	{d1[0]}, [r4 :32]
	DCD	0xf4a518bf ;	vld1.32	{d1[1]}, [r5 :32]
	DCD	0xf4a6448d ;	vld1.16	{d4[2]}, [r6]!
	DCD	0xf4a644cd ;	vld1.16	{d4[3]}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000004 ;	beq	e408 <pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon+0x52c>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a408bf ;	vld1.32	{d0[1]}, [r4 :32]
	DCD	0xf4a6444d ;	vld1.16	{d4[1]}, [r6]!
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c34c06 ;	vmull.u8	q10, d3, d6
	DCD	0xf3c36c07 ;	vmull.u8	q11, d3, d7
	DCD	0xf3c38c2e ;	vmull.u8	q12, d3, d30
	DCD	0xf3d8a274 ;	vrshr.u16	q13, q10, #8
	DCD	0xf3986276 ;	vrshr.u16	q3, q11, #8
	DCD	0xf3d8e278 ;	vrshr.u16	q15, q12, #8
	DCD	0xf3c444aa ;	vraddhn.i16	d20, q10, q13
	DCD	0xf3c67486 ;	vraddhn.i16	d23, q11, q3
	DCD	0xf3c864ae ;	vraddhn.i16	d22, q12, q15
	DCD	0xf3420034 ;	vqadd.u8	d16, d2, d20
	DCD	0xf3402076 ;	vqadd.u8	q9, q0, q11
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	e480 <pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon+0x5a4>
	DCD	0xf441d74d ;	vst1.16	{d29}, [r1]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	e490 <pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon+0x5b4>
	DCD	0xf4c1c48d ;	vst1.16	{d28[2]}, [r1]!
	DCD	0xf4c1c4cd ;	vst1.16	{d28[3]}, [r1]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	e49c <pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon+0x5c0>
	DCD	0xf4c1c44d ;	vst1.16	{d28[1]}, [r1]!
	DCD	0xe8bd8070 ;	pop	{r4, r5, r6, pc}
	ENDP  ; |pixman_scaled_nearest_scanline_8888_0565_OVER_asm_neon|

|pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon| PROC
	DCD	0xe59dc000 ;	ldr	ip, [sp]
	DCD	0xe92d4070 ;	push	{r4, r5, r6, lr}
	DCD	0xe1a06001 ;	mov	r6, r1
	DCD	0xe3500008 ;	cmp	r0, #8
	DCD	0xba0000ce ;	blt	e7f0 <pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon+0x350>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a00003a ;	beq	e5a8 <pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon+0x108>
	DCD	0xe3160002 ;	tst	r6, #2
	DCD	0x0a000005 ;	beq	e4dc <pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon+0x3c>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a408bf ;	vld1.32	{d0[1]}, [r4 :32]
	DCD	0xe2866002 ;	add	r6, r6, #2
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000009 ;	beq	e50c <pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon+0x6c>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4183f ;	vld1.32	{d1[0]}, [r4 :32]
	DCD	0xf4a518bf ;	vld1.32	{d1[1]}, [r5 :32]
	DCD	0xe2866004 ;	add	r6, r6, #4
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000011 ;	beq	e55c <pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon+0xbc>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4283f ;	vld1.32	{d2[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5383f ;	vld1.32	{d3[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a428bf ;	vld1.32	{d2[1]}, [r4 :32]
	DCD	0xf4a538bf ;	vld1.32	{d3[1]}, [r5 :32]
	DCD	0xe2866008 ;	add	r6, r6, #8
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3f20301 ;	vshll.i8	q8, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3f22300 ;	vshll.i8	q9, d0, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3110002 ;	tst	r1, #2
	DCD	0x0a000000 ;	beq	e58c <pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon+0xec>
	DCD	0xf4c1c44d ;	vst1.16	{d28[1]}, [r1]!
	DCD	0xe3110004 ;	tst	r1, #4
	DCD	0x0a000001 ;	beq	e59c <pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon+0xfc>
	DCD	0xf4c1c48d ;	vst1.16	{d28[2]}, [r1]!
	DCD	0xf4c1c4cd ;	vst1.16	{d28[3]}, [r1]!
	DCD	0xe3110008 ;	tst	r1, #8
	DCD	0x0a000000 ;	beq	e5a8 <pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon+0x108>
	DCD	0xf441d75d ;	vst1.16	{d29}, [r1 :64]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xba000057 ;	blt	e710 <pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon+0x270>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4083f ;	vld1.32	{d0[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5183f ;	vld1.32	{d1[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a408bf ;	vld1.32	{d0[1]}, [r4 :32]
	DCD	0xf4a518bf ;	vld1.32	{d1[1]}, [r5 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4283f ;	vld1.32	{d2[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5383f ;	vld1.32	{d3[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a428bf ;	vld1.32	{d2[1]}, [r4 :32]
	DCD	0xf4a538bf ;	vld1.32	{d3[1]}, [r5 :32]
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3f20301 ;	vshll.i8	q8, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3f22300 ;	vshll.i8	q9, d0, #8
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xba00002b ;	blt	e704 <pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon+0x264>
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4083f ;	vld1.32	{d0[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5183f ;	vld1.32	{d1[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a408bf ;	vld1.32	{d0[1]}, [r4 :32]
	DCD	0xf4a518bf ;	vld1.32	{d1[1]}, [r5 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4283f ;	vld1.32	{d2[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5383f ;	vld1.32	{d3[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a428bf ;	vld1.32	{d2[1]}, [r4 :32]
	DCD	0xf4a538bf ;	vld1.32	{d3[1]}, [r5 :32]
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xf3f20301 ;	vshll.i8	q8, d1, #8
	DCD	0xf441ca6d ;	vst1.16	{d28-d29}, [r1 :128]!
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3f22300 ;	vshll.i8	q9, d0, #8
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffd3 ;	bge	e654 <pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon+0x1b4>
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xf441ca6d ;	vst1.16	{d28-d29}, [r1 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000034 ;	beq	e7ec <pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon+0x34c>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a00000f ;	beq	e760 <pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon+0x2c0>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4283f ;	vld1.32	{d2[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5383f ;	vld1.32	{d3[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a428bf ;	vld1.32	{d2[1]}, [r4 :32]
	DCD	0xf4a538bf ;	vld1.32	{d3[1]}, [r5 :32]
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000007 ;	beq	e788 <pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon+0x2e8>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4183f ;	vld1.32	{d1[0]}, [r4 :32]
	DCD	0xf4a518bf ;	vld1.32	{d1[1]}, [r5 :32]
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000003 ;	beq	e7a0 <pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon+0x300>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a408bf ;	vld1.32	{d0[1]}, [r4 :32]
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3f20301 ;	vshll.i8	q8, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3f22300 ;	vshll.i8	q9, d0, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	e7d0 <pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon+0x330>
	DCD	0xf441d75d ;	vst1.16	{d29}, [r1 :64]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	e7e0 <pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon+0x340>
	DCD	0xf4c1c48d ;	vst1.16	{d28[2]}, [r1]!
	DCD	0xf4c1c4cd ;	vst1.16	{d28[3]}, [r1]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	e7ec <pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon+0x34c>
	DCD	0xf4c1c44d ;	vst1.16	{d28[1]}, [r1]!
	DCD	0xe8bd8070 ;	pop	{r4, r5, r6, pc}
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000034 ;	beq	e8cc <pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon+0x42c>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a00000f ;	beq	e840 <pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon+0x3a0>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4283f ;	vld1.32	{d2[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5383f ;	vld1.32	{d3[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a428bf ;	vld1.32	{d2[1]}, [r4 :32]
	DCD	0xf4a538bf ;	vld1.32	{d3[1]}, [r5 :32]
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000007 ;	beq	e868 <pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon+0x3c8>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4183f ;	vld1.32	{d1[0]}, [r4 :32]
	DCD	0xf4a518bf ;	vld1.32	{d1[1]}, [r5 :32]
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000003 ;	beq	e880 <pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon+0x3e0>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a408bf ;	vld1.32	{d0[1]}, [r4 :32]
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3f20301 ;	vshll.i8	q8, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3f22300 ;	vshll.i8	q9, d0, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	e8b0 <pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon+0x410>
	DCD	0xf441d74d ;	vst1.16	{d29}, [r1]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	e8c0 <pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon+0x420>
	DCD	0xf4c1c48d ;	vst1.16	{d28[2]}, [r1]!
	DCD	0xf4c1c4cd ;	vst1.16	{d28[3]}, [r1]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	e8cc <pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon+0x42c>
	DCD	0xf4c1c44d ;	vst1.16	{d28[1]}, [r1]!
	DCD	0xe8bd8070 ;	pop	{r4, r5, r6, pc}
	ENDP  ; |pixman_scaled_nearest_scanline_8888_0565_SRC_asm_neon|

|pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon| PROC
	DCD	0xe59dc000 ;	ldr	ip, [sp]
	DCD	0xe92d4070 ;	push	{r4, r5, r6, lr}
	DCD	0xe1a06001 ;	mov	r6, r1
	DCD	0xe3500008 ;	cmp	r0, #8
	DCD	0xba0000c8 ;	blt	ec08 <pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon+0x338>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000037 ;	beq	e9cc <pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon+0xfc>
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a000005 ;	beq	e90c <pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon+0x3c>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a4045f ;	vld1.16	{d0[1]}, [r4 :16]
	DCD	0xe2866004 ;	add	r6, r6, #4
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000009 ;	beq	e93c <pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon+0x6c>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a4049f ;	vld1.16	{d0[2]}, [r4 :16]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a404df ;	vld1.16	{d0[3]}, [r4 :16]
	DCD	0xe2866008 ;	add	r6, r6, #8
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4141f ;	vld1.16	{d1[0]}, [r4 :16]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a5145f ;	vld1.16	{d1[1]}, [r5 :16]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4149f ;	vld1.16	{d1[2]}, [r4 :16]
	DCD	0xf4a514df ;	vld1.16	{d1[3]}, [r5 :16]
	DCD	0xe2866010 ;	add	r6, r6, #16
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf2c8e810 ;	vshrn.i16	d30, q0, #8
	DCD	0xf2cdd810 ;	vshrn.i16	d29, q0, #3
	DCD	0xf3950550 ;	vsli.16	q0, q0, #5
	DCD	0xf3c7fe1f ;	vmov.i8	d31, #255	; 0xff
	DCD	0xf3cbe43e ;	vsri.8	d30, d30, #5
	DCD	0xf3cad43d ;	vsri.8	d29, d29, #6
	DCD	0xf2cec810 ;	vshrn.i16	d28, q0, #2
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3110004 ;	tst	r1, #4
	DCD	0x0a000000 ;	beq	e9bc <pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon+0xec>
	DCD	0xf4c1c88d ;	vst1.32	{d28[1]}, [r1]!
	DCD	0xe3110008 ;	tst	r1, #8
	DCD	0x0a000000 ;	beq	e9c8 <pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon+0xf8>
	DCD	0xf441d79d ;	vst1.32	{d29}, [r1 :64]!
	DCD	0xf441eaad ;	vst1.32	{d30-d31}, [r1 :128]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xba000053 ;	blt	eb24 <pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon+0x254>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4041f ;	vld1.16	{d0[0]}, [r4 :16]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a5045f ;	vld1.16	{d0[1]}, [r5 :16]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4049f ;	vld1.16	{d0[2]}, [r4 :16]
	DCD	0xf4a504df ;	vld1.16	{d0[3]}, [r5 :16]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4141f ;	vld1.16	{d1[0]}, [r4 :16]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a5145f ;	vld1.16	{d1[1]}, [r5 :16]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4149f ;	vld1.16	{d1[2]}, [r4 :16]
	DCD	0xf4a514df ;	vld1.16	{d1[3]}, [r5 :16]
	DCD	0xf2c8e810 ;	vshrn.i16	d30, q0, #8
	DCD	0xf2cdd810 ;	vshrn.i16	d29, q0, #3
	DCD	0xf3950550 ;	vsli.16	q0, q0, #5
	DCD	0xf3c7fe1f ;	vmov.i8	d31, #255	; 0xff
	DCD	0xf3cbe43e ;	vsri.8	d30, d30, #5
	DCD	0xf3cad43d ;	vsri.8	d29, d29, #6
	DCD	0xf2cec810 ;	vshrn.i16	d28, q0, #2
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xba000029 ;	blt	eb20 <pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon+0x250>
	DCD	0xf441c02d ;	vst4.8	{d28-d31}, [r1 :128]!
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4041f ;	vld1.16	{d0[0]}, [r4 :16]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a5045f ;	vld1.16	{d0[1]}, [r5 :16]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4049f ;	vld1.16	{d0[2]}, [r4 :16]
	DCD	0xf4a504df ;	vld1.16	{d0[3]}, [r5 :16]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4141f ;	vld1.16	{d1[0]}, [r4 :16]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a5145f ;	vld1.16	{d1[1]}, [r5 :16]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4149f ;	vld1.16	{d1[2]}, [r4 :16]
	DCD	0xf4a514df ;	vld1.16	{d1[3]}, [r5 :16]
	DCD	0xf2c8e810 ;	vshrn.i16	d30, q0, #8
	DCD	0xf2cdd810 ;	vshrn.i16	d29, q0, #3
	DCD	0xf3950550 ;	vsli.16	q0, q0, #5
	DCD	0xf3c7fe1f ;	vmov.i8	d31, #255	; 0xff
	DCD	0xf3cbe43e ;	vsri.8	d30, d30, #5
	DCD	0xf3cad43d ;	vsri.8	d29, d29, #6
	DCD	0xf2cec810 ;	vshrn.i16	d28, q0, #2
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffd5 ;	bge	ea78 <pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon+0x1a8>
	DCD	0xf441c02d ;	vst4.8	{d28-d31}, [r1 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000035 ;	beq	ec04 <pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon+0x334>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a00000f ;	beq	eb74 <pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon+0x2a4>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4141f ;	vld1.16	{d1[0]}, [r4 :16]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a5145f ;	vld1.16	{d1[1]}, [r5 :16]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4149f ;	vld1.16	{d1[2]}, [r4 :16]
	DCD	0xf4a514df ;	vld1.16	{d1[3]}, [r5 :16]
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000007 ;	beq	eb9c <pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon+0x2cc>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a4049f ;	vld1.16	{d0[2]}, [r4 :16]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a404df ;	vld1.16	{d0[3]}, [r4 :16]
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000003 ;	beq	ebb4 <pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon+0x2e4>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a4045f ;	vld1.16	{d0[1]}, [r4 :16]
	DCD	0xf2c8e810 ;	vshrn.i16	d30, q0, #8
	DCD	0xf2cdd810 ;	vshrn.i16	d29, q0, #3
	DCD	0xf3950550 ;	vsli.16	q0, q0, #5
	DCD	0xf3c7fe1f ;	vmov.i8	d31, #255	; 0xff
	DCD	0xf3cbe43e ;	vsri.8	d30, d30, #5
	DCD	0xf3cad43d ;	vsri.8	d29, d29, #6
	DCD	0xf2cec810 ;	vshrn.i16	d28, q0, #2
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	ebec <pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon+0x31c>
	DCD	0xf441eaad ;	vst1.32	{d30-d31}, [r1 :128]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	ebf8 <pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon+0x328>
	DCD	0xf441d79d ;	vst1.32	{d29}, [r1 :64]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	ec04 <pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon+0x334>
	DCD	0xf4c1c88d ;	vst1.32	{d28[1]}, [r1]!
	DCD	0xe8bd8070 ;	pop	{r4, r5, r6, pc}
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a000035 ;	beq	ece8 <pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon+0x418>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a00000f ;	beq	ec58 <pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon+0x388>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4141f ;	vld1.16	{d1[0]}, [r4 :16]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a5145f ;	vld1.16	{d1[1]}, [r5 :16]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4149f ;	vld1.16	{d1[2]}, [r4 :16]
	DCD	0xf4a514df ;	vld1.16	{d1[3]}, [r5 :16]
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000007 ;	beq	ec80 <pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon+0x3b0>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a4049f ;	vld1.16	{d0[2]}, [r4 :16]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a404df ;	vld1.16	{d0[3]}, [r4 :16]
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000003 ;	beq	ec98 <pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon+0x3c8>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a4045f ;	vld1.16	{d0[1]}, [r4 :16]
	DCD	0xf2c8e810 ;	vshrn.i16	d30, q0, #8
	DCD	0xf2cdd810 ;	vshrn.i16	d29, q0, #3
	DCD	0xf3950550 ;	vsli.16	q0, q0, #5
	DCD	0xf3c7fe1f ;	vmov.i8	d31, #255	; 0xff
	DCD	0xf3cbe43e ;	vsri.8	d30, d30, #5
	DCD	0xf3cad43d ;	vsri.8	d29, d29, #6
	DCD	0xf2cec810 ;	vshrn.i16	d28, q0, #2
	DCD	0xf3f2c1ae ;	vzip.8	d28, d30
	DCD	0xf3f2d1af ;	vzip.8	d29, d31
	DCD	0xf3f2e1af ;	vzip.8	d30, d31
	DCD	0xf3f2c1ad ;	vzip.8	d28, d29
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	ecd0 <pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon+0x400>
	DCD	0xf441ea8d ;	vst1.32	{d30-d31}, [r1]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000000 ;	beq	ecdc <pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon+0x40c>
	DCD	0xf441d78d ;	vst1.32	{d29}, [r1]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	ece8 <pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon+0x418>
	DCD	0xf4c1c88d ;	vst1.32	{d28[1]}, [r1]!
	DCD	0xe8bd8070 ;	pop	{r4, r5, r6, pc}
	ENDP  ; |pixman_scaled_nearest_scanline_0565_8888_SRC_asm_neon|

|pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon| PROC
	DCD	0xe59dc000 ;	ldr	ip, [sp]
	DCD	0xe92d4070 ;	push	{r4, r5, r6, lr}
	DCD	0xe59de014 ;	ldr	lr, [sp, #20]
	DCD	0xed2d8b10 ;	vpush	{d8-d15}
	DCD	0xe1a06001 ;	mov	r6, r1
	DCD	0xe3500008 ;	cmp	r0, #8
	DCD	0xba00015e ;	blt	f284 <pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon+0x598>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a000060 ;	beq	ee94 <pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon+0x1a8>
	DCD	0xe3160002 ;	tst	r6, #2
	DCD	0x0a000006 ;	beq	ed34 <pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon+0x48>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a488bf ;	vld1.32	{d8[1]}, [r4 :32]
	DCD	0xf4ee802d ;	vld1.8	{d24[1]}, [lr]!
	DCD	0xf4a6444d ;	vld1.16	{d4[1]}, [r6]!
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a00000c ;	beq	ed70 <pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon+0x84>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4983f ;	vld1.32	{d9[0]}, [r4 :32]
	DCD	0xf4a598bf ;	vld1.32	{d9[1]}, [r5 :32]
	DCD	0xf4ee804d ;	vld1.8	{d24[2]}, [lr]!
	DCD	0xf4ee806d ;	vld1.8	{d24[3]}, [lr]!
	DCD	0xf4a6448d ;	vld1.16	{d4[2]}, [r6]!
	DCD	0xf4a644cd ;	vld1.16	{d4[3]}, [r6]!
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000015 ;	beq	edd0 <pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon+0xe4>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4a83f ;	vld1.32	{d10[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5b83f ;	vld1.32	{d11[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4a8bf ;	vld1.32	{d10[1]}, [r4 :32]
	DCD	0xf4a5b8bf ;	vld1.32	{d11[1]}, [r5 :32]
	DCD	0xf4ee808d ;	vld1.8	{d24[4]}, [lr]!
	DCD	0xf4ee80ad ;	vld1.8	{d24[5]}, [lr]!
	DCD	0xf4ee80cd ;	vld1.8	{d24[6]}, [lr]!
	DCD	0xf4ee80ed ;	vld1.8	{d24[7]}, [lr]!
	DCD	0xf426575d ;	vld1.16	{d5}, [r6 :64]!
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf3b28109 ;	vuzp.8	d8, d9
	DCD	0xf3b2a10b ;	vuzp.8	d10, d11
	DCD	0xf3b2910b ;	vuzp.8	d9, d11
	DCD	0xf3b2810a ;	vuzp.8	d8, d10
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3882c89 ;	vmull.u8	q1, d24, d9
	DCD	0xf388cc8a ;	vmull.u8	q6, d24, d10
	DCD	0xf388ec8b ;	vmull.u8	q7, d24, d11
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d82252 ;	vrshr.u16	q9, q1, #8
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38c2424 ;	vraddhn.i16	d2, q6, q10
	DCD	0xf38e3426 ;	vraddhn.i16	d3, q7, q11
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c30c06 ;	vmull.u8	q8, d3, d6
	DCD	0xf3c32c07 ;	vmull.u8	q9, d3, d7
	DCD	0xf3c34c2e ;	vmull.u8	q10, d3, d30
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d86272 ;	vrshr.u16	q11, q9, #8
	DCD	0xf3d8e274 ;	vrshr.u16	q15, q10, #8
	DCD	0xf3c004aa ;	vraddhn.i16	d16, q8, q13
	DCD	0xf3c2b4a6 ;	vraddhn.i16	d27, q9, q11
	DCD	0xf3c4a4ae ;	vraddhn.i16	d26, q10, q15
	DCD	0xf3420030 ;	vqadd.u8	d16, d2, d16
	DCD	0xf340207a ;	vqadd.u8	q9, q0, q13
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3110002 ;	tst	r1, #2
	DCD	0x0a000000 ;	beq	ee78 <pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon+0x18c>
	DCD	0xf4c1c44d ;	vst1.16	{d28[1]}, [r1]!
	DCD	0xe3110004 ;	tst	r1, #4
	DCD	0x0a000001 ;	beq	ee88 <pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon+0x19c>
	DCD	0xf4c1c48d ;	vst1.16	{d28[2]}, [r1]!
	DCD	0xf4c1c4cd ;	vst1.16	{d28[3]}, [r1]!
	DCD	0xe3110008 ;	tst	r1, #8
	DCD	0x0a000000 ;	beq	ee94 <pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon+0x1a8>
	DCD	0xf441d75d ;	vst1.16	{d29}, [r1 :64]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xba000097 ;	blt	f0fc <pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon+0x410>
	DCD	0xf4264a6d ;	vld1.16	{d4-d5}, [r6 :128]!
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4883f ;	vld1.32	{d8[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5983f ;	vld1.32	{d9[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a488bf ;	vld1.32	{d8[1]}, [r4 :32]
	DCD	0xf4a598bf ;	vld1.32	{d9[1]}, [r5 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4a83f ;	vld1.32	{d10[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5b83f ;	vld1.32	{d11[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4a8bf ;	vld1.32	{d10[1]}, [r4 :32]
	DCD	0xf4a5b8bf ;	vld1.32	{d11[1]}, [r5 :32]
	DCD	0xf3b28109 ;	vuzp.8	d8, d9
	DCD	0xf3b2a10b ;	vuzp.8	d10, d11
	DCD	0xf3b2910b ;	vuzp.8	d9, d11
	DCD	0xf3b2810a ;	vuzp.8	d8, d10
	DCD	0xf46e870d ;	vld1.8	{d24}, [lr]!
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3882c89 ;	vmull.u8	q1, d24, d9
	DCD	0xf388cc8a ;	vmull.u8	q6, d24, d10
	DCD	0xf388ec8b ;	vmull.u8	q7, d24, d11
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d82252 ;	vrshr.u16	q9, q1, #8
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38c2424 ;	vraddhn.i16	d2, q6, q10
	DCD	0xf38e3426 ;	vraddhn.i16	d3, q7, q11
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c30c06 ;	vmull.u8	q8, d3, d6
	DCD	0xf3c32c07 ;	vmull.u8	q9, d3, d7
	DCD	0xf3c34c2e ;	vmull.u8	q10, d3, d30
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xba00004b ;	blt	f0c4 <pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon+0x3d8>
	DCD	0xf4264a6d ;	vld1.16	{d4-d5}, [r6 :128]!
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf46e870d ;	vld1.8	{d24}, [lr]!
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4883f ;	vld1.32	{d8[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5983f ;	vld1.32	{d9[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a488bf ;	vld1.32	{d8[1]}, [r4 :32]
	DCD	0xf4a598bf ;	vld1.32	{d9[1]}, [r5 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4a83f ;	vld1.32	{d10[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5b83f ;	vld1.32	{d11[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4a8bf ;	vld1.32	{d10[1]}, [r4 :32]
	DCD	0xf4a5b8bf ;	vld1.32	{d11[1]}, [r5 :32]
	DCD	0xf3b28109 ;	vuzp.8	d8, d9
	DCD	0xf3b2a10b ;	vuzp.8	d10, d11
	DCD	0xf3b2910b ;	vuzp.8	d9, d11
	DCD	0xf3b2810a ;	vuzp.8	d8, d10
	DCD	0xf388cc8a ;	vmull.u8	q6, d24, d10
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d86272 ;	vrshr.u16	q11, q9, #8
	DCD	0xf3d8e274 ;	vrshr.u16	q15, q10, #8
	DCD	0xf3c004aa ;	vraddhn.i16	d16, q8, q13
	DCD	0xf3c2b4a6 ;	vraddhn.i16	d27, q9, q11
	DCD	0xf3c4a4ae ;	vraddhn.i16	d26, q10, q15
	DCD	0xf3420030 ;	vqadd.u8	d16, d2, d16
	DCD	0xf3882c89 ;	vmull.u8	q1, d24, d9
	DCD	0xf340207a ;	vqadd.u8	q9, q0, q13
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf388ec8b ;	vmull.u8	q7, d24, d11
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d82252 ;	vrshr.u16	q9, q1, #8
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38c2424 ;	vraddhn.i16	d2, q6, q10
	DCD	0xf38e3426 ;	vraddhn.i16	d3, q7, q11
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf441ca6d ;	vst1.16	{d28-d29}, [r1 :128]!
	DCD	0xf3c30c06 ;	vmull.u8	q8, d3, d6
	DCD	0xf3c32c07 ;	vmull.u8	q9, d3, d7
	DCD	0xf3c34c2e ;	vmull.u8	q10, d3, d30
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffb3 ;	bge	ef94 <pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon+0x2a8>
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d86272 ;	vrshr.u16	q11, q9, #8
	DCD	0xf3d8e274 ;	vrshr.u16	q15, q10, #8
	DCD	0xf3c004aa ;	vraddhn.i16	d16, q8, q13
	DCD	0xf3c2b4a6 ;	vraddhn.i16	d27, q9, q11
	DCD	0xf3c4a4ae ;	vraddhn.i16	d26, q10, q15
	DCD	0xf3420030 ;	vqadd.u8	d16, d2, d16
	DCD	0xf340207a ;	vqadd.u8	q9, q0, q13
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xf441ca6d ;	vst1.16	{d28-d29}, [r1 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00005d ;	beq	f27c <pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon+0x590>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000014 ;	beq	f160 <pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon+0x474>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4a83f ;	vld1.32	{d10[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5b83f ;	vld1.32	{d11[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4a8bf ;	vld1.32	{d10[1]}, [r4 :32]
	DCD	0xf4a5b8bf ;	vld1.32	{d11[1]}, [r5 :32]
	DCD	0xf4ee808d ;	vld1.8	{d24[4]}, [lr]!
	DCD	0xf4ee80ad ;	vld1.8	{d24[5]}, [lr]!
	DCD	0xf4ee80cd ;	vld1.8	{d24[6]}, [lr]!
	DCD	0xf4ee80ed ;	vld1.8	{d24[7]}, [lr]!
	DCD	0xf426575d ;	vld1.16	{d5}, [r6 :64]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a00000b ;	beq	f198 <pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon+0x4ac>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4983f ;	vld1.32	{d9[0]}, [r4 :32]
	DCD	0xf4a598bf ;	vld1.32	{d9[1]}, [r5 :32]
	DCD	0xf4ee804d ;	vld1.8	{d24[2]}, [lr]!
	DCD	0xf4ee806d ;	vld1.8	{d24[3]}, [lr]!
	DCD	0xf4a6448d ;	vld1.16	{d4[2]}, [r6]!
	DCD	0xf4a644cd ;	vld1.16	{d4[3]}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000005 ;	beq	f1b8 <pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon+0x4cc>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a488bf ;	vld1.32	{d8[1]}, [r4 :32]
	DCD	0xf4ee802d ;	vld1.8	{d24[1]}, [lr]!
	DCD	0xf4a6444d ;	vld1.16	{d4[1]}, [r6]!
	DCD	0xf3b28109 ;	vuzp.8	d8, d9
	DCD	0xf3b2a10b ;	vuzp.8	d10, d11
	DCD	0xf3b2910b ;	vuzp.8	d9, d11
	DCD	0xf3b2810a ;	vuzp.8	d8, d10
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3882c89 ;	vmull.u8	q1, d24, d9
	DCD	0xf388cc8a ;	vmull.u8	q6, d24, d10
	DCD	0xf388ec8b ;	vmull.u8	q7, d24, d11
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d82252 ;	vrshr.u16	q9, q1, #8
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38c2424 ;	vraddhn.i16	d2, q6, q10
	DCD	0xf38e3426 ;	vraddhn.i16	d3, q7, q11
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c30c06 ;	vmull.u8	q8, d3, d6
	DCD	0xf3c32c07 ;	vmull.u8	q9, d3, d7
	DCD	0xf3c34c2e ;	vmull.u8	q10, d3, d30
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d86272 ;	vrshr.u16	q11, q9, #8
	DCD	0xf3d8e274 ;	vrshr.u16	q15, q10, #8
	DCD	0xf3c004aa ;	vraddhn.i16	d16, q8, q13
	DCD	0xf3c2b4a6 ;	vraddhn.i16	d27, q9, q11
	DCD	0xf3c4a4ae ;	vraddhn.i16	d26, q10, q15
	DCD	0xf3420030 ;	vqadd.u8	d16, d2, d16
	DCD	0xf340207a ;	vqadd.u8	q9, q0, q13
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	f260 <pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon+0x574>
	DCD	0xf441d75d ;	vst1.16	{d29}, [r1 :64]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	f270 <pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon+0x584>
	DCD	0xf4c1c48d ;	vst1.16	{d28[2]}, [r1]!
	DCD	0xf4c1c4cd ;	vst1.16	{d28[3]}, [r1]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	f27c <pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon+0x590>
	DCD	0xf4c1c44d ;	vst1.16	{d28[1]}, [r1]!
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd8070 ;	pop	{r4, r5, r6, pc}
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00005d ;	beq	f404 <pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon+0x718>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000014 ;	beq	f2e8 <pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon+0x5fc>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe043300c ;	sub	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4a83f ;	vld1.32	{d10[0]}, [r4 :32]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083308c ;	add	r3, r3, ip, lsl #1
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a5b83f ;	vld1.32	{d11[0]}, [r5 :32]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4a8bf ;	vld1.32	{d10[1]}, [r4 :32]
	DCD	0xf4a5b8bf ;	vld1.32	{d11[1]}, [r5 :32]
	DCD	0xf4ee808d ;	vld1.8	{d24[4]}, [lr]!
	DCD	0xf4ee80ad ;	vld1.8	{d24[5]}, [lr]!
	DCD	0xf4ee80cd ;	vld1.8	{d24[6]}, [lr]!
	DCD	0xf4ee80ed ;	vld1.8	{d24[7]}, [lr]!
	DCD	0xf426574d ;	vld1.16	{d5}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a00000b ;	beq	f320 <pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon+0x634>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf4a4983f ;	vld1.32	{d9[0]}, [r4 :32]
	DCD	0xf4a598bf ;	vld1.32	{d9[1]}, [r5 :32]
	DCD	0xf4ee804d ;	vld1.8	{d24[2]}, [lr]!
	DCD	0xf4ee806d ;	vld1.8	{d24[3]}, [lr]!
	DCD	0xf4a6448d ;	vld1.16	{d4[2]}, [r6]!
	DCD	0xf4a644cd ;	vld1.16	{d4[3]}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000005 ;	beq	f340 <pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon+0x654>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4a488bf ;	vld1.32	{d8[1]}, [r4 :32]
	DCD	0xf4ee802d ;	vld1.8	{d24[1]}, [lr]!
	DCD	0xf4a6444d ;	vld1.16	{d4[1]}, [r6]!
	DCD	0xf3b28109 ;	vuzp.8	d8, d9
	DCD	0xf3b2a10b ;	vuzp.8	d10, d11
	DCD	0xf3b2910b ;	vuzp.8	d9, d11
	DCD	0xf3b2810a ;	vuzp.8	d8, d10
	DCD	0xf3880c88 ;	vmull.u8	q0, d24, d8
	DCD	0xf3882c89 ;	vmull.u8	q1, d24, d9
	DCD	0xf388cc8a ;	vmull.u8	q6, d24, d10
	DCD	0xf388ec8b ;	vmull.u8	q7, d24, d11
	DCD	0xf2886814 ;	vshrn.i16	d6, q2, #8
	DCD	0xf28d7814 ;	vshrn.i16	d7, q2, #3
	DCD	0xf3954554 ;	vsli.16	q2, q2, #5
	DCD	0xf3d80250 ;	vrshr.u16	q8, q0, #8
	DCD	0xf3d82252 ;	vrshr.u16	q9, q1, #8
	DCD	0xf3d8425c ;	vrshr.u16	q10, q6, #8
	DCD	0xf3d8625e ;	vrshr.u16	q11, q7, #8
	DCD	0xf3800420 ;	vraddhn.i16	d0, q0, q8
	DCD	0xf3821422 ;	vraddhn.i16	d1, q1, q9
	DCD	0xf38c2424 ;	vraddhn.i16	d2, q6, q10
	DCD	0xf38e3426 ;	vraddhn.i16	d3, q7, q11
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a7417 ;	vsri.8	d7, d7, #6
	DCD	0xf3b03583 ;	vmvn	d3, d3
	DCD	0xf2cee814 ;	vshrn.i16	d30, q2, #2
	DCD	0xf3c30c06 ;	vmull.u8	q8, d3, d6
	DCD	0xf3c32c07 ;	vmull.u8	q9, d3, d7
	DCD	0xf3c34c2e ;	vmull.u8	q10, d3, d30
	DCD	0xf3d8a270 ;	vrshr.u16	q13, q8, #8
	DCD	0xf3d86272 ;	vrshr.u16	q11, q9, #8
	DCD	0xf3d8e274 ;	vrshr.u16	q15, q10, #8
	DCD	0xf3c004aa ;	vraddhn.i16	d16, q8, q13
	DCD	0xf3c2b4a6 ;	vraddhn.i16	d27, q9, q11
	DCD	0xf3c4a4ae ;	vraddhn.i16	d26, q10, q15
	DCD	0xf3420030 ;	vqadd.u8	d16, d2, d16
	DCD	0xf340207a ;	vqadd.u8	q9, q0, q13
	DCD	0xf3f2c320 ;	vshll.i8	q14, d16, #8
	DCD	0xf3f20323 ;	vshll.i8	q8, d19, #8
	DCD	0xf3f22322 ;	vshll.i8	q9, d18, #8
	DCD	0xf3dbc470 ;	vsri.16	q14, q8, #5
	DCD	0xf3d5c472 ;	vsri.16	q14, q9, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	f3e8 <pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon+0x6fc>
	DCD	0xf441d74d ;	vst1.16	{d29}, [r1]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	f3f8 <pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon+0x70c>
	DCD	0xf4c1c48d ;	vst1.16	{d28[2]}, [r1]!
	DCD	0xf4c1c4cd ;	vst1.16	{d28[3]}, [r1]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	f404 <pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon+0x718>
	DCD	0xf4c1c44d ;	vst1.16	{d28[1]}, [r1]!
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd8070 ;	pop	{r4, r5, r6, pc}
	ENDP  ; |pixman_scaled_nearest_scanline_8888_8_0565_OVER_asm_neon|

|pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon| PROC
	DCD	0xe59dc000 ;	ldr	ip, [sp]
	DCD	0xe92d4070 ;	push	{r4, r5, r6, lr}
	DCD	0xe59de014 ;	ldr	lr, [sp, #20]
	DCD	0xed2d8b10 ;	vpush	{d8-d15}
	DCD	0xe1a06001 ;	mov	r6, r1
	DCD	0xe3500008 ;	cmp	r0, #8
	DCD	0xba00015a ;	blt	f994 <pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon+0x588>
	DCD	0xe316000f ;	tst	r6, #15
	DCD	0x0a00005f ;	beq	f5b0 <pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon+0x1a4>
	DCD	0xe3160002 ;	tst	r6, #2
	DCD	0x0a000006 ;	beq	f454 <pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon+0x48>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a4845f ;	vld1.16	{d8[1]}, [r4 :16]
	DCD	0xf4aef02d ;	vld1.8	{d15[1]}, [lr]!
	DCD	0xf4a6a44d ;	vld1.16	{d10[1]}, [r6]!
	DCD	0xe2400001 ;	sub	r0, r0, #1
	DCD	0xe3160004 ;	tst	r6, #4
	DCD	0x0a00000c ;	beq	f490 <pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon+0x84>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a4849f ;	vld1.16	{d8[2]}, [r4 :16]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a484df ;	vld1.16	{d8[3]}, [r4 :16]
	DCD	0xf4aef04d ;	vld1.8	{d15[2]}, [lr]!
	DCD	0xf4aef06d ;	vld1.8	{d15[3]}, [lr]!
	DCD	0xf4a6a48d ;	vld1.16	{d10[2]}, [r6]!
	DCD	0xf4a6a4cd ;	vld1.16	{d10[3]}, [r6]!
	DCD	0xe2400002 ;	sub	r0, r0, #2
	DCD	0xe3160008 ;	tst	r6, #8
	DCD	0x0a000015 ;	beq	f4f0 <pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon+0xe4>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4941f ;	vld1.16	{d9[0]}, [r4 :16]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a5945f ;	vld1.16	{d9[1]}, [r5 :16]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4949f ;	vld1.16	{d9[2]}, [r4 :16]
	DCD	0xf4a594df ;	vld1.16	{d9[3]}, [r5 :16]
	DCD	0xf4aef08d ;	vld1.8	{d15[4]}, [lr]!
	DCD	0xf4aef0ad ;	vld1.8	{d15[5]}, [lr]!
	DCD	0xf4aef0cd ;	vld1.8	{d15[6]}, [lr]!
	DCD	0xf4aef0ed ;	vld1.8	{d15[7]}, [lr]!
	DCD	0xf426b75d ;	vld1.16	{d11}, [r6 :64]!
	DCD	0xe2400004 ;	sub	r0, r0, #4
	DCD	0xf2882818 ;	vshrn.i16	d2, q4, #8
	DCD	0xf28d1818 ;	vshrn.i16	d1, q4, #3
	DCD	0xf3958558 ;	vsli.16	q4, q4, #5
	DCD	0xf38b2412 ;	vsri.8	d2, d2, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0818 ;	vshrn.i16	d0, q4, #2
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf3b0758f ;	vmvn	d7, d15
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3c70c04 ;	vmull.u8	q8, d7, d4
	DCD	0xf3c72c05 ;	vmull.u8	q9, d7, d5
	DCD	0xf3c7ac06 ;	vmull.u8	q13, d7, d6
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d8827a ;	vrshr.u16	q12, q13, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4aa ;	vraddhn.i16	d30, q12, q13
	DCD	0xf300007c ;	vqadd.u8	q0, q0, q14
	DCD	0xf302207e ;	vqadd.u8	q1, q1, q15
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xe3110002 ;	tst	r1, #2
	DCD	0x0a000000 ;	beq	f594 <pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon+0x188>
	DCD	0xf4c1c44d ;	vst1.16	{d28[1]}, [r1]!
	DCD	0xe3110004 ;	tst	r1, #4
	DCD	0x0a000001 ;	beq	f5a4 <pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon+0x198>
	DCD	0xf4c1c48d ;	vst1.16	{d28[2]}, [r1]!
	DCD	0xf4c1c4cd ;	vst1.16	{d28[3]}, [r1]!
	DCD	0xe3110008 ;	tst	r1, #8
	DCD	0x0a000000 ;	beq	f5b0 <pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon+0x1a4>
	DCD	0xf441d75d ;	vst1.16	{d29}, [r1 :64]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xba000095 ;	blt	f810 <pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon+0x404>
	DCD	0xf426aa6d ;	vld1.16	{d10-d11}, [r6 :128]!
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4841f ;	vld1.16	{d8[0]}, [r4 :16]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a5845f ;	vld1.16	{d8[1]}, [r5 :16]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4849f ;	vld1.16	{d8[2]}, [r4 :16]
	DCD	0xf4a584df ;	vld1.16	{d8[3]}, [r5 :16]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4941f ;	vld1.16	{d9[0]}, [r4 :16]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a5945f ;	vld1.16	{d9[1]}, [r5 :16]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4949f ;	vld1.16	{d9[2]}, [r4 :16]
	DCD	0xf4a594df ;	vld1.16	{d9[3]}, [r5 :16]
	DCD	0xf42ef70d ;	vld1.8	{d15}, [lr]!
	DCD	0xf2882818 ;	vshrn.i16	d2, q4, #8
	DCD	0xf28d1818 ;	vshrn.i16	d1, q4, #3
	DCD	0xf3958558 ;	vsli.16	q4, q4, #5
	DCD	0xf38b2412 ;	vsri.8	d2, d2, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0818 ;	vshrn.i16	d0, q4, #2
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf3b0758f ;	vmvn	d7, d15
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3c70c04 ;	vmull.u8	q8, d7, d4
	DCD	0xf3c72c05 ;	vmull.u8	q9, d7, d5
	DCD	0xf3c7ac06 ;	vmull.u8	q13, d7, d6
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xba00004a ;	blt	f7d8 <pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon+0x3cc>
	DCD	0xf42ef70d ;	vld1.8	{d15}, [lr]!
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d8827a ;	vrshr.u16	q12, q13, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4aa ;	vraddhn.i16	d30, q12, q13
	DCD	0xf300007c ;	vqadd.u8	q0, q0, q14
	DCD	0xf302207e ;	vqadd.u8	q1, q1, q15
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4841f ;	vld1.16	{d8[0]}, [r4 :16]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a5845f ;	vld1.16	{d8[1]}, [r5 :16]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4849f ;	vld1.16	{d8[2]}, [r4 :16]
	DCD	0xf4a584df ;	vld1.16	{d8[3]}, [r5 :16]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4941f ;	vld1.16	{d9[0]}, [r4 :16]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a5945f ;	vld1.16	{d9[1]}, [r5 :16]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4949f ;	vld1.16	{d9[2]}, [r4 :16]
	DCD	0xf4a594df ;	vld1.16	{d9[3]}, [r5 :16]
	DCD	0xf426aa6d ;	vld1.16	{d10-d11}, [r6 :128]!
	DCD	0xf2882818 ;	vshrn.i16	d2, q4, #8
	DCD	0xf28d1818 ;	vshrn.i16	d1, q4, #3
	DCD	0xf3958558 ;	vsli.16	q4, q4, #5
	DCD	0xf38b2412 ;	vsri.8	d2, d2, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0818 ;	vshrn.i16	d0, q4, #2
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf3b0758f ;	vmvn	d7, d15
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3c70c04 ;	vmull.u8	q8, d7, d4
	DCD	0xf3c72c05 ;	vmull.u8	q9, d7, d5
	DCD	0xf3c7ac06 ;	vmull.u8	q13, d7, d6
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf441ca6d ;	vst1.16	{d28-d29}, [r1 :128]!
	DCD	0xe2500008 ;	subs	r0, r0, #8
	DCD	0xaaffffb4 ;	bge	f6ac <pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon+0x2a0>
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d8827a ;	vrshr.u16	q12, q13, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4aa ;	vraddhn.i16	d30, q12, q13
	DCD	0xf300007c ;	vqadd.u8	q0, q0, q14
	DCD	0xf302207e ;	vqadd.u8	q1, q1, q15
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xf441ca6d ;	vst1.16	{d28-d29}, [r1 :128]!
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00005c ;	beq	f98c <pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon+0x580>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000014 ;	beq	f874 <pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon+0x468>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4941f ;	vld1.16	{d9[0]}, [r4 :16]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a5945f ;	vld1.16	{d9[1]}, [r5 :16]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4949f ;	vld1.16	{d9[2]}, [r4 :16]
	DCD	0xf4a594df ;	vld1.16	{d9[3]}, [r5 :16]
	DCD	0xf4aef08d ;	vld1.8	{d15[4]}, [lr]!
	DCD	0xf4aef0ad ;	vld1.8	{d15[5]}, [lr]!
	DCD	0xf4aef0cd ;	vld1.8	{d15[6]}, [lr]!
	DCD	0xf4aef0ed ;	vld1.8	{d15[7]}, [lr]!
	DCD	0xf426b75d ;	vld1.16	{d11}, [r6 :64]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a00000b ;	beq	f8ac <pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon+0x4a0>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a4849f ;	vld1.16	{d8[2]}, [r4 :16]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a484df ;	vld1.16	{d8[3]}, [r4 :16]
	DCD	0xf4aef04d ;	vld1.8	{d15[2]}, [lr]!
	DCD	0xf4aef06d ;	vld1.8	{d15[3]}, [lr]!
	DCD	0xf4a6a48d ;	vld1.16	{d10[2]}, [r6]!
	DCD	0xf4a6a4cd ;	vld1.16	{d10[3]}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000005 ;	beq	f8cc <pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon+0x4c0>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a4845f ;	vld1.16	{d8[1]}, [r4 :16]
	DCD	0xf4aef02d ;	vld1.8	{d15[1]}, [lr]!
	DCD	0xf4a6a44d ;	vld1.16	{d10[1]}, [r6]!
	DCD	0xf2882818 ;	vshrn.i16	d2, q4, #8
	DCD	0xf28d1818 ;	vshrn.i16	d1, q4, #3
	DCD	0xf3958558 ;	vsli.16	q4, q4, #5
	DCD	0xf38b2412 ;	vsri.8	d2, d2, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0818 ;	vshrn.i16	d0, q4, #2
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf3b0758f ;	vmvn	d7, d15
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3c70c04 ;	vmull.u8	q8, d7, d4
	DCD	0xf3c72c05 ;	vmull.u8	q9, d7, d5
	DCD	0xf3c7ac06 ;	vmull.u8	q13, d7, d6
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d8827a ;	vrshr.u16	q12, q13, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4aa ;	vraddhn.i16	d30, q12, q13
	DCD	0xf300007c ;	vqadd.u8	q0, q0, q14
	DCD	0xf302207e ;	vqadd.u8	q1, q1, q15
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	f970 <pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon+0x564>
	DCD	0xf441d75d ;	vst1.16	{d29}, [r1 :64]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	f980 <pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon+0x574>
	DCD	0xf4c1c48d ;	vst1.16	{d28[2]}, [r1]!
	DCD	0xf4c1c4cd ;	vst1.16	{d28[3]}, [r1]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	f98c <pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon+0x580>
	DCD	0xf4c1c44d ;	vst1.16	{d28[1]}, [r1]!
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd8070 ;	pop	{r4, r5, r6, pc}
	DCD	0xe3100007 ;	tst	r0, #7
	DCD	0x0a00005c ;	beq	fb10 <pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon+0x704>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000014 ;	beq	f9f8 <pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon+0x5ec>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4941f ;	vld1.16	{d9[0]}, [r4 :16]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a5945f ;	vld1.16	{d9[1]}, [r5 :16]
	DCD	0xe1a05843 ;	asr	r5, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4a4949f ;	vld1.16	{d9[2]}, [r4 :16]
	DCD	0xf4a594df ;	vld1.16	{d9[3]}, [r5 :16]
	DCD	0xf4aef08d ;	vld1.8	{d15[4]}, [lr]!
	DCD	0xf4aef0ad ;	vld1.8	{d15[5]}, [lr]!
	DCD	0xf4aef0cd ;	vld1.8	{d15[6]}, [lr]!
	DCD	0xf4aef0ed ;	vld1.8	{d15[7]}, [lr]!
	DCD	0xf426b74d ;	vld1.16	{d11}, [r6]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a00000b ;	beq	fa30 <pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon+0x624>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a4849f ;	vld1.16	{d8[2]}, [r4 :16]
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a484df ;	vld1.16	{d8[3]}, [r4 :16]
	DCD	0xf4aef04d ;	vld1.8	{d15[2]}, [lr]!
	DCD	0xf4aef06d ;	vld1.8	{d15[3]}, [lr]!
	DCD	0xf4a6a48d ;	vld1.16	{d10[2]}, [r6]!
	DCD	0xf4a6a4cd ;	vld1.16	{d10[3]}, [r6]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000005 ;	beq	fa50 <pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon+0x644>
	DCD	0xe1a04843 ;	asr	r4, r3, #16
	DCD	0xe083300c ;	add	r3, r3, ip
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a4845f ;	vld1.16	{d8[1]}, [r4 :16]
	DCD	0xf4aef02d ;	vld1.8	{d15[1]}, [lr]!
	DCD	0xf4a6a44d ;	vld1.16	{d10[1]}, [r6]!
	DCD	0xf2882818 ;	vshrn.i16	d2, q4, #8
	DCD	0xf28d1818 ;	vshrn.i16	d1, q4, #3
	DCD	0xf3958558 ;	vsli.16	q4, q4, #5
	DCD	0xf38b2412 ;	vsri.8	d2, d2, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0818 ;	vshrn.i16	d0, q4, #2
	DCD	0xf288681a ;	vshrn.i16	d6, q5, #8
	DCD	0xf28d581a ;	vshrn.i16	d5, q5, #3
	DCD	0xf395a55a ;	vsli.16	q5, q5, #5
	DCD	0xf38b6416 ;	vsri.8	d6, d6, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e481a ;	vshrn.i16	d4, q5, #2
	DCD	0xf3b0758f ;	vmvn	d7, d15
	DCD	0xf38fcc02 ;	vmull.u8	q6, d15, d2
	DCD	0xf38fac01 ;	vmull.u8	q5, d15, d1
	DCD	0xf38f8c00 ;	vmull.u8	q4, d15, d0
	DCD	0xf3c70c04 ;	vmull.u8	q8, d7, d4
	DCD	0xf3c72c05 ;	vmull.u8	q9, d7, d5
	DCD	0xf3c7ac06 ;	vmull.u8	q13, d7, d6
	DCD	0xf3d8825c ;	vrshr.u16	q12, q6, #8
	DCD	0xf3d8625a ;	vrshr.u16	q11, q5, #8
	DCD	0xf3d84258 ;	vrshr.u16	q10, q4, #8
	DCD	0xf38c2428 ;	vraddhn.i16	d2, q6, q12
	DCD	0xf38a1426 ;	vraddhn.i16	d1, q5, q11
	DCD	0xf3880424 ;	vraddhn.i16	d0, q4, q10
	DCD	0xf3d8c270 ;	vrshr.u16	q14, q8, #8
	DCD	0xf3d8e272 ;	vrshr.u16	q15, q9, #8
	DCD	0xf3d8827a ;	vrshr.u16	q12, q13, #8
	DCD	0xf3ccc4a0 ;	vraddhn.i16	d28, q14, q8
	DCD	0xf3ced4a2 ;	vraddhn.i16	d29, q15, q9
	DCD	0xf3c8e4aa ;	vraddhn.i16	d30, q12, q13
	DCD	0xf300007c ;	vqadd.u8	q0, q0, q14
	DCD	0xf302207e ;	vqadd.u8	q1, q1, q15
	DCD	0xf3f2e301 ;	vshll.i8	q15, d1, #8
	DCD	0xf3f2c302 ;	vshll.i8	q14, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf3dbc47e ;	vsri.16	q14, q15, #5
	DCD	0xf3d5c456 ;	vsri.16	q14, q3, #11
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000000 ;	beq	faf4 <pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon+0x6e8>
	DCD	0xf441d74d ;	vst1.16	{d29}, [r1]!
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000001 ;	beq	fb04 <pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon+0x6f8>
	DCD	0xf4c1c48d ;	vst1.16	{d28[2]}, [r1]!
	DCD	0xf4c1c4cd ;	vst1.16	{d28[3]}, [r1]!
	DCD	0xe3100001 ;	tst	r0, #1
	DCD	0x0a000000 ;	beq	fb10 <pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon+0x704>
	DCD	0xf4c1c44d ;	vst1.16	{d28[1]}, [r1]!
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd8070 ;	pop	{r4, r5, r6, pc}
	ENDP  ; |pixman_scaled_nearest_scanline_0565_8_0565_OVER_asm_neon|

|pixman_scaled_bilinear_scanline_8888_8888_SRC_asm_neon| PROC
	DCD	0xe1a0c00d ;	mov	ip, sp
	DCD	0xe92d03f0 ;	push	{r4, r5, r6, r7, r8, r9}
	DCD	0xe3a0701c ;	mov	r7, #28
	DCD	0xe89c1070 ;	ldm	ip, {r4, r5, r6, ip}
	DCD	0xe0070697 ;	mul	r7, r7, r6
	DCD	0xe0422001 ;	sub	r2, r2, r1
	DCD	0xe35c0000 ;	cmp	ip, #0
	DCD	0xda0000d6 ;	ble	fe94 <pixman_scaled_bilinear_scanline_8888_8888_SRC_asm_neon+0x37c>
	DCD	0xeea85bb0 ;	vdup.16	q12, r5
	DCD	0xeeaa6bb0 ;	vdup.16	q13, r6
	DCD	0xeecc3b90 ;	vdup.8	d28, r3
	DCD	0xeecd4b90 ;	vdup.8	d29, r4
	DCD	0xf25998aa ;	vadd.i16	d25, d25, d26
	DCD	0xe35c0001 ;	cmp	ip, #1
	DCD	0xba000011 ;	blt	fb9c <pixman_scaled_bilinear_scanline_8888_8888_SRC_asm_neon+0x84>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a00000f ;	beq	fb9c <pixman_scaled_bilinear_scanline_8888_8888_SRC_asm_neon+0x84>
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xf4230782 ;	vld1.32	{d0}, [r3], r2
	DCD	0xf423178f ;	vld1.32	{d1}, [r3]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf480083d ;	vst1.32	{d0[0]}, [r0 :32]!
	DCD	0xe24cc001 ;	sub	ip, ip, #1
	DCD	0xf25aa8ea ;	vadd.i16	q13, q13, q13
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xe35c0002 ;	cmp	ip, #2
	DCD	0xba00001c ;	blt	fc24 <pixman_scaled_bilinear_scanline_8888_8888_SRC_asm_neon+0x10c>
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a00001a ;	beq	fc24 <pixman_scaled_bilinear_scanline_8888_8888_SRC_asm_neon+0x10c>
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xf4230782 ;	vld1.32	{d0}, [r3], r2
	DCD	0xf423178f ;	vld1.32	{d1}, [r3]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xf4634782 ;	vld1.32	{d20}, [r3], r2
	DCD	0xf463578f ;	vld1.32	{d21}, [r3]
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3d84a36 ;	vshll.u16	d20, q11, #8
	DCD	0xf3d64aaf ;	vmlsl.u16	q10, d22, d31
	DCD	0xf3d748af ;	vmlal.u16	q10, d23, d31
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf400079d ;	vst1.32	{d0}, [r0 :64]!
	DCD	0xe24cc002 ;	sub	ip, ip, #2
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xba00006e ;	blt	fde8 <pixman_scaled_bilinear_scanline_8888_8888_SRC_asm_neon+0x2d0>
	DCD	0xe1a07747 ;	asr	r7, r7, #14
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xe1a04845 ;	asr	r4, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0814104 ;	add	r4, r1, r4, lsl #2
	DCD	0xf4636782 ;	vld1.32	{d22}, [r3], r2
	DCD	0xf463778f ;	vld1.32	{d23}, [r3]
	DCD	0xe1a08845 ;	asr	r8, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0818108 ;	add	r8, r1, r8, lsl #2
	DCD	0xf3c60cac ;	vmull.u8	q8, d22, d28
	DCD	0xf3c708ad ;	vmlal.u8	q8, d23, d29
	DCD	0xf4646782 ;	vld1.32	{d22}, [r4], r2
	DCD	0xf464778f ;	vld1.32	{d23}, [r4]
	DCD	0xe1a09845 ;	asr	r9, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0819109 ;	add	r9, r1, r9, lsl #2
	DCD	0xf3c62cac ;	vmull.u8	q9, d22, d28
	DCD	0xf3c728ad ;	vmlal.u8	q9, d23, d29
	DCD	0xf4686782 ;	vld1.32	{d22}, [r8], r2
	DCD	0xf468778f ;	vld1.32	{d23}, [r8]
	DCD	0xf3c64cac ;	vmull.u8	q10, d22, d28
	DCD	0xf3c748ad ;	vmlal.u8	q10, d23, d29
	DCD	0xf3980a30 ;	vshll.u16	d0, q8, #8
	DCD	0xf3900aae ;	vmlsl.u16	q0, d16, d30
	DCD	0xf39108ae ;	vmlal.u16	q0, d17, d30
	DCD	0xf7d9f007 ;	pld	[r9, r7]
	DCD	0xf4690782 ;	vld1.32	{d16}, [r9], r2
	DCD	0xf469178f ;	vld1.32	{d17}, [r9]
	DCD	0xf7d9f007 ;	pld	[r9, r7]
	DCD	0xf3c06cac ;	vmull.u8	q11, d16, d28
	DCD	0xf3c168ad ;	vmlal.u8	q11, d17, d29
	DCD	0xf3982a32 ;	vshll.u16	d2, q9, #8
	DCD	0xf3922aaf ;	vmlsl.u16	q1, d18, d31
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xba000036 ;	blt	fda0 <pixman_scaled_bilinear_scanline_8888_8888_SRC_asm_neon+0x288>
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xe1a04845 ;	asr	r4, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0814104 ;	add	r4, r1, r4, lsl #2
	DCD	0xf39328af ;	vmlal.u16	q1, d19, d31
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3984a34 ;	vshll.u16	d4, q10, #8
	DCD	0xf3944aae ;	vmlsl.u16	q2, d20, d30
	DCD	0xf39548ae ;	vmlal.u16	q2, d21, d30
	DCD	0xf3986a36 ;	vshll.u16	d6, q11, #8
	DCD	0xf4634782 ;	vld1.32	{d20}, [r3], r2
	DCD	0xf3966aaf ;	vmlsl.u16	q3, d22, d31
	DCD	0xf39768af ;	vmlal.u16	q3, d23, d31
	DCD	0xf463578f ;	vld1.32	{d21}, [r3]
	DCD	0xf3c40cac ;	vmull.u8	q8, d20, d28
	DCD	0xf3c508ad ;	vmlal.u8	q8, d21, d29
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901812 ;	vshrn.i32	d1, q1, #16
	DCD	0xf2904814 ;	vshrn.i32	d4, q2, #16
	DCD	0xf4646782 ;	vld1.32	{d22}, [r4], r2
	DCD	0xf2905816 ;	vshrn.i32	d5, q3, #16
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf464778f ;	vld1.32	{d23}, [r4]
	DCD	0xf3c62cac ;	vmull.u8	q9, d22, d28
	DCD	0xe1a08845 ;	asr	r8, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0818108 ;	add	r8, r1, r8, lsl #2
	DCD	0xe1a09845 ;	asr	r9, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0819109 ;	add	r9, r1, r9, lsl #2
	DCD	0xf3c728ad ;	vmlal.u8	q9, d23, d29
	DCD	0xf4686782 ;	vld1.32	{d22}, [r8], r2
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf468778f ;	vld1.32	{d23}, [r8]
	DCD	0xf3c64cac ;	vmull.u8	q10, d22, d28
	DCD	0xf3c748ad ;	vmlal.u8	q10, d23, d29
	DCD	0xf3b26200 ;	vmovn.i16	d6, q0
	DCD	0xf3980a30 ;	vshll.u16	d0, q8, #8
	DCD	0xf3b27204 ;	vmovn.i16	d7, q2
	DCD	0xf3900aae ;	vmlsl.u16	q0, d16, d30
	DCD	0xf39108ae ;	vmlal.u16	q0, d17, d30
	DCD	0xf7d9f007 ;	pld	[r9, r7]
	DCD	0xf4690782 ;	vld1.32	{d16}, [r9], r2
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf469178f ;	vld1.32	{d17}, [r9]
	DCD	0xf7d9f007 ;	pld	[r9, r7]
	DCD	0xf3c06cac ;	vmull.u8	q11, d16, d28
	DCD	0xf3c168ad ;	vmlal.u8	q11, d17, d29
	DCD	0xf4006aad ;	vst1.32	{d6-d7}, [r0 :128]!
	DCD	0xf3982a32 ;	vshll.u16	d2, q9, #8
	DCD	0xf3922aaf ;	vmlsl.u16	q1, d18, d31
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xaaffffc8 ;	bge	fcc4 <pixman_scaled_bilinear_scanline_8888_8888_SRC_asm_neon+0x1ac>
	DCD	0xf39328af ;	vmlal.u16	q1, d19, d31
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3984a34 ;	vshll.u16	d4, q10, #8
	DCD	0xf3944aae ;	vmlsl.u16	q2, d20, d30
	DCD	0xf39548ae ;	vmlal.u16	q2, d21, d30
	DCD	0xf3986a36 ;	vshll.u16	d6, q11, #8
	DCD	0xf3966aaf ;	vmlsl.u16	q3, d22, d31
	DCD	0xf39768af ;	vmlal.u16	q3, d23, d31
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901812 ;	vshrn.i32	d1, q1, #16
	DCD	0xf2904814 ;	vshrn.i32	d4, q2, #16
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf2905816 ;	vshrn.i32	d5, q3, #16
	DCD	0xf3b26200 ;	vmovn.i16	d6, q0
	DCD	0xf3b27204 ;	vmovn.i16	d7, q2
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf4006aad ;	vst1.32	{d6-d7}, [r0 :128]!
	DCD	0xe31c0002 ;	tst	ip, #2
	DCD	0x0a000019 ;	beq	fe58 <pixman_scaled_bilinear_scanline_8888_8888_SRC_asm_neon+0x340>
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xf4230782 ;	vld1.32	{d0}, [r3], r2
	DCD	0xf423178f ;	vld1.32	{d1}, [r3]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xf4634782 ;	vld1.32	{d20}, [r3], r2
	DCD	0xf463578f ;	vld1.32	{d21}, [r3]
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3d84a36 ;	vshll.u16	d20, q11, #8
	DCD	0xf3d64aaf ;	vmlsl.u16	q10, d22, d31
	DCD	0xf3d748af ;	vmlal.u16	q10, d23, d31
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf400079d ;	vst1.32	{d0}, [r0 :64]!
	DCD	0xe31c0001 ;	tst	ip, #1
	DCD	0x0a00000c ;	beq	fe94 <pixman_scaled_bilinear_scanline_8888_8888_SRC_asm_neon+0x37c>
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xf4230782 ;	vld1.32	{d0}, [r3], r2
	DCD	0xf423178f ;	vld1.32	{d1}, [r3]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf480083d ;	vst1.32	{d0[0]}, [r0 :32]!
	DCD	0xe8bd03f0 ;	pop	{r4, r5, r6, r7, r8, r9}
	DCD	0xe12fff1e ;	bx	lr
	;		fe98: R_ARM_V4BX	*ABS*
	ENDP  ; |pixman_scaled_bilinear_scanline_8888_8888_SRC_asm_neon|

|pixman_scaled_bilinear_scanline_8888_0565_SRC_asm_neon| PROC
	DCD	0xe1a0c00d ;	mov	ip, sp
	DCD	0xe92d03f0 ;	push	{r4, r5, r6, r7, r8, r9}
	DCD	0xe3a0701c ;	mov	r7, #28
	DCD	0xe89c1070 ;	ldm	ip, {r4, r5, r6, ip}
	DCD	0xe0070697 ;	mul	r7, r7, r6
	DCD	0xed2d8b10 ;	vpush	{d8-d15}
	DCD	0xe0422001 ;	sub	r2, r2, r1
	DCD	0xe35c0000 ;	cmp	ip, #0
	DCD	0xda0001f9 ;	ble	106a8 <pixman_scaled_bilinear_scanline_8888_0565_SRC_asm_neon+0x80c>
	DCD	0xeea85bb0 ;	vdup.16	q12, r5
	DCD	0xeeaa6bb0 ;	vdup.16	q13, r6
	DCD	0xeecc3b90 ;	vdup.8	d28, r3
	DCD	0xeecd4b90 ;	vdup.8	d29, r4
	DCD	0xf25998aa ;	vadd.i16	d25, d25, d26
	DCD	0xe35c0001 ;	cmp	ip, #1
	DCD	0xba00001a ;	blt	ff48 <pixman_scaled_bilinear_scanline_8888_0565_SRC_asm_neon+0xac>
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000018 ;	beq	ff48 <pixman_scaled_bilinear_scanline_8888_0565_SRC_asm_neon+0xac>
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xf4230782 ;	vld1.32	{d0}, [r3], r2
	DCD	0xf423178f ;	vld1.32	{d1}, [r3]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24301 ;	vshll.i8	q2, d1, #8
	DCD	0xf3b22302 ;	vshll.i8	q1, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf39b2454 ;	vsri.16	q1, q2, #5
	DCD	0xf3952456 ;	vsri.16	q1, q3, #11
	DCD	0xf480241d ;	vst1.16	{d2[0]}, [r0 :16]!
	DCD	0xe24cc001 ;	sub	ip, ip, #1
	DCD	0xf25aa8ea ;	vadd.i16	q13, q13, q13
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xe35c0002 ;	cmp	ip, #2
	DCD	0xba000025 ;	blt	fff4 <pixman_scaled_bilinear_scanline_8888_0565_SRC_asm_neon+0x158>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000023 ;	beq	fff4 <pixman_scaled_bilinear_scanline_8888_0565_SRC_asm_neon+0x158>
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xf4230782 ;	vld1.32	{d0}, [r3], r2
	DCD	0xf423178f ;	vld1.32	{d1}, [r3]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xf4634782 ;	vld1.32	{d20}, [r3], r2
	DCD	0xf463578f ;	vld1.32	{d21}, [r3]
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3d84a36 ;	vshll.u16	d20, q11, #8
	DCD	0xf3d64aaf ;	vmlsl.u16	q10, d22, d31
	DCD	0xf3d748af ;	vmlal.u16	q10, d23, d31
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24301 ;	vshll.i8	q2, d1, #8
	DCD	0xf3b22302 ;	vshll.i8	q1, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf39b2454 ;	vsri.16	q1, q2, #5
	DCD	0xf3952456 ;	vsri.16	q1, q3, #11
	DCD	0xf480283d ;	vst1.32	{d2[0]}, [r0 :32]!
	DCD	0xe24cc002 ;	sub	ip, ip, #2
	DCD	0xe35c0004 ;	cmp	ip, #4
	DCD	0xba000041 ;	blt	10104 <pixman_scaled_bilinear_scanline_8888_0565_SRC_asm_neon+0x268>
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a00003f ;	beq	10104 <pixman_scaled_bilinear_scanline_8888_0565_SRC_asm_neon+0x268>
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xf4230782 ;	vld1.32	{d0}, [r3], r2
	DCD	0xf423178f ;	vld1.32	{d1}, [r3]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xf4634782 ;	vld1.32	{d20}, [r3], r2
	DCD	0xf463578f ;	vld1.32	{d21}, [r3]
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xf4234782 ;	vld1.32	{d4}, [r3], r2
	DCD	0xf423578f ;	vld1.32	{d5}, [r3]
	DCD	0xf3846c2c ;	vmull.u8	q3, d4, d28
	DCD	0xf385682d ;	vmlal.u8	q3, d5, d29
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xf4630782 ;	vld1.32	{d16}, [r3], r2
	DCD	0xf463178f ;	vld1.32	{d17}, [r3]
	DCD	0xf3c02cac ;	vmull.u8	q9, d16, d28
	DCD	0xf3c128ad ;	vmlal.u8	q9, d17, d29
	DCD	0xf7d3f007 ;	pld	[r3, r7]
	DCD	0xe0433002 ;	sub	r3, r3, r2
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3d84a36 ;	vshll.u16	d20, q11, #8
	DCD	0xf3d64aaf ;	vmlsl.u16	q10, d22, d31
	DCD	0xf3d748af ;	vmlal.u16	q10, d23, d31
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3984a16 ;	vshll.u16	d4, q3, #8
	DCD	0xf3964a2e ;	vmlsl.u16	q2, d6, d30
	DCD	0xf397482e ;	vmlal.u16	q2, d7, d30
	DCD	0xf3d80a32 ;	vshll.u16	d16, q9, #8
	DCD	0xf7d4f007 ;	pld	[r4, r7]
	DCD	0xf3d20aaf ;	vmlsl.u16	q8, d18, d31
	DCD	0xf3d308af ;	vmlal.u16	q8, d19, d31
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf2904814 ;	vshrn.i32	d4, q2, #16
	DCD	0xf2905830 ;	vshrn.i32	d5, q8, #16
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b21204 ;	vmovn.i16	d1, q2
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24301 ;	vshll.i8	q2, d1, #8
	DCD	0xf3b22302 ;	vshll.i8	q1, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf39b2454 ;	vsri.16	q1, q2, #5
	DCD	0xf3952456 ;	vsri.16	q1, q3, #11
	DCD	0xf400275d ;	vst1.16	{d2}, [r0 :64]!
	DCD	0xe24cc004 ;	sub	ip, ip, #4
	DCD	0xe25cc008 ;	subs	ip, ip, #8
	DCD	0xba0000e8 ;	blt	104b0 <pixman_scaled_bilinear_scanline_8888_0565_SRC_asm_neon+0x614>
	DCD	0xe1a07747 ;	asr	r7, r7, #14
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xe1a04845 ;	asr	r4, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0814104 ;	add	r4, r1, r4, lsl #2
	DCD	0xf4634782 ;	vld1.32	{d20}, [r3], r2
	DCD	0xf463578f ;	vld1.32	{d21}, [r3]
	DCD	0xf3c40cac ;	vmull.u8	q8, d20, d28
	DCD	0xf3c508ad ;	vmlal.u8	q8, d21, d29
	DCD	0xf4646782 ;	vld1.32	{d22}, [r4], r2
	DCD	0xf464778f ;	vld1.32	{d23}, [r4]
	DCD	0xf3c62cac ;	vmull.u8	q9, d22, d28
	DCD	0xe1a08845 ;	asr	r8, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0818108 ;	add	r8, r1, r8, lsl #2
	DCD	0xe1a09845 ;	asr	r9, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0819109 ;	add	r9, r1, r9, lsl #2
	DCD	0xf3c728ad ;	vmlal.u8	q9, d23, d29
	DCD	0xf4686782 ;	vld1.32	{d22}, [r8], r2
	DCD	0xf468778f ;	vld1.32	{d23}, [r8]
	DCD	0xf3c64cac ;	vmull.u8	q10, d22, d28
	DCD	0xf3c748ad ;	vmlal.u8	q10, d23, d29
	DCD	0xf3980a30 ;	vshll.u16	d0, q8, #8
	DCD	0xf3900aae ;	vmlsl.u16	q0, d16, d30
	DCD	0xf39108ae ;	vmlal.u16	q0, d17, d30
	DCD	0xf7d9f007 ;	pld	[r9, r7]
	DCD	0xf4690782 ;	vld1.32	{d16}, [r9], r2
	DCD	0xf469178f ;	vld1.32	{d17}, [r9]
	DCD	0xf7d9f007 ;	pld	[r9, r7]
	DCD	0xf3c06cac ;	vmull.u8	q11, d16, d28
	DCD	0xf3c168ad ;	vmlal.u8	q11, d17, d29
	DCD	0xf3982a32 ;	vshll.u16	d2, q9, #8
	DCD	0xf3922aaf ;	vmlsl.u16	q1, d18, d31
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xe1a04845 ;	asr	r4, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0814104 ;	add	r4, r1, r4, lsl #2
	DCD	0xf39328af ;	vmlal.u16	q1, d19, d31
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3984a34 ;	vshll.u16	d4, q10, #8
	DCD	0xf3944aae ;	vmlsl.u16	q2, d20, d30
	DCD	0xf39548ae ;	vmlal.u16	q2, d21, d30
	DCD	0xf3986a36 ;	vshll.u16	d6, q11, #8
	DCD	0xf4634782 ;	vld1.32	{d20}, [r3], r2
	DCD	0xf3966aaf ;	vmlsl.u16	q3, d22, d31
	DCD	0xf39768af ;	vmlal.u16	q3, d23, d31
	DCD	0xf463578f ;	vld1.32	{d21}, [r3]
	DCD	0xf3c40cac ;	vmull.u8	q8, d20, d28
	DCD	0xf3c508ad ;	vmlal.u8	q8, d21, d29
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901812 ;	vshrn.i32	d1, q1, #16
	DCD	0xf2904814 ;	vshrn.i32	d4, q2, #16
	DCD	0xf4646782 ;	vld1.32	{d22}, [r4], r2
	DCD	0xf2905816 ;	vshrn.i32	d5, q3, #16
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf464778f ;	vld1.32	{d23}, [r4]
	DCD	0xf3c62cac ;	vmull.u8	q9, d22, d28
	DCD	0xe1a08845 ;	asr	r8, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0818108 ;	add	r8, r1, r8, lsl #2
	DCD	0xe1a09845 ;	asr	r9, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0819109 ;	add	r9, r1, r9, lsl #2
	DCD	0xf3c728ad ;	vmlal.u8	q9, d23, d29
	DCD	0xf4686782 ;	vld1.32	{d22}, [r8], r2
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf468778f ;	vld1.32	{d23}, [r8]
	DCD	0xf3c64cac ;	vmull.u8	q10, d22, d28
	DCD	0xf3c748ad ;	vmlal.u8	q10, d23, d29
	DCD	0xf3b28200 ;	vmovn.i16	d8, q0
	DCD	0xf3980a30 ;	vshll.u16	d0, q8, #8
	DCD	0xf3b29204 ;	vmovn.i16	d9, q2
	DCD	0xf3900aae ;	vmlsl.u16	q0, d16, d30
	DCD	0xf39108ae ;	vmlal.u16	q0, d17, d30
	DCD	0xf7d9f007 ;	pld	[r9, r7]
	DCD	0xf4690782 ;	vld1.32	{d16}, [r9], r2
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf469178f ;	vld1.32	{d17}, [r9]
	DCD	0xf7d9f007 ;	pld	[r9, r7]
	DCD	0xf3c06cac ;	vmull.u8	q11, d16, d28
	DCD	0xf3c168ad ;	vmlal.u8	q11, d17, d29
	DCD	0xf3982a32 ;	vshll.u16	d2, q9, #8
	DCD	0xf3922aaf ;	vmlsl.u16	q1, d18, d31
	DCD	0xe25cc008 ;	subs	ip, ip, #8
	DCD	0xba000073 ;	blt	10444 <pixman_scaled_bilinear_scanline_8888_0565_SRC_asm_neon+0x5a8>
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xe1a04845 ;	asr	r4, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0814104 ;	add	r4, r1, r4, lsl #2
	DCD	0xf39328af ;	vmlal.u16	q1, d19, d31
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3b28109 ;	vuzp.8	d8, d9
	DCD	0xf3984a34 ;	vshll.u16	d4, q10, #8
	DCD	0xf3944aae ;	vmlsl.u16	q2, d20, d30
	DCD	0xf39548ae ;	vmlal.u16	q2, d21, d30
	DCD	0xf3986a36 ;	vshll.u16	d6, q11, #8
	DCD	0xf4634782 ;	vld1.32	{d20}, [r3], r2
	DCD	0xf3966aaf ;	vmlsl.u16	q3, d22, d31
	DCD	0xf39768af ;	vmlal.u16	q3, d23, d31
	DCD	0xf463578f ;	vld1.32	{d21}, [r3]
	DCD	0xf3c40cac ;	vmull.u8	q8, d20, d28
	DCD	0xf3c508ad ;	vmlal.u8	q8, d21, d29
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901812 ;	vshrn.i32	d1, q1, #16
	DCD	0xf2904814 ;	vshrn.i32	d4, q2, #16
	DCD	0xf4646782 ;	vld1.32	{d22}, [r4], r2
	DCD	0xf2905816 ;	vshrn.i32	d5, q3, #16
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf464778f ;	vld1.32	{d23}, [r4]
	DCD	0xf3c62cac ;	vmull.u8	q9, d22, d28
	DCD	0xe1a08845 ;	asr	r8, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0818108 ;	add	r8, r1, r8, lsl #2
	DCD	0xe1a09845 ;	asr	r9, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0819109 ;	add	r9, r1, r9, lsl #2
	DCD	0xf3c728ad ;	vmlal.u8	q9, d23, d29
	DCD	0xf4686782 ;	vld1.32	{d22}, [r8], r2
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf468778f ;	vld1.32	{d23}, [r8]
	DCD	0xf3c64cac ;	vmull.u8	q10, d22, d28
	DCD	0xf3c748ad ;	vmlal.u8	q10, d23, d29
	DCD	0xf3b2a200 ;	vmovn.i16	d10, q0
	DCD	0xf3980a30 ;	vshll.u16	d0, q8, #8
	DCD	0xf3b2b204 ;	vmovn.i16	d11, q2
	DCD	0xf3900aae ;	vmlsl.u16	q0, d16, d30
	DCD	0xf39108ae ;	vmlal.u16	q0, d17, d30
	DCD	0xf7d9f007 ;	pld	[r9, r7]
	DCD	0xf4690782 ;	vld1.32	{d16}, [r9], r2
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf469178f ;	vld1.32	{d17}, [r9]
	DCD	0xf7d9f007 ;	pld	[r9, r7]
	DCD	0xf3c06cac ;	vmull.u8	q11, d16, d28
	DCD	0xf3c168ad ;	vmlal.u8	q11, d17, d29
	DCD	0xf3b2a10b ;	vuzp.8	d10, d11
	DCD	0xf3982a32 ;	vshll.u16	d2, q9, #8
	DCD	0xf3922aaf ;	vmlsl.u16	q1, d18, d31
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xe1a04845 ;	asr	r4, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0814104 ;	add	r4, r1, r4, lsl #2
	DCD	0xf39328af ;	vmlal.u16	q1, d19, d31
	DCD	0xf3b2910b ;	vuzp.8	d9, d11
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3984a34 ;	vshll.u16	d4, q10, #8
	DCD	0xf3b2810a ;	vuzp.8	d8, d10
	DCD	0xf3944aae ;	vmlsl.u16	q2, d20, d30
	DCD	0xf39548ae ;	vmlal.u16	q2, d21, d30
	DCD	0xf3986a36 ;	vshll.u16	d6, q11, #8
	DCD	0xf4634782 ;	vld1.32	{d20}, [r3], r2
	DCD	0xf3966aaf ;	vmlsl.u16	q3, d22, d31
	DCD	0xf39768af ;	vmlal.u16	q3, d23, d31
	DCD	0xf463578f ;	vld1.32	{d21}, [r3]
	DCD	0xf3c40cac ;	vmull.u8	q8, d20, d28
	DCD	0xf3c508ad ;	vmlal.u8	q8, d21, d29
	DCD	0xf3b2c309 ;	vshll.i8	q6, d9, #8
	DCD	0xf3b2a30a ;	vshll.i8	q5, d10, #8
	DCD	0xf3b2e308 ;	vshll.i8	q7, d8, #8
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf39ba45c ;	vsri.16	q5, q6, #5
	DCD	0xf2901812 ;	vshrn.i32	d1, q1, #16
	DCD	0xf395a45e ;	vsri.16	q5, q7, #11
	DCD	0xf2904814 ;	vshrn.i32	d4, q2, #16
	DCD	0xf4646782 ;	vld1.32	{d22}, [r4], r2
	DCD	0xf2905816 ;	vshrn.i32	d5, q3, #16
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf464778f ;	vld1.32	{d23}, [r4]
	DCD	0xf3c62cac ;	vmull.u8	q9, d22, d28
	DCD	0xe1a08845 ;	asr	r8, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0818108 ;	add	r8, r1, r8, lsl #2
	DCD	0xe1a09845 ;	asr	r9, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0819109 ;	add	r9, r1, r9, lsl #2
	DCD	0xf3c728ad ;	vmlal.u8	q9, d23, d29
	DCD	0xf4686782 ;	vld1.32	{d22}, [r8], r2
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf468778f ;	vld1.32	{d23}, [r8]
	DCD	0xf3c64cac ;	vmull.u8	q10, d22, d28
	DCD	0xf3c748ad ;	vmlal.u8	q10, d23, d29
	DCD	0xf3b28200 ;	vmovn.i16	d8, q0
	DCD	0xf3980a30 ;	vshll.u16	d0, q8, #8
	DCD	0xf3b29204 ;	vmovn.i16	d9, q2
	DCD	0xf3900aae ;	vmlsl.u16	q0, d16, d30
	DCD	0xf39108ae ;	vmlal.u16	q0, d17, d30
	DCD	0xf7d9f007 ;	pld	[r9, r7]
	DCD	0xf4690782 ;	vld1.32	{d16}, [r9], r2
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf469178f ;	vld1.32	{d17}, [r9]
	DCD	0xf7d9f007 ;	pld	[r9, r7]
	DCD	0xf3c06cac ;	vmull.u8	q11, d16, d28
	DCD	0xf3c168ad ;	vmlal.u8	q11, d17, d29
	DCD	0xf3982a32 ;	vshll.u16	d2, q9, #8
	DCD	0xf400aaad ;	vst1.32	{d10-d11}, [r0 :128]!
	DCD	0xf3922aaf ;	vmlsl.u16	q1, d18, d31
	DCD	0xe25cc008 ;	subs	ip, ip, #8
	DCD	0xaaffff8b ;	bge	10274 <pixman_scaled_bilinear_scanline_8888_0565_SRC_asm_neon+0x3d8>
	DCD	0xf39328af ;	vmlal.u16	q1, d19, d31
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3984a34 ;	vshll.u16	d4, q10, #8
	DCD	0xf3944aae ;	vmlsl.u16	q2, d20, d30
	DCD	0xf39548ae ;	vmlal.u16	q2, d21, d30
	DCD	0xf3986a36 ;	vshll.u16	d6, q11, #8
	DCD	0xf3966aaf ;	vmlsl.u16	q3, d22, d31
	DCD	0xf39768af ;	vmlal.u16	q3, d23, d31
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901812 ;	vshrn.i32	d1, q1, #16
	DCD	0xf2904814 ;	vshrn.i32	d4, q2, #16
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf2905816 ;	vshrn.i32	d5, q3, #16
	DCD	0xf3b2a200 ;	vmovn.i16	d10, q0
	DCD	0xf3b2b204 ;	vmovn.i16	d11, q2
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b28109 ;	vuzp.8	d8, d9
	DCD	0xf3b2a10b ;	vuzp.8	d10, d11
	DCD	0xf3b2910b ;	vuzp.8	d9, d11
	DCD	0xf3b2810a ;	vuzp.8	d8, d10
	DCD	0xf3b2c309 ;	vshll.i8	q6, d9, #8
	DCD	0xf3b2a30a ;	vshll.i8	q5, d10, #8
	DCD	0xf3b2e308 ;	vshll.i8	q7, d8, #8
	DCD	0xf39ba45c ;	vsri.16	q5, q6, #5
	DCD	0xf395a45e ;	vsri.16	q5, q7, #11
	DCD	0xf400aaad ;	vst1.32	{d10-d11}, [r0 :128]!
	DCD	0xe31c0004 ;	tst	ip, #4
	DCD	0x0a00003e ;	beq	105b4 <pixman_scaled_bilinear_scanline_8888_0565_SRC_asm_neon+0x718>
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xf4230782 ;	vld1.32	{d0}, [r3], r2
	DCD	0xf423178f ;	vld1.32	{d1}, [r3]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xf4634782 ;	vld1.32	{d20}, [r3], r2
	DCD	0xf463578f ;	vld1.32	{d21}, [r3]
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xf4234782 ;	vld1.32	{d4}, [r3], r2
	DCD	0xf423578f ;	vld1.32	{d5}, [r3]
	DCD	0xf3846c2c ;	vmull.u8	q3, d4, d28
	DCD	0xf385682d ;	vmlal.u8	q3, d5, d29
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xf4630782 ;	vld1.32	{d16}, [r3], r2
	DCD	0xf463178f ;	vld1.32	{d17}, [r3]
	DCD	0xf3c02cac ;	vmull.u8	q9, d16, d28
	DCD	0xf3c128ad ;	vmlal.u8	q9, d17, d29
	DCD	0xf7d3f007 ;	pld	[r3, r7]
	DCD	0xe0433002 ;	sub	r3, r3, r2
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3d84a36 ;	vshll.u16	d20, q11, #8
	DCD	0xf3d64aaf ;	vmlsl.u16	q10, d22, d31
	DCD	0xf3d748af ;	vmlal.u16	q10, d23, d31
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3984a16 ;	vshll.u16	d4, q3, #8
	DCD	0xf3964a2e ;	vmlsl.u16	q2, d6, d30
	DCD	0xf397482e ;	vmlal.u16	q2, d7, d30
	DCD	0xf3d80a32 ;	vshll.u16	d16, q9, #8
	DCD	0xf7d4f007 ;	pld	[r4, r7]
	DCD	0xf3d20aaf ;	vmlsl.u16	q8, d18, d31
	DCD	0xf3d308af ;	vmlal.u16	q8, d19, d31
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf2904814 ;	vshrn.i32	d4, q2, #16
	DCD	0xf2905830 ;	vshrn.i32	d5, q8, #16
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b21204 ;	vmovn.i16	d1, q2
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24301 ;	vshll.i8	q2, d1, #8
	DCD	0xf3b22302 ;	vshll.i8	q1, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf39b2454 ;	vsri.16	q1, q2, #5
	DCD	0xf3952456 ;	vsri.16	q1, q3, #11
	DCD	0xf400275d ;	vst1.16	{d2}, [r0 :64]!
	DCD	0xe31c0002 ;	tst	ip, #2
	DCD	0x0a000022 ;	beq	10648 <pixman_scaled_bilinear_scanline_8888_0565_SRC_asm_neon+0x7ac>
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xf4230782 ;	vld1.32	{d0}, [r3], r2
	DCD	0xf423178f ;	vld1.32	{d1}, [r3]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xf4634782 ;	vld1.32	{d20}, [r3], r2
	DCD	0xf463578f ;	vld1.32	{d21}, [r3]
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3d84a36 ;	vshll.u16	d20, q11, #8
	DCD	0xf3d64aaf ;	vmlsl.u16	q10, d22, d31
	DCD	0xf3d748af ;	vmlal.u16	q10, d23, d31
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24301 ;	vshll.i8	q2, d1, #8
	DCD	0xf3b22302 ;	vshll.i8	q1, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf39b2454 ;	vsri.16	q1, q2, #5
	DCD	0xf3952456 ;	vsri.16	q1, q3, #11
	DCD	0xf480283d ;	vst1.32	{d2[0]}, [r0 :32]!
	DCD	0xe31c0001 ;	tst	ip, #1
	DCD	0x0a000015 ;	beq	106a8 <pixman_scaled_bilinear_scanline_8888_0565_SRC_asm_neon+0x80c>
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xf4230782 ;	vld1.32	{d0}, [r3], r2
	DCD	0xf423178f ;	vld1.32	{d1}, [r3]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24301 ;	vshll.i8	q2, d1, #8
	DCD	0xf3b22302 ;	vshll.i8	q1, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf39b2454 ;	vsri.16	q1, q2, #5
	DCD	0xf3952456 ;	vsri.16	q1, q3, #11
	DCD	0xf480241d ;	vst1.16	{d2[0]}, [r0 :16]!
	DCD	0xecbd8b10 ;	vpop	{d8-d15}
	DCD	0xe8bd03f0 ;	pop	{r4, r5, r6, r7, r8, r9}
	DCD	0xe12fff1e ;	bx	lr
	;		106b0: R_ARM_V4BX	*ABS*
	ENDP  ; |pixman_scaled_bilinear_scanline_8888_0565_SRC_asm_neon|

|pixman_scaled_bilinear_scanline_0565_x888_SRC_asm_neon| PROC
	DCD	0xe1a0c00d ;	mov	ip, sp
	DCD	0xe92d03f0 ;	push	{r4, r5, r6, r7, r8, r9}
	DCD	0xe3a0701c ;	mov	r7, #28
	DCD	0xe89c1070 ;	ldm	ip, {r4, r5, r6, ip}
	DCD	0xe0070697 ;	mul	r7, r7, r6
	DCD	0xe0422001 ;	sub	r2, r2, r1
	DCD	0xe35c0000 ;	cmp	ip, #0
	DCD	0xda000124 ;	ble	10b68 <pixman_scaled_bilinear_scanline_0565_x888_SRC_asm_neon+0x4b4>
	DCD	0xeea85bb0 ;	vdup.16	q12, r5
	DCD	0xeeaa6bb0 ;	vdup.16	q13, r6
	DCD	0xeecc3b90 ;	vdup.8	d28, r3
	DCD	0xeecd4b90 ;	vdup.8	d29, r4
	DCD	0xf25998aa ;	vadd.i16	d25, d25, d26
	DCD	0xe35c0001 ;	cmp	ip, #1
	DCD	0xba000019 ;	blt	10758 <pixman_scaled_bilinear_scanline_0565_x888_SRC_asm_neon+0xa4>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000017 ;	beq	10758 <pixman_scaled_bilinear_scanline_0565_x888_SRC_asm_neon+0xa4>
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813083 ;	add	r3, r1, r3, lsl #1
	DCD	0xf4a31802 ;	vld1.32	{d1[0]}, [r3], r2
	DCD	0xf4a3188f ;	vld1.32	{d1[1]}, [r3]
	DCD	0xf2950511 ;	vshl.s16	d0, d1, #5
	DCD	0xf29b2511 ;	vshl.s16	d2, d1, #11
	DCD	0xf39b1411 ;	vsri.16	d1, d1, #5
	DCD	0xf39a0410 ;	vsri.16	d0, d0, #6
	DCD	0xf39b2412 ;	vsri.16	d2, d2, #5
	DCD	0xf3981011 ;	vshr.u16	d1, d1, #8
	DCD	0xf3980412 ;	vsri.16	d0, d2, #8
	DCD	0xf3b60181 ;	vzip.16	d0, d1
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf480083d ;	vst1.32	{d0[0]}, [r0 :32]!
	DCD	0xe24cc001 ;	sub	ip, ip, #1
	DCD	0xf25aa8ea ;	vadd.i16	q13, q13, q13
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xe35c0002 ;	cmp	ip, #2
	DCD	0xba000026 ;	blt	10808 <pixman_scaled_bilinear_scanline_0565_x888_SRC_asm_neon+0x154>
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000024 ;	beq	10808 <pixman_scaled_bilinear_scanline_0565_x888_SRC_asm_neon+0x154>
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813083 ;	add	r3, r1, r3, lsl #1
	DCD	0xe1a04845 ;	asr	r4, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0814084 ;	add	r4, r1, r4, lsl #1
	DCD	0xf4e36802 ;	vld1.32	{d22[0]}, [r3], r2
	DCD	0xf4e47802 ;	vld1.32	{d23[0]}, [r4], r2
	DCD	0xf4e3688f ;	vld1.32	{d22[1]}, [r3]
	DCD	0xf4e4788f ;	vld1.32	{d23[1]}, [r4]
	DCD	0xf2c84836 ;	vshrn.i16	d20, q11, #8
	DCD	0xf28d1836 ;	vshrn.i16	d1, q11, #3
	DCD	0xf3d56576 ;	vsli.16	q11, q11, #5
	DCD	0xf3cb4434 ;	vsri.8	d20, d20, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0836 ;	vshrn.i16	d0, q11, #2
	DCD	0xf3b201a4 ;	vzip.8	d0, d20
	DCD	0xf3b211a5 ;	vzip.8	d1, d21
	DCD	0xf3f241a5 ;	vzip.8	d20, d21
	DCD	0xf3b20181 ;	vzip.8	d0, d1
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3d84a36 ;	vshll.u16	d20, q11, #8
	DCD	0xf3d64aaf ;	vmlsl.u16	q10, d22, d31
	DCD	0xf3d748af ;	vmlal.u16	q10, d23, d31
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf400079d ;	vst1.32	{d0}, [r0 :64]!
	DCD	0xe24cc002 ;	sub	ip, ip, #2
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xba000098 ;	blt	10a74 <pixman_scaled_bilinear_scanline_0565_x888_SRC_asm_neon+0x3c0>
	DCD	0xe1a077c7 ;	asr	r7, r7, #15
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813083 ;	add	r3, r1, r3, lsl #1
	DCD	0xe1a04845 ;	asr	r4, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0814084 ;	add	r4, r1, r4, lsl #1
	DCD	0xf4e36802 ;	vld1.32	{d22[0]}, [r3], r2
	DCD	0xf4e47802 ;	vld1.32	{d23[0]}, [r4], r2
	DCD	0xf4e3688f ;	vld1.32	{d22[1]}, [r3]
	DCD	0xf4e4788f ;	vld1.32	{d23[1]}, [r4]
	DCD	0xf2c84836 ;	vshrn.i16	d20, q11, #8
	DCD	0xf28d1836 ;	vshrn.i16	d1, q11, #3
	DCD	0xf3d56576 ;	vsli.16	q11, q11, #5
	DCD	0xf3cb4434 ;	vsri.8	d20, d20, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0836 ;	vshrn.i16	d0, q11, #2
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813083 ;	add	r3, r1, r3, lsl #1
	DCD	0xe1a04845 ;	asr	r4, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0814084 ;	add	r4, r1, r4, lsl #1
	DCD	0xf4e32802 ;	vld1.32	{d18[0]}, [r3], r2
	DCD	0xf3b201a4 ;	vzip.8	d0, d20
	DCD	0xf4e43802 ;	vld1.32	{d19[0]}, [r4], r2
	DCD	0xf3b211a5 ;	vzip.8	d1, d21
	DCD	0xf4e3288f ;	vld1.32	{d18[1]}, [r3]
	DCD	0xf3f241a5 ;	vzip.8	d20, d21
	DCD	0xf4e4388f ;	vld1.32	{d19[1]}, [r4]
	DCD	0xf3b20181 ;	vzip.8	d0, d1
	DCD	0xf2c80832 ;	vshrn.i16	d16, q9, #8
	DCD	0xf28d5832 ;	vshrn.i16	d5, q9, #3
	DCD	0xf3d52572 ;	vsli.16	q9, q9, #5
	DCD	0xf3cb0430 ;	vsri.8	d16, d16, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e4832 ;	vshrn.i16	d4, q9, #2
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf3b241a0 ;	vzip.8	d4, d16
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3b251a1 ;	vzip.8	d5, d17
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3f201a1 ;	vzip.8	d16, d17
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xf3b24185 ;	vzip.8	d4, d5
	DCD	0xf3846c2c ;	vmull.u8	q3, d4, d28
	DCD	0xf385682d ;	vmlal.u8	q3, d5, d29
	DCD	0xf3c02cac ;	vmull.u8	q9, d16, d28
	DCD	0xf3c128ad ;	vmlal.u8	q9, d17, d29
	DCD	0xf7d3f007 ;	pld	[r3, r7]
	DCD	0xe0433002 ;	sub	r3, r3, r2
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3d84a36 ;	vshll.u16	d20, q11, #8
	DCD	0xf3d64aaf ;	vmlsl.u16	q10, d22, d31
	DCD	0xf3d748af ;	vmlal.u16	q10, d23, d31
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3984a16 ;	vshll.u16	d4, q3, #8
	DCD	0xf3964a2e ;	vmlsl.u16	q2, d6, d30
	DCD	0xf397482e ;	vmlal.u16	q2, d7, d30
	DCD	0xf3d80a32 ;	vshll.u16	d16, q9, #8
	DCD	0xf7d4f007 ;	pld	[r4, r7]
	DCD	0xf3d20aaf ;	vmlsl.u16	q8, d18, d31
	DCD	0xf3d308af ;	vmlal.u16	q8, d19, d31
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf2904814 ;	vshrn.i32	d4, q2, #16
	DCD	0xf2905830 ;	vshrn.i32	d5, q8, #16
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b21204 ;	vmovn.i16	d1, q2
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf4000aad ;	vst1.32	{d0-d1}, [r0 :128]!
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xba00004b ;	blt	10a74 <pixman_scaled_bilinear_scanline_0565_x888_SRC_asm_neon+0x3c0>
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813083 ;	add	r3, r1, r3, lsl #1
	DCD	0xe1a04845 ;	asr	r4, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0814084 ;	add	r4, r1, r4, lsl #1
	DCD	0xf4e36802 ;	vld1.32	{d22[0]}, [r3], r2
	DCD	0xf4e47802 ;	vld1.32	{d23[0]}, [r4], r2
	DCD	0xf4e3688f ;	vld1.32	{d22[1]}, [r3]
	DCD	0xf4e4788f ;	vld1.32	{d23[1]}, [r4]
	DCD	0xf2c84836 ;	vshrn.i16	d20, q11, #8
	DCD	0xf28d1836 ;	vshrn.i16	d1, q11, #3
	DCD	0xf3d56576 ;	vsli.16	q11, q11, #5
	DCD	0xf3cb4434 ;	vsri.8	d20, d20, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0836 ;	vshrn.i16	d0, q11, #2
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813083 ;	add	r3, r1, r3, lsl #1
	DCD	0xe1a04845 ;	asr	r4, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0814084 ;	add	r4, r1, r4, lsl #1
	DCD	0xf4e32802 ;	vld1.32	{d18[0]}, [r3], r2
	DCD	0xf3b201a4 ;	vzip.8	d0, d20
	DCD	0xf4e43802 ;	vld1.32	{d19[0]}, [r4], r2
	DCD	0xf3b211a5 ;	vzip.8	d1, d21
	DCD	0xf4e3288f ;	vld1.32	{d18[1]}, [r3]
	DCD	0xf3f241a5 ;	vzip.8	d20, d21
	DCD	0xf4e4388f ;	vld1.32	{d19[1]}, [r4]
	DCD	0xf3b20181 ;	vzip.8	d0, d1
	DCD	0xf2c80832 ;	vshrn.i16	d16, q9, #8
	DCD	0xf28d5832 ;	vshrn.i16	d5, q9, #3
	DCD	0xf3d52572 ;	vsli.16	q9, q9, #5
	DCD	0xf3cb0430 ;	vsri.8	d16, d16, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e4832 ;	vshrn.i16	d4, q9, #2
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf3b241a0 ;	vzip.8	d4, d16
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3b251a1 ;	vzip.8	d5, d17
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3f201a1 ;	vzip.8	d16, d17
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xf3b24185 ;	vzip.8	d4, d5
	DCD	0xf3846c2c ;	vmull.u8	q3, d4, d28
	DCD	0xf385682d ;	vmlal.u8	q3, d5, d29
	DCD	0xf3c02cac ;	vmull.u8	q9, d16, d28
	DCD	0xf3c128ad ;	vmlal.u8	q9, d17, d29
	DCD	0xf7d3f007 ;	pld	[r3, r7]
	DCD	0xe0433002 ;	sub	r3, r3, r2
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3d84a36 ;	vshll.u16	d20, q11, #8
	DCD	0xf3d64aaf ;	vmlsl.u16	q10, d22, d31
	DCD	0xf3d748af ;	vmlal.u16	q10, d23, d31
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3984a16 ;	vshll.u16	d4, q3, #8
	DCD	0xf3964a2e ;	vmlsl.u16	q2, d6, d30
	DCD	0xf397482e ;	vmlal.u16	q2, d7, d30
	DCD	0xf3d80a32 ;	vshll.u16	d16, q9, #8
	DCD	0xf7d4f007 ;	pld	[r4, r7]
	DCD	0xf3d20aaf ;	vmlsl.u16	q8, d18, d31
	DCD	0xf3d308af ;	vmlal.u16	q8, d19, d31
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf2904814 ;	vshrn.i32	d4, q2, #16
	DCD	0xf2905830 ;	vshrn.i32	d5, q8, #16
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b21204 ;	vmovn.i16	d1, q2
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf4000aad ;	vst1.32	{d0-d1}, [r0 :128]!
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xaaffffb3 ;	bge	10944 <pixman_scaled_bilinear_scanline_0565_x888_SRC_asm_neon+0x290>
	DCD	0xe31c0002 ;	tst	ip, #2
	DCD	0x0a000023 ;	beq	10b0c <pixman_scaled_bilinear_scanline_0565_x888_SRC_asm_neon+0x458>
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813083 ;	add	r3, r1, r3, lsl #1
	DCD	0xe1a04845 ;	asr	r4, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0814084 ;	add	r4, r1, r4, lsl #1
	DCD	0xf4e36802 ;	vld1.32	{d22[0]}, [r3], r2
	DCD	0xf4e47802 ;	vld1.32	{d23[0]}, [r4], r2
	DCD	0xf4e3688f ;	vld1.32	{d22[1]}, [r3]
	DCD	0xf4e4788f ;	vld1.32	{d23[1]}, [r4]
	DCD	0xf2c84836 ;	vshrn.i16	d20, q11, #8
	DCD	0xf28d1836 ;	vshrn.i16	d1, q11, #3
	DCD	0xf3d56576 ;	vsli.16	q11, q11, #5
	DCD	0xf3cb4434 ;	vsri.8	d20, d20, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0836 ;	vshrn.i16	d0, q11, #2
	DCD	0xf3b201a4 ;	vzip.8	d0, d20
	DCD	0xf3b211a5 ;	vzip.8	d1, d21
	DCD	0xf3f241a5 ;	vzip.8	d20, d21
	DCD	0xf3b20181 ;	vzip.8	d0, d1
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3d84a36 ;	vshll.u16	d20, q11, #8
	DCD	0xf3d64aaf ;	vmlsl.u16	q10, d22, d31
	DCD	0xf3d748af ;	vmlal.u16	q10, d23, d31
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf400079d ;	vst1.32	{d0}, [r0 :64]!
	DCD	0xe31c0001 ;	tst	ip, #1
	DCD	0x0a000014 ;	beq	10b68 <pixman_scaled_bilinear_scanline_0565_x888_SRC_asm_neon+0x4b4>
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813083 ;	add	r3, r1, r3, lsl #1
	DCD	0xf4a31802 ;	vld1.32	{d1[0]}, [r3], r2
	DCD	0xf4a3188f ;	vld1.32	{d1[1]}, [r3]
	DCD	0xf2950511 ;	vshl.s16	d0, d1, #5
	DCD	0xf29b2511 ;	vshl.s16	d2, d1, #11
	DCD	0xf39b1411 ;	vsri.16	d1, d1, #5
	DCD	0xf39a0410 ;	vsri.16	d0, d0, #6
	DCD	0xf39b2412 ;	vsri.16	d2, d2, #5
	DCD	0xf3981011 ;	vshr.u16	d1, d1, #8
	DCD	0xf3980412 ;	vsri.16	d0, d2, #8
	DCD	0xf3b60181 ;	vzip.16	d0, d1
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf480083d ;	vst1.32	{d0[0]}, [r0 :32]!
	DCD	0xe8bd03f0 ;	pop	{r4, r5, r6, r7, r8, r9}
	DCD	0xe12fff1e ;	bx	lr
	;		10b6c: R_ARM_V4BX	*ABS*
	ENDP  ; |pixman_scaled_bilinear_scanline_0565_x888_SRC_asm_neon|

|pixman_scaled_bilinear_scanline_0565_0565_SRC_asm_neon| PROC
	DCD	0xe1a0c00d ;	mov	ip, sp
	DCD	0xe92d03f0 ;	push	{r4, r5, r6, r7, r8, r9}
	DCD	0xe3a0701c ;	mov	r7, #28
	DCD	0xe89c1070 ;	ldm	ip, {r4, r5, r6, ip}
	DCD	0xe0070697 ;	mul	r7, r7, r6
	DCD	0xe0422001 ;	sub	r2, r2, r1
	DCD	0xe35c0000 ;	cmp	ip, #0
	DCD	0xda00015a ;	ble	110fc <pixman_scaled_bilinear_scanline_0565_0565_SRC_asm_neon+0x58c>
	DCD	0xeea85bb0 ;	vdup.16	q12, r5
	DCD	0xeeaa6bb0 ;	vdup.16	q13, r6
	DCD	0xeecc3b90 ;	vdup.8	d28, r3
	DCD	0xeecd4b90 ;	vdup.8	d29, r4
	DCD	0xf25998aa ;	vadd.i16	d25, d25, d26
	DCD	0xe35c0001 ;	cmp	ip, #1
	DCD	0xba000022 ;	blt	10c38 <pixman_scaled_bilinear_scanline_0565_0565_SRC_asm_neon+0xc8>
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000020 ;	beq	10c38 <pixman_scaled_bilinear_scanline_0565_0565_SRC_asm_neon+0xc8>
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813083 ;	add	r3, r1, r3, lsl #1
	DCD	0xf4a31802 ;	vld1.32	{d1[0]}, [r3], r2
	DCD	0xf4a3188f ;	vld1.32	{d1[1]}, [r3]
	DCD	0xf2950511 ;	vshl.s16	d0, d1, #5
	DCD	0xf29b2511 ;	vshl.s16	d2, d1, #11
	DCD	0xf39b1411 ;	vsri.16	d1, d1, #5
	DCD	0xf39a0410 ;	vsri.16	d0, d0, #6
	DCD	0xf39b2412 ;	vsri.16	d2, d2, #5
	DCD	0xf3981011 ;	vshr.u16	d1, d1, #8
	DCD	0xf3980412 ;	vsri.16	d0, d2, #8
	DCD	0xf3b60181 ;	vzip.16	d0, d1
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24301 ;	vshll.i8	q2, d1, #8
	DCD	0xf3b22302 ;	vshll.i8	q1, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf39b2454 ;	vsri.16	q1, q2, #5
	DCD	0xf3952456 ;	vsri.16	q1, q3, #11
	DCD	0xf480241d ;	vst1.16	{d2[0]}, [r0 :16]!
	DCD	0xe24cc001 ;	sub	ip, ip, #1
	DCD	0xf25aa8ea ;	vadd.i16	q13, q13, q13
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xe35c0002 ;	cmp	ip, #2
	DCD	0xba00002f ;	blt	10d0c <pixman_scaled_bilinear_scanline_0565_0565_SRC_asm_neon+0x19c>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a00002d ;	beq	10d0c <pixman_scaled_bilinear_scanline_0565_0565_SRC_asm_neon+0x19c>
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813083 ;	add	r3, r1, r3, lsl #1
	DCD	0xe1a04845 ;	asr	r4, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0814084 ;	add	r4, r1, r4, lsl #1
	DCD	0xf4e36802 ;	vld1.32	{d22[0]}, [r3], r2
	DCD	0xf4e47802 ;	vld1.32	{d23[0]}, [r4], r2
	DCD	0xf4e3688f ;	vld1.32	{d22[1]}, [r3]
	DCD	0xf4e4788f ;	vld1.32	{d23[1]}, [r4]
	DCD	0xf2c84836 ;	vshrn.i16	d20, q11, #8
	DCD	0xf28d1836 ;	vshrn.i16	d1, q11, #3
	DCD	0xf3d56576 ;	vsli.16	q11, q11, #5
	DCD	0xf3cb4434 ;	vsri.8	d20, d20, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0836 ;	vshrn.i16	d0, q11, #2
	DCD	0xf3b201a4 ;	vzip.8	d0, d20
	DCD	0xf3b211a5 ;	vzip.8	d1, d21
	DCD	0xf3f241a5 ;	vzip.8	d20, d21
	DCD	0xf3b20181 ;	vzip.8	d0, d1
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3d84a36 ;	vshll.u16	d20, q11, #8
	DCD	0xf3d64aaf ;	vmlsl.u16	q10, d22, d31
	DCD	0xf3d748af ;	vmlal.u16	q10, d23, d31
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24301 ;	vshll.i8	q2, d1, #8
	DCD	0xf3b22302 ;	vshll.i8	q1, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf39b2454 ;	vsri.16	q1, q2, #5
	DCD	0xf3952456 ;	vsri.16	q1, q3, #11
	DCD	0xf480283d ;	vst1.32	{d2[0]}, [r0 :32]!
	DCD	0xe24cc002 ;	sub	ip, ip, #2
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xba0000aa ;	blt	10fc0 <pixman_scaled_bilinear_scanline_0565_0565_SRC_asm_neon+0x450>
	DCD	0xe1a077c7 ;	asr	r7, r7, #15
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813083 ;	add	r3, r1, r3, lsl #1
	DCD	0xe1a04845 ;	asr	r4, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0814084 ;	add	r4, r1, r4, lsl #1
	DCD	0xf4e36802 ;	vld1.32	{d22[0]}, [r3], r2
	DCD	0xf4e47802 ;	vld1.32	{d23[0]}, [r4], r2
	DCD	0xf4e3688f ;	vld1.32	{d22[1]}, [r3]
	DCD	0xf4e4788f ;	vld1.32	{d23[1]}, [r4]
	DCD	0xf2c84836 ;	vshrn.i16	d20, q11, #8
	DCD	0xf28d1836 ;	vshrn.i16	d1, q11, #3
	DCD	0xf3d56576 ;	vsli.16	q11, q11, #5
	DCD	0xf3cb4434 ;	vsri.8	d20, d20, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0836 ;	vshrn.i16	d0, q11, #2
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813083 ;	add	r3, r1, r3, lsl #1
	DCD	0xe1a04845 ;	asr	r4, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0814084 ;	add	r4, r1, r4, lsl #1
	DCD	0xf4e32802 ;	vld1.32	{d18[0]}, [r3], r2
	DCD	0xf3b201a4 ;	vzip.8	d0, d20
	DCD	0xf4e43802 ;	vld1.32	{d19[0]}, [r4], r2
	DCD	0xf3b211a5 ;	vzip.8	d1, d21
	DCD	0xf4e3288f ;	vld1.32	{d18[1]}, [r3]
	DCD	0xf3f241a5 ;	vzip.8	d20, d21
	DCD	0xf4e4388f ;	vld1.32	{d19[1]}, [r4]
	DCD	0xf3b20181 ;	vzip.8	d0, d1
	DCD	0xf2c80832 ;	vshrn.i16	d16, q9, #8
	DCD	0xf28d5832 ;	vshrn.i16	d5, q9, #3
	DCD	0xf3d52572 ;	vsli.16	q9, q9, #5
	DCD	0xf3cb0430 ;	vsri.8	d16, d16, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e4832 ;	vshrn.i16	d4, q9, #2
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf3b241a0 ;	vzip.8	d4, d16
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3b251a1 ;	vzip.8	d5, d17
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3f201a1 ;	vzip.8	d16, d17
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xf3b24185 ;	vzip.8	d4, d5
	DCD	0xf3846c2c ;	vmull.u8	q3, d4, d28
	DCD	0xf385682d ;	vmlal.u8	q3, d5, d29
	DCD	0xf3c02cac ;	vmull.u8	q9, d16, d28
	DCD	0xf3c128ad ;	vmlal.u8	q9, d17, d29
	DCD	0xf7d3f007 ;	pld	[r3, r7]
	DCD	0xe0433002 ;	sub	r3, r3, r2
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3d84a36 ;	vshll.u16	d20, q11, #8
	DCD	0xf3d64aaf ;	vmlsl.u16	q10, d22, d31
	DCD	0xf3d748af ;	vmlal.u16	q10, d23, d31
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3984a16 ;	vshll.u16	d4, q3, #8
	DCD	0xf3964a2e ;	vmlsl.u16	q2, d6, d30
	DCD	0xf397482e ;	vmlal.u16	q2, d7, d30
	DCD	0xf3d80a32 ;	vshll.u16	d16, q9, #8
	DCD	0xf7d4f007 ;	pld	[r4, r7]
	DCD	0xf3d20aaf ;	vmlsl.u16	q8, d18, d31
	DCD	0xf3d308af ;	vmlal.u16	q8, d19, d31
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf2904814 ;	vshrn.i32	d4, q2, #16
	DCD	0xf2905830 ;	vshrn.i32	d5, q8, #16
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b21204 ;	vmovn.i16	d1, q2
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24301 ;	vshll.i8	q2, d1, #8
	DCD	0xf3b22302 ;	vshll.i8	q1, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf39b2454 ;	vsri.16	q1, q2, #5
	DCD	0xf3952456 ;	vsri.16	q1, q3, #11
	DCD	0xf400275d ;	vst1.16	{d2}, [r0 :64]!
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xba000054 ;	blt	10fc0 <pixman_scaled_bilinear_scanline_0565_0565_SRC_asm_neon+0x450>
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813083 ;	add	r3, r1, r3, lsl #1
	DCD	0xe1a04845 ;	asr	r4, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0814084 ;	add	r4, r1, r4, lsl #1
	DCD	0xf4e36802 ;	vld1.32	{d22[0]}, [r3], r2
	DCD	0xf4e47802 ;	vld1.32	{d23[0]}, [r4], r2
	DCD	0xf4e3688f ;	vld1.32	{d22[1]}, [r3]
	DCD	0xf4e4788f ;	vld1.32	{d23[1]}, [r4]
	DCD	0xf2c84836 ;	vshrn.i16	d20, q11, #8
	DCD	0xf28d1836 ;	vshrn.i16	d1, q11, #3
	DCD	0xf3d56576 ;	vsli.16	q11, q11, #5
	DCD	0xf3cb4434 ;	vsri.8	d20, d20, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0836 ;	vshrn.i16	d0, q11, #2
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813083 ;	add	r3, r1, r3, lsl #1
	DCD	0xe1a04845 ;	asr	r4, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0814084 ;	add	r4, r1, r4, lsl #1
	DCD	0xf4e32802 ;	vld1.32	{d18[0]}, [r3], r2
	DCD	0xf3b201a4 ;	vzip.8	d0, d20
	DCD	0xf4e43802 ;	vld1.32	{d19[0]}, [r4], r2
	DCD	0xf3b211a5 ;	vzip.8	d1, d21
	DCD	0xf4e3288f ;	vld1.32	{d18[1]}, [r3]
	DCD	0xf3f241a5 ;	vzip.8	d20, d21
	DCD	0xf4e4388f ;	vld1.32	{d19[1]}, [r4]
	DCD	0xf3b20181 ;	vzip.8	d0, d1
	DCD	0xf2c80832 ;	vshrn.i16	d16, q9, #8
	DCD	0xf28d5832 ;	vshrn.i16	d5, q9, #3
	DCD	0xf3d52572 ;	vsli.16	q9, q9, #5
	DCD	0xf3cb0430 ;	vsri.8	d16, d16, #5
	DCD	0xf38a5415 ;	vsri.8	d5, d5, #6
	DCD	0xf28e4832 ;	vshrn.i16	d4, q9, #2
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf3b241a0 ;	vzip.8	d4, d16
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3b251a1 ;	vzip.8	d5, d17
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3f201a1 ;	vzip.8	d16, d17
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xf3b24185 ;	vzip.8	d4, d5
	DCD	0xf3846c2c ;	vmull.u8	q3, d4, d28
	DCD	0xf385682d ;	vmlal.u8	q3, d5, d29
	DCD	0xf3c02cac ;	vmull.u8	q9, d16, d28
	DCD	0xf3c128ad ;	vmlal.u8	q9, d17, d29
	DCD	0xf7d3f007 ;	pld	[r3, r7]
	DCD	0xe0433002 ;	sub	r3, r3, r2
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3d84a36 ;	vshll.u16	d20, q11, #8
	DCD	0xf3d64aaf ;	vmlsl.u16	q10, d22, d31
	DCD	0xf3d748af ;	vmlal.u16	q10, d23, d31
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3984a16 ;	vshll.u16	d4, q3, #8
	DCD	0xf3964a2e ;	vmlsl.u16	q2, d6, d30
	DCD	0xf397482e ;	vmlal.u16	q2, d7, d30
	DCD	0xf3d80a32 ;	vshll.u16	d16, q9, #8
	DCD	0xf7d4f007 ;	pld	[r4, r7]
	DCD	0xf3d20aaf ;	vmlsl.u16	q8, d18, d31
	DCD	0xf3d308af ;	vmlal.u16	q8, d19, d31
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf2904814 ;	vshrn.i32	d4, q2, #16
	DCD	0xf2905830 ;	vshrn.i32	d5, q8, #16
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b21204 ;	vmovn.i16	d1, q2
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24301 ;	vshll.i8	q2, d1, #8
	DCD	0xf3b22302 ;	vshll.i8	q1, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf39b2454 ;	vsri.16	q1, q2, #5
	DCD	0xf3952456 ;	vsri.16	q1, q3, #11
	DCD	0xf400275d ;	vst1.16	{d2}, [r0 :64]!
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xaaffffaa ;	bge	10e6c <pixman_scaled_bilinear_scanline_0565_0565_SRC_asm_neon+0x2fc>
	DCD	0xe31c0002 ;	tst	ip, #2
	DCD	0x0a00002c ;	beq	1107c <pixman_scaled_bilinear_scanline_0565_0565_SRC_asm_neon+0x50c>
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813083 ;	add	r3, r1, r3, lsl #1
	DCD	0xe1a04845 ;	asr	r4, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0814084 ;	add	r4, r1, r4, lsl #1
	DCD	0xf4e36802 ;	vld1.32	{d22[0]}, [r3], r2
	DCD	0xf4e47802 ;	vld1.32	{d23[0]}, [r4], r2
	DCD	0xf4e3688f ;	vld1.32	{d22[1]}, [r3]
	DCD	0xf4e4788f ;	vld1.32	{d23[1]}, [r4]
	DCD	0xf2c84836 ;	vshrn.i16	d20, q11, #8
	DCD	0xf28d1836 ;	vshrn.i16	d1, q11, #3
	DCD	0xf3d56576 ;	vsli.16	q11, q11, #5
	DCD	0xf3cb4434 ;	vsri.8	d20, d20, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0836 ;	vshrn.i16	d0, q11, #2
	DCD	0xf3b201a4 ;	vzip.8	d0, d20
	DCD	0xf3b211a5 ;	vzip.8	d1, d21
	DCD	0xf3f241a5 ;	vzip.8	d20, d21
	DCD	0xf3b20181 ;	vzip.8	d0, d1
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3d84a36 ;	vshll.u16	d20, q11, #8
	DCD	0xf3d64aaf ;	vmlsl.u16	q10, d22, d31
	DCD	0xf3d748af ;	vmlal.u16	q10, d23, d31
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24301 ;	vshll.i8	q2, d1, #8
	DCD	0xf3b22302 ;	vshll.i8	q1, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf39b2454 ;	vsri.16	q1, q2, #5
	DCD	0xf3952456 ;	vsri.16	q1, q3, #11
	DCD	0xf480283d ;	vst1.32	{d2[0]}, [r0 :32]!
	DCD	0xe31c0001 ;	tst	ip, #1
	DCD	0x0a00001d ;	beq	110fc <pixman_scaled_bilinear_scanline_0565_0565_SRC_asm_neon+0x58c>
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813083 ;	add	r3, r1, r3, lsl #1
	DCD	0xf4a31802 ;	vld1.32	{d1[0]}, [r3], r2
	DCD	0xf4a3188f ;	vld1.32	{d1[1]}, [r3]
	DCD	0xf2950511 ;	vshl.s16	d0, d1, #5
	DCD	0xf29b2511 ;	vshl.s16	d2, d1, #11
	DCD	0xf39b1411 ;	vsri.16	d1, d1, #5
	DCD	0xf39a0410 ;	vsri.16	d0, d0, #6
	DCD	0xf39b2412 ;	vsri.16	d2, d2, #5
	DCD	0xf3981011 ;	vshr.u16	d1, d1, #8
	DCD	0xf3980412 ;	vsri.16	d0, d2, #8
	DCD	0xf3b60181 ;	vzip.16	d0, d1
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24301 ;	vshll.i8	q2, d1, #8
	DCD	0xf3b22302 ;	vshll.i8	q1, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf39b2454 ;	vsri.16	q1, q2, #5
	DCD	0xf3952456 ;	vsri.16	q1, q3, #11
	DCD	0xf480241d ;	vst1.16	{d2[0]}, [r0 :16]!
	DCD	0xe8bd03f0 ;	pop	{r4, r5, r6, r7, r8, r9}
	DCD	0xe12fff1e ;	bx	lr
	;		11100: R_ARM_V4BX	*ABS*
	ENDP  ; |pixman_scaled_bilinear_scanline_0565_0565_SRC_asm_neon|

	END
