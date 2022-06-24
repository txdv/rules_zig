# rules.bzl

#load(":zig_toolchain.bzl")

def _zig_rule(ctx):
    tc = ctx.toolchains[":toolchain_type"]
    
    output_file = ctx.actions.declare_file(ctx.label.name)

    inputs = ctx.files.srcs

    ctx.actions.run(
        mnemonic = "zig",
        executable = "/Users/andriusb/Projects/zig/bin/zig_build",
        arguments = ["build-exe", "-femit-bin=" + output_file.path, "test.zig"],
        inputs = inputs,
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
