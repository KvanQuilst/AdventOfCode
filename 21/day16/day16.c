///////////////
//
// Advent of Code - Day 16
// Packet Decoder
//
///////////////

#include <fcntl.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void versions(void);
int convert(char c);

int main (void)
{
  versions();
}

void versions(void)
{
  FILE *day16;
  char *line = NULL;
  size_t len;

  int i, sum, v, t, li, l;
  long string;

  day16 = fopen("day16.in", "r");
  if (day16 == NULL) {
    fprintf(stderr, "day16 won't open!\n");
    exit(1);
  }

  if (getline(&line, &len, day16) == -1) {
    fprintf(stderr, "no data!\n");
    exit(1);
  }

  sum = 0;
  while (i < len && ((line[i] >= '0' && line[i] <= '9') ||
        (line[i] >= 'A' && line[i] <= 'F'))) {

    v = convert(line[i]) >> 1;
    sum += v;

    t = ((convert(line[i]) << 3) & 0x4) | (convert(line[i]) >> 2);
    if (t == 4) {
      i += 6;
    } else {
      li = convert(line[i+1]) & 0x2;       
      if (li == 0) {
        l = ((convert(line[i+1]) & 0x1) << 14) | (convert(line[i+2]) << 10) |
            (convert(line[i+3]) << 6) | (convert(line[i+4]) << 2) | 
            ((convert(line[i+5]) & 0xC) >> 2);
        i += 6 + (l+(l%4)-2 / 4);
      } else { // if (li == 1)
        l = ((convert(line[i+1]) & 0x1) << 10) | (convert(line[i+2]) << 6) |
            (convert(line[i+3]) << 2) | ((convert(line[i+4]) & 0xC) >> 2);
        i += 5 + (l+(l%4)-2 / 4);
      }
    }
  }

  printf("The sum of versions is %d\n", sum);
  fclose(day16);
}

int convert(char c)
{
  if (c >= '0' && c <= '9') {
    return (int) c - '0';
  } else if (c >= 'A' && c <= 'F') {
    return (int) c - 'A' + 10;
  } else {
    return -1;
  }
}
