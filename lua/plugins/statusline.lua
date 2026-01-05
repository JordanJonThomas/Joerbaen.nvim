-- default lualine mode strings are too verbose, a letter or two can get the same point across
local mode_map = {
    ['n']      = 'N',
    ['no']     = '~',
    ['nov']    = '~',
    ['noV']    = '~',
    ['no\22'] = '~',
    ['niI']    = 'N',
    ['niR']    = 'N',
    ['niV']    = 'N',
    ['nt']     = 'N',
    ['ntT']    = 'N',
    ['v']      = 'V',
    ['vs']     = 'V',
    ['V']      = 'V',
    ['Vs']     = 'V',
    ['\22']   = 'VB',
    ['\22s']  = 'VB',
    ['s']      = 'S',
    ['S']      = 'SL',
    ['\19']   = 'SB',
    ['i']      = 'I',
    ['ic']     = 'I',
    ['ix']     = 'I',
    ['R']      = 'R',
    ['Rc']     = 'R',
    ['Rx']     = 'R',
    ['Rv']     = 'VR',
    ['Rvc']    = 'VR',
    ['Rvx']    = 'VR',
    ['c']      = 'COMMAND',
    ['cv']     = 'EX',
    ['ce']     = 'EX',
    ['r']      = 'R',
    ['rm']     = 'MORE',
    ['r?']     = 'CONFIRM',
    ['!']      = 'S',
    ['t']      = 'T',
}

-- map vim mode to string
local CustomMode = {
    function()
        local mode = vim.fn.mode()
        return mode_map[mode] or mode
    end,
}

-- TODO: right now this is basically still the default lualine, 
-- I'd like it to be a bit more pesonalized.
return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        sections = {
            lualine_a = { CustomMode },
            lualine_b = {'branch', 'diff', 'diagnostics'},
            lualine_c = {'filename'},
            lualine_x = {'encoding', 'fileformat', 'filetype'},
            lualine_y = {'progress'},
            lualine_z = {'location'}
        },
    }
}
