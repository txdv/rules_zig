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

def _zig_test(ctx):
    tc = ctx.toolchains[":toolchain_type"]

    output_file = ctx.actions.declare_file(ctx.label.name)

    srcs = ctx.files.srcs
    paths = [src.path for src in srcs]

    runfiles_root = output_file.path + ".runfiles"
    workspace_name = ctx.workspace_name

    content = "{path} test {srcs}".format(
        path = tc.path,
        srcs = " ".join(paths),
    )

    ctx.actions.write(
        output = output_file,
        content = content,
        is_executable = True,
    )

    runfiles = ctx.runfiles(files = ctx.files.srcs)
    return [DefaultInfo(
        executable = output_file,
        runfiles = runfiles,
    )]

zig_test = rule(
    _zig_test,
    toolchains = [":toolchain_type"],
    test = True,
    attrs = {
        "srcs": attr.label_list(allow_files = [".zig"]),
    }
)
