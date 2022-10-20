	ORG $2200

C0	=	$F0
C1	=	$F1
C2	=	$F2
C3	=	$F3
DL	=	$F4
DH	=	$F5
	
SDLSTL	=	$0230
SDLSTH	=	$0231
CHBAS	=	$02F4
	
START:
	;; CLEAR KEYBOARD BUFFER
	LDA	#$FF
	STA	$02FC

	;; SAVE DISPLAY LIST

	LDA	SDLSTL
	STA	DL
	LDA	SDLSTH
	STA	DH

	;; SAVE COLOR REGISTERS

	LDX	#$04
SL1:	LDA	$02C4,X
	STA	C0,X
	DEX
	BPL	SL1

	;; SET COLOR REGISTERS

	LDA	#$0E
	STA	$02C4
	STA	$02C5
	STA	$02C6
	STA	$02C7

	;; SET DISPLAY LIST

	LDA	#.lo(DLST)
	STA	SDLSTL
	LDA	#.hi(DLST)
	STA	SDLSTH

	LDX	#$FF
	STX	$02FC

	;; Main loop

LOOP:	STX	$D016
	STX	$D40A	
	DEX
	LDA	$02FC
	BMI	LOOP

	;; RESTORE DISPLAY LIST

	LDA	DL
	STA	SDLSTL
	LDA	DH
	STA	SDLSTH

	;; RESTORE COLOR REGISTERS

	LDX	#$04
SL2:	LDA	C0,X
	STA	$02C4,X
	DEX
	BPL	SL2

	RTS

	ORG	$2900

DLST:
	.BYTE	$70,$70,$70
	.BYTE   $4E,$50,$31
	.BYTE   $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
	.BYTE   $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
	.BYTE   $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
	.BYTE   $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
	.BYTE   $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
	.BYTE   $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
	.BYTE   $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
	.BYTE   $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
	.BYTE   $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
	.BYTE   $0E,$0E,$0E
	.BYTE	$4E,$00,$40
	.BYTE   $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
	.BYTE   $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
	.BYTE   $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
	.BYTE   $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
	.BYTE   $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
	.BYTE   $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
	.BYTE   $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
	.BYTE   $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
	.BYTE   $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
	.BYTE	$0E,$0E,$0E,$0E,$0E,$0E,$0E
	.BYTE	$41,$00,$29

	ORG 	$3150

	INS	"logo.mic"

	RUN	START
