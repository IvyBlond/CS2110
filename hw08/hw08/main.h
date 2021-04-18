#ifndef MAIN_H
#define MAIN_H

#include "gba.h"

// TODO: Create any necessary structs

/*
* For example, for a Snake game, one could be:
*
* struct snake {
*   int heading;
*   int length;
*   int row;
*   int col;
* };
*
* Example of a struct to hold state machine data:
*
* struct state {
*   int currentState;
*   int nextState;
* };
*
*/

typedef struct KleeS {
  int rowK;
  int colK;
  int life;
} KleeS;

typedef struct BombS {
  int rowB;
  int colB;
  int range;
} BombS;

typedef struct fishS {
  int rowF;
  int colF;
  int rd;
  int cd;
} fishS;

#endif
