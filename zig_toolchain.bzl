# demo_toolchain.bzl

#toolchain_type(name = "toolchain_type")

DEMO_TOOLCHAIN = "@rules_demo//:demo_toolchain_type"

def _demo_toolchain_info(ctx):
    return [
        platform_common.ToolchainInfo(
            #compiler = ctx.attr.compiler,
            cflags = ctx.attr.cflags,
        ),
    ]

demo_toolchain_info = rule(
    _demo_toolchain_info,
    attrs = {
        #"_compiler": attr.label(
        #    executable = True,
        #    default = "//:demo_compiler",
        #    cfg = "host",
        #),
        "cflags": attr.string_list(),
    },
)
