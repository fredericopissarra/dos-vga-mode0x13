The image.tga must be 320x200 256-color indexed and top-left origin.

<p>
Original image:<br/> 
<img src="images/original.png" /><br/>
</p>

<b>Rescaled images: 320x200</b>

<p>
With custom palette:<br/>
<img src="images/image.png" /><br/>
</p>

<p>
With VGA default palette:<br/>
<img src="images/image-vga.png" /><br/>
</p>

Compile on Linux/Windows: nasm -fobj -o girl.obj girl.asm

Link with TLINK (DosBOX): tlink /x girl.obj, girl.exe
