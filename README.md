The image.tga must be 320x200 256-color indexed and top-left origin.

Original image: 
<img src="images/original.png" /><br>

Rescaled images: 320x200

With custom palette:
<img src="images/image.png" /><br>

With VGA default palette:
<img src="images/image-vga.png" /><br>

Compile on Linux/Windows:

  nasm -fobj -o girl.obj girl.asm

Link with TLINK (DosBOX):

  tlink /x girl.obj, girl.exe
