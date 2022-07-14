load(":zig_toolchain.bzl", "zig_toolchain_info")

toolchain_type(name = "toolchain_type")

zig_toolchain_info(
    name = "zig_toolchain_info/osx-aarm64",
    cflags = ["--target-os=osx", "--target-arch=aarm64"],
)

zig_toolchain_info(
    name = "zig_toolchain_info/x86_64-linux-gnu",
    cflags = ["--target-os=linux", "--target-arch=amd64"],
)# BUILD

toolchain(
    name = "zig_toolchain_linux_osx_aarm",
    #exec_compatible_with = [
    #        "@bazel_tools//platforms:linux",
    #        "@bazel_tools//platforms:x86_32",
    #],
    target_compatible_with = [
             #"@bazel_tools//os:osx",
             "@bazel_tools//platforms:osx",
    #        "@bazel_tools//platforms:linux",
    #        "@bazel_tools//platforms:x86_32",
    ],
    toolchain = ":zig_toolchain_info/osx-aarm64",
    toolchain_type = ":toolchain_type",
)

load(":rules.bzl", "zig_rule")
zig_rule(name = "test", srcs = ["test.zig"])
filegroup(
    name = "wrapper",
    srcs = ["zig.sh"],
    visibility = ["//visibility:public"],
)
