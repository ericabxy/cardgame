local filename = 'share/tinycards_imagefont.png' 
local extraspacing = 2
return love.graphics.newImageFont(
  filename,
  '@'..           --card back 1
  'ABCDEFGHIJ'..  --Ace through Ten of Spades 
  'KLM'..         --Jack Queen and King of Spades
  'P'..           --card back 2
  'QRSTUVWXYZ'..  --Ace through Ten of Hearts
  '[\\]'..        --Jack Queen and King of Hearts
  '_'..           --red Joker
  'abcdefghij'..  --Ace through Ten of Diamonds
  'klm'..         --Jack Queen and King of Diamonds
  'o'..           --black Joker
  'qrstuvwxyz'..  --Ace through Ten of Clubs
  '{|}',          --Jack Queen and King of Clubs
  extraspacing
)
