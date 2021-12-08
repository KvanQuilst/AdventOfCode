///////////////
//
// Advent of Code - Day 8
// Seven Segment Search
//
///////////////

#include <fcntl.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void count_unique(void);

int main (void)
{
  count_unique();
  return 0;
}

void count_unique (void)
{
  FILE *day8;
  char *out, *line = NULL;
  char **digits;
  int read, ptr1, ptr2, count, segLen;
  size_t len;

  day8 = fopen("day8.in", "r");
  if (day8 == NULL) {
    fprintf(stderr, "day8 won't open\n");
    exit(1);
  }

  count = 0;
  while ((read = getline (&line, &len, day8)) != -1) {

    // Read the output
    ptr1 = 0;
    while (ptr1 < len && line[ptr1] != '|') {
      ptr1++;
    }
    out = &line[ptr1+2];

    ptr2 = 0;
    segLen = 0;
    while (ptr1+ptr2+2 < len && out[ptr2] != 0) {

      // Count length of segment
      if (out[ptr2] == ' ' || out[ptr2] == '\n') {
        count += (segLen == 2 || segLen == 4 || segLen == 3 || segLen == 7);
        segLen = 0;
      } else {
        segLen++;
      }
      ptr2++;
    }
  }
  fclose (day8);
  printf ("The number of unique counts is %d\n", count);
}
