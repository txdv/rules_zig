# rules.bzl

#load(":demo_toolchain.bzl")

def _demo_rule(ctx):
    tc = ctx.toolchains[":toolchain_type"]
    #print("toolchain: %s %r" % (tc.compiler, tc.cflags))
    print("toolchain: %r" % (tc.cflags))

demo_rule = rule(
    _demo_rule,
    toolchains = [":toolchain_type"],
)
