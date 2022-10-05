#include <stdio.h>
#include <string.h>
#include "acllib.h"
#include "edit.h"

void string_inflate() {
    size = strlen(sp)+BLOCK;
    char t[size];
    strcpy(t,sp);
    free(sp);
    sp = t;
} 

void view() {
    beginPaint();
    setPenColor(WHITE);
    setBrushColor(WHITE);
    rectangle(0, 0, WINWID, WINHEI);
    setTextColor(BLACK);
    setTextBkColor(WHITE);
    setTextSize(TEXTSIZE);
    paintText(0,0,sp);
    if (mode == INSERT) {
        setCaretSize(2,TEXTSIZE);
        setCaretPos(caret*TEXTSIZE*0.52,0);
        showCaret();
    } else {
        hideCaret();
        char hide[2];
        hide[0] = sp[caret];
        hide[1] = '\0';
        
        setPenColor(BLACK);
        setBrushColor(BLACK);
        rectangle(caret*TEXTSIZE*0.52,0,(caret+1)*TEXTSIZE*0.52,TEXTSIZE);

        setTextColor(WHITE);
        setTextBkColor(BLACK);
        paintText(caret*TEXTSIZE*0.52,0,hide);
    }
    
    endPaint();
}

void sub() {
    switch(state) {
            case BACKSPACE:
                if (caret !=0 ){
                    for (int i=caret-1;i<strlen(sp)-1;i++) {
                        sp[i] = sp[i+1];
                    }
                    sp[strlen(sp)-1] = '\0';
                    caret--;
                }
                break;
            case MDELETE:
                if (caret != strlen(sp)) {
                    for (int i=caret;i<strlen(sp)-1;i++) {
                        sp[i] = sp[i+1];
                    }
                    sp[strlen(sp)-1] = '\0';
                }
                break;
    }
    view();
}
void add(int c) {
    switch(mode) {
        case INSERT:
            if (strlen(sp)+2 == size) string_inflate();
            caret++;
            for (int i=strlen(sp);i>=caret;i--) {
                sp[i] = sp[i-1];
            }
            sp[strlen(sp)+2] = '\0';
            sp[caret-1] = c;
            break;
        case COVER:
            if (strlen(sp)+2 == size) string_inflate();
            sp[caret++] = c;
            break;
    }
    view();
}
void keyprobe(int key,int event) {
    if (event==0) {//0是按下，1是抬起
        switch(key) {
            case 0x08://BACKSPACE
            state = BACKSPACE;
            sub();
            break;
            case 0x2E://DEL
            state = MDELETE;
            sub();
            break;
            case 0x25://LEFT
            if (caret!=0) caret--;
            view();
            break;
            case 0x27://RIGHT
            if (caret!=strlen(sp)) caret++;
            view();
            break;
            case 0x2D://INS
            mode *= -1;
            view();
            break;
            default:break;
        }
    }
}
void charput(char key) {
    if (key>=32 && key<=126) {
        add(key);
    }
    
}
int Setup() {
    initWindow("EDITOR", 0, 0, WINWID, WINHEI);
    initConsole();

    registerKeyboardEvent(keyprobe);
    registerCharEvent(charput);
}