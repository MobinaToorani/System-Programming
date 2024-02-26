CC = gcc
CFLAGS = -Wall -Werror -g -std=gnu99
TARGET = regex

all: $(TARGET)

regx: regex.c
	$(CC) $(CFLAGS) regex.c -o regex

run:
	./regex

clean:
	rm -f $(TARGET) *.o *~ *.bak


