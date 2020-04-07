	CODE32

	IMPORT	|ff_ac3_bin_to_band_tab|
	IMPORT	|ff_ac3_band_start_tab|
	IMPORT	|memset|

	EXPORT	|ff_ac3_bit_alloc_calc_bap_armv6|

	AREA	|.text|, CODE, ARM
|ff_ac3_bit_alloc_calc_bap_armv6| PROC
	DCD	0xe59dc000 ;	ldr	ip, [sp]
	DCD	0xe37c0d0f ;	cmn	ip, #960	; 0x3c0
	DCD	0x0a00002f ;	beq	cc <ff_ac3_bit_alloc_calc_bap_armv6+0xcc>
	DCD	0xe92d4ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, lr}
	DCD	0xe28d5028 ;	add	r5, sp, #40	; 0x28
	DCD	0xe59f40c0 ;	ldr	r4, [pc, #192]	; dc <ff_ac3_bit_alloc_calc_bap_armv6+0xdc>
	DCD	0xe59fe0c0 ;	ldr	lr, [pc, #192]	; e0 <ff_ac3_bit_alloc_calc_bap_armv6+0xe0>
	DCD	0xe89500e0 ;	ldm	r5, {r5, r6, r7}
	DCD	0xe7d44002 ;	ldrb	r4, [r4, r2]
	DCD	0xe0811082 ;	add	r1, r1, r2, lsl #1
	DCD	0xe0800084 ;	add	r0, r0, r4, lsl #1
	DCD	0xe08e4004 ;	add	r4, lr, r4
	DCD	0xe0877002 ;	add	r7, r7, r2
	DCD	0xe4d4a001 ;	ldrb	sl, [r4], #1
	DCD	0xe0d090f2 ;	ldrsh	r9, [r0], #2
	DCD	0xe59f80a0 ;	ldr	r8, [pc, #160]	; e4 <ff_ac3_bit_alloc_calc_bap_armv6+0xe4>
	DCD	0xe049900c ;	sub	r9, r9, ip
	DCD	0xe1a0b00a ;	mov	fp, sl
	DCD	0xe4d4a001 ;	ldrb	sl, [r4], #1
	DCD	0xe0599005 ;	subs	r9, r9, r5
	DCD	0xb3a09000 ;	movlt	r9, #0
	DCD	0xe15a0003 ;	cmp	sl, r3
	DCD	0xe0099008 ;	and	r9, r9, r8
	DCD	0xc043800b ;	subgt	r8, r3, fp
	DCD	0xd04a800b ;	suble	r8, sl, fp
	DCD	0xe0899005 ;	add	r9, r9, r5
	DCD	0xe3180001 ;	tst	r8, #1
	DCD	0xe0872008 ;	add	r2, r7, r8
	DCD	0x1a00000f ;	bne	b4 <ff_ac3_bit_alloc_calc_bap_armv6+0xb4>
	DCD	0xea000009 ;	b	a0 <ff_ac3_bit_alloc_calc_bap_armv6+0xa0>
	DCD	0xe0d180f2 ;	ldrsh	r8, [r1], #2
	DCD	0xe0d1e0f2 ;	ldrsh	lr, [r1], #2
	DCD	0xe0488009 ;	sub	r8, r8, r9
	DCD	0xe04ee009 ;	sub	lr, lr, r9
	DCD	0xe6e682d8 ;	usat	r8, #6, r8, asr #5
	DCD	0xe6e6e2de ;	usat	lr, #6, lr, asr #5
	DCD	0xe7d68008 ;	ldrb	r8, [r6, r8]
	DCD	0xe7d6e00e ;	ldrb	lr, [r6, lr]
	DCD	0xe4c78001 ;	strb	r8, [r7], #1
	DCD	0xe4c7e001 ;	strb	lr, [r7], #1
	DCD	0xe1570002 ;	cmp	r7, r2
	DCD	0x3afffff3 ;	bcc	78 <ff_ac3_bit_alloc_calc_bap_armv6+0x78>
	DCD	0xe153000b ;	cmp	r3, fp
	DCD	0xcaffffe1 ;	bgt	38 <ff_ac3_bit_alloc_calc_bap_armv6+0x38>
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	DCD	0xe0d180f2 ;	ldrsh	r8, [r1], #2
	DCD	0xe0488009 ;	sub	r8, r8, r9
	DCD	0xe6e682d8 ;	usat	r8, #6, r8, asr #5
	DCD	0xe7d68008 ;	ldrb	r8, [r6, r8]
	DCD	0xe4c78001 ;	strb	r8, [r7], #1
	DCD	0xeafffff4 ;	b	a0 <ff_ac3_bit_alloc_calc_bap_armv6+0xa0>
	DCD	0xe59d000c ;	ldr	r0, [sp, #12]
	DCD	0xe3a01000 ;	mov	r1, #0
	DCD	0xe3a02c01 ;	mov	r2, #256	; 0x100
	b	|memset|
;	DCD	0xeafffffe ;	b	0 <memset>
;		d8: R_ARM_JUMP24	memset
	DCD	|ff_ac3_bin_to_band_tab|
	DCD	|ff_ac3_band_start_tab|
;		dc: R_ARM_ABS32	ff_ac3_bin_to_band_tab
;		e0: R_ARM_ABS32	ff_ac3_band_start_tab
	DCD	0x00001fe0 ;	andeq	r1, r0, r0, ror #31
	ENDP  ; |ff_ac3_bit_alloc_calc_bap_armv6|

	END
