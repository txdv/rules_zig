# rules.bzl

#load(":zig_toolchain.bzl")

def _zig_rule(ctx):
    tc = ctx.toolchains[":toolchain_type"]
    #print("toolchain: %s %r" % (tc.compiler, tc.cflags))
    print("toolchain: %r" % (tc.cflags))

zig_rule = rule(
    _zig_rule,
    toolchains = [":toolchain_type"],
)
