;;=======================================
;; CS 2110 - Spring 2020
;; HW6 - Recursive Fibonacci Sequence
;;=======================================
;; Name:
;;=======================================

;; In this file, you must implement the 'fib' subroutine.

;; Little reminder from your friendly neighborhood 2110 TA staff: don't run
;; this directly by pressing 'RUN' in complx, since there is nothing put at
;; address x3000. Instead, load it and use 'Debug' -> 'Simulate
;; Subroutine Call' and choose the 'reverseLL' label.

.orig x3000
HALT

;; Pseudocode (see PDF for explanation):
;;
;; Arguments of Fibonacci number: integer n
;;
;; Pseudocode:
;; fib(int n) {
;;     if (n == 0) {
;;         return 0;
;;     } else if (n == 1) {
;;         return 1;
;;     } else {
;;         return fib(n - 1) + fib(n - 2);
;;     }
;; }
fib

ADD R6, R6, -4 ;ALLOCATE SPACE
STR R7, R6, 2 ;SAME OLD RETURN ADDRESS
STR R5, R6, 1 ;SAVE OLD FRAME POINTER
ADD R5, R6, 0 ;SET CURRENT FRAME POINTER
ADD R6, R6, -5 ; BE REDAY TO SAVE REG
STR R0, R6, 4 ;SAVE R0
STR R1, R6, 3 ;SAVE R1
STR R2, R6, 2 ;SAVE R2
STR R3, R6, 1 ;SAVE R3
STR R4, R6, 0 ;SAVE R4

LDR R0, R5, 4 ;n TO R0
BRnp IFELSE1 ;IF N==0
  AND R0, R0, 0
  STR R0, R5, 0 ;ANSWER = 0
  BR ENDIF1
IFELSE1 LDR R0, R5, 4
        ADD R0, R0, -1 ;SET CONDITION CODE
BRnp IFELSE2 ;IF N==1
  AND R0, R0, 0
  ADD R0, R0, 1
  STR R0, R5, 0 ;ANSWER = 1
  BR ENDIF1
IFELSE2 LDR R0, R5, 4; ELSE
  ;Fibonacci(N-1)
  ADD R0, R0, -1 ;R0 = N-1
  ADD R6, R6, -1 ;PUSH N-1
  STR R0, R6, 0 ;N-1 ON THE NEW stack
  JSR fib ;Fibonacci(N-1)
  LDR R0, R6, 0 ;R0 = RETRUN value
  ADD R6, R6, 2 ;POP RV AND ARG1
  ;Fibonacci(N-2)
  LDR R1, R5, 4
  ADD R1, R1, -2 ;R1 = N-2
  ADD R6, R6, -1 ;PUSH N-1
  STR R1, R6, 0 ;N-2 ON THE NEW stack
  JSR fib ;Fibonacci(N-2)
  LDR R1, R6, 0 ;R1 = RETRUN value
  ADD R6, R6, 2 ;POP RV AND ARG1
  ;return Fibonacci(N-1) + Fibonacci(N-2)
  ADD R0, R0, R1
  STR R0, R5, 0 ;ANSWER = R0
  BR ENDIF1
ENDIF1 NOP

LDR R0, R5, 0 ;RETURN VALUE = ANSWER
STR R0, R5, 3 ;STORE RETRUN VALUE TO RETURN
LDR R4, R5, -5 ;RESTORE R4
LDR R3, R5, -4 ;RESTORE R3
LDR R2, R5, -3 ;RESTORE R2
LDR R1, R5, -2 ;RESTORE R1
LDR R0, R5, -1 ;RESTORE R0
ADD R6, R5, 0 ;REDTORE STACK POINTER
LDR R5, R6, 1 ;RESTORE FRAME POINTER
LDR R7, R6, 2 ;RESTORE RETRUN ADDRESS
ADD R6, R6, 3 ;POP SP, FP, RA

RET

;; used by the autograder
STACK .fill xF000
.end
