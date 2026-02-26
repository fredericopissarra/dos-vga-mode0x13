The image.tga must be 320x200 256-color indexed and top-left origin.

Original image: ![original](./images/original.png).

Rescaled images: 320x200
With custom palette: ![custom](./images/custom.png)
With VGA default palette: ![vgadefault](./images/vga.png)

Compile on Linux/Windows:

  nasm -fobj -o girl.obj girl.asm

Link with TLINK (DosBOX):

  tlink /x girl.obj, girl.exe
