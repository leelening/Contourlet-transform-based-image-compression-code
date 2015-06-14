#!/bin/sh

EXE=test_wav
FLAGS=-g -Wall -O2 `libit-config --cflags`
LIBS=`libit-config --libs` -lm # -lefence
CC=gcc
DIFF=diff -c

all: $(EXE)

$(EXE): $(EXE).c
	$(CC) $(FLAGS) -o $(EXE) $(EXE).c $(LIBS)

clean:
	$(RM) $(EXE) out.wav reverse.wav

exe:
	./$(EXE)

check:
	./$(EXE) > test.out
	$(DIFF) test.out $(EXE).out
	$(RM) test.out
#additional checking that the image is the same
	$(DIFF) ../data/test.wav out.wav