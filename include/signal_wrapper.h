#ifndef SIGNAL_WRAPPER_H
#define SIGNAL_WRAPPER_H

void soft_sigint_handler(int sig);
void set_ignore_signal(int sig, void (*handler)(int));

#endif
