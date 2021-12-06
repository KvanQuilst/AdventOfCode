///////////////
//
// Advent of Code - Day 6
// Lanternfish
//
///////////////

#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void gen(int input[], int size, int days);

int main (void)
{
  int input[300] = {5,1,5,3,2,2,3,1,1,4,2,4,1,2,1,4,1,1,5,3,5,1,5,3,1,2,4,4,1,1,3,1,1,3,1,1,5,1,5,4,5,4,5,1,3,2,4,3,5,3,5,4,3,1,4,3,1,1,1,4,5,1,1,1,2,1,2,1,1,4,1,4,1,1,3,3,2,2,4,2,1,1,5,3,1,3,1,1,4,3,3,3,1,5,2,3,1,3,1,5,2,2,1,2,1,1,1,3,4,1,1,1,5,4,1,1,1,4,4,2,1,5,4,3,1,2,5,1,1,1,1,2,1,5,5,1,1,1,1,3,1,4,1,3,1,5,1,1,1,5,5,1,4,5,4,5,4,3,3,1,3,1,1,5,5,5,5,1,2,5,4,1,1,1,2,2,1,3,1,1,2,4,2,2,2,1,1,2,2,1,5,2,1,1,2,1,3,1,3,2,2,4,3,1,2,4,5,2,1,4,5,4,2,1,1,1,5,4,1,1,4,1,4,3,1,2,5,2,4,1,1,5,1,5,4,1,1,4,1,1,5,5,1,5,4,2,5,2,5,4,1,1,4,1,2,4,1,2,2,2,1,1,1,5,5,1,2,5,1,3,4,1,1,1,1,5,3,4,1,1,2,1,1,3,5,5,2,3,5,1,1,1,5,4,3,4,2,2,1,3};

  int test[5] = {3,4,3,1,2};

  gen(input, 300, 256);
  return 0;
}

void gen(int input[], int size, int days)
{
  long dayarr[9] = {0};
  int i;
  long tmp, sum = 0;

  for (i = 0; i < size; i++) {
    dayarr[input[i]] += 1;
  }

  for (i = 0; i < days; i++) {
    tmp = dayarr[0];
    dayarr[0] = dayarr[1];
    dayarr[1] = dayarr[2];
    dayarr[2] = dayarr[3];
    dayarr[3] = dayarr[4];
    dayarr[4] = dayarr[5];
    dayarr[5] = dayarr[6];
    dayarr[6] = tmp + dayarr[7];
    dayarr[7] = dayarr[8];
    dayarr[8] = tmp;
  }

  for (i = 0; i < 9; i++) {
    sum += dayarr[i];
  }

  printf ("The number of fish after day %d is %ld\n", days, sum);
}
