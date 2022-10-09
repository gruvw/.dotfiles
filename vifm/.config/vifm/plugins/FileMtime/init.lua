local M = {}

local function fileMtime(info)
    local text = ''
    if info.entry.type ~= 'dir' then
        text = os.date(vifm.opts.global.timefmt, info.entry.mtime)
    end
    return { text = text }
end

local added = vifm.addcolumntype {
    name = 'FileMtime',
    handler = fileMtime
}
if not added then
    vifm.sb.error("Failed to add FileMtime view column")
end

return M
