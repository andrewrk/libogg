const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addLibrary(.{
        .name = "ogg",
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
        }),
        .linkage = .static,
    });
    lib.addIncludePath(b.path("include"));
    lib.addCSourceFiles(.{
        .files = &.{
            "src/bitwise.c",
            "src/framing.c",
        },
        .flags = &.{
            "-std=c99",
        },
    });
    lib.linkLibC();
    lib.installHeadersDirectory(b.path("include/ogg"), "ogg", .{});
    b.installArtifact(lib);
}
