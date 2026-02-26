  bits  16

  ; Not needed, but avoids warning 'no stack' from linker.
  section _STACK stack align=2

  dw  256
_stktop:

  section _TEXT class=CODE align=2

..start:
  ; I don't know (and didn't test it) if DOS set SS:SP for the
  ; segment defined above ('stack' class), so I do it myself.
  mov   ax,_STACK
  mov   ss,ax
  mov   sp,_stktop wrt _STACK

  ; Setup mode 0x13 (320x200x256).
  mov   ax,0x13
  int   0x10

  call  setup_palette
  call  copy_pic_to_framebuffer

  ; Wait key.
  xor   ah,ah
  int   0x16

  ; Get back to mode 3.
  mov   ax,3
  int   0x10

  ; Exit program with errorlevel 0.
  mov   ax,0x4c00
  int   0x21

copy_pic_to_framebuffer:
  push  ds

  mov   ax,0xa000
  mov   es,ax
  xor   di,di
  mov   ax,PICSEG
  mov   ds,ax
  mov   si,picture wrt PICSEG
  mov   cx,(320*200)/2
  rep   movsw

  pop   ds
  ret

; Rewrites VGA palette (using VGA hardware, not BIOS).
setup_palette:
  push  ds

  mov   ax,PALSEG
  mov   ds,ax
  mov   si,palette wrt PALSEG

  xor   cx,cx
  mov   dx,0x3c8

  align 2
.loop:
  mov   al,cl
  out   dx,al

  inc   dx

  ; Load BGRA entry and recalc color using 6 bits per component (truncate).
  ; Ignore alpha channel.
  lodsw       ; AL = B, AH = G
  shr   al,2
  shr   ah,2
  mov   bx,ax
  lodsw       ; AL = R
  shr   al,2

  ; Write RGB into VGA hardware, in that order.
  out   dx,al
  mov   al,bh
  out   dx,al
  mov   al,bl
  out   dx,al

  dec   dx

  inc   cl
  jnz   .loop

  pop   ds
  ret

  ; Image and its palette, taken from a TGA file
  ; rescaled to fit 320x200 without distorcions
  ; and indexed for 256 colors.
  ; Scan lines are "top to bottom".

  ; Notice I put these data in different segments so,
  ; A 320x200 image will fit in 64000 bytes and the palette
  ; is 1 KiB long (they could fit in a single data segment,
  ; but this is simplier and a way to show how to do it).

  ; GIMP saves each palette entry as BGRA.

  section PICSEG align=2

picture:
  incbin "image.tga",18+256*4,320*200

  section PALSEG align=2

palette:
  incbin "image.tga",18,256*4

