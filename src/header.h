#include <stdio.h>
#include <unistd.h>
#include <string.h>

#ifndef HEADER_H
# define HEADER_H

size_t strlen(const char *s);
ssize_t ft_write(int fd, const void *buf, size_t count);

#endif
