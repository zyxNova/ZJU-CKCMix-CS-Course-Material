            .ORIG   x3000
            LEA     R0, Prompt                  ; print "Enter a name: " on the monitor
            PUTS                                
; Input the name
            LEA     R1, NAME                    ; R1, ptr of input string
Input       GETC
            OUT                                 ; echo on the monitor
            LD      R2, Enter
            NOT     R2, R2                      
            ADD     R2, R2, #1                  
            ADD     R2, R2, R0                  ; test whether the current char is '\n'
            BRz     StopInput                   ; '\n' indicates the end of input
            STR     R0, R1, #0                  
            ADD     R1, R1, #1                  
            BR      Input                       ; read next char
StopInput   AND     R1, R1, #0                  ; add '\0' to the end of string
; Search in the Linked List
            LDI     R1, Node0                   ; R1, ptr of Linkedlist, containing the address of Node's first word
LOOP        BRz     StopSearch                  ; if R1 == x0000, R1 points to NULL, which is the end of Linkedlist
            LDR     R2, R1, #2                  ; R2, ptr of fisrtname or lastname, containing the address of string's first char
            LEA     R4, NAME                    ; R4, ptr of input
            JSR     Compare                     ; identify whether firstname is equal to input
            ADD     R0, R6, #0                  ; R0 = 1 if FIRST name match, else = 0.
            
            LDR     R2, R1, #3
            JSR     Compare                     ; compare lastname and input. R6 = 1 if LAST name match, else = 0
            AND     R2, R0, R6                  
            BRp     BothMatch                   ; fisrtname is identical to lastname
            ADD     R0, R0, #0
            BRp     OneMatch
            ADD     R6, R6, #0
            BRp     OneMatch
            BRnzp   NextLoop
;
OneMatch    AND     R0, R0, #0                  
            ST      R0, FLAG                    ; set FLAG = 0 to indicates Found
; Output with format
            LDR     R0, R1, #2
            PUTS        
            LD      R0, Space
            OUT
BothMatch   AND     R0, R0, #0                  
            ST      R0, FLAG                    ; set FLAG = 0 to indicates Found
            LDR     R0, R1, #3
            PUTS   
            LD      R0, Space
            OUT
            LDR     R0, R1, #1
            PUTS
            LD      R0, Enter
            OUT
;
NextLoop    LDR     R1, R1, #0                  ; Load the next Node to R1
            BR      LOOP
; Check whether or not found yet
StopSearch  LD      R0, FLAG
            BRz     NEXT
            LEA     R0, NotFound
            PUTS
NEXT        HALT
; Subroutine to find whether string A is equal to B
; R3 = mem[R2], R5 = mem[R4]
Compare     ST      R4, Save4
            AND     R6, R6, #0
            ADD     R6, R6, #1                  
AGAIN       LDR     R3, R2, #0                  ; test whether name string is end
            BRz     Test
            LDR     R5, R4, #0                  ; test whether input string is end
            BRz     NotMatch
            NOT     R5, R5
            ADD     R5, R5, #1                  ; cmp name with input
            ADD     R5, R5, R3
            BRnp    NotMatch
            ADD     R2, R2, #1                  ; ptr++
            ADD     R4, R4, #1
            BRnzp   AGAIN
Test        LDR     R5, R4, #0
            BRz     EndCmp
NotMatch    AND     R6, R6, #0
EndCmp      LD      R4, Save4
            RET
; .FILL LABEL means initialize the next location with the address of LABEL
Prompt      .STRINGZ "Enter a name: "
NotFound    .STRINGZ "Not found"
Enter       .FILL x000A
Space       .FILL x0020
Node0       .FILL x4000
FLAG        .FILL x0001                         ; Found if FLAG = 0, else FLAG != 0
Save4       .BLKW 1
NAME        .BLKW 16
            .END