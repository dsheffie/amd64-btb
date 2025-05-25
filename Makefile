OBJ =  btb.o cycle_1024.o cycle_128.o cycle_16384.o cycle_16.o cycle_2048.o cycle_256.o cycle_32.o cycle_4096.o cycle_4.o cycle_512.o cycle_64.o cycle_8192.o cycle_8.o cycle_65536.o cycle_32768.o
CC = gcc
EXE = btbtest
OPT = -O2
CXXFLAGS = -std=gnu99 -g $(OPT)
DEP = $(OBJ:.o=.d)

.PHONY: all clean

all: $(EXE)

$(EXE) : $(OBJ)
	$(CC) $(CXXFLAGS) $(OBJ) $(LIBS) -o $(EXE)  -lm -z max-page-size=65536

%.o: %.c
	$(CC) -MMD $(CXXFLAGS) -c $< 

cycle_4.o:
	./cycle.py 2
	$(CC) -MMD $(CXXFLAGS) -c cycle_4.s

cycle_8.o:
	./cycle.py 3
	$(CC) -MMD $(CXXFLAGS) -c cycle_8.s

cycle_16.o:
	./cycle.py 4
	$(CC) -MMD $(CXXFLAGS) -c cycle_16.s

cycle_32.o:
	./cycle.py 5
	$(CC) -MMD $(CXXFLAGS) -c cycle_32.s

cycle_64.o:
	./cycle.py 6
	$(CC) -MMD $(CXXFLAGS) -c cycle_64.s

cycle_128.o:
	./cycle.py 7
	$(CC) -MMD $(CXXFLAGS) -c cycle_128.s

cycle_256.o:
	./cycle.py 8
	$(CC) -MMD $(CXXFLAGS) -c cycle_256.s

cycle_512.o:
	./cycle.py 9
	$(CC) -MMD $(CXXFLAGS) -c cycle_512.s

cycle_1024.o:
	./cycle.py 10
	$(CC) -MMD $(CXXFLAGS) -c cycle_1024.s

cycle_2048.o:
	./cycle.py 11
	$(CC) -MMD $(CXXFLAGS) -c cycle_2048.s

cycle_4096.o:
	./cycle.py 12
	$(CC) -MMD $(CXXFLAGS) -c cycle_4096.s

cycle_8192.o:
	./cycle.py 13
	$(CC) -MMD $(CXXFLAGS) -c cycle_8192.s

cycle_16384.o:
	./cycle.py 14
	$(CC) -MMD $(CXXFLAGS) -c cycle_16384.s

cycle_32768.o:
	./cycle.py 15
	$(CC) -MMD $(CXXFLAGS) -c cycle_32768.s

cycle_65536.o:
	./cycle.py 16
	$(CC) -MMD $(CXXFLAGS) -c cycle_65536.s

-include $(DEP)

clean:
	rm -rf $(EXE) $(OBJ) $(DEP)
