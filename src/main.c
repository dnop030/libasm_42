#include "header.h"

// Define a very large size for the maximum test
#define MAX_ft_strlen_TEST_SIZE 1000000

void test_ft_strlen() {
	size_t len;

	// Normal case
	len = ft_strlen("hello");
	printf("ft_strlen(\"hello\"): %lu\n", len);
	if (len != 5) {
		printf("Error: Expected 5, got %lu\n", len);
	}

	// Corner case
	len = ft_strlen("");
	printf("ft_strlen(\"\"): %lu\n", len);
	if (len != 0) {
		printf("Error: Expected 0, got %lu\n", len);
	}

	// Maximum length test case
	char *long_string = malloc(MAX_ft_strlen_TEST_SIZE + 1);
	if (long_string) {
		memset(long_string, 'a', MAX_ft_strlen_TEST_SIZE);
		long_string[MAX_ft_strlen_TEST_SIZE] = '\0';
		len = ft_strlen(long_string);
		printf("ft_strlen(long_string): %lu\n", len);
		if (len != MAX_ft_strlen_TEST_SIZE) {
			printf("Error: Expected %d, got %lu\n", MAX_ft_strlen_TEST_SIZE, len);
		}
		free(long_string);
	} else {
		printf("Error: Failed to allocate memory for long_string\n");
	}
}

void test_ft_strcmp() {
	int result;

	// Normal case
	result = ft_strcmp("hello", "hello");
	printf("ft_strcmp(\"hello\", \"hello\"): %d\n", result);
	if (result != 0) {
		printf("Error: Expected 0, got %d\n", result);
	}

	result = ft_strcmp("hello", "world");
	printf("ft_strcmp(\"hello\", \"world\"): %d\n", result);
	if (result >= 0) {
		printf("Error: Expected negative value, got %d\n", result);
	}

	// Corner case
	result = ft_strcmp("", "");
	printf("ft_strcmp(\"\", \"\"): %d\n", result);
	if (result != 0) {
		printf("Error: Expected 0, got %d\n", result);
	}

	result = ft_strcmp("hello", "");
	printf("ft_strcmp(\"hello\", \"\"): %d\n", result);
	if (result <= 0) {
		printf("Error: Expected positive value, got %d\n", result);
	}

	result = ft_strcmp("", "hello");
	printf("ft_strcmp(\"\", \"hello\"): %d\n", result);
	if (result >= 0) {
		printf("Error: Expected negative value, got %d\n", result);
	}
}

void test_ft_strcpy() {
	char dest[50];
	char *result;

	// Normal case
	result = ft_strcpy(dest, "hello");
	printf("ft_strcpy(dest, \"hello\"): %s\n", dest);
	if (ft_strcmp(result, "hello") != 0) {
		printf("Error: Expected \"hello\", got \"%s\"\n", result);
	}

	// Corner case
	result = ft_strcpy(dest, "");
	printf("ft_strcpy(dest, \"\"): %s\n", dest);
	if (ft_strcmp(result, "") != 0) {
		printf("Error: Expected \"\", got \"%s\"\n", result);
	}
}

// void test_ft_strdup() {
//     char *str;

//     // Normal case
//     str = ft_strdup("hello");
//     printf("ft_strdup(\"hello\"): %s\n", str);
//     if (ft_strcmp(str, "hello") != 0) {
//         printf("Error: Expected \"hello\", got \"%s\"\n", str);
//     }
//     free(str);

//     // Corner case
//     str = ft_strdup("");
//     printf("ft_strdup(\"\"): %s\n", str);
//     if (ft_strcmp(str, "") != 0) {
//         printf("Error: Expected \"\", got \"%s\"\n", str);
//     }
//     free(str);
// }

void test_ft_write() {
	int fd;
	ssize_t bytesWritten;

	// Normal case
	fd = open("testfile.txt", O_CREAT | O_RDWR, 0666);
	if (fd == -1) {
		perror("open");
		return;
	}

	bytesWritten = ft_write(fd, "hello, world", 12);
	if (bytesWritten == -1) {
		perror("ft_write");
		close(fd);
		return;
	} else if (bytesWritten != 12) {
		printf("Error: Expected 12 bytes written, got %zd\n", bytesWritten);
	}

	close(fd);

	// Corner case: writing empty string
	fd = open("emptyfile.txt", O_CREAT | O_RDWR, 0666);
	if (fd == -1) {
		perror("open");
		return;
	}

	bytesWritten = ft_write(fd, "", 0);
	if (bytesWritten == -1) {
		perror("ft_write");
	} else if (bytesWritten != 0) {
		printf("Error: Expected 0 bytes written, got %zd\n", bytesWritten);
	}

	close(fd);

	// Error case: writing to a closed file descriptor
	bytesWritten = ft_write(fd, "should fail", 11);
	if (bytesWritten != -1 || errno != EBADF) {
		printf("Error: Expected ft_write to fail with EBADF, got %zd, errno %d\n", bytesWritten, errno);
	} else {
		perror("ft_write to closed fd");
	}
}

void test_ft_read() {
	char buffer[128];
	int fd;
	ssize_t bytesRead;

	// Normal case
	fd = open("testfile.txt", O_RDONLY);
	if (fd == -1) {
		perror("open");
		return;
	}

	bytesRead = ft_read(fd, buffer, sizeof(buffer) - 1);
	if (bytesRead == -1) {
		perror("ft_read");
		close(fd);
		return;
	}

	buffer[bytesRead] = '\0';
	printf("ft_read normal case: %s\n", buffer);

	close(fd);

	// Corner case: empty file
	fd = open("emptyfile.txt", O_RDONLY);
	if (fd == -1) {
		perror("open");
		return;
	}

	bytesRead = ft_read(fd, buffer, sizeof(buffer));
	if (bytesRead == -1) {
		perror("ft_read");
	} else if (bytesRead != 0) {
		printf("Error: Expected 0 bytes ft_read, got %zd\n", bytesRead);
	}

	buffer[bytesRead] = '\0';
	printf("ft_read empty file: %s\n", buffer);

	close(fd);

	// Error case: reading from a closed file descriptor
	bytesRead = ft_read(fd, buffer, sizeof(buffer));
	if (bytesRead != -1 || errno != EBADF) {
		printf("Error: Expected ft_read to fail with EBADF, got %zd, errno %d\n", bytesRead, errno);
	} else {
		perror("ft_read from closed fd");
	}
}

int main() {
	// printf("Testing ft_strlen:\n");
	// test_ft_strlen();

	// printf("\nTesting ft_strcmp:\n");
	// test_ft_strcmp();

	// printf("\nTesting ft_strcpy:\n");
	// test_ft_strcpy();

	// printf("\nTesting ft_strdup:\n");
	// test_ft_strdup();

	printf("\nTesting ft_write:\n");
	test_ft_write();

	printf("\nTesting ft_read:\n");
	test_ft_read();

	return 0;
}
