// Import STD
const std = @import("std");

// Build script
// Build function
pub fn build(b: *std.Build) void {
    // Set the Release Small to default build optimization
    const optimize = std.builtin.Mode.ReleaseSmall;
    // Executable "RenuxShell"
    const exe = b.addExecutable(.{
        .name = "RenuxShell",
        .root_source_file = b.path("src/shell.zig"),
        .target = b.graph.host,
        .optimize = optimize,
    });
    // Add include dirs
    exe.addIncludePath(b.path("src/include/"));
    // Add signal wrapper C file
    exe.addCSourceFile(.{
        .file = b.path("src/signal_wrapper.c"),
        .flags = &[_][]const u8{},
    });
    // LibC
    exe.linkLibC();
    // Install Renux Shell
    b.installArtifact(exe);
    // "zig build run" command
    const run_exe = b.addRunArtifact(exe);
    const run_step = b.step("run", "Run the Renux Shell");
    run_step.dependOn(&run_exe.step);
}
