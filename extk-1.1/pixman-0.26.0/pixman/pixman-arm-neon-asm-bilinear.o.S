	CODE32

	EXPORT	|pixman_scaled_bilinear_scanline_8888_8_8888_SRC_asm_neon|
	EXPORT	|pixman_scaled_bilinear_scanline_8888_8_0565_SRC_asm_neon|
	EXPORT	|pixman_scaled_bilinear_scanline_0565_8_x888_SRC_asm_neon|
	EXPORT	|pixman_scaled_bilinear_scanline_0565_8_0565_SRC_asm_neon|
	EXPORT	|pixman_scaled_bilinear_scanline_8888_8888_OVER_asm_neon|
	EXPORT	|pixman_scaled_bilinear_scanline_8888_8_8888_OVER_asm_neon|
	EXPORT	|pixman_scaled_bilinear_scanline_8888_8888_ADD_asm_neon|
	EXPORT	|pixman_scaled_bilinear_scanline_8888_8_8888_ADD_asm_neon|

	AREA	|.text|, CODE, ARM

|pixman_scaled_bilinear_scanline_8888_8_8888_SRC_asm_neon| PROC
	DCD	0xe1a0c00d ;	mov	ip, sp
	DCD	0xe92d17f0 ;	push	{r4, r5, r6, r7, r8, r9, sl, ip}
	DCD	0xe3a0801c ;	mov	r8, #28
	DCD	0xe89c10f0 ;	ldm	ip, {r4, r5, r6, r7, ip}
	DCD	0xe0080798 ;	mul	r8, r8, r7
	DCD	0xe0433002 ;	sub	r3, r3, r2
	DCD	0xe35c0000 ;	cmp	ip, #0
	DCD	0xda000132 ;	ble	4ec <pixman_scaled_bilinear_scanline_8888_8_8888_SRC_asm_neon+0x4ec>
	DCD	0xeea86bb0 ;	vdup.16	q12, r6
	DCD	0xeeaa7bb0 ;	vdup.16	q13, r7
	DCD	0xeecc4b90 ;	vdup.8	d28, r4
	DCD	0xeecd5b90 ;	vdup.8	d29, r5
	DCD	0xf25998aa ;	vadd.i16	d25, d25, d26
	DCD	0xe35c0001 ;	cmp	ip, #1
	DCD	0xba000020 ;	blt	c0 <pixman_scaled_bilinear_scanline_8888_8_8888_SRC_asm_neon+0xc0>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a00001e ;	beq	c0 <pixman_scaled_bilinear_scanline_8888_8_8888_SRC_asm_neon+0xc0>
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4240783 ;	vld1.32	{d0}, [r4], r3
	DCD	0xf424178f ;	vld1.32	{d1}, [r4]
	DCD	0xf4a1400d ;	vld1.8	{d4[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3b14c04 ;	vdup.8	d4, d4[0]
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3806c04 ;	vmull.u8	q3, d0, d4
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3840486 ;	vraddhn.i16	d0, q10, q3
	DCD	0xf38614a0 ;	vraddhn.i16	d1, q11, q8
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf480083d ;	vst1.32	{d0[0]}, [r0 :32]!
	DCD	0xe24cc001 ;	sub	ip, ip, #1
	DCD	0xf25aa8ea ;	vadd.i16	q13, q13, q13
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xe35c0002 ;	cmp	ip, #2
	DCD	0xba00002b ;	blt	184 <pixman_scaled_bilinear_scanline_8888_8_8888_SRC_asm_neon+0x184>
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000029 ;	beq	184 <pixman_scaled_bilinear_scanline_8888_8_8888_SRC_asm_neon+0x184>
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4240783 ;	vld1.32	{d0}, [r4], r3
	DCD	0xf424178f ;	vld1.32	{d1}, [r4]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4644783 ;	vld1.32	{d20}, [r4], r3
	DCD	0xf464578f ;	vld1.32	{d21}, [r4]
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xf4a1440d ;	vld1.16	{d4[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3d84a36 ;	vshll.u16	d20, q11, #8
	DCD	0xf3d64aaf ;	vmlsl.u16	q10, d22, d31
	DCD	0xf3d748af ;	vmlal.u16	q10, d23, d31
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf3b24c04 ;	vdup.16	d4, d4[0]
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3806c04 ;	vmull.u8	q3, d0, d4
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3840486 ;	vraddhn.i16	d0, q10, q3
	DCD	0xf38614a0 ;	vraddhn.i16	d1, q11, q8
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf400078d ;	vst1.32	{d0}, [r0]!
	DCD	0xe24cc002 ;	sub	ip, ip, #2
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xba00008e ;	blt	3c8 <pixman_scaled_bilinear_scanline_8888_8_8888_SRC_asm_neon+0x3c8>
	DCD	0xe1a08748 ;	asr	r8, r8, #14
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4240783 ;	vld1.32	{d0}, [r4], r3
	DCD	0xf424178f ;	vld1.32	{d1}, [r4]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4644783 ;	vld1.32	{d20}, [r4], r3
	DCD	0xf464578f ;	vld1.32	{d21}, [r4]
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4244783 ;	vld1.32	{d4}, [r4], r3
	DCD	0xf424578f ;	vld1.32	{d5}, [r4]
	DCD	0xf3846c2c ;	vmull.u8	q3, d4, d28
	DCD	0xf385682d ;	vmlal.u8	q3, d5, d29
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4640783 ;	vld1.32	{d16}, [r4], r3
	DCD	0xf464178f ;	vld1.32	{d17}, [r4]
	DCD	0xf3c02cac ;	vmull.u8	q9, d16, d28
	DCD	0xf3c128ad ;	vmlal.u8	q9, d17, d29
	DCD	0xf7d4f008 ;	pld	[r4, r8]
	DCD	0xe0444003 ;	sub	r4, r4, r3
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
	DCD	0xf4e1680d ;	vld1.32	{d22[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf7d4f008 ;	pld	[r4, r8]
	DCD	0xf3d20aaf ;	vmlsl.u16	q8, d18, d31
	DCD	0xf3d308af ;	vmlal.u16	q8, d19, d31
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf2904814 ;	vshrn.i32	d4, q2, #16
	DCD	0xf2905830 ;	vshrn.i32	d5, q8, #16
	DCD	0xf3f46c26 ;	vdup.32	d22, d22[0]
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b21204 ;	vmovn.i16	d1, q2
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3806c26 ;	vmull.u8	q3, d0, d22
	DCD	0xf3c10c26 ;	vmull.u8	q8, d1, d22
	DCD	0xf3d82256 ;	vrshr.u16	q9, q3, #8
	DCD	0xf3d84270 ;	vrshr.u16	q10, q8, #8
	DCD	0xf3820486 ;	vraddhn.i16	d0, q9, q3
	DCD	0xf38414a0 ;	vraddhn.i16	d1, q10, q8
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf4000a8d ;	vst1.32	{d0-d1}, [r0]!
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xba000046 ;	blt	3c8 <pixman_scaled_bilinear_scanline_8888_8_8888_SRC_asm_neon+0x3c8>
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4240783 ;	vld1.32	{d0}, [r4], r3
	DCD	0xf424178f ;	vld1.32	{d1}, [r4]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4644783 ;	vld1.32	{d20}, [r4], r3
	DCD	0xf464578f ;	vld1.32	{d21}, [r4]
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4244783 ;	vld1.32	{d4}, [r4], r3
	DCD	0xf424578f ;	vld1.32	{d5}, [r4]
	DCD	0xf3846c2c ;	vmull.u8	q3, d4, d28
	DCD	0xf385682d ;	vmlal.u8	q3, d5, d29
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4640783 ;	vld1.32	{d16}, [r4], r3
	DCD	0xf464178f ;	vld1.32	{d17}, [r4]
	DCD	0xf3c02cac ;	vmull.u8	q9, d16, d28
	DCD	0xf3c128ad ;	vmlal.u8	q9, d17, d29
	DCD	0xf7d4f008 ;	pld	[r4, r8]
	DCD	0xe0444003 ;	sub	r4, r4, r3
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
	DCD	0xf4e1680d ;	vld1.32	{d22[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf7d4f008 ;	pld	[r4, r8]
	DCD	0xf3d20aaf ;	vmlsl.u16	q8, d18, d31
	DCD	0xf3d308af ;	vmlal.u16	q8, d19, d31
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf2904814 ;	vshrn.i32	d4, q2, #16
	DCD	0xf2905830 ;	vshrn.i32	d5, q8, #16
	DCD	0xf3f46c26 ;	vdup.32	d22, d22[0]
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b21204 ;	vmovn.i16	d1, q2
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3806c26 ;	vmull.u8	q3, d0, d22
	DCD	0xf3c10c26 ;	vmull.u8	q8, d1, d22
	DCD	0xf3d82256 ;	vrshr.u16	q9, q3, #8
	DCD	0xf3d84270 ;	vrshr.u16	q10, q8, #8
	DCD	0xf3820486 ;	vraddhn.i16	d0, q9, q3
	DCD	0xf38414a0 ;	vraddhn.i16	d1, q10, q8
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf4000a8d ;	vst1.32	{d0-d1}, [r0]!
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xaaffffb8 ;	bge	2ac <pixman_scaled_bilinear_scanline_8888_8_8888_SRC_asm_neon+0x2ac>
	DCD	0xe31c0002 ;	tst	ip, #2
	DCD	0x0a000028 ;	beq	474 <pixman_scaled_bilinear_scanline_8888_8_8888_SRC_asm_neon+0x474>
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4240783 ;	vld1.32	{d0}, [r4], r3
	DCD	0xf424178f ;	vld1.32	{d1}, [r4]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4644783 ;	vld1.32	{d20}, [r4], r3
	DCD	0xf464578f ;	vld1.32	{d21}, [r4]
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xf4a1440d ;	vld1.16	{d4[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3d84a36 ;	vshll.u16	d20, q11, #8
	DCD	0xf3d64aaf ;	vmlsl.u16	q10, d22, d31
	DCD	0xf3d748af ;	vmlal.u16	q10, d23, d31
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf3b24c04 ;	vdup.16	d4, d4[0]
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3806c04 ;	vmull.u8	q3, d0, d4
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3840486 ;	vraddhn.i16	d0, q10, q3
	DCD	0xf38614a0 ;	vraddhn.i16	d1, q11, q8
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf400078d ;	vst1.32	{d0}, [r0]!
	DCD	0xe31c0001 ;	tst	ip, #1
	DCD	0x0a00001b ;	beq	4ec <pixman_scaled_bilinear_scanline_8888_8_8888_SRC_asm_neon+0x4ec>
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4240783 ;	vld1.32	{d0}, [r4], r3
	DCD	0xf424178f ;	vld1.32	{d1}, [r4]
	DCD	0xf4a1400d ;	vld1.8	{d4[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3b14c04 ;	vdup.8	d4, d4[0]
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3806c04 ;	vmull.u8	q3, d0, d4
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3840486 ;	vraddhn.i16	d0, q10, q3
	DCD	0xf38614a0 ;	vraddhn.i16	d1, q11, q8
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf480083d ;	vst1.32	{d0[0]}, [r0 :32]!
	DCD	0xe8bd17f0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, ip}
	DCD	0xe12fff1e ;	bx	lr
	;		4f0: R_ARM_V4BX	*ABS*
	ENDP  ; |pixman_scaled_bilinear_scanline_8888_8_8888_SRC_asm_neon|

|pixman_scaled_bilinear_scanline_8888_8_0565_SRC_asm_neon| PROC
	DCD	0xe1a0c00d ;	mov	ip, sp
	DCD	0xe92d17f0 ;	push	{r4, r5, r6, r7, r8, r9, sl, ip}
	DCD	0xe3a0801c ;	mov	r8, #28
	DCD	0xe89c10f0 ;	ldm	ip, {r4, r5, r6, r7, ip}
	DCD	0xe0080798 ;	mul	r8, r8, r7
	DCD	0xe0433002 ;	sub	r3, r3, r2
	DCD	0xe35c0000 ;	cmp	ip, #0
	DCD	0xda000168 ;	ble	ab8 <pixman_scaled_bilinear_scanline_8888_8_0565_SRC_asm_neon+0x5c4>
	DCD	0xeea86bb0 ;	vdup.16	q12, r6
	DCD	0xeeaa7bb0 ;	vdup.16	q13, r7
	DCD	0xeecc4b90 ;	vdup.8	d28, r4
	DCD	0xeecd5b90 ;	vdup.8	d29, r5
	DCD	0xf25998aa ;	vadd.i16	d25, d25, d26
	DCD	0xe35c0001 ;	cmp	ip, #1
	DCD	0xba000029 ;	blt	5d8 <pixman_scaled_bilinear_scanline_8888_8_0565_SRC_asm_neon+0xe4>
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a000027 ;	beq	5d8 <pixman_scaled_bilinear_scanline_8888_8_0565_SRC_asm_neon+0xe4>
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4240783 ;	vld1.32	{d0}, [r4], r3
	DCD	0xf424178f ;	vld1.32	{d1}, [r4]
	DCD	0xf4a1400d ;	vld1.8	{d4[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3b14c04 ;	vdup.8	d4, d4[0]
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3806c04 ;	vmull.u8	q3, d0, d4
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3840486 ;	vraddhn.i16	d0, q10, q3
	DCD	0xf38614a0 ;	vraddhn.i16	d1, q11, q8
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24301 ;	vshll.i8	q2, d1, #8
	DCD	0xf3b22302 ;	vshll.i8	q1, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf39b2454 ;	vsri.16	q1, q2, #5
	DCD	0xf3952456 ;	vsri.16	q1, q3, #11
	DCD	0xf480240d ;	vst1.16	{d2[0]}, [r0]!
	DCD	0xe24cc001 ;	sub	ip, ip, #1
	DCD	0xf25aa8ea ;	vadd.i16	q13, q13, q13
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xe35c0002 ;	cmp	ip, #2
	DCD	0xba000034 ;	blt	6c0 <pixman_scaled_bilinear_scanline_8888_8_0565_SRC_asm_neon+0x1cc>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000032 ;	beq	6c0 <pixman_scaled_bilinear_scanline_8888_8_0565_SRC_asm_neon+0x1cc>
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4240783 ;	vld1.32	{d0}, [r4], r3
	DCD	0xf424178f ;	vld1.32	{d1}, [r4]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4644783 ;	vld1.32	{d20}, [r4], r3
	DCD	0xf464578f ;	vld1.32	{d21}, [r4]
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xf4a1440d ;	vld1.16	{d4[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3d84a36 ;	vshll.u16	d20, q11, #8
	DCD	0xf3d64aaf ;	vmlsl.u16	q10, d22, d31
	DCD	0xf3d748af ;	vmlal.u16	q10, d23, d31
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf3b24c04 ;	vdup.16	d4, d4[0]
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3806c04 ;	vmull.u8	q3, d0, d4
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3840486 ;	vraddhn.i16	d0, q10, q3
	DCD	0xf38614a0 ;	vraddhn.i16	d1, q11, q8
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24301 ;	vshll.i8	q2, d1, #8
	DCD	0xf3b22302 ;	vshll.i8	q1, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf39b2454 ;	vsri.16	q1, q2, #5
	DCD	0xf3952456 ;	vsri.16	q1, q3, #11
	DCD	0xf480280d ;	vst1.32	{d2[0]}, [r0]!
	DCD	0xe24cc002 ;	sub	ip, ip, #2
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xba0000a0 ;	blt	94c <pixman_scaled_bilinear_scanline_8888_8_0565_SRC_asm_neon+0x458>
	DCD	0xe1a08748 ;	asr	r8, r8, #14
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4240783 ;	vld1.32	{d0}, [r4], r3
	DCD	0xf424178f ;	vld1.32	{d1}, [r4]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4644783 ;	vld1.32	{d20}, [r4], r3
	DCD	0xf464578f ;	vld1.32	{d21}, [r4]
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4244783 ;	vld1.32	{d4}, [r4], r3
	DCD	0xf424578f ;	vld1.32	{d5}, [r4]
	DCD	0xf3846c2c ;	vmull.u8	q3, d4, d28
	DCD	0xf385682d ;	vmlal.u8	q3, d5, d29
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4640783 ;	vld1.32	{d16}, [r4], r3
	DCD	0xf464178f ;	vld1.32	{d17}, [r4]
	DCD	0xf3c02cac ;	vmull.u8	q9, d16, d28
	DCD	0xf3c128ad ;	vmlal.u8	q9, d17, d29
	DCD	0xf7d4f008 ;	pld	[r4, r8]
	DCD	0xe0444003 ;	sub	r4, r4, r3
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
	DCD	0xf4e1680d ;	vld1.32	{d22[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf7d4f008 ;	pld	[r4, r8]
	DCD	0xf3d20aaf ;	vmlsl.u16	q8, d18, d31
	DCD	0xf3d308af ;	vmlal.u16	q8, d19, d31
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf2904814 ;	vshrn.i32	d4, q2, #16
	DCD	0xf2905830 ;	vshrn.i32	d5, q8, #16
	DCD	0xf3f46c26 ;	vdup.32	d22, d22[0]
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b21204 ;	vmovn.i16	d1, q2
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3806c26 ;	vmull.u8	q3, d0, d22
	DCD	0xf3c10c26 ;	vmull.u8	q8, d1, d22
	DCD	0xf3d82256 ;	vrshr.u16	q9, q3, #8
	DCD	0xf3d84270 ;	vrshr.u16	q10, q8, #8
	DCD	0xf3820486 ;	vraddhn.i16	d0, q9, q3
	DCD	0xf38414a0 ;	vraddhn.i16	d1, q10, q8
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24301 ;	vshll.i8	q2, d1, #8
	DCD	0xf3b22302 ;	vshll.i8	q1, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf39b2454 ;	vsri.16	q1, q2, #5
	DCD	0xf3952456 ;	vsri.16	q1, q3, #11
	DCD	0xf400274d ;	vst1.16	{d2}, [r0]!
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xba00004f ;	blt	94c <pixman_scaled_bilinear_scanline_8888_8_0565_SRC_asm_neon+0x458>
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4240783 ;	vld1.32	{d0}, [r4], r3
	DCD	0xf424178f ;	vld1.32	{d1}, [r4]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4644783 ;	vld1.32	{d20}, [r4], r3
	DCD	0xf464578f ;	vld1.32	{d21}, [r4]
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4244783 ;	vld1.32	{d4}, [r4], r3
	DCD	0xf424578f ;	vld1.32	{d5}, [r4]
	DCD	0xf3846c2c ;	vmull.u8	q3, d4, d28
	DCD	0xf385682d ;	vmlal.u8	q3, d5, d29
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4640783 ;	vld1.32	{d16}, [r4], r3
	DCD	0xf464178f ;	vld1.32	{d17}, [r4]
	DCD	0xf3c02cac ;	vmull.u8	q9, d16, d28
	DCD	0xf3c128ad ;	vmlal.u8	q9, d17, d29
	DCD	0xf7d4f008 ;	pld	[r4, r8]
	DCD	0xe0444003 ;	sub	r4, r4, r3
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
	DCD	0xf4e1680d ;	vld1.32	{d22[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf7d4f008 ;	pld	[r4, r8]
	DCD	0xf3d20aaf ;	vmlsl.u16	q8, d18, d31
	DCD	0xf3d308af ;	vmlal.u16	q8, d19, d31
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf2904814 ;	vshrn.i32	d4, q2, #16
	DCD	0xf2905830 ;	vshrn.i32	d5, q8, #16
	DCD	0xf3f46c26 ;	vdup.32	d22, d22[0]
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b21204 ;	vmovn.i16	d1, q2
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3806c26 ;	vmull.u8	q3, d0, d22
	DCD	0xf3c10c26 ;	vmull.u8	q8, d1, d22
	DCD	0xf3d82256 ;	vrshr.u16	q9, q3, #8
	DCD	0xf3d84270 ;	vrshr.u16	q10, q8, #8
	DCD	0xf3820486 ;	vraddhn.i16	d0, q9, q3
	DCD	0xf38414a0 ;	vraddhn.i16	d1, q10, q8
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24301 ;	vshll.i8	q2, d1, #8
	DCD	0xf3b22302 ;	vshll.i8	q1, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf39b2454 ;	vsri.16	q1, q2, #5
	DCD	0xf3952456 ;	vsri.16	q1, q3, #11
	DCD	0xf400274d ;	vst1.16	{d2}, [r0]!
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xaaffffaf ;	bge	80c <pixman_scaled_bilinear_scanline_8888_8_0565_SRC_asm_neon+0x318>
	DCD	0xe31c0002 ;	tst	ip, #2
	DCD	0x0a000031 ;	beq	a1c <pixman_scaled_bilinear_scanline_8888_8_0565_SRC_asm_neon+0x528>
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4240783 ;	vld1.32	{d0}, [r4], r3
	DCD	0xf424178f ;	vld1.32	{d1}, [r4]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4644783 ;	vld1.32	{d20}, [r4], r3
	DCD	0xf464578f ;	vld1.32	{d21}, [r4]
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xf4a1440d ;	vld1.16	{d4[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3d84a36 ;	vshll.u16	d20, q11, #8
	DCD	0xf3d64aaf ;	vmlsl.u16	q10, d22, d31
	DCD	0xf3d748af ;	vmlal.u16	q10, d23, d31
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf3b24c04 ;	vdup.16	d4, d4[0]
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3806c04 ;	vmull.u8	q3, d0, d4
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3840486 ;	vraddhn.i16	d0, q10, q3
	DCD	0xf38614a0 ;	vraddhn.i16	d1, q11, q8
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24301 ;	vshll.i8	q2, d1, #8
	DCD	0xf3b22302 ;	vshll.i8	q1, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf39b2454 ;	vsri.16	q1, q2, #5
	DCD	0xf3952456 ;	vsri.16	q1, q3, #11
	DCD	0xf480280d ;	vst1.32	{d2[0]}, [r0]!
	DCD	0xe31c0001 ;	tst	ip, #1
	DCD	0x0a000024 ;	beq	ab8 <pixman_scaled_bilinear_scanline_8888_8_0565_SRC_asm_neon+0x5c4>
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4240783 ;	vld1.32	{d0}, [r4], r3
	DCD	0xf424178f ;	vld1.32	{d1}, [r4]
	DCD	0xf4a1400d ;	vld1.8	{d4[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3b14c04 ;	vdup.8	d4, d4[0]
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3806c04 ;	vmull.u8	q3, d0, d4
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3840486 ;	vraddhn.i16	d0, q10, q3
	DCD	0xf38614a0 ;	vraddhn.i16	d1, q11, q8
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24301 ;	vshll.i8	q2, d1, #8
	DCD	0xf3b22302 ;	vshll.i8	q1, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf39b2454 ;	vsri.16	q1, q2, #5
	DCD	0xf3952456 ;	vsri.16	q1, q3, #11
	DCD	0xf480240d ;	vst1.16	{d2[0]}, [r0]!
	DCD	0xe8bd17f0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, ip}
	DCD	0xe12fff1e ;	bx	lr
	;		abc: R_ARM_V4BX	*ABS*
	ENDP  ; |pixman_scaled_bilinear_scanline_8888_8_0565_SRC_asm_neon|

|pixman_scaled_bilinear_scanline_0565_8_x888_SRC_asm_neon| PROC
	DCD	0xe1a0c00d ;	mov	ip, sp
	DCD	0xe92d17f0 ;	push	{r4, r5, r6, r7, r8, r9, sl, ip}
	DCD	0xe3a0801c ;	mov	r8, #28
	DCD	0xe89c10f0 ;	ldm	ip, {r4, r5, r6, r7, ip}
	DCD	0xe0080798 ;	mul	r8, r8, r7
	DCD	0xe0433002 ;	sub	r3, r3, r2
	DCD	0xe35c0000 ;	cmp	ip, #0
	DCD	0xda00017e ;	ble	10dc <pixman_scaled_bilinear_scanline_0565_8_x888_SRC_asm_neon+0x61c>
	DCD	0xeea86bb0 ;	vdup.16	q12, r6
	DCD	0xeeaa7bb0 ;	vdup.16	q13, r7
	DCD	0xeecc4b90 ;	vdup.8	d28, r4
	DCD	0xeecd5b90 ;	vdup.8	d29, r5
	DCD	0xf25998aa ;	vadd.i16	d25, d25, d26
	DCD	0xe35c0001 ;	cmp	ip, #1
	DCD	0xba000028 ;	blt	ba0 <pixman_scaled_bilinear_scanline_0565_8_x888_SRC_asm_neon+0xe0>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000026 ;	beq	ba0 <pixman_scaled_bilinear_scanline_0565_8_x888_SRC_asm_neon+0xe0>
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a41803 ;	vld1.32	{d1[0]}, [r4], r3
	DCD	0xf4a4188f ;	vld1.32	{d1[1]}, [r4]
	DCD	0xf2950511 ;	vshl.s16	d0, d1, #5
	DCD	0xf29b2511 ;	vshl.s16	d2, d1, #11
	DCD	0xf39b1411 ;	vsri.16	d1, d1, #5
	DCD	0xf39a0410 ;	vsri.16	d0, d0, #6
	DCD	0xf39b2412 ;	vsri.16	d2, d2, #5
	DCD	0xf3981011 ;	vshr.u16	d1, d1, #8
	DCD	0xf3980412 ;	vsri.16	d0, d2, #8
	DCD	0xf3b60181 ;	vzip.16	d0, d1
	DCD	0xf4a1400d ;	vld1.8	{d4[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3b14c04 ;	vdup.8	d4, d4[0]
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3806c04 ;	vmull.u8	q3, d0, d4
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3840486 ;	vraddhn.i16	d0, q10, q3
	DCD	0xf38614a0 ;	vraddhn.i16	d1, q11, q8
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf480083d ;	vst1.32	{d0[0]}, [r0 :32]!
	DCD	0xe24cc001 ;	sub	ip, ip, #1
	DCD	0xf25aa8ea ;	vadd.i16	q13, q13, q13
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xe35c0002 ;	cmp	ip, #2
	DCD	0xba000035 ;	blt	c8c <pixman_scaled_bilinear_scanline_0565_8_x888_SRC_asm_neon+0x1cc>
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000033 ;	beq	c8c <pixman_scaled_bilinear_scanline_0565_8_x888_SRC_asm_neon+0x1cc>
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xe1a05846 ;	asr	r5, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4e46803 ;	vld1.32	{d22[0]}, [r4], r3
	DCD	0xf4e57803 ;	vld1.32	{d23[0]}, [r5], r3
	DCD	0xf4e4688f ;	vld1.32	{d22[1]}, [r4]
	DCD	0xf4e5788f ;	vld1.32	{d23[1]}, [r5]
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
	DCD	0xf4a1440d ;	vld1.16	{d4[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3d84a36 ;	vshll.u16	d20, q11, #8
	DCD	0xf3d64aaf ;	vmlsl.u16	q10, d22, d31
	DCD	0xf3d748af ;	vmlal.u16	q10, d23, d31
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf3b24c04 ;	vdup.16	d4, d4[0]
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3806c04 ;	vmull.u8	q3, d0, d4
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3840486 ;	vraddhn.i16	d0, q10, q3
	DCD	0xf38614a0 ;	vraddhn.i16	d1, q11, q8
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf400078d ;	vst1.32	{d0}, [r0]!
	DCD	0xe24cc002 ;	sub	ip, ip, #2
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xba0000b6 ;	blt	f70 <pixman_scaled_bilinear_scanline_0565_8_x888_SRC_asm_neon+0x4b0>
	DCD	0xe1a087c8 ;	asr	r8, r8, #15
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xe1a05846 ;	asr	r5, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4e46803 ;	vld1.32	{d22[0]}, [r4], r3
	DCD	0xf4e57803 ;	vld1.32	{d23[0]}, [r5], r3
	DCD	0xf4e4688f ;	vld1.32	{d22[1]}, [r4]
	DCD	0xf4e5788f ;	vld1.32	{d23[1]}, [r5]
	DCD	0xf2c84836 ;	vshrn.i16	d20, q11, #8
	DCD	0xf28d1836 ;	vshrn.i16	d1, q11, #3
	DCD	0xf3d56576 ;	vsli.16	q11, q11, #5
	DCD	0xf3cb4434 ;	vsri.8	d20, d20, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0836 ;	vshrn.i16	d0, q11, #2
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xe1a05846 ;	asr	r5, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4e42803 ;	vld1.32	{d18[0]}, [r4], r3
	DCD	0xf3b201a4 ;	vzip.8	d0, d20
	DCD	0xf4e53803 ;	vld1.32	{d19[0]}, [r5], r3
	DCD	0xf3b211a5 ;	vzip.8	d1, d21
	DCD	0xf4e4288f ;	vld1.32	{d18[1]}, [r4]
	DCD	0xf3f241a5 ;	vzip.8	d20, d21
	DCD	0xf4e5388f ;	vld1.32	{d19[1]}, [r5]
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
	DCD	0xf7d4f008 ;	pld	[r4, r8]
	DCD	0xe0444003 ;	sub	r4, r4, r3
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
	DCD	0xf4e1680d ;	vld1.32	{d22[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf7d4f008 ;	pld	[r4, r8]
	DCD	0xf3d20aaf ;	vmlsl.u16	q8, d18, d31
	DCD	0xf3d308af ;	vmlal.u16	q8, d19, d31
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf2904814 ;	vshrn.i32	d4, q2, #16
	DCD	0xf2905830 ;	vshrn.i32	d5, q8, #16
	DCD	0xf3f46c26 ;	vdup.32	d22, d22[0]
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b21204 ;	vmovn.i16	d1, q2
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3806c26 ;	vmull.u8	q3, d0, d22
	DCD	0xf3c10c26 ;	vmull.u8	q8, d1, d22
	DCD	0xf3d82256 ;	vrshr.u16	q9, q3, #8
	DCD	0xf3d84270 ;	vrshr.u16	q10, q8, #8
	DCD	0xf3820486 ;	vraddhn.i16	d0, q9, q3
	DCD	0xf38414a0 ;	vraddhn.i16	d1, q10, q8
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf4000a8d ;	vst1.32	{d0-d1}, [r0]!
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xba00005a ;	blt	f70 <pixman_scaled_bilinear_scanline_0565_8_x888_SRC_asm_neon+0x4b0>
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xe1a05846 ;	asr	r5, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4e46803 ;	vld1.32	{d22[0]}, [r4], r3
	DCD	0xf4e57803 ;	vld1.32	{d23[0]}, [r5], r3
	DCD	0xf4e4688f ;	vld1.32	{d22[1]}, [r4]
	DCD	0xf4e5788f ;	vld1.32	{d23[1]}, [r5]
	DCD	0xf2c84836 ;	vshrn.i16	d20, q11, #8
	DCD	0xf28d1836 ;	vshrn.i16	d1, q11, #3
	DCD	0xf3d56576 ;	vsli.16	q11, q11, #5
	DCD	0xf3cb4434 ;	vsri.8	d20, d20, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0836 ;	vshrn.i16	d0, q11, #2
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xe1a05846 ;	asr	r5, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4e42803 ;	vld1.32	{d18[0]}, [r4], r3
	DCD	0xf3b201a4 ;	vzip.8	d0, d20
	DCD	0xf4e53803 ;	vld1.32	{d19[0]}, [r5], r3
	DCD	0xf3b211a5 ;	vzip.8	d1, d21
	DCD	0xf4e4288f ;	vld1.32	{d18[1]}, [r4]
	DCD	0xf3f241a5 ;	vzip.8	d20, d21
	DCD	0xf4e5388f ;	vld1.32	{d19[1]}, [r5]
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
	DCD	0xf7d4f008 ;	pld	[r4, r8]
	DCD	0xe0444003 ;	sub	r4, r4, r3
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
	DCD	0xf4e1680d ;	vld1.32	{d22[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf7d4f008 ;	pld	[r4, r8]
	DCD	0xf3d20aaf ;	vmlsl.u16	q8, d18, d31
	DCD	0xf3d308af ;	vmlal.u16	q8, d19, d31
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf2904814 ;	vshrn.i32	d4, q2, #16
	DCD	0xf2905830 ;	vshrn.i32	d5, q8, #16
	DCD	0xf3f46c26 ;	vdup.32	d22, d22[0]
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b21204 ;	vmovn.i16	d1, q2
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3806c26 ;	vmull.u8	q3, d0, d22
	DCD	0xf3c10c26 ;	vmull.u8	q8, d1, d22
	DCD	0xf3d82256 ;	vrshr.u16	q9, q3, #8
	DCD	0xf3d84270 ;	vrshr.u16	q10, q8, #8
	DCD	0xf3820486 ;	vraddhn.i16	d0, q9, q3
	DCD	0xf38414a0 ;	vraddhn.i16	d1, q10, q8
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf4000a8d ;	vst1.32	{d0-d1}, [r0]!
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xaaffffa4 ;	bge	e04 <pixman_scaled_bilinear_scanline_0565_8_x888_SRC_asm_neon+0x344>
	DCD	0xe31c0002 ;	tst	ip, #2
	DCD	0x0a000032 ;	beq	1044 <pixman_scaled_bilinear_scanline_0565_8_x888_SRC_asm_neon+0x584>
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xe1a05846 ;	asr	r5, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4e46803 ;	vld1.32	{d22[0]}, [r4], r3
	DCD	0xf4e57803 ;	vld1.32	{d23[0]}, [r5], r3
	DCD	0xf4e4688f ;	vld1.32	{d22[1]}, [r4]
	DCD	0xf4e5788f ;	vld1.32	{d23[1]}, [r5]
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
	DCD	0xf4a1440d ;	vld1.16	{d4[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3d84a36 ;	vshll.u16	d20, q11, #8
	DCD	0xf3d64aaf ;	vmlsl.u16	q10, d22, d31
	DCD	0xf3d748af ;	vmlal.u16	q10, d23, d31
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf3b24c04 ;	vdup.16	d4, d4[0]
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3806c04 ;	vmull.u8	q3, d0, d4
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3840486 ;	vraddhn.i16	d0, q10, q3
	DCD	0xf38614a0 ;	vraddhn.i16	d1, q11, q8
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf400078d ;	vst1.32	{d0}, [r0]!
	DCD	0xe31c0001 ;	tst	ip, #1
	DCD	0x0a000023 ;	beq	10dc <pixman_scaled_bilinear_scanline_0565_8_x888_SRC_asm_neon+0x61c>
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a41803 ;	vld1.32	{d1[0]}, [r4], r3
	DCD	0xf4a4188f ;	vld1.32	{d1[1]}, [r4]
	DCD	0xf2950511 ;	vshl.s16	d0, d1, #5
	DCD	0xf29b2511 ;	vshl.s16	d2, d1, #11
	DCD	0xf39b1411 ;	vsri.16	d1, d1, #5
	DCD	0xf39a0410 ;	vsri.16	d0, d0, #6
	DCD	0xf39b2412 ;	vsri.16	d2, d2, #5
	DCD	0xf3981011 ;	vshr.u16	d1, d1, #8
	DCD	0xf3980412 ;	vsri.16	d0, d2, #8
	DCD	0xf3b60181 ;	vzip.16	d0, d1
	DCD	0xf4a1400d ;	vld1.8	{d4[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3b14c04 ;	vdup.8	d4, d4[0]
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3806c04 ;	vmull.u8	q3, d0, d4
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3840486 ;	vraddhn.i16	d0, q10, q3
	DCD	0xf38614a0 ;	vraddhn.i16	d1, q11, q8
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf480083d ;	vst1.32	{d0[0]}, [r0 :32]!
	DCD	0xe8bd17f0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, ip}
	DCD	0xe12fff1e ;	bx	lr
	;		10e0: R_ARM_V4BX	*ABS*
	ENDP  ; |pixman_scaled_bilinear_scanline_0565_8_x888_SRC_asm_neon|

|pixman_scaled_bilinear_scanline_0565_8_0565_SRC_asm_neon| PROC
	DCD	0xe1a0c00d ;	mov	ip, sp
	DCD	0xe92d17f0 ;	push	{r4, r5, r6, r7, r8, r9, sl, ip}
	DCD	0xe3a0801c ;	mov	r8, #28
	DCD	0xe89c10f0 ;	ldm	ip, {r4, r5, r6, r7, ip}
	DCD	0xe0080798 ;	mul	r8, r8, r7
	DCD	0xe0433002 ;	sub	r3, r3, r2
	DCD	0xe35c0000 ;	cmp	ip, #0
	DCD	0xda0001b4 ;	ble	17d8 <pixman_scaled_bilinear_scanline_0565_8_0565_SRC_asm_neon+0x6f4>
	DCD	0xeea86bb0 ;	vdup.16	q12, r6
	DCD	0xeeaa7bb0 ;	vdup.16	q13, r7
	DCD	0xeecc4b90 ;	vdup.8	d28, r4
	DCD	0xeecd5b90 ;	vdup.8	d29, r5
	DCD	0xf25998aa ;	vadd.i16	d25, d25, d26
	DCD	0xe35c0001 ;	cmp	ip, #1
	DCD	0xba000031 ;	blt	11e8 <pixman_scaled_bilinear_scanline_0565_8_0565_SRC_asm_neon+0x104>
	DCD	0xe3100002 ;	tst	r0, #2
	DCD	0x0a00002f ;	beq	11e8 <pixman_scaled_bilinear_scanline_0565_8_0565_SRC_asm_neon+0x104>
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a41803 ;	vld1.32	{d1[0]}, [r4], r3
	DCD	0xf4a4188f ;	vld1.32	{d1[1]}, [r4]
	DCD	0xf2950511 ;	vshl.s16	d0, d1, #5
	DCD	0xf29b2511 ;	vshl.s16	d2, d1, #11
	DCD	0xf39b1411 ;	vsri.16	d1, d1, #5
	DCD	0xf39a0410 ;	vsri.16	d0, d0, #6
	DCD	0xf39b2412 ;	vsri.16	d2, d2, #5
	DCD	0xf3981011 ;	vshr.u16	d1, d1, #8
	DCD	0xf3980412 ;	vsri.16	d0, d2, #8
	DCD	0xf3b60181 ;	vzip.16	d0, d1
	DCD	0xf4a1400d ;	vld1.8	{d4[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3b14c04 ;	vdup.8	d4, d4[0]
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3806c04 ;	vmull.u8	q3, d0, d4
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3840486 ;	vraddhn.i16	d0, q10, q3
	DCD	0xf38614a0 ;	vraddhn.i16	d1, q11, q8
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24301 ;	vshll.i8	q2, d1, #8
	DCD	0xf3b22302 ;	vshll.i8	q1, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf39b2454 ;	vsri.16	q1, q2, #5
	DCD	0xf3952456 ;	vsri.16	q1, q3, #11
	DCD	0xf480240d ;	vst1.16	{d2[0]}, [r0]!
	DCD	0xe24cc001 ;	sub	ip, ip, #1
	DCD	0xf25aa8ea ;	vadd.i16	q13, q13, q13
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xe35c0002 ;	cmp	ip, #2
	DCD	0xba00003e ;	blt	12f8 <pixman_scaled_bilinear_scanline_0565_8_0565_SRC_asm_neon+0x214>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a00003c ;	beq	12f8 <pixman_scaled_bilinear_scanline_0565_8_0565_SRC_asm_neon+0x214>
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xe1a05846 ;	asr	r5, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4e46803 ;	vld1.32	{d22[0]}, [r4], r3
	DCD	0xf4e57803 ;	vld1.32	{d23[0]}, [r5], r3
	DCD	0xf4e4688f ;	vld1.32	{d22[1]}, [r4]
	DCD	0xf4e5788f ;	vld1.32	{d23[1]}, [r5]
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
	DCD	0xf4a1440d ;	vld1.16	{d4[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3d84a36 ;	vshll.u16	d20, q11, #8
	DCD	0xf3d64aaf ;	vmlsl.u16	q10, d22, d31
	DCD	0xf3d748af ;	vmlal.u16	q10, d23, d31
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf3b24c04 ;	vdup.16	d4, d4[0]
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3806c04 ;	vmull.u8	q3, d0, d4
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3840486 ;	vraddhn.i16	d0, q10, q3
	DCD	0xf38614a0 ;	vraddhn.i16	d1, q11, q8
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24301 ;	vshll.i8	q2, d1, #8
	DCD	0xf3b22302 ;	vshll.i8	q1, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf39b2454 ;	vsri.16	q1, q2, #5
	DCD	0xf3952456 ;	vsri.16	q1, q3, #11
	DCD	0xf480280d ;	vst1.32	{d2[0]}, [r0]!
	DCD	0xe24cc002 ;	sub	ip, ip, #2
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xba0000c8 ;	blt	1624 <pixman_scaled_bilinear_scanline_0565_8_0565_SRC_asm_neon+0x540>
	DCD	0xe1a087c8 ;	asr	r8, r8, #15
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xe1a05846 ;	asr	r5, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4e46803 ;	vld1.32	{d22[0]}, [r4], r3
	DCD	0xf4e57803 ;	vld1.32	{d23[0]}, [r5], r3
	DCD	0xf4e4688f ;	vld1.32	{d22[1]}, [r4]
	DCD	0xf4e5788f ;	vld1.32	{d23[1]}, [r5]
	DCD	0xf2c84836 ;	vshrn.i16	d20, q11, #8
	DCD	0xf28d1836 ;	vshrn.i16	d1, q11, #3
	DCD	0xf3d56576 ;	vsli.16	q11, q11, #5
	DCD	0xf3cb4434 ;	vsri.8	d20, d20, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0836 ;	vshrn.i16	d0, q11, #2
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xe1a05846 ;	asr	r5, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4e42803 ;	vld1.32	{d18[0]}, [r4], r3
	DCD	0xf3b201a4 ;	vzip.8	d0, d20
	DCD	0xf4e53803 ;	vld1.32	{d19[0]}, [r5], r3
	DCD	0xf3b211a5 ;	vzip.8	d1, d21
	DCD	0xf4e4288f ;	vld1.32	{d18[1]}, [r4]
	DCD	0xf3f241a5 ;	vzip.8	d20, d21
	DCD	0xf4e5388f ;	vld1.32	{d19[1]}, [r5]
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
	DCD	0xf7d4f008 ;	pld	[r4, r8]
	DCD	0xe0444003 ;	sub	r4, r4, r3
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
	DCD	0xf4e1680d ;	vld1.32	{d22[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf7d4f008 ;	pld	[r4, r8]
	DCD	0xf3d20aaf ;	vmlsl.u16	q8, d18, d31
	DCD	0xf3d308af ;	vmlal.u16	q8, d19, d31
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf2904814 ;	vshrn.i32	d4, q2, #16
	DCD	0xf2905830 ;	vshrn.i32	d5, q8, #16
	DCD	0xf3f46c26 ;	vdup.32	d22, d22[0]
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b21204 ;	vmovn.i16	d1, q2
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3806c26 ;	vmull.u8	q3, d0, d22
	DCD	0xf3c10c26 ;	vmull.u8	q8, d1, d22
	DCD	0xf3d82256 ;	vrshr.u16	q9, q3, #8
	DCD	0xf3d84270 ;	vrshr.u16	q10, q8, #8
	DCD	0xf3820486 ;	vraddhn.i16	d0, q9, q3
	DCD	0xf38414a0 ;	vraddhn.i16	d1, q10, q8
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24301 ;	vshll.i8	q2, d1, #8
	DCD	0xf3b22302 ;	vshll.i8	q1, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf39b2454 ;	vsri.16	q1, q2, #5
	DCD	0xf3952456 ;	vsri.16	q1, q3, #11
	DCD	0xf400274d ;	vst1.16	{d2}, [r0]!
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xba000063 ;	blt	1624 <pixman_scaled_bilinear_scanline_0565_8_0565_SRC_asm_neon+0x540>
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xe1a05846 ;	asr	r5, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4e46803 ;	vld1.32	{d22[0]}, [r4], r3
	DCD	0xf4e57803 ;	vld1.32	{d23[0]}, [r5], r3
	DCD	0xf4e4688f ;	vld1.32	{d22[1]}, [r4]
	DCD	0xf4e5788f ;	vld1.32	{d23[1]}, [r5]
	DCD	0xf2c84836 ;	vshrn.i16	d20, q11, #8
	DCD	0xf28d1836 ;	vshrn.i16	d1, q11, #3
	DCD	0xf3d56576 ;	vsli.16	q11, q11, #5
	DCD	0xf3cb4434 ;	vsri.8	d20, d20, #5
	DCD	0xf38a1411 ;	vsri.8	d1, d1, #6
	DCD	0xf28e0836 ;	vshrn.i16	d0, q11, #2
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xe1a05846 ;	asr	r5, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4e42803 ;	vld1.32	{d18[0]}, [r4], r3
	DCD	0xf3b201a4 ;	vzip.8	d0, d20
	DCD	0xf4e53803 ;	vld1.32	{d19[0]}, [r5], r3
	DCD	0xf3b211a5 ;	vzip.8	d1, d21
	DCD	0xf4e4288f ;	vld1.32	{d18[1]}, [r4]
	DCD	0xf3f241a5 ;	vzip.8	d20, d21
	DCD	0xf4e5388f ;	vld1.32	{d19[1]}, [r5]
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
	DCD	0xf7d4f008 ;	pld	[r4, r8]
	DCD	0xe0444003 ;	sub	r4, r4, r3
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
	DCD	0xf4e1680d ;	vld1.32	{d22[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf7d4f008 ;	pld	[r4, r8]
	DCD	0xf3d20aaf ;	vmlsl.u16	q8, d18, d31
	DCD	0xf3d308af ;	vmlal.u16	q8, d19, d31
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf2904814 ;	vshrn.i32	d4, q2, #16
	DCD	0xf2905830 ;	vshrn.i32	d5, q8, #16
	DCD	0xf3f46c26 ;	vdup.32	d22, d22[0]
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b21204 ;	vmovn.i16	d1, q2
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3806c26 ;	vmull.u8	q3, d0, d22
	DCD	0xf3c10c26 ;	vmull.u8	q8, d1, d22
	DCD	0xf3d82256 ;	vrshr.u16	q9, q3, #8
	DCD	0xf3d84270 ;	vrshr.u16	q10, q8, #8
	DCD	0xf3820486 ;	vraddhn.i16	d0, q9, q3
	DCD	0xf38414a0 ;	vraddhn.i16	d1, q10, q8
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24301 ;	vshll.i8	q2, d1, #8
	DCD	0xf3b22302 ;	vshll.i8	q1, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf39b2454 ;	vsri.16	q1, q2, #5
	DCD	0xf3952456 ;	vsri.16	q1, q3, #11
	DCD	0xf400274d ;	vst1.16	{d2}, [r0]!
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xaaffff9b ;	bge	1494 <pixman_scaled_bilinear_scanline_0565_8_0565_SRC_asm_neon+0x3b0>
	DCD	0xe31c0002 ;	tst	ip, #2
	DCD	0x0a00003b ;	beq	171c <pixman_scaled_bilinear_scanline_0565_8_0565_SRC_asm_neon+0x638>
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xe1a05846 ;	asr	r5, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0825085 ;	add	r5, r2, r5, lsl #1
	DCD	0xf4e46803 ;	vld1.32	{d22[0]}, [r4], r3
	DCD	0xf4e57803 ;	vld1.32	{d23[0]}, [r5], r3
	DCD	0xf4e4688f ;	vld1.32	{d22[1]}, [r4]
	DCD	0xf4e5788f ;	vld1.32	{d23[1]}, [r5]
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
	DCD	0xf4a1440d ;	vld1.16	{d4[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3d84a36 ;	vshll.u16	d20, q11, #8
	DCD	0xf3d64aaf ;	vmlsl.u16	q10, d22, d31
	DCD	0xf3d748af ;	vmlal.u16	q10, d23, d31
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf3b24c04 ;	vdup.16	d4, d4[0]
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3806c04 ;	vmull.u8	q3, d0, d4
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3840486 ;	vraddhn.i16	d0, q10, q3
	DCD	0xf38614a0 ;	vraddhn.i16	d1, q11, q8
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24301 ;	vshll.i8	q2, d1, #8
	DCD	0xf3b22302 ;	vshll.i8	q1, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf39b2454 ;	vsri.16	q1, q2, #5
	DCD	0xf3952456 ;	vsri.16	q1, q3, #11
	DCD	0xf480280d ;	vst1.32	{d2[0]}, [r0]!
	DCD	0xe31c0001 ;	tst	ip, #1
	DCD	0x0a00002c ;	beq	17d8 <pixman_scaled_bilinear_scanline_0565_8_0565_SRC_asm_neon+0x6f4>
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824084 ;	add	r4, r2, r4, lsl #1
	DCD	0xf4a41803 ;	vld1.32	{d1[0]}, [r4], r3
	DCD	0xf4a4188f ;	vld1.32	{d1[1]}, [r4]
	DCD	0xf2950511 ;	vshl.s16	d0, d1, #5
	DCD	0xf29b2511 ;	vshl.s16	d2, d1, #11
	DCD	0xf39b1411 ;	vsri.16	d1, d1, #5
	DCD	0xf39a0410 ;	vsri.16	d0, d0, #6
	DCD	0xf39b2412 ;	vsri.16	d2, d2, #5
	DCD	0xf3981011 ;	vshr.u16	d1, d1, #8
	DCD	0xf3980412 ;	vsri.16	d0, d2, #8
	DCD	0xf3b60181 ;	vzip.16	d0, d1
	DCD	0xf4a1400d ;	vld1.8	{d4[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3b14c04 ;	vdup.8	d4, d4[0]
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3806c04 ;	vmull.u8	q3, d0, d4
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3840486 ;	vraddhn.i16	d0, q10, q3
	DCD	0xf38614a0 ;	vraddhn.i16	d1, q11, q8
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b21103 ;	vuzp.8	d1, d3
	DCD	0xf3b20102 ;	vuzp.8	d0, d2
	DCD	0xf3b24301 ;	vshll.i8	q2, d1, #8
	DCD	0xf3b22302 ;	vshll.i8	q1, d2, #8
	DCD	0xf3b26300 ;	vshll.i8	q3, d0, #8
	DCD	0xf39b2454 ;	vsri.16	q1, q2, #5
	DCD	0xf3952456 ;	vsri.16	q1, q3, #11
	DCD	0xf480240d ;	vst1.16	{d2[0]}, [r0]!
	DCD	0xe8bd17f0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, ip}
	DCD	0xe12fff1e ;	bx	lr
	;		17dc: R_ARM_V4BX	*ABS*
	ENDP  ; |pixman_scaled_bilinear_scanline_0565_8_0565_SRC_asm_neon|

|pixman_scaled_bilinear_scanline_8888_8888_OVER_asm_neon| PROC
	DCD	0xe1a0c00d ;	mov	ip, sp
	DCD	0xe92d03f0 ;	push	{r4, r5, r6, r7, r8, r9}
	DCD	0xe3a0701c ;	mov	r7, #28
	DCD	0xe89c1070 ;	ldm	ip, {r4, r5, r6, ip}
	DCD	0xe0070697 ;	mul	r7, r7, r6
	DCD	0xe0422001 ;	sub	r2, r2, r1
	DCD	0xe35c0000 ;	cmp	ip, #0
	DCD	0xda00013c ;	ble	1cf4 <pixman_scaled_bilinear_scanline_8888_8888_OVER_asm_neon+0x514>
	DCD	0xeea85bb0 ;	vdup.16	q12, r5
	DCD	0xeeaa6bb0 ;	vdup.16	q13, r6
	DCD	0xeecc3b90 ;	vdup.8	d28, r3
	DCD	0xeecd4b90 ;	vdup.8	d29, r4
	DCD	0xf25998aa ;	vadd.i16	d25, d25, d26
	DCD	0xe35c0001 ;	cmp	ip, #1
	DCD	0xba000022 ;	blt	18a8 <pixman_scaled_bilinear_scanline_8888_8888_OVER_asm_neon+0xc8>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000020 ;	beq	18a8 <pixman_scaled_bilinear_scanline_8888_8888_OVER_asm_neon+0xc8>
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xf4230782 ;	vld1.32	{d0}, [r3], r2
	DCD	0xf423178f ;	vld1.32	{d1}, [r3]
	DCD	0xf4e0280f ;	vld1.32	{d18[0]}, [r0]
	DCD	0xf5d0f070 ;	pld	[r0, #112]	; 0x70
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3bc5c01 ;	vdup.32	d5, d1[1]
	DCD	0xf3b05585 ;	vmvn	d5, d5
	DCD	0xf3826c85 ;	vmull.u8	q3, d18, d5
	DCD	0xf3c30c85 ;	vmull.u8	q8, d19, d5
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3c42486 ;	vraddhn.i16	d18, q10, q3
	DCD	0xf3c634a0 ;	vraddhn.i16	d19, q11, q8
	DCD	0xf30200d0 ;	vqadd.u8	q0, q9, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf480083d ;	vst1.32	{d0[0]}, [r0 :32]!
	DCD	0xe24cc001 ;	sub	ip, ip, #1
	DCD	0xf25aa8ea ;	vadd.i16	q13, q13, q13
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xe35c0002 ;	cmp	ip, #2
	DCD	0xba00002d ;	blt	1974 <pixman_scaled_bilinear_scanline_8888_8888_OVER_asm_neon+0x194>
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a00002b ;	beq	1974 <pixman_scaled_bilinear_scanline_8888_8888_OVER_asm_neon+0x194>
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
	DCD	0xf460278f ;	vld1.32	{d18}, [r0]
	DCD	0xf5d0f070 ;	pld	[r0, #112]	; 0x70
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
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3bc5c01 ;	vdup.32	d5, d1[1]
	DCD	0xf3b05585 ;	vmvn	d5, d5
	DCD	0xf3826c85 ;	vmull.u8	q3, d18, d5
	DCD	0xf3c30c85 ;	vmull.u8	q8, d19, d5
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3c42486 ;	vraddhn.i16	d18, q10, q3
	DCD	0xf3c634a0 ;	vraddhn.i16	d19, q11, q8
	DCD	0xf30200d0 ;	vqadd.u8	q0, q9, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf400078d ;	vst1.32	{d0}, [r0]!
	DCD	0xe24cc002 ;	sub	ip, ip, #2
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xba000090 ;	blt	1bc0 <pixman_scaled_bilinear_scanline_8888_8888_OVER_asm_neon+0x3e0>
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
	DCD	0xf39328af ;	vmlal.u16	q1, d19, d31
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xba000047 ;	blt	1b40 <pixman_scaled_bilinear_scanline_8888_8888_OVER_asm_neon+0x360>
	DCD	0xf3984a34 ;	vshll.u16	d4, q10, #8
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xf3944aae ;	vmlsl.u16	q2, d20, d30
	DCD	0xe1a04845 ;	asr	r4, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0814104 ;	add	r4, r1, r4, lsl #2
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
	DCD	0xf4202aaf ;	vld1.32	{d2-d3}, [r0 :128]
	DCD	0xf7d0f007 ;	pld	[r0, r7]
	DCD	0xf2904814 ;	vshrn.i32	d4, q2, #16
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf4646782 ;	vld1.32	{d22}, [r4], r2
	DCD	0xf2905816 ;	vshrn.i32	d5, q3, #16
	DCD	0xf3b26200 ;	vmovn.i16	d6, q0
	DCD	0xf464778f ;	vld1.32	{d23}, [r4]
	DCD	0xf3c62cac ;	vmull.u8	q9, d22, d28
	DCD	0xe1a08845 ;	asr	r8, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0818108 ;	add	r8, r1, r8, lsl #2
	DCD	0xe1a09845 ;	asr	r9, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0819109 ;	add	r9, r1, r9, lsl #2
	DCD	0xf3c728ad ;	vmlal.u8	q9, d23, d29
	DCD	0xf3b27204 ;	vmovn.i16	d7, q2
	DCD	0xf4686782 ;	vld1.32	{d22}, [r8], r2
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3bc4c07 ;	vdup.32	d4, d7[1]
	DCD	0xf468778f ;	vld1.32	{d23}, [r8]
	DCD	0xf3b04584 ;	vmvn	d4, d4
	DCD	0xf3c64cac ;	vmull.u8	q10, d22, d28
	DCD	0xf3c748ad ;	vmlal.u8	q10, d23, d29
	DCD	0xf3c26c04 ;	vmull.u8	q11, d2, d4
	DCD	0xf3834c04 ;	vmull.u8	q2, d3, d4
	DCD	0xf3980a30 ;	vshll.u16	d0, q8, #8
	DCD	0xf3900aae ;	vmlsl.u16	q0, d16, d30
	DCD	0xf3982276 ;	vrshr.u16	q1, q11, #8
	DCD	0xf39108ae ;	vmlal.u16	q0, d17, d30
	DCD	0xf3d80254 ;	vrshr.u16	q8, q2, #8
	DCD	0xf3822426 ;	vraddhn.i16	d2, q1, q11
	DCD	0xf3803484 ;	vraddhn.i16	d3, q8, q2
	DCD	0xf7d9f007 ;	pld	[r9, r7]
	DCD	0xf4690782 ;	vld1.32	{d16}, [r9], r2
	DCD	0xf3026056 ;	vqadd.u8	q3, q1, q3
	DCD	0xf469178f ;	vld1.32	{d17}, [r9]
	DCD	0xf7d9f007 ;	pld	[r9, r7]
	DCD	0xf3c06cac ;	vmull.u8	q11, d16, d28
	DCD	0xf3c168ad ;	vmlal.u8	q11, d17, d29
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3982a32 ;	vshll.u16	d2, q9, #8
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3922aaf ;	vmlsl.u16	q1, d18, d31
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf39328af ;	vmlal.u16	q1, d19, d31
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf4006aad ;	vst1.32	{d6-d7}, [r0 :128]!
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xaaffffb7 ;	bge	1a20 <pixman_scaled_bilinear_scanline_8888_8888_OVER_asm_neon+0x240>
	DCD	0xf3984a34 ;	vshll.u16	d4, q10, #8
	DCD	0xf3944aae ;	vmlsl.u16	q2, d20, d30
	DCD	0xf39548ae ;	vmlal.u16	q2, d21, d30
	DCD	0xf3986a36 ;	vshll.u16	d6, q11, #8
	DCD	0xf3966aaf ;	vmlsl.u16	q3, d22, d31
	DCD	0xf39768af ;	vmlal.u16	q3, d23, d31
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901812 ;	vshrn.i32	d1, q1, #16
	DCD	0xf4202aaf ;	vld1.32	{d2-d3}, [r0 :128]
	DCD	0xf5d0f070 ;	pld	[r0, #112]	; 0x70
	DCD	0xf2904814 ;	vshrn.i32	d4, q2, #16
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf2905816 ;	vshrn.i32	d5, q3, #16
	DCD	0xf3b26200 ;	vmovn.i16	d6, q0
	DCD	0xf3b27204 ;	vmovn.i16	d7, q2
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3bc4c07 ;	vdup.32	d4, d7[1]
	DCD	0xf3b04584 ;	vmvn	d4, d4
	DCD	0xf3c26c04 ;	vmull.u8	q11, d2, d4
	DCD	0xf3834c04 ;	vmull.u8	q2, d3, d4
	DCD	0xf3982276 ;	vrshr.u16	q1, q11, #8
	DCD	0xf3d84254 ;	vrshr.u16	q10, q2, #8
	DCD	0xf3822426 ;	vraddhn.i16	d2, q1, q11
	DCD	0xf3843484 ;	vraddhn.i16	d3, q10, q2
	DCD	0xf3026056 ;	vqadd.u8	q3, q1, q3
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf3b26107 ;	vuzp.8	d6, d7
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf4006aad ;	vst1.32	{d6-d7}, [r0 :128]!
	DCD	0xe31c0002 ;	tst	ip, #2
	DCD	0x0a00002a ;	beq	1c74 <pixman_scaled_bilinear_scanline_8888_8888_OVER_asm_neon+0x494>
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
	DCD	0xf460278f ;	vld1.32	{d18}, [r0]
	DCD	0xf5d0f070 ;	pld	[r0, #112]	; 0x70
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
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3bc5c01 ;	vdup.32	d5, d1[1]
	DCD	0xf3b05585 ;	vmvn	d5, d5
	DCD	0xf3826c85 ;	vmull.u8	q3, d18, d5
	DCD	0xf3c30c85 ;	vmull.u8	q8, d19, d5
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3c42486 ;	vraddhn.i16	d18, q10, q3
	DCD	0xf3c634a0 ;	vraddhn.i16	d19, q11, q8
	DCD	0xf30200d0 ;	vqadd.u8	q0, q9, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf400078d ;	vst1.32	{d0}, [r0]!
	DCD	0xe31c0001 ;	tst	ip, #1
	DCD	0x0a00001d ;	beq	1cf4 <pixman_scaled_bilinear_scanline_8888_8888_OVER_asm_neon+0x514>
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xf4230782 ;	vld1.32	{d0}, [r3], r2
	DCD	0xf423178f ;	vld1.32	{d1}, [r3]
	DCD	0xf4e0280f ;	vld1.32	{d18[0]}, [r0]
	DCD	0xf5d0f070 ;	pld	[r0, #112]	; 0x70
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3bc5c01 ;	vdup.32	d5, d1[1]
	DCD	0xf3b05585 ;	vmvn	d5, d5
	DCD	0xf3826c85 ;	vmull.u8	q3, d18, d5
	DCD	0xf3c30c85 ;	vmull.u8	q8, d19, d5
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3c42486 ;	vraddhn.i16	d18, q10, q3
	DCD	0xf3c634a0 ;	vraddhn.i16	d19, q11, q8
	DCD	0xf30200d0 ;	vqadd.u8	q0, q9, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf480083d ;	vst1.32	{d0[0]}, [r0 :32]!
	DCD	0xe8bd03f0 ;	pop	{r4, r5, r6, r7, r8, r9}
	DCD	0xe12fff1e ;	bx	lr
	;		1cf8: R_ARM_V4BX	*ABS*
	ENDP  ; |pixman_scaled_bilinear_scanline_8888_8888_OVER_asm_neon|

|pixman_scaled_bilinear_scanline_8888_8_8888_OVER_asm_neon| PROC
	DCD	0xe1a0c00d ;	mov	ip, sp
	DCD	0xe92d17f0 ;	push	{r4, r5, r6, r7, r8, r9, sl, ip}
	DCD	0xe3a0801c ;	mov	r8, #28
	DCD	0xe89c10f0 ;	ldm	ip, {r4, r5, r6, r7, ip}
	DCD	0xe0080798 ;	mul	r8, r8, r7
	DCD	0xe0433002 ;	sub	r3, r3, r2
	DCD	0xe35c0000 ;	cmp	ip, #0
	DCD	0xda000171 ;	ble	22e4 <pixman_scaled_bilinear_scanline_8888_8_8888_OVER_asm_neon+0x5e8>
	DCD	0xeea86bb0 ;	vdup.16	q12, r6
	DCD	0xeeaa7bb0 ;	vdup.16	q13, r7
	DCD	0xeecc4b90 ;	vdup.8	d28, r4
	DCD	0xeecd5b90 ;	vdup.8	d29, r5
	DCD	0xf25998aa ;	vadd.i16	d25, d25, d26
	DCD	0xe35c0001 ;	cmp	ip, #1
	DCD	0xba00002b ;	blt	1de8 <pixman_scaled_bilinear_scanline_8888_8_8888_OVER_asm_neon+0xec>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000029 ;	beq	1de8 <pixman_scaled_bilinear_scanline_8888_8_8888_OVER_asm_neon+0xec>
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4240783 ;	vld1.32	{d0}, [r4], r3
	DCD	0xf424178f ;	vld1.32	{d1}, [r4]
	DCD	0xf4a1400d ;	vld1.8	{d4[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf4e0280f ;	vld1.32	{d18[0]}, [r0]
	DCD	0xf5d0f070 ;	pld	[r0, #112]	; 0x70
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3b14c04 ;	vdup.8	d4, d4[0]
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3806c04 ;	vmull.u8	q3, d0, d4
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3840486 ;	vraddhn.i16	d0, q10, q3
	DCD	0xf38614a0 ;	vraddhn.i16	d1, q11, q8
	DCD	0xf3bc5c01 ;	vdup.32	d5, d1[1]
	DCD	0xf3b05585 ;	vmvn	d5, d5
	DCD	0xf3826c85 ;	vmull.u8	q3, d18, d5
	DCD	0xf3c30c85 ;	vmull.u8	q8, d19, d5
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3c42486 ;	vraddhn.i16	d18, q10, q3
	DCD	0xf3c634a0 ;	vraddhn.i16	d19, q11, q8
	DCD	0xf30200d0 ;	vqadd.u8	q0, q9, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf480083d ;	vst1.32	{d0[0]}, [r0 :32]!
	DCD	0xe24cc001 ;	sub	ip, ip, #1
	DCD	0xf25aa8ea ;	vadd.i16	q13, q13, q13
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xe35c0002 ;	cmp	ip, #2
	DCD	0xba000036 ;	blt	1ed8 <pixman_scaled_bilinear_scanline_8888_8_8888_OVER_asm_neon+0x1dc>
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a000034 ;	beq	1ed8 <pixman_scaled_bilinear_scanline_8888_8_8888_OVER_asm_neon+0x1dc>
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4240783 ;	vld1.32	{d0}, [r4], r3
	DCD	0xf424178f ;	vld1.32	{d1}, [r4]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4644783 ;	vld1.32	{d20}, [r4], r3
	DCD	0xf464578f ;	vld1.32	{d21}, [r4]
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xf4a1440d ;	vld1.16	{d4[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf460278f ;	vld1.32	{d18}, [r0]
	DCD	0xf5d0f070 ;	pld	[r0, #112]	; 0x70
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3d84a36 ;	vshll.u16	d20, q11, #8
	DCD	0xf3d64aaf ;	vmlsl.u16	q10, d22, d31
	DCD	0xf3d748af ;	vmlal.u16	q10, d23, d31
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf3b24c04 ;	vdup.16	d4, d4[0]
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3806c04 ;	vmull.u8	q3, d0, d4
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3840486 ;	vraddhn.i16	d0, q10, q3
	DCD	0xf38614a0 ;	vraddhn.i16	d1, q11, q8
	DCD	0xf3bc5c01 ;	vdup.32	d5, d1[1]
	DCD	0xf3b05585 ;	vmvn	d5, d5
	DCD	0xf3826c85 ;	vmull.u8	q3, d18, d5
	DCD	0xf3c30c85 ;	vmull.u8	q8, d19, d5
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3c42486 ;	vraddhn.i16	d18, q10, q3
	DCD	0xf3c634a0 ;	vraddhn.i16	d19, q11, q8
	DCD	0xf30200d0 ;	vqadd.u8	q0, q9, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf400078d ;	vst1.32	{d0}, [r0]!
	DCD	0xe24cc002 ;	sub	ip, ip, #2
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xba0000a1 ;	blt	2168 <pixman_scaled_bilinear_scanline_8888_8_8888_OVER_asm_neon+0x46c>
	DCD	0xe1a08748 ;	asr	r8, r8, #14
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4240783 ;	vld1.32	{d0}, [r4], r3
	DCD	0xe1a05846 ;	asr	r5, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf424178f ;	vld1.32	{d1}, [r4]
	DCD	0xe1a09846 ;	asr	r9, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0829109 ;	add	r9, r2, r9, lsl #2
	DCD	0xf4252783 ;	vld1.32	{d2}, [r5], r3
	DCD	0xe1a0a846 ;	asr	sl, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe082a10a ;	add	sl, r2, sl, lsl #2
	DCD	0xf425378f ;	vld1.32	{d3}, [r5]
	DCD	0xf3804c2c ;	vmull.u8	q2, d0, d28
	DCD	0xf3826c2c ;	vmull.u8	q3, d2, d28
	DCD	0xf381482d ;	vmlal.u8	q2, d1, d29
	DCD	0xf383682d ;	vmlal.u8	q3, d3, d29
	DCD	0xf3980a14 ;	vshll.u16	d0, q2, #8
	DCD	0xf3982a16 ;	vshll.u16	d2, q3, #8
	DCD	0xf3940a2e ;	vmlsl.u16	q0, d4, d30
	DCD	0xf3962a2f ;	vmlsl.u16	q1, d6, d31
	DCD	0xf395082e ;	vmlal.u16	q0, d5, d30
	DCD	0xf397282f ;	vmlal.u16	q1, d7, d31
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901812 ;	vshrn.i32	d1, q1, #16
	DCD	0xf4292783 ;	vld1.32	{d2}, [r9], r3
	DCD	0xf429378f ;	vld1.32	{d3}, [r9]
	DCD	0xf7daf008 ;	pld	[sl, r8]
	DCD	0xf42a4783 ;	vld1.32	{d4}, [sl], r3
	DCD	0xf42a578f ;	vld1.32	{d5}, [sl]
	DCD	0xf7daf008 ;	pld	[sl, r8]
	DCD	0xf3826c2c ;	vmull.u8	q3, d2, d28
	DCD	0xf383682d ;	vmlal.u8	q3, d3, d29
	DCD	0xf3842c2c ;	vmull.u8	q1, d4, d28
	DCD	0xf385282d ;	vmlal.u8	q1, d5, d29
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf4e1680d ;	vld1.32	{d22[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3f20200 ;	vmovn.i16	d16, q0
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xba00004f ;	blt	20d8 <pixman_scaled_bilinear_scanline_8888_8_8888_OVER_asm_neon+0x3dc>
	DCD	0xf3d82a16 ;	vshll.u16	d18, q3, #8
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf3d84a12 ;	vshll.u16	d20, q1, #8
	DCD	0xf4240783 ;	vld1.32	{d0}, [r4], r3
	DCD	0xe1a05846 ;	asr	r5, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0825105 ;	add	r5, r2, r5, lsl #2
	DCD	0xf3d62a2e ;	vmlsl.u16	q9, d6, d30
	DCD	0xf3d24a2f ;	vmlsl.u16	q10, d2, d31
	DCD	0xf424178f ;	vld1.32	{d1}, [r4]
	DCD	0xe1a09846 ;	asr	r9, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0829109 ;	add	r9, r2, r9, lsl #2
	DCD	0xf3d7282e ;	vmlal.u16	q9, d7, d30
	DCD	0xf3d3482f ;	vmlal.u16	q10, d3, d31
	DCD	0xf4252783 ;	vld1.32	{d2}, [r5], r3
	DCD	0xe1a0a846 ;	asr	sl, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe082a10a ;	add	sl, r2, sl, lsl #2
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf425378f ;	vld1.32	{d3}, [r5]
	DCD	0xf3f46c26 ;	vdup.32	d22, d22[0]
	DCD	0xf2d02832 ;	vshrn.i32	d18, q9, #16
	DCD	0xf2d03834 ;	vshrn.i32	d19, q10, #16
	DCD	0xf3804c2c ;	vmull.u8	q2, d0, d28
	DCD	0xf3826c2c ;	vmull.u8	q3, d2, d28
	DCD	0xf3f21222 ;	vmovn.i16	d17, q9
	DCD	0xf4602aaf ;	vld1.32	{d18-d19}, [r0 :128]
	DCD	0xf5d0f070 ;	pld	[r0, #112]	; 0x70
	DCD	0xf381482d ;	vmlal.u8	q2, d1, d29
	DCD	0xf383682d ;	vmlal.u8	q3, d3, d29
	DCD	0xf3f20121 ;	vuzp.8	d16, d17
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3980a14 ;	vshll.u16	d0, q2, #8
	DCD	0xf3982a16 ;	vshll.u16	d2, q3, #8
	DCD	0xf3f20121 ;	vuzp.8	d16, d17
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3940a2e ;	vmlsl.u16	q0, d4, d30
	DCD	0xf3962a2f ;	vmlsl.u16	q1, d6, d31
	DCD	0xf3c04ca6 ;	vmull.u8	q10, d16, d22
	DCD	0xf3c16ca6 ;	vmull.u8	q11, d17, d22
	DCD	0xf395082e ;	vmlal.u16	q0, d5, d30
	DCD	0xf397282f ;	vmlal.u16	q1, d7, d31
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901812 ;	vshrn.i32	d1, q1, #16
	DCD	0xf2c80874 ;	vrshrn.i16	d16, q10, #8
	DCD	0xf2c81876 ;	vrshrn.i16	d17, q11, #8
	DCD	0xf4292783 ;	vld1.32	{d2}, [r9], r3
	DCD	0xf3fc6c21 ;	vdup.32	d22, d17[1]
	DCD	0xf429378f ;	vld1.32	{d3}, [r9]
	DCD	0xf3f065a6 ;	vmvn	d22, d22
	DCD	0xf7daf008 ;	pld	[sl, r8]
	DCD	0xf42a4783 ;	vld1.32	{d4}, [sl], r3
	DCD	0xf3c24ca6 ;	vmull.u8	q10, d18, d22
	DCD	0xf3c36ca6 ;	vmull.u8	q11, d19, d22
	DCD	0xf42a578f ;	vld1.32	{d5}, [sl]
	DCD	0xf7daf008 ;	pld	[sl, r8]
	DCD	0xf3826c2c ;	vmull.u8	q3, d2, d28
	DCD	0xf3d82274 ;	vrshr.u16	q9, q10, #8
	DCD	0xf3d8e276 ;	vrshr.u16	q15, q11, #8
	DCD	0xf383682d ;	vmlal.u8	q3, d3, d29
	DCD	0xf3842c2c ;	vmull.u8	q1, d4, d28
	DCD	0xf3c224a4 ;	vraddhn.i16	d18, q9, q10
	DCD	0xf3ce34a6 ;	vraddhn.i16	d19, q15, q11
	DCD	0xf385282d ;	vmlal.u8	q1, d5, d29
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf34020f2 ;	vqadd.u8	q9, q8, q9
	DCD	0xf4e1680d ;	vld1.32	{d22[0]}, [r1]!
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3f20200 ;	vmovn.i16	d16, q0
	DCD	0xf4402aad ;	vst1.32	{d18-d19}, [r0 :128]!
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xaaffffaf ;	bge	1f98 <pixman_scaled_bilinear_scanline_8888_8_8888_OVER_asm_neon+0x29c>
	DCD	0xf3d82a16 ;	vshll.u16	d18, q3, #8
	DCD	0xf3d84a12 ;	vshll.u16	d20, q1, #8
	DCD	0xf3d62a2e ;	vmlsl.u16	q9, d6, d30
	DCD	0xf3d24a2f ;	vmlsl.u16	q10, d2, d31
	DCD	0xf3d7282e ;	vmlal.u16	q9, d7, d30
	DCD	0xf3d3482f ;	vmlal.u16	q10, d3, d31
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3f46c26 ;	vdup.32	d22, d22[0]
	DCD	0xf2d02832 ;	vshrn.i32	d18, q9, #16
	DCD	0xf2d03834 ;	vshrn.i32	d19, q10, #16
	DCD	0xf3f21222 ;	vmovn.i16	d17, q9
	DCD	0xf4602aaf ;	vld1.32	{d18-d19}, [r0 :128]
	DCD	0xf7d0f008 ;	pld	[r0, r8]
	DCD	0xf3f20121 ;	vuzp.8	d16, d17
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3f20121 ;	vuzp.8	d16, d17
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3c04ca6 ;	vmull.u8	q10, d16, d22
	DCD	0xf3c16ca6 ;	vmull.u8	q11, d17, d22
	DCD	0xf3d84374 ;	vrsra.u16	q10, q10, #8
	DCD	0xf3d86376 ;	vrsra.u16	q11, q11, #8
	DCD	0xf2c80874 ;	vrshrn.i16	d16, q10, #8
	DCD	0xf2c81876 ;	vrshrn.i16	d17, q11, #8
	DCD	0xf3fc6c21 ;	vdup.32	d22, d17[1]
	DCD	0xf3f065a6 ;	vmvn	d22, d22
	DCD	0xf3c24ca6 ;	vmull.u8	q10, d18, d22
	DCD	0xf3c36ca6 ;	vmull.u8	q11, d19, d22
	DCD	0xf3d82274 ;	vrshr.u16	q9, q10, #8
	DCD	0xf3980276 ;	vrshr.u16	q0, q11, #8
	DCD	0xf3c224a4 ;	vraddhn.i16	d18, q9, q10
	DCD	0xf3c03426 ;	vraddhn.i16	d19, q0, q11
	DCD	0xf34020f2 ;	vqadd.u8	q9, q8, q9
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf4402aad ;	vst1.32	{d18-d19}, [r0 :128]!
	DCD	0xe31c0002 ;	tst	ip, #2
	DCD	0x0a000033 ;	beq	2240 <pixman_scaled_bilinear_scanline_8888_8_8888_OVER_asm_neon+0x544>
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4240783 ;	vld1.32	{d0}, [r4], r3
	DCD	0xf424178f ;	vld1.32	{d1}, [r4]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4644783 ;	vld1.32	{d20}, [r4], r3
	DCD	0xf464578f ;	vld1.32	{d21}, [r4]
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xf4a1440d ;	vld1.16	{d4[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf460278f ;	vld1.32	{d18}, [r0]
	DCD	0xf5d0f070 ;	pld	[r0, #112]	; 0x70
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3d84a36 ;	vshll.u16	d20, q11, #8
	DCD	0xf3d64aaf ;	vmlsl.u16	q10, d22, d31
	DCD	0xf3d748af ;	vmlal.u16	q10, d23, d31
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf3b24c04 ;	vdup.16	d4, d4[0]
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3806c04 ;	vmull.u8	q3, d0, d4
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3840486 ;	vraddhn.i16	d0, q10, q3
	DCD	0xf38614a0 ;	vraddhn.i16	d1, q11, q8
	DCD	0xf3bc5c01 ;	vdup.32	d5, d1[1]
	DCD	0xf3b05585 ;	vmvn	d5, d5
	DCD	0xf3826c85 ;	vmull.u8	q3, d18, d5
	DCD	0xf3c30c85 ;	vmull.u8	q8, d19, d5
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3c42486 ;	vraddhn.i16	d18, q10, q3
	DCD	0xf3c634a0 ;	vraddhn.i16	d19, q11, q8
	DCD	0xf30200d0 ;	vqadd.u8	q0, q9, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf400078d ;	vst1.32	{d0}, [r0]!
	DCD	0xe31c0001 ;	tst	ip, #1
	DCD	0x0a000026 ;	beq	22e4 <pixman_scaled_bilinear_scanline_8888_8_8888_OVER_asm_neon+0x5e8>
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4240783 ;	vld1.32	{d0}, [r4], r3
	DCD	0xf424178f ;	vld1.32	{d1}, [r4]
	DCD	0xf4a1400d ;	vld1.8	{d4[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf4e0280f ;	vld1.32	{d18[0]}, [r0]
	DCD	0xf5d0f070 ;	pld	[r0, #112]	; 0x70
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3b14c04 ;	vdup.8	d4, d4[0]
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3806c04 ;	vmull.u8	q3, d0, d4
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3840486 ;	vraddhn.i16	d0, q10, q3
	DCD	0xf38614a0 ;	vraddhn.i16	d1, q11, q8
	DCD	0xf3bc5c01 ;	vdup.32	d5, d1[1]
	DCD	0xf3b05585 ;	vmvn	d5, d5
	DCD	0xf3826c85 ;	vmull.u8	q3, d18, d5
	DCD	0xf3c30c85 ;	vmull.u8	q8, d19, d5
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3c42486 ;	vraddhn.i16	d18, q10, q3
	DCD	0xf3c634a0 ;	vraddhn.i16	d19, q11, q8
	DCD	0xf30200d0 ;	vqadd.u8	q0, q9, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf480083d ;	vst1.32	{d0[0]}, [r0 :32]!
	DCD	0xe8bd17f0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, ip}
	DCD	0xe12fff1e ;	bx	lr
	;		22e8: R_ARM_V4BX	*ABS*
	ENDP  ; |pixman_scaled_bilinear_scanline_8888_8_8888_OVER_asm_neon|

|pixman_scaled_bilinear_scanline_8888_8888_ADD_asm_neon| PROC
	DCD	0xe1a0c00d ;	mov	ip, sp
	DCD	0xe92d03f0 ;	push	{r4, r5, r6, r7, r8, r9}
	DCD	0xe3a0701c ;	mov	r7, #28
	DCD	0xe89c1070 ;	ldm	ip, {r4, r5, r6, ip}
	DCD	0xe0070697 ;	mul	r7, r7, r6
	DCD	0xe0422001 ;	sub	r2, r2, r1
	DCD	0xe35c0000 ;	cmp	ip, #0
	DCD	0xda0000ea ;	ble	26b8 <pixman_scaled_bilinear_scanline_8888_8888_ADD_asm_neon+0x3cc>
	DCD	0xeea85bb0 ;	vdup.16	q12, r5
	DCD	0xeeaa6bb0 ;	vdup.16	q13, r6
	DCD	0xeecc3b90 ;	vdup.8	d28, r3
	DCD	0xeecd4b90 ;	vdup.8	d29, r4
	DCD	0xf25998aa ;	vadd.i16	d25, d25, d26
	DCD	0xe35c0001 ;	cmp	ip, #1
	DCD	0xba000014 ;	blt	237c <pixman_scaled_bilinear_scanline_8888_8888_ADD_asm_neon+0x90>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000012 ;	beq	237c <pixman_scaled_bilinear_scanline_8888_8888_ADD_asm_neon+0x90>
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xf4230782 ;	vld1.32	{d0}, [r3], r2
	DCD	0xf423178f ;	vld1.32	{d1}, [r3]
	DCD	0xf4e0280f ;	vld1.32	{d18[0]}, [r0]
	DCD	0xf5d0f070 ;	pld	[r0, #112]	; 0x70
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf30200d0 ;	vqadd.u8	q0, q9, q0
	DCD	0xf480083d ;	vst1.32	{d0[0]}, [r0 :32]!
	DCD	0xe24cc001 ;	sub	ip, ip, #1
	DCD	0xf25aa8ea ;	vadd.i16	q13, q13, q13
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xe35c0002 ;	cmp	ip, #2
	DCD	0xba00001f ;	blt	2410 <pixman_scaled_bilinear_scanline_8888_8888_ADD_asm_neon+0x124>
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a00001d ;	beq	2410 <pixman_scaled_bilinear_scanline_8888_8888_ADD_asm_neon+0x124>
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
	DCD	0xf460278f ;	vld1.32	{d18}, [r0]
	DCD	0xf5d0f070 ;	pld	[r0, #112]	; 0x70
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
	DCD	0xf30200d0 ;	vqadd.u8	q0, q9, q0
	DCD	0xf400078d ;	vst1.32	{d0}, [r0]!
	DCD	0xe24cc002 ;	sub	ip, ip, #2
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xba000076 ;	blt	25f4 <pixman_scaled_bilinear_scanline_8888_8888_ADD_asm_neon+0x308>
	DCD	0xe1a07747 ;	asr	r7, r7, #14
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
	DCD	0xf4202a8f ;	vld1.32	{d2-d3}, [r0]
	DCD	0xf5d0f070 ;	pld	[r0, #112]	; 0x70
	DCD	0xf7d3f007 ;	pld	[r3, r7]
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
	DCD	0xf3020050 ;	vqadd.u8	q0, q1, q0
	DCD	0xf4000a8d ;	vst1.32	{d0-d1}, [r0]!
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xba00003a ;	blt	25f4 <pixman_scaled_bilinear_scanline_8888_8888_ADD_asm_neon+0x308>
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
	DCD	0xf4202a8f ;	vld1.32	{d2-d3}, [r0]
	DCD	0xf5d0f070 ;	pld	[r0, #112]	; 0x70
	DCD	0xf7d3f007 ;	pld	[r3, r7]
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
	DCD	0xf3020050 ;	vqadd.u8	q0, q1, q0
	DCD	0xf4000a8d ;	vst1.32	{d0-d1}, [r0]!
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xaaffffc4 ;	bge	2508 <pixman_scaled_bilinear_scanline_8888_8888_ADD_asm_neon+0x21c>
	DCD	0xe31c0002 ;	tst	ip, #2
	DCD	0x0a00001c ;	beq	2670 <pixman_scaled_bilinear_scanline_8888_8888_ADD_asm_neon+0x384>
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
	DCD	0xf460278f ;	vld1.32	{d18}, [r0]
	DCD	0xf5d0f070 ;	pld	[r0, #112]	; 0x70
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
	DCD	0xf30200d0 ;	vqadd.u8	q0, q9, q0
	DCD	0xf400078d ;	vst1.32	{d0}, [r0]!
	DCD	0xe31c0001 ;	tst	ip, #1
	DCD	0x0a00000f ;	beq	26b8 <pixman_scaled_bilinear_scanline_8888_8888_ADD_asm_neon+0x3cc>
	DCD	0xe1a03845 ;	asr	r3, r5, #16
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0813103 ;	add	r3, r1, r3, lsl #2
	DCD	0xf4230782 ;	vld1.32	{d0}, [r3], r2
	DCD	0xf423178f ;	vld1.32	{d1}, [r3]
	DCD	0xf4e0280f ;	vld1.32	{d18[0]}, [r0]
	DCD	0xf5d0f070 ;	pld	[r0, #112]	; 0x70
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf30200d0 ;	vqadd.u8	q0, q9, q0
	DCD	0xf480083d ;	vst1.32	{d0[0]}, [r0 :32]!
	DCD	0xe8bd03f0 ;	pop	{r4, r5, r6, r7, r8, r9}
	DCD	0xe12fff1e ;	bx	lr
	;		26bc: R_ARM_V4BX	*ABS*
	ENDP  ; |pixman_scaled_bilinear_scanline_8888_8888_ADD_asm_neon|

|pixman_scaled_bilinear_scanline_8888_8_8888_ADD_asm_neon| PROC
	DCD	0xe1a0c00d ;	mov	ip, sp
	DCD	0xe92d17f0 ;	push	{r4, r5, r6, r7, r8, r9, sl, ip}
	DCD	0xe3a0801c ;	mov	r8, #28
	DCD	0xe89c10f0 ;	ldm	ip, {r4, r5, r6, r7, ip}
	DCD	0xe0080798 ;	mul	r8, r8, r7
	DCD	0xe0433002 ;	sub	r3, r3, r2
	DCD	0xe35c0000 ;	cmp	ip, #0
	DCD	0xda000144 ;	ble	2bf4 <pixman_scaled_bilinear_scanline_8888_8_8888_ADD_asm_neon+0x534>
	DCD	0xeea86bb0 ;	vdup.16	q12, r6
	DCD	0xeeaa7bb0 ;	vdup.16	q13, r7
	DCD	0xeecc4b90 ;	vdup.8	d28, r4
	DCD	0xeecd5b90 ;	vdup.8	d29, r5
	DCD	0xf25998aa ;	vadd.i16	d25, d25, d26
	DCD	0xe35c0001 ;	cmp	ip, #1
	DCD	0xba000023 ;	blt	278c <pixman_scaled_bilinear_scanline_8888_8_8888_ADD_asm_neon+0xcc>
	DCD	0xe3100004 ;	tst	r0, #4
	DCD	0x0a000021 ;	beq	278c <pixman_scaled_bilinear_scanline_8888_8_8888_ADD_asm_neon+0xcc>
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4240783 ;	vld1.32	{d0}, [r4], r3
	DCD	0xf424178f ;	vld1.32	{d1}, [r4]
	DCD	0xf4a1400d ;	vld1.8	{d4[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf4e0280f ;	vld1.32	{d18[0]}, [r0]
	DCD	0xf5d0f070 ;	pld	[r0, #112]	; 0x70
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3b14c04 ;	vdup.8	d4, d4[0]
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3806c04 ;	vmull.u8	q3, d0, d4
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3840486 ;	vraddhn.i16	d0, q10, q3
	DCD	0xf38614a0 ;	vraddhn.i16	d1, q11, q8
	DCD	0xf30200d0 ;	vqadd.u8	q0, q9, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf480083d ;	vst1.32	{d0[0]}, [r0 :32]!
	DCD	0xe24cc001 ;	sub	ip, ip, #1
	DCD	0xf25aa8ea ;	vadd.i16	q13, q13, q13
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xe35c0002 ;	cmp	ip, #2
	DCD	0xba00002e ;	blt	285c <pixman_scaled_bilinear_scanline_8888_8_8888_ADD_asm_neon+0x19c>
	DCD	0xe3100008 ;	tst	r0, #8
	DCD	0x0a00002c ;	beq	285c <pixman_scaled_bilinear_scanline_8888_8_8888_ADD_asm_neon+0x19c>
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4240783 ;	vld1.32	{d0}, [r4], r3
	DCD	0xf424178f ;	vld1.32	{d1}, [r4]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4644783 ;	vld1.32	{d20}, [r4], r3
	DCD	0xf464578f ;	vld1.32	{d21}, [r4]
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xf4a1440d ;	vld1.16	{d4[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf460278f ;	vld1.32	{d18}, [r0]
	DCD	0xf5d0f070 ;	pld	[r0, #112]	; 0x70
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3d84a36 ;	vshll.u16	d20, q11, #8
	DCD	0xf3d64aaf ;	vmlsl.u16	q10, d22, d31
	DCD	0xf3d748af ;	vmlal.u16	q10, d23, d31
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf3b24c04 ;	vdup.16	d4, d4[0]
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3806c04 ;	vmull.u8	q3, d0, d4
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3840486 ;	vraddhn.i16	d0, q10, q3
	DCD	0xf38614a0 ;	vraddhn.i16	d1, q11, q8
	DCD	0xf30200d0 ;	vqadd.u8	q0, q9, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf400078d ;	vst1.32	{d0}, [r0]!
	DCD	0xe24cc002 ;	sub	ip, ip, #2
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xba000094 ;	blt	2ab8 <pixman_scaled_bilinear_scanline_8888_8_8888_ADD_asm_neon+0x3f8>
	DCD	0xe1a08748 ;	asr	r8, r8, #14
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4240783 ;	vld1.32	{d0}, [r4], r3
	DCD	0xf424178f ;	vld1.32	{d1}, [r4]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4644783 ;	vld1.32	{d20}, [r4], r3
	DCD	0xf464578f ;	vld1.32	{d21}, [r4]
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4244783 ;	vld1.32	{d4}, [r4], r3
	DCD	0xf424578f ;	vld1.32	{d5}, [r4]
	DCD	0xf3846c2c ;	vmull.u8	q3, d4, d28
	DCD	0xf385682d ;	vmlal.u8	q3, d5, d29
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4640783 ;	vld1.32	{d16}, [r4], r3
	DCD	0xf464178f ;	vld1.32	{d17}, [r4]
	DCD	0xf3c02cac ;	vmull.u8	q9, d16, d28
	DCD	0xf3c128ad ;	vmlal.u8	q9, d17, d29
	DCD	0xf7d4f008 ;	pld	[r4, r8]
	DCD	0xe0444003 ;	sub	r4, r4, r3
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
	DCD	0xf4e1680d ;	vld1.32	{d22[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf4202a8f ;	vld1.32	{d2-d3}, [r0]
	DCD	0xf5d0f070 ;	pld	[r0, #112]	; 0x70
	DCD	0xf7d4f008 ;	pld	[r4, r8]
	DCD	0xf3d20aaf ;	vmlsl.u16	q8, d18, d31
	DCD	0xf3d308af ;	vmlal.u16	q8, d19, d31
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf2904814 ;	vshrn.i32	d4, q2, #16
	DCD	0xf2905830 ;	vshrn.i32	d5, q8, #16
	DCD	0xf3f46c26 ;	vdup.32	d22, d22[0]
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b21204 ;	vmovn.i16	d1, q2
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3806c26 ;	vmull.u8	q3, d0, d22
	DCD	0xf3c10c26 ;	vmull.u8	q8, d1, d22
	DCD	0xf3d82256 ;	vrshr.u16	q9, q3, #8
	DCD	0xf3d84270 ;	vrshr.u16	q10, q8, #8
	DCD	0xf3820486 ;	vraddhn.i16	d0, q9, q3
	DCD	0xf38414a0 ;	vraddhn.i16	d1, q10, q8
	DCD	0xf3020050 ;	vqadd.u8	q0, q1, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf4000a8d ;	vst1.32	{d0-d1}, [r0]!
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xba000049 ;	blt	2ab8 <pixman_scaled_bilinear_scanline_8888_8_8888_ADD_asm_neon+0x3f8>
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4240783 ;	vld1.32	{d0}, [r4], r3
	DCD	0xf424178f ;	vld1.32	{d1}, [r4]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4644783 ;	vld1.32	{d20}, [r4], r3
	DCD	0xf464578f ;	vld1.32	{d21}, [r4]
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4244783 ;	vld1.32	{d4}, [r4], r3
	DCD	0xf424578f ;	vld1.32	{d5}, [r4]
	DCD	0xf3846c2c ;	vmull.u8	q3, d4, d28
	DCD	0xf385682d ;	vmlal.u8	q3, d5, d29
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4640783 ;	vld1.32	{d16}, [r4], r3
	DCD	0xf464178f ;	vld1.32	{d17}, [r4]
	DCD	0xf3c02cac ;	vmull.u8	q9, d16, d28
	DCD	0xf3c128ad ;	vmlal.u8	q9, d17, d29
	DCD	0xf7d4f008 ;	pld	[r4, r8]
	DCD	0xe0444003 ;	sub	r4, r4, r3
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
	DCD	0xf4e1680d ;	vld1.32	{d22[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf4202a8f ;	vld1.32	{d2-d3}, [r0]
	DCD	0xf5d0f070 ;	pld	[r0, #112]	; 0x70
	DCD	0xf7d4f008 ;	pld	[r4, r8]
	DCD	0xf3d20aaf ;	vmlsl.u16	q8, d18, d31
	DCD	0xf3d308af ;	vmlal.u16	q8, d19, d31
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf2904814 ;	vshrn.i32	d4, q2, #16
	DCD	0xf2905830 ;	vshrn.i32	d5, q8, #16
	DCD	0xf3f46c26 ;	vdup.32	d22, d22[0]
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b21204 ;	vmovn.i16	d1, q2
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b22103 ;	vuzp.8	d2, d3
	DCD	0xf3806c26 ;	vmull.u8	q3, d0, d22
	DCD	0xf3c10c26 ;	vmull.u8	q8, d1, d22
	DCD	0xf3d82256 ;	vrshr.u16	q9, q3, #8
	DCD	0xf3d84270 ;	vrshr.u16	q10, q8, #8
	DCD	0xf3820486 ;	vraddhn.i16	d0, q9, q3
	DCD	0xf38414a0 ;	vraddhn.i16	d1, q10, q8
	DCD	0xf3020050 ;	vqadd.u8	q0, q1, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf4000a8d ;	vst1.32	{d0-d1}, [r0]!
	DCD	0xe25cc004 ;	subs	ip, ip, #4
	DCD	0xaaffffb5 ;	bge	2990 <pixman_scaled_bilinear_scanline_8888_8_8888_ADD_asm_neon+0x2d0>
	DCD	0xe31c0002 ;	tst	ip, #2
	DCD	0x0a00002b ;	beq	2b70 <pixman_scaled_bilinear_scanline_8888_8_8888_ADD_asm_neon+0x4b0>
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4240783 ;	vld1.32	{d0}, [r4], r3
	DCD	0xf424178f ;	vld1.32	{d1}, [r4]
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4644783 ;	vld1.32	{d20}, [r4], r3
	DCD	0xf464578f ;	vld1.32	{d21}, [r4]
	DCD	0xf3c46cac ;	vmull.u8	q11, d20, d28
	DCD	0xf3c568ad ;	vmlal.u8	q11, d21, d29
	DCD	0xf4a1440d ;	vld1.16	{d4[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf460278f ;	vld1.32	{d18}, [r0]
	DCD	0xf5d0f070 ;	pld	[r0, #112]	; 0x70
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3d84a36 ;	vshll.u16	d20, q11, #8
	DCD	0xf3d64aaf ;	vmlsl.u16	q10, d22, d31
	DCD	0xf3d748af ;	vmlal.u16	q10, d23, d31
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf2901834 ;	vshrn.i32	d1, q10, #16
	DCD	0xf3b24c04 ;	vdup.16	d4, d4[0]
	DCD	0xf3d8e078 ;	vshr.u16	q15, q12, #8
	DCD	0xf25888ea ;	vadd.i16	q12, q12, q13
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3806c04 ;	vmull.u8	q3, d0, d4
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3840486 ;	vraddhn.i16	d0, q10, q3
	DCD	0xf38614a0 ;	vraddhn.i16	d1, q11, q8
	DCD	0xf30200d0 ;	vqadd.u8	q0, q9, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf400078d ;	vst1.32	{d0}, [r0]!
	DCD	0xe31c0001 ;	tst	ip, #1
	DCD	0x0a00001e ;	beq	2bf4 <pixman_scaled_bilinear_scanline_8888_8_8888_ADD_asm_neon+0x534>
	DCD	0xe1a04846 ;	asr	r4, r6, #16
	DCD	0xe0866007 ;	add	r6, r6, r7
	DCD	0xe0824104 ;	add	r4, r2, r4, lsl #2
	DCD	0xf4240783 ;	vld1.32	{d0}, [r4], r3
	DCD	0xf424178f ;	vld1.32	{d1}, [r4]
	DCD	0xf4a1400d ;	vld1.8	{d4[0]}, [r1]!
	DCD	0xf5d1f01c ;	pld	[r1, #28]
	DCD	0xf4e0280f ;	vld1.32	{d18[0]}, [r0]
	DCD	0xf5d0f070 ;	pld	[r0, #112]	; 0x70
	DCD	0xf3802c2c ;	vmull.u8	q1, d0, d28
	DCD	0xf381282d ;	vmlal.u8	q1, d1, d29
	DCD	0xf3980a12 ;	vshll.u16	d0, q1, #8
	DCD	0xf3920a2e ;	vmlsl.u16	q0, d2, d30
	DCD	0xf393082e ;	vmlal.u16	q0, d3, d30
	DCD	0xf3b14c04 ;	vdup.8	d4, d4[0]
	DCD	0xf2900810 ;	vshrn.i32	d0, q0, #16
	DCD	0xf3b20200 ;	vmovn.i16	d0, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3f22123 ;	vuzp.8	d18, d19
	DCD	0xf3806c04 ;	vmull.u8	q3, d0, d4
	DCD	0xf3c10c04 ;	vmull.u8	q8, d1, d4
	DCD	0xf3d84256 ;	vrshr.u16	q10, q3, #8
	DCD	0xf3d86270 ;	vrshr.u16	q11, q8, #8
	DCD	0xf3840486 ;	vraddhn.i16	d0, q10, q3
	DCD	0xf38614a0 ;	vraddhn.i16	d1, q11, q8
	DCD	0xf30200d0 ;	vqadd.u8	q0, q9, q0
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf3b20101 ;	vuzp.8	d0, d1
	DCD	0xf480083d ;	vst1.32	{d0[0]}, [r0 :32]!
	DCD	0xe8bd17f0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, ip}
	DCD	0xe12fff1e ;	bx	lr
	;		2bf8: R_ARM_V4BX	*ABS*
	ENDP  ; |pixman_scaled_bilinear_scanline_8888_8_8888_ADD_asm_neon|

	END
