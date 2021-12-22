///////////////
//
// Advent of Code - Day 22
// Reactor Reboot
//
///////////////

#include <fcntl.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void part1(void);
void convertLine(char*, int*, int*, int*, int*, int*, int*);
int countOn(int ***reactor, int xl, int yl, int zl);

int main (void)
{
  part1();
}

void part1(void)
{
  FILE *day22;
  char *line = NULL;
  size_t len;

  int ***reactor;
  int i, j, k, onoff;
  int x0, x1, y0, y1, z0, z1;
  char *trash;

  day22 = fopen("day22.in", "r");
  if (day22 == NULL) {
    fprintf(stderr, "day22 won't open\n");
    exit(1);
  }

  // prepare reactor
  reactor = malloc (101 * sizeof(int**));
  for (i = 0; i < 101; i++) {
    reactor[i] = malloc (101 * sizeof(int*));
    for (j = 0; j < 101; k++) {
      reactor[i][j] = malloc (101 * sizeof(int));
      for (k = 0; k < 101; k++) {
        reactor[i][j][k] = 0; 
      }
    }
  }
/*
  // run instructions
  while (getline(&line, &len, day22) != -1) {
    convertLine(line, &x0, &x1, &y0, &y1, &z0, &z1);
    onoff = !strncmp(line, "on", 2);
    for (i = x0; i <= x1; i++) {
      for (j = y0; j <= y1; j++) {
        for (k = z0; k <= z1; k++) {
          reactor[i][j][k] = onoff;
        }
      }
    }
  } */
  fclose(day22);
}

void convertLine(char *line, int *x0, int *x1,
                 int *y0, int *y1, int *z0, int *z1)
{
  int i = 0;

  // x=
  while (line[i] != '=')
    i++;
  *x0 = atoi(&line[i+1])+50;

  // x=n..
  while (line[i] != '.')
    i++;
  *x1 = atoi(&line[i+2])+50;

  // y=
  while (line[i] != '=')
    i++;
  *y0 = atoi(&line[i+1])+50;

  // y=n..
  while (line[i] != '.')
    i++;
  *y1 = atoi(&line[i+2])+50;

  // z=
  while (line[i] != '=')
    i++;
  *z0 = atoi(&line[i+1])+50;

  // z=n..
  while (line[i] != '.')
    i++;
  *z1 = atoi(&line[i+2])+50;

  printf("%d %d %d %d %d %d\n", *x0, *x1, *y0, *y1, *z0, *z1);
}

int countOn(int ***reactor, int xl, int yl, int zl)
{

}
