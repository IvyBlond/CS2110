;;=============================================================
;; CS 2110 - Fall 2021
;; Homework 5 - Studly Caps!
;;=============================================================
;; Name: Qingyu Chen
;;=============================================================

;; Pseudocode (see PDF for explanation)
;;
;; string = "TWENTY 1 ten";
;; i = 0;
;; while (string[i] != 0) {
;;   if (i % 2 == 0) {
;;   // should be lowercase
;;     if ('A' <= string[i] <= 'Z') {
;;       string[i] = string[i] | 32;
;;     }
;;   } else {
;;   // should be uppercase
;;     if ('a' <= string[i] <= 'z') {
;;       string[i] = string[i] & ~32;
;;     }
;;   }
;;   i++;
;; }

.orig x3000

;R0 for i
AND R0, R0, 0; SET I TO ZERO
;R1 for string ADDRESS
LD R1, STRING

;R7 FOR -64
AND R7, R7, 0 ;CLEAR R7
ADD R7, R7, -16; R7 = -16
ADD R7, R7, R7; R7 = -32
ADD R7, R7, R7; R7 = -64

;R6 FOR -96
AND R6, R6, 0; CLREAR R6
ADD R6, R6, -16; R6 = -16
ADD R6, R6, R6; R6 = -32
ADD R6, R6, R7; R6 = -96



WHILE ADD R2, R1, R0 ;ADDRESS OF LETTER
LDR R2, R2, 0 ;R2 = STRING[I]
BRz ENDW ;WHILE
  AND R3, R3, 0 ;CLEAR R3 (R3=0)
  ADD R3, R3, 1 ;R3 = 1
  AND R2, R0, R3; KEEP THE LAST PLACE OF STRING[I]
  BRp ELSE1 ;IF ZERO(CAN BE DIVIDED BY 2)
    ADD R2, R1, R0 ;ADDRESS OF LETTER
    LDR R2, R2, 0 ;R2 = STRING[I]
    ADD R3, R7, -1 ;R3 = - 'A'
    ADD R3, R2, R3 ;R3 = R2 - 'A'
    BRn ENDIF2 ;IF LETTER IS LARGER OR EQUAL TO A
    ADD R3, R7, -16 ;R3 = - 80
    ADD R3, R3, -10 ;R3 = - 'Z'
    ADD R3, R2, R3 ;R3 = R2 - 'Z'
    BRp ENDIF2 ;IF LETTER IS SMALLER OR EQUAL TO Z
      AND R3, R3, 0; R3 = 0 (CLEARED)
      ADD R3, R3, 15 ;R3 = 15
      ADD R3, R3, 15 ;R3 = 30
      ADD R3, R3, 2 ;R3 = 32
      NOT R3, R3 ;R3 IS NEGATE 32
      NOT R4, R2 ;R4 IS THE NEGATE OF THE LETTER
      AND R2, R4, R3 ;R2 = NEGATE32 AND NEGATE LETTER
      NOT R2, R2 ;R2 = LETTER|32
      ADD R3, R1, R0 ;R3 = ADDRESS OF THE LETTER
      STR R2, R3, 0 ;STRING[I] = STING[I] | 32
    ENDIF2 NOP
  BR ENDIF1
  ELSE1 ;iF POSITIVE (CANNOT BE DIVEDED BY 2)
    ADD R2, R1, R0 ;ADDRESS OF LETTER
    LDR R2, R2, 0 ;R2 = STRING[I]
    ADD R3, R6, -1 ;R3 = -'a'
    ADD R3, R2, R3 ;R3 = R2 -'a'
    BRn ENDIF3 ;IF LETTER IS LARGER OR EQUAL TO a
    ADD R3, R6, -16 ;R3 = - 112
    ADD R3, R3, -10 ;R3 = - 'z'
    ADD R3, R2, R3 ;R3 = R2 - 'z'
    BRp ENDIF3 ;IF LETTER IS SMALLER OR EQUAL TO Z
      AND R3, R3, 0; R3 = 0 (CLEARED)
      ADD R3, R3, 15 ;R3 = 15
      ADD R3, R3, 15 ;R3 = 30
      ADD R3, R3, 2 ;R3 = 32
      NOT R3, R3 ;R3 IS NEGATE 32
      AND R2, R2, R3 ;R2 = NEGATE32 AND LETTER
      ADD R3, R1, R0 ;R3 = ADDRESS OF THE LETTER
      STR R2, R3, 0 ;STRING[I] = STING[I] & ^32
    ENDIF3 NOP
  ENDIF1 NOP
  ADD R0, R0, 1 ;I++
BR WHILE
ENDW NOP
HALT

UPPERA .fill x41    ;; A in ASCII
UPPERZ .fill x5A	;; Z in ASCII
LOWERA .fill x61	;; a in ASCII
LOWERZ .fill x7A	;; z in ASCII

STRING .fill x4000
.end

.orig x4000
.stringz "TWENTY ONE TEN"
.end
