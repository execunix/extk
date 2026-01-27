	CODE32

	EXPORT	|ff_dct_unquantize_h263_armv5te|

	AREA	|.text|, CODE, ARM
|ff_dct_unquantize_h263_armv5te| PROC
	DCD	0xe92d43f0 ;	push	{r4, r5, r6, r7, r8, r9, lr}
	DCD	0xe3a0c000 ;	mov	ip, #0
	DCD	0xe2533002 ;	subs	r3, r3, #2
	DCD	0xda00002e ;	ble	cc <ff_dct_unquantize_h263_armv5te+0xcc>
	DCD	0xe1c040d0 ;	ldrd	r4, [r0]
	DCD	0xe1c060d8 ;	ldrd	r6, [r0, #8]
	DCD	0xe07c9844 ;	rsbs	r9, ip, r4, asr #16
	DCD	0xc2829000 ;	addgt	r9, r2, #0
	DCD	0xb2629000 ;	rsblt	r9, r2, #0
	DCD	0x110991a4 ;	smlatbne	r9, r4, r1, r9
	DCD	0xe07ce845 ;	rsbs	lr, ip, r5, asr #16
	DCD	0xc282e000 ;	addgt	lr, r2, #0
	DCD	0xb262e000 ;	rsblt	lr, r2, #0
	DCD	0x110ee1a5 ;	smlatbne	lr, r5, r1, lr
	DCD	0xe07c8804 ;	rsbs	r8, ip, r4, lsl #16
	DCD	0xc2828000 ;	addgt	r8, r2, #0
	DCD	0xb2628000 ;	rsblt	r8, r2, #0
	DCD	0x11048184 ;	smlabbne	r4, r4, r1, r8
	DCD	0xe07c8805 ;	rsbs	r8, ip, r5, lsl #16
	DCD	0xc2828000 ;	addgt	r8, r2, #0
	DCD	0xb2628000 ;	rsblt	r8, r2, #0
	DCD	0x11058185 ;	smlabbne	r5, r5, r1, r8
	DCD	0xe0c040b2 ;	strh	r4, [r0], #2
	DCD	0xe0c090b2 ;	strh	r9, [r0], #2
	DCD	0xe0c050b2 ;	strh	r5, [r0], #2
	DCD	0xe0c0e0b2 ;	strh	lr, [r0], #2
	DCD	0xe07c9846 ;	rsbs	r9, ip, r6, asr #16
	DCD	0xc2829000 ;	addgt	r9, r2, #0
	DCD	0xb2629000 ;	rsblt	r9, r2, #0
	DCD	0x110991a6 ;	smlatbne	r9, r6, r1, r9
	DCD	0xe07ce847 ;	rsbs	lr, ip, r7, asr #16
	DCD	0xc282e000 ;	addgt	lr, r2, #0
	DCD	0xb262e000 ;	rsblt	lr, r2, #0
	DCD	0x110ee1a7 ;	smlatbne	lr, r7, r1, lr
	DCD	0xe07c8806 ;	rsbs	r8, ip, r6, lsl #16
	DCD	0xc2828000 ;	addgt	r8, r2, #0
	DCD	0xb2628000 ;	rsblt	r8, r2, #0
	DCD	0x11068186 ;	smlabbne	r6, r6, r1, r8
	DCD	0xe07c8807 ;	rsbs	r8, ip, r7, lsl #16
	DCD	0xc2828000 ;	addgt	r8, r2, #0
	DCD	0xb2628000 ;	rsblt	r8, r2, #0
	DCD	0x11078187 ;	smlabbne	r7, r7, r1, r8
	DCD	0xe0c060b2 ;	strh	r6, [r0], #2
	DCD	0xe0c090b2 ;	strh	r9, [r0], #2
	DCD	0xe0c070b2 ;	strh	r7, [r0], #2
	DCD	0xe0c0e0b2 ;	strh	lr, [r0], #2
	DCD	0xe2533008 ;	subs	r3, r3, #8
	DCD	0xc1c040d0 ;	ldrdgt	r4, [r0]
	DCD	0xcaffffd3 ;	bgt	14 <ff_dct_unquantize_h263_armv5te+0x14>
	DCD	0xe2933002 ;	adds	r3, r3, #2
	DCD	0xd8bd83f0 ;	pople	{r4, r5, r6, r7, r8, r9, pc}
	DCD	0xe1d090f0 ;	ldrsh	r9, [r0]
	DCD	0xe1d0e0f2 ;	ldrsh	lr, [r0, #2]
	DCD	0xe1a08002 ;	mov	r8, r2
	DCD	0xe3590000 ;	cmp	r9, #0
	DCD	0xb2628000 ;	rsblt	r8, r2, #0
	DCD	0x11098189 ;	smlabbne	r9, r9, r1, r8
	DCD	0xe1a08002 ;	mov	r8, r2
	DCD	0xe35e0000 ;	cmp	lr, #0
	DCD	0xb2628000 ;	rsblt	r8, r2, #0
	DCD	0x110e818e ;	smlabbne	lr, lr, r1, r8
	DCD	0xe0c090b2 ;	strh	r9, [r0], #2
	DCD	0xe0c0e0b2 ;	strh	lr, [r0], #2
	DCD	0xe8bd83f0 ;	pop	{r4, r5, r6, r7, r8, r9, pc}
	ENDP

	END
