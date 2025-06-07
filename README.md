# 🐚 RenuxShell

A simple shell written in **Zig**, supporting basic commands and clean SIGINT (Ctrl+C) handling. This is the official shell for the **Renux OS** project — fast, minimal, and built by and for out-of-the-box thinkers.

---

## 🚀 Features

- Prompt displays current working directory
- Supports `cd` command
- Supports `echo` command
- Basic variable expansion (e.g., `$SHELL`)
- Executes external commands (e.g., `ls`, `gcc`, etc.)
- Ignores Ctrl+C (SIGINT) without crashing
- Built-in commands handled separately

---

## 🛠️ Build Instructions

**Requirements:**

- [Zig](https://ziglang.org/download/)
- GCC or Clang (for compiling the C signal wrapper)

### Clone the repository 
```bash
git clone https://github.com/renuxteam/renuxshell.git
```
### Enter the `renuxshell` directory
```bash
cd renuxshell
```
## Available commands
### 🔧 Build

```bash
zig build 
```

### ▶️ Run

```bash
zig build run
```

---

## 🧠 Project Structure

```
renuxshell/
├── build.zig                  # Zig build script
└── src/                       # Source code
    ├── include/               # Header files for C/Zig interop
    │   └── signal_wrapper.h
    ├── shell.zig              # Main shell code in Zig
    └── signal_wrapper.c       # C wrapper for signal handling

```

---


## 🧪 To-Do

- Pipe and redirection support
- Command history
- Tab autocompletion
- More built-in commands like `export`, `pwd`, etc.

---

## 👨‍💻 Author

**Renan Lucas** – A AuDHD, ethical hacker, engineer, creator of RenuxOS 

---

## 🧷 License

MIT License. Use it freely, just give credit 😉

---
*built with ❤️ and autistic neurons to take over the terminals of the future.*
