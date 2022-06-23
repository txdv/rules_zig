# BUILD

toolchain_type(name = "toolchain_type") # sito truko

load(":demo_toolchain.bzl", "demo_toolchain_info")

demo_toolchain_info(
    name = "demo_toolchain_info/i686-linux-gnu",
    cflags = ["--target-os=osx", "--target-arch=aarm64"],
)

demo_toolchain_info(
    name = "demo_toolchain_info/x86_64-linux-gnu",
    cflags = ["--target-os=linux", "--target-arch=amd64"],
)# BUILD

toolchain(
    name = "demo_toolchain_linux_osx_aarm",
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
    toolchain = ":demo_toolchain_info/i686-linux-gnu",
    toolchain_type = ":toolchain_type",
)

load(":rules.bzl", "demo_rule")
demo_rule(name = "ASD")
