# rules.bzl

#load(":zig_toolchain.bzl")

def _zig_rule(ctx):
    tc = ctx.toolchains[":toolchain_type"]
    
    output_file = ctx.actions.declare_file(ctx.label.name)

    srcs = ctx.files.srcs
    paths = [src.path for src in srcs]

    ctx.actions.run(
        mnemonic = "zig",
        executable = tc.path,
        arguments = ["build-exe", "-femit-bin=" + output_file.path] + paths,
        inputs = srcs,
        outputs = [output_file],
    )

    return [DefaultInfo(files = depset([output_file]), executable = output_file)]

zig_rule = rule(
    _zig_rule,
    toolchains = [":toolchain_type"],
    executable=True,
    attrs = {
        "srcs": attr.label_list(allow_files = [".zig"]),
    }
)

zig_build_exe = zig_rule
