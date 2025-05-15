UI.StatBoxes = {
    elements = {}
}

UI.StatBox = function(x,y) 
    local _sb = UI.Element(x,y)
    _sb.drawList = {'testKey: testValue', 'testKey: testValue', 'testKey: testValue' }
    _sb.lineHeight = 8

    _sb.step = function(dt)
        local _font = love.graphics.getFont()
        local _tbLength = table.maxn(_sb.drawList)
        local _maxW = 0
        
        for i,v in ipairs(_sb.drawList) do 
            _maxW = math.max(_maxW, _font:getWidth(v))
        end
        
        _sb.width  = (_sb.padding * 2) + _maxW
        _sb.height = (_sb.padding * 2) + (_sb.lineHeight * _tbLength)
    end

    _sb.draw = function()
        local _yy = 0
        _sb.drawBox()
        for i,v in ipairs(_sb.drawList) do 
            love.graphics.print(v, _sb.x + _sb.padding, _sb.y + _sb.padding + _yy)
            _yy = _yy + _sb.lineHeight
        end
    end

    return _sb
end

UI.EngineStatBox = function(x, y)
    local _eb = UI.StatBox(x, y)

    local _step_inherited = _eb.step

    _eb.step = function(dt)
        _eb.drawList = {'[---engine info---]'}
        table.insert(_eb.drawList, 'fps: ' .. love.timer.getFPS())
        table.insert(_eb.drawList, 'delta: ' .. floorToPrecision(love.timer.getDelta(), 4))
        table.insert(_eb.drawList, 'stepTime: ' .. floorToPrecision(love.timer.step(), 4))
        _step_inherited(dt)
    end
    
    return _eb
end

UI.EntityStatBox = function(entity, x, y)
    local _eb = UI.StatBox(x,y)
    _eb.propsToDraw = {'x','y','z','hsp','vsp','zsp', 'coyoteTime', 'onGround'}

    local _step_inherited = _eb.step

    _eb.step = function(dt)
        _eb.drawList = {'[' .. entity.name .. ']'}
        for i,v in ipairs(_eb.propsToDraw) do
            if entity[v] then
                local _drawValue = entity[v]
                if type(entity[v]) == "number" then
                    _drawValue = floorToPrecision(entity[v], 4)
                elseif type(entity[v]) == "boolean" then
                    _drawValue = entity[v] and 'true' or 'false'
                end
                _str = v .. ": " .. _drawValue
                table.insert(_eb.drawList, _str)
            end
        end
        _step_inherited(dt)
    end

    return _eb
end