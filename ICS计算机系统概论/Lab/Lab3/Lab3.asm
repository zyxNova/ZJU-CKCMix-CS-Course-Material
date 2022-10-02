            .ORIG   x0200
            LD      R6, OS_SP
            LD      R0, USER_PSR 
            ADD     R6, R6, #-1 
            STR     R0, R6, #0
            LD      R0, USER_PC
            ADD     R6, R6, #-1
            STR     R0, R6, #0
;   
            LD      R0, INTEN
            STI     R0, KBSR            ; set interrupt enable bit to 1
;
            LD      R0, StartAdd
            STI     R0, INTV            ; set interrupt vector table, x0180 contains x0800
;
            RTI
;
OS_SP       .FILL x3000 
USER_PSR    .FILL x8002 
USER_PC     .FILL x3000
INTEN       .FILL x6000                 ; INT.EN bit MASK
KBSR        .FILL xFE00                 
StartAdd    .FILL x0800                 ; the start address of the INT service subroutine
INTV        .FILL x0180                 ; the keyboard INTV
            .END
;
;
            .ORIG x3000
            LD      R3, ASCII0
            ADD     R3, R3, #7          ; R3 contains the char, initialize to 7
            LD      R2, MAXCHAR         ; R2 contains the char counter
;
AGAIN       BRz     Newline
            JSR     DELAY
            ADD     R0, R3, #0
            OUT                         ; output the current char to monitor
            ADD     R2, R2, #-1         ; counter--
            BR      Loop
Newline     LD      R0, Enter
            OUT                         ; output '\n' to monitor
            LD      R2, MAXCHAR         ; reset counter to 40
Loop        BR      AGAIN
;
DELAY       ST      R1, DELAY_R1
            LD      R1, DELAY_COUNT
DELAY_LOOP  ADD     R1, R1, #-1
            BRnp    DELAY_LOOP
            LD      R1, DELAY_R1
            RET
;
DELAY_COUNT .FILL   #2000
DELAY_R1    .BLKW   1
Enter       .FILL   x000A    
ASCII0      .FILL   #48
MAXCHAR     .FILL   #40
            .END
;
;
            .ORIG   x0800
            ADD     R6, R6, #-1
            STR     R0, R6, #0
            ADD     R6, R6, #-1
            STR     R1, R6, #0
            ADD     R6, R6, #-1
            STR     R2, R6, #0          ; Save R0,R1,R2
;
            LDI     R0, KBDR            ; R0 uses for load the char keyboard input, and output non-digit char
            LD      R1, ASCEnter
            NOT     R1, R1
            ADD     R1, R1, #1          ; R1 <- '\n'
            LD      R2, CHAR0
            NOT     R2, R2
            ADD     R2, R2, #1          ; R2 <- -'0'
;            
            ADD     R1, R1, R0
            BRz     DECREASE            ; KBDR is '\n'
            ADD     R1, R2, R0
            BRzp    IfDigit             ; to test if KBDR is '0'~'9'
;
Other       ADD     R1, R0, #0          ; KBDR is neither '\n' nor digit
            LD      R2, MAXNUM
            LD      R0, ASCEnter
            OUT
            ADD     R0, R1, #0
L2          ST      R7, SaveR7          ; Noting: SaveR7
            JSR     Delay2
            LD      R7, SaveR7
            OUT
            ADD     R2, R2, #-1
            BRp     L2
            LD      R0, ASCenter
            OUT
            BR      EndINT
;
IfDigit     ADD     R1, R1, #-10
            BRzp    Other     
            ADD     R3, R0, #0          ; KBDR is digit
            BR      EndINT
            
DECREASE    ADD     R1, R3, R2          ; test if current task counter is '0'
            BRz     EndINT
            ADD     R3, R3, #-1
            BR      EndINT
            
EndINT      LDR     R2, R6, #0
            ADD     R6, R6, #1
            LDR     R1, R6, #0
            ADD     R6, R6, #1
            LDR     R0, R6, #0
            ADD     R6, R6, #1          ; Restore R0,R1,R2
;
            RTI
;
DELAY2      ST      R1, DELAY2_R1       ; nest subroutine should save R7
            LD      R1, DELAY2_COUNT
DELAY2_LOOP ADD     R1, R1, #-1
            BRnp    DELAY2_LOOP
            LD      R1, DELAY2_R1
            RET
;
DELAY2_COUNT .FILL   #2000
DELAY2_R1   .BLKW   1
SaveR7      .BLKW   1
KBDR        .FILL   xFE02
ASCenter    .FILL   x000A
CHAR0       .FILL   #48
MAXNUM      .FILL   #40
            .END