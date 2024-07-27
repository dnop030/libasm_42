#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>

// Define a very large size for the maximum test
#define MAX_STRLEN_TEST_SIZE 1000000

#ifndef HEADER_H
# define HEADER_H

size_t ft_strlen(const char *s);
ssize_t ft_write(int fd, const void *buf, size_t count);

#endif
