                .ORIG       x3000
; Main program to set start position, call the recursive subroutine, and store the result
                LD          R0, MapBase             ; R0 holds the current cell address
                LD          R6, UserStack
                AND         R5, R5, #0
                LDI         R1, MapRow
                LDI         R3, MapColumn
                NOT         R3, R3
                ADD         R3, R3, #1
                ST          R3, NegColumn
                
                ; Calculate the total number of cells
MulLoop         BRz         EndMulti
                ADD         R5, R5, R1
                ADD         R3, R3, #1
                BR          MulLoop
EndMulti        ST          R5, MapSize             ; Noting: ST cannot change CC
                ADD         R5, R5, #0              ; R5 holds the total number of cells, counter
                
                ; Iterate the map, set the start position
SkiiLoop        BRz         EndSkii
                AND         R2, R2, 0               ; R2 holds the pedometer
                ADD         R2, R2, #1              ; reset pedometer to 1 (because we have gone 1 step)
                ADD         R4, R0, #0              ; R4 holds the current cell address
                LDR         R1, R0, #0              ; R1 holds the current cell height
                JSR         Skiing
                ADD         R0, R0, #1      
                ADD         R5, R5, #-1
                BR          SkiiLoop
                ; Store the longest distance
EndSkii         LD          R2, Longest
                HALT
                
MapRow          .FILL       x4000                   
MapColumn       .FILL       x4001
MapBase         .FILL       x4002                   ; the start address containing the map data
NegBase         .FILL       xBFFE                   ; -x4002
MapSize         .BLKW       #1
NegColumn       .BLKW       #1
Longest         .FILL       #0                      ; Global to store the longest distance
UserStack       .FILL       xFE00

; Recursive Subroutine to find the longest distance when skiing
; input: R0, the current cell address
; output: Global, the current longest distance

                ; save modified registers into the stack
Skiing          ADD         R6, R6, #-1
                STR         R1, R6, #0              ; R1 holds the cell height of caller
                ADD         R6, R6, #-1
                STR         R2, R6, #0              ; R2 holds the Pedometer
                ADD         R6, R6, #-1
                STR         R4, R6, #0              ; R4 holds the cell address of caller
                ADD         R6, R6, #-1
                STR         R5, R6, #0              ; R5 holds the main program iterative counter
                ADD         R6, R6, #-1
                STR         R7, R6, #0              ; R7 holds the PC of caller
                ; update current cell information
                ADD         R4, R0, #0              ; R4 now holds the current cell address
                LDR         R1, R0, #0              ; R1 now holds the current cell height
                ;
CHECK_NORTH     LD          R3, NegColumn
                ADD         R3, R0, R3
                LD          R7, NegBase
                ADD         R7, R7, R3
                BRn         CHECK_SOUTH             ; edge check, cannot go north: R0-MapBase-Column<0
                LDR         R5, R3, #0
                NOT         R5, R5
                ADD         R5, R5, #1
                ADD         R5, R5, R1
                BRnz        CHECK_SOUTH             ; height check, cannot go north: R1 - mem[R0-column] <= 0
                ADD         R0, R3, #0
                ADD         R2, R2, #1
                JSR         Skiing                  
                ADD         R0, R4, #0              
                ADD         R2, R2, #-1             ; restore the current address and pedometer
                ;
CHECK_SOUTH     LDI         R3, MapColumn
                ADD         R3, R0, R3
                LD          R7, MapBase
                LD          R5, MapSize
                ADD         R7, R7, R5
                NOT         R7, R7
                ADD         R7, R7, #1
                ADD         R7, R7, R3
                BRzp        CHECK_WEST              ; edge check, cannot go south: R0+Column >= MapBase+MapSize
                LDR         R5, R3, #0
                NOT         R5, R5
                ADD         R5, R5, #1
                ADD         R5, R5, R1
                BRnz        CHECK_WEST              ; height check, cannot go south: mem[R0+column] >= R1
                ADD         R0, R3, #0
                ADD         R2, R2, #1
                JSR         Skiing
                ADD         R0, R4, #0              ; restore the current address and pedometer
                ADD         R2, R2, #-1
                ;
CHECK_WEST      LD          R3, NegColumn
                LD          R7, NegBase
                ADD         R7, R7, R0
Sub1Loop        BRn         EndSub1
                ADD         R7, R7, R3
                BR          Sub1Loop
EndSub1         LDI         R3, MapColumn
                ADD         R7, R7, R3
                BRz         CHECK_EAST              ; edge check, cannot go west: R0 = MapBase+n*Column
                LDR         R5, R0, #-1
                NOT         R5, R5
                ADD         R5, R5, #1
                ADD         R5, R5, R1
                BRnz        CHECK_EAST              ; height check, cannot go west: mem[R0-1] >= R1
                ADD         R0, R0, #-1
                ADD         R2, R2, #1
                JSR         Skiing
                ADD         R0, R4, #0              ; restore the current address and pedometer
                ADD         R2, R2, #-1
                ;
CHECK_EAST      LD          R3, NegColumn
                LD          R7, NegBase
                ADD         R7, R7, R0
                ADD         R7, R7, #1
Sub2Loop        BRn         EndSub2
                ADD         R7, R7, R3
                BR          Sub2Loop
EndSub2         LDI         R3, MapColumn
                ADD         R7, R7, R3
                BRz         CmpDistance             ; edge check, cannot go east: R0 = MapBase+n*Column-1
                LDR         R5, R0, #1
                NOT         R5, R5
                ADD         R5, R5, #1
                ADD         R5, R5, R1
                BRnz        CmpDistance             ; height check, cannot go east: mem[R0+1] >= R1
                ADD         R0, R0, #1
                ADD         R2, R2, #1
                JSR         Skiing
                ADD         R0, R4, #0              ; restore the current address and pedometer
                ADD         R2, R2, #-1
                ; arrive at the lowest cell, compare the current pedometer with the longest distance
                ; if the current pedometer is larger, than update the longest
CmpDistance     LD          R3, Longest
                NOT         R3, R3
                ADD         R3, R3, #1
                ADD         R3, R3, R2              
                BRnz        RESTORE
                ST          R2, Longest
                ;
RESTORE         ADD         R0, R4, #0
                LDR         R7, R6, #0
                ADD         R6, R6, #1
                LDR         R5, R6, #0
                ADD         R6, R6, #1
                LDR         R4, R6, #0
                ADD         R6, R6, #1
                LDR         R2, R6, #0
                ADD         R6, R6, #1
                LDR         R1, R6, #0
                ADD         R6, R6, #1
                RET
                .END
                
                
               .ORIG       x4000
.fill #6
.fill #6

.fill #1
.fill #2
.fill #3
.fill #4
.fill #5
.fill #6
.fill #12
.fill #11
.fill #10
.fill #9
.fill #8
.fill #7
.fill #13
.fill #14
.fill #15
.fill #16
.fill #17
.fill #18
.fill #24
.fill #23
.fill #22
.fill #21
.fill #20
.fill #19
.fill #25
.fill #26
.fill #27
.fill #28
.fill #29
.fill #30
.fill #36
.fill #35
.fill #34
.fill #33
.fill #32
.fill #31
.fill #71
.fill #72
.fill #73
.fill #74
.fill #75
.fill #76
.fill #94
.fill #95
.fill #96
.fill #97
.fill #98
.fill #99
.fill #100
.fill #49
                .END