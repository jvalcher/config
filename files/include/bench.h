
/*
 *  measure program execution duration
 *  -----------------
 *
 *  Usage:
 *
 *      double begin = bench_begin ();
 *      ...
 *      bench_end (begin);
 *
 *
 */

#include <stdio.h>
#include <time.h>           // clock_t, clock(), CLOCKS_PER_SEC
#include <unistd.h>         // sleep()


double bench_begin ()
{
    clock_t begin = clock();
    return begin;
}

double bench_end (double begin) 
{
    clock_t end = clock();
    double time_sec = 0.0;
    double time_msec = 0.0;

    time_sec += (double)(end-begin) / CLOCKS_PER_SEC;
    time_msec += (double)(end-begin) / (CLOCKS_PER_SEC / 1000);

    printf("\n---------------\n"
             "Execution time:\n"
             "---------------\n"
             "     Seconds: \t%f\n"
             "Milliseconds: \t%f\n"
             "---------------\n\n", time_sec, time_msec);

}

