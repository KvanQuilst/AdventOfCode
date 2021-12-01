///////////////
//
// Advent of Code - Day 1
// Sweeping Sonar
//
///////////////

#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void timesDeeper(void);
void timesDeeperAdv(void);

int main(int argc, char **argv)
{

  timesDeeper ();
  timesDeeperAdv ();

  return 0;
}

void timesDeeper(void)
{
  FILE *day1_1;
  char *line = NULL;
  int read, val1, val2, count;
  size_t len;

  day1_1 = fopen ("day1_1.in", "r");
  if (day1_1 == NULL) {
    fprintf (stderr, "day1_1 won't open");
    exit (1);
  }

  if ((read = getline (&line, &len, day1_1)) == 1) {
    fprintf (stderr, "line error\n");
    exit (1);
  }
  val1 = atoi(line);

  while ((read = getline (&line, &len, day1_1)) != -1) {
    val2 = atoi(line);
    if (val2 > val1) {
      count++;
    }
    val1 = val2;
  }

  printf ("The number of depth increases is %d\n", count);    

  fclose (day1_1);
}

void timesDeeperAdv(void)
{
  FILE *day1_1;
  char *line = NULL;
  int read, val1, val2, val3, val4, count2, i;
  size_t len;
  int arr[2000];

  day1_1 = fopen ("day1_1.in", "r");
  if (day1_1 == NULL) {
      fprintf (stderr, "line error\n");
      exit(1);
  }

  while ((read = getline (&line, &len, day1_1)) != -1) {
    arr[count2] = atoi(line);
    count2++;
  }

  count2 = 0;
  for (i = 0; i < 1998; i++) {
    if (arr[i]+arr[i+1]+arr[i+2]<arr[i+1]+arr[i+2]+arr[i+3]) {
      count2++;
    }
  }
  printf ("The number of depth sum increases is %d\n", count2);

  fclose (day1_1);
}
