# 🐚 RenuxShell

<p align="center">
  <img src="https://github.com/user-attachments/assets/242b0eb2-7db1-4b7b-a01d-4f525a5c1228" alt="RenuxShell demo">
</p>

<p align="center">
  <strong>The official shell for RenuxOS: fast, minimalist, and built in Zig.</strong>
</p>

<p align="center">
  <img alt="Main Language" src="https://img.shields.io/badge/language-Zig-orange.svg?style=for-the-badge">
  <a href="https://github.com/renuxteam/renuxos-src">
    <img alt="Part of RenuxOS" src="https://img.shields.io/badge/Part%20of-RenuxOS-purple.svg?style=for-the-badge">
  </a>
  <img alt="Project Status" src="https://img.shields.io/badge/status-In%20Development-blue.svg?style=for-the-badge">
  <img alt="License" src="https://img.shields.io/badge/license-MIT-green.svg?style=for-the-badge">
</p>

---

## 🐚 About RenuxShell

**RenuxShell** is a simple yet powerful shell written in **Zig**, designed to be the default command interpreter for **RenuxOS**. It's built with a focus on speed, minimalism, and a clean design—made by and for out-of-the-box thinkers.

It supports essential commands, external program execution, and cleanly handles interruptions (like `Ctrl+C`), ensuring a stable and predictable experience.

---

## ✨ Core Features

-   **Dynamic Prompt:** Displays the current working directory.
-   **Built-in Commands:** Native support for `cd` and `echo`.
-   **External Execution:** Runs any command available in your `PATH` (e.g., `ls`, `gcc`, `git`).
-   **Variable Expansion:** Basic support for environment variables (e.g., `$HOME`, `$USER`).
-   **Signal Handling:** Ignores `Ctrl+C` (SIGINT) without crashing, keeping the shell alive.

---

## 🚀 Getting Started

To build and run RenuxShell, follow the steps below.

**Prerequisites:**
-   [Zig compiler](https://ziglang.org/download/) (master/nightly)
-   A C compiler like `GCC` or `Clang` (for the signal wrapper)

**Steps:**
```bash
# 1. Clone the repository and enter the directory
git clone https://github.com/renuxteam/renuxshell.git
cd renuxshell

# 2. Build the project
zig build

# 3. Run the shell
zig build run

# (Optional) To run the compiled binary directly:
# ./zig-out/bin/renuxshell
```

---

## 🤝 How to Contribute

Contributions are very welcome! This is a project driven by a passion for simple and efficient systems.

**Ways you can help:**
-   ⭐ Star the project.
-   🐞 Open an *Issue* to report bugs or suggest new features.
-   🛠️ Submit a *Pull Request* to implement something from our to-do list (see below!).
-   💡 Suggest improvements to the structure or code.

---

## 🗺️ Roadmap (To-Do)

Below are the next planned features. Feel free to pick one up and contribute!

-   [ ] Pipe (`|`) and Redirection (`>`, `>>`, `<`) support.
-   [ ] Command history (arrow key navigation).
-   [ ] Tab autocompletion.
-   [ ] More built-in commands like `export`, `unset`, `pwd`, and `exit`.
-   [ ] Basic scripting support.

---

## 🧠 Project Structure

```
renuxshell/
├── build.zig                  # Zig build script
└── src/                       # Source code
    ├── include/               # Header files for C/Zig interop
    │   └── signal_wrapper.h
    ├── shell.zig              # Main shell logic in Zig
    └── signal_wrapper.c       # C wrapper for signal handling
```

---

#### 👨‍💻 Author
**Renan Lucas** – An AuDHD, ethical hacker, engineer, and creator of RenuxOS.

#### 🧷 License
MIT License. Use it freely, just give credit 😉.

---
*Built with ❤️ and autistic neurons to take over the terminals of the future.*
