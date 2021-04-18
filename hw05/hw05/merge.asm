;;=============================================================
;; CS 2110 - Spring 2020
;; Homework 5 - Array Merge
;;=============================================================
;; Name: Qingyu Chen
;;=============================================================

;; Pseudocode (see PDF for explanation):
;;
;; x = 0;
;; y = 0;
;; z = 0;
;; while (x < LENGTH_X && y < LENGTH_Y) {
;;   if (ARR_X[x] <= ARR_Y[y]) {
;;     ARR_RES[z] = ARR_X[x];
;;     z++;
;;     x++;
;;   } else {
;;     ARR_RES[z] = ARR_Y[y];
;;     z++;
;;     y++;
;;   }
;; }
;; while(x < ARRX.length) {
;;   ARR_RES[z] = ARR_X[x];
;;   z++;
;;   x++;
;; }
;; while (y < ARRY.length) {
;;   ARR_RES[z] = ARR_Y[y];
;;   z++;
;;   y++;
;; }



.orig x3000

;R0 for x, R1 for y, R2 for z
;set xyz to zero
AND R0, R0, 0 ;X
AND R1, R1, 0 ;Y
AND R2, R2, 0 ;Z

;R3 for ARR_X, R4 for ARR_Y, R5 for ARR_RES
LD R3, ARR_X ;ARR_X
LD R4, ARR_Y ;ARR_Y
LD R5, ARR_RES ;ARR_RES


WHILE1  LD R6, LENGTH_X
NOT R6, R6 ;ARR
ADD R6, R6, 1 ;R6 = -LENGTH_X
ADD R6, R6, R0 ;R6 = X - LENGTH_X
BRzp ENDW1 ;X < LENGTH_X, WHILE1

LD R6, LENGTH_Y
NOT R6, R6
ADD R6, R6, 1 ;R6 = -LENGTH_Y
ADD R6, R6, R1 ;R6 = Y - LENGTH_Y
BRzp ENDW1 ;Y<LENGTH_Y, WHILE1

  ADD R6, R3, R0
  LDR R6, R6, 0 ;R6 = ARR_X[X]
  ADD R7, R4, R1;
  LDR R7, R7, 0 ;R7 = ARR_Y[Y]
  NOT R7, R7
  ADD R7, R7, 1
  ADD R6, R6, R7 ;R6 = ARR_X[X] - ARR_Y[Y]
  BRp ELSE ;IF
    ADD R6, R3, R0
    LDR R6, R6, 0 ;R6 = ARR_X[X]
    ADD R7, R5, R2 ;R7 IS THE ADDRESS OF ARR_RES[Z]
    STR R6, R7, 0 ;ARR_RES[z] = ARR_X[x]
    ADD R2, R2, 1 ;Z++
    ADD R0, R0, 1 ;X++
  BR ENDIF ;END IF

  ELSE NOP ;ELSE
    ADD R6, R4, R1
    LDR R6, R6, 0 ;R6 = ARR_Y[Y]
    ADD R7, R5, R2 ;R7 IS THE ADDRESS OF ARR_RES[Z]
    STR R6, R7, 0 ;ARR_RES[z] = ARR_Y[Y]
    ADD R2, R2, 1 ;Z++
    ADD R1, R1, 1 ;Y++
  ENDIF NOP

BR WHILE1
ENDW1 NOP


WHILE2  LD R6, LENGTH_X
NOT R6, R6
ADD R6, R6, 1 ;R6 = -LENGTH_X
ADD R6, R6, R0 ;R6 = X - LENGTH_X
BRzp ENDW2 ;X < LENGTH_X, WHILE2
  ADD R6, R3, R0
  LDR R6, R6, 0 ;R6 = ARR_X[X]
  ADD R7, R5, R2 ;R7 IS THE ADDRESS OF ARR_RES[Z]
  STR R6, R7, 0 ;ARR_RES[z] = ARR_X[x]
  ADD R2, R2, 1 ;Z++
  ADD R0, R0, 1 ;X++
BR WHILE2
ENDW2 NOP

WHILE3  LD R6, LENGTH_Y
NOT R6, R6
ADD R6, R6, 1 ;R6 = -LENGTH_Y
ADD R6, R6, R1 ;R6 = Y - LENGTH_Y
BRzp ENDW3 ;Y < LENGTH_Y, WHILE3
  ADD R6, R4, R1
  LDR R6, R6, 0 ;R6 = ARR_Y[Y]
  ADD R7, R5, R2 ;R7 IS THE ADDRESS OF ARR_RES[Z]
  STR R6, R7, 0 ;ARR_RES[Z] = ARR_Y[Y]
  ADD R2, R2, 1 ;Z++
  ADD R1, R1, 1 ;Y++
BR WHILE3
ENDW3 NOP

HALT

ARR_X      .fill x4000
ARR_Y      .fill x4100
ARR_RES    .fill x4200

LENGTH_X   .fill 5
LENGTH_Y   .fill 7
LENGTH_RES .fill 12

.end

.orig x4000
.fill 1
.fill 5
.fill 10
.fill 11
.fill 12
.end

.orig x4100
.fill 3
.fill 4
.fill 6
.fill 9
.fill 15
.fill 16
.fill 17
.end
