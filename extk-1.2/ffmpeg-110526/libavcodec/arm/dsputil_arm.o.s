	CODE32

	IMPORT	|ff_ac3_bin_to_band_tab|
	IMPORT	|ff_ac3_band_start_tab|
	IMPORT	|memset|

	EXPORT	|ff_prefetch_arm|
	EXPORT	|ff_put_pixels16_arm|
	EXPORT	|ff_put_pixels8_arm|
	EXPORT	|ff_put_pixels8_x2_arm|
	EXPORT	|ff_put_no_rnd_pixels8_x2_arm|
	EXPORT	|ff_put_pixels8_y2_arm|
	EXPORT	|ff_put_no_rnd_pixels8_y2_arm|
	EXPORT	|ff_put_pixels8_xy2_arm|
	EXPORT	|ff_put_no_rnd_pixels8_xy2_arm|
	EXPORT	|ff_add_pixels_clamped_arm|

	AREA	|.text|, CODE, ARM
|ff_prefetch_arm| PROC
	DCD	0xe2522001 ;	subs	r2, r2, #1
	DCD	0xf5d0f000 ;	pld	[r0]
	DCD	0xe0800001 ;	add	r0, r0, r1
	bne	|ff_prefetch_arm|
;	DCD	0x1afffffe ;	bne	0 <ff_prefetch_arm>
;	c: R_ARM_JUMP24	ff_prefetch_arm
	DCD	0xe12fff1e ;	bx	lr
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	ENDP  ; |ff_prefetch_arm|

|ff_put_pixels16_arm| PROC
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe92d4ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, lr}
	DCD	0xe2115003 ;	ands	r5, r1, #3
	DCD	0xe3c11003 ;	bic	r1, r1, #3
	DCD	0x0a000004 ;	beq	48 <ff_put_pixels16_arm+0x28>
	DCD	0xe2555001 ;	subs	r5, r5, #1
	DCD	0x0a000010 ;	beq	80 <ff_put_pixels16_arm+0x60>
	DCD	0xe2555001 ;	subs	r5, r5, #1
	DCD	0x0a00001e ;	beq	c0 <ff_put_pixels16_arm+0xa0>
	DCD	0xea00002d ;	b	100 <ff_put_pixels16_arm+0xe0>
	DCD	0xe89100f0 ;	ldm	r1, {r4, r5, r6, r7}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xe88000f0 ;	stm	r0, {r4, r5, r6, r7}
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0x1afffff8 ;	bne	48 <ff_put_pixels16_arm+0x28>
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe89101f0 ;	ldm	r1, {r4, r5, r6, r7, r8}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xe1a09424 ;	lsr	r9, r4, #8
	DCD	0xe1a0a425 ;	lsr	sl, r5, #8
	DCD	0xe1a0b426 ;	lsr	fp, r6, #8
	DCD	0xe1a0c427 ;	lsr	ip, r7, #8
	DCD	0xe1899c05 ;	orr	r9, r9, r5, lsl #24
	DCD	0xe18aac06 ;	orr	sl, sl, r6, lsl #24
	DCD	0xe18bbc07 ;	orr	fp, fp, r7, lsl #24
	DCD	0xe18ccc08 ;	orr	ip, ip, r8, lsl #24
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe8801e00 ;	stm	r0, {r9, sl, fp, ip}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0x1afffff0 ;	bne	80 <ff_put_pixels16_arm+0x60>
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	DCD	0xe89101f0 ;	ldm	r1, {r4, r5, r6, r7, r8}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xe1a09824 ;	lsr	r9, r4, #16
	DCD	0xe1a0a825 ;	lsr	sl, r5, #16
	DCD	0xe1a0b826 ;	lsr	fp, r6, #16
	DCD	0xe1a0c827 ;	lsr	ip, r7, #16
	DCD	0xe1899805 ;	orr	r9, r9, r5, lsl #16
	DCD	0xe18aa806 ;	orr	sl, sl, r6, lsl #16
	DCD	0xe18bb807 ;	orr	fp, fp, r7, lsl #16
	DCD	0xe18cc808 ;	orr	ip, ip, r8, lsl #16
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe8801e00 ;	stm	r0, {r9, sl, fp, ip}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0x1afffff0 ;	bne	c0 <ff_put_pixels16_arm+0xa0>
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	DCD	0xe89101f0 ;	ldm	r1, {r4, r5, r6, r7, r8}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xe1a09c24 ;	lsr	r9, r4, #24
	DCD	0xe1a0ac25 ;	lsr	sl, r5, #24
	DCD	0xe1a0bc26 ;	lsr	fp, r6, #24
	DCD	0xe1a0cc27 ;	lsr	ip, r7, #24
	DCD	0xe1899405 ;	orr	r9, r9, r5, lsl #8
	DCD	0xe18aa406 ;	orr	sl, sl, r6, lsl #8
	DCD	0xe18bb407 ;	orr	fp, fp, r7, lsl #8
	DCD	0xe18cc408 ;	orr	ip, ip, r8, lsl #8
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe8801e00 ;	stm	r0, {r9, sl, fp, ip}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0x1afffff0 ;	bne	100 <ff_put_pixels16_arm+0xe0>
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	ENDP  ; |ff_put_pixels16_arm|

|ff_put_pixels8_arm| PROC
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe92d4030 ;	push	{r4, r5, lr}
	DCD	0xe2115003 ;	ands	r5, r1, #3
	DCD	0xe3c11003 ;	bic	r1, r1, #3
	DCD	0x0a000004 ;	beq	168 <ff_put_pixels8_arm+0x28>
	DCD	0xe2555001 ;	subs	r5, r5, #1
	DCD	0x0a000010 ;	beq	1a0 <ff_put_pixels8_arm+0x60>
	DCD	0xe2555001 ;	subs	r5, r5, #1
	DCD	0x0a00001e ;	beq	1e0 <ff_put_pixels8_arm+0xa0>
	DCD	0xea00002d ;	b	220 <ff_put_pixels8_arm+0xe0>
	DCD	0xe8910030 ;	ldm	r1, {r4, r5}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe8800030 ;	stm	r0, {r4, r5}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0x1afffff8 ;	bne	168 <ff_put_pixels8_arm+0x28>
	DCD	0xe8bd8030 ;	pop	{r4, r5, pc}
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe8911030 ;	ldm	r1, {r4, r5, ip}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xe1a04424 ;	lsr	r4, r4, #8
	DCD	0xe1844c05 ;	orr	r4, r4, r5, lsl #24
	DCD	0xe1a05425 ;	lsr	r5, r5, #8
	DCD	0xe1855c0c ;	orr	r5, r5, ip, lsl #24
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe8800030 ;	stm	r0, {r4, r5}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0x1afffff4 ;	bne	1a0 <ff_put_pixels8_arm+0x60>
	DCD	0xe8bd8030 ;	pop	{r4, r5, pc}
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe8911030 ;	ldm	r1, {r4, r5, ip}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xe1a04824 ;	lsr	r4, r4, #16
	DCD	0xe1844805 ;	orr	r4, r4, r5, lsl #16
	DCD	0xe1a05825 ;	lsr	r5, r5, #16
	DCD	0xe185580c ;	orr	r5, r5, ip, lsl #16
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe8800030 ;	stm	r0, {r4, r5}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0x1afffff4 ;	bne	1e0 <ff_put_pixels8_arm+0xa0>
	DCD	0xe8bd8030 ;	pop	{r4, r5, pc}
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe8911030 ;	ldm	r1, {r4, r5, ip}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xe1a04c24 ;	lsr	r4, r4, #24
	DCD	0xe1844405 ;	orr	r4, r4, r5, lsl #8
	DCD	0xe1a05c25 ;	lsr	r5, r5, #24
	DCD	0xe185540c ;	orr	r5, r5, ip, lsl #8
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe8800030 ;	stm	r0, {r4, r5}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0x1afffff4 ;	bne	220 <ff_put_pixels8_arm+0xe0>
	DCD	0xe8bd8030 ;	pop	{r4, r5, pc}
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	ENDP  ; |ff_put_pixels8_arm|

|ff_put_pixels8_x2_arm| PROC
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe92d47f0 ;	push	{r4, r5, r6, r7, r8, r9, sl, lr}
	DCD	0xe59fc920 ;	ldr	ip, [pc, #2336]	; b90 <ff_put_no_rnd_pixels8_y2_arm+0x2f0>
	DCD	0xe2115003 ;	ands	r5, r1, #3
	DCD	0xe3c11003 ;	bic	r1, r1, #3
	DCD	0x0a000004 ;	beq	28c <ff_put_pixels8_x2_arm+0x2c>
	DCD	0xe2555001 ;	subs	r5, r5, #1
	DCD	0x0a000017 ;	beq	2e0 <ff_put_pixels8_x2_arm+0x80>
	DCD	0xe2555001 ;	subs	r5, r5, #1
	DCD	0x0a00002d ;	beq	340 <ff_put_pixels8_x2_arm+0xe0>
	DCD	0xea000044 ;	b	3a0 <ff_put_pixels8_x2_arm+0x140>
	DCD	0xe8910430 ;	ldm	r1, {r4, r5, sl}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xe1a06424 ;	lsr	r6, r4, #8
	DCD	0xe1a07425 ;	lsr	r7, r5, #8
	DCD	0xe1866c05 ;	orr	r6, r6, r5, lsl #24
	DCD	0xe1877c0a ;	orr	r7, r7, sl, lsl #24
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe0248006 ;	eor	r8, r4, r6
	DCD	0xe0259007 ;	eor	r9, r5, r7
	DCD	0xe1844006 ;	orr	r4, r4, r6
	DCD	0xe1855007 ;	orr	r5, r5, r7
	DCD	0xe008800c ;	and	r8, r8, ip
	DCD	0xe009900c ;	and	r9, r9, ip
	DCD	0xe04480a8 ;	sub	r8, r4, r8, lsr #1
	DCD	0xe04590a9 ;	sub	r9, r5, r9, lsr #1
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe8800300 ;	stm	r0, {r8, r9}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0x1affffec ;	bne	28c <ff_put_pixels8_x2_arm+0x2c>
	DCD	0xe8bd87f0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, pc}
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe8910430 ;	ldm	r1, {r4, r5, sl}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xe1a06424 ;	lsr	r6, r4, #8
	DCD	0xe1a07425 ;	lsr	r7, r5, #8
	DCD	0xe1866c05 ;	orr	r6, r6, r5, lsl #24
	DCD	0xe1877c0a ;	orr	r7, r7, sl, lsl #24
	DCD	0xe1a08824 ;	lsr	r8, r4, #16
	DCD	0xe1a09825 ;	lsr	r9, r5, #16
	DCD	0xe1888805 ;	orr	r8, r8, r5, lsl #16
	DCD	0xe189980a ;	orr	r9, r9, sl, lsl #16
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe0264008 ;	eor	r4, r6, r8
	DCD	0xe0275009 ;	eor	r5, r7, r9
	DCD	0xe1866008 ;	orr	r6, r6, r8
	DCD	0xe1877009 ;	orr	r7, r7, r9
	DCD	0xe004400c ;	and	r4, r4, ip
	DCD	0xe005500c ;	and	r5, r5, ip
	DCD	0xe04640a4 ;	sub	r4, r6, r4, lsr #1
	DCD	0xe04750a5 ;	sub	r5, r7, r5, lsr #1
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe8800030 ;	stm	r0, {r4, r5}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0x1affffe8 ;	bne	2e0 <ff_put_pixels8_x2_arm+0x80>
	DCD	0xe8bd87f0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, pc}
	DCD	0xe8910430 ;	ldm	r1, {r4, r5, sl}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xe1a06824 ;	lsr	r6, r4, #16
	DCD	0xe1a07825 ;	lsr	r7, r5, #16
	DCD	0xe1866805 ;	orr	r6, r6, r5, lsl #16
	DCD	0xe187780a ;	orr	r7, r7, sl, lsl #16
	DCD	0xe1a08c24 ;	lsr	r8, r4, #24
	DCD	0xe1a09c25 ;	lsr	r9, r5, #24
	DCD	0xe1888405 ;	orr	r8, r8, r5, lsl #8
	DCD	0xe189940a ;	orr	r9, r9, sl, lsl #8
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe0264008 ;	eor	r4, r6, r8
	DCD	0xe0275009 ;	eor	r5, r7, r9
	DCD	0xe1866008 ;	orr	r6, r6, r8
	DCD	0xe1877009 ;	orr	r7, r7, r9
	DCD	0xe004400c ;	and	r4, r4, ip
	DCD	0xe005500c ;	and	r5, r5, ip
	DCD	0xe04640a4 ;	sub	r4, r6, r4, lsr #1
	DCD	0xe04750a5 ;	sub	r5, r7, r5, lsr #1
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe8800030 ;	stm	r0, {r4, r5}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0x1affffe8 ;	bne	340 <ff_put_pixels8_x2_arm+0xe0>
	DCD	0xe8bd87f0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, pc}
	DCD	0xe8910430 ;	ldm	r1, {r4, r5, sl}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xe1a06c24 ;	lsr	r6, r4, #24
	DCD	0xe1a07c25 ;	lsr	r7, r5, #24
	DCD	0xe1866405 ;	orr	r6, r6, r5, lsl #8
	DCD	0xe187740a ;	orr	r7, r7, sl, lsl #8
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe0268005 ;	eor	r8, r6, r5
	DCD	0xe027900a ;	eor	r9, r7, sl
	DCD	0xe1866005 ;	orr	r6, r6, r5
	DCD	0xe187700a ;	orr	r7, r7, sl
	DCD	0xe008800c ;	and	r8, r8, ip
	DCD	0xe009900c ;	and	r9, r9, ip
	DCD	0xe04680a8 ;	sub	r8, r6, r8, lsr #1
	DCD	0xe04790a9 ;	sub	r9, r7, r9, lsr #1
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe8800300 ;	stm	r0, {r8, r9}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0x1affffec ;	bne	3a0 <ff_put_pixels8_x2_arm+0x140>
	DCD	0xe8bd87f0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, pc}
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	ENDP  ; |ff_put_pixels8_x2_arm|

|ff_put_no_rnd_pixels8_x2_arm| PROC
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe92d47f0 ;	push	{r4, r5, r6, r7, r8, r9, sl, lr}
	DCD	0xe59fc780 ;	ldr	ip, [pc, #1920]	; b90 <ff_put_no_rnd_pixels8_y2_arm+0x2f0>
	DCD	0xe2115003 ;	ands	r5, r1, #3
	DCD	0xe3c11003 ;	bic	r1, r1, #3
	DCD	0x0a000004 ;	beq	42c <ff_put_no_rnd_pixels8_x2_arm+0x2c>
	DCD	0xe2555001 ;	subs	r5, r5, #1
	DCD	0x0a000017 ;	beq	480 <ff_put_no_rnd_pixels8_x2_arm+0x80>
	DCD	0xe2555001 ;	subs	r5, r5, #1
	DCD	0x0a00002d ;	beq	4e0 <ff_put_no_rnd_pixels8_x2_arm+0xe0>
	DCD	0xea000044 ;	b	540 <ff_put_no_rnd_pixels8_x2_arm+0x140>
	DCD	0xe8910430 ;	ldm	r1, {r4, r5, sl}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xe1a06424 ;	lsr	r6, r4, #8
	DCD	0xe1a07425 ;	lsr	r7, r5, #8
	DCD	0xe1866c05 ;	orr	r6, r6, r5, lsl #24
	DCD	0xe1877c0a ;	orr	r7, r7, sl, lsl #24
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe0248006 ;	eor	r8, r4, r6
	DCD	0xe0259007 ;	eor	r9, r5, r7
	DCD	0xe0044006 ;	and	r4, r4, r6
	DCD	0xe0055007 ;	and	r5, r5, r7
	DCD	0xe008800c ;	and	r8, r8, ip
	DCD	0xe009900c ;	and	r9, r9, ip
	DCD	0xe08480a8 ;	add	r8, r4, r8, lsr #1
	DCD	0xe08590a9 ;	add	r9, r5, r9, lsr #1
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe8800300 ;	stm	r0, {r8, r9}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0x1affffec ;	bne	42c <ff_put_no_rnd_pixels8_x2_arm+0x2c>
	DCD	0xe8bd87f0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, pc}
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe8910430 ;	ldm	r1, {r4, r5, sl}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xe1a06424 ;	lsr	r6, r4, #8
	DCD	0xe1a07425 ;	lsr	r7, r5, #8
	DCD	0xe1866c05 ;	orr	r6, r6, r5, lsl #24
	DCD	0xe1877c0a ;	orr	r7, r7, sl, lsl #24
	DCD	0xe1a08824 ;	lsr	r8, r4, #16
	DCD	0xe1a09825 ;	lsr	r9, r5, #16
	DCD	0xe1888805 ;	orr	r8, r8, r5, lsl #16
	DCD	0xe189980a ;	orr	r9, r9, sl, lsl #16
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe0264008 ;	eor	r4, r6, r8
	DCD	0xe0275009 ;	eor	r5, r7, r9
	DCD	0xe0066008 ;	and	r6, r6, r8
	DCD	0xe0077009 ;	and	r7, r7, r9
	DCD	0xe004400c ;	and	r4, r4, ip
	DCD	0xe005500c ;	and	r5, r5, ip
	DCD	0xe08640a4 ;	add	r4, r6, r4, lsr #1
	DCD	0xe08750a5 ;	add	r5, r7, r5, lsr #1
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe8800030 ;	stm	r0, {r4, r5}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0x1affffe8 ;	bne	480 <ff_put_no_rnd_pixels8_x2_arm+0x80>
	DCD	0xe8bd87f0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, pc}
	DCD	0xe8910430 ;	ldm	r1, {r4, r5, sl}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xe1a06824 ;	lsr	r6, r4, #16
	DCD	0xe1a07825 ;	lsr	r7, r5, #16
	DCD	0xe1866805 ;	orr	r6, r6, r5, lsl #16
	DCD	0xe187780a ;	orr	r7, r7, sl, lsl #16
	DCD	0xe1a08c24 ;	lsr	r8, r4, #24
	DCD	0xe1a09c25 ;	lsr	r9, r5, #24
	DCD	0xe1888405 ;	orr	r8, r8, r5, lsl #8
	DCD	0xe189940a ;	orr	r9, r9, sl, lsl #8
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe0264008 ;	eor	r4, r6, r8
	DCD	0xe0275009 ;	eor	r5, r7, r9
	DCD	0xe0066008 ;	and	r6, r6, r8
	DCD	0xe0077009 ;	and	r7, r7, r9
	DCD	0xe004400c ;	and	r4, r4, ip
	DCD	0xe005500c ;	and	r5, r5, ip
	DCD	0xe08640a4 ;	add	r4, r6, r4, lsr #1
	DCD	0xe08750a5 ;	add	r5, r7, r5, lsr #1
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe8800030 ;	stm	r0, {r4, r5}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0x1affffe8 ;	bne	4e0 <ff_put_no_rnd_pixels8_x2_arm+0xe0>
	DCD	0xe8bd87f0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, pc}
	DCD	0xe8910430 ;	ldm	r1, {r4, r5, sl}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xe1a06c24 ;	lsr	r6, r4, #24
	DCD	0xe1a07c25 ;	lsr	r7, r5, #24
	DCD	0xe1866405 ;	orr	r6, r6, r5, lsl #8
	DCD	0xe187740a ;	orr	r7, r7, sl, lsl #8
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe0268005 ;	eor	r8, r6, r5
	DCD	0xe027900a ;	eor	r9, r7, sl
	DCD	0xe0066005 ;	and	r6, r6, r5
	DCD	0xe007700a ;	and	r7, r7, sl
	DCD	0xe008800c ;	and	r8, r8, ip
	DCD	0xe009900c ;	and	r9, r9, ip
	DCD	0xe08680a8 ;	add	r8, r6, r8, lsr #1
	DCD	0xe08790a9 ;	add	r9, r7, r9, lsr #1
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe8800300 ;	stm	r0, {r8, r9}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0x1affffec ;	bne	540 <ff_put_no_rnd_pixels8_x2_arm+0x140>
	DCD	0xe8bd87f0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, pc}
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	ENDP  ; |ff_put_no_rnd_pixels8_x2_arm|

|ff_put_pixels8_y2_arm| PROC
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe92d4ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, lr}
	DCD	0xe1a030a3 ;	lsr	r3, r3, #1
	DCD	0xe59fc5dc ;	ldr	ip, [pc, #1500]	; b90 <ff_put_no_rnd_pixels8_y2_arm+0x2f0>
	DCD	0xe2115003 ;	ands	r5, r1, #3
	DCD	0xe3c11003 ;	bic	r1, r1, #3
	DCD	0x0a000004 ;	beq	5d0 <ff_put_pixels8_y2_arm+0x30>
	DCD	0xe2555001 ;	subs	r5, r5, #1
	DCD	0x0a000026 ;	beq	660 <ff_put_pixels8_y2_arm+0xc0>
	DCD	0xe2555001 ;	subs	r5, r5, #1
	DCD	0x0a000054 ;	beq	720 <ff_put_pixels8_y2_arm+0x180>
	DCD	0xea000083 ;	b	7e0 <ff_put_pixels8_y2_arm+0x240>
	DCD	0xe8910030 ;	ldm	r1, {r4, r5}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xe89100c0 ;	ldm	r1, {r6, r7}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe0248006 ;	eor	r8, r4, r6
	DCD	0xe0259007 ;	eor	r9, r5, r7
	DCD	0xe1844006 ;	orr	r4, r4, r6
	DCD	0xe1855007 ;	orr	r5, r5, r7
	DCD	0xe008800c ;	and	r8, r8, ip
	DCD	0xe009900c ;	and	r9, r9, ip
	DCD	0xe04480a8 ;	sub	r8, r4, r8, lsr #1
	DCD	0xe04590a9 ;	sub	r9, r5, r9, lsr #1
	DCD	0xe8910030 ;	ldm	r1, {r4, r5}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xe8800300 ;	stm	r0, {r8, r9}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe0268004 ;	eor	r8, r6, r4
	DCD	0xe0279005 ;	eor	r9, r7, r5
	DCD	0xe1866004 ;	orr	r6, r6, r4
	DCD	0xe1877005 ;	orr	r7, r7, r5
	DCD	0xe008800c ;	and	r8, r8, ip
	DCD	0xe009900c ;	and	r9, r9, ip
	DCD	0xe04680a8 ;	sub	r8, r6, r8, lsr #1
	DCD	0xe04790a9 ;	sub	r9, r7, r9, lsr #1
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe8800300 ;	stm	r0, {r8, r9}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0x1affffe3 ;	bne	5d8 <ff_put_pixels8_y2_arm+0x38>
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe8910070 ;	ldm	r1, {r4, r5, r6}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04424 ;	lsr	r4, r4, #8
	DCD	0xe1844c05 ;	orr	r4, r4, r5, lsl #24
	DCD	0xe1a05425 ;	lsr	r5, r5, #8
	DCD	0xe1855c06 ;	orr	r5, r5, r6, lsl #24
	DCD	0xe8910380 ;	ldm	r1, {r7, r8, r9}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a07427 ;	lsr	r7, r7, #8
	DCD	0xe1877c08 ;	orr	r7, r7, r8, lsl #24
	DCD	0xe1a08428 ;	lsr	r8, r8, #8
	DCD	0xe1888c09 ;	orr	r8, r8, r9, lsl #24
	DCD	0xe024a007 ;	eor	sl, r4, r7
	DCD	0xe025b008 ;	eor	fp, r5, r8
	DCD	0xe1844007 ;	orr	r4, r4, r7
	DCD	0xe1855008 ;	orr	r5, r5, r8
	DCD	0xe00aa00c ;	and	sl, sl, ip
	DCD	0xe00bb00c ;	and	fp, fp, ip
	DCD	0xe044a0aa ;	sub	sl, r4, sl, lsr #1
	DCD	0xe045b0ab ;	sub	fp, r5, fp, lsr #1
	DCD	0xe8800c00 ;	stm	r0, {sl, fp}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0xe8910070 ;	ldm	r1, {r4, r5, r6}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04424 ;	lsr	r4, r4, #8
	DCD	0xe1844c05 ;	orr	r4, r4, r5, lsl #24
	DCD	0xe1a05425 ;	lsr	r5, r5, #8
	DCD	0xe1855c06 ;	orr	r5, r5, r6, lsl #24
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe027a004 ;	eor	sl, r7, r4
	DCD	0xe028b005 ;	eor	fp, r8, r5
	DCD	0xe1877004 ;	orr	r7, r7, r4
	DCD	0xe1888005 ;	orr	r8, r8, r5
	DCD	0xe00aa00c ;	and	sl, sl, ip
	DCD	0xe00bb00c ;	and	fp, fp, ip
	DCD	0xe047a0aa ;	sub	sl, r7, sl, lsr #1
	DCD	0xe048b0ab ;	sub	fp, r8, fp, lsr #1
	DCD	0xe8800c00 ;	stm	r0, {sl, fp}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0x1affffdb ;	bne	67c <ff_put_pixels8_y2_arm+0xdc>
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe8910070 ;	ldm	r1, {r4, r5, r6}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04824 ;	lsr	r4, r4, #16
	DCD	0xe1844805 ;	orr	r4, r4, r5, lsl #16
	DCD	0xe1a05825 ;	lsr	r5, r5, #16
	DCD	0xe1855806 ;	orr	r5, r5, r6, lsl #16
	DCD	0xe8910380 ;	ldm	r1, {r7, r8, r9}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a07827 ;	lsr	r7, r7, #16
	DCD	0xe1877808 ;	orr	r7, r7, r8, lsl #16
	DCD	0xe1a08828 ;	lsr	r8, r8, #16
	DCD	0xe1888809 ;	orr	r8, r8, r9, lsl #16
	DCD	0xe024a007 ;	eor	sl, r4, r7
	DCD	0xe025b008 ;	eor	fp, r5, r8
	DCD	0xe1844007 ;	orr	r4, r4, r7
	DCD	0xe1855008 ;	orr	r5, r5, r8
	DCD	0xe00aa00c ;	and	sl, sl, ip
	DCD	0xe00bb00c ;	and	fp, fp, ip
	DCD	0xe044a0aa ;	sub	sl, r4, sl, lsr #1
	DCD	0xe045b0ab ;	sub	fp, r5, fp, lsr #1
	DCD	0xe8800c00 ;	stm	r0, {sl, fp}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0xe8910070 ;	ldm	r1, {r4, r5, r6}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04824 ;	lsr	r4, r4, #16
	DCD	0xe1844805 ;	orr	r4, r4, r5, lsl #16
	DCD	0xe1a05825 ;	lsr	r5, r5, #16
	DCD	0xe1855806 ;	orr	r5, r5, r6, lsl #16
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe027a004 ;	eor	sl, r7, r4
	DCD	0xe028b005 ;	eor	fp, r8, r5
	DCD	0xe1877004 ;	orr	r7, r7, r4
	DCD	0xe1888005 ;	orr	r8, r8, r5
	DCD	0xe00aa00c ;	and	sl, sl, ip
	DCD	0xe00bb00c ;	and	fp, fp, ip
	DCD	0xe047a0aa ;	sub	sl, r7, sl, lsr #1
	DCD	0xe048b0ab ;	sub	fp, r8, fp, lsr #1
	DCD	0xe8800c00 ;	stm	r0, {sl, fp}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0x1affffdb ;	bne	73c <ff_put_pixels8_y2_arm+0x19c>
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe8910070 ;	ldm	r1, {r4, r5, r6}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04c24 ;	lsr	r4, r4, #24
	DCD	0xe1844405 ;	orr	r4, r4, r5, lsl #8
	DCD	0xe1a05c25 ;	lsr	r5, r5, #24
	DCD	0xe1855406 ;	orr	r5, r5, r6, lsl #8
	DCD	0xe8910380 ;	ldm	r1, {r7, r8, r9}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a07c27 ;	lsr	r7, r7, #24
	DCD	0xe1877408 ;	orr	r7, r7, r8, lsl #8
	DCD	0xe1a08c28 ;	lsr	r8, r8, #24
	DCD	0xe1888409 ;	orr	r8, r8, r9, lsl #8
	DCD	0xe024a007 ;	eor	sl, r4, r7
	DCD	0xe025b008 ;	eor	fp, r5, r8
	DCD	0xe1844007 ;	orr	r4, r4, r7
	DCD	0xe1855008 ;	orr	r5, r5, r8
	DCD	0xe00aa00c ;	and	sl, sl, ip
	DCD	0xe00bb00c ;	and	fp, fp, ip
	DCD	0xe044a0aa ;	sub	sl, r4, sl, lsr #1
	DCD	0xe045b0ab ;	sub	fp, r5, fp, lsr #1
	DCD	0xe8800c00 ;	stm	r0, {sl, fp}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0xe8910070 ;	ldm	r1, {r4, r5, r6}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04c24 ;	lsr	r4, r4, #24
	DCD	0xe1844405 ;	orr	r4, r4, r5, lsl #8
	DCD	0xe1a05c25 ;	lsr	r5, r5, #24
	DCD	0xe1855406 ;	orr	r5, r5, r6, lsl #8
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe027a004 ;	eor	sl, r7, r4
	DCD	0xe028b005 ;	eor	fp, r8, r5
	DCD	0xe1877004 ;	orr	r7, r7, r4
	DCD	0xe1888005 ;	orr	r8, r8, r5
	DCD	0xe00aa00c ;	and	sl, sl, ip
	DCD	0xe00bb00c ;	and	fp, fp, ip
	DCD	0xe047a0aa ;	sub	sl, r7, sl, lsr #1
	DCD	0xe048b0ab ;	sub	fp, r8, fp, lsr #1
	DCD	0xe8800c00 ;	stm	r0, {sl, fp}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0x1affffdb ;	bne	7fc <ff_put_pixels8_y2_arm+0x25c>
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	ENDP  ; |ff_put_pixels8_y2_arm|

|ff_put_no_rnd_pixels8_y2_arm| PROC
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe92d4ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, lr}
	DCD	0xe1a030a3 ;	lsr	r3, r3, #1
	DCD	0xe59fc2dc ;	ldr	ip, [pc, #732]	; b90 <ff_put_no_rnd_pixels8_y2_arm+0x2f0>
	DCD	0xe2115003 ;	ands	r5, r1, #3
	DCD	0xe3c11003 ;	bic	r1, r1, #3
	DCD	0x0a000004 ;	beq	8d0 <ff_put_no_rnd_pixels8_y2_arm+0x30>
	DCD	0xe2555001 ;	subs	r5, r5, #1
	DCD	0x0a000026 ;	beq	960 <ff_put_no_rnd_pixels8_y2_arm+0xc0>
	DCD	0xe2555001 ;	subs	r5, r5, #1
	DCD	0x0a000054 ;	beq	a20 <ff_put_no_rnd_pixels8_y2_arm+0x180>
	DCD	0xea000083 ;	b	ae0 <ff_put_no_rnd_pixels8_y2_arm+0x240>
	DCD	0xe8910030 ;	ldm	r1, {r4, r5}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xe89100c0 ;	ldm	r1, {r6, r7}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe0248006 ;	eor	r8, r4, r6
	DCD	0xe0259007 ;	eor	r9, r5, r7
	DCD	0xe0044006 ;	and	r4, r4, r6
	DCD	0xe0055007 ;	and	r5, r5, r7
	DCD	0xe008800c ;	and	r8, r8, ip
	DCD	0xe009900c ;	and	r9, r9, ip
	DCD	0xe08480a8 ;	add	r8, r4, r8, lsr #1
	DCD	0xe08590a9 ;	add	r9, r5, r9, lsr #1
	DCD	0xe8910030 ;	ldm	r1, {r4, r5}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xe8800300 ;	stm	r0, {r8, r9}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe0268004 ;	eor	r8, r6, r4
	DCD	0xe0279005 ;	eor	r9, r7, r5
	DCD	0xe0066004 ;	and	r6, r6, r4
	DCD	0xe0077005 ;	and	r7, r7, r5
	DCD	0xe008800c ;	and	r8, r8, ip
	DCD	0xe009900c ;	and	r9, r9, ip
	DCD	0xe08680a8 ;	add	r8, r6, r8, lsr #1
	DCD	0xe08790a9 ;	add	r9, r7, r9, lsr #1
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe8800300 ;	stm	r0, {r8, r9}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0x1affffe3 ;	bne	8d8 <ff_put_no_rnd_pixels8_y2_arm+0x38>
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe8910070 ;	ldm	r1, {r4, r5, r6}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04424 ;	lsr	r4, r4, #8
	DCD	0xe1844c05 ;	orr	r4, r4, r5, lsl #24
	DCD	0xe1a05425 ;	lsr	r5, r5, #8
	DCD	0xe1855c06 ;	orr	r5, r5, r6, lsl #24
	DCD	0xe8910380 ;	ldm	r1, {r7, r8, r9}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a07427 ;	lsr	r7, r7, #8
	DCD	0xe1877c08 ;	orr	r7, r7, r8, lsl #24
	DCD	0xe1a08428 ;	lsr	r8, r8, #8
	DCD	0xe1888c09 ;	orr	r8, r8, r9, lsl #24
	DCD	0xe024a007 ;	eor	sl, r4, r7
	DCD	0xe025b008 ;	eor	fp, r5, r8
	DCD	0xe0044007 ;	and	r4, r4, r7
	DCD	0xe0055008 ;	and	r5, r5, r8
	DCD	0xe00aa00c ;	and	sl, sl, ip
	DCD	0xe00bb00c ;	and	fp, fp, ip
	DCD	0xe084a0aa ;	add	sl, r4, sl, lsr #1
	DCD	0xe085b0ab ;	add	fp, r5, fp, lsr #1
	DCD	0xe8800c00 ;	stm	r0, {sl, fp}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0xe8910070 ;	ldm	r1, {r4, r5, r6}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04424 ;	lsr	r4, r4, #8
	DCD	0xe1844c05 ;	orr	r4, r4, r5, lsl #24
	DCD	0xe1a05425 ;	lsr	r5, r5, #8
	DCD	0xe1855c06 ;	orr	r5, r5, r6, lsl #24
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe027a004 ;	eor	sl, r7, r4
	DCD	0xe028b005 ;	eor	fp, r8, r5
	DCD	0xe0077004 ;	and	r7, r7, r4
	DCD	0xe0088005 ;	and	r8, r8, r5
	DCD	0xe00aa00c ;	and	sl, sl, ip
	DCD	0xe00bb00c ;	and	fp, fp, ip
	DCD	0xe087a0aa ;	add	sl, r7, sl, lsr #1
	DCD	0xe088b0ab ;	add	fp, r8, fp, lsr #1
	DCD	0xe8800c00 ;	stm	r0, {sl, fp}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0x1affffdb ;	bne	97c <ff_put_no_rnd_pixels8_y2_arm+0xdc>
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe8910070 ;	ldm	r1, {r4, r5, r6}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04824 ;	lsr	r4, r4, #16
	DCD	0xe1844805 ;	orr	r4, r4, r5, lsl #16
	DCD	0xe1a05825 ;	lsr	r5, r5, #16
	DCD	0xe1855806 ;	orr	r5, r5, r6, lsl #16
	DCD	0xe8910380 ;	ldm	r1, {r7, r8, r9}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a07827 ;	lsr	r7, r7, #16
	DCD	0xe1877808 ;	orr	r7, r7, r8, lsl #16
	DCD	0xe1a08828 ;	lsr	r8, r8, #16
	DCD	0xe1888809 ;	orr	r8, r8, r9, lsl #16
	DCD	0xe024a007 ;	eor	sl, r4, r7
	DCD	0xe025b008 ;	eor	fp, r5, r8
	DCD	0xe0044007 ;	and	r4, r4, r7
	DCD	0xe0055008 ;	and	r5, r5, r8
	DCD	0xe00aa00c ;	and	sl, sl, ip
	DCD	0xe00bb00c ;	and	fp, fp, ip
	DCD	0xe084a0aa ;	add	sl, r4, sl, lsr #1
	DCD	0xe085b0ab ;	add	fp, r5, fp, lsr #1
	DCD	0xe8800c00 ;	stm	r0, {sl, fp}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0xe8910070 ;	ldm	r1, {r4, r5, r6}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04824 ;	lsr	r4, r4, #16
	DCD	0xe1844805 ;	orr	r4, r4, r5, lsl #16
	DCD	0xe1a05825 ;	lsr	r5, r5, #16
	DCD	0xe1855806 ;	orr	r5, r5, r6, lsl #16
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe027a004 ;	eor	sl, r7, r4
	DCD	0xe028b005 ;	eor	fp, r8, r5
	DCD	0xe0077004 ;	and	r7, r7, r4
	DCD	0xe0088005 ;	and	r8, r8, r5
	DCD	0xe00aa00c ;	and	sl, sl, ip
	DCD	0xe00bb00c ;	and	fp, fp, ip
	DCD	0xe087a0aa ;	add	sl, r7, sl, lsr #1
	DCD	0xe088b0ab ;	add	fp, r8, fp, lsr #1
	DCD	0xe8800c00 ;	stm	r0, {sl, fp}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0x1affffdb ;	bne	a3c <ff_put_no_rnd_pixels8_y2_arm+0x19c>
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe8910070 ;	ldm	r1, {r4, r5, r6}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04c24 ;	lsr	r4, r4, #24
	DCD	0xe1844405 ;	orr	r4, r4, r5, lsl #8
	DCD	0xe1a05c25 ;	lsr	r5, r5, #24
	DCD	0xe1855406 ;	orr	r5, r5, r6, lsl #8
	DCD	0xe8910380 ;	ldm	r1, {r7, r8, r9}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a07c27 ;	lsr	r7, r7, #24
	DCD	0xe1877408 ;	orr	r7, r7, r8, lsl #8
	DCD	0xe1a08c28 ;	lsr	r8, r8, #24
	DCD	0xe1888409 ;	orr	r8, r8, r9, lsl #8
	DCD	0xe024a007 ;	eor	sl, r4, r7
	DCD	0xe025b008 ;	eor	fp, r5, r8
	DCD	0xe0044007 ;	and	r4, r4, r7
	DCD	0xe0055008 ;	and	r5, r5, r8
	DCD	0xe00aa00c ;	and	sl, sl, ip
	DCD	0xe00bb00c ;	and	fp, fp, ip
	DCD	0xe084a0aa ;	add	sl, r4, sl, lsr #1
	DCD	0xe085b0ab ;	add	fp, r5, fp, lsr #1
	DCD	0xe8800c00 ;	stm	r0, {sl, fp}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0xe8910070 ;	ldm	r1, {r4, r5, r6}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04c24 ;	lsr	r4, r4, #24
	DCD	0xe1844405 ;	orr	r4, r4, r5, lsl #8
	DCD	0xe1a05c25 ;	lsr	r5, r5, #24
	DCD	0xe1855406 ;	orr	r5, r5, r6, lsl #8
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe027a004 ;	eor	sl, r7, r4
	DCD	0xe028b005 ;	eor	fp, r8, r5
	DCD	0xe0077004 ;	and	r7, r7, r4
	DCD	0xe0088005 ;	and	r8, r8, r5
	DCD	0xe00aa00c ;	and	sl, sl, ip
	DCD	0xe00bb00c ;	and	fp, fp, ip
	DCD	0xe087a0aa ;	add	sl, r7, sl, lsr #1
	DCD	0xe088b0ab ;	add	fp, r8, fp, lsr #1
	DCD	0xe8800c00 ;	stm	r0, {sl, fp}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0x1affffdb ;	bne	afc <ff_put_no_rnd_pixels8_y2_arm+0x25c>
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	DCD	0xfefefefe ;	mrc2	14, 7, pc, cr14, cr14, {7}
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	ENDP  ; |ff_put_no_rnd_pixels8_y2_arm|

|ff_put_pixels8_xy2_arm| PROC
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe92d4ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, lr}
	DCD	0xe2115003 ;	ands	r5, r1, #3
	DCD	0xe3c11003 ;	bic	r1, r1, #3
	DCD	0x0a000004 ;	beq	bc8 <ff_put_pixels8_xy2_arm+0x28>
	DCD	0xe2555001 ;	subs	r5, r5, #1
	DCD	0x0a000048 ;	beq	ce0 <ff_put_pixels8_xy2_arm+0x140>
	DCD	0xe2555001 ;	subs	r5, r5, #1
	DCD	0x0a000096 ;	beq	e20 <ff_put_pixels8_xy2_arm+0x280>
	DCD	0xea0000e5 ;	b	f60 <ff_put_pixels8_xy2_arm+0x3c0>
	DCD	0xe89101c0 ;	ldm	r1, {r6, r7, r8}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04426 ;	lsr	r4, r6, #8
	DCD	0xe1a05427 ;	lsr	r5, r7, #8
	DCD	0xe1844c07 ;	orr	r4, r4, r7, lsl #24
	DCD	0xe1855c08 ;	orr	r5, r5, r8, lsl #24
	DCD	0xe59fea84 ;	ldr	lr, [pc, #2692]	; 1670 <ff_add_pixels_clamped_arm+0x110>
	DCD	0xe3130001 ;	tst	r3, #1
	DCD	0xe004800e ;	and	r8, r4, lr
	DCD	0xe005900e ;	and	r9, r5, lr
	DCD	0xe006a00e ;	and	sl, r6, lr
	DCD	0xe007b00e ;	and	fp, r7, lr
	DCD	0x000ee08e ;	andeq	lr, lr, lr, lsl #1
	DCD	0xe088800a ;	add	r8, r8, sl
	DCD	0xe089900b ;	add	r9, r9, fp
	DCD	0xe59fca64 ;	ldr	ip, [pc, #2660]	; 1674 <ff_add_pixels_clamped_arm+0x114>
	DCD	0x0088800e ;	addeq	r8, r8, lr
	DCD	0x0089900e ;	addeq	r9, r9, lr
	DCD	0xe00c4124 ;	and	r4, ip, r4, lsr #2
	DCD	0xe00c5125 ;	and	r5, ip, r5, lsr #2
	DCD	0xe00c6126 ;	and	r6, ip, r6, lsr #2
	DCD	0xe00c7127 ;	and	r7, ip, r7, lsr #2
	DCD	0xe084a006 ;	add	sl, r4, r6
	DCD	0xe085b007 ;	add	fp, r5, r7
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe92d0f00 ;	push	{r8, r9, sl, fp}
	DCD	0xe89101c0 ;	ldm	r1, {r6, r7, r8}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04426 ;	lsr	r4, r6, #8
	DCD	0xe1a05427 ;	lsr	r5, r7, #8
	DCD	0xe1844c07 ;	orr	r4, r4, r7, lsl #24
	DCD	0xe1855c08 ;	orr	r5, r5, r8, lsl #24
	DCD	0xe59fea18 ;	ldr	lr, [pc, #2584]	; 1670 <ff_add_pixels_clamped_arm+0x110>
	DCD	0xe3130001 ;	tst	r3, #1
	DCD	0xe004800e ;	and	r8, r4, lr
	DCD	0xe005900e ;	and	r9, r5, lr
	DCD	0xe006a00e ;	and	sl, r6, lr
	DCD	0xe007b00e ;	and	fp, r7, lr
	DCD	0x000ee08e ;	andeq	lr, lr, lr, lsl #1
	DCD	0xe088800a ;	add	r8, r8, sl
	DCD	0xe089900b ;	add	r9, r9, fp
	DCD	0xe59fc9f8 ;	ldr	ip, [pc, #2552]	; 1674 <ff_add_pixels_clamped_arm+0x114>
	DCD	0x0088800e ;	addeq	r8, r8, lr
	DCD	0x0089900e ;	addeq	r9, r9, lr
	DCD	0xe00c4124 ;	and	r4, ip, r4, lsr #2
	DCD	0xe00c5125 ;	and	r5, ip, r5, lsr #2
	DCD	0xe00c6126 ;	and	r6, ip, r6, lsr #2
	DCD	0xe00c7127 ;	and	r7, ip, r7, lsr #2
	DCD	0xe084a006 ;	add	sl, r4, r6
	DCD	0xe085b007 ;	add	fp, r5, r7
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe8bd00f0 ;	pop	{r4, r5, r6, r7}
	DCD	0xe0844008 ;	add	r4, r4, r8
	DCD	0xe0855009 ;	add	r5, r5, r9
	DCD	0xe59fe9c8 ;	ldr	lr, [pc, #2504]	; 1678 <ff_add_pixels_clamped_arm+0x118>
	DCD	0xe086600a ;	add	r6, r6, sl
	DCD	0xe087700b ;	add	r7, r7, fp
	DCD	0xe00e4124 ;	and	r4, lr, r4, lsr #2
	DCD	0xe00e5125 ;	and	r5, lr, r5, lsr #2
	DCD	0xe0844006 ;	add	r4, r4, r6
	DCD	0xe0855007 ;	add	r5, r5, r7
	DCD	0xe8800030 ;	stm	r0, {r4, r5}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0xaaffffd7 ;	bge	c30 <ff_put_pixels8_xy2_arm+0x90>
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe8910700 ;	ldm	r1, {r8, r9, sl}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04428 ;	lsr	r4, r8, #8
	DCD	0xe1a05429 ;	lsr	r5, r9, #8
	DCD	0xe1844c09 ;	orr	r4, r4, r9, lsl #24
	DCD	0xe1855c0a ;	orr	r5, r5, sl, lsl #24
	DCD	0xe1a06828 ;	lsr	r6, r8, #16
	DCD	0xe1a07829 ;	lsr	r7, r9, #16
	DCD	0xe1866809 ;	orr	r6, r6, r9, lsl #16
	DCD	0xe187780a ;	orr	r7, r7, sl, lsl #16
	DCD	0xe59fe95c ;	ldr	lr, [pc, #2396]	; 1670 <ff_add_pixels_clamped_arm+0x110>
	DCD	0xe3130001 ;	tst	r3, #1
	DCD	0xe004800e ;	and	r8, r4, lr
	DCD	0xe005900e ;	and	r9, r5, lr
	DCD	0xe006a00e ;	and	sl, r6, lr
	DCD	0xe007b00e ;	and	fp, r7, lr
	DCD	0x000ee08e ;	andeq	lr, lr, lr, lsl #1
	DCD	0xe088800a ;	add	r8, r8, sl
	DCD	0xe089900b ;	add	r9, r9, fp
	DCD	0xe59fc93c ;	ldr	ip, [pc, #2364]	; 1674 <ff_add_pixels_clamped_arm+0x114>
	DCD	0x0088800e ;	addeq	r8, r8, lr
	DCD	0x0089900e ;	addeq	r9, r9, lr
	DCD	0xe00c4124 ;	and	r4, ip, r4, lsr #2
	DCD	0xe00c5125 ;	and	r5, ip, r5, lsr #2
	DCD	0xe00c6126 ;	and	r6, ip, r6, lsr #2
	DCD	0xe00c7127 ;	and	r7, ip, r7, lsr #2
	DCD	0xe084a006 ;	add	sl, r4, r6
	DCD	0xe085b007 ;	add	fp, r5, r7
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe92d0f00 ;	push	{r8, r9, sl, fp}
	DCD	0xe8910700 ;	ldm	r1, {r8, r9, sl}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04428 ;	lsr	r4, r8, #8
	DCD	0xe1a05429 ;	lsr	r5, r9, #8
	DCD	0xe1844c09 ;	orr	r4, r4, r9, lsl #24
	DCD	0xe1855c0a ;	orr	r5, r5, sl, lsl #24
	DCD	0xe1a06828 ;	lsr	r6, r8, #16
	DCD	0xe1a07829 ;	lsr	r7, r9, #16
	DCD	0xe1866809 ;	orr	r6, r6, r9, lsl #16
	DCD	0xe187780a ;	orr	r7, r7, sl, lsl #16
	DCD	0xe59fe8e0 ;	ldr	lr, [pc, #2272]	; 1670 <ff_add_pixels_clamped_arm+0x110>
	DCD	0xe3130001 ;	tst	r3, #1
	DCD	0xe004800e ;	and	r8, r4, lr
	DCD	0xe005900e ;	and	r9, r5, lr
	DCD	0xe006a00e ;	and	sl, r6, lr
	DCD	0xe007b00e ;	and	fp, r7, lr
	DCD	0x000ee08e ;	andeq	lr, lr, lr, lsl #1
	DCD	0xe088800a ;	add	r8, r8, sl
	DCD	0xe089900b ;	add	r9, r9, fp
	DCD	0xe59fc8c0 ;	ldr	ip, [pc, #2240]	; 1674 <ff_add_pixels_clamped_arm+0x114>
	DCD	0x0088800e ;	addeq	r8, r8, lr
	DCD	0x0089900e ;	addeq	r9, r9, lr
	DCD	0xe00c4124 ;	and	r4, ip, r4, lsr #2
	DCD	0xe00c5125 ;	and	r5, ip, r5, lsr #2
	DCD	0xe00c6126 ;	and	r6, ip, r6, lsr #2
	DCD	0xe00c7127 ;	and	r7, ip, r7, lsr #2
	DCD	0xe084a006 ;	add	sl, r4, r6
	DCD	0xe085b007 ;	add	fp, r5, r7
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe8bd00f0 ;	pop	{r4, r5, r6, r7}
	DCD	0xe0844008 ;	add	r4, r4, r8
	DCD	0xe0855009 ;	add	r5, r5, r9
	DCD	0xe59fe890 ;	ldr	lr, [pc, #2192]	; 1678 <ff_add_pixels_clamped_arm+0x118>
	DCD	0xe086600a ;	add	r6, r6, sl
	DCD	0xe087700b ;	add	r7, r7, fp
	DCD	0xe00e4124 ;	and	r4, lr, r4, lsr #2
	DCD	0xe00e5125 ;	and	r5, lr, r5, lsr #2
	DCD	0xe0844006 ;	add	r4, r4, r6
	DCD	0xe0855007 ;	add	r5, r5, r7
	DCD	0xe8800030 ;	stm	r0, {r4, r5}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0xaaffffd3 ;	bge	d58 <ff_put_pixels8_xy2_arm+0x1b8>
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe8910700 ;	ldm	r1, {r8, r9, sl}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04828 ;	lsr	r4, r8, #16
	DCD	0xe1a05829 ;	lsr	r5, r9, #16
	DCD	0xe1844809 ;	orr	r4, r4, r9, lsl #16
	DCD	0xe185580a ;	orr	r5, r5, sl, lsl #16
	DCD	0xe1a06c28 ;	lsr	r6, r8, #24
	DCD	0xe1a07c29 ;	lsr	r7, r9, #24
	DCD	0xe1866409 ;	orr	r6, r6, r9, lsl #8
	DCD	0xe187740a ;	orr	r7, r7, sl, lsl #8
	DCD	0xe59fe81c ;	ldr	lr, [pc, #2076]	; 1670 <ff_add_pixels_clamped_arm+0x110>
	DCD	0xe3130001 ;	tst	r3, #1
	DCD	0xe004800e ;	and	r8, r4, lr
	DCD	0xe005900e ;	and	r9, r5, lr
	DCD	0xe006a00e ;	and	sl, r6, lr
	DCD	0xe007b00e ;	and	fp, r7, lr
	DCD	0x000ee08e ;	andeq	lr, lr, lr, lsl #1
	DCD	0xe088800a ;	add	r8, r8, sl
	DCD	0xe089900b ;	add	r9, r9, fp
	DCD	0xe59fc7fc ;	ldr	ip, [pc, #2044]	; 1674 <ff_add_pixels_clamped_arm+0x114>
	DCD	0x0088800e ;	addeq	r8, r8, lr
	DCD	0x0089900e ;	addeq	r9, r9, lr
	DCD	0xe00c4124 ;	and	r4, ip, r4, lsr #2
	DCD	0xe00c5125 ;	and	r5, ip, r5, lsr #2
	DCD	0xe00c6126 ;	and	r6, ip, r6, lsr #2
	DCD	0xe00c7127 ;	and	r7, ip, r7, lsr #2
	DCD	0xe084a006 ;	add	sl, r4, r6
	DCD	0xe085b007 ;	add	fp, r5, r7
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe92d0f00 ;	push	{r8, r9, sl, fp}
	DCD	0xe8910700 ;	ldm	r1, {r8, r9, sl}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04828 ;	lsr	r4, r8, #16
	DCD	0xe1a05829 ;	lsr	r5, r9, #16
	DCD	0xe1844809 ;	orr	r4, r4, r9, lsl #16
	DCD	0xe185580a ;	orr	r5, r5, sl, lsl #16
	DCD	0xe1a06c28 ;	lsr	r6, r8, #24
	DCD	0xe1a07c29 ;	lsr	r7, r9, #24
	DCD	0xe1866409 ;	orr	r6, r6, r9, lsl #8
	DCD	0xe187740a ;	orr	r7, r7, sl, lsl #8
	DCD	0xe59fe7a0 ;	ldr	lr, [pc, #1952]	; 1670 <ff_add_pixels_clamped_arm+0x110>
	DCD	0xe3130001 ;	tst	r3, #1
	DCD	0xe004800e ;	and	r8, r4, lr
	DCD	0xe005900e ;	and	r9, r5, lr
	DCD	0xe006a00e ;	and	sl, r6, lr
	DCD	0xe007b00e ;	and	fp, r7, lr
	DCD	0x000ee08e ;	andeq	lr, lr, lr, lsl #1
	DCD	0xe088800a ;	add	r8, r8, sl
	DCD	0xe089900b ;	add	r9, r9, fp
	DCD	0xe59fc780 ;	ldr	ip, [pc, #1920]	; 1674 <ff_add_pixels_clamped_arm+0x114>
	DCD	0x0088800e ;	addeq	r8, r8, lr
	DCD	0x0089900e ;	addeq	r9, r9, lr
	DCD	0xe00c4124 ;	and	r4, ip, r4, lsr #2
	DCD	0xe00c5125 ;	and	r5, ip, r5, lsr #2
	DCD	0xe00c6126 ;	and	r6, ip, r6, lsr #2
	DCD	0xe00c7127 ;	and	r7, ip, r7, lsr #2
	DCD	0xe084a006 ;	add	sl, r4, r6
	DCD	0xe085b007 ;	add	fp, r5, r7
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe8bd00f0 ;	pop	{r4, r5, r6, r7}
	DCD	0xe0844008 ;	add	r4, r4, r8
	DCD	0xe0855009 ;	add	r5, r5, r9
	DCD	0xe59fe750 ;	ldr	lr, [pc, #1872]	; 1678 <ff_add_pixels_clamped_arm+0x118>
	DCD	0xe086600a ;	add	r6, r6, sl
	DCD	0xe087700b ;	add	r7, r7, fp
	DCD	0xe00e4124 ;	and	r4, lr, r4, lsr #2
	DCD	0xe00e5125 ;	and	r5, lr, r5, lsr #2
	DCD	0xe0844006 ;	add	r4, r4, r6
	DCD	0xe0855007 ;	add	r5, r5, r7
	DCD	0xe8800030 ;	stm	r0, {r4, r5}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0xaaffffd3 ;	bge	e98 <ff_put_pixels8_xy2_arm+0x2f8>
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe89100e0 ;	ldm	r1, {r5, r6, r7}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04c25 ;	lsr	r4, r5, #24
	DCD	0xe1a05c26 ;	lsr	r5, r6, #24
	DCD	0xe1844406 ;	orr	r4, r4, r6, lsl #8
	DCD	0xe1855407 ;	orr	r5, r5, r7, lsl #8
	DCD	0xe59fe6ec ;	ldr	lr, [pc, #1772]	; 1670 <ff_add_pixels_clamped_arm+0x110>
	DCD	0xe3130001 ;	tst	r3, #1
	DCD	0xe004800e ;	and	r8, r4, lr
	DCD	0xe005900e ;	and	r9, r5, lr
	DCD	0xe006a00e ;	and	sl, r6, lr
	DCD	0xe007b00e ;	and	fp, r7, lr
	DCD	0x000ee08e ;	andeq	lr, lr, lr, lsl #1
	DCD	0xe088800a ;	add	r8, r8, sl
	DCD	0xe089900b ;	add	r9, r9, fp
	DCD	0xe59fc6cc ;	ldr	ip, [pc, #1740]	; 1674 <ff_add_pixels_clamped_arm+0x114>
	DCD	0x0088800e ;	addeq	r8, r8, lr
	DCD	0x0089900e ;	addeq	r9, r9, lr
	DCD	0xe00c4124 ;	and	r4, ip, r4, lsr #2
	DCD	0xe00c5125 ;	and	r5, ip, r5, lsr #2
	DCD	0xe00c6126 ;	and	r6, ip, r6, lsr #2
	DCD	0xe00c7127 ;	and	r7, ip, r7, lsr #2
	DCD	0xe084a006 ;	add	sl, r4, r6
	DCD	0xe085b007 ;	add	fp, r5, r7
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe92d0f00 ;	push	{r8, r9, sl, fp}
	DCD	0xe89100e0 ;	ldm	r1, {r5, r6, r7}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04c25 ;	lsr	r4, r5, #24
	DCD	0xe1a05c26 ;	lsr	r5, r6, #24
	DCD	0xe1844406 ;	orr	r4, r4, r6, lsl #8
	DCD	0xe1855407 ;	orr	r5, r5, r7, lsl #8
	DCD	0xe59fe680 ;	ldr	lr, [pc, #1664]	; 1670 <ff_add_pixels_clamped_arm+0x110>
	DCD	0xe3130001 ;	tst	r3, #1
	DCD	0xe004800e ;	and	r8, r4, lr
	DCD	0xe005900e ;	and	r9, r5, lr
	DCD	0xe006a00e ;	and	sl, r6, lr
	DCD	0xe007b00e ;	and	fp, r7, lr
	DCD	0x000ee08e ;	andeq	lr, lr, lr, lsl #1
	DCD	0xe088800a ;	add	r8, r8, sl
	DCD	0xe089900b ;	add	r9, r9, fp
	DCD	0xe59fc660 ;	ldr	ip, [pc, #1632]	; 1674 <ff_add_pixels_clamped_arm+0x114>
	DCD	0x0088800e ;	addeq	r8, r8, lr
	DCD	0x0089900e ;	addeq	r9, r9, lr
	DCD	0xe00c4124 ;	and	r4, ip, r4, lsr #2
	DCD	0xe00c5125 ;	and	r5, ip, r5, lsr #2
	DCD	0xe00c6126 ;	and	r6, ip, r6, lsr #2
	DCD	0xe00c7127 ;	and	r7, ip, r7, lsr #2
	DCD	0xe084a006 ;	add	sl, r4, r6
	DCD	0xe085b007 ;	add	fp, r5, r7
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe8bd00f0 ;	pop	{r4, r5, r6, r7}
	DCD	0xe0844008 ;	add	r4, r4, r8
	DCD	0xe0855009 ;	add	r5, r5, r9
	DCD	0xe59fe630 ;	ldr	lr, [pc, #1584]	; 1678 <ff_add_pixels_clamped_arm+0x118>
	DCD	0xe086600a ;	add	r6, r6, sl
	DCD	0xe087700b ;	add	r7, r7, fp
	DCD	0xe00e4124 ;	and	r4, lr, r4, lsr #2
	DCD	0xe00e5125 ;	and	r5, lr, r5, lsr #2
	DCD	0xe0844006 ;	add	r4, r4, r6
	DCD	0xe0855007 ;	add	r5, r5, r7
	DCD	0xe8800030 ;	stm	r0, {r4, r5}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0xaaffffd7 ;	bge	fc8 <ff_put_pixels8_xy2_arm+0x428>
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	ENDP  ; |ff_put_pixels8_xy2_arm|

|ff_put_no_rnd_pixels8_xy2_arm| PROC
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe92d4ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, lr}
	DCD	0xe2115003 ;	ands	r5, r1, #3
	DCD	0xe3c11003 ;	bic	r1, r1, #3
	DCD	0x0a000004 ;	beq	10a8 <ff_put_no_rnd_pixels8_xy2_arm+0x28>
	DCD	0xe2555001 ;	subs	r5, r5, #1
	DCD	0x0a000048 ;	beq	11c0 <ff_put_no_rnd_pixels8_xy2_arm+0x140>
	DCD	0xe2555001 ;	subs	r5, r5, #1
	DCD	0x0a000096 ;	beq	1300 <ff_put_no_rnd_pixels8_xy2_arm+0x280>
	DCD	0xea0000e5 ;	b	1440 <ff_put_no_rnd_pixels8_xy2_arm+0x3c0>
	DCD	0xe89101c0 ;	ldm	r1, {r6, r7, r8}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04426 ;	lsr	r4, r6, #8
	DCD	0xe1a05427 ;	lsr	r5, r7, #8
	DCD	0xe1844c07 ;	orr	r4, r4, r7, lsl #24
	DCD	0xe1855c08 ;	orr	r5, r5, r8, lsl #24
	DCD	0xe59fe5a4 ;	ldr	lr, [pc, #1444]	; 1670 <ff_add_pixels_clamped_arm+0x110>
	DCD	0xe3130001 ;	tst	r3, #1
	DCD	0xe004800e ;	and	r8, r4, lr
	DCD	0xe005900e ;	and	r9, r5, lr
	DCD	0xe006a00e ;	and	sl, r6, lr
	DCD	0xe007b00e ;	and	fp, r7, lr
	DCD	0x000ee0ae ;	andeq	lr, lr, lr, lsr #1
	DCD	0xe088800a ;	add	r8, r8, sl
	DCD	0xe089900b ;	add	r9, r9, fp
	DCD	0xe59fc584 ;	ldr	ip, [pc, #1412]	; 1674 <ff_add_pixels_clamped_arm+0x114>
	DCD	0x0088800e ;	addeq	r8, r8, lr
	DCD	0x0089900e ;	addeq	r9, r9, lr
	DCD	0xe00c4124 ;	and	r4, ip, r4, lsr #2
	DCD	0xe00c5125 ;	and	r5, ip, r5, lsr #2
	DCD	0xe00c6126 ;	and	r6, ip, r6, lsr #2
	DCD	0xe00c7127 ;	and	r7, ip, r7, lsr #2
	DCD	0xe084a006 ;	add	sl, r4, r6
	DCD	0xe085b007 ;	add	fp, r5, r7
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe92d0f00 ;	push	{r8, r9, sl, fp}
	DCD	0xe89101c0 ;	ldm	r1, {r6, r7, r8}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04426 ;	lsr	r4, r6, #8
	DCD	0xe1a05427 ;	lsr	r5, r7, #8
	DCD	0xe1844c07 ;	orr	r4, r4, r7, lsl #24
	DCD	0xe1855c08 ;	orr	r5, r5, r8, lsl #24
	DCD	0xe59fe538 ;	ldr	lr, [pc, #1336]	; 1670 <ff_add_pixels_clamped_arm+0x110>
	DCD	0xe3130001 ;	tst	r3, #1
	DCD	0xe004800e ;	and	r8, r4, lr
	DCD	0xe005900e ;	and	r9, r5, lr
	DCD	0xe006a00e ;	and	sl, r6, lr
	DCD	0xe007b00e ;	and	fp, r7, lr
	DCD	0x000ee0ae ;	andeq	lr, lr, lr, lsr #1
	DCD	0xe088800a ;	add	r8, r8, sl
	DCD	0xe089900b ;	add	r9, r9, fp
	DCD	0xe59fc518 ;	ldr	ip, [pc, #1304]	; 1674 <ff_add_pixels_clamped_arm+0x114>
	DCD	0x0088800e ;	addeq	r8, r8, lr
	DCD	0x0089900e ;	addeq	r9, r9, lr
	DCD	0xe00c4124 ;	and	r4, ip, r4, lsr #2
	DCD	0xe00c5125 ;	and	r5, ip, r5, lsr #2
	DCD	0xe00c6126 ;	and	r6, ip, r6, lsr #2
	DCD	0xe00c7127 ;	and	r7, ip, r7, lsr #2
	DCD	0xe084a006 ;	add	sl, r4, r6
	DCD	0xe085b007 ;	add	fp, r5, r7
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe8bd00f0 ;	pop	{r4, r5, r6, r7}
	DCD	0xe0844008 ;	add	r4, r4, r8
	DCD	0xe0855009 ;	add	r5, r5, r9
	DCD	0xe59fe4e8 ;	ldr	lr, [pc, #1256]	; 1678 <ff_add_pixels_clamped_arm+0x118>
	DCD	0xe086600a ;	add	r6, r6, sl
	DCD	0xe087700b ;	add	r7, r7, fp
	DCD	0xe00e4124 ;	and	r4, lr, r4, lsr #2
	DCD	0xe00e5125 ;	and	r5, lr, r5, lsr #2
	DCD	0xe0844006 ;	add	r4, r4, r6
	DCD	0xe0855007 ;	add	r5, r5, r7
	DCD	0xe8800030 ;	stm	r0, {r4, r5}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0xaaffffd7 ;	bge	1110 <ff_put_no_rnd_pixels8_xy2_arm+0x90>
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe8910700 ;	ldm	r1, {r8, r9, sl}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04428 ;	lsr	r4, r8, #8
	DCD	0xe1a05429 ;	lsr	r5, r9, #8
	DCD	0xe1844c09 ;	orr	r4, r4, r9, lsl #24
	DCD	0xe1855c0a ;	orr	r5, r5, sl, lsl #24
	DCD	0xe1a06828 ;	lsr	r6, r8, #16
	DCD	0xe1a07829 ;	lsr	r7, r9, #16
	DCD	0xe1866809 ;	orr	r6, r6, r9, lsl #16
	DCD	0xe187780a ;	orr	r7, r7, sl, lsl #16
	DCD	0xe59fe47c ;	ldr	lr, [pc, #1148]	; 1670 <ff_add_pixels_clamped_arm+0x110>
	DCD	0xe3130001 ;	tst	r3, #1
	DCD	0xe004800e ;	and	r8, r4, lr
	DCD	0xe005900e ;	and	r9, r5, lr
	DCD	0xe006a00e ;	and	sl, r6, lr
	DCD	0xe007b00e ;	and	fp, r7, lr
	DCD	0x000ee0ae ;	andeq	lr, lr, lr, lsr #1
	DCD	0xe088800a ;	add	r8, r8, sl
	DCD	0xe089900b ;	add	r9, r9, fp
	DCD	0xe59fc45c ;	ldr	ip, [pc, #1116]	; 1674 <ff_add_pixels_clamped_arm+0x114>
	DCD	0x0088800e ;	addeq	r8, r8, lr
	DCD	0x0089900e ;	addeq	r9, r9, lr
	DCD	0xe00c4124 ;	and	r4, ip, r4, lsr #2
	DCD	0xe00c5125 ;	and	r5, ip, r5, lsr #2
	DCD	0xe00c6126 ;	and	r6, ip, r6, lsr #2
	DCD	0xe00c7127 ;	and	r7, ip, r7, lsr #2
	DCD	0xe084a006 ;	add	sl, r4, r6
	DCD	0xe085b007 ;	add	fp, r5, r7
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe92d0f00 ;	push	{r8, r9, sl, fp}
	DCD	0xe8910700 ;	ldm	r1, {r8, r9, sl}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04428 ;	lsr	r4, r8, #8
	DCD	0xe1a05429 ;	lsr	r5, r9, #8
	DCD	0xe1844c09 ;	orr	r4, r4, r9, lsl #24
	DCD	0xe1855c0a ;	orr	r5, r5, sl, lsl #24
	DCD	0xe1a06828 ;	lsr	r6, r8, #16
	DCD	0xe1a07829 ;	lsr	r7, r9, #16
	DCD	0xe1866809 ;	orr	r6, r6, r9, lsl #16
	DCD	0xe187780a ;	orr	r7, r7, sl, lsl #16
	DCD	0xe59fe400 ;	ldr	lr, [pc, #1024]	; 1670 <ff_add_pixels_clamped_arm+0x110>
	DCD	0xe3130001 ;	tst	r3, #1
	DCD	0xe004800e ;	and	r8, r4, lr
	DCD	0xe005900e ;	and	r9, r5, lr
	DCD	0xe006a00e ;	and	sl, r6, lr
	DCD	0xe007b00e ;	and	fp, r7, lr
	DCD	0x000ee0ae ;	andeq	lr, lr, lr, lsr #1
	DCD	0xe088800a ;	add	r8, r8, sl
	DCD	0xe089900b ;	add	r9, r9, fp
	DCD	0xe59fc3e0 ;	ldr	ip, [pc, #992]	; 1674 <ff_add_pixels_clamped_arm+0x114>
	DCD	0x0088800e ;	addeq	r8, r8, lr
	DCD	0x0089900e ;	addeq	r9, r9, lr
	DCD	0xe00c4124 ;	and	r4, ip, r4, lsr #2
	DCD	0xe00c5125 ;	and	r5, ip, r5, lsr #2
	DCD	0xe00c6126 ;	and	r6, ip, r6, lsr #2
	DCD	0xe00c7127 ;	and	r7, ip, r7, lsr #2
	DCD	0xe084a006 ;	add	sl, r4, r6
	DCD	0xe085b007 ;	add	fp, r5, r7
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe8bd00f0 ;	pop	{r4, r5, r6, r7}
	DCD	0xe0844008 ;	add	r4, r4, r8
	DCD	0xe0855009 ;	add	r5, r5, r9
	DCD	0xe59fe3b0 ;	ldr	lr, [pc, #944]	; 1678 <ff_add_pixels_clamped_arm+0x118>
	DCD	0xe086600a ;	add	r6, r6, sl
	DCD	0xe087700b ;	add	r7, r7, fp
	DCD	0xe00e4124 ;	and	r4, lr, r4, lsr #2
	DCD	0xe00e5125 ;	and	r5, lr, r5, lsr #2
	DCD	0xe0844006 ;	add	r4, r4, r6
	DCD	0xe0855007 ;	add	r5, r5, r7
	DCD	0xe8800030 ;	stm	r0, {r4, r5}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0xaaffffd3 ;	bge	1238 <ff_put_no_rnd_pixels8_xy2_arm+0x1b8>
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe8910700 ;	ldm	r1, {r8, r9, sl}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04828 ;	lsr	r4, r8, #16
	DCD	0xe1a05829 ;	lsr	r5, r9, #16
	DCD	0xe1844809 ;	orr	r4, r4, r9, lsl #16
	DCD	0xe185580a ;	orr	r5, r5, sl, lsl #16
	DCD	0xe1a06c28 ;	lsr	r6, r8, #24
	DCD	0xe1a07c29 ;	lsr	r7, r9, #24
	DCD	0xe1866409 ;	orr	r6, r6, r9, lsl #8
	DCD	0xe187740a ;	orr	r7, r7, sl, lsl #8
	DCD	0xe59fe33c ;	ldr	lr, [pc, #828]	; 1670 <ff_add_pixels_clamped_arm+0x110>
	DCD	0xe3130001 ;	tst	r3, #1
	DCD	0xe004800e ;	and	r8, r4, lr
	DCD	0xe005900e ;	and	r9, r5, lr
	DCD	0xe006a00e ;	and	sl, r6, lr
	DCD	0xe007b00e ;	and	fp, r7, lr
	DCD	0x000ee0ae ;	andeq	lr, lr, lr, lsr #1
	DCD	0xe088800a ;	add	r8, r8, sl
	DCD	0xe089900b ;	add	r9, r9, fp
	DCD	0xe59fc31c ;	ldr	ip, [pc, #796]	; 1674 <ff_add_pixels_clamped_arm+0x114>
	DCD	0x0088800e ;	addeq	r8, r8, lr
	DCD	0x0089900e ;	addeq	r9, r9, lr
	DCD	0xe00c4124 ;	and	r4, ip, r4, lsr #2
	DCD	0xe00c5125 ;	and	r5, ip, r5, lsr #2
	DCD	0xe00c6126 ;	and	r6, ip, r6, lsr #2
	DCD	0xe00c7127 ;	and	r7, ip, r7, lsr #2
	DCD	0xe084a006 ;	add	sl, r4, r6
	DCD	0xe085b007 ;	add	fp, r5, r7
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe92d0f00 ;	push	{r8, r9, sl, fp}
	DCD	0xe8910700 ;	ldm	r1, {r8, r9, sl}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04828 ;	lsr	r4, r8, #16
	DCD	0xe1a05829 ;	lsr	r5, r9, #16
	DCD	0xe1844809 ;	orr	r4, r4, r9, lsl #16
	DCD	0xe185580a ;	orr	r5, r5, sl, lsl #16
	DCD	0xe1a06c28 ;	lsr	r6, r8, #24
	DCD	0xe1a07c29 ;	lsr	r7, r9, #24
	DCD	0xe1866409 ;	orr	r6, r6, r9, lsl #8
	DCD	0xe187740a ;	orr	r7, r7, sl, lsl #8
	DCD	0xe59fe2c0 ;	ldr	lr, [pc, #704]	; 1670 <ff_add_pixels_clamped_arm+0x110>
	DCD	0xe3130001 ;	tst	r3, #1
	DCD	0xe004800e ;	and	r8, r4, lr
	DCD	0xe005900e ;	and	r9, r5, lr
	DCD	0xe006a00e ;	and	sl, r6, lr
	DCD	0xe007b00e ;	and	fp, r7, lr
	DCD	0x000ee0ae ;	andeq	lr, lr, lr, lsr #1
	DCD	0xe088800a ;	add	r8, r8, sl
	DCD	0xe089900b ;	add	r9, r9, fp
	DCD	0xe59fc2a0 ;	ldr	ip, [pc, #672]	; 1674 <ff_add_pixels_clamped_arm+0x114>
	DCD	0x0088800e ;	addeq	r8, r8, lr
	DCD	0x0089900e ;	addeq	r9, r9, lr
	DCD	0xe00c4124 ;	and	r4, ip, r4, lsr #2
	DCD	0xe00c5125 ;	and	r5, ip, r5, lsr #2
	DCD	0xe00c6126 ;	and	r6, ip, r6, lsr #2
	DCD	0xe00c7127 ;	and	r7, ip, r7, lsr #2
	DCD	0xe084a006 ;	add	sl, r4, r6
	DCD	0xe085b007 ;	add	fp, r5, r7
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe8bd00f0 ;	pop	{r4, r5, r6, r7}
	DCD	0xe0844008 ;	add	r4, r4, r8
	DCD	0xe0855009 ;	add	r5, r5, r9
	DCD	0xe59fe270 ;	ldr	lr, [pc, #624]	; 1678 <ff_add_pixels_clamped_arm+0x118>
	DCD	0xe086600a ;	add	r6, r6, sl
	DCD	0xe087700b ;	add	r7, r7, fp
	DCD	0xe00e4124 ;	and	r4, lr, r4, lsr #2
	DCD	0xe00e5125 ;	and	r5, lr, r5, lsr #2
	DCD	0xe0844006 ;	add	r4, r4, r6
	DCD	0xe0855007 ;	add	r5, r5, r7
	DCD	0xe8800030 ;	stm	r0, {r4, r5}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0xaaffffd3 ;	bge	1378 <ff_put_no_rnd_pixels8_xy2_arm+0x2f8>
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe89100e0 ;	ldm	r1, {r5, r6, r7}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04c25 ;	lsr	r4, r5, #24
	DCD	0xe1a05c26 ;	lsr	r5, r6, #24
	DCD	0xe1844406 ;	orr	r4, r4, r6, lsl #8
	DCD	0xe1855407 ;	orr	r5, r5, r7, lsl #8
	DCD	0xe59fe20c ;	ldr	lr, [pc, #524]	; 1670 <ff_add_pixels_clamped_arm+0x110>
	DCD	0xe3130001 ;	tst	r3, #1
	DCD	0xe004800e ;	and	r8, r4, lr
	DCD	0xe005900e ;	and	r9, r5, lr
	DCD	0xe006a00e ;	and	sl, r6, lr
	DCD	0xe007b00e ;	and	fp, r7, lr
	DCD	0x000ee0ae ;	andeq	lr, lr, lr, lsr #1
	DCD	0xe088800a ;	add	r8, r8, sl
	DCD	0xe089900b ;	add	r9, r9, fp
	DCD	0xe59fc1ec ;	ldr	ip, [pc, #492]	; 1674 <ff_add_pixels_clamped_arm+0x114>
	DCD	0x0088800e ;	addeq	r8, r8, lr
	DCD	0x0089900e ;	addeq	r9, r9, lr
	DCD	0xe00c4124 ;	and	r4, ip, r4, lsr #2
	DCD	0xe00c5125 ;	and	r5, ip, r5, lsr #2
	DCD	0xe00c6126 ;	and	r6, ip, r6, lsr #2
	DCD	0xe00c7127 ;	and	r7, ip, r7, lsr #2
	DCD	0xe084a006 ;	add	sl, r4, r6
	DCD	0xe085b007 ;	add	fp, r5, r7
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe92d0f00 ;	push	{r8, r9, sl, fp}
	DCD	0xe89100e0 ;	ldm	r1, {r5, r6, r7}
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xe1a04c25 ;	lsr	r4, r5, #24
	DCD	0xe1a05c26 ;	lsr	r5, r6, #24
	DCD	0xe1844406 ;	orr	r4, r4, r6, lsl #8
	DCD	0xe1855407 ;	orr	r5, r5, r7, lsl #8
	DCD	0xe59fe1a0 ;	ldr	lr, [pc, #416]	; 1670 <ff_add_pixels_clamped_arm+0x110>
	DCD	0xe3130001 ;	tst	r3, #1
	DCD	0xe004800e ;	and	r8, r4, lr
	DCD	0xe005900e ;	and	r9, r5, lr
	DCD	0xe006a00e ;	and	sl, r6, lr
	DCD	0xe007b00e ;	and	fp, r7, lr
	DCD	0x000ee0ae ;	andeq	lr, lr, lr, lsr #1
	DCD	0xe088800a ;	add	r8, r8, sl
	DCD	0xe089900b ;	add	r9, r9, fp
	DCD	0xe59fc180 ;	ldr	ip, [pc, #384]	; 1674 <ff_add_pixels_clamped_arm+0x114>
	DCD	0x0088800e ;	addeq	r8, r8, lr
	DCD	0x0089900e ;	addeq	r9, r9, lr
	DCD	0xe00c4124 ;	and	r4, ip, r4, lsr #2
	DCD	0xe00c5125 ;	and	r5, ip, r5, lsr #2
	DCD	0xe00c6126 ;	and	r6, ip, r6, lsr #2
	DCD	0xe00c7127 ;	and	r7, ip, r7, lsr #2
	DCD	0xe084a006 ;	add	sl, r4, r6
	DCD	0xe085b007 ;	add	fp, r5, r7
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe8bd00f0 ;	pop	{r4, r5, r6, r7}
	DCD	0xe0844008 ;	add	r4, r4, r8
	DCD	0xe0855009 ;	add	r5, r5, r9
	DCD	0xe59fe150 ;	ldr	lr, [pc, #336]	; 1678 <ff_add_pixels_clamped_arm+0x118>
	DCD	0xe086600a ;	add	r6, r6, sl
	DCD	0xe087700b ;	add	r7, r7, fp
	DCD	0xe00e4124 ;	and	r4, lr, r4, lsr #2
	DCD	0xe00e5125 ;	and	r5, lr, r5, lsr #2
	DCD	0xe0844006 ;	add	r4, r4, r6
	DCD	0xe0855007 ;	add	r5, r5, r7
	DCD	0xe8800030 ;	stm	r0, {r4, r5}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0xaaffffd7 ;	bge	14a8 <ff_put_no_rnd_pixels8_xy2_arm+0x428>
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	ENDP  ; |ff_put_no_rnd_pixels8_xy2_arm|

|ff_add_pixels_clamped_arm| PROC
	DCD	0xe92d07f0 ;	push	{r4, r5, r6, r7, r8, r9, sl}
	DCD	0xe3a0a008 ;	mov	sl, #8
	DCD	0xe5914000 ;	ldr	r4, [r1]
	DCD	0xe1d050f0 ;	ldrsh	r5, [r0]
	DCD	0xe1d070f2 ;	ldrsh	r7, [r0, #2]
	DCD	0xe20460ff ;	and	r6, r4, #255	; 0xff
	DCD	0xe2048cff ;	and	r8, r4, #65280	; 0xff00
	DCD	0xe0856006 ;	add	r6, r5, r6
	DCD	0xe0878428 ;	add	r8, r7, r8, lsr #8
	DCD	0xe1e05005 ;	mvn	r5, r5
	DCD	0xe1e07007 ;	mvn	r7, r7
	DCD	0xe3160c01 ;	tst	r6, #256	; 0x100
	DCD	0x11a06c25 ;	lsrne	r6, r5, #24
	DCD	0xe3180c01 ;	tst	r8, #256	; 0x100
	DCD	0x11a08c27 ;	lsrne	r8, r7, #24
	DCD	0xe1a09006 ;	mov	r9, r6
	DCD	0xe1d050f4 ;	ldrsh	r5, [r0, #4]
	DCD	0xe1899408 ;	orr	r9, r9, r8, lsl #8
	DCD	0xe1d070f6 ;	ldrsh	r7, [r0, #6]
	DCD	0xe20468ff ;	and	r6, r4, #16711680	; 0xff0000
	DCD	0xe20484ff ;	and	r8, r4, #-16777216	; 0xff000000
	DCD	0xe0856826 ;	add	r6, r5, r6, lsr #16
	DCD	0xe0878c28 ;	add	r8, r7, r8, lsr #24
	DCD	0xe1e05005 ;	mvn	r5, r5
	DCD	0xe1e07007 ;	mvn	r7, r7
	DCD	0xe3160c01 ;	tst	r6, #256	; 0x100
	DCD	0x11a06c25 ;	lsrne	r6, r5, #24
	DCD	0xe3180c01 ;	tst	r8, #256	; 0x100
	DCD	0x11a08c27 ;	lsrne	r8, r7, #24
	DCD	0xe1899806 ;	orr	r9, r9, r6, lsl #16
	DCD	0xe5914004 ;	ldr	r4, [r1, #4]
	DCD	0xe1899c08 ;	orr	r9, r9, r8, lsl #24
	DCD	0xe1d050f8 ;	ldrsh	r5, [r0, #8]
	DCD	0xe5819000 ;	str	r9, [r1]
	DCD	0xe1d070fa ;	ldrsh	r7, [r0, #10]
	DCD	0xe20460ff ;	and	r6, r4, #255	; 0xff
	DCD	0xe2048cff ;	and	r8, r4, #65280	; 0xff00
	DCD	0xe0856006 ;	add	r6, r5, r6
	DCD	0xe0878428 ;	add	r8, r7, r8, lsr #8
	DCD	0xe1e05005 ;	mvn	r5, r5
	DCD	0xe1e07007 ;	mvn	r7, r7
	DCD	0xe3160c01 ;	tst	r6, #256	; 0x100
	DCD	0x11a06c25 ;	lsrne	r6, r5, #24
	DCD	0xe3180c01 ;	tst	r8, #256	; 0x100
	DCD	0x11a08c27 ;	lsrne	r8, r7, #24
	DCD	0xe1a09006 ;	mov	r9, r6
	DCD	0xe1d050fc ;	ldrsh	r5, [r0, #12]
	DCD	0xe1899408 ;	orr	r9, r9, r8, lsl #8
	DCD	0xe1d070fe ;	ldrsh	r7, [r0, #14]
	DCD	0xe20468ff ;	and	r6, r4, #16711680	; 0xff0000
	DCD	0xe20484ff ;	and	r8, r4, #-16777216	; 0xff000000
	DCD	0xe0856826 ;	add	r6, r5, r6, lsr #16
	DCD	0xe0878c28 ;	add	r8, r7, r8, lsr #24
	DCD	0xe1e05005 ;	mvn	r5, r5
	DCD	0xe1e07007 ;	mvn	r7, r7
	DCD	0xe3160c01 ;	tst	r6, #256	; 0x100
	DCD	0x11a06c25 ;	lsrne	r6, r5, #24
	DCD	0xe3180c01 ;	tst	r8, #256	; 0x100
	DCD	0x11a08c27 ;	lsrne	r8, r7, #24
	DCD	0xe1899806 ;	orr	r9, r9, r6, lsl #16
	DCD	0xe2800010 ;	add	r0, r0, #16
	DCD	0xe1899c08 ;	orr	r9, r9, r8, lsl #24
	DCD	0xe25aa001 ;	subs	sl, sl, #1
	DCD	0xe5819004 ;	str	r9, [r1, #4]
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0x1affffbf ;	bne	1568 <ff_add_pixels_clamped_arm+0x8>
	DCD	0xe8bd07f0 ;	pop	{r4, r5, r6, r7, r8, r9, sl}
	DCD	0xe12fff1e ;	bx	lr
	DCD	0x03030303 ;	movweq	r0, #13059	; 0x3303
	DCD	0x3f3f3f3f ;	svccc	0x003f3f3f
	DCD	0x0f0f0f0f ;	svceq	0x000f0f0f
	DCD	0xe1a00000 ;	nop			; (mov r0, r0)
	ENDP  ; |ff_add_pixels_clamped_arm|

	END
