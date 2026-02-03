-- To use this plugin, a leetcode cookie must be provided. This cookie is obtained from the
-- Cookie header in the leetcode networking tab in browser. For more information, view this link
-- https://github.com/kawre/leetcode.nvim?tab=readme-ov-file#sign-in

-- 'nvim <launch_arg>' starts in leetcode mode :)
local launch_arg = 'leet';

return {
    'kawre/leetcode.nvim',
    build = ':TSUpdate html',
    lazy = launch_arg ~= vim.fn.argv(0, -1),
    dependencies = {
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
    },
    opts = {
        arg = launch_arg,
        lang = 'rust',
    },
}
