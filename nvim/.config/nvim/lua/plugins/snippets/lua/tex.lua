-- ~/.config/nvim/lua/plugins/snippets/lua/tex.lua

local has_treesitter, ts = pcall(require, "vim.treesitter")
local _, query = pcall(require, "vim.treesitter.query")

local MATH_NODES = {
    displayed_equation = true,
    inline_formula = true,
    math_environment = true,
}

local COMMENT = {
    ["comment"] = true,
    ["line_comment"] = true,
    ["block_comment"] = true,
    ["comment_environment"] = true,
}

local function get_node_at_cursor()
    local buf = vim.api.nvim_get_current_buf()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    row = row - 1
    col = col - 1

    local ok, parser = pcall(ts.get_parser, buf, "latex")
    if not ok or not parser then return end

    local root_tree = parser:parse()[1]
    local root = root_tree and root_tree:root()

    if not root then
        return
    end

    return root:named_descendant_for_range(row, col, row, col)
end

function in_comment()
    if has_treesitter then
        local node = get_node_at_cursor()
        while node do
            if COMMENT[node:type()] then
                return true
            end
            node = node:parent()
        end
        return false
    end
end

function in_mathzone()
    if has_treesitter then
        local node = get_node_at_cursor()
        while node do
            if node:type() == "text_mode" then
                return false
            elseif MATH_NODES[node:type()] then
                return true
            end
            node = node:parent()
        end
        return false
    end
end

return
{

},
-- Automatic
{

}
