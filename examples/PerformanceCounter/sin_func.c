/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

#include "sys/alt_stdio.h"
#include <math.h>
#include "PerformanceCounter.h"

void plotValue(int l, float v, float r)
{
	int ir = r;
	int iv = ir + v;
	int i;

	printf("[%d] ", l);
	for (i=0; i < iv; i++)
		printf(" ");

	printf("*\n");
}


int main()
{ 
  alt_putstr("Hello from Nios II!\n");

  int i=0;
  float t = 0;
  float r = 20;
  float inc = 3.1415 /  10;
  float x;

  alt_putstr("Variables initialized\n");

  uint64  t0, tf;

  t0 = perfCounter();
  for (i=0; i < 20; i++)
  {
	  x = sin(t) * r;

	  //plotValue(i, x, r);

	  t += inc;
  }

  tf = perfCounter();

  printLap(t0, tf);

  while (1);

  return 0;
}

