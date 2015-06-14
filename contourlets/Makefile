# a changer avec le --prefix
#CFLAGS = -g -pg -Wall `libit-config --cflags`
CFLAGS = -g -O2 -Wall `libit-config --cflags`
LIBS = `libit-config --libs` -lezbc #-lefence
CC = gcc

OBJS = dfb.o contourlet.o pyramid.o ezbc.o

all: contourlet

contourlet: $(OBJS) main.o
	$(CC) $(CFLAGS) -o contourlet main.o $(OBJS) $(LIBS)

%.o: %.c 
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	$(RM) contourlet main.o $(OBJS)
