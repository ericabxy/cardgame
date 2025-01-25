--- simple color module
-- @module gamelib.color

local color = {
  -- from Color Graphics Array
  black = lutro and {0, 0, 0} or {0.00, 0.00, 0.00},
  blue = lutro and {0, 0, 170} or {0.00, 0.00, 0.66},
  green = lutro and {0, 170, 00} or {0.00, 0.66, 0.00},
  cyan = lutro and {0, 170, 170} or {0.00, 0.66, 0.66},
  red = lutro and {170, 0, 0} or {0.66, 0.00, 0.00},
  magenta = lutro and {170, 0, 170} or {0.66, 0.00, 0.66},
  brown = lutro and {170, 85, 0} or {0.66, 0.33, 0.00},
  light_gray = lutro and {170, 170, 170} or {0.66, 0.66, 0.66},
  dark_gray = lutro and {85, 85, 85} or {0.33, 0.33, 0.33},
  light_blue = lutro and {85, 85, 255} or {0.33, 0.33, 1.00},
  light_green = lutro and {85, 255, 85} or {0.33, 1.00, 0.33},
  light_cyan = lutro and {85, 255, 255} or {0.33, 1.00, 1.00},
  light_red = lutro and {255, 85, 85} or {1.00, 0.33, 0.33},
  light_magenta = lutro and {255, 85, 255} or {1.00, 0.33, 1.00},
  yellow = lutro and {255, 255, 85} or {1.00, 1.00, 0.33},
  white = lutro and {255, 255, 255} or {1.00, 1.00, 1.00},
}

return color
