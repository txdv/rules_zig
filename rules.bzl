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

    test_runner = ctx.actions.declare_file(ctx.label.name + "_runner")
    test_binary = ctx.actions.declare_file(ctx.label.name + "_binary")

    srcs = ctx.files.srcs
    paths = [src.path for src in srcs]

    ctx.actions.run(
        mnemonic = "zig",
        executable = tc.path,
        arguments = ["test", "--test-no-exec", "-femit-bin=" + test_binary.path] + paths,
        inputs = srcs,
        outputs = [test_binary],
    )

    content = "{path} {zig}".format(
        path = test_binary.short_path,
        zig = tc.path,
    )

    ctx.actions.write(
        output = test_runner,
        content = content,
        is_executable = True,
    )

    runfiles = ctx.runfiles(files = [test_binary])

    return [DefaultInfo(
        executable = test_runner,
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

def zig_pkg(name, srcs):
    zig_build_exe(name = name, srcs = srcs)
    zig_test(name = name + "_test", srcs = srcs)
