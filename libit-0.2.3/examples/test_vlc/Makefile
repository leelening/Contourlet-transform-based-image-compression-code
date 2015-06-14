#!/bin/sh

EXE=test_vlc
FLAGS=-Wall -O2 `libit-config --cflags`
LIBS=`libit-config --libs` -lm # -lefence
LIBS=/home/edgar/hjegou/local/lib/libit.a -lm
CC=gcc
DIFF=diff -c

all: $(EXE)

$(EXE): $(EXE).c
	$(CC) $(FLAGS) -o $(EXE) $(EXE).c $(LIBS) 

clean:
	$(RM) $(EXE)

exe:
	./$(EXE)

check:
	./$(EXE) > test.out
	$(DIFF) test.out $(EXE).out
	$(RM) test.out