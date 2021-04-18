;;=============================================================
;; CS 2110 - Fall 2020
;; Homework 5 - Palindrome
;;=============================================================
;; Name: Qingyu Chen
;;=============================================================

;; Pseudocode (see PDF for explanation):
;;
;; string = "racecar";
;; len = 0;
;;
;; // to find the length of the string
;; while (string[len] != '\0') {
;;   len = len + 1;
;; }
;;
;; // to check whether the string is a palindrome
;; result = 1;
;; i = 0;
;; while (i < length) {
;;   if (string[i] != string[length - i - 1]) {
;;     result = 0;
;;     break;
;;   }
;;   i = i + 1;
;; }

.orig x3000

AND R0, R0, 0 ;R0 FOR len
LD R1, STRING ;R1 FOR string

WHILE1 ADD R7, R1, R0 ;ADDRESS OF LETTER
LDR R7, R7, 0 ;R2 = STRING[I]
BRz ENDW1 ;WHILE
  ADD R0, R0, 1 ;LEN++
BR WHILE1
ENDW1 NOP

AND R2, R2, 0;CLEAR R2
ADD R2, R2, 1;R2 FOR result (DEFAULT AS 1)
AND R3, R3, 0 ;R3 AS I

WHILE2 NOT R7, R0
ADD R7, R7, 1 ;R7 = -len
ADD R7, R7, R3 ;R7 = I - len
BRzp ENDW2
  ADD R7, R3, R1 ;R7 = ADDRESS OF STRING[I]
  LDR R6, R7, 0 ;R6 = STRING[I]
  NOT R7, R3 ;R7 = -I-1
  ADD R7, R7, R0 ;R7 = LEN-I-1
  ADD R7, R7, R1 ;R7 = ADDRESS OF STRING[LEN - I - 1]
  LDR R7, R7, 0 ;R7 = STRING[LEN - I - 1]
  NOT R7, R7
  ADD R7, R7, 1; R7 = -STRING[LEN - I - 1]
  ADD R7, R6, R7; R7 = STRING[I] - STRING[LEN - I - 1]
  BRz ENDIF; IF STRING[I] - STRING[LEN - I - 1] != 0
    AND R2, R2, 0; RESULT IS 0
    BR ENDW2
  ENDIF NOP
  ADD R3, R3, 1 ;I++
BR WHILE2
ENDW2 NOP
ST R2, ANSWER
HALT

ANSWER .blkw 1
STRING .fill x4000
.end

.orig x4000
.stringz "racecar"
.end
