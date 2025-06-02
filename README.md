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
### make build.lua executable
```bash
chmod +x build.lua
```
## Available commands
### 🔧 Build

```bash
./build.lua shell
```

### 🧹 Clean

```bash
./build.lua clean
```

### ▶️ Run

```bash
./build.lua run
```

---

## 🧠 Project Structure

```
renuxshell/
├── shell.zig             # Main shell code
├── signal_wrapper.c      # C wrapper for signal handling
├── include/
│   └── signal_wrapper.h  # Header for Zig-C interop
├── build.lua             # Build/clean/run script
└── README.md             # This file
```

---

## Running RenuxShell
![image](https://github.com/user-attachments/assets/da303095-b03e-4226-9281-7bc8b9b09e22)


---

## 🧪 To-Do

- Pipe and redirection support
- Command history
- Tab autocompletion
- More built-in commands like `export`, `pwd`, etc.

---

## 👨‍💻 Author

**Renan Lucas** – Ethical hacker, engineer, creator of RenuxOS 

---

## 🧷 License

MIT License. Use it freely, just give credit 😉

---
*built with ❤️ and autistic neurons to take over the terminals of the future.*
