--[[
    Name: DebugLogClass
    Version: 1.0.1
    Author: zReko
    Creation date: 2022-03-13
    Update date: 2022-03-14
]]

DebugLogClass = class()

local function createCustomResWorkspace(width, height, name, workspace_object, scene)
    local name = "_fullrect_" .. tostring(width) .. "x" .. tostring(height) .. "_data" .. (name and "_" or "") ..
                     (name or "")
    managers.gui_data[name] = {}
    managers.gui_data[name].w = width
    managers.gui_data[name].h = height
    managers.gui_data[name].width = managers.gui_data[name].w
    managers.gui_data[name].height = managers.gui_data[name].h
    managers.gui_data[name].x = RenderSettings.resolution.x / 2 -
                                    math.min(RenderSettings.resolution.y, RenderSettings.resolution.x / (width / height)) *
                                    width / height / 2
    managers.gui_data[name].y = RenderSettings.resolution.y / 2 -
                                    math.min(RenderSettings.resolution.x, RenderSettings.resolution.y * width / height) /
                                    (width / height) / 2
    managers.gui_data[name].on_screen_width = math.min(RenderSettings.resolution.x,
        RenderSettings.resolution.y * width / height)
    managers.gui_data[name].convert_x = 0
    managers.gui_data[name].convert_y = 0
    local ws = (scene or managers.gui_data._scene_gui or Overlay:gui()):create_scaled_screen_workspace(10, 10, 10, 10,
        10)
    managers.gui_data._workspace_configuration[ws:key()] = {
        workspace_object = workspace_object
    }
    managers.gui_data:_set_layout(ws, managers.gui_data[name])
    return ws
end

local function CoroutineAnim(TOTAL_T, callback)
    local t = 0
    while t < TOTAL_T do
        local dt = coroutine.yield()
        t = t + dt
        callback(t / TOTAL_T, t)
    end
    callback(1, TOTAL_T)
end

function DebugLogClass:init()
    self.row_height = 25
    self.font_size = 25
    self.allow_new_entries = true
    self.font = "fonts/font_medium_mf"
    self.list_offset_x, self.list_offset_y = 5, 10
    self.current_entries = {}
    --[[self.main_panel = createCustomResWorkspace(1920, 1080, "debug_logger_ws"):panel({
        visible = true,
        alpha = 1,
        layer = 100000
    })]]
    self.main_panel = managers.gui_data:create_saferect_workspace():panel({
        visible = true,
        alpha = 1,
        layer = 100000
    })
end

function DebugLogClass:updatePos(x, y)
    self.main_panel:set_position(x, y)
end

function DebugLogClass:addNewLog(params)
    if not self.allow_new_entries then
        return
    end
    if #self.current_entries > 75 then
        self:movePanelToLeft(self.current_entries[#self.current_entries].panel, 0.5, true)
        table.remove(self.current_entries, #self.current_entries)
    end
    local message_panel = self.main_panel:panel({
        alpha = 1,
        x = self.list_offset_x,
        y = self.list_offset_y + self.row_height,
        h = self.row_height
    })
    local text = message_panel:text({
        text = tostring(params.message),
        font = self.font,
        font_size = self.font_size,
        color = params.color or Color(1, 1, 1),
        alpha = 1,
        x = 2,
        layer = 1001,
        w = 2000
    })
    local width = select(3, text:text_rect()) + 8
    message_panel:set_w(width)
    message_panel:rect({
        color = Color(0, 0, 0),
        alpha = 0.5,
        w = width - 3,
        layer = 1000
    })
    local data = {
        text_panel = text,
        panel = message_panel,
        timer = TimerManager:game():time() + params.time
    }
    table.insert(self.current_entries, 1, data)
    for i, v in pairs(self.current_entries) do
        self:adjustPanelHeight(v.panel, i, 0.5 / (i / 8))
    end
end

function DebugLogClass:adjustPanelHeight(panel, row, time)
    panel:stop()
    panel:animate(function(obj)
        CoroutineAnim(time or 0, function(p)
            obj:set_y(math.lerp(obj:y(), self.list_offset_y + (self.row_height * (row)), p))
        end)
    end)
end

function DebugLogClass:movePanelToLeft(panel, time, remove_on_end)
    panel:stop()
    panel:animate(function(obj)
        CoroutineAnim(time or 0, function(p)
            obj:set_x(math.lerp(obj:x(), obj:x() - 50, p))
            obj:set_alpha(math.lerp(1, 0, p))
            obj:set_layer(obj:layer() - 1)
        end)
        if remove_on_end then
            panel:parent():remove(panel)
        end
    end)
end

function DebugLogClass:update()
    for i = #self.current_entries, 1, -1 do
        local item = self.current_entries[i]
        if item.timer <= TimerManager:game():time() then
            local panel = item.panel
            table.remove(self.current_entries, i)
            self:movePanelToLeft(panel, 0.3, true)
            for ii = i, #self.current_entries, 1 do
                self:adjustPanelHeight(self.current_entries[ii].panel, ii - 1, 2)
            end
            break
        end
    end
end

function DebugLogClass:isVisible()
    return self.main_panel:visible()
end

function DebugLogClass:setVisState(state)
    self.main_panel:set_visible(state)
    self.allow_new_entries = state
end
