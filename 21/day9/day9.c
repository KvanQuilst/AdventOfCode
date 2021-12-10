///////////////
//
// Advent of Code - Day 9
// Smoke Basin
//
///////////////

#include <fcntl.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void lowpoints(void);

int main (void)
{
  lowpoints();
}

void lowpoints(void)
{
  FILE *day9;
  char *line = NULL;
  int risk, height, length, i, j;
  int **map;
  size_t len;

  day9 = fopen("day9.in", "r");
  if (day9 == NULL) {
    fprintf(stderr, "day9 won't open\n");
    exit(1);
  }

  // get sizes
  height = 0;
  length = 0;
  while (getline (&line, &len, day9) != -1) {
    if (length == 0) {
      while (line[length] >= '0' && line[length] <= '9') {
        length++;
      }
      //printf ("length = %d\n", length);
    }
    height++;
  }

  map = malloc(height * sizeof (int*));
  rewind(day9);

  // set map
  for (i = 0; i < height; i++) {
    getline (&line, &len, day9);
    map[i] = malloc (length * sizeof(int));
    for (j = 0; j < length; j++) {
      map[i][j] = line[j] - '0';
      //printf ("%d ", map[i][j]);
    }
    //printf ("\n");
  }

  // operate on map
  risk = 0;
  for (i = 0; i < height; i++) {
    for (j = 0; j < length; j++) {
      if (!(i > 0 && map[i-1][j] <= map[i][j]) &&
          !(i < height-1 && map[i+1][j] <= map[i][j]) &&
          !(j > 0 && map[i][j-1] <= map[i][j]) &&
          !(j < length-1 && map[i][j+1] <= map[i][j])) {
        risk += map[i][j]+1;
      }
    }
  }

  printf ("The sum of risk is %d\n", risk);
  fclose (day9);
}
