	CODE32

	EXPORT	|idct_row_armv6|
	EXPORT	|idct_col_armv6|
	EXPORT	|idct_col_put_armv6|
	EXPORT	|idct_col_add_armv6|
	EXPORT	|ff_simple_idct_armv6|
	EXPORT	|ff_simple_idct_add_armv6|
	EXPORT	|ff_simple_idct_put_armv6|

	AREA	|.text|, DATA, READONLY
|w13|
	DCD	0x4b4258c5 ;	blmi	109631c <ff_simple_idct_put_armv6+0x1095d00>
|w26|
	DCD	0x22a3539f ;	adccs	r5, r3, #2080374786	; 0x7c000002
|w42|
	DCD	0x539f3fff ;	orrspl	r3, pc, #1020	; 0x3fc
|w42n|
	DCD	0xac61c001 ;	stclge	0, cr12, [r1], #-4
|w46|
	DCD	0x22a33fff ;	adccs	r3, r3, #1020	; 0x3fc
|w57|
	DCD	0x11a83249 ;			; <UNDEFINED> instruction: 0x11a83249

	AREA	|.text|, CODE, ARM
|idct_row_armv6| PROC
	DCD	0xe52de004 ;	push	{lr}		; (str lr, [sp, #-4]!)
	DCD	0xe590e00c ;	ldr	lr, [r0, #12]
	DCD	0xe590c004 ;	ldr	ip, [r0, #4]
	DCD	0xe5903008 ;	ldr	r3, [r0, #8]
	DCD	0xe5902000 ;	ldr	r2, [r0]
	DCD	0xe19ee00c ;	orrs	lr, lr, ip
	DCD	0x015e0003 ;	cmpeq	lr, r3
	DCD	0x015e0822 ;	cmpeq	lr, r2, lsr #16
	DCD	0x0a000046 ;	beq	158 <idct_row_armv6+0x140>
	DCD	0xe52d1004 ;	push	{r1}		; (str r1, [sp, #-4]!)
	DCD	0xe51fc040 ;	ldr	ip, [pc, #-64]	; 8 <w42>
	DCD	0xe35e0000 ;	cmp	lr, #0
	DCD	0x0a00001a ;	beq	b8 <idct_row_armv6+0xa0>
	DCD	0xe51fe044 ;	ldr	lr, [pc, #-68]	; 10 <w46>
	DCD	0xe3a01b01 ;	mov	r1, #1024	; 0x400
	DCD	0xe7041c12 ;	smlad	r4, r2, ip, r1
	DCD	0xe7071c52 ;	smlsd	r7, r2, ip, r1
	DCD	0xe51fc064 ;	ldr	ip, [pc, #-100]	; 0 <w13>
	DCD	0xe51fa054 ;	ldr	sl, [pc, #-84]	; 14 <w57>
	DCD	0xe7051e12 ;	smlad	r5, r2, lr, r1
	DCD	0xe7061e52 ;	smlsd	r6, r2, lr, r1
	DCD	0xe708fc13 ;	smuad	r8, r3, ip
	DCD	0xe70bfa73 ;	smusdx	fp, r3, sl
	DCD	0xe590e00c ;	ldr	lr, [r0, #12]
	DCD	0xe68c285a ;	pkhtb	r2, ip, sl, asr #16
	DCD	0xe68c181a ;	pkhbt	r1, ip, sl, lsl #16
	DCD	0xe709f372 ;	smusdx	r9, r2, r3
	DCD	0xe7088a1e ;	smlad	r8, lr, sl, r8
	DCD	0xe70af173 ;	smusdx	sl, r3, r1
	DCD	0xe51f3088 ;	ldr	r3, [pc, #-136]	; c <w42n>
	DCD	0xe70aa21e ;	smlad	sl, lr, r2, sl
	DCD	0xe5902004 ;	ldr	r2, [r0, #4]
	DCD	0xe70bbc7e ;	smlsdx	fp, lr, ip, fp
	DCD	0xe51fc094 ;	ldr	ip, [pc, #-148]	; 10 <w46>
	DCD	0xe709911e ;	smlad	r9, lr, r1, r9
	DCD	0xe7055312 ;	smlad	r5, r2, r3, r5
	DCD	0xe7066352 ;	smlsd	r6, r2, r3, r6
	DCD	0xe7044c12 ;	smlad	r4, r2, ip, r4
	DCD	0xe7077c52 ;	smlsd	r7, r2, ip, r7
	DCD	0xea00000d ;	b	f0 <idct_row_armv6+0xd8>
	DCD	0xe51fe0b0 ;	ldr	lr, [pc, #-176]	; 10 <w46>
	DCD	0xe51fa0b0 ;	ldr	sl, [pc, #-176]	; 14 <w57>
	DCD	0xe3a01b01 ;	mov	r1, #1024	; 0x400
	DCD	0xe7041c12 ;	smlad	r4, r2, ip, r1
	DCD	0xe7071c52 ;	smlsd	r7, r2, ip, r1
	DCD	0xe51fc0d4 ;	ldr	ip, [pc, #-212]	; 0 <w13>
	DCD	0xe7051e12 ;	smlad	r5, r2, lr, r1
	DCD	0xe7061e52 ;	smlsd	r6, r2, lr, r1
	DCD	0xe70bfa73 ;	smusdx	fp, r3, sl
	DCD	0xe708fc13 ;	smuad	r8, r3, ip
	DCD	0xe68c285a ;	pkhtb	r2, ip, sl, asr #16
	DCD	0xe68c181a ;	pkhbt	r1, ip, sl, lsl #16
	DCD	0xe709f372 ;	smusdx	r9, r2, r3
	DCD	0xe70af173 ;	smusdx	sl, r3, r1
	DCD	0xe49d1004 ;	pop	{r1}		; (ldr r1, [sp], #4)
	DCD	0xe0843008 ;	add	r3, r4, r8
	DCD	0xe0442008 ;	sub	r2, r4, r8
	DCD	0xe1a045c3 ;	asr	r4, r3, #11
	DCD	0xe1a085c2 ;	asr	r8, r2, #11
	DCD	0xe0453009 ;	sub	r3, r5, r9
	DCD	0xe0852009 ;	add	r2, r5, r9
	DCD	0xe1a055c3 ;	asr	r5, r3, #11
	DCD	0xe1a095c2 ;	asr	r9, r2, #11
	DCD	0xe086300a ;	add	r3, r6, sl
	DCD	0xe046200a ;	sub	r2, r6, sl
	DCD	0xe1a065c3 ;	asr	r6, r3, #11
	DCD	0xe1a0a5c2 ;	asr	sl, r2, #11
	DCD	0xe087300b ;	add	r3, r7, fp
	DCD	0xe047200b ;	sub	r2, r7, fp
	DCD	0xe1a075c3 ;	asr	r7, r3, #11
	DCD	0xe1a0b5c2 ;	asr	fp, r2, #11
	DCD	0xe1c140b0 ;	strh	r4, [r1]
	DCD	0xe1c152b0 ;	strh	r5, [r1, #32]
	DCD	0xe1c164b0 ;	strh	r6, [r1, #64]	; 0x40
	DCD	0xe1c176b0 ;	strh	r7, [r1, #96]	; 0x60
	DCD	0xe1c1b1b0 ;	strh	fp, [r1, #16]
	DCD	0xe1c1a3b0 ;	strh	sl, [r1, #48]	; 0x30
	DCD	0xe1c195b0 ;	strh	r9, [r1, #80]	; 0x50
	DCD	0xe1c187b0 ;	strh	r8, [r1, #112]	; 0x70
	DCD	0xe49df004 ;	pop	{pc}		; (ldr pc, [sp], #4)
	DCD	0xe1a02182 ;	lsl	r2, r2, #3
	DCD	0xe1c120b0 ;	strh	r2, [r1]
	DCD	0xe1c122b0 ;	strh	r2, [r1, #32]
	DCD	0xe1c124b0 ;	strh	r2, [r1, #64]	; 0x40
	DCD	0xe1c126b0 ;	strh	r2, [r1, #96]	; 0x60
	DCD	0xe1c121b0 ;	strh	r2, [r1, #16]
	DCD	0xe1c123b0 ;	strh	r2, [r1, #48]	; 0x30
	DCD	0xe1c125b0 ;	strh	r2, [r1, #80]	; 0x50
	DCD	0xe1c127b0 ;	strh	r2, [r1, #112]	; 0x70
	DCD	0xe49df004 ;	pop	{pc}		; (ldr pc, [sp], #4)
	ENDP

|idct_col_armv6| PROC
	DCD	0xe92d4002 ;	push	{r1, lr}
	DCD	0xe5902000 ;	ldr	r2, [r0]
	DCD	0xe51fc188 ;	ldr	ip, [pc, #-392]	; 8 <w42>
	DCD	0xe5903008 ;	ldr	r3, [r0, #8]
	DCD	0xe51fe188 ;	ldr	lr, [pc, #-392]	; 10 <w46>
	DCD	0xe3a01702 ;	mov	r1, #524288	; 0x80000
	DCD	0xe7041c12 ;	smlad	r4, r2, ip, r1
	DCD	0xe7071c52 ;	smlsd	r7, r2, ip, r1
	DCD	0xe51fc1a8 ;	ldr	ip, [pc, #-424]	; 0 <w13>
	DCD	0xe51fa198 ;	ldr	sl, [pc, #-408]	; 14 <w57>
	DCD	0xe7051e12 ;	smlad	r5, r2, lr, r1
	DCD	0xe7061e52 ;	smlsd	r6, r2, lr, r1
	DCD	0xe708fc13 ;	smuad	r8, r3, ip
	DCD	0xe70bfa73 ;	smusdx	fp, r3, sl
	DCD	0xe590e00c ;	ldr	lr, [r0, #12]
	DCD	0xe68c285a ;	pkhtb	r2, ip, sl, asr #16
	DCD	0xe68c181a ;	pkhbt	r1, ip, sl, lsl #16
	DCD	0xe709f372 ;	smusdx	r9, r2, r3
	DCD	0xe7088a1e ;	smlad	r8, lr, sl, r8
	DCD	0xe70af173 ;	smusdx	sl, r3, r1
	DCD	0xe51f31cc ;	ldr	r3, [pc, #-460]	; c <w42n>
	DCD	0xe70aa21e ;	smlad	sl, lr, r2, sl
	DCD	0xe5902004 ;	ldr	r2, [r0, #4]
	DCD	0xe70bbc7e ;	smlsdx	fp, lr, ip, fp
	DCD	0xe51fc1d8 ;	ldr	ip, [pc, #-472]	; 10 <w46>
	DCD	0xe709911e ;	smlad	r9, lr, r1, r9
	DCD	0xe7055312 ;	smlad	r5, r2, r3, r5
	DCD	0xe7066352 ;	smlsd	r6, r2, r3, r6
	DCD	0xe7044c12 ;	smlad	r4, r2, ip, r4
	DCD	0xe7077c52 ;	smlsd	r7, r2, ip, r7
	DCD	0xe49d1004 ;	pop	{r1}		; (ldr r1, [sp], #4)
	DCD	0xe0843008 ;	add	r3, r4, r8
	DCD	0xe0442008 ;	sub	r2, r4, r8
	DCD	0xe1a04a43 ;	asr	r4, r3, #20
	DCD	0xe1a08a42 ;	asr	r8, r2, #20
	DCD	0xe0453009 ;	sub	r3, r5, r9
	DCD	0xe0852009 ;	add	r2, r5, r9
	DCD	0xe1a05a43 ;	asr	r5, r3, #20
	DCD	0xe1a09a42 ;	asr	r9, r2, #20
	DCD	0xe086300a ;	add	r3, r6, sl
	DCD	0xe046200a ;	sub	r2, r6, sl
	DCD	0xe1a06a43 ;	asr	r6, r3, #20
	DCD	0xe1a0aa42 ;	asr	sl, r2, #20
	DCD	0xe087300b ;	add	r3, r7, fp
	DCD	0xe047200b ;	sub	r2, r7, fp
	DCD	0xe1a07a43 ;	asr	r7, r3, #20
	DCD	0xe1a0ba42 ;	asr	fp, r2, #20
	DCD	0xe1c140b0 ;	strh	r4, [r1]
	DCD	0xe1c151b0 ;	strh	r5, [r1, #16]
	DCD	0xe1c162b0 ;	strh	r6, [r1, #32]
	DCD	0xe1c173b0 ;	strh	r7, [r1, #48]	; 0x30
	DCD	0xe1c1b4b0 ;	strh	fp, [r1, #64]	; 0x40
	DCD	0xe1c1a5b0 ;	strh	sl, [r1, #80]	; 0x50
	DCD	0xe1c196b0 ;	strh	r9, [r1, #96]	; 0x60
	DCD	0xe1c187b0 ;	strh	r8, [r1, #112]	; 0x70
	DCD	0xe49df004 ;	pop	{pc}		; (ldr pc, [sp], #4)
	ENDP

|idct_col_put_armv6| PROC
	DCD	0xe92d4006 ;	push	{r1, r2, lr}
	DCD	0xe5902000 ;	ldr	r2, [r0]
	DCD	0xe51fc268 ;	ldr	ip, [pc, #-616]	; 8 <w42>
	DCD	0xe5903008 ;	ldr	r3, [r0, #8]
	DCD	0xe51fe268 ;	ldr	lr, [pc, #-616]	; 10 <w46>
	DCD	0xe3a01702 ;	mov	r1, #524288	; 0x80000
	DCD	0xe7041c12 ;	smlad	r4, r2, ip, r1
	DCD	0xe7071c52 ;	smlsd	r7, r2, ip, r1
	DCD	0xe51fc288 ;	ldr	ip, [pc, #-648]	; 0 <w13>
	DCD	0xe51fa278 ;	ldr	sl, [pc, #-632]	; 14 <w57>
	DCD	0xe7051e12 ;	smlad	r5, r2, lr, r1
	DCD	0xe7061e52 ;	smlsd	r6, r2, lr, r1
	DCD	0xe708fc13 ;	smuad	r8, r3, ip
	DCD	0xe70bfa73 ;	smusdx	fp, r3, sl
	DCD	0xe590e00c ;	ldr	lr, [r0, #12]
	DCD	0xe68c285a ;	pkhtb	r2, ip, sl, asr #16
	DCD	0xe68c181a ;	pkhbt	r1, ip, sl, lsl #16
	DCD	0xe709f372 ;	smusdx	r9, r2, r3
	DCD	0xe7088a1e ;	smlad	r8, lr, sl, r8
	DCD	0xe70af173 ;	smusdx	sl, r3, r1
	DCD	0xe51f32ac ;	ldr	r3, [pc, #-684]	; c <w42n>
	DCD	0xe70aa21e ;	smlad	sl, lr, r2, sl
	DCD	0xe5902004 ;	ldr	r2, [r0, #4]
	DCD	0xe70bbc7e ;	smlsdx	fp, lr, ip, fp
	DCD	0xe51fc2b8 ;	ldr	ip, [pc, #-696]	; 10 <w46>
	DCD	0xe709911e ;	smlad	r9, lr, r1, r9
	DCD	0xe7055312 ;	smlad	r5, r2, r3, r5
	DCD	0xe7066352 ;	smlsd	r6, r2, r3, r6
	DCD	0xe7044c12 ;	smlad	r4, r2, ip, r4
	DCD	0xe7077c52 ;	smlsd	r7, r2, ip, r7
	DCD	0xe8bd0006 ;	pop	{r1, r2}
	DCD	0xe0843008 ;	add	r3, r4, r8
	DCD	0xe044c008 ;	sub	ip, r4, r8
	DCD	0xe6e84a53 ;	usat	r4, #8, r3, asr #20
	DCD	0xe6e88a5c ;	usat	r8, #8, ip, asr #20
	DCD	0xe0453009 ;	sub	r3, r5, r9
	DCD	0xe085c009 ;	add	ip, r5, r9
	DCD	0xe6e85a53 ;	usat	r5, #8, r3, asr #20
	DCD	0xe6e89a5c ;	usat	r9, #8, ip, asr #20
	DCD	0xe086300a ;	add	r3, r6, sl
	DCD	0xe046c00a ;	sub	ip, r6, sl
	DCD	0xe6e86a53 ;	usat	r6, #8, r3, asr #20
	DCD	0xe6e8aa5c ;	usat	sl, #8, ip, asr #20
	DCD	0xe087300b ;	add	r3, r7, fp
	DCD	0xe047c00b ;	sub	ip, r7, fp
	DCD	0xe6e87a53 ;	usat	r7, #8, r3, asr #20
	DCD	0xe6e8ba5c ;	usat	fp, #8, ip, asr #20
	DCD	0xe6c14002 ;	strb	r4, [r1], r2
	DCD	0xe6c15002 ;	strb	r5, [r1], r2
	DCD	0xe6c16002 ;	strb	r6, [r1], r2
	DCD	0xe6c17002 ;	strb	r7, [r1], r2
	DCD	0xe6c1b002 ;	strb	fp, [r1], r2
	DCD	0xe6c1a002 ;	strb	sl, [r1], r2
	DCD	0xe6c19002 ;	strb	r9, [r1], r2
	DCD	0xe6c18002 ;	strb	r8, [r1], r2
	DCD	0xe0411182 ;	sub	r1, r1, r2, lsl #3
	DCD	0xe49df004 ;	pop	{pc}		; (ldr pc, [sp], #4)
	ENDP

|idct_col_add_armv6| PROC
	DCD	0xe92d4006 ;	push	{r1, r2, lr}
	DCD	0xe5902000 ;	ldr	r2, [r0]
	DCD	0xe51fc34c ;	ldr	ip, [pc, #-844]	; 8 <w42>
	DCD	0xe5903008 ;	ldr	r3, [r0, #8]
	DCD	0xe51fe34c ;	ldr	lr, [pc, #-844]	; 10 <w46>
	DCD	0xe3a01702 ;	mov	r1, #524288	; 0x80000
	DCD	0xe7041c12 ;	smlad	r4, r2, ip, r1
	DCD	0xe7071c52 ;	smlsd	r7, r2, ip, r1
	DCD	0xe51fc36c ;	ldr	ip, [pc, #-876]	; 0 <w13>
	DCD	0xe51fa35c ;	ldr	sl, [pc, #-860]	; 14 <w57>
	DCD	0xe7051e12 ;	smlad	r5, r2, lr, r1
	DCD	0xe7061e52 ;	smlsd	r6, r2, lr, r1
	DCD	0xe708fc13 ;	smuad	r8, r3, ip
	DCD	0xe70bfa73 ;	smusdx	fp, r3, sl
	DCD	0xe590e00c ;	ldr	lr, [r0, #12]
	DCD	0xe68c285a ;	pkhtb	r2, ip, sl, asr #16
	DCD	0xe68c181a ;	pkhbt	r1, ip, sl, lsl #16
	DCD	0xe709f372 ;	smusdx	r9, r2, r3
	DCD	0xe7088a1e ;	smlad	r8, lr, sl, r8
	DCD	0xe70af173 ;	smusdx	sl, r3, r1
	DCD	0xe51f3390 ;	ldr	r3, [pc, #-912]	; c <w42n>
	DCD	0xe70aa21e ;	smlad	sl, lr, r2, sl
	DCD	0xe5902004 ;	ldr	r2, [r0, #4]
	DCD	0xe70bbc7e ;	smlsdx	fp, lr, ip, fp
	DCD	0xe51fc39c ;	ldr	ip, [pc, #-924]	; 10 <w46>
	DCD	0xe709911e ;	smlad	r9, lr, r1, r9
	DCD	0xe7055312 ;	smlad	r5, r2, r3, r5
	DCD	0xe7066352 ;	smlsd	r6, r2, r3, r6
	DCD	0xe7044c12 ;	smlad	r4, r2, ip, r4
	DCD	0xe7077c52 ;	smlsd	r7, r2, ip, r7
	DCD	0xe8bd0006 ;	pop	{r1, r2}
	DCD	0xe084c008 ;	add	ip, r4, r8
	DCD	0xe044e008 ;	sub	lr, r4, r8
	DCD	0xe0454009 ;	sub	r4, r5, r9
	DCD	0xe0858009 ;	add	r8, r5, r9
	DCD	0xe086500a ;	add	r5, r6, sl
	DCD	0xe046900a ;	sub	r9, r6, sl
	DCD	0xe087600b ;	add	r6, r7, fp
	DCD	0xe047a00b ;	sub	sl, r7, fp
	DCD	0xe5d13000 ;	ldrb	r3, [r1]
	DCD	0xe7d17002 ;	ldrb	r7, [r1, r2]
	DCD	0xe7d1b102 ;	ldrb	fp, [r1, r2, lsl #2]
	DCD	0xe083ca4c ;	add	ip, r3, ip, asr #20
	DCD	0xe6e8c01c ;	usat	ip, #8, ip
	DCD	0xe0874a44 ;	add	r4, r7, r4, asr #20
	DCD	0xe6c1c002 ;	strb	ip, [r1], r2
	DCD	0xe7d1c002 ;	ldrb	ip, [r1, r2]
	DCD	0xe6e84014 ;	usat	r4, #8, r4
	DCD	0xe7d1b102 ;	ldrb	fp, [r1, r2, lsl #2]
	DCD	0xe08c5a45 ;	add	r5, ip, r5, asr #20
	DCD	0xe6e85015 ;	usat	r5, #8, r5
	DCD	0xe6c14002 ;	strb	r4, [r1], r2
	DCD	0xe7d13002 ;	ldrb	r3, [r1, r2]
	DCD	0xe7d1c102 ;	ldrb	ip, [r1, r2, lsl #2]
	DCD	0xe6c15002 ;	strb	r5, [r1], r2
	DCD	0xe7d17002 ;	ldrb	r7, [r1, r2]
	DCD	0xe7d14102 ;	ldrb	r4, [r1, r2, lsl #2]
	DCD	0xe0836a46 ;	add	r6, r3, r6, asr #20
	DCD	0xe6e86016 ;	usat	r6, #8, r6
	DCD	0xe087aa4a ;	add	sl, r7, sl, asr #20
	DCD	0xe6e8a01a ;	usat	sl, #8, sl
	DCD	0xe08b9a49 ;	add	r9, fp, r9, asr #20
	DCD	0xe6e89019 ;	usat	r9, #8, r9
	DCD	0xe08c8a48 ;	add	r8, ip, r8, asr #20
	DCD	0xe6e88018 ;	usat	r8, #8, r8
	DCD	0xe084ea4e ;	add	lr, r4, lr, asr #20
	DCD	0xe6e8e01e ;	usat	lr, #8, lr
	DCD	0xe6c16002 ;	strb	r6, [r1], r2
	DCD	0xe6c1a002 ;	strb	sl, [r1], r2
	DCD	0xe6c19002 ;	strb	r9, [r1], r2
	DCD	0xe6c18002 ;	strb	r8, [r1], r2
	DCD	0xe6c1e002 ;	strb	lr, [r1], r2
	DCD	0xe0411182 ;	sub	r1, r1, r2, lsl #3
	DCD	0xe49df004 ;	pop	{pc}		; (ldr pc, [sp], #4)
	ENDP

|ff_simple_idct_armv6| PROC
	DCD	0xe92d4ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, lr}
	DCD	0xe24dd080 ;	sub	sp, sp, #128	; 0x80
	DCD	0xe1a0100d ;	mov	r1, sp
	DCD	0xebfffee6 ;	bl	18 <idct_row_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebfffee3 ;	bl	18 <idct_row_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebfffee0 ;	bl	18 <idct_row_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebfffedd ;	bl	18 <idct_row_armv6>
	DCD	0xe2400050 ;	sub	r0, r0, #80	; 0x50
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebfffeda ;	bl	18 <idct_row_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebfffed7 ;	bl	18 <idct_row_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebfffed4 ;	bl	18 <idct_row_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebfffed1 ;	bl	18 <idct_row_armv6>
	DCD	0xe2400070 ;	sub	r0, r0, #112	; 0x70
	DCD	0xe1a01000 ;	mov	r1, r0
	DCD	0xe1a0000d ;	mov	r0, sp
	DCD	0xebffff27 ;	bl	180 <idct_col_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebffff24 ;	bl	180 <idct_col_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebffff21 ;	bl	180 <idct_col_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebffff1e ;	bl	180 <idct_col_armv6>
	DCD	0xe2400050 ;	sub	r0, r0, #80	; 0x50
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebffff1b ;	bl	180 <idct_col_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebffff18 ;	bl	180 <idct_col_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebffff15 ;	bl	180 <idct_col_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebffff12 ;	bl	180 <idct_col_armv6>
	DCD	0xe2400070 ;	sub	r0, r0, #112	; 0x70
	DCD	0xe28dd080 ;	add	sp, sp, #128	; 0x80
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	ENDP

|ff_simple_idct_add_armv6| PROC
	DCD	0xe92d4ff3 ;	push	{r0, r1, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	DCD	0xe24dd080 ;	sub	sp, sp, #128	; 0x80
	DCD	0xe1a00002 ;	mov	r0, r2
	DCD	0xe1a0100d ;	mov	r1, sp
	DCD	0xebfffeb0 ;	bl	18 <idct_row_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebfffead ;	bl	18 <idct_row_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebfffeaa ;	bl	18 <idct_row_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebfffea7 ;	bl	18 <idct_row_armv6>
	DCD	0xe2400050 ;	sub	r0, r0, #80	; 0x50
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebfffea4 ;	bl	18 <idct_row_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebfffea1 ;	bl	18 <idct_row_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebfffe9e ;	bl	18 <idct_row_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebfffe9b ;	bl	18 <idct_row_armv6>
	DCD	0xe2400070 ;	sub	r0, r0, #112	; 0x70
	DCD	0xe1a0000d ;	mov	r0, sp
	DCD	0xe59d1080 ;	ldr	r1, [sp, #128]	; 0x80
	DCD	0xe59d2084 ;	ldr	r2, [sp, #132]	; 0x84
	DCD	0xebffff61 ;	bl	344 <idct_col_add_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811001 ;	add	r1, r1, #1
	DCD	0xebffff5e ;	bl	344 <idct_col_add_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811001 ;	add	r1, r1, #1
	DCD	0xebffff5b ;	bl	344 <idct_col_add_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811001 ;	add	r1, r1, #1
	DCD	0xebffff58 ;	bl	344 <idct_col_add_armv6>
	DCD	0xe2400050 ;	sub	r0, r0, #80	; 0x50
	DCD	0xe2811001 ;	add	r1, r1, #1
	DCD	0xebffff55 ;	bl	344 <idct_col_add_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811001 ;	add	r1, r1, #1
	DCD	0xebffff52 ;	bl	344 <idct_col_add_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811001 ;	add	r1, r1, #1
	DCD	0xebffff4f ;	bl	344 <idct_col_add_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811001 ;	add	r1, r1, #1
	DCD	0xebffff4c ;	bl	344 <idct_col_add_armv6>
	DCD	0xe2400070 ;	sub	r0, r0, #112	; 0x70
	DCD	0xe28dd088 ;	add	sp, sp, #136	; 0x88
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	ENDP

|ff_simple_idct_put_armv6| PROC
	DCD	0xe92d4ff3 ;	push	{r0, r1, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	DCD	0xe24dd080 ;	sub	sp, sp, #128	; 0x80
	DCD	0xe1a00002 ;	mov	r0, r2
	DCD	0xe1a0100d ;	mov	r1, sp
	DCD	0xebfffe79 ;	bl	18 <idct_row_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebfffe76 ;	bl	18 <idct_row_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebfffe73 ;	bl	18 <idct_row_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebfffe70 ;	bl	18 <idct_row_armv6>
	DCD	0xe2400050 ;	sub	r0, r0, #80	; 0x50
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebfffe6d ;	bl	18 <idct_row_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebfffe6a ;	bl	18 <idct_row_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebfffe67 ;	bl	18 <idct_row_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811002 ;	add	r1, r1, #2
	DCD	0xebfffe64 ;	bl	18 <idct_row_armv6>
	DCD	0xe2400070 ;	sub	r0, r0, #112	; 0x70
	DCD	0xe1a0000d ;	mov	r0, sp
	DCD	0xe59d1080 ;	ldr	r1, [sp, #128]	; 0x80
	DCD	0xe59d2084 ;	ldr	r2, [sp, #132]	; 0x84
	DCD	0xebfffef1 ;	bl	260 <idct_col_put_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811001 ;	add	r1, r1, #1
	DCD	0xebfffeee ;	bl	260 <idct_col_put_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811001 ;	add	r1, r1, #1
	DCD	0xebfffeeb ;	bl	260 <idct_col_put_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811001 ;	add	r1, r1, #1
	DCD	0xebfffee8 ;	bl	260 <idct_col_put_armv6>
	DCD	0xe2400050 ;	sub	r0, r0, #80	; 0x50
	DCD	0xe2811001 ;	add	r1, r1, #1
	DCD	0xebfffee5 ;	bl	260 <idct_col_put_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811001 ;	add	r1, r1, #1
	DCD	0xebfffee2 ;	bl	260 <idct_col_put_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811001 ;	add	r1, r1, #1
	DCD	0xebfffedf ;	bl	260 <idct_col_put_armv6>
	DCD	0xe2800020 ;	add	r0, r0, #32
	DCD	0xe2811001 ;	add	r1, r1, #1
	DCD	0xebfffedc ;	bl	260 <idct_col_put_armv6>
	DCD	0xe2400070 ;	sub	r0, r0, #112	; 0x70
	DCD	0xe28dd088 ;	add	sp, sp, #136	; 0x88
	DCD	0xe8bd8ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
	ENDP

	END
