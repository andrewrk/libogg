const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addLibrary(.{
        .name = "ogg",
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
            .link_libc = true,
        }),
        .linkage = .static,
    });
    lib.root_module.addIncludePath(b.path("include"));
    lib.root_module.addCSourceFiles(.{
        .files = &.{
            "src/bitwise.c",
            "src/framing.c",
        },
        .flags = &.{
            "-std=c99",
        },
    });
    lib.installHeadersDirectory(b.path("include/ogg"), "ogg", .{});
    b.installArtifact(lib);
}
