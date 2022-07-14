# zig_toolchain.bzl

#toolchain_type(name = "toolchain_type")

DEMO_TOOLCHAIN = "@rules_zig//:zig_toolchain_type"

def _zig_toolchain_info(ctx):
    return [
        platform_common.ToolchainInfo(
            path = ctx.attr.path,
            cflags = ctx.attr.cflags,
        ),
    ]

zig_toolchain_info = rule(
    _zig_toolchain_info,
    attrs = {
        "path": attr.string(),
        "cflags": attr.string_list(),
    },
)
