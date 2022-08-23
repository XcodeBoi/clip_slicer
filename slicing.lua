local utils = require "mp.utils"
local options = require "mp.options"

local cut_pos = nil

local options = {
    bitrate = "1280k",
    outputDir = [[~\Videos\Clips]]
}

local command = [[ffmpeg -ss $shift -i "$in" -t $duration -maxrate $bitrate -bufsize $bitrate "$out.mp4"]]

function timestamp(duration)
    local hours = duration / 3600
    local minutes = duration % 3600 / 60
    local seconds = duration % 60
    return string.format("%02d-%02d-%02.03f", hours, minutes, seconds)
end

function osd(str)
    return mp.osd_message(str, 3)
end

function get_homedir()
  -- It would be better to do platform detection instead of fallback but
  -- it's not that easy in Lua.
  return os.getenv("HOME") or os.getenv("USERPROFILE") or ""
end

function escape(str)
    -- FIXME(Kagami): This escaping is NOT enough, see e.g.
    -- https://stackoverflow.com/a/31413730
    -- Consider using `utils.subprocess` instead.
    return str:gsub("\\", "\\\\"):gsub('"', '\\"')
end

function get_outname(shift, endpos)
    local name = mp.get_property("filename")
    print(name)
    local isClip, endF = string.find(name, [[.+% ....%...%...% %-% ..%...%...%...%..+]])
    print(isClip, endF)
    if isClip then name = name:sub(1, -33) end
    local time = os.time()
    return time .. " (" .. name .. ")"
end

function cut(shift, endpos)
    local cmd = command
    -- get the file name
    local inpath = escape(utils.join_path(
        utils.getcwd(),
        mp.get_property("stream-path")))
    -- create the output path
    local outpath = escape(utils.join_path(
        options.outputDir:gsub("~", get_homedir()),
        get_outname(shift, endpos)))

    -- 7.5MB/s divided by number of seconds for discord target
    local targetBitRate = 60 / (endpos - shift)
    local bRate = string.format("%sM", targetBitRate)

    cmd = cmd:gsub("$shift", shift)
    cmd = cmd:gsub("$duration", endpos - shift)
    cmd = cmd:gsub("$out", outpath)
    cmd = cmd:gsub("$in", inpath, 1)
    cmd = cmd:gsub("$bitrate", bRate)

    os.execute(cmd)
end

function toggle_mark()
    local pos = mp.get_property_number("time-pos")
    if cut_pos then
        local shift, endpos = cut_pos, pos
        if shift > endpos then
            shift, endpos = endpos, shift
        end
        if shift == endpos then
            osd("Clip is empty")
        else
            cut_pos = nil
            osd("Creating clip")
            cut(shift, endpos)
        end
    else
        cut_pos = pos
        osd(string.format("Marked %s as start position", timestamp(pos)))
    end
end

mp.add_key_binding("c", "slicing_mark", toggle_mark)
