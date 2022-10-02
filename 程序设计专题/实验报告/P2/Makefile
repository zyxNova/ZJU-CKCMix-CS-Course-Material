SRC = ..\..\src\acllib.c
INCLUDE_DIR = ..\..\src
LIB = gdi32 ole32 oleaut32 uuid winmm msimg32

edit :
	gcc $(SRC) $@.c -I$(INCLUDE_DIR) $(LIB:%=-l%) -DWINVER=0x0501 -o $@