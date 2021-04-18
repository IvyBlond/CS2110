#ifndef MYLIB_H
#define MYLIB_H

#include "gba.h"

typeof struct Klee {
  int rowK;
  int colK;
  int life;
} Klee;

typeof struct Bomb {
  int rowB;
  int colB;
  int range;
} Bomb;

typeof struct  Fish {
  int rowF;
  int colF;
  int rd;
  int cd;
} Fish;

#endif
