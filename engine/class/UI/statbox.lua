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

UI.EntityStatBox = function(entity, x, y)
    local _eb = UI.StatBox(x,y)
    _eb.propsToDraw = {'x','y','z','hsp','vsp','zsp', 'coyoteTime'}

    local _step_inherited = _eb.step

    _eb.step = function(dt)
        _eb.drawList = {'[' .. entity.name .. ']'}
        for i,v in ipairs(_eb.propsToDraw) do
            if entity[v] then
                _str = v .. ": " .. floorToPrecision(entity[v], 4) 
                table.insert(_eb.drawList, _str)
            end
        end
        _step_inherited(dt)
    end

    return _eb
end