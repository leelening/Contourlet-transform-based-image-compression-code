#!/bin/sh

EXE=test_filter
FLAGS=-g -Wall -O2 `libit-config --cflags`
LIBS=`libit-config --libs` -lm # -lefence
CC=gcc
DIFF=diff -c

all: $(EXE)

$(EXE): $(EXE).c
	$(CC) $(FLAGS) -o $(EXE) $(EXE).c $(LIBS)

clean:
	$(RM) $(EXE) *.pgm *.wav

exe:
	./$(EXE)

check:
	./$(EXE) > test.out
	$(DIFF) test.out $(EXE).out
	$(RM) test.out
