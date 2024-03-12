CC = gcc
CFLAGS = -Wall -Werror -g -std=gnu99
TARGET = regex

all: $(TARGET)

regex: regex.c
	$(CC) $(CFLAGS) regex.c -o regex

run:
	./regex

clean:
	rm -f $(TARGET) *.o *~ *.bak


