	CODE32

	EXPORT	|idct_row_armv5te|
	EXPORT	|idct_col_armv5te|
	EXPORT	|idct_col_put_armv5te|
	EXPORT	|idct_col_add_armv5te|
	EXPORT	|ff_simple_idct_armv5te|
	EXPORT	|ff_simple_idct_add_armv5te|
	EXPORT	|ff_simple_idct_put_armv5te|

	AREA	|.text|, DATA, READONLY
|w13|
	DCD	0x4b4258c5 ;	blmi	109631c <ff_simple_idct_put_armv5te+0x109579c>
|w26|
	DCD	0x22a3539f ;	adccs	r5, r3, #2080374786	; 0x7c000002
|w57|
	DCD	0x11a83249 ;			; <UNDEFINED> instruction: 0x11a83249

	AREA	|.text|, CODE, ARM
|idct_row_armv5te| PROC
	DCD	0xe52de004 ;	push	{lr}		; (str lr, [sp, #-4]!)
	DCD	0xe1c040d8 ;	ldrd	r4, [r0, #8]
	DCD	0xe1c020d0 ;	ldrd	r2, [r0]
	DCD	0xe1944005 ;	orrs	r4, r4, r5
	DCD	0x01540003 ;	cmpeq	r4, r3
	DCD	0x01540822 ;	cmpeq	r4, r2, lsr #16
	DCD	0x0a00004c ;	beq	15c <row_dc_only>
	DCD	0xe3a04b01 ;	mov	r4, #1024	; 0x400
	DCD	0xe3a0c901 ;	mov	ip, #16384	; 0x4000
	DCD	0xe24cc001 ;	sub	ip, ip, #1
	DCD	0xe104428c ;	smlabb	r4, ip, r2, r4
	DCD	0xe51fc03c ;	ldr	ip, [pc, #-60]	; 4 <w26>
	DCD	0xe16103ac ;	smultb	r1, ip, r3
	DCD	0xe16e038c ;	smulbb	lr, ip, r3
	DCD	0xe0845001 ;	add	r5, r4, r1
	DCD	0xe0446001 ;	sub	r6, r4, r1
	DCD	0xe044700e ;	sub	r7, r4, lr
	DCD	0xe084400e ;	add	r4, r4, lr
	DCD	0xe51fc05c ;	ldr	ip, [pc, #-92]	; 0 <w13>
	DCD	0xe51fe058 ;	ldr	lr, [pc, #-88]	; 8 <w57>
	DCD	0xe16802cc ;	smulbt	r8, ip, r2
	DCD	0xe16903ee ;	smultt	r9, lr, r3
	DCD	0xe10883ec ;	smlatt	r8, ip, r3, r8
	DCD	0xe16102ec ;	smultt	r1, ip, r2
	DCD	0xe16a02ce ;	smulbt	sl, lr, r2
	DCD	0xe0499001 ;	sub	r9, r9, r1
	DCD	0xe16103cc ;	smulbt	r1, ip, r3
	DCD	0xe16b02ee ;	smultt	fp, lr, r2
	DCD	0xe04aa001 ;	sub	sl, sl, r1
	DCD	0xe16103ce ;	smulbt	r1, lr, r3
	DCD	0xe1c020d8 ;	ldrd	r2, [r0, #8]
	DCD	0xe04bb001 ;	sub	fp, fp, r1
	DCD	0xe1921003 ;	orrs	r1, r2, r3
	DCD	0x0a000016 ;	beq	f0 <idct_row_armv5te+0xe4>
	DCD	0xe10882ce ;	smlabt	r8, lr, r2, r8
	DCD	0xe10992cc ;	smlabt	r9, ip, r2, r9
	DCD	0xe10883ee ;	smlatt	r8, lr, r3, r8
	DCD	0xe10993ce ;	smlabt	r9, lr, r3, r9
	DCD	0xe10aa2ee ;	smlatt	sl, lr, r2, sl
	DCD	0xe10bb2ec ;	smlatt	fp, ip, r2, fp
	DCD	0xe16103cc ;	smulbt	r1, ip, r3
	DCD	0xe10aa3ec ;	smlatt	sl, ip, r3, sl
	DCD	0xe04bb001 ;	sub	fp, fp, r1
	DCD	0xe51fc0bc ;	ldr	ip, [pc, #-188]	; 4 <w26>
	DCD	0xe3a01901 ;	mov	r1, #16384	; 0x4000
	DCD	0xe2411001 ;	sub	r1, r1, #1
	DCD	0xe1610281 ;	smulbb	r1, r1, r2
	DCD	0xe16e03ac ;	smultb	lr, ip, r3
	DCD	0xe0844001 ;	add	r4, r4, r1
	DCD	0xe084400e ;	add	r4, r4, lr
	DCD	0xe0877001 ;	add	r7, r7, r1
	DCD	0xe047700e ;	sub	r7, r7, lr
	DCD	0xe16e038c ;	smulbb	lr, ip, r3
	DCD	0xe0455001 ;	sub	r5, r5, r1
	DCD	0xe045500e ;	sub	r5, r5, lr
	DCD	0xe0466001 ;	sub	r6, r6, r1
	DCD	0xe086600e ;	add	r6, r6, lr
	DCD	0xe0841008 ;	add	r1, r4, r8
	DCD	0xe1a025a1 ;	lsr	r2, r1, #11
	DCD	0xe3c2281f ;	bic	r2, r2, #2031616	; 0x1f0000
	DCD	0xe0451009 ;	sub	r1, r5, r9
	DCD	0xe1a015a1 ;	lsr	r1, r1, #11
	DCD	0xe0822801 ;	add	r2, r2, r1, lsl #16
	DCD	0xe086100a ;	add	r1, r6, sl
	DCD	0xe1a035a1 ;	lsr	r3, r1, #11
	DCD	0xe3c3381f ;	bic	r3, r3, #2031616	; 0x1f0000
	DCD	0xe087100b ;	add	r1, r7, fp
	DCD	0xe1a015a1 ;	lsr	r1, r1, #11
	DCD	0xe0833801 ;	add	r3, r3, r1, lsl #16
	DCD	0xe1c020f0 ;	strd	r2, [r0]
	DCD	0xe047100b ;	sub	r1, r7, fp
	DCD	0xe1a025a1 ;	lsr	r2, r1, #11
	DCD	0xe3c2281f ;	bic	r2, r2, #2031616	; 0x1f0000
	DCD	0xe046100a ;	sub	r1, r6, sl
	DCD	0xe1a015a1 ;	lsr	r1, r1, #11
	DCD	0xe0822801 ;	add	r2, r2, r1, lsl #16
	DCD	0xe0851009 ;	add	r1, r5, r9
	DCD	0xe1a035a1 ;	lsr	r3, r1, #11
	DCD	0xe3c3381f ;	bic	r3, r3, #2031616	; 0x1f0000
	DCD	0xe0441008 ;	sub	r1, r4, r8
	DCD	0xe1a015a1 ;	lsr	r1, r1, #11
	DCD	0xe0833801 ;	add	r3, r3, r1, lsl #16
	DCD	0xe1c020f8 ;	strd	r2, [r0, #8]
	DCD	0xe49df004 ;	pop	{pc}		; (ldr pc, [sp], #4)
	ENDP

|row_dc_only| PROC
	DCD	0xe1822802 ;	orr	r2, r2, r2, lsl #16
	DCD	0xe3c22a0e ;	bic	r2, r2, #57344	; 0xe000
	DCD	0xe1a02182 ;	lsl	r2, r2, #3
	DCD	0xe1a03002 ;	mov	r3, r2
	DCD	0xe1c020f0 ;	strd	r2, [r0]
	DCD	0xe1c020f8 ;	strd	r2, [r0, #8]
	DCD	0xe49df004 ;	pop	{pc}		; (ldr pc, [sp], #4)
	ENDP

|idct_col_armv5te| PROC
	DCD	0xe52de004 ;	push	{lr}		; (str lr, [sp, #-4]!)
	DCD	0xe5903000 ;	ldr	r3, [r0]
	DCD	0xe3a0c901 ;	mov	ip, #16384	; 0x4000
	DCD	0xe24cc001 ;	sub	ip, ip, #1
	DCD	0xe3a04020 ;	mov	r4, #32
	DCD	0xe0845843 ;	add	r5, r4, r3, asr #16
	DCD	0xe0655705 ;	rsb	r5, r5, r5, lsl #14
	DCD	0xe1a03803 ;	lsl	r3, r3, #16
	DCD	0xe0844843 ;	add	r4, r4, r3, asr #16
	DCD	0xe5903040 ;	ldr	r3, [r0, #64]	; 0x40
	DCD	0xe0644704 ;	rsb	r4, r4, r4, lsl #14
	DCD	0xe16e038c ;	smulbb	lr, ip, r3
	DCD	0xe16203cc ;	smulbt	r2, ip, r3
	DCD	0xe044600e ;	sub	r6, r4, lr
	DCD	0xe044800e ;	sub	r8, r4, lr
	DCD	0xe084a00e ;	add	sl, r4, lr
	DCD	0xe084400e ;	add	r4, r4, lr
	DCD	0xe0457002 ;	sub	r7, r5, r2
	DCD	0xe0459002 ;	sub	r9, r5, r2
	DCD	0xe085b002 ;	add	fp, r5, r2
	DCD	0xe51fc1cc ;	ldr	ip, [pc, #-460]	; 4 <w26>
	DCD	0xe5903020 ;	ldr	r3, [r0, #32]
	DCD	0xe0855002 ;	add	r5, r5, r2
	DCD	0xe16e038c ;	smulbb	lr, ip, r3
	DCD	0xe16203ac ;	smultb	r2, ip, r3
	DCD	0xe084400e ;	add	r4, r4, lr
	DCD	0xe04aa00e ;	sub	sl, sl, lr
	DCD	0xe0866002 ;	add	r6, r6, r2
	DCD	0xe0488002 ;	sub	r8, r8, r2
	DCD	0xe16e03cc ;	smulbt	lr, ip, r3
	DCD	0xe16203ec ;	smultt	r2, ip, r3
	DCD	0xe085500e ;	add	r5, r5, lr
	DCD	0xe04bb00e ;	sub	fp, fp, lr
	DCD	0xe0877002 ;	add	r7, r7, r2
	DCD	0xe5903060 ;	ldr	r3, [r0, #96]	; 0x60
	DCD	0xe0499002 ;	sub	r9, r9, r2
	DCD	0xe16e03ac ;	smultb	lr, ip, r3
	DCD	0xe162038c ;	smulbb	r2, ip, r3
	DCD	0xe084400e ;	add	r4, r4, lr
	DCD	0xe04aa00e ;	sub	sl, sl, lr
	DCD	0xe0466002 ;	sub	r6, r6, r2
	DCD	0xe0888002 ;	add	r8, r8, r2
	DCD	0xe16e03ec ;	smultt	lr, ip, r3
	DCD	0xe16203cc ;	smulbt	r2, ip, r3
	DCD	0xe085500e ;	add	r5, r5, lr
	DCD	0xe04bb00e ;	sub	fp, fp, lr
	DCD	0xe0477002 ;	sub	r7, r7, r2
	DCD	0xe0899002 ;	add	r9, r9, r2
	DCD	0xe92d0ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp}
	DCD	0xe51fc244 ;	ldr	ip, [pc, #-580]	; 0 <w13>
	DCD	0xe5903010 ;	ldr	r3, [r0, #16]
	DCD	0xe51fe244 ;	ldr	lr, [pc, #-580]	; 8 <w57>
	DCD	0xe164038c ;	smulbb	r4, ip, r3
	DCD	0xe16603ac ;	smultb	r6, ip, r3
	DCD	0xe168038e ;	smulbb	r8, lr, r3
	DCD	0xe16a03ae ;	smultb	sl, lr, r3
	DCD	0xe16503cc ;	smulbt	r5, ip, r3
	DCD	0xe16703ec ;	smultt	r7, ip, r3
	DCD	0xe16903ce ;	smulbt	r9, lr, r3
	DCD	0xe16b03ee ;	smultt	fp, lr, r3
	DCD	0xe2677000 ;	rsb	r7, r7, #0
	DCD	0xe5903030 ;	ldr	r3, [r0, #48]	; 0x30
	DCD	0xe2666000 ;	rsb	r6, r6, #0
	DCD	0xe10443ac ;	smlatb	r4, ip, r3, r4
	DCD	0xe10663ae ;	smlatb	r6, lr, r3, r6
	DCD	0xe162038c ;	smulbb	r2, ip, r3
	DCD	0xe161038e ;	smulbb	r1, lr, r3
	DCD	0xe0488002 ;	sub	r8, r8, r2
	DCD	0xe04aa001 ;	sub	sl, sl, r1
	DCD	0xe10553ec ;	smlatt	r5, ip, r3, r5
	DCD	0xe10773ee ;	smlatt	r7, lr, r3, r7
	DCD	0xe16203cc ;	smulbt	r2, ip, r3
	DCD	0xe16103ce ;	smulbt	r1, lr, r3
	DCD	0xe0499002 ;	sub	r9, r9, r2
	DCD	0xe5903050 ;	ldr	r3, [r0, #80]	; 0x50
	DCD	0xe04bb001 ;	sub	fp, fp, r1
	DCD	0xe104438e ;	smlabb	r4, lr, r3, r4
	DCD	0xe106638c ;	smlabb	r6, ip, r3, r6
	DCD	0xe10883ae ;	smlatb	r8, lr, r3, r8
	DCD	0xe10aa3ac ;	smlatb	sl, ip, r3, sl
	DCD	0xe10553ce ;	smlabt	r5, lr, r3, r5
	DCD	0xe10773cc ;	smlabt	r7, ip, r3, r7
	DCD	0xe10993ee ;	smlatt	r9, lr, r3, r9
	DCD	0xe5902070 ;	ldr	r2, [r0, #112]	; 0x70
	DCD	0xe10bb3ec ;	smlatt	fp, ip, r3, fp
	DCD	0xe10442ae ;	smlatb	r4, lr, r2, r4
	DCD	0xe106628e ;	smlabb	r6, lr, r2, r6
	DCD	0xe10882ac ;	smlatb	r8, ip, r2, r8
	DCD	0xe163028c ;	smulbb	r3, ip, r2
	DCD	0xe10552ee ;	smlatt	r5, lr, r2, r5
	DCD	0xe04aa003 ;	sub	sl, sl, r3
	DCD	0xe10772ce ;	smlabt	r7, lr, r2, r7
	DCD	0xe16302cc ;	smulbt	r3, ip, r2
	DCD	0xe10992ec ;	smlatt	r9, ip, r2, r9
	DCD	0xe04bb003 ;	sub	fp, fp, r3
	DCD	0xe8bd000c ;	pop	{r2, r3}
	DCD	0xe0921004 ;	adds	r1, r2, r4
	DCD	0xe1a01a21 ;	lsr	r1, r1, #20
	DCD	0x43811a0f ;	orrmi	r1, r1, #61440	; 0xf000
	DCD	0xe083c005 ;	add	ip, r3, r5
	DCD	0xe1a0ca4c ;	asr	ip, ip, #20
	DCD	0xe181180c ;	orr	r1, r1, ip, lsl #16
	DCD	0xe5801000 ;	str	r1, [r0]
	DCD	0xe0522004 ;	subs	r2, r2, r4
	DCD	0xe1a01a22 ;	lsr	r1, r2, #20
	DCD	0x43811a0f ;	orrmi	r1, r1, #61440	; 0xf000
	DCD	0xe0433005 ;	sub	r3, r3, r5
	DCD	0xe1a03a43 ;	asr	r3, r3, #20
	DCD	0xe1811803 ;	orr	r1, r1, r3, lsl #16
	DCD	0xe8bd000c ;	pop	{r2, r3}
	DCD	0xe5801070 ;	str	r1, [r0, #112]	; 0x70
	DCD	0xe0521006 ;	subs	r1, r2, r6
	DCD	0xe1a01a21 ;	lsr	r1, r1, #20
	DCD	0x43811a0f ;	orrmi	r1, r1, #61440	; 0xf000
	DCD	0xe043c007 ;	sub	ip, r3, r7
	DCD	0xe1a0ca4c ;	asr	ip, ip, #20
	DCD	0xe181180c ;	orr	r1, r1, ip, lsl #16
	DCD	0xe5801010 ;	str	r1, [r0, #16]
	DCD	0xe0922006 ;	adds	r2, r2, r6
	DCD	0xe1a01a22 ;	lsr	r1, r2, #20
	DCD	0x43811a0f ;	orrmi	r1, r1, #61440	; 0xf000
	DCD	0xe0833007 ;	add	r3, r3, r7
	DCD	0xe1a03a43 ;	asr	r3, r3, #20
	DCD	0xe1811803 ;	orr	r1, r1, r3, lsl #16
	DCD	0xe8bd000c ;	pop	{r2, r3}
	DCD	0xe5801060 ;	str	r1, [r0, #96]	; 0x60
	DCD	0xe0921008 ;	adds	r1, r2, r8
	DCD	0xe1a01a21 ;	lsr	r1, r1, #20
	DCD	0x43811a0f ;	orrmi	r1, r1, #61440	; 0xf000
	DCD	0xe083c009 ;	add	ip, r3, r9
	DCD	0xe1a0ca4c ;	asr	ip, ip, #20
	DCD	0xe181180c ;	orr	r1, r1, ip, lsl #16
	DCD	0xe5801020 ;	str	r1, [r0, #32]
	DCD	0xe0522008 ;	subs	r2, r2, r8
	DCD	0xe1a01a22 ;	lsr	r1, r2, #20
	DCD	0x43811a0f ;	orrmi	r1, r1, #61440	; 0xf000
	DCD	0xe0433009 ;	sub	r3, r3, r9
	DCD	0xe1a03a43 ;	asr	r3, r3, #20
	DCD	0xe1811803 ;	orr	r1, r1, r3, lsl #16
	DCD	0xe8bd000c ;	pop	{r2, r3}
	DCD	0xe5801050 ;	str	r1, [r0, #80]	; 0x50
	DCD	0xe092100a ;	adds	r1, r2, sl
	DCD	0xe1a01a21 ;	lsr	r1, r1, #20
	DCD	0x43811a0f ;	orrmi	r1, r1, #61440	; 0xf000
	DCD	0xe083c00b ;	add	ip, r3, fp
	DCD	0xe1a0ca4c ;	asr	ip, ip, #20
	DCD	0xe181180c ;	orr	r1, r1, ip, lsl #16
	DCD	0xe5801030 ;	str	r1, [r0, #48]	; 0x30
	DCD	0xe052200a ;	subs	r2, r2, sl
	DCD	0xe1a01a22 ;	lsr	r1, r2, #20
	DCD	0x43811a0f ;	orrmi	r1, r1, #61440	; 0xf000
	DCD	0xe043300b ;	sub	r3, r3, fp
	DCD	0xe1a03a43 ;	asr	r3, r3, #20
	DCD	0xe1811803 ;	orr	r1, r1, r3, lsl #16
	DCD	0xe5801040 ;	str	r1, [r0, #64]	; 0x40
	DCD	0xe49df004 ;	pop	{pc}		; (ldr pc, [sp], #4)
	ENDP

|idct_col_put_armv5te| PROC
	DCD	0xe52de004 ;	push	{lr}		; (str lr, [sp, #-4]!)
	DCD	0xe5903000 ;	ldr	r3, [r0]
	DCD	0xe3a0c901 ;	mov	ip, #16384	; 0x4000
	DCD	0xe24cc001 ;	sub	ip, ip, #1
	DCD	0xe3a04020 ;	mov	r4, #32
	DCD	0xe0845843 ;	add	r5, r4, r3, asr #16
	DCD	0xe0655705 ;	rsb	r5, r5, r5, lsl #14
	DCD	0xe1a03803 ;	lsl	r3, r3, #16
	DCD	0xe0844843 ;	add	r4, r4, r3, asr #16
	DCD	0xe5903040 ;	ldr	r3, [r0, #64]	; 0x40
	DCD	0xe0644704 ;	rsb	r4, r4, r4, lsl #14
	DCD	0xe16e038c ;	smulbb	lr, ip, r3
	DCD	0xe16203cc ;	smulbt	r2, ip, r3
	DCD	0xe044600e ;	sub	r6, r4, lr
	DCD	0xe044800e ;	sub	r8, r4, lr
	DCD	0xe084a00e ;	add	sl, r4, lr
	DCD	0xe084400e ;	add	r4, r4, lr
	DCD	0xe0457002 ;	sub	r7, r5, r2
	DCD	0xe0459002 ;	sub	r9, r5, r2
	DCD	0xe085b002 ;	add	fp, r5, r2
	DCD	0xe51fc43c ;	ldr	ip, [pc, #-1084]	; 4 <w26>
	DCD	0xe5903020 ;	ldr	r3, [r0, #32]
	DCD	0xe0855002 ;	add	r5, r5, r2
	DCD	0xe16e038c ;	smulbb	lr, ip, r3
	DCD	0xe16203ac ;	smultb	r2, ip, r3
	DCD	0xe084400e ;	add	r4, r4, lr
	DCD	0xe04aa00e ;	sub	sl, sl, lr
	DCD	0xe0866002 ;	add	r6, r6, r2
	DCD	0xe0488002 ;	sub	r8, r8, r2
	DCD	0xe16e03cc ;	smulbt	lr, ip, r3
	DCD	0xe16203ec ;	smultt	r2, ip, r3
	DCD	0xe085500e ;	add	r5, r5, lr
	DCD	0xe04bb00e ;	sub	fp, fp, lr
	DCD	0xe0877002 ;	add	r7, r7, r2
	DCD	0xe5903060 ;	ldr	r3, [r0, #96]	; 0x60
	DCD	0xe0499002 ;	sub	r9, r9, r2
	DCD	0xe16e03ac ;	smultb	lr, ip, r3
	DCD	0xe162038c ;	smulbb	r2, ip, r3
	DCD	0xe084400e ;	add	r4, r4, lr
	DCD	0xe04aa00e ;	sub	sl, sl, lr
	DCD	0xe0466002 ;	sub	r6, r6, r2
	DCD	0xe0888002 ;	add	r8, r8, r2
	DCD	0xe16e03ec ;	smultt	lr, ip, r3
	DCD	0xe16203cc ;	smulbt	r2, ip, r3
	DCD	0xe085500e ;	add	r5, r5, lr
	DCD	0xe04bb00e ;	sub	fp, fp, lr
	DCD	0xe0477002 ;	sub	r7, r7, r2
	DCD	0xe0899002 ;	add	r9, r9, r2
	DCD	0xe92d0ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp}
	DCD	0xe51fc4b4 ;	ldr	ip, [pc, #-1204]	; 0 <w13>
	DCD	0xe5903010 ;	ldr	r3, [r0, #16]
	DCD	0xe51fe4b4 ;	ldr	lr, [pc, #-1204]	; 8 <w57>
	DCD	0xe164038c ;	smulbb	r4, ip, r3
	DCD	0xe16603ac ;	smultb	r6, ip, r3
	DCD	0xe168038e ;	smulbb	r8, lr, r3
	DCD	0xe16a03ae ;	smultb	sl, lr, r3
	DCD	0xe16503cc ;	smulbt	r5, ip, r3
	DCD	0xe16703ec ;	smultt	r7, ip, r3
	DCD	0xe16903ce ;	smulbt	r9, lr, r3
	DCD	0xe16b03ee ;	smultt	fp, lr, r3
	DCD	0xe2677000 ;	rsb	r7, r7, #0
	DCD	0xe5903030 ;	ldr	r3, [r0, #48]	; 0x30
	DCD	0xe2666000 ;	rsb	r6, r6, #0
	DCD	0xe10443ac ;	smlatb	r4, ip, r3, r4
	DCD	0xe10663ae ;	smlatb	r6, lr, r3, r6
	DCD	0xe162038c ;	smulbb	r2, ip, r3
	DCD	0xe161038e ;	smulbb	r1, lr, r3
	DCD	0xe0488002 ;	sub	r8, r8, r2
	DCD	0xe04aa001 ;	sub	sl, sl, r1
	DCD	0xe10553ec ;	smlatt	r5, ip, r3, r5
	DCD	0xe10773ee ;	smlatt	r7, lr, r3, r7
	DCD	0xe16203cc ;	smulbt	r2, ip, r3
	DCD	0xe16103ce ;	smulbt	r1, lr, r3
	DCD	0xe0499002 ;	sub	r9, r9, r2
	DCD	0xe5903050 ;	ldr	r3, [r0, #80]	; 0x50
	DCD	0xe04bb001 ;	sub	fp, fp, r1
	DCD	0xe104438e ;	smlabb	r4, lr, r3, r4
	DCD	0xe106638c ;	smlabb	r6, ip, r3, r6
	DCD	0xe10883ae ;	smlatb	r8, lr, r3, r8
	DCD	0xe10aa3ac ;	smlatb	sl, ip, r3, sl
	DCD	0xe10553ce ;	smlabt	r5, lr, r3, r5
	DCD	0xe10773cc ;	smlabt	r7, ip, r3, r7
	DCD	0xe10993ee ;	smlatt	r9, lr, r3, r9
	DCD	0xe5902070 ;	ldr	r2, [r0, #112]	; 0x70
	DCD	0xe10bb3ec ;	smlatt	fp, ip, r3, fp
	DCD	0xe10442ae ;	smlatb	r4, lr, r2, r4
	DCD	0xe106628e ;	smlabb	r6, lr, r2, r6
	DCD	0xe10882ac ;	smlatb	r8, ip, r2, r8
	DCD	0xe163028c ;	smulbb	r3, ip, r2
	DCD	0xe10552ee ;	smlatt	r5, lr, r2, r5
	DCD	0xe04aa003 ;	sub	sl, sl, r3
	DCD	0xe10772ce ;	smlabt	r7, lr, r2, r7
	DCD	0xe16302cc ;	smulbt	r3, ip, r2
	DCD	0xe10992ec ;	smlatt	r9, ip, r2, r9
	DCD	0xe04bb003 ;	sub	fp, fp, r3
	DCD	0xe8bd000c ;	pop	{r2, r3}
	DCD	0xe59de020 ;	ldr	lr, [sp, #32]
	DCD	0xe0821004 ;	add	r1, r2, r4
	DCD	0xe1b01a41 ;	asrs	r1, r1, #20
	DCD	0x43a01000 ;	movmi	r1, #0
	DCD	0xe35100ff ;	cmp	r1, #255	; 0xff
	DCD	0xc3a010ff ;	movgt	r1, #255	; 0xff
	DCD	0xe083c005 ;	add	ip, r3, r5
	DCD	0xe1b0ca4c ;	asrs	ip, ip, #20
	DCD	0x43a0c000 ;	movmi	ip, #0
	DCD	0xe35c00ff ;	cmp	ip, #255	; 0xff
	DCD	0xc3a0c0ff ;	movgt	ip, #255	; 0xff
	DCD	0xe181140c ;	orr	r1, r1, ip, lsl #8
	DCD	0xe0422004 ;	sub	r2, r2, r4
	DCD	0xe1b02a42 ;	asrs	r2, r2, #20
	DCD	0x43a02000 ;	movmi	r2, #0
	DCD	0xe35200ff ;	cmp	r2, #255	; 0xff
	DCD	0xc3a020ff ;	movgt	r2, #255	; 0xff
	DCD	0xe0433005 ;	sub	r3, r3, r5
	DCD	0xe1b03a43 ;	asrs	r3, r3, #20
	DCD	0x43a03000 ;	movmi	r3, #0
	DCD	0xe35300ff ;	cmp	r3, #255	; 0xff
	DCD	0xe59d401c ;	ldr	r4, [sp, #28]
	DCD	0xc3a030ff ;	movgt	r3, #255	; 0xff
	DCD	0xe1c410b0 ;	strh	r1, [r4]
	DCD	0xe2841002 ;	add	r1, r4, #2
	DCD	0xe58d101c ;	str	r1, [sp, #28]
	DCD	0xe1821403 ;	orr	r1, r2, r3, lsl #8
	DCD	0xe06e518e ;	rsb	r5, lr, lr, lsl #3
	DCD	0xe8bd000c ;	pop	{r2, r3}
	DCD	0xe1a510b4 ;	strh	r1, [r5, r4]!
	DCD	0xe0421006 ;	sub	r1, r2, r6
	DCD	0xe1b01a41 ;	asrs	r1, r1, #20
	DCD	0x43a01000 ;	movmi	r1, #0
	DCD	0xe35100ff ;	cmp	r1, #255	; 0xff
	DCD	0xc3a010ff ;	movgt	r1, #255	; 0xff
	DCD	0xe043c007 ;	sub	ip, r3, r7
	DCD	0xe1b0ca4c ;	asrs	ip, ip, #20
	DCD	0x43a0c000 ;	movmi	ip, #0
	DCD	0xe35c00ff ;	cmp	ip, #255	; 0xff
	DCD	0xc3a0c0ff ;	movgt	ip, #255	; 0xff
	DCD	0xe181140c ;	orr	r1, r1, ip, lsl #8
	DCD	0xe1a410be ;	strh	r1, [r4, lr]!
	DCD	0xe0822006 ;	add	r2, r2, r6
	DCD	0xe1b01a42 ;	asrs	r1, r2, #20
	DCD	0x43a01000 ;	movmi	r1, #0
	DCD	0xe35100ff ;	cmp	r1, #255	; 0xff
	DCD	0xc3a010ff ;	movgt	r1, #255	; 0xff
	DCD	0xe0833007 ;	add	r3, r3, r7
	DCD	0xe1b03a43 ;	asrs	r3, r3, #20
	DCD	0x43a03000 ;	movmi	r3, #0
	DCD	0xe35300ff ;	cmp	r3, #255	; 0xff
	DCD	0xc3a030ff ;	movgt	r3, #255	; 0xff
	DCD	0xe1811403 ;	orr	r1, r1, r3, lsl #8
	DCD	0xe8bd000c ;	pop	{r2, r3}
	DCD	0xe12510be ;	strh	r1, [r5, -lr]!
	DCD	0xe0821008 ;	add	r1, r2, r8
	DCD	0xe1b01a41 ;	asrs	r1, r1, #20
	DCD	0x43a01000 ;	movmi	r1, #0
	DCD	0xe35100ff ;	cmp	r1, #255	; 0xff
	DCD	0xc3a010ff ;	movgt	r1, #255	; 0xff
	DCD	0xe083c009 ;	add	ip, r3, r9
	DCD	0xe1b0ca4c ;	asrs	ip, ip, #20
	DCD	0x43a0c000 ;	movmi	ip, #0
	DCD	0xe35c00ff ;	cmp	ip, #255	; 0xff
	DCD	0xc3a0c0ff ;	movgt	ip, #255	; 0xff
	DCD	0xe181140c ;	orr	r1, r1, ip, lsl #8
	DCD	0xe1a410be ;	strh	r1, [r4, lr]!
	DCD	0xe0422008 ;	sub	r2, r2, r8
	DCD	0xe1b01a42 ;	asrs	r1, r2, #20
	DCD	0x43a01000 ;	movmi	r1, #0
	DCD	0xe35100ff ;	cmp	r1, #255	; 0xff
	DCD	0xc3a010ff ;	movgt	r1, #255	; 0xff
	DCD	0xe0433009 ;	sub	r3, r3, r9
	DCD	0xe1b03a43 ;	asrs	r3, r3, #20
	DCD	0x43a03000 ;	movmi	r3, #0
	DCD	0xe35300ff ;	cmp	r3, #255	; 0xff
	DCD	0xc3a030ff ;	movgt	r3, #255	; 0xff
	DCD	0xe1811403 ;	orr	r1, r1, r3, lsl #8
	DCD	0xe8bd000c ;	pop	{r2, r3}
	DCD	0xe12510be ;	strh	r1, [r5, -lr]!
	DCD	0xe082100a ;	add	r1, r2, sl
	DCD	0xe1b01a41 ;	asrs	r1, r1, #20
	DCD	0x43a01000 ;	movmi	r1, #0
	DCD	0xe35100ff ;	cmp	r1, #255	; 0xff
	DCD	0xc3a010ff ;	movgt	r1, #255	; 0xff
	DCD	0xe083c00b ;	add	ip, r3, fp
	DCD	0xe1b0ca4c ;	asrs	ip, ip, #20
	DCD	0x43a0c000 ;	movmi	ip, #0
	DCD	0xe35c00ff ;	cmp	ip, #255	; 0xff
	DCD	0xc3a0c0ff ;	movgt	ip, #255	; 0xff
	DCD	0xe181140c ;	orr	r1, r1, ip, lsl #8
	DCD	0xe18410be ;	strh	r1, [r4, lr]
	DCD	0xe042200a ;	sub	r2, r2, sl
	DCD	0xe1b01a42 ;	asrs	r1, r2, #20
	DCD	0x43a01000 ;	movmi	r1, #0
	DCD	0xe35100ff ;	cmp	r1, #255	; 0xff
	DCD	0xc3a010ff ;	movgt	r1, #255	; 0xff
	DCD	0xe043300b ;	sub	r3, r3, fp
	DCD	0xe1b03a43 ;	asrs	r3, r3, #20
	DCD	0x43a03000 ;	movmi	r3, #0
	DCD	0xe35300ff ;	cmp	r3, #255	; 0xff
	DCD	0xc3a030ff ;	movgt	r3, #255	; 0xff
	DCD	0xe1811403 ;	orr	r1, r1, r3, lsl #8
	DCD	0xe10510be ;	strh	r1, [r5, -lr]
	DCD	0xe49df004 ;	pop	{pc}		; (ldr pc, [sp], #4)
	ENDP

|idct_col_add_armv5te| PROC
	DCD	0xe52de004 ;	push	{lr}		; (str lr, [sp, #-4]!)
	DCD	0xe5903000 ;	ldr	r3, [r0]
	DCD	0xe3a0c901 ;	mov	ip, #16384	; 0x4000
	DCD	0xe24cc001 ;	sub	ip, ip, #1
	DCD	0xe3a04020 ;	mov	r4, #32
	DCD	0xe0845843 ;	add	r5, r4, r3, asr #16
	DCD	0xe0655705 ;	rsb	r5, r5, r5, lsl #14
	DCD	0xe1a03803 ;	lsl	r3, r3, #16
	DCD	0xe0844843 ;	add	r4, r4, r3, asr #16
	DCD	0xe5903040 ;	ldr	r3, [r0, #64]	; 0x40
	DCD	0xe0644704 ;	rsb	r4, r4, r4, lsl #14
	DCD	0xe16e038c ;	smulbb	lr, ip, r3
	DCD	0xe16203cc ;	smulbt	r2, ip, r3
	DCD	0xe044600e ;	sub	r6, r4, lr
	DCD	0xe044800e ;	sub	r8, r4, lr
	DCD	0xe084a00e ;	add	sl, r4, lr
	DCD	0xe084400e ;	add	r4, r4, lr
	DCD	0xe0457002 ;	sub	r7, r5, r2
	DCD	0xe0459002 ;	sub	r9, r5, r2
	DCD	0xe085b002 ;	add	fp, r5, r2
	DCD	0xe51fc760 ;	ldr	ip, [pc, #-1888]	; 4 <w26>
	DCD	0xe5903020 ;	ldr	r3, [r0, #32]
	DCD	0xe0855002 ;	add	r5, r5, r2
	DCD	0xe16e038c ;	smulbb	lr, ip, r3
	DCD	0xe16203ac ;	smultb	r2, ip, r3
	DCD	0xe084400e ;	add	r4, r4, lr
	DCD	0xe04aa00e ;	sub	sl, sl, lr
	DCD	0xe0866002 ;	add	r6, r6, r2
	DCD	0xe0488002 ;	sub	r8, r8, r2
	DCD	0xe16e03cc ;	smulbt	lr, ip, r3
	DCD	0xe16203ec ;	smultt	r2, ip, r3
	DCD	0xe085500e ;	add	r5, r5, lr
	DCD	0xe04bb00e ;	sub	fp, fp, lr
	DCD	0xe0877002 ;	add	r7, r7, r2
	DCD	0xe5903060 ;	ldr	r3, [r0, #96]	; 0x60
	DCD	0xe0499002 ;	sub	r9, r9, r2
	DCD	0xe16e03ac ;	smultb	lr, ip, r3
	DCD	0xe162038c ;	smulbb	r2, ip, r3
	DCD	0xe084400e ;	add	r4, r4, lr
	DCD	0xe04aa00e ;	sub	sl, sl, lr
	DCD	0xe0466002 ;	sub	r6, r6, r2
	DCD	0xe0888002 ;	add	r8, r8, r2
	DCD	0xe16e03ec ;	smultt	lr, ip, r3
	DCD	0xe16203cc ;	smulbt	r2, ip, r3
	DCD	0xe085500e ;	add	r5, r5, lr
	DCD	0xe04bb00e ;	sub	fp, fp, lr
	DCD	0xe0477002 ;	sub	r7, r7, r2
	DCD	0xe0899002 ;	add	r9, r9, r2
	DCD	0xe92d0ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp}
	DCD	0xe51fc7d8 ;	ldr	ip, [pc, #-2008]	; 0 <w13>
	DCD	0xe5903010 ;	ldr	r3, [r0, #16]
	DCD	0xe51fe7d8 ;	ldr	lr, [pc, #-2008]	; 8 <w57>
	DCD	0xe164038c ;	smulbb	r4, ip, r3
	DCD	0xe16603ac ;	smultb	r6, ip, r3
	DCD	0xe168038e ;	smulbb	r8, lr, r3
	DCD	0xe16a03ae ;	smultb	sl, lr, r3
	DCD	0xe16503cc ;	smulbt	r5, ip, r3
	DCD	0xe16703ec ;	smultt	r7, ip, r3
	DCD	0xe16903ce ;	smulbt	r9, lr, r3
	DCD	0xe16b03ee ;	smultt	fp, lr, r3
	DCD	0xe2677000 ;	rsb	r7, r7, #0
	DCD	0xe5903030 ;	ldr	r3, [r0, #48]	; 0x30
	DCD	0xe2666000 ;	rsb	r6, r6, #0
	DCD	0xe10443ac ;	smlatb	r4, ip, r3, r4
	DCD	0xe10663ae ;	smlatb	r6, lr, r3, r6
	DCD	0xe162038c ;	smulbb	r2, ip, r3
	DCD	0xe161038e ;	smulbb	r1, lr, r3
	DCD	0xe0488002 ;	sub	r8, r8, r2
	DCD	0xe04aa001 ;	sub	sl, sl, r1
	DCD	0xe10553ec ;	smlatt	r5, ip, r3, r5
	DCD	0xe10773ee ;	smlatt	r7, lr, r3, r7
	DCD	0xe16203cc ;	smulbt	r2, ip, r3
	DCD	0xe16103ce ;	smulbt	r1, lr, r3
	DCD	0xe0499002 ;	sub	r9, r9, r2
	DCD	0xe5903050 ;	ldr	r3, [r0, #80]	; 0x50
	DCD	0xe04bb001 ;	sub	fp, fp, r1
	DCD	0xe104438e ;	smlabb	r4, lr, r3, r4
	DCD	0xe106638c ;	smlabb	r6, ip, r3, r6
	DCD	0xe10883ae ;	smlatb	r8, lr, r3, r8
	DCD	0xe10aa3ac ;	smlatb	sl, ip, r3, sl
	DCD	0xe10553ce ;	smlabt	r5, lr, r3, r5
	DCD	0xe10773cc ;	smlabt	r7, ip, r3, r7
	DCD	0xe10993ee ;	smlatt	r9, lr, r3, r9
	DCD	0xe5902070 ;	ldr	r2, [r0, #112]	; 0x70
	DCD	0xe10bb3ec ;	smlatt	fp, ip, r3, fp
	DCD	0xe10442ae ;	smlatb	r4, lr, r2, r4
	DCD	0xe106628e ;	smlabb	r6, lr, r2, r6
	DCD	0xe10882ac ;	smlatb	r8, ip, r2, r8
	DCD	0xe163028c ;	smulbb	r3, ip, r2
	DCD	0xe10552ee ;	smlatt	r5, lr, r2, r5
	DCD	0xe04aa003 ;	sub	sl, sl, r3
	DCD	0xe10772ce ;	smlabt	r7, lr, r2, r7
	DCD	0xe16302cc ;	smulbt	r3, ip, r2
	DCD	0xe10992ec ;	smlatt	r9, ip, r2, r9
	DCD	0xe04bb003 ;	sub	fp, fp, r3
	DCD	0xe59de024 ;	ldr	lr, [sp, #36]	; 0x24
	DCD	0xe8bd000c ;	pop	{r2, r3}
	DCD	0xe1dec0b0 ;	ldrh	ip, [lr]
	DCD	0xe0821004 ;	add	r1, r2, r4
	DCD	0xe1a01a41 ;	asr	r1, r1, #20
	DCD	0xe0422004 ;	sub	r2, r2, r4
	DCD	0xe20c40ff ;	and	r4, ip, #255	; 0xff
	DCD	0xe0911004 ;	adds	r1, r1, r4
	DCD	0x43a01000 ;	movmi	r1, #0
	DCD	0xe35100ff ;	cmp	r1, #255	; 0xff
	DCD	0xc3a010ff ;	movgt	r1, #255	; 0xff
	DCD	0xe0834005 ;	add	r4, r3, r5
	DCD	0xe1a04a44 ;	asr	r4, r4, #20
	DCD	0xe094442c ;	adds	r4, r4, ip, lsr #8
	DCD	0x43a04000 ;	movmi	r4, #0
	DCD	0xe35400ff ;	cmp	r4, #255	; 0xff
	DCD	0xc3a040ff ;	movgt	r4, #255	; 0xff
	DCD	0xe1811404 ;	orr	r1, r1, r4, lsl #8
	DCD	0xe59d4020 ;	ldr	r4, [sp, #32]
	DCD	0xe0433005 ;	sub	r3, r3, r5
	DCD	0xe0645184 ;	rsb	r5, r4, r4, lsl #3
	DCD	0xe1b5c0be ;	ldrh	ip, [r5, lr]!
	DCD	0xe1ce10b0 ;	strh	r1, [lr]
	DCD	0xe1a02a42 ;	asr	r2, r2, #20
	DCD	0xe20c10ff ;	and	r1, ip, #255	; 0xff
	DCD	0xe0922001 ;	adds	r2, r2, r1
	DCD	0x43a02000 ;	movmi	r2, #0
	DCD	0xe35200ff ;	cmp	r2, #255	; 0xff
	DCD	0xc3a020ff ;	movgt	r2, #255	; 0xff
	DCD	0xe1a03a43 ;	asr	r3, r3, #20
	DCD	0xe093342c ;	adds	r3, r3, ip, lsr #8
	DCD	0x43a03000 ;	movmi	r3, #0
	DCD	0xe35300ff ;	cmp	r3, #255	; 0xff
	DCD	0xc3a030ff ;	movgt	r3, #255	; 0xff
	DCD	0xe28e1002 ;	add	r1, lr, #2
	DCD	0xe58d101c ;	str	r1, [sp, #28]
	DCD	0xe1821403 ;	orr	r1, r2, r3, lsl #8
	DCD	0xe1c510b0 ;	strh	r1, [r5]
	DCD	0xe8bd000c ;	pop	{r2, r3}
	DCD	0xe1bec0b4 ;	ldrh	ip, [lr, r4]!
	DCD	0xe0421006 ;	sub	r1, r2, r6
	DCD	0xe1a01a41 ;	asr	r1, r1, #20
	DCD	0xe0822006 ;	add	r2, r2, r6
	DCD	0xe20c60ff ;	and	r6, ip, #255	; 0xff
	DCD	0xe0911006 ;	adds	r1, r1, r6
	DCD	0x43a01000 ;	movmi	r1, #0
	DCD	0xe35100ff ;	cmp	r1, #255	; 0xff
	DCD	0xc3a010ff ;	movgt	r1, #255	; 0xff
	DCD	0xe0436007 ;	sub	r6, r3, r7
	DCD	0xe1a06a46 ;	asr	r6, r6, #20
	DCD	0xe096642c ;	adds	r6, r6, ip, lsr #8
	DCD	0x43a06000 ;	movmi	r6, #0
	DCD	0xe35600ff ;	cmp	r6, #255	; 0xff
	DCD	0xc3a060ff ;	movgt	r6, #255	; 0xff
	DCD	0xe1811406 ;	orr	r1, r1, r6, lsl #8
	DCD	0xe0833007 ;	add	r3, r3, r7
	DCD	0xe135c0b4 ;	ldrh	ip, [r5, -r4]!
	DCD	0xe1ce10b0 ;	strh	r1, [lr]
	DCD	0xe1a02a42 ;	asr	r2, r2, #20
	DCD	0xe20c10ff ;	and	r1, ip, #255	; 0xff
	DCD	0xe0922001 ;	adds	r2, r2, r1
	DCD	0x43a02000 ;	movmi	r2, #0
	DCD	0xe35200ff ;	cmp	r2, #255	; 0xff
	DCD	0xc3a020ff ;	movgt	r2, #255	; 0xff
	DCD	0xe1a03a43 ;	asr	r3, r3, #20
	DCD	0xe093342c ;	adds	r3, r3, ip, lsr #8
	DCD	0x43a03000 ;	movmi	r3, #0
	DCD	0xe35300ff ;	cmp	r3, #255	; 0xff
	DCD	0xc3a030ff ;	movgt	r3, #255	; 0xff
	DCD	0xe1821403 ;	orr	r1, r2, r3, lsl #8
	DCD	0xe1c510b0 ;	strh	r1, [r5]
	DCD	0xe8bd000c ;	pop	{r2, r3}
	DCD	0xe1bec0b4 ;	ldrh	ip, [lr, r4]!
	DCD	0xe0821008 ;	add	r1, r2, r8
	DCD	0xe1a01a41 ;	asr	r1, r1, #20
	DCD	0xe0422008 ;	sub	r2, r2, r8
	DCD	0xe20c60ff ;	and	r6, ip, #255	; 0xff
	DCD	0xe0911006 ;	adds	r1, r1, r6
	DCD	0x43a01000 ;	movmi	r1, #0
	DCD	0xe35100ff ;	cmp	r1, #255	; 0xff
	DCD	0xc3a010ff ;	movgt	r1, #255	; 0xff
	DCD	0xe0836009 ;	add	r6, r3, r9
	DCD	0xe1a06a46 ;	asr	r6, r6, #20
	DCD	0xe096642c ;	adds	r6, r6, ip, lsr #8
	DCD	0x43a06000 ;	movmi	r6, #0
	DCD	0xe35600ff ;	cmp	r6, #255	; 0xff
	DCD	0xc3a060ff ;	movgt	r6, #255	; 0xff
	DCD	0xe1811406 ;	orr	r1, r1, r6, lsl #8
	DCD	0xe0433009 ;	sub	r3, r3, r9
	DCD	0xe135c0b4 ;	ldrh	ip, [r5, -r4]!
	DCD	0xe1ce10b0 ;	strh	r1, [lr]
	DCD	0xe1a02a42 ;	asr	r2, r2, #20
	DCD	0xe20c10ff ;	and	r1, ip, #255	; 0xff
	DCD	0xe0922001 ;	adds	r2, r2, r1
	DCD	0x43a02000 ;	movmi	r2, #0
	DCD	0xe35200ff ;	cmp	r2, #255	; 0xff
	DCD	0xc3a020ff ;	movgt	r2, #255	; 0xff
	DCD	0xe1a03a43 ;	asr	r3, r3, #20
	DCD	0xe093342c ;	adds	r3, r3, ip, lsr #8
	DCD	0x43a03000 ;	movmi	r3, #0
	DCD	0xe35300ff ;	cmp	r3, #255	; 0xff
	DCD	0xc3a030ff ;	movgt	r3, #255	; 0xff
	DCD	0xe1821403 ;	orr	r1, r2, r3, lsl #8
	DCD	0xe1c510b0 ;	strh	r1, [r5]
	DCD	0xe8bd000c ;	pop	{r2, r3}
	DCD	0xe1bec0b4 ;	ldrh	ip, [lr, r4]!
	DCD	0xe082100a ;	add	r1, r2, sl
	DCD	0xe1a01a41 ;	asr	r1, r1, #20
	DCD	0xe042200a ;	sub	r2, r2, sl
	DCD	0xe20c60ff ;	and	r6, ip, #255	; 0xff
	DCD	0xe0911006 ;	adds	r1, r1, r6
	DCD	0x43a01000 ;	movmi	r1, #0
	DCD	0xe35100ff ;	cmp	r1, #255	; 0xff
	DCD	0xc3a010ff ;	movgt	r1, #255	; 0xff
	DCD	0xe083600b ;	add	r6, r3, fp
	DCD	0xe1a06a46 ;	asr	r6, r6, #20
	DCD	0xe096642c ;	adds	r6, r6, ip, lsr #8
	DCD	0x43a06000 ;	movmi	r6, #0
	DCD	0xe35600ff ;	cmp	r6, #255	; 0xff
	DCD	0xc3a060ff ;	movgt	r6, #255	; 0xff
	DCD	0xe1811406 ;	orr	r1, r1, r6, lsl #8
	DCD	0xe043300b ;	sub	r3, r3, fp
	DCD	0xe135c0b4 ;	ldrh	ip, [r5, -r4]!
	DCD	0xe1ce10b0 ;	strh	r1, [lr]
	DCD	0xe1a02a42 ;	asr	r2, r2, #20
	DCD	0xe20c10ff ;	and	r1, ip, #255	; 0xff
	DCD	0xe0922001 ;	adds	r2, r2, r1
	DCD	0x43a02000 ;	movmi	r2, #0
	DCD	0xe35200ff ;	cmp	r2, #255	; 0xff
	DCD	0xc3a020ff ;	movgt	r2, #255	; 0xff
	DCD	0xe1a03a43 ;	asr	r3, r3, #20
	DCD	0xe093342c ;	adds	r3, r3, ip, lsr #8
	DCD	0x43a03000 ;	movmi	r3, #0
	DCD	0xe35300ff ;	cmp	r3, #255	; 0xff
	DCD	0xc3a030ff ;	movgt	r3, #255	; 0xff
	DCD	0xe1821403 ;	orr	r1, r2, r3, lsl #8
	DCD	0xe1c510b0 ;	strh	r1, [r5]
	DCD	0xe49df004 ;	pop	{pc}		; (ldr pc, [sp], #4)
	ENDP

|ff_simple_idct_armv5te| PROC
	DCD	0xe92d4ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, lr}
	DCD	0xebfffd54 ;	bl	c <idct_row_armv5te>
	DCD	0xe2800010 ;	add	r0, r0, #16
	DCD	0xebfffd52 ;	bl	c <idct_row_armv5te>
	DCD	0xe2800010 ;	add	r0, r0, #16
	DCD	0xebfffd50 ;	bl	c <idct_row_armv5te>
	DCD	0xe2800010 ;	add	r0, r0, #16
	DCD	0xebfffd4e ;	bl	c <idct_row_armv5te>
	DCD	0xe2800010 ;	add	r0, r0, #16
	DCD	0xebfffd4c ;	bl	c <idct_row_armv5te>
	DCD	0xe2800010 ;	add	r0, r0, #16
	DCD	0xebfffd4a ;	bl	c <idct_row_armv5te>
	DCD	0xe2800010 ;	add	r0, r0, #16
	DCD	0xebfffd48 ;	bl	c <idct_row_armv5te>
	DCD	0xe2800010 ;	add	r0, r0, #16
	DCD	0xebfffd46 ;	bl	c <idct_row_armv5te>
	DCD	0xe2400070 ;	sub	r0, r0, #112	; 0x70
	DCD	0xebfffd9f ;	bl	178 <idct_col_armv5te>
	DCD	0xe2800004 ;	add	r0, r0, #4
	DCD	0xebfffd9d ;	bl	178 <idct_col_armv5te>
	DCD	0xe2800004 ;	add	r0, r0, #4
	DCD	0xebfffd9b ;	bl	178 <idct_col_armv5te>
	DCD	0xe2800004 ;	add	r0, r0, #4
	DCD	0xebfffd99 ;	bl	178 <idct_col_armv5te>
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	ENDP

|ff_simple_idct_add_armv5te| PROC
	DCD	0xe92d4ff3 ;	push	{r0, r1, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	DCD	0xe1a00002 ;	mov	r0, r2
	DCD	0xebfffd3a ;	bl	c <idct_row_armv5te>
	DCD	0xe2800010 ;	add	r0, r0, #16
	DCD	0xebfffd38 ;	bl	c <idct_row_armv5te>
	DCD	0xe2800010 ;	add	r0, r0, #16
	DCD	0xebfffd36 ;	bl	c <idct_row_armv5te>
	DCD	0xe2800010 ;	add	r0, r0, #16
	DCD	0xebfffd34 ;	bl	c <idct_row_armv5te>
	DCD	0xe2800010 ;	add	r0, r0, #16
	DCD	0xebfffd32 ;	bl	c <idct_row_armv5te>
	DCD	0xe2800010 ;	add	r0, r0, #16
	DCD	0xebfffd30 ;	bl	c <idct_row_armv5te>
	DCD	0xe2800010 ;	add	r0, r0, #16
	DCD	0xebfffd2e ;	bl	c <idct_row_armv5te>
	DCD	0xe2800010 ;	add	r0, r0, #16
	DCD	0xebfffd2c ;	bl	c <idct_row_armv5te>
	DCD	0xe2400070 ;	sub	r0, r0, #112	; 0x70
	DCD	0xebfffeea ;	bl	70c <idct_col_add_armv5te>
	DCD	0xe2800004 ;	add	r0, r0, #4
	DCD	0xebfffee8 ;	bl	70c <idct_col_add_armv5te>
	DCD	0xe2800004 ;	add	r0, r0, #4
	DCD	0xebfffee6 ;	bl	70c <idct_col_add_armv5te>
	DCD	0xe2800004 ;	add	r0, r0, #4
	DCD	0xebfffee4 ;	bl	70c <idct_col_add_armv5te>
	DCD	0xe28dd008 ;	add	sp, sp, #8
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	ENDP

|ff_simple_idct_put_armv5te| PROC
	DCD	0xe92d4ff3 ;	push	{r0, r1, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	DCD	0xe1a00002 ;	mov	r0, r2
	DCD	0xebfffd1f ;	bl	c <idct_row_armv5te>
	DCD	0xe2800010 ;	add	r0, r0, #16
	DCD	0xebfffd1d ;	bl	c <idct_row_armv5te>
	DCD	0xe2800010 ;	add	r0, r0, #16
	DCD	0xebfffd1b ;	bl	c <idct_row_armv5te>
	DCD	0xe2800010 ;	add	r0, r0, #16
	DCD	0xebfffd19 ;	bl	c <idct_row_armv5te>
	DCD	0xe2800010 ;	add	r0, r0, #16
	DCD	0xebfffd17 ;	bl	c <idct_row_armv5te>
	DCD	0xe2800010 ;	add	r0, r0, #16
	DCD	0xebfffd15 ;	bl	c <idct_row_armv5te>
	DCD	0xe2800010 ;	add	r0, r0, #16
	DCD	0xebfffd13 ;	bl	c <idct_row_armv5te>
	DCD	0xe2800010 ;	add	r0, r0, #16
	DCD	0xebfffd11 ;	bl	c <idct_row_armv5te>
	DCD	0xe2400070 ;	sub	r0, r0, #112	; 0x70
	DCD	0xebfffe06 ;	bl	3e8 <idct_col_put_armv5te>
	DCD	0xe2800004 ;	add	r0, r0, #4
	DCD	0xebfffe04 ;	bl	3e8 <idct_col_put_armv5te>
	DCD	0xe2800004 ;	add	r0, r0, #4
	DCD	0xebfffe02 ;	bl	3e8 <idct_col_put_armv5te>
	DCD	0xe2800004 ;	add	r0, r0, #4
	DCD	0xebfffe00 ;	bl	3e8 <idct_col_put_armv5te>
	DCD	0xe28dd008 ;	add	sp, sp, #8
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	ENDP

	END
