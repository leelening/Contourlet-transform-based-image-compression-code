#OPTIMIZE = -O6 -march=pentium4 -mcpu=pentium4 -fexpensive-optimizations -fomit-frame-pointer
OPTIMIZE = -g -pg
CFLAGS  = $(OPTIMIZE) -I/usr/local/include -Wall 
LDFLAGS = -g -L/usr/local/lib
#LIBS    = -lm -lslim -lefence
LIBS    = -lm -lslim
OBJS =  ezbc_tables.o ezbc_encoder.o ezbc_decoder.o ezbc_codec.o arithmetic_codec.o bitbuffer.o
PREFIX = /usr/local

all: libezbc.so libezbc.a

libezbc.so: $(OBJS)
	$(CC) -shared $(LDFLAGS) -o libezbc.so $(OBJS) $(LIBS)

libezbc.a: $(OBJS)
	$(AR) r libezbc.a $(OBJS)

%.o: %.c %.h
	$(CC) $(CFLAGS) -c -o $@ $<

install: all
	cp libezbc.so libezbc.a $(PREFIX)/lib
	cp *.h $(PREFIX)/include

clean:
	$(RM) $(OBJS) libezbc.so libezbc.a