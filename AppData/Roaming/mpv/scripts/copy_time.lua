require 'mp'
local assdraw = require('mp.assdraw')

-- Drawing
local window_size = {}
window_size.w, window_size.h = mp.get_osd_size()
local ass = assdraw.ass_new()

local start_time = "00:00:00"
local end_time = "00:00:00"

function writeToFile(text)
    local out_abs_path = string.format("\"%s\\%s.timing\"", 
                                       mp.get_property('working-directory'), 
                                       mp.get_property('filename'))
    mp.commandv("run", "pwsh", "-Command", 
        string.format("\"%s\"", text), "|", "Out-File", "-Encoding", "utf8", "-LiteralPath", out_abs_path, "-Append")
end

function copyTime()
    local time_pos = mp.get_property_number("time-pos")
    local time_in_seconds = time_pos
    local time_seg = time_pos % 60
    time_pos = time_pos - time_seg
    local time_hours = math.floor(time_pos / 3600)
    time_pos = time_pos - (time_hours * 3600)
    local time_minutes = time_pos/60
    time_seg,time_ms=string.format("%.03f", time_seg):match"([^.]*).(.*)"
    time = string.format("%02d:%02d:%02d.%s", time_hours, time_minutes, time_seg, time_ms)
    return time
end

function draw_timestamp(square_color, p_x, p_y, text)
    -- Draws the timestamps with the corresponding markers to the screen. The variable square_color
    -- is a HBBGGRR color value.

    -- Drawing the square
    ass:new_event()
    ass:pos(p_x, p_y)
    ass:append("{\\bord0}")
    ass:append("{\\shad0}")
    ass:append(string.format("{\\c&%s&}", square_color))
    ass:draw_start()
    ass:rect_cw(0, 0, 10, 10)
    ass:draw_stop()

    -- Drawing the background of the text
    ass:new_event()
    ass:pos(p_x + 10, p_y + 0)
    ass:append("{\\bord0}")
    ass:append("{\\shad0}")
    ass:append("{\\c&H000000&}")
    ass:draw_start()
    ass:rect_cw(0, 0, 55, 10)
    ass:draw_stop()
   
    -- Drawing the timestamp
    ass:new_event()
    ass:pos(p_x + 12, p_y + 0)
    ass:append("{\\fs10}")
    ass:append("{\\bord0.5}")
    ass:append(text)
    mp.set_osd_ass(window_size.w, window_size.h, ass.text)
end

function getStart()
	start_time = copyTime()

    -- Drawing green rectangle
    draw_timestamp("H21e021", 0, 0, start_time)
end

function getEnd()
	end_time = copyTime()
	-- mp.osd_message(string.format("End time: %s", end_time))

    draw_timestamp("H2929f4", 0, 10, end_time)
end

function saveTimes()
	local msg = start_time .. "|" .. end_time
	-- mp.osd_message(string.format("End time: %s", end_time))
	writeToFile(msg)
	-- mp.osd_message("Times saved")

    -- Remove rectangles from screen
    ass = assdraw.ass_new()
    mp.set_osd_ass(window_size.w,window_size.h, ass.text)
end 

mp.add_key_binding("ő", getStart)
mp.add_key_binding("ú", getEnd)
mp.add_key_binding("ű", saveTimes)
