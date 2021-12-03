/////////////////
//
// Advent of Code 2021 - Day 2
// Dive!
//
/////////////////

#include <fcntl.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void movement(void);
void movementAdv(void);

int main (void)
{
  movement();
  printf("\n");
  movementAdv();
  exit(0);
}

void movement(void)
{
  FILE *day2;
  char *line = NULL;
  int read, depth, horz, x;
  size_t len;

  day2 = fopen("day2.in", "r");
  if (day2 == NULL) {
    fprintf(stderr, "day2 won't open\n");
    exit(1);
  }
  
  depth = 0;
  horz = 0;
  while ((read = getline (&line, &len, day2)) != -1) {
    if (strncmp(line, "up", 2) == 0) {
      depth -= atoi(&line[3]);
    } else if (strncmp(line, "down", 4) == 0) {
      depth += atoi(&line[5]);
    } else if (strncmp(line, "forward", 7) == 0) {
      horz += atoi(&line[8]);
    } else {
      fprintf (stderr, "should never reach this point!\n");
      exit(1);
    }
  }

  printf ("The depth is %d\n", depth);
  printf ("The horizontal is %d\n", horz);
  printf ("The horizontal and depth multiplied is %d\n", depth * horz);
  fclose (day2);
}

void movementAdv(void)
{
  FILE *day2;
  char *line = NULL;
  int read, depth, horz, aim, x;
  size_t len;

  day2 = fopen("day2.in", "r");
  if (day2 == NULL) {
    fprintf(stderr, "day2 won't open\n");
    exit(1);
  }

  depth = 0;
  horz = 0;
  aim = 0;
  while ((read = getline(&line, &len, day2)) != -1) {
      if (strncmp(line, "up", 2) == 0) {
        aim -= atoi(&line[3]); 
      } else if (strncmp(line, "down", 4) == 0) {
        aim += atoi(&line[5]);
      } else if (strncmp(line, "forward", 7) == 0) {
        x = atoi(&line[8]);
        horz += x;
        depth += aim * x;
      } else {
        fprintf (stderr, "should never reach this point!\n");
        exit(1);
      }
  }

  printf("The depth is %d\n", depth);
  printf("The horizontal is %d\n", horz);
  printf("The depth and horizontal multiplied is %d\n", depth * horz);

}
