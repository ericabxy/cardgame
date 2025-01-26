local sources_t = {
  love.audio.newSource('share/sfx_movement_dooropen1.wav','static'),
  love.audio.newSource('share/sfx_sounds_damage1.wav', 'static'),
  love.audio.newSource('share/sfx_sounds_fanfare3.wav', 'static'),
}
sources_t[1]:setVolume(0.40)
sources_t[2]:setVolume(0.40)
sources_t[3]:setVolume(0.40)
return sources_t
