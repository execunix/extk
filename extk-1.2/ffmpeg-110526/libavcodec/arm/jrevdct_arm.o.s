	CODE32

	EXPORT	|ff_j_rev_dct_arm|

	AREA	|.text|, CODE, ARM
|ff_j_rev_dct_arm| PROC
	DCD	0xe92d5ff0 ;	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
	DCD	0xe24dd004 ;	sub	sp, sp, #4
	DCD	0xe58d0000 ;	str	r0, [sp]
	DCD	0xe1a0e000 ;	mov	lr, r0
	DCD	0xe3a0c008 ;	mov	ip, #8
	DCD	0xe28fbfdb ;	add	fp, pc, #876	; 0x36c
	ENDP

|row_loop| PROC
	DCD	0xe1de00f0 ;	ldrsh	r0, [lr]
	DCD	0xe1de20f2 ;	ldrsh	r2, [lr, #2]
	DCD	0xe59e5000 ;	ldr	r5, [lr]
	DCD	0xe59e6004 ;	ldr	r6, [lr, #4]
	DCD	0xe59e3008 ;	ldr	r3, [lr, #8]
	DCD	0xe59e400c ;	ldr	r4, [lr, #12]
	DCD	0xe1833004 ;	orr	r3, r3, r4
	DCD	0xe1833006 ;	orr	r3, r3, r6
	DCD	0xe1935005 ;	orrs	r5, r3, r5
	DCD	0x0a00005d ;	beq	1b8 <end_of_row_loop>
	DCD	0xe1933002 ;	orrs	r3, r3, r2
	DCD	0x0a000053 ;	beq	198 <empty_row>
	DCD	0xe1de10f8 ;	ldrsh	r1, [lr, #8]
	DCD	0xe1de40f4 ;	ldrsh	r4, [lr, #4]
	DCD	0xe1de60f6 ;	ldrsh	r6, [lr, #6]
	DCD	0xe59b3004 ;	ldr	r3, [fp, #4]
	DCD	0xe0827006 ;	add	r7, r2, r6
	DCD	0xe59b5024 ;	ldr	r5, [fp, #36]	; 0x24
	DCD	0xe0070793 ;	mul	r7, r3, r7
	DCD	0xe59b3008 ;	ldr	r3, [fp, #8]
	DCD	0xe0267695 ;	mla	r6, r5, r6, r7
	DCD	0xe0805004 ;	add	r5, r0, r4
	DCD	0xe0227293 ;	mla	r2, r3, r2, r7
	DCD	0xe0403004 ;	sub	r3, r0, r4
	DCD	0xe0820685 ;	add	r0, r2, r5, lsl #13
	DCD	0xe0622685 ;	rsb	r2, r2, r5, lsl #13
	DCD	0xe0864683 ;	add	r4, r6, r3, lsl #13
	DCD	0xe0663683 ;	rsb	r3, r6, r3, lsl #13
	DCD	0xe92d001d ;	push	{r0, r2, r3, r4}
	DCD	0xe1de30fa ;	ldrsh	r3, [lr, #10]
	DCD	0xe1de50fc ;	ldrsh	r5, [lr, #12]
	DCD	0xe1de70fe ;	ldrsh	r7, [lr, #14]
	DCD	0xe0830005 ;	add	r0, r3, r5
	DCD	0xe0812007 ;	add	r2, r1, r7
	DCD	0xe0834007 ;	add	r4, r3, r7
	DCD	0xe0816005 ;	add	r6, r1, r5
	DCD	0xe59b900c ;	ldr	r9, [fp, #12]
	DCD	0xe0848006 ;	add	r8, r4, r6
	DCD	0xe59ba020 ;	ldr	sl, [fp, #32]
	DCD	0xe0080899 ;	mul	r8, r9, r8
	DCD	0xe59b902c ;	ldr	r9, [fp, #44]	; 0x2c
	DCD	0xe002029a ;	mul	r2, sl, r2
	DCD	0xe59ba028 ;	ldr	sl, [fp, #40]	; 0x28
	DCD	0xe0000099 ;	mul	r0, r9, r0
	DCD	0xe59b901c ;	ldr	r9, [fp, #28]
	DCD	0xe024849a ;	mla	r4, sl, r4, r8
	DCD	0xe59ba000 ;	ldr	sl, [fp]
	DCD	0xe0268699 ;	mla	r6, r9, r6, r8
	DCD	0xe59b9014 ;	ldr	r9, [fp, #20]
	DCD	0xe027279a ;	mla	r7, sl, r7, r2
	DCD	0xe59ba018 ;	ldr	sl, [fp, #24]
	DCD	0xe0250599 ;	mla	r5, r9, r5, r0
	DCD	0xe59b9010 ;	ldr	r9, [fp, #16]
	DCD	0xe023039a ;	mla	r3, sl, r3, r0
	DCD	0xe0877004 ;	add	r7, r7, r4
	DCD	0xe0212199 ;	mla	r1, r9, r1, r2
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0833004 ;	add	r3, r3, r4
	DCD	0xe0811006 ;	add	r1, r1, r6
	DCD	0xe8bd0055 ;	pop	{r0, r2, r4, r6}
	DCD	0xe0808001 ;	add	r8, r0, r1
	DCD	0xe2888b01 ;	add	r8, r8, #1024	; 0x400
	DCD	0xe1a085c8 ;	asr	r8, r8, #11
	DCD	0xe1ce80b0 ;	strh	r8, [lr]
	DCD	0xe0408001 ;	sub	r8, r0, r1
	DCD	0xe2888b01 ;	add	r8, r8, #1024	; 0x400
	DCD	0xe1a085c8 ;	asr	r8, r8, #11
	DCD	0xe1ce80be ;	strh	r8, [lr, #14]
	DCD	0xe0868003 ;	add	r8, r6, r3
	DCD	0xe2888b01 ;	add	r8, r8, #1024	; 0x400
	DCD	0xe1a085c8 ;	asr	r8, r8, #11
	DCD	0xe1ce80b2 ;	strh	r8, [lr, #2]
	DCD	0xe0468003 ;	sub	r8, r6, r3
	DCD	0xe2888b01 ;	add	r8, r8, #1024	; 0x400
	DCD	0xe1a085c8 ;	asr	r8, r8, #11
	DCD	0xe1ce80bc ;	strh	r8, [lr, #12]
	DCD	0xe0848005 ;	add	r8, r4, r5
	DCD	0xe2888b01 ;	add	r8, r8, #1024	; 0x400
	DCD	0xe1a085c8 ;	asr	r8, r8, #11
	DCD	0xe1ce80b4 ;	strh	r8, [lr, #4]
	DCD	0xe0448005 ;	sub	r8, r4, r5
	DCD	0xe2888b01 ;	add	r8, r8, #1024	; 0x400
	DCD	0xe1a085c8 ;	asr	r8, r8, #11
	DCD	0xe1ce80ba ;	strh	r8, [lr, #10]
	DCD	0xe0828007 ;	add	r8, r2, r7
	DCD	0xe2888b01 ;	add	r8, r8, #1024	; 0x400
	DCD	0xe1a085c8 ;	asr	r8, r8, #11
	DCD	0xe1ce80b6 ;	strh	r8, [lr, #6]
	DCD	0xe0428007 ;	sub	r8, r2, r7
	DCD	0xe2888b01 ;	add	r8, r8, #1024	; 0x400
	DCD	0xe1a085c8 ;	asr	r8, r8, #11
	DCD	0xe1ce80b8 ;	strh	r8, [lr, #8]
	DCD	0xe28ee010 ;	add	lr, lr, #16
	DCD	0xe25cc001 ;	subs	ip, ip, #1
	DCD	0x1affffa0 ;	bne	18 <row_loop>
	DCD	0x0a00000a ;	beq	1c4 <start_column_loop>
	ENDP

|empty_row| PROC
	DCD	0xe59b1030 ;	ldr	r1, [fp, #48]	; 0x30
	DCD	0xe1a00100 ;	lsl	r0, r0, #2
	DCD	0xe0000001 ;	and	r0, r0, r1
	DCD	0xe0800800 ;	add	r0, r0, r0, lsl #16
	DCD	0xe58e0000 ;	str	r0, [lr]
	DCD	0xe58e0004 ;	str	r0, [lr, #4]
	DCD	0xe58e0008 ;	str	r0, [lr, #8]
	DCD	0xe58e000c ;	str	r0, [lr, #12]
	ENDP

|end_of_row_loop| PROC
	DCD	0xe28ee010 ;	add	lr, lr, #16
	DCD	0xe25cc001 ;	subs	ip, ip, #1
	DCD	0x1affff94 ;	bne	18 <row_loop>
	ENDP

|start_column_loop| PROC
	DCD	0xe59de000 ;	ldr	lr, [sp]
	DCD	0xe3a0c008 ;	mov	ip, #8
	ENDP

|column_loop| PROC
	DCD	0xe1de00f0 ;	ldrsh	r0, [lr]
	DCD	0xe1de22f0 ;	ldrsh	r2, [lr, #32]
	DCD	0xe1de44f0 ;	ldrsh	r4, [lr, #64]	; 0x40
	DCD	0xe1de66f0 ;	ldrsh	r6, [lr, #96]	; 0x60
	DCD	0xe59b3004 ;	ldr	r3, [fp, #4]
	DCD	0xe0821006 ;	add	r1, r2, r6
	DCD	0xe59b5024 ;	ldr	r5, [fp, #36]	; 0x24
	DCD	0xe0010193 ;	mul	r1, r3, r1
	DCD	0xe59b3008 ;	ldr	r3, [fp, #8]
	DCD	0xe0261695 ;	mla	r6, r5, r6, r1
	DCD	0xe0805004 ;	add	r5, r0, r4
	DCD	0xe0221293 ;	mla	r2, r3, r2, r1
	DCD	0xe0403004 ;	sub	r3, r0, r4
	DCD	0xe0820685 ;	add	r0, r2, r5, lsl #13
	DCD	0xe0622685 ;	rsb	r2, r2, r5, lsl #13
	DCD	0xe0864683 ;	add	r4, r6, r3, lsl #13
	DCD	0xe0666683 ;	rsb	r6, r6, r3, lsl #13
	DCD	0xe1de11f0 ;	ldrsh	r1, [lr, #16]
	DCD	0xe1de33f0 ;	ldrsh	r3, [lr, #48]	; 0x30
	DCD	0xe1de55f0 ;	ldrsh	r5, [lr, #80]	; 0x50
	DCD	0xe1de77f0 ;	ldrsh	r7, [lr, #112]	; 0x70
	DCD	0xe1819003 ;	orr	r9, r1, r3
	DCD	0xe185a007 ;	orr	sl, r5, r7
	DCD	0xe199a00a ;	orrs	sl, r9, sl
	DCD	0x0a000040 ;	beq	334 <empty_odd_column>
	DCD	0xe92d0055 ;	push	{r0, r2, r4, r6}
	DCD	0xe0830005 ;	add	r0, r3, r5
	DCD	0xe0812007 ;	add	r2, r1, r7
	DCD	0xe0834007 ;	add	r4, r3, r7
	DCD	0xe0816005 ;	add	r6, r1, r5
	DCD	0xe59b900c ;	ldr	r9, [fp, #12]
	DCD	0xe0848006 ;	add	r8, r4, r6
	DCD	0xe59ba020 ;	ldr	sl, [fp, #32]
	DCD	0xe0080899 ;	mul	r8, r9, r8
	DCD	0xe59b902c ;	ldr	r9, [fp, #44]	; 0x2c
	DCD	0xe002029a ;	mul	r2, sl, r2
	DCD	0xe59ba028 ;	ldr	sl, [fp, #40]	; 0x28
	DCD	0xe0000099 ;	mul	r0, r9, r0
	DCD	0xe59b901c ;	ldr	r9, [fp, #28]
	DCD	0xe024849a ;	mla	r4, sl, r4, r8
	DCD	0xe59ba000 ;	ldr	sl, [fp]
	DCD	0xe0268699 ;	mla	r6, r9, r6, r8
	DCD	0xe59b9014 ;	ldr	r9, [fp, #20]
	DCD	0xe027279a ;	mla	r7, sl, r7, r2
	DCD	0xe59ba018 ;	ldr	sl, [fp, #24]
	DCD	0xe0250599 ;	mla	r5, r9, r5, r0
	DCD	0xe59b9010 ;	ldr	r9, [fp, #16]
	DCD	0xe023039a ;	mla	r3, sl, r3, r0
	DCD	0xe0877004 ;	add	r7, r7, r4
	DCD	0xe0212199 ;	mla	r1, r9, r1, r2
	DCD	0xe0855006 ;	add	r5, r5, r6
	DCD	0xe0833004 ;	add	r3, r3, r4
	DCD	0xe0811006 ;	add	r1, r1, r6
	DCD	0xe8bd0055 ;	pop	{r0, r2, r4, r6}
	DCD	0xe0808001 ;	add	r8, r0, r1
	DCD	0xe2888802 ;	add	r8, r8, #131072	; 0x20000
	DCD	0xe1a08948 ;	asr	r8, r8, #18
	DCD	0xe1ce80b0 ;	strh	r8, [lr]
	DCD	0xe0408001 ;	sub	r8, r0, r1
	DCD	0xe2888802 ;	add	r8, r8, #131072	; 0x20000
	DCD	0xe1a08948 ;	asr	r8, r8, #18
	DCD	0xe1ce87b0 ;	strh	r8, [lr, #112]	; 0x70
	DCD	0xe0848003 ;	add	r8, r4, r3
	DCD	0xe2888802 ;	add	r8, r8, #131072	; 0x20000
	DCD	0xe1a08948 ;	asr	r8, r8, #18
	DCD	0xe1ce81b0 ;	strh	r8, [lr, #16]
	DCD	0xe0448003 ;	sub	r8, r4, r3
	DCD	0xe2888802 ;	add	r8, r8, #131072	; 0x20000
	DCD	0xe1a08948 ;	asr	r8, r8, #18
	DCD	0xe1ce86b0 ;	strh	r8, [lr, #96]	; 0x60
	DCD	0xe0868005 ;	add	r8, r6, r5
	DCD	0xe2888802 ;	add	r8, r8, #131072	; 0x20000
	DCD	0xe1a08948 ;	asr	r8, r8, #18
	DCD	0xe1ce82b0 ;	strh	r8, [lr, #32]
	DCD	0xe0468005 ;	sub	r8, r6, r5
	DCD	0xe2888802 ;	add	r8, r8, #131072	; 0x20000
	DCD	0xe1a08948 ;	asr	r8, r8, #18
	DCD	0xe1ce85b0 ;	strh	r8, [lr, #80]	; 0x50
	DCD	0xe0828007 ;	add	r8, r2, r7
	DCD	0xe2888802 ;	add	r8, r8, #131072	; 0x20000
	DCD	0xe1a08948 ;	asr	r8, r8, #18
	DCD	0xe1ce83b0 ;	strh	r8, [lr, #48]	; 0x30
	DCD	0xe0428007 ;	sub	r8, r2, r7
	DCD	0xe2888802 ;	add	r8, r8, #131072	; 0x20000
	DCD	0xe1a08948 ;	asr	r8, r8, #18
	DCD	0xe1ce84b0 ;	strh	r8, [lr, #64]	; 0x40
	DCD	0xe28ee002 ;	add	lr, lr, #2
	DCD	0xe25cc001 ;	subs	ip, ip, #1
	DCD	0x1affffa6 ;	bne	1cc <column_loop>
	DCD	0x0a000012 ;	beq	380 <the_end>
	ENDP

|empty_odd_column| PROC
	DCD	0xe2800802 ;	add	r0, r0, #131072	; 0x20000
	DCD	0xe1a00940 ;	asr	r0, r0, #18
	DCD	0xe1ce00b0 ;	strh	r0, [lr]
	DCD	0xe1ce07b0 ;	strh	r0, [lr, #112]	; 0x70
	DCD	0xe2844802 ;	add	r4, r4, #131072	; 0x20000
	DCD	0xe1a04944 ;	asr	r4, r4, #18
	DCD	0xe1ce41b0 ;	strh	r4, [lr, #16]
	DCD	0xe1ce46b0 ;	strh	r4, [lr, #96]	; 0x60
	DCD	0xe2866802 ;	add	r6, r6, #131072	; 0x20000
	DCD	0xe1a06946 ;	asr	r6, r6, #18
	DCD	0xe1ce62b0 ;	strh	r6, [lr, #32]
	DCD	0xe1ce65b0 ;	strh	r6, [lr, #80]	; 0x50
	DCD	0xe2822802 ;	add	r2, r2, #131072	; 0x20000
	DCD	0xe1a02942 ;	asr	r2, r2, #18
	DCD	0xe1ce23b0 ;	strh	r2, [lr, #48]	; 0x30
	DCD	0xe1ce24b0 ;	strh	r2, [lr, #64]	; 0x40
	DCD	0xe28ee002 ;	add	lr, lr, #2
	DCD	0xe25cc001 ;	subs	ip, ip, #1
	DCD	0x1affff92 ;	bne	1cc <column_loop>
	ENDP

|the_end| PROC
	DCD	0xe28dd004 ;	add	sp, sp, #4
	DCD	0xe8bd9ff0 ;	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip, pc}
	ENDP

|const_array| PROC
	DCD	0x0000098e ;	andeq	r0, r0, lr, lsl #19
	DCD	0x00001151 ;	andeq	r1, r0, r1, asr r1
	DCD	0x0000187e ;	andeq	r1, r0, lr, ror r8
	DCD	0x000025a1 ;	andeq	r2, r0, r1, lsr #11
	DCD	0x0000300b ;	andeq	r3, r0, fp
	DCD	0x000041b3 ;			; <UNDEFINED> instruction: 0x000041b3
	DCD	0x00006254 ;	andeq	r6, r0, r4, asr r2
	DCD	0xfffff384 ;			; <UNDEFINED> instruction: 0xfffff384
	DCD	0xffffe333 ;			; <UNDEFINED> instruction: 0xffffe333
	DCD	0xffffc4df ;			; <UNDEFINED> instruction: 0xffffc4df
	DCD	0xffffc13b ;			; <UNDEFINED> instruction: 0xffffc13b
	DCD	0xffffadfd ;			; <UNDEFINED> instruction: 0xffffadfd
	DCD	0x0000ffff ;	strdeq	pc, [r0], -pc	; <UNPREDICTABLE>
	ENDP

	END
