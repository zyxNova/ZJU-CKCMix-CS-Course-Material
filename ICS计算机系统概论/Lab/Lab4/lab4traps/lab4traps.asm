            .ORIG   x0080

            .FILL   MUL        ; x80
            .FILL   DIV        ; x81
            .FILL   PARSE_INT  ; x82
            .FILL   PRINT_INT  ; x83

            .END


            .ORIG   x1000

MUL         ; R0 = R0 * R1
            ST      R1, MUL_R1
            ST      R2, MUL_R2
            AND     R2, R2, #0

MUL_LOOP    ADD     R2, R2, R0
            ADD     R1, R1, #-1
            BRnp    MUL_LOOP

            ADD     R0, R2, #0
            LD      R1, MUL_R1
            LD      R2, MUL_R2
            RTI

MUL_R1      .BLKW   #1
MUL_R2      .BLKW   #1



DIV         ; R0 = R0 / R1, R1 = R0 % R1
            ; only support positive numbers
            ST      R2, DIV_R2
            ST      R3, DIV_R3

            NOT     R3, R1
            ADD     R3, R3, #1
            AND     R2, R2, #0

DIV_LOOP    ADD     R2, R2, #1
            ADD     R0, R0, R3
            BRzp    DIV_LOOP

            ADD     R1, R0, R1
            ADD     R0, R2, #-1
            LD      R2, DIV_R2
            LD      R3, DIV_R3
            RTI

DIV_R2      .BLKW   #1
DIV_R3      .BLKW   #1



PARSE_INT   ; parse the string starting from R1 to an integer
            ; return the integer in R0
            ; and move R1 to the next non-digit character
            ST      R2, PARSE_R2
            ST      R3, PARSE_R3
            AND     R0, R0, #0

PARSE_LOOP  LDR     R2, R1, #0
            LD      R3, NASCII_9
            ADD     R3, R3, R2  ; char - '9'
            BRp     PARSE_BREAK
            ADD     R3, R3, #9  ; char - '0'
            BRn     PARSE_BREAK

            ADD     R0, R0, R0  ; 2R0
            ADD     R3, R0, R3  ; 2R0 + R3
            ADD     R0, R0, R0  ; 4R0
            ADD     R0, R0, R0  ; 8R0
            ADD     R0, R0, R3  ; 10R0 + R3

            ADD     R1, R1, #1
            BR      PARSE_LOOP

PARSE_BREAK LD      R2, PARSE_R2
            LD      R3, PARSE_R3
            RTI

PARSE_R2    .BLKW   #1
PARSE_R3    .BLKW   #1
NASCII_9    .FILL   x-39



            .BLKW   #6  ; stack
PRINT_INT   ; print R0 as an integer to the screen
            ; only support positive numbers
            ST      R0, PRINT_R0
            ST      R1, PRINT_R1
            ST      R2, PRINT_R2
            ST      R3, PRINT_R3

            LEA     R3, PRINT_INT
            AND     R1, R1, #0
            ADD     R3, R3, #-1
            STR     R1, R3, #0

            LD      R2, ASCII_0

PRINT_LOOP  ADD     R0, R0, #0
            BRz     PRINT_BREAK

            LD      R1, PRINT_TEN
            TRAP    x81  ; DIV
            ADD     R1, R1, R2
            ADD     R3, R3, #-1
            STR     R1, R3, #0
            BR      PRINT_LOOP

PRINT_BREAK ADD     R0, R3, #0
            PUTS

            LD      R0, PRINT_R0
            LD      R1, PRINT_R1
            LD      R2, PRINT_R2
            LD      R3, PRINT_R3
            RTI

PRINT_TEN   .FILL   #10
PRINT_R0    .BLKW   #1
PRINT_R1    .BLKW   #1
PRINT_R2    .BLKW   #1
PRINT_R3    .BLKW   #1
ASCII_0     .FILL   x30


            .END
