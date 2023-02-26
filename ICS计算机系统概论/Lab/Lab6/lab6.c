#include <stdio.h>
#include <stdlib.h>
#define BUSNUM 0x10000
#define HALT 0xF025
#define MASK15_12 0xF000
#define MASK11_9 0x0E00
#define MASK8_6 0x01C0
#define MASK5   0x0020
#define MASK4   0x0010
#define MASK2_0 0x0007
#define MASK4_0 0x001F
#define MASK8_0 0x01FF
#define MASK5_0 0x003F
#define MASK10_0 0x07FF
#define MASK11 0x0800
#define MASK10 0x0400
#define MASK9 0x0200
#define MASK8 0x0100
enum _opcode {
    BR = 0, ADD, LD, 
    ST, JSR, AND,
    LDR, STR, NOT = 9,
    LDI, STI, JMP,
    LEA = 14, TRAP
} opcode;

short MAR, IR, PSR = 1, PC;
short MEM[BUSNUM];
short R[8];
//MEM[unsigned short], type conversion, else segmentation fault!

void setCC(int dst);
short BinarytoDecimal(char *bicode);
void Initialize(void);
void ADDfunc(void);
void ANDfunc(void);
void NOTfunc(void);
void LEAfunc(void);
void LDfunc(void);
void LDRfunc(void);
void LDIfunc(void);
void STfunc(void);
void STRfunc(void);
void STIfunc(void);
void BRfunc(void);
void JSRfunc(void);
void JMPfunc(void);
void TRAPfunc(void);

void (*fp[16])(void) = {BRfunc, ADDfunc, LDfunc, 
    STfunc, JSRfunc, ANDfunc, LDRfunc, STRfunc,
    NULL, NOTfunc, LDIfunc, STIfunc, JMPfunc, NULL,
    LEAfunc,TRAPfunc};

void setCC(int dst) {
    if (R[dst] > 0) PSR = 1;
    else if (R[dst] == 0) PSR = 2;
    else PSR = 4;
}

short BinarytoDecimal(char *bicode) {
    short decimal = 0;
    for (int i=0;bicode[i];i++) {
        decimal <<= 1;
        decimal += bicode[i] - '0';
    }
    return decimal;
}
void Initialize(void) {
    for (int i=0;i<BUSNUM;i++) {
        MEM[i] = 0x7777;
    }
    for (int i=0;i<8;i++) {
        R[i] = 0x7777;
    }
    char bicode[17];
    scanf("%s",bicode);
    PC = BinarytoDecimal(bicode);
    unsigned short temp = PC;
    while (fscanf(stdin,"%s",bicode) == 1) {
        MEM[temp++] = BinarytoDecimal(bicode);
    }
}

void ADDfunc(void) {
    int dst, src1, sign;
    signed short src2;
    dst = (IR & MASK11_9) >> 9;
    src1 = (IR & MASK8_6) >> 6;
    sign = (IR & MASK5) >> 5;
    if (sign == 0) {
        src2 = IR & MASK2_0;
        R[dst] = R[src1] + R[src2];
    }
    else {
        sign = IR & MASK4;
        src2 = IR & MASK4_0;
        if (sign) {
            src2 |= ~MASK4_0;
        }
        R[dst] = R[src1] + src2;
    }
    setCC(dst);
}

void ANDfunc(void) {
    int dst, src1, sign;
    signed short src2;
    dst = (IR & MASK11_9) >> 9;
    src1 = (IR & MASK8_6) >> 6;
    sign = (IR & MASK5) >> 5;
    if (sign == 0) {
        src2 = IR & MASK2_0;
        R[dst] = R[src1] & R[src2];
    }
    else {
        sign = IR & MASK4;
        src2 = IR & MASK4_0;
        if (sign) {
            src2 |= ~MASK4_0;
        }
        R[dst] = R[src1] & src2;
    }
    setCC(dst);
}
void NOTfunc(void) {
    int dst, src;
    dst = (IR & MASK11_9) >> 9;
    src = (IR & MASK8_6) >> 6;
    R[dst] = ~R[src];
    setCC(dst);
}

void LEAfunc(void) {
    short dst, offset9;
    dst = (IR & MASK11_9) >> 9;
    offset9 = IR & MASK8_0;
    int sign = IR & MASK8;
    if (sign) {
        offset9 |= ~MASK8_0;
    }
    R[dst] = PC + offset9;
}
void LDfunc(void) {
    short dst, offset9;
    dst = (IR & MASK11_9) >> 9;
    offset9 = IR & MASK8_0;
    int sign = IR & MASK8;
    if (sign) {
        offset9 |= ~MASK8_0;
    }
    R[dst] = MEM[(unsigned short)(PC + offset9)];
    setCC(dst);
}
void LDRfunc(void) {
    short dst, base, offset6;
    dst = (IR & MASK11_9) >> 9;
    base = (IR & MASK8_6) >> 6;
    offset6 = IR & MASK5_0;
    int sign = IR & 0x0020;
    if (sign) {
        offset6 |= ~MASK5_0;
    }
    R[dst] = MEM[(unsigned short)(R[base] + offset6)];
    setCC(dst);
}
void LDIfunc(void) {
    short dst, offset9;
    dst = (IR & MASK11_9) >> 9;
    offset9 = IR & MASK8_0;
    int sign = IR & MASK8;
    if (sign) {
        offset9 |= ~MASK8_0;
    }
    R[dst] = MEM[(unsigned short)(MEM[(unsigned short)(PC + offset9)] & 0xFFFF)];
    setCC(dst);
}
void STfunc(void) {
    short src, offset9;
    src = (IR & MASK11_9) >> 9;
    offset9 = IR & MASK8_0;
    int sign = IR & MASK8;
    if (sign) {
        offset9 |= ~MASK8_0;
    }
    MEM[(unsigned short)(PC + offset9)] = R[src];
}
void STRfunc(void) {
    short src, base, offset6;
    src = (IR & MASK11_9) >> 9;
    base = (IR & MASK8_6) >> 6;
    offset6 = IR & MASK5_0;
    int sign = IR & 0x0020;
    if (sign) {
        offset6 |= ~MASK5_0;
    }
    MEM[(unsigned short)(R[base] + offset6)] = R[src];
}
void STIfunc(void) {
    short src, offset9;
    src = (IR & MASK11_9) >> 9;
    offset9 = IR & MASK8_0;
    int sign = IR & MASK8;
    if (sign) {
        offset9 |= ~MASK8_0;
    }
    MEM[(unsigned short)(MEM[(unsigned short)(PC + offset9)] & 0xFFFF)] = R[src];
}
void BRfunc(void) {
    char n,z,p,N,Z,P;
    n = (IR & MASK11) >> 11;
    z = (IR & MASK10) >> 10;
    p = (IR & MASK9) >> 9;
    N = (PSR & 4) >> 2;
    Z = (PSR & 2) >> 1;
    P = (PSR & 1);
    if ((n & N) | (z & Z) | (p & P)) {
        short offset9 = IR & MASK8_0;
        int sign = IR & MASK8;
        if (sign) {
            offset9 |= ~MASK8_0;//SEXT
        }
        PC += offset9;
    }

}
void JSRfunc(void) {
    R[7] = PC;
    short sign = (IR & MASK11) >> 11;
    if (sign) {
        short offset11 = IR & MASK10_0;
        sign = IR & MASK10;
        if (sign) {
            offset11 |= ~MASK10_0;
        }
        PC += offset11;
    }
    else {
        short base = (IR & MASK8_6) >> 6;
        PC = R[base];
    }
}
void JMPfunc(void) {
    PC = R[(IR & MASK8_6) >> 6];
}
void TRAPfunc(void) {
    for (int i=0;i<8;i++) {
        printf("R%d = x%04hX\n",i,R[i]);
    }
    exit(0);
}
int main() {
    Initialize();
    while (1) {
        MAR = PC++;
        IR = MEM[(unsigned short)MAR];
        opcode = (IR & MASK15_12) >> 12; //>>优先级比&高??
        if (fp[opcode]) fp[opcode]();
    }
    return 0;
}
