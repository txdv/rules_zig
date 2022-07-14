# WORKSPACE

workspace(name = "rules_zig")

register_toolchains(
    "//:zig_toolchain_linux_osx_aarm",
    #"//:demo_toolchain_linux_x86_64",
)

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "zig_sdk",
    urls = ["https://ziglang.org/builds/zig-macos-aarch64-0.10.0-dev.2981+7090f0471.tar.xz"],
    sha256 = "d524edc8f043786505a231c922c9f2a0664f6c1ec85ab6a22e24574373cd39c5",
    build_file = "@//:compiler.BUILD",
    strip_prefix = "zig-macos-aarch64-0.10.0-dev.2981+7090f0471",
)
