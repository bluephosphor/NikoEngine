function Initialize()
  love.graphics.setDefaultFilter("nearest", "nearest", 0);
  love.window.setMode(640,480,{
    highdpi = true,
    --usedpiscale = false
  })
  InitFonts()
end

function InitFonts()
  Font = {}
  Font.default = love.graphics.newFont("lib/font/ChevyRay - Softsquare Wide.ttf", 9)
end