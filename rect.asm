include 'include/ez80.inc'
include 'include/tiformat.inc'
include 'include/ti84pceg.inc'
format ti executable 'DEMO'

RECT_WIDTH := 10
RECT_HEIGHT := 10
RECT_COLOR_I := 135

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

main_loop:
	di
	ld	hl,ti.DI_Mode		; register for keypad mode
	ld	(hl),2			; set single scan mode

	xor	a,a
scan_wait:
	cp	a,(hl)			; wait for keypad idle mode
	jr	nz,scan_wait

; Read data registers here as needed

	ld	a,(ti.kbdG1)
	bit	ti.kbit2nd,a
	call     nz,center_rectangle    ; center the rectangle if [2nd] is pressed

	ld	a,(ti.kbdG6)
	bit	ti.kbitClear,a
	jp	nz,exit_prgm		; exit the program if [CLEAR] is pressed

	ld	a,(ti.kbdG7)
	push	af
 	bit	ti.kbitUp,a
 	call	nz,request_up   	  ; is [UP] pressed?

	pop	af
	push	af
	bit	ti.kbitRight,a
	call	nz,request_right	; is [RIGHT] pressed?

	pop	af
	push	af
	bit	ti.kbitLeft,a
	call	nz,request_left		; is [LEFT] pressed?

	pop	af
	push	af
	bit	ti.kbitDown,a
	call	nz,request_down		; is [DOWN] pressed?

 	pop	af
	or	a,a
	call	nz,redraw_screen	; if any key is pressed, update the screen

	jp	main_loop

request_up:
	ld	a,0
yPos := $ - 1
	dec	a
	ret	z			; return if @ 1
	ld	(yPos),a
	ret

request_right:
	ld	hl,0
xPos := $ - 3
	inc	hl
	ld	de,ti.lcdWidth
	or	a,a
	sbc	hl,de
	add	hl,de
	ret	z			; return if @ 319
	ld	(xPos),hl
	ret

request_left:
	ld	hl,(xPos)
	dec	hl
	add	hl,de
; The purpose of these instructions is to perform a subtraction and check if the result is zero.
; The or a, a is used to set the zero flag, and then sbc hl, de subtracts de from hl with the carry flag acting as a borrow.
; The subsequent ret z instruction checks the zero flag and returns from the subroutine if the result of the subtraction was zero
	or	a,a
	sbc	hl,de
	ret	z			; return if @ 1
	ld	(xPos),hl
	ret

request_down:
	ld	a,(yPos)
	inc	a
	cp	a,ti.lcdHeight
	ret	z			; return if @ 239
	ld	(yPos),a
	ret

center_rectangle:
	ld  hl,ti.lcdWidth / 2
    ld  (xPos),hl
	ld  hl,ti.lcdHeight / 2
    ld  (yPos),hl
	ret

redraw_screen:
	ld	hl,ti.vRam
	ld	bc,ti.lcdWidth * ti.lcdHeight
	ld	a,$cc
	call	ti.MemSet		; set the LCD background

	ld	a,RECT_COLOR_I		; change the color of the rectangle
	ld	(draw_rectangle.color),a

	ld	de,(xPos)
	ld	hl,(yPos)
	ld	a,RECT_WIDTH
	ld	bc,RECT_HEIGHT
;	jp	draw_rectangle

;----------------------------------------
; draw_rectangle
; inputs:
;         de = x
;          l = y
;         bc = width
;          a = height
;  rcolor = color of rectangle
;  this routine can be greatly optimized!
;----------------------------------------
draw_rectangle:
	ld	h,ti.lcdWidth / 2	; h = 160
	mlt	hl			; 160 * y
	add	hl,hl			; hl * 2
	add	hl,de			; add x coordinate
	ld	de,ti.vRam
	add	hl,de			; offset vRam
	dec	bc			; for ldir
.loop:
	ld	(hl),0
.color := $ - 1
	push	hl
	pop	de
	inc	de
	push	bc
	ldir				; draw line
	pop	bc
	ld	de,ti.lcdWidth
	add	hl,de			; move down
	sbc	hl,bc
	dec	a
	jr	nz,.loop
	ret

exit_prgm:
	call	ti.ClrScrn
	ld	a,ti.lcdBpp16
	ld	(ti.mpLcdCtrl),a
	call	ti.DrawStatusBar
	ei				; reset screen back to normal
	ret				; return to os