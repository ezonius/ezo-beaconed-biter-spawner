data:extend({
    {
        type = "bool-setting",
        name = "cbs-enable-speed",
        order = "aaa",
        setting_type = "startup",
        default_value = false,
    },
    {
        type = "bool-setting",
        name = "cbs-enable-productivity",
        order = "baa",
        setting_type = "startup",
        default_value = false,
    },
    {
        type = "bool-setting",
        name = "cbs-enable-quality",
        order = "caa",
        setting_type = "startup",
        default_value = false,
    },
    {
        type = "bool-setting",
        name = "cbs-enable-pollution",
        order = "daa",
        setting_type = "startup",
        default_value = false,
    },
    {
        type = "bool-setting",
        name = "cbs-enable-consumption",
        order = "eaa",
        setting_type = "startup",
        default_value = false,
    },
    {
        type = "int-setting",
        name = "cbs-module-slots",
        order = "faa",
        setting_type = "startup",
        default_value = 0,
        maximum_value = 1000,
        minimum_value = 0
    },
})
