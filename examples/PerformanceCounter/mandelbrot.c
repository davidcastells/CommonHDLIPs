/**
 *
 * Copyright (C) 2008 David Castells i Rufas (david.castells@uab.cat)
 *
 *	OVERVIEW:
 *	=========
 *	Simple sequential Mandelbrot Set calculation and visualization through
 *	ASCII Art
 */
#include <math.h>
#include <stdio.h>
#include <time.h>
#include "PerformanceCounter.h"

int max_iteration = 10000;
 
// Lookup table for our ASCII Art
char* lut =   " .-:o*B#";

double ymin = -1;
double ymax = 1;
double xmin = -2;
double xmax = 1;

double divx = 128;
double divy = 64*2/3;
int results[128*42];


/**
 *	Print the result nicely
 */
void plot(double x, double y, int color)
{
	static double lasty = -10000;

	if (lasty != y)
		printf("\n");

	color = (int) ((double) color * 256.0 / (double) max_iteration);
	
	printf("%c", lut[1+color*6/256]); 

	lasty = y;
	
}


/**
 *	Stores a computed point of the mandelbrot set in the results array
 *	for later visualization
 */
void putResult(double x0, double y0, int v)
{
	double incx = (xmax-xmin) / divx;
	double incy = (ymax-ymin) / divy;
	int x = ((x0 - xmin) / incx);
	int y = ((y0 - ymin) / incy);

	int index = y*((int)divx)+x;
	
	results[index] = v;

}

/**
 *	Computes a point of the mandelbrot set
 */
void computePoint(double x0, double y0)
{
	double x = x0; // x co-ordinate of pixel
	double y = y0; // y co-ordinate of pixel

	int iteration = 0;
	int colour;
  
	while ( (x*x + y*y < (2*2))  &&  (iteration < max_iteration) ) 
	{
		double xtemp = x*x - y*y + x0;
		double ytemp = 2*x*y + y0;
		
		x = xtemp;
		y = ytemp;
		
		iteration = iteration + 1;
	}
	
	if ( iteration == max_iteration ) 
		colour = max_iteration;
	else
		colour = iteration;
	
	putResult(x0, y0, colour);
	
}


/**
 *	Mandelbrot set computation
 */
int main()
{
	uint64 t0, tf;
	
	t0 = perfCounter();
	float x;
	float y;
	
	printf("Generating a mandelbrot set %dx%d (%d iterations)",  (int) divx, (int) divy, max_iteration);
	for (y=ymin; y<=ymax; y+= (ymax-ymin)/divy)
		for (x=xmin; x<=xmax; x+= (xmax-xmin)/divx)
			computePoint(x, y);
		
	tf = perfCounter();
	int iy,ix;
	
	for (iy=0; iy < 42; iy++)
		for (ix=0; ix < 128; ix++)
			plot(ix, iy, results[iy*128+ix]);
	
	printf("\n");
			
	double diff = (end - start) /  (double) CLOCKS_PER_SEC;
	printLap(t0, tf);
}
