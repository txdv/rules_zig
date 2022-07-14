# rules.bzl

#load(":zig_toolchain.bzl")

def _zig_rule(ctx):
    tc = ctx.toolchains[":toolchain_type"]

    output_file = ctx.actions.declare_file(ctx.label.name)

    srcs = ctx.files.srcs
    paths = [src.path for src in srcs]

    ctx.actions.run(
        mnemonic = "zig",
        executable = ctx.attr.wrapper.files_to_run.executable,
        arguments = ["build-exe", "-femit-bin=" + output_file.path] + paths,
        inputs = depset(srcs + [ctx.attr.compiler.files_to_run.executable]),
        outputs = [output_file],
    )

    return [DefaultInfo(
        files = depset([output_file]),
        executable = output_file,
    )]

zig_rule = rule(
    _zig_rule,
    toolchains = [":toolchain_type"],
    executable=True,
    attrs = {
        "srcs": attr.label_list(allow_files = [".zig"]),
        "compiler": attr.label(
            default = Label("@zig_sdk//:compiler"),
            allow_single_file = True,
            executable = True,
            cfg = "exec",
        ),
        "compiler_data": attr.label(
            default = Label("@zig_sdk//:compiler_data"),
            providers = ["files"],
        ),
        "wrapper": attr.label(
            default = Label("//:wrapper"),
            allow_single_file = True,
            executable = True,
            cfg = "exec",
        )
    }
)

zig_build_exe = zig_rule

def _zig_test(ctx):
    tc = ctx.toolchains[":toolchain_type"]

    test_runner = ctx.actions.declare_file(ctx.label.name + "_runner")
    test_binary = ctx.actions.declare_file(ctx.label.name + "_binary")

    srcs = ctx.files.srcs
    srcs_path = [src.path for src in srcs]

    ctx.actions.run(
        mnemonic = "zig",
        executable = ctx.attr.wrapper.files_to_run.executable,
        arguments = ["test", "--test-no-exec", "-femit-bin=" + test_binary.path] + srcs_path,
        inputs = depset(srcs + [ctx.attr.compiler.files_to_run.executable]),
        outputs = [test_binary],
    )

    content = "{path} {zig}".format(
        path = test_binary.short_path,
        zig = ctx.attr.compiler.files_to_run.executable.path,
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
        "compiler": attr.label(
            default = Label("@zig_sdk//:compiler"),
            allow_single_file = True,
            executable = True,
            cfg = "exec",
        ),
        "compiler_data": attr.label(
            default = Label("@zig_sdk//:compiler_data"),
            providers = ["files"],
        ),
        "wrapper": attr.label(
            default = Label("//:wrapper"),
            allow_single_file = True,
            executable = True,
            cfg = "exec",
        )
    },
)

def zig_pkg(name, srcs):
    zig_build_exe(name = name, srcs = srcs)
    zig_test(name = name + "_test", srcs = srcs)
