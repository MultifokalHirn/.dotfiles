
--- Keycodes: https://www.hammerspoon.org/docs/hs.keycodes.html#map

hs.loadSpoon("MouseFollowsFocus") --- does not appear to work?


hs.loadSpoon("ShiftIt")
spoon.ShiftIt:bindHotkeys({
  left = { { 'ctrl', 'alt' }, 'left' },
  right = { { 'ctrl', 'alt' }, 'right' },
  up = { { 'ctrl', 'alt' }, 'up' },
  down = { { 'ctrl', 'alt' }, 'down' },
  upleft = { { 'ctrl', 'alt' }, '1' },
  upright = { { 'ctrl', 'alt' }, '2' },
  botleft = { { 'ctrl', 'alt' }, '3' },
  botright = { { 'ctrl', 'alt' }, '4' },
  maximum = { { 'ctrl', 'alt' }, 'return' },
  toggleFullScreen = { { 'ctrl', 'alt' }, 'f' },
  toggleZoom = { { 'ctrl', 'alt' }, 'z' },
  center = { { 'ctrl', 'alt' }, 'm' },
  nextScreen = { { 'ctrl', 'alt' }, 'n' },
  previousScreen = { { 'ctrl', 'alt' }, 'p' },
  resizeOut = { { 'ctrl', 'alt' }, '-' },
  resizeIn = { { 'ctrl', 'alt' }, '.' }
})

hs.loadSpoon("MouseCircle")
spoon.MouseCircle.color = hs.drawing.color.osx_red
spoon.MouseCircle:bindHotkeys({
  show = { { "ctrl", "alt" }, "o" }
})
