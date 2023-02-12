const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "ogg",
        .target = target,
        .optimize = optimize,
    });
    lib.addIncludePath("include");
    lib.addCSourceFiles(&.{
        "src/bitwise.c",
        "src/framing.c",
    }, &.{
        "-std=c99",
    });
    lib.linkLibC();
    lib.install();
    lib.installHeadersDirectory("include/ogg", "ogg");
}
