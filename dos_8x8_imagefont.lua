local filename = 'share/dos_8x8_imagefont.png' 
local extraspacing = 0
return love.graphics.newImageFont(
  filename,
  ' !"#$%&\'()*+,-./'..  --stick 2
  '0123456789:;<=>?'..   --stick 3
  '@ABCDEFGHIJKLMNO'..   --stick 4
  'PQRSTUVWXYZ[\\]^_'..  --stick 5
  '`abcdefghijklmno'..   --stick 6
  'pqrstuvwxyz{|}~',     --stick 7 except DEL
  extraspacing
)
