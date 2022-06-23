# zig_toolchain.bzl

#toolchain_type(name = "toolchain_type")

DEMO_TOOLCHAIN = "@rules_zig//:zig_toolchain_type"

def _zig_toolchain_info(ctx):
    return [
        platform_common.ToolchainInfo(
            #compiler = ctx.attr.compiler,
            cflags = ctx.attr.cflags,
        ),
    ]

zig_toolchain_info = rule(
    _zig_toolchain_info,
    attrs = {
        #"_compiler": attr.label(
        #    executable = True,
        #    default = "//:zig_compiler",
        #    cfg = "host",
        #),
        "cflags": attr.string_list(),
    },
)
