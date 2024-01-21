include 'include/ez80.inc'
include 'include/tiformat.inc'
include 'include/ti84pceg.inc'
format ti executable 'MAIN'



; Start of program code
	call	ti.RunIndicOff		; turn off run indicator
	di				; disable interrupts

create1555palette:
	ld	hl,ti.mpLcdPalette	; mmio address of lcd palette
	ld	b,0
.loop:
	ld	d,b
	ld	a,b
	and	a,192
	srl	d
	rra
	ld	e,a
	ld	a,31
	and	a,b
	or	a,e
	ld	(hl),a
	inc	hl
	ld	(hl),d
	inc	hl
	inc	b
	jr	nz,.loop

	call	ti.boot.ClearVRAM	; set all of vram to index 255 (white)
	ld	a,ti.lcdBpp8
	ld	(ti.mpLcdCtrl),a	; enable 8bpp mode


	; ld	a,$aa			; place your favorite color index here
	; ld	hl,ti.vRam
	; ld	bc,ti.lcdWidth * ti.lcdHeight / 2
	; call	ti.MemSet ; print

	; ld	a,$cc			; place your favorite color index here
	; ld	hl,ti.vRam + ti.lcdWidth * ti.lcdHeight / 2
	; ld	bc,ti.lcdWidth * ti.lcdHeight / 2
	; call	ti.MemSet

; 	ld	bc,ti.lcdWidth / 2
; colorHalfSide:
; 	ld	de,ti.lcdWidth
; 	ld	hl,0
; 	ld	c,0
; 	add	hl,bc
; 	call	multiplyNumbers ; hl = (ti.lcdWidth * b)
; 	ld de, ti.vRam
; 	add	hl, de      ; hl += ti.vRam

	; Load the first operand into register A

	; ld c,0
	; ld hl, bc     ; Initialize HL to 0, this will store the result

	; Loop to perform multiplication

	; The result is now in HL



	; ld	a,$c2			; place your favorite color index here
	; ld	hl,ti.vRam + ti.lcdWidth * ti.lcdHeight / 2
	; ld	bc,ti.lcdWidth * ti.lcdHeight / 2
	; call	ti.MemSet

	ld	a,$44			; place your favorite color index here
	ld	hl,ti.vRam + ti.lcdWidth
	; ld	hl,ti.vRam + (ti.lcdWidth * b) ;; I want
	ld	bc,ti.lcdWidth / 2
	call	ti.MemSet

	; dec	bc
	; jr	z,colorHalfSide


wait4key:
	call	ti.GetCSC
	cp	a,ti.skEnter
	jr	nz,wait4key

	call	ti.ClrScrn
	ld	a,ti.lcdBpp16
	ld	(ti.mpLcdCtrl),a
	call	ti.DrawStatusBar
	ei				; reset screen back to normal
	ret				; return to os

; function multiply (de, hl)
; multiplyNumbers:
; 	ld	b,0
; multiplyLoop:
; 	add	hl, de  ; Add DE to HL (DE is treated as a 16-bit value)
; 	dec	b       ; Decrement B
; 	jr	nz, multiplyLoop ; Jump back to the loop if B is not zero
; 	ret
