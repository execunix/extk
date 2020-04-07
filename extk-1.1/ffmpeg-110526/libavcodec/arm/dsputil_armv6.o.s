	CODE32

	EXPORT	|ff_avg_pixels16_armv6|
	EXPORT	|ff_avg_pixels8_armv6|
	EXPORT	|ff_put_pixels16_x2_armv6|
	EXPORT	|ff_put_pixels8_x2_armv6|
	EXPORT	|ff_put_pixels16_y2_armv6|
	EXPORT	|ff_put_pixels8_y2_armv6|
	EXPORT	|ff_put_pixels16_x2_no_rnd_armv6|
	EXPORT	|ff_put_pixels8_x2_no_rnd_armv6|
	EXPORT	|ff_put_pixels16_y2_no_rnd_armv6|
	EXPORT	|ff_put_pixels8_y2_no_rnd_armv6|
	EXPORT	|ff_put_pixels16_armv6|
	EXPORT	|ff_put_pixels8_armv6|
	EXPORT	|ff_add_pixels_clamped_armv6|
	EXPORT	|ff_get_pixels_armv6|
	EXPORT	|ff_diff_pixels_armv6|
	EXPORT	|ff_pix_abs16_armv6|
	EXPORT	|ff_pix_abs16_x2_armv6|
	EXPORT	|ff_pix_abs16_y2_armv6|
	EXPORT	|ff_pix_abs8_armv6|
	EXPORT	|ff_sse16_armv6|
	EXPORT	|ff_pix_norm1_armv6|
	EXPORT	|ff_pix_sum_armv6|
	
	AREA	|.text|, CODE, ARM
	
|ff_avg_pixels16_armv6| PROC
	DCD	0xe92d400f ;	push	{r0, r1, r2, r3, lr}
	bl	|ff_avg_pixels8_armv6|
;	DCD	0xebfffffe ;	bl	2ac <ff_avg_pixels8_armv6>
;		4: R_ARM_CALL	ff_avg_pixels8_armv6
	DCD	0xe8bd400f ;	pop	{r0, r1, r2, r3, lr}
	DCD	0xe2800008 ;	add	r0, r0, #8
	DCD	0xe2811008 ;	add	r1, r1, #8
	b	|ff_avg_pixels8_armv6|
;	DCD	0xeafffffe ;	b	2ac <ff_avg_pixels8_armv6>
;		14: R_ARM_JUMP24	ff_avg_pixels8_armv6
	ENDP

|ff_put_pixels16_x2_armv6| PROC
	DCD	0xe92d400f ;	push	{r0, r1, r2, r3, lr}
	bl	|ff_put_pixels8_x2_armv6|
;	DCD	0xebfffffe ;	bl	e8 <ff_put_pixels8_x2_armv6>
;		1c: R_ARM_CALL	ff_put_pixels8_x2_armv6
	DCD	0xe8bd400f ;	pop	{r0, r1, r2, r3, lr}
	DCD	0xe2800008 ;	add	r0, r0, #8
	DCD	0xe2811008 ;	add	r1, r1, #8
	b	|ff_put_pixels8_x2_armv6|
;	DCD	0xeafffffe ;	b	e8 <ff_put_pixels8_x2_armv6>
;		2c: R_ARM_JUMP24	ff_put_pixels8_x2_armv6
	ENDP

|ff_put_pixels16_y2_armv6| PROC
	DCD	0xe92d400f ;	push	{r0, r1, r2, r3, lr}
	bl	|ff_put_pixels8_y2_armv6|
;	DCD	0xebfffffe ;	bl	178 <ff_put_pixels8_y2_armv6>
;		34: R_ARM_CALL	ff_put_pixels8_y2_armv6
	DCD	0xe8bd400f ;	pop	{r0, r1, r2, r3, lr}
	DCD	0xe2800008 ;	add	r0, r0, #8
	DCD	0xe2811008 ;	add	r1, r1, #8
	b	|ff_put_pixels8_y2_armv6|
;	DCD	0xeafffffe ;	b	178 <ff_put_pixels8_y2_armv6>
;		44: R_ARM_JUMP24	ff_put_pixels8_y2_armv6
	ENDP

|ff_put_pixels16_x2_no_rnd_armv6| PROC
	DCD	0xe92d400f ;	push	{r0, r1, r2, r3, lr}
	bl	|ff_put_pixels8_x2_no_rnd_armv6|
;	DCD	0xebfffffe ;	bl	200 <ff_put_pixels8_x2_no_rnd_armv6>
;		4c: R_ARM_CALL	ff_put_pixels8_x2_no_rnd_armv6
	DCD	0xe8bd400f ;	pop	{r0, r1, r2, r3, lr}
	DCD	0xe2800008 ;	add	r0, r0, #8
	DCD	0xe2811008 ;	add	r1, r1, #8
	b	|ff_put_pixels8_x2_no_rnd_armv6|
;	DCD	0xeafffffe ;	b	200 <ff_put_pixels8_x2_no_rnd_armv6>
;		5c: R_ARM_JUMP24	ff_put_pixels8_x2_no_rnd_armv6
	ENDP

|ff_put_pixels16_y2_no_rnd_armv6| PROC
	DCD	0xe92d400f ;	push	{r0, r1, r2, r3, lr}
	bl	|ff_put_pixels8_y2_no_rnd_armv6|
;	DCD	0xebfffffe ;	bl	25c <ff_put_pixels8_y2_no_rnd_armv6>
;		64: R_ARM_CALL	ff_put_pixels8_y2_no_rnd_armv6
	DCD	0xe8bd400f ;	pop	{r0, r1, r2, r3, lr}
	DCD	0xe2800008 ;	add	r0, r0, #8
	DCD	0xe2811008 ;	add	r1, r1, #8
	b	|ff_put_pixels8_y2_no_rnd_armv6|
;	DCD	0xeafffffe ;	b	25c <ff_put_pixels8_y2_no_rnd_armv6>
;		74: R_ARM_JUMP24	ff_put_pixels8_y2_no_rnd_armv6
	ENDP

|ff_put_pixels16_armv6| PROC
	DCD	0xe92d0ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp}
	DCD	0xe5915004 ;	ldr	r5, [r1, #4]
	DCD	0xe5916008 ;	ldr	r6, [r1, #8]
	DCD	0xe591700c ;	ldr	r7, [r1, #12]
	DCD	0xe6914002 ;	ldr	r4, [r1], r2
	DCD	0xe1c060f8 ;	strd	r6, [r0, #8]
	DCD	0xe5919004 ;	ldr	r9, [r1, #4]
	DCD	0xe08040f2 ;	strd	r4, [r0], r2
	DCD	0xe591a008 ;	ldr	sl, [r1, #8]
	DCD	0xe591b00c ;	ldr	fp, [r1, #12]
	DCD	0xe6918002 ;	ldr	r8, [r1], r2
	DCD	0xe1c0a0f8 ;	strd	sl, [r0, #8]
	DCD	0xe2533002 ;	subs	r3, r3, #2
	DCD	0xe08080f2 ;	strd	r8, [r0], r2
	DCD	0x1afffff1 ;	bne	7c <ff_put_pixels16_armv6+0x4>
	DCD	0xe8bd0ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp}
	DCD	0xe12fff1e ;	bx	lr
	ENDP

|ff_put_pixels8_armv6| PROC
	DCD	0xe92d00f0 ;	push	{r4, r5, r6, r7}
	DCD	0xe5915004 ;	ldr	r5, [r1, #4]
	DCD	0xe6914002 ;	ldr	r4, [r1], r2
	DCD	0xe5917004 ;	ldr	r7, [r1, #4]
	DCD	0xe08040f2 ;	strd	r4, [r0], r2
	DCD	0xe6916002 ;	ldr	r6, [r1], r2
	DCD	0xe2533002 ;	subs	r3, r3, #2
	DCD	0xe08060f2 ;	strd	r6, [r0], r2
	DCD	0x1afffff7 ;	bne	c0 <ff_put_pixels8_armv6+0x4>
	DCD	0xe8bd00f0 ;	pop	{r4, r5, r6, r7}
	DCD	0xe12fff1e ;	bx	lr
	ENDP

|ff_put_pixels8_x2_armv6| PROC
	DCD	0xe92d4ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, lr}
	DCD	0xe3a0c001 ;	mov	ip, #1
	DCD	0xe18cc40c ;	orr	ip, ip, ip, lsl #8
	DCD	0xe18cc80c ;	orr	ip, ip, ip, lsl #16
	DCD	0xe5914000 ;	ldr	r4, [r1]
	DCD	0xe2533002 ;	subs	r3, r3, #2
	DCD	0xe5915004 ;	ldr	r5, [r1, #4]
	DCD	0xe5917005 ;	ldr	r7, [r1, #5]
	DCD	0xe1a06424 ;	lsr	r6, r4, #8
	DCD	0xe7b18002 ;	ldr	r8, [r1, r2]!
	DCD	0xe1866c05 ;	orr	r6, r6, r5, lsl #24
	DCD	0xe5919004 ;	ldr	r9, [r1, #4]
	DCD	0xe591b005 ;	ldr	fp, [r1, #5]
	DCD	0xe1a0a428 ;	lsr	sl, r8, #8
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xe18aac09 ;	orr	sl, sl, r9, lsl #24
	DCD	0xe024e006 ;	eor	lr, r4, r6
	DCD	0xe6744f96 ;	uhadd8	r4, r4, r6
	DCD	0xe0256007 ;	eor	r6, r5, r7
	DCD	0xe6755f97 ;	uhadd8	r5, r5, r7
	DCD	0xe00ee00c ;	and	lr, lr, ip
	DCD	0xe006600c ;	and	r6, r6, ip
	DCD	0xe6544f9e ;	uadd8	r4, r4, lr
	DCD	0xe028e00a ;	eor	lr, r8, sl
	DCD	0xe6555f96 ;	uadd8	r5, r5, r6
	DCD	0xe029600b ;	eor	r6, r9, fp
	DCD	0xe6788f9a ;	uhadd8	r8, r8, sl
	DCD	0xe00ee00c ;	and	lr, lr, ip
	DCD	0xe6799f9b ;	uhadd8	r9, r9, fp
	DCD	0xe006600c ;	and	r6, r6, ip
	DCD	0xe6588f9e ;	uadd8	r8, r8, lr
	DCD	0xe08040f2 ;	strd	r4, [r0], r2
	DCD	0xe6599f96 ;	uadd8	r9, r9, r6
	DCD	0xe08080f2 ;	strd	r8, [r0], r2
	DCD	0x1affffe0 ;	bne	f8 <ff_put_pixels8_x2_armv6+0x10>
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	ENDP

|ff_put_pixels8_y2_armv6| PROC
	DCD	0xe92d0ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp}
	DCD	0xe3a0c001 ;	mov	ip, #1
	DCD	0xe18cc40c ;	orr	ip, ip, ip, lsl #8
	DCD	0xe18cc80c ;	orr	ip, ip, ip, lsl #16
	DCD	0xe5914000 ;	ldr	r4, [r1]
	DCD	0xe5915004 ;	ldr	r5, [r1, #4]
	DCD	0xe7b16002 ;	ldr	r6, [r1, r2]!
	DCD	0xe5917004 ;	ldr	r7, [r1, #4]
	DCD	0xe2533002 ;	subs	r3, r3, #2
	DCD	0xe6748f96 ;	uhadd8	r8, r4, r6
	DCD	0xe024a006 ;	eor	sl, r4, r6
	DCD	0xe6759f97 ;	uhadd8	r9, r5, r7
	DCD	0xe025b007 ;	eor	fp, r5, r7
	DCD	0xe00aa00c ;	and	sl, sl, ip
	DCD	0xe7b14002 ;	ldr	r4, [r1, r2]!
	DCD	0xe6588f9a ;	uadd8	r8, r8, sl
	DCD	0xe00bb00c ;	and	fp, fp, ip
	DCD	0xe6599f9b ;	uadd8	r9, r9, fp
	DCD	0xe5915004 ;	ldr	r5, [r1, #4]
	DCD	0xe674af96 ;	uhadd8	sl, r4, r6
	DCD	0xe0246006 ;	eor	r6, r4, r6
	DCD	0xe675bf97 ;	uhadd8	fp, r5, r7
	DCD	0xe006600c ;	and	r6, r6, ip
	DCD	0xe0257007 ;	eor	r7, r5, r7
	DCD	0xe65aaf96 ;	uadd8	sl, sl, r6
	DCD	0xe007700c ;	and	r7, r7, ip
	DCD	0xe7b16002 ;	ldr	r6, [r1, r2]!
	DCD	0xe65bbf97 ;	uadd8	fp, fp, r7
	DCD	0xe08080f2 ;	strd	r8, [r0], r2
	DCD	0xe5917004 ;	ldr	r7, [r1, #4]
	DCD	0xe080a0f2 ;	strd	sl, [r0], r2
	DCD	0x1affffe7 ;	bne	198 <ff_put_pixels8_y2_armv6+0x20>
	DCD	0xe8bd0ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp}
	DCD	0xe12fff1e ;	bx	lr
	ENDP

|ff_put_pixels8_x2_no_rnd_armv6| PROC
	DCD	0xe92d43f0 ;	push	{r4, r5, r6, r7, r8, r9, lr}
	DCD	0xe2533002 ;	subs	r3, r3, #2
	DCD	0xe5914000 ;	ldr	r4, [r1]
	DCD	0xe5915004 ;	ldr	r5, [r1, #4]
	DCD	0xe5917005 ;	ldr	r7, [r1, #5]
	DCD	0xe7b18002 ;	ldr	r8, [r1, r2]!
	DCD	0xe5919004 ;	ldr	r9, [r1, #4]
	DCD	0xe591e005 ;	ldr	lr, [r1, #5]
	DCD	0xe0811002 ;	add	r1, r1, r2
	DCD	0xe1a06424 ;	lsr	r6, r4, #8
	DCD	0xe1866c05 ;	orr	r6, r6, r5, lsl #24
	DCD	0xe1a0c428 ;	lsr	ip, r8, #8
	DCD	0xe18ccc09 ;	orr	ip, ip, r9, lsl #24
	DCD	0xe6744f96 ;	uhadd8	r4, r4, r6
	DCD	0xe6755f97 ;	uhadd8	r5, r5, r7
	DCD	0xe6788f9c ;	uhadd8	r8, r8, ip
	DCD	0xe6799f9e ;	uhadd8	r9, r9, lr
	DCD	0xe8800030 ;	stm	r0, {r4, r5}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0xe8800300 ;	stm	r0, {r8, r9}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0x1affffea ;	bne	204 <ff_put_pixels8_x2_no_rnd_armv6+0x4>
	DCD	0xe8bd83f0 ;	pop	{r4, r5, r6, r7, r8, r9, pc}
	ENDP

|ff_put_pixels8_y2_no_rnd_armv6| PROC
	DCD	0xe92d43f0 ;	push	{r4, r5, r6, r7, r8, r9, lr}
	DCD	0xe5914000 ;	ldr	r4, [r1]
	DCD	0xe5915004 ;	ldr	r5, [r1, #4]
	DCD	0xe7b16002 ;	ldr	r6, [r1, r2]!
	DCD	0xe5917004 ;	ldr	r7, [r1, #4]
	DCD	0xe2533002 ;	subs	r3, r3, #2
	DCD	0xe6748f96 ;	uhadd8	r8, r4, r6
	DCD	0xe7b14002 ;	ldr	r4, [r1, r2]!
	DCD	0xe6759f97 ;	uhadd8	r9, r5, r7
	DCD	0xe5915004 ;	ldr	r5, [r1, #4]
	DCD	0xe674cf96 ;	uhadd8	ip, r4, r6
	DCD	0xe7b16002 ;	ldr	r6, [r1, r2]!
	DCD	0xe675ef97 ;	uhadd8	lr, r5, r7
	DCD	0xe5917004 ;	ldr	r7, [r1, #4]
	DCD	0xe8800300 ;	stm	r0, {r8, r9}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0xe8805000 ;	stm	r0, {ip, lr}
	DCD	0xe0800002 ;	add	r0, r0, r2
	DCD	0x1afffff1 ;	bne	270 <ff_put_pixels8_y2_no_rnd_armv6+0x14>
	DCD	0xe8bd83f0 ;	pop	{r4, r5, r6, r7, r8, r9, pc}
	ENDP

|ff_avg_pixels8_armv6| PROC
	DCD	0xf7d1f002 ;	pld	[r1, r2]
	DCD	0xe92d47f0 ;	push	{r4, r5, r6, r7, r8, r9, sl, lr}
	DCD	0xe3a0e001 ;	mov	lr, #1
	DCD	0xe18ee40e ;	orr	lr, lr, lr, lsl #8
	DCD	0xe18ee80e ;	orr	lr, lr, lr, lsl #16
	DCD	0xe1c040d0 ;	ldrd	r4, [r0]
	DCD	0xe591a004 ;	ldr	sl, [r1, #4]
	DCD	0xe6919002 ;	ldr	r9, [r1], r2
	DCD	0xe2533002 ;	subs	r3, r3, #2
	DCD	0xf7d1f002 ;	pld	[r1, r2]
	DCD	0xe0248009 ;	eor	r8, r4, r9
	DCD	0xe6744f99 ;	uhadd8	r4, r4, r9
	DCD	0xe025c00a ;	eor	ip, r5, sl
	DCD	0xe18060d2 ;	ldrd	r6, [r0, r2]
	DCD	0xe6755f9a ;	uhadd8	r5, r5, sl
	DCD	0xe008800e ;	and	r8, r8, lr
	DCD	0xe591a004 ;	ldr	sl, [r1, #4]
	DCD	0xe00cc00e ;	and	ip, ip, lr
	DCD	0xe6544f98 ;	uadd8	r4, r4, r8
	DCD	0xe6919002 ;	ldr	r9, [r1], r2
	DCD	0xe0268009 ;	eor	r8, r6, r9
	DCD	0xe6555f9c ;	uadd8	r5, r5, ip
	DCD	0xf7d1f082 ;	pld	[r1, r2, lsl #1]
	DCD	0xe027c00a ;	eor	ip, r7, sl
	DCD	0xe6766f99 ;	uhadd8	r6, r6, r9
	DCD	0xe08040f2 ;	strd	r4, [r0], r2
	DCD	0xe6777f9a ;	uhadd8	r7, r7, sl
	DCD	0x0a000009 ;	beq	344 <ff_avg_pixels8_armv6+0x98>
	DCD	0xe008800e ;	and	r8, r8, lr
	DCD	0xe18040d2 ;	ldrd	r4, [r0, r2]
	DCD	0xe6566f98 ;	uadd8	r6, r6, r8
	DCD	0xe591a004 ;	ldr	sl, [r1, #4]
	DCD	0xe00cc00e ;	and	ip, ip, lr
	DCD	0xe2533002 ;	subs	r3, r3, #2
	DCD	0xe6577f9c ;	uadd8	r7, r7, ip
	DCD	0xe6919002 ;	ldr	r9, [r1], r2
	DCD	0xe08060f2 ;	strd	r6, [r0], r2
	DCD	0xeaffffe2 ;	b	2d0 <ff_avg_pixels8_armv6+0x24>
	DCD	0xe008800e ;	and	r8, r8, lr
	DCD	0xe00cc00e ;	and	ip, ip, lr
	DCD	0xe6566f98 ;	uadd8	r6, r6, r8
	DCD	0xe6577f9c ;	uadd8	r7, r7, ip
	DCD	0xe08060f2 ;	strd	r6, [r0], r2
	DCD	0xe8bd87f0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, pc}
	ENDP

|ff_add_pixels_clamped_armv6| PROC
	DCD	0xe92d41f0 ;	push	{r4, r5, r6, r7, r8, lr}
	DCD	0xe3a03008 ;	mov	r3, #8
	DCD	0xe8b05030 ;	ldm	r0!, {r4, r5, ip, lr}
	DCD	0xe1c160d0 ;	ldrd	r6, [r1]
	DCD	0xe6848815 ;	pkhbt	r8, r4, r5, lsl #16
	DCD	0xe6855854 ;	pkhtb	r5, r5, r4, asr #16
	DCD	0xe68c481e ;	pkhbt	r4, ip, lr, lsl #16
	DCD	0xe68ee85c ;	pkhtb	lr, lr, ip, asr #16
	DCD	0xf7d1f002 ;	pld	[r1, r2]
	DCD	0xe6c88076 ;	uxtab16	r8, r8, r6
	DCD	0xe6c55476 ;	uxtab16	r5, r5, r6, ror #8
	DCD	0xe6c44077 ;	uxtab16	r4, r4, r7
	DCD	0xe6cee477 ;	uxtab16	lr, lr, r7, ror #8
	DCD	0xe6e88f38 ;	usat16	r8, #8, r8
	DCD	0xe6e85f35 ;	usat16	r5, #8, r5
	DCD	0xe6e84f34 ;	usat16	r4, #8, r4
	DCD	0xe6e8ef3e ;	usat16	lr, #8, lr
	DCD	0xe1886405 ;	orr	r6, r8, r5, lsl #8
	DCD	0xe184740e ;	orr	r7, r4, lr, lsl #8
	DCD	0xe2533001 ;	subs	r3, r3, #1
	DCD	0xe08160f2 ;	strd	r6, [r1], r2
	DCD	0xcaffffeb ;	bgt	364 <ff_add_pixels_clamped_armv6+0x8>
	DCD	0xe8bd81f0 ;	pop	{r4, r5, r6, r7, r8, pc}
	ENDP

|ff_get_pixels_armv6| PROC
	DCD	0xf7d1f002 ;	pld	[r1, r2]
	DCD	0xe92d41f0 ;	push	{r4, r5, r6, r7, r8, lr}
	DCD	0xe3a0e008 ;	mov	lr, #8
	DCD	0xe08140d2 ;	ldrd	r4, [r1], r2
	DCD	0xe25ee001 ;	subs	lr, lr, #1
	DCD	0xe6cf6074 ;	uxtb16	r6, r4
	DCD	0xe6cf4474 ;	uxtb16	r4, r4, ror #8
	DCD	0xe6cfc075 ;	uxtb16	ip, r5
	DCD	0xe6cf8475 ;	uxtb16	r8, r5, ror #8
	DCD	0xf7d1f002 ;	pld	[r1, r2]
	DCD	0xe6865814 ;	pkhbt	r5, r6, r4, lsl #16
	DCD	0xe6846856 ;	pkhtb	r6, r4, r6, asr #16
	DCD	0xe68c7818 ;	pkhbt	r7, ip, r8, lsl #16
	DCD	0xe688c85c ;	pkhtb	ip, r8, ip, asr #16
	DCD	0xe8a010e0 ;	stmia	r0!, {r5, r6, r7, ip}
	DCD	0xcafffff2 ;	bgt	3c4 <ff_get_pixels_armv6+0xc>
	DCD	0xe8bd81f0 ;	pop	{r4, r5, r6, r7, r8, pc}
	ENDP

|ff_diff_pixels_armv6| PROC
	DCD	0xf7d1f003 ;	pld	[r1, r3]
	DCD	0xf7d2f003 ;	pld	[r2, r3]
	DCD	0xe92d43f0 ;	push	{r4, r5, r6, r7, r8, r9, lr}
	DCD	0xe3a0e008 ;	mov	lr, #8
	DCD	0xe08140d3 ;	ldrd	r4, [r1], r3
	DCD	0xe08260d3 ;	ldrd	r6, [r2], r3
	DCD	0xe6cf8074 ;	uxtb16	r8, r4
	DCD	0xe6cf4474 ;	uxtb16	r4, r4, ror #8
	DCD	0xe6cf9076 ;	uxtb16	r9, r6
	DCD	0xe6cf6476 ;	uxtb16	r6, r6, ror #8
	DCD	0xf7d1f003 ;	pld	[r1, r3]
	DCD	0xe6189f79 ;	ssub16	r9, r8, r9
	DCD	0xe6146f76 ;	ssub16	r6, r4, r6
	DCD	0xe6cf8075 ;	uxtb16	r8, r5
	DCD	0xe6cf5475 ;	uxtb16	r5, r5, ror #8
	DCD	0xf7d2f003 ;	pld	[r2, r3]
	DCD	0xe6894816 ;	pkhbt	r4, r9, r6, lsl #16
	DCD	0xe6866859 ;	pkhtb	r6, r6, r9, asr #16
	DCD	0xe6cf9077 ;	uxtb16	r9, r7
	DCD	0xe6cf7477 ;	uxtb16	r7, r7, ror #8
	DCD	0xe6189f79 ;	ssub16	r9, r8, r9
	DCD	0xe6155f77 ;	ssub16	r5, r5, r7
	DCD	0xe25ee001 ;	subs	lr, lr, #1
	DCD	0xe6898815 ;	pkhbt	r8, r9, r5, lsl #16
	DCD	0xe6859859 ;	pkhtb	r9, r5, r9, asr #16
	DCD	0xe8a00350 ;	stmia	r0!, {r4, r6, r8, r9}
	DCD	0xcaffffe8 ;	bgt	40c <ff_diff_pixels_armv6+0x10>
	DCD	0xe8bd83f0 ;	pop	{r4, r5, r6, r7, r8, r9, pc}
	ENDP

|ff_pix_abs16_armv6| PROC
	DCD	0xe59d0000 ;	ldr	r0, [sp]
	DCD	0xe92d43f0 ;	push	{r4, r5, r6, r7, r8, r9, lr}
	DCD	0xe3a0c000 ;	mov	ip, #0
	DCD	0xe3a0e000 ;	mov	lr, #0
	DCD	0xe89100f0 ;	ldm	r1, {r4, r5, r6, r7}
	DCD	0xe5928000 ;	ldr	r8, [r2]
	DCD	0xe5929004 ;	ldr	r9, [r2, #4]
	DCD	0xf7d1f003 ;	pld	[r1, r3]
	DCD	0xe78cc814 ;	usada8	ip, r4, r8, ip
	DCD	0xe5928008 ;	ldr	r8, [r2, #8]
	DCD	0xf7d2f003 ;	pld	[r2, r3]
	DCD	0xe78ee915 ;	usada8	lr, r5, r9, lr
	DCD	0xe592900c ;	ldr	r9, [r2, #12]
	DCD	0xe78cc816 ;	usada8	ip, r6, r8, ip
	DCD	0xe2500001 ;	subs	r0, r0, #1
	DCD	0xe78ee917 ;	usada8	lr, r7, r9, lr
	DCD	0x0a000004 ;	beq	4c4 <ff_pix_abs16_armv6+0x58>
	DCD	0xe0811003 ;	add	r1, r1, r3
	DCD	0xe89100f0 ;	ldm	r1, {r4, r5, r6, r7}
	DCD	0xe0822003 ;	add	r2, r2, r3
	DCD	0xe5928000 ;	ldr	r8, [r2]
	DCD	0xeaffffef ;	b	484 <ff_pix_abs16_armv6+0x18>
	DCD	0xe08c000e ;	add	r0, ip, lr
	DCD	0xe8bd83f0 ;	pop	{r4, r5, r6, r7, r8, r9, pc}
	ENDP

|ff_pix_abs16_x2_armv6| PROC
	DCD	0xe59dc000 ;	ldr	ip, [sp]
	DCD	0xe92d4ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, lr}
	DCD	0xe3a00000 ;	mov	r0, #0
	DCD	0xe3a0e001 ;	mov	lr, #1
	DCD	0xe18ee40e ;	orr	lr, lr, lr, lsl #8
	DCD	0xe18ee80e ;	orr	lr, lr, lr, lsl #16
	DCD	0xe5928000 ;	ldr	r8, [r2]
	DCD	0xe5929004 ;	ldr	r9, [r2, #4]
	DCD	0xe1a0a428 ;	lsr	sl, r8, #8
	DCD	0xe5914000 ;	ldr	r4, [r1]
	DCD	0xe1a06429 ;	lsr	r6, r9, #8
	DCD	0xe18aac09 ;	orr	sl, sl, r9, lsl #24
	DCD	0xe5925008 ;	ldr	r5, [r2, #8]
	DCD	0xe028b00a ;	eor	fp, r8, sl
	DCD	0xe6787f9a ;	uhadd8	r7, r8, sl
	DCD	0xe1866c05 ;	orr	r6, r6, r5, lsl #24
	DCD	0xe00bb00e ;	and	fp, fp, lr
	DCD	0xe6577f9b ;	uadd8	r7, r7, fp
	DCD	0xe5918004 ;	ldr	r8, [r1, #4]
	DCD	0xe7800714 ;	usada8	r0, r4, r7, r0
	DCD	0xe0297006 ;	eor	r7, r9, r6
	DCD	0xe1a0a425 ;	lsr	sl, r5, #8
	DCD	0xe007700e ;	and	r7, r7, lr
	DCD	0xe6794f96 ;	uhadd8	r4, r9, r6
	DCD	0xe592600c ;	ldr	r6, [r2, #12]
	DCD	0xe6544f97 ;	uadd8	r4, r4, r7
	DCD	0xf7d1f003 ;	pld	[r1, r3]
	DCD	0xe18aac06 ;	orr	sl, sl, r6, lsl #24
	DCD	0xe7800418 ;	usada8	r0, r8, r4, r0
	DCD	0xe5914008 ;	ldr	r4, [r1, #8]
	DCD	0xe025b00a ;	eor	fp, r5, sl
	DCD	0xe5d27010 ;	ldrb	r7, [r2, #16]
	DCD	0xe00bb00e ;	and	fp, fp, lr
	DCD	0xe6758f9a ;	uhadd8	r8, r5, sl
	DCD	0xe591500c ;	ldr	r5, [r1, #12]
	DCD	0xe6588f9b ;	uadd8	r8, r8, fp
	DCD	0xf7d2f003 ;	pld	[r2, r3]
	DCD	0xe1a0a426 ;	lsr	sl, r6, #8
	DCD	0xe7800814 ;	usada8	r0, r4, r8, r0
	DCD	0xe18aac07 ;	orr	sl, sl, r7, lsl #24
	DCD	0xe25cc001 ;	subs	ip, ip, #1
	DCD	0xe026b00a ;	eor	fp, r6, sl
	DCD	0xe0811003 ;	add	r1, r1, r3
	DCD	0xe6769f9a ;	uhadd8	r9, r6, sl
	DCD	0xe00bb00e ;	and	fp, fp, lr
	DCD	0xe6599f9b ;	uadd8	r9, r9, fp
	DCD	0xe0822003 ;	add	r2, r2, r3
	DCD	0xe7800915 ;	usada8	r0, r5, r9, r0
	DCD	0xcaffffd4 ;	bgt	4e4 <ff_pix_abs16_x2_armv6+0x18>
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	ENDP

|ff_pix_abs16_y2_armv6| PROC
	DCD	0xf5d1f000 ;	pld	[r1]
	DCD	0xf5d2f000 ;	pld	[r2]
	DCD	0xe59dc000 ;	ldr	ip, [sp]
	DCD	0xe92d4ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, lr}
	DCD	0xe3a00000 ;	mov	r0, #0
	DCD	0xe3a0e001 ;	mov	lr, #1
	DCD	0xe18ee40e ;	orr	lr, lr, lr, lsl #8
	DCD	0xe18ee80e ;	orr	lr, lr, lr, lsl #16
	DCD	0xe5924000 ;	ldr	r4, [r2]
	DCD	0xe5925004 ;	ldr	r5, [r2, #4]
	DCD	0xe5926008 ;	ldr	r6, [r2, #8]
	DCD	0xe592700c ;	ldr	r7, [r2, #12]
	DCD	0xe0822003 ;	add	r2, r2, r3
	DCD	0xe5928000 ;	ldr	r8, [r2]
	DCD	0xe0249008 ;	eor	r9, r4, r8
	DCD	0xe6744f98 ;	uhadd8	r4, r4, r8
	DCD	0xe009900e ;	and	r9, r9, lr
	DCD	0xe591a000 ;	ldr	sl, [r1]
	DCD	0xe6544f99 ;	uadd8	r4, r4, r9
	DCD	0xe5929004 ;	ldr	r9, [r2, #4]
	DCD	0xe7800a14 ;	usada8	r0, r4, sl, r0
	DCD	0xf7d1f003 ;	pld	[r1, r3]
	DCD	0xe025b009 ;	eor	fp, r5, r9
	DCD	0xe6755f99 ;	uhadd8	r5, r5, r9
	DCD	0xe00bb00e ;	and	fp, fp, lr
	DCD	0xe5914004 ;	ldr	r4, [r1, #4]
	DCD	0xe6555f9b ;	uadd8	r5, r5, fp
	DCD	0xe592a008 ;	ldr	sl, [r2, #8]
	DCD	0xe7800415 ;	usada8	r0, r5, r4, r0
	DCD	0xf7d2f003 ;	pld	[r2, r3]
	DCD	0xe026400a ;	eor	r4, r6, sl
	DCD	0xe6766f9a ;	uhadd8	r6, r6, sl
	DCD	0xe004400e ;	and	r4, r4, lr
	DCD	0xe5915008 ;	ldr	r5, [r1, #8]
	DCD	0xe6566f94 ;	uadd8	r6, r6, r4
	DCD	0xe592b00c ;	ldr	fp, [r2, #12]
	DCD	0xe7800516 ;	usada8	r0, r6, r5, r0
	DCD	0xe027500b ;	eor	r5, r7, fp
	DCD	0xe6777f9b ;	uhadd8	r7, r7, fp
	DCD	0xe005500e ;	and	r5, r5, lr
	DCD	0xe591400c ;	ldr	r4, [r1, #12]
	DCD	0xe6577f95 ;	uadd8	r7, r7, r5
	DCD	0xe0811003 ;	add	r1, r1, r3
	DCD	0xe7800417 ;	usada8	r0, r7, r4, r0
	DCD	0xe0822003 ;	add	r2, r2, r3
	DCD	0xe25cc002 ;	subs	ip, ip, #2
	DCD	0xe5924000 ;	ldr	r4, [r2]
	DCD	0xe0285004 ;	eor	r5, r8, r4
	DCD	0xe6788f94 ;	uhadd8	r8, r8, r4
	DCD	0xe005500e ;	and	r5, r5, lr
	DCD	0xe5916000 ;	ldr	r6, [r1]
	DCD	0xe6588f95 ;	uadd8	r8, r8, r5
	DCD	0xe5925004 ;	ldr	r5, [r2, #4]
	DCD	0xe7800618 ;	usada8	r0, r8, r6, r0
	DCD	0xf7d1f003 ;	pld	[r1, r3]
	DCD	0xe0297005 ;	eor	r7, r9, r5
	DCD	0xe6799f95 ;	uhadd8	r9, r9, r5
	DCD	0xe007700e ;	and	r7, r7, lr
	DCD	0xe5918004 ;	ldr	r8, [r1, #4]
	DCD	0xe6599f97 ;	uadd8	r9, r9, r7
	DCD	0xe5926008 ;	ldr	r6, [r2, #8]
	DCD	0xe7800819 ;	usada8	r0, r9, r8, r0
	DCD	0xf7d2f003 ;	pld	[r2, r3]
	DCD	0xe02a8006 ;	eor	r8, sl, r6
	DCD	0xe67aaf96 ;	uhadd8	sl, sl, r6
	DCD	0xe008800e ;	and	r8, r8, lr
	DCD	0xe5919008 ;	ldr	r9, [r1, #8]
	DCD	0xe65aaf98 ;	uadd8	sl, sl, r8
	DCD	0xe592700c ;	ldr	r7, [r2, #12]
	DCD	0xe780091a ;	usada8	r0, sl, r9, r0
	DCD	0xe02b9007 ;	eor	r9, fp, r7
	DCD	0xe67bbf97 ;	uhadd8	fp, fp, r7
	DCD	0xe009900e ;	and	r9, r9, lr
	DCD	0xe591800c ;	ldr	r8, [r1, #12]
	DCD	0xe65bbf99 ;	uadd8	fp, fp, r9
	DCD	0xe0811003 ;	add	r1, r1, r3
	DCD	0xe780081b ;	usada8	r0, fp, r8, r0
	DCD	0xe0822003 ;	add	r2, r2, r3
	DCD	0xcaffffbd ;	bgt	5c8 <ff_pix_abs16_y2_armv6+0x34>
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	ENDP

|ff_pix_abs8_armv6| PROC
	DCD	0xf7d2f003 ;	pld	[r2, r3]
	DCD	0xe59dc000 ;	ldr	ip, [sp]
	DCD	0xe92d43f0 ;	push	{r4, r5, r6, r7, r8, r9, lr}
	DCD	0xe3a00000 ;	mov	r0, #0
	DCD	0xe3a0e000 ;	mov	lr, #0
	DCD	0xe08140d3 ;	ldrd	r4, [r1], r3
	DCD	0xe25cc002 ;	subs	ip, ip, #2
	DCD	0xe5927004 ;	ldr	r7, [r2, #4]
	DCD	0xe6926003 ;	ldr	r6, [r2], r3
	DCD	0xe08180d3 ;	ldrd	r8, [r1], r3
	DCD	0xe7800614 ;	usada8	r0, r4, r6, r0
	DCD	0xf7d2f003 ;	pld	[r2, r3]
	DCD	0xe78ee715 ;	usada8	lr, r5, r7, lr
	DCD	0xe5927004 ;	ldr	r7, [r2, #4]
	DCD	0xe6926003 ;	ldr	r6, [r2], r3
	DCD	0x0a000004 ;	beq	728 <ff_pix_abs8_armv6+0x54>
	DCD	0xe08140d3 ;	ldrd	r4, [r1], r3
	DCD	0xe7800618 ;	usada8	r0, r8, r6, r0
	DCD	0xf7d2f003 ;	pld	[r2, r3]
	DCD	0xe78ee719 ;	usada8	lr, r9, r7, lr
	DCD	0xeafffff0 ;	b	6ec <ff_pix_abs8_armv6+0x18>
	DCD	0xe7800618 ;	usada8	r0, r8, r6, r0
	DCD	0xe78ee719 ;	usada8	lr, r9, r7, lr
	DCD	0xe080000e ;	add	r0, r0, lr
	DCD	0xe8bd83f0 ;	pop	{r4, r5, r6, r7, r8, r9, pc}
	ENDP

|ff_sse16_armv6| PROC
	DCD	0xe59dc000 ;	ldr	ip, [sp]
	DCD	0xe92d43f0 ;	push	{r4, r5, r6, r7, r8, r9, lr}
	DCD	0xe3a00000 ;	mov	r0, #0
	DCD	0xe1c140d0 ;	ldrd	r4, [r1]
	DCD	0xe5928000 ;	ldr	r8, [r2]
	DCD	0xe6cfe074 ;	uxtb16	lr, r4
	DCD	0xe6cf4474 ;	uxtb16	r4, r4, ror #8
	DCD	0xe6cf9078 ;	uxtb16	r9, r8
	DCD	0xe6cf8478 ;	uxtb16	r8, r8, ror #8
	DCD	0xe5927004 ;	ldr	r7, [r2, #4]
	DCD	0xe65eef79 ;	usub16	lr, lr, r9
	DCD	0xe6544f78 ;	usub16	r4, r4, r8
	DCD	0xe7000e1e ;	smlad	r0, lr, lr, r0
	DCD	0xe6cf6075 ;	uxtb16	r6, r5
	DCD	0xe6cfe475 ;	uxtb16	lr, r5, ror #8
	DCD	0xe6cf8077 ;	uxtb16	r8, r7
	DCD	0xe6cf9477 ;	uxtb16	r9, r7, ror #8
	DCD	0xe7000414 ;	smlad	r0, r4, r4, r0
	DCD	0xe1c140d8 ;	ldrd	r4, [r1, #8]
	DCD	0xe6566f78 ;	usub16	r6, r6, r8
	DCD	0xe65e8f79 ;	usub16	r8, lr, r9
	DCD	0xe5927008 ;	ldr	r7, [r2, #8]
	DCD	0xe7000616 ;	smlad	r0, r6, r6, r0
	DCD	0xe6cfe074 ;	uxtb16	lr, r4
	DCD	0xe6cf4474 ;	uxtb16	r4, r4, ror #8
	DCD	0xe6cf9077 ;	uxtb16	r9, r7
	DCD	0xe6cf7477 ;	uxtb16	r7, r7, ror #8
	DCD	0xe7000818 ;	smlad	r0, r8, r8, r0
	DCD	0xe592800c ;	ldr	r8, [r2, #12]
	DCD	0xe65eef79 ;	usub16	lr, lr, r9
	DCD	0xe6544f77 ;	usub16	r4, r4, r7
	DCD	0xe7000e1e ;	smlad	r0, lr, lr, r0
	DCD	0xe6cf6075 ;	uxtb16	r6, r5
	DCD	0xe6cf5475 ;	uxtb16	r5, r5, ror #8
	DCD	0xe6cf9078 ;	uxtb16	r9, r8
	DCD	0xe6cf8478 ;	uxtb16	r8, r8, ror #8
	DCD	0xe7000414 ;	smlad	r0, r4, r4, r0
	DCD	0xe6566f79 ;	usub16	r6, r6, r9
	DCD	0xe6555f78 ;	usub16	r5, r5, r8
	DCD	0xe7000616 ;	smlad	r0, r6, r6, r0
	DCD	0xe0811003 ;	add	r1, r1, r3
	DCD	0xe0822003 ;	add	r2, r2, r3
	DCD	0xe25cc001 ;	subs	ip, ip, #1
	DCD	0xe7000515 ;	smlad	r0, r5, r5, r0
	DCD	0xcaffffd5 ;	bgt	744 <ff_sse16_armv6+0xc>
	DCD	0xe8bd83f0 ;	pop	{r4, r5, r6, r7, r8, r9, pc}
	ENDP

|ff_pix_norm1_armv6| PROC
	DCD	0xe92d4070 ;	push	{r4, r5, r6, lr}
	DCD	0xe3a0c010 ;	mov	ip, #16
	DCD	0xe3a0e000 ;	mov	lr, #0
	DCD	0xe890003c ;	ldm	r0, {r2, r3, r4, r5}
	DCD	0xe6cf6072 ;	uxtb16	r6, r2
	DCD	0xe6cf2472 ;	uxtb16	r2, r2, ror #8
	DCD	0xe70ee616 ;	smlad	lr, r6, r6, lr
	DCD	0xe6cf6073 ;	uxtb16	r6, r3
	DCD	0xe70ee212 ;	smlad	lr, r2, r2, lr
	DCD	0xe6cf3473 ;	uxtb16	r3, r3, ror #8
	DCD	0xe70ee616 ;	smlad	lr, r6, r6, lr
	DCD	0xe6cf6074 ;	uxtb16	r6, r4
	DCD	0xe70ee313 ;	smlad	lr, r3, r3, lr
	DCD	0xe6cf4474 ;	uxtb16	r4, r4, ror #8
	DCD	0xe70ee616 ;	smlad	lr, r6, r6, lr
	DCD	0xe6cf6075 ;	uxtb16	r6, r5
	DCD	0xe70ee414 ;	smlad	lr, r4, r4, lr
	DCD	0xe6cf5475 ;	uxtb16	r5, r5, ror #8
	DCD	0xe70ee616 ;	smlad	lr, r6, r6, lr
	DCD	0xe25cc001 ;	subs	ip, ip, #1
	DCD	0xe0800001 ;	add	r0, r0, r1
	DCD	0xe70ee515 ;	smlad	lr, r5, r5, lr
	DCD	0xcaffffeb ;	bgt	7fc <ff_pix_norm1_armv6+0xc>
	DCD	0xe1a0000e ;	mov	r0, lr
	DCD	0xe8bd8070 ;	pop	{r4, r5, r6, pc}
	ENDP

|ff_pix_sum_armv6| PROC
	DCD	0xe92d40f0 ;	push	{r4, r5, r6, r7, lr}
	DCD	0xe3a0c010 ;	mov	ip, #16
	DCD	0xe3a02000 ;	mov	r2, #0
	DCD	0xe3a03000 ;	mov	r3, #0
	DCD	0xe3a0e000 ;	mov	lr, #0
	DCD	0xe5904000 ;	ldr	r4, [r0]
	DCD	0xe25cc001 ;	subs	ip, ip, #1
	DCD	0xe5905004 ;	ldr	r5, [r0, #4]
	DCD	0xe7822e14 ;	usada8	r2, r4, lr, r2
	DCD	0xe5906008 ;	ldr	r6, [r0, #8]
	DCD	0xe7833e15 ;	usada8	r3, r5, lr, r3
	DCD	0xe590700c ;	ldr	r7, [r0, #12]
	DCD	0xe7822e16 ;	usada8	r2, r6, lr, r2
	DCD	0x0a000002 ;	beq	898 <ff_pix_sum_armv6+0x44>
	DCD	0xe7b04001 ;	ldr	r4, [r0, r1]!
	DCD	0xe7833e17 ;	usada8	r3, r7, lr, r3
	DCD	0xcafffff4 ;	bgt	86c <ff_pix_sum_armv6+0x18>
	DCD	0xe7833e17 ;	usada8	r3, r7, lr, r3
	DCD	0xe0820003 ;	add	r0, r2, r3
	DCD	0xe8bd80f0 ;	pop	{r4, r5, r6, r7, pc}
	ENDP

	END
