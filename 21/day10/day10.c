///////////////
//
// Advent of Code - Day 10
// Syntax Scoring
//
///////////////

#include <fcntl.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void firstIllegal(void);
int processLine(char *line);
void middleIncomplete(void);
long fixLine(char *line);
void sort(long *a, int len);
long binarySearch (long *a, long item, int low, int high);

int main (void)
{
  firstIllegal();
  middleIncomplete();
}

void firstIllegal(void)
{
  FILE *day10;
  char *line = NULL;
  int count[4] = {0}; /* (,[,{,> */
  int rv;
  long total;
  size_t len;

  day10 = fopen("day10.in", "r");
  if (day10 == NULL) {
    fprintf(stderr, "day10 won't open!\n");
    exit(1);
  }

  while (getline (&line, &len, day10) != -1) {
    rv = processLine(line);
    if (rv != 0) {
      count[rv-1]++;
    }
  }

  total = 3*count[0] + 57*count[1] + 1197*count[2] + 25137*count[3];
  printf("The total illegal value is %d\n", total);
  fclose(day10);
}

int processLine(char *line)
{
  char total[1024] = {0};
  int i, j;

  i = 0; j = 0;
  while (line[i] == '(' || line[i] == ')' ||
         line[i] == '[' || line[i] == ']' ||
         line[i] == '{' || line[i] == '}' ||
         line[i] == '<' || line[i] == '>') {
    if (line[i] == ')') {
      if (total[j-1] != '(') {
        return 1;
      }
      j--; 
    } else if (line[i] == ']') {
      if (total[j-1] != '[') {
        return 2;
      }
      j--;
    } else if (line[i] == '}') {
      if (total[j-1] != '{') {
        return 3;
      }
      j--;
    } else if (line[i] == '>') {
      if (total[j-1] != '<') {
        return 4;
      }
      j--;
    } else {
      total[j] = line[i];
      j++;
    }
    i++;
  }
  return 0;
}

void middleIncomplete(void)
{
  FILE *day10;
  char *line = NULL;
  long *total;
  int rv, count, i;
  size_t len;

  day10 = fopen("day10_test.in", "r");
  if (day10 == NULL) {
    fprintf(stderr, "day10 won't open!\n");
    exit(1);
  }
  
  while (getline(&line, &len, day10) != -1) {
    rv = processLine(line);
    if (rv == 0) {
      count++;
    }
  }

  total = malloc(count * sizeof(long));

  rewind(day10);
  i = 0;
  while (getline(&line, &len, day10) != -1) {
    rv = processLine(line);
    if (rv == 0) {
      total[i] = fixLine(line);
      printf("total[i] = %d\n", total[i]);
      i++;
    }
  }

  sort(total, count);

  printf ("The middle incomplete value is %d\n", total[count/2]);
  fclose(day10);
}

long fixLine(char *line)
{
  char stack[1024];
  int i, j;
  long sum;

  i = 0; j = 0;
  while (line[i] == '(' || line[i] == ')' ||
         line[i] == '[' || line[i] == ']' ||
         line[i] == '{' || line[i] == '}' ||
         line[i] == '<' || line[i] == '>') {
      if (stack[j-1] != '(') {
      j--; 
    } else if (line[i] == ']') {
      j--;
    } else if (line[i] == '}') {
      j--;
    } else if (line[i] == '>') {
      j--;
    } else {
      stack[j] = line[i];
      j++;
    }
    i++;
  }

  sum = 0;
  for (j; j > 0; j--) {
    sum *= 5;
    if (stack[j] == '(') {
      sum += 1;
    } else if (stack[j] == '[') {
      sum += 2;
    } else if (stack[j] == '{') {
      sum += 3;
    } else if (stack[j] == '<') {
      sum += 4;
    }
  }
  return sum;
}

void sort(long *a, int len)
{
  int i, loc, j, k;
  long selected;

  for (i = 1; i < len; ++i)
  {
    j = i - 1;
    selected = a[i];

    loc = binarySearch(a, selected, 0, j);

    while (j >= loc) {
      a[j + 1] = a[j];
      j--;
    }
    a[j + 1] = selected;
  }
}

long binarySearch(long *a, long item, int low, int high) {
  if (high <= low)
    return (item > a[low]) ? (low + 1) : low;

  int mid = (low + high) / 2;

  if (item == a[mid])
    return mid + 1;

  if (item > a[mid])
    return binarySearch(a, item, mid + 1, high);
  return binarySearch(a, item, low, mid - 1);
}
