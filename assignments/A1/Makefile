CC = gcc
CFLAGS = -Wall -Werror -g -std=gnu99
TARGET = filecopy ticket triangle

all: $(TARGET)

filecopy: filecopy.c
	$(CC) $(CFLAGS) -o filecopy filecopy.c

ticket: ticket.c
	$(CC) $(CFLAGS) -o ticket ticket.c

triangle: triangle.c
	$(CC) $(CFLAGS) -o triangle triangle.c

clean:
	rm -f $(TARGET) *.o *~ *.bak

runfilecopy:
	./filecopy input.txt output.txt

runticket:
	./ticket

runtriangle:
	./triangle