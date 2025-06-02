-- Written by Renan Lucas
#!/usr/bin/env luajit

local os = require("os")

local function shell()
    print("==> Building shell...")
    local cmd = "zig build-exe -O ReleaseSmall shell.zig signal_wrapper.c -lc -I./include"
    local res = os.execute(cmd)
    if res ~= 0 then
        print("Build failed!")
        os.exit(1)
    end
    print("Build finished!")
end

local function clean()
    print("==> Cleaning build artifacts...")
    local res = os.remove("shell")
    local res2 = os.remove("shell.o")
    if res or res2 then
        print("==> Clean done!")
    else
        print("==> Nothing to clean or failed to remove shell executable.")
    end
end

local function run()
    print("==> Running shell...")
    local res = os.execute("./shell")
    if res ~= 0 then
        print("==> !!Execution finished with errors or was interrupted!!")
    end
end

local cmd = arg[1]

if cmd == "shell" then
    shell()
elseif cmd == "clean" then
    clean()
elseif cmd == "run" then
    run()
else
    print("Usage: ./build.lua [shell|clean|run]")
end
