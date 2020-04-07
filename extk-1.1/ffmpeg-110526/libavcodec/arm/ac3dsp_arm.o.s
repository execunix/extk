	CODE32

	EXPORT	|ff_ac3_compute_mantissa_size_arm|

	AREA	|.text|, CODE, ARM
|ff_ac3_compute_mantissa_size_arm| PROC
	DCD	0xe92d41f0 ;	push	{r4, r5, r6, r7, r8, lr}
	DCD	0xe89001f0 ;	ldm	r0, {r4, r5, r6, r7, r8}
	DCD	0xe1a03000 ;	mov	r3, r0
	DCD	0xe3a00000 ;	mov	r0, #0
	DCD	0xe4d1e001 ;	ldrb	lr, [r1], #1
	DCD	0xe2522001 ;	subs	r2, r2, #1
	DCD	0xba00000f ;	blt	5c <ff_ac3_compute_mantissa_size_arm+0x5c>
	DCD	0xe35e0004 ;	cmp	lr, #4
	DCD	0xca000008 ;	bgt	48 <ff_ac3_compute_mantissa_size_arm+0x48>
	DCD	0xe25ee001 ;	subs	lr, lr, #1
	DCD	0xb2844001 ;	addlt	r4, r4, #1
	DCD	0x02855001 ;	addeq	r5, r5, #1
	DCD	0xdafffff6 ;	ble	10 <ff_ac3_compute_mantissa_size_arm+0x10>
	DCD	0xe25ee002 ;	subs	lr, lr, #2
	DCD	0xb2866001 ;	addlt	r6, r6, #1
	DCD	0x02877001 ;	addeq	r7, r7, #1
	DCD	0xc2888001 ;	addgt	r8, r8, #1
	DCD	0xeafffff1 ;	b	10 <ff_ac3_compute_mantissa_size_arm+0x10>
	DCD	0xe35e000e ;	cmp	lr, #14
	DCD	0xb24ee001 ;	sublt	lr, lr, #1
	DCD	0xc2800010 ;	addgt	r0, r0, #16
	DCD	0xd080000e ;	addle	r0, r0, lr
	DCD	0xeaffffec ;	b	10 <ff_ac3_compute_mantissa_size_arm+0x10>
	DCD	0xe88301f0 ;	stm	r3, {r4, r5, r6, r7, r8}
	DCD	0xe8bd81f0 ;	pop	{r4, r5, r6, r7, r8, pc}
	ENDP  ; |ff_ac3_compute_mantissa_size_arm|

	END
