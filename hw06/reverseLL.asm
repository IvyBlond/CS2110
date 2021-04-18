;;=============================================================
;; CS 2110 - Spring 2020
;; Homework 6 - Reverse Linked List
;;=============================================================
;; Name:
;;============================================================

;; In this file, you must implement the 'reverseLL' subroutine.

;; Little reminder from your friendly neighborhood 2110 TA staff: don't run
;; this directly by pressing 'RUN' in complx, since there is nothing put at
;; address x3000. Instead, load it and use 'Debug' -> 'Simulate
;; Subroutine Call' and choose the 'reverseLL' label.

.orig x3000
HALT

;; Pseudocode (see PDF for explanation):
;;
;; Arguments of reverseLL: Node head
;;
;; reverseLL(Node head) {
;;     // note that a NULL address is the same thing as the value 0
;;     if (head == NULL) {
;;         return NULL;
;;     }
;;     if (head.next == NULL) {
;;         return head;
;;     }
;;     Node tail = head.next;
;;     Node newHead = reverseLL(tail);
;;     tail.next = head;
;;     head.next = NULL;
;;     return newHead;
;; }
reverseLL


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

LDR R0, R5, 4 ;load HEAD NODE INTO R0
BRnp ENDIF1 ;IF HEAD == NULL
  AND R0, R0, 0
  STR R0, R5, 0 ;ANSWER = NULL
  BR ENDIF
ENDIF1 LDR R0, R5, 4
LDR R0, R0, 0 ;LOAD HEAD.NEXT INTO R0
BRnp ENDIF2 ;IF HEAD.NEXT == NULL
  LDR R0, R5, 4 ;LOAD HEAD INTO R0
  STR R0, R5, 0 ;ANSWER = head
  BR ENDIF

ENDIF2 LDR R0, R5, 4
LDR R0, R0, 0 ;LOAD HEAD.NEXT INTO R0, R0 = TAIL
ADD R6, R6, -1 ;DECREMENT R6
STR R0, R6, 0 ;STORE FIRST Argument
JSR reverseLL ;reverseLL(HEAD.NEXT)
LDR R1, R6, 0 ;R1 = RETURN value = newHead
ADD R6, R6, 3 ;POP RV AND ARGUMENT1
LDR R2, R5, 4 ;LOAD HEAD INTO R2
STR R2, R0, 0 ;TAIL.NEXT = head
AND R3, R3, 0 ; R3 = NULL
STR R3, R2, 0 ;HEAD.NEXT = NULL
STR R1, R5, 0 ;ANSWER = newHead

ENDIF NOP

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

;; The following is an example of a small linked list that starts at x4000.
;;
;; The first number (offset 0) contains the address of the next node in the
;; linked list, or zero if this is the final node.
;;
;; The second number (offset 1) contains the data of this node.
.orig x4000
.fill x4008
.fill 5
.end

.orig x4008
.fill x4010
.fill 12
.end

.orig x4010
.fill 0
.fill -7
.end
