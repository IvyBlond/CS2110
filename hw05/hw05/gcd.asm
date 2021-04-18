;;=============================================================
;; CS 2110 - Spring 2021
;; Homework 5 - Iterative GCD
;;=============================================================
;; Name: Qingyu Chen
;;=============================================================

;; Pseudocode (see PDF for explanation):
;;
;; a = (argument 1);
;; b = (argument 2);
;; ANSWER = 0;
;;
;; while (a != b) {
;;   if (a > b) {
;;     a = a - b;
;;   } else {
;;     b = b - a;
;;   }
;; }
;; ANSWER = a;

.orig x3000

;R0 for a, R1 FOR B, R2 FOR ANSWER
;SET ANSWER TO 0
AND R2, R2, 0
;LOAD VALUE TO A AND B
LD R0, A
LD R1, B

WHILE NOT R3, R1
ADD R3, R3, 1; B = -B
ADD R3, R3, R0
BRz ENDW ;IF A = B, END WHILE
  ADD R3, R3, 0 ;RESET CONDITIONAL CODE
  BRn ELSE ;IF A>B
    NOT R3, R1
    ADD R3, R3, 1 ;R3 = -B
    ADD R0, R0, R3 ;A = A-B
  BR ENDIF
  ELSE NOP
    NOT R3, R0
    ADD R3, R3, 1 ;R3 = -A
    ADD R1, R1, R3; B = B-A
  ENDIF NOP
BR WHILE
ENDW NOP
ADD R2, R0, #0 ;ANSWER = A
ST R2, ANSWER ; STORE IN ANSWER

HALT

A .fill 20
B .fill 19

ANSWER .blkw 1

.end
