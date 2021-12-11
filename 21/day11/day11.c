///////////////
//
// Advent of Code - Day 11
// Dumbo Octopus
//
///////////////

#include <fcntl.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void flashes(int steps);
int flash(int octo[10][10], int i, int j);

int main (void)
{
  flashes(100);
}

void flashes(int steps)
{
  FILE *day11;
  char *line = NULL;
  size_t len;

  int octo[10][10];
  int i, j, k, flashes;

  day11 = fopen("day11.in", "r");
  if (day11 == NULL) {
    fprintf(stderr, "day11 won't open!\n");
    exit(1);
  }

  // fill octo map
  for (i = 0; i < 10; i++) {
    if (getline(&line, &len, day11) == -1) {
      fprintf(stderr, "input isn't big enough!\n");
      exit(1);
    }

    for (j = 0; j < 10; j++) {
      octo[i][j] = line[j] - '0';
    }
  }

  flashes = 0;
  for (k = 0; k < steps; k++) {
   
    // increment by 1
    for (i = 0; i < 10; i++) {
      for (j = 0; j < 10; j++) {
        octo[i][j]++;
      }
    }

    // look for flashes
    for (i = 0; i < 10; i++) {
      for (j = 0; j < 10; j++) {
        if (octo[i][j] > 9) {
          flashes += flash(octo, i, j);
        }
      }
    }

    // reset flashes to 0
    for (i = 0; i < 10; i++) {
      for (j = 0; j < 10; j++) {
        if (octo[i][j] == -1) {
          octo[i][j] = 0;
        }
  //      printf("%d ", octo[i][j]);
      }
   //   printf("\n");
    }
    //printf("\n");
  }

  printf("The total number of flashes in %d steps is %d\n", steps, flashes);
  fclose(day11);
}

int flash(int octo[10][10], int i, int j)
{
  int sum = 0;
  if (octo[i][j] == -1) {
    return 0;
  } else if (octo[i][j] < 9) {
    octo[i][j]++;
    return 0;
  }
  octo[i][j] = -1;
          printf ("(%d, %d)\n", i, j);
  sum++;

  if (i > 0) {
    sum += flash (octo, i-1, j);
  }
  if (i < 9) {
    sum += flash (octo, i+1, j);
  }
  if (i > 0 && j > 0) {
    sum += flash (octo, i-1, j-1);
  }
  if (i > 0 && j < 9) {
    sum += flash(octo, i-1, j+1);
  }
  if (i < 9 && j > 0) {
    sum += flash(octo, i+1, j-1);
  }
  if (i < 9 && j < 9) {
    sum += flash (octo, i+1, j+1);
  }
  if (j > 0) {
    sum += flash(octo, i, j-1);
  }
  if (j < 9) {
    sum += flash(octo, i, j+1);
  }
  return sum;
}
