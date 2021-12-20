///////////////
//
// Advent of Code - Day 19
// Beacon Scanner
//
///////////////

#include <fcntl.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int **readScanners(void);

int main (void)
{

}

int **readScanners(void) 
{
  FILE *day19;
  char *line = NULL;
  int scanNum, **scanners;
  int i, j;
  size_t len;

  day19 = fopen("day19.in", "r");
  if (day19 == NULL) {
    fprintf(stderr, "day19 won't open\n");
    exit(1);
  }

  // get length
  scanNum = 0;
  while (getline (&line, &len, day19) != -1) {
    if (line[0] == '-') {
      scanNum++;
    }
  }

  scanners = malloc (scanNum * sizeof(int*));

  // read scanners
  rewind(day19);
  i = -1; j = 0;
  while (getline (&line, &len, day19) != -1) {
    if (line[0] == '-') {
      i++;
    } else {
      
    }
  }

}
