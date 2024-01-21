include 'include/ez80.inc'
include 'include/tiformat.inc'
include 'include/ti84pceg.inc'
format ti executable 'MEMO'

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


	ld	a,$c2			; place your favorite color index here
	ld	hl,ti.vRam + ti.lcdWidth * ti.lcdHeight / 2
	ld	bc,ti.lcdWidth * ti.lcdHeight / 2
	call	ti.MemSet

	ld	a,$e0			; place your favorite color index here
	ld	hl,ti.vRam
	ld	bc,ti.lcdWidth * ti.lcdHeight / 2

	call	ti.MemSet ; print

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