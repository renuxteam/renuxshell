#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <string.h>
#include "./include/signal_wrapper.h"


void soft_sigint_handler(int sig) {
    (void)sig;  // Suppress unused parameter warning
    write(STDOUT_FILENO, "\n", 1);  // Write a newline to stdout
    // This handler is intentionally left empty to ignore SIGINT
}

void set_ignore_signal(int sig, void (*handler)(int)) {
    struct sigaction sa;
    sa.sa_handler = handler;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = 0;

    if (sigaction(sig, &sa, NULL) == -1) {
        perror("sigaction failed");
    }
}