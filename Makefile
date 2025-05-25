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

%.o: %.s
	$(CC) -MMD $(CXXFLAGS) -c $<

-include $(DEP)

clean:
	rm -rf $(EXE) $(OBJ) $(DEP)
