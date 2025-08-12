return {
    require("custom.options"), -- my options

    require("custom.mappings_micro"), -- my key mappings #1
    require("custom.mappings_others"), -- my key mappings #2

    require("custom.commands"), -- my custom commands

    require("custom.autocmds"), -- auto commands

    -- my plugins
    require("custom.goto_line"),
    require("custom.surround"),
    require("custom.terminal"),
    require("custom.floating_terminal"),
}
