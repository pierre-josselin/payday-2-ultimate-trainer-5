UT.Utils = {}

function UT.Utils:getType(value)
    return type(value)
end

function UT.Utils:toString(value)
    return tostring(value)
end

function UT.Utils:isString(value)
    return UT.Utils:getType(value) == "string"
end

function UT.Utils:isEmptyString(value)
    return UT.Utils:isString(value) and value == ""
end

function UT.Utils:toNumber(value)
    return tonumber(value)
end

function UT.Utils:isNumber(value)
    return UT.Utils:getType(value) == "number"
end

function UT.Utils:isInteger(value)
    return UT.Utils:isNumber(value) and UT.Utils:toString(value % 1) == "0"
end

function UT.Utils:jsonEncode(value)
    return json.encode(value)
end

function UT.Utils:jsonDecode(value)
    return json.decode(value)
end

function UT.Utils:readFile(filePath)
    if not io.file_is_readable(filePath) then
        return false
    end
    local file = io.open(filePath, "r")
    if not file then
        return false
    end
    local content = file:read("*all")
    file:close()
    return content
end

function UT.Utils:writeFile(filePath, content, mode)
    file = io.open(filePath, mode or "w+")
    if not file then
        return false
    end
    file:write(content)
    file:close()
    return true
end

function UT.Utils:getSaveTable(fileName)
    local content = UT.Utils:readFile(SavePath .. fileName)
    if not content then
        return {}
    end
    return UT.Utils:jsonDecode(content)
end

function UT.Utils:setSaveTable(fileName, table)
    local content = UT.Utils:jsonEncode(table)
    return UT.Utils:writeFile(SavePath .. fileName, content)
end

function UT.Utils:getToggleValue(value)
    return value == "on"
end

function UT.Utils:inTable(element, table)
    for key, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

function UT.Utils:isTableEmpty(table)
    return next(table) == nil
end

function UT.Utils:countTable(table)
    local count = 0
    for key, value in pairs(table) do
        count = count + 1
    end
    return count
end

function UT.Utils:getPathBaseName(path)
    return path:match("[^/]+$")
end

UTLoadedClassUtils = true
