// RenuxShell - A simple shell implementation in Zig
// Written by Renan Lucas
// STD Library Usage
const std = @import("std");
// Import signal.zig to ignore SIGINT
const signal = @cImport({
    @cInclude("signal_wrapper.h");
    @cInclude("signal.h");
});
// Import necessary POSIX functions
const c_errno = @cImport({
    @cInclude("errno.h");
    @cInclude("unistd.h");
    @cInclude("string.h");
});

extern fn setenv(name: [*:0]const u8, value: [*:0]const u8, overwrite: c_int) c_int;

pub fn ignore_sigint(sig: c_int) callconv(.C) void {
    _ = sig; // Ignore the signal
    // This function is intentionally left empty to ignore SIGINT (Ctrl+C)
}

fn get_error() c_int {
    return c_errno.__errno_location().*;
}

pub fn main() !void {
    // Set the SHELL environment variable to "RenuxShell"
    _ = setenv("SHELL", "RenuxShell", 1);
    // Initialize the shell
    const allocator = std.heap.page_allocator;
    const stdout = std.io.getStdOut().writer();
    const stdin = std.io.getStdIn().reader();
    // ignoore warning for unused variable
    _ = stdin;
    // Buffer for reading input
    var buf: [1024]u8 = undefined;
    // Main loop for the shell
    // ignore SIGINT (Ctrl+C) to prevent the shell from exiting
    signal.set_ignore_signal(signal.SIGINT, signal.soft_sigint_handler);
    while (true) {

        // Print the current working directory
        const cwd_path = try std.fs.cwd().realpathAlloc(allocator, ".");
        // Ensure the path is freed after use
        defer allocator.free(cwd_path);
        // Print the prompt with the current directory
        try stdout.print("{s} $ ", .{cwd_path});

        var idx: usize = 0;

        while (true) {
            const slice = buf[idx .. idx + 1];
            const res = c_errno.read(0, &buf[idx], 1); // Read a single byte from stdin

            if (res == -1) {
                if (get_error() == c_errno.EINTR) {
                    // Interrupted by a signal, continue reading
                    continue;
                } else {
                    // An error occurred, print the error and exit
                    const err_str = std.mem.span(c_errno.strerror(get_error()));
                    try stdout.print("Error reading input: {s}\n", .{err_str});
                    return error.FileNotFound; // Return an error code
                }
            }

            // Read a single byte from stdin
            if (res == 0) {
                // EOF
                return;
            }
            // Read from stdin into the buffer
            if (slice[0] == '\n') {
                idx += 1;
                break; // End of line
            }
            if (res > 0) {
                const res2: usize = @intCast(res);
                // Check if the read bytes fit in the buffer
                idx += res2;
            }
            if (idx >= buf.len) {
                // Buffer overflow, reset the index
                break;
            }
        }
        if (idx == 0) {
            continue; // Skip if no input was read
        }

        const line = buf[0 .. idx - 1]; // Exclude the newline character

        // Trim whitespace from the input
        const trimed = std.mem.trim(u8, line, " \t\r\n");
        // Check for exit command
        if (std.mem.eql(u8, trimed, "exit")) {
            break;
        }
        // Check for empty input
        if (trimed.len == 0) {
            continue; // Skip empty input
        }
        // Split the input into arguments
        var split = std.mem.splitScalar(u8, trimed, ' ');
        // Create an array to hold the arguments
        var args = std.ArrayList([]const u8).init(allocator);
        // Iterate over the split tokens
        while (split.next()) |token| {
            // Skip leading and trailing whitespace
            if (token.len == 0) {
                continue; // Skip empty tokens
            }
            // Expand variables in the token
            const expanded = try expand_variable(token, allocator);
            // Append the expanded token to the arguments list
            try args.append(expanded);
        }
        // Check if the first argument is empty
        if (args.items.len == 0) {
            continue; // Skip empty input
        }
        // Check for built-in commands
        if (std.mem.eql(u8, args.items[0], "echo")) {
            if (args.items.len > 1) {
                for (args.items[1..]) |arg| {
                    try stdout.print("{s} ", .{arg});
                }
            }
            try stdout.print("\n", .{});
            continue; // Skip echo command
        }

        if (std.mem.eql(u8, args.items[0], "cd")) {
            if (args.items.len > 1) {
                const new_dir = args.items[1];
                const result = std.posix.chdir(new_dir);

                if (result) |_| {
                    // OK
                } else |err| {
                    const c = @cImport({
                        @cInclude("string.h");
                    });

                    const err_str = std.mem.span(c.strerror(@intFromError(err)));
                    try stdout.print("Error switching to direcory '{s}': {s}\n", .{ new_dir, err_str });
                }
            } else {
                try stdout.print("Error: missing argument\n", .{});
            }
            continue; // Skip cd command
        }

        var process = std.process.Child.init(args.items, allocator);
        process.stdin_behavior = .Inherit;
        process.stdout_behavior = .Inherit;
        process.stderr_behavior = .Inherit;

        const result = process.spawnAndWait();

        signal.set_ignore_signal(signal.SIGINT, signal.soft_sigint_handler);

        if (result) |exit_status| {
            _ = exit_status;
        } else |err| {
            switch (err) {
                error.FileNotFound => try stdout.print("Error command not found: {s}\n", .{args.items[0]}),
                else => return err,
            }
        }
    }
}

fn expand_variable(token: []const u8, allocator: std.mem.Allocator) ![]const u8 {
    if (std.mem.startsWith(u8, token, "$")) {
        const var_name = token[1..];
        if (std.mem.eql(u8, var_name, "SHELL")) {
            return allocator.dupe(u8, "RenuxShell");
        } else {
            return allocator.dupe(u8, "");
        }
    } else {
        return allocator.dupe(u8, token);
    }
}
