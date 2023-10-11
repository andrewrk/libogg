const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "ogg",
        .target = target,
        .optimize = optimize,
    });
    lib.addIncludePath(.{ .path = "include" });
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
    lib.installHeadersDirectory("include/ogg", "ogg");
    b.installArtifact(lib);
}
