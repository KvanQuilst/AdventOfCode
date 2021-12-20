///////////////
//
// Advent of Code - Day 15
// Chiton
//
///////////////

#include <fcntl.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void tlbr(void);
int minRiskPath(int **map, int l, int i, int j);

int main (void)
{
  tlbr();
}

void tlbr(void)
{
  FILE *day15;
  char *line = NULL;
  size_t len;

  int risk, l, i, j;
  int **map, *dist;

  day15 = fopen("day15.in", "r");
  if (day15 == NULL) {
    fprintf(stderr, "day15 won't open\n");
    exit(1);
  }

  // get map size
  l = 0;
  while (getline (&line, &len, day15) != -1) {
    l++;
  }

  map = malloc(l * sizeof(int*));
  rewind(day15);

  // fill the map
  for (i = 0; i < l; i++) {
    getline(&line, &len, day15);
    map[i] = malloc(l * sizeof(int));
    for (j = 0; j < l; j++) {
      map[i][j] = line[j] - '0';
    }
  }

  risk = minRiskPath(map, l, 0, 0) - map[0][0];

  printf("The minimum risk path total is %d\n", risk);
  fclose(day15);
}

int minRiskPath(int **map, int l, int i, int j)
{
  int risk = 0, d, r;
  if (i == l-1 && j == l-1) {
    return map[i][j];
  }

  if (i == l-1) {
    return map[i][j] + minRiskPath(map, l, i, j+1);
  }

  if (j == l-1) {
    return map[i][j] + minRiskPath(map, l, i+1, j);
  }
  
  d = map[i][j] + minRiskPath(map, l, i+1, j);
  r = map[i][j] + minRiskPath(map, l, i, j+1);

  return d < r ? d : r;  
}
