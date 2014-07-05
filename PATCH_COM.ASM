
; fasm example of writing 16-bit COM program

	org	100h			; code starts at offset 100h
	use16				; use 16-bit code

;Open filename
	mov 	ah, 0x3D
	mov	dx, filename
	mov	al, 2
	int	21h

	jc	error

;Store filehandler
	mov	bx, ax	

;Seek 528652
	mov	ah ,0x42	
	mov	al, 0
	mov	cx, 0x08
	mov	dx, 0x110B
	int	21h

	jc	error

;Write new_code
	mov	ah, 0x40       
	mov	dx, new_code
	mov	cx, 1
	int	21h

	jc	error

;seek 0x81244
	mov	ah, 0x42	
	mov	al, 0
	mov	cx, 0x08
	mov	dx, 0x1244
	int	21h

;Write new_str
	mov	ah, 0x40       
	mov	dx, new_str
	mov	cx, 2
	int	21h

;Close file
	mov	ah, 0x3E	
	int	21h

;Write success
	mov	ah, 9
	mov	dx, filename
	int	21h

	mov	dx, succes_patch
	int	21h

	jmp	exit

error:
	mov	ah, 9
	mov	dx, err_open
	int	21h
	mov	dx, filename
	int	21h
	
exit:
	int	20h

new_code db 'D$', 0
new_str db '68$', 0
err_open db 'could not open $', 0
filename db 'HANOI.EXE$', 0
succes_patch db ' patched$', 0
