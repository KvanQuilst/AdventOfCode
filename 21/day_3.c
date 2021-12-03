///////////////////////
//
// Advent of Code 2021 - Day 3
// Binary Diagnostic
//
///////////////////////

#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void biterpreter(void);
void lifesupport(void);
int mask(long num, int bitPos);

int main()
{
  biterpreter();  
  lifesupport();
}

void biterpreter(void)
{
  FILE *day3;
  char *line = NULL;
  int read, bit, i;
  long num;
  int setcount[12] = {0}; 
  int resetcount [12] = {0};
  unsigned int gamma, epsilon;
  size_t len;

  day3 = fopen("day3.in", "r");
  if (day3 == NULL) {
    fprintf(stderr, "day3 won't open\n");
    exit(1);
  }

  while ((read = getline (&line, &len, day3)) != -1) {
    sscanf (line, "%ld\n", &num);

    for (i = 0; i < 12; i++) {
      bit = mask(num, i);
      setcount[i] += bit;
      resetcount[i] += !bit;
    }
  }

  gamma = 0;
  epsilon = 0;
  for (i = 0; i < 12; i++) {
    if (setcount[i] > resetcount[i]) {
      gamma |= 0x01 << i;
    } else {
      epsilon |= 0x01 << i;
    }
  }

  printf ("gamma is %u\n", gamma);
  printf ("epsilon is %u\n", epsilon);
  printf ("gamma x epsilon is %u\n", gamma * epsilon);
  fclose (day3);
}

void lifesupport(void)
{
  FILE *day3;
  char *line = NULL;
  int read, bit, most, bitPos, i;
  long num;
  int setcount[12] = {0};
  int resetcount[12] = {0};
  int set[1000] = {0};
  int reset[1000] = {0};
  int setnum = 1000;
  int resetnum = 1000;
  int nums[1000] = {0};
  unsigned int oxygen, co2;
  size_t len;

  day3 = fopen("day3.in", "r");
  if (day3 == NULL) {
      fprintf(stderr, "day3 won't open\n");
      exit(1);
  }

  while ((read = getline(&line, &len, day3)) != -1) {
    sscanf (line, "%ld\n", &num);

    for (bitPos = 0; bitPos < 12; bitPos++) {
      bit = mask(num, bitPos); 
      nums[i] = bit << bitPos;
    }
    i++;
  }

  for (bitPos = 11; bitPos >= 0; bitPos--) {
    for (i = 0; i < 1000; i++) {
      bit = nums[i] & (0x01 << bitPos);
      if (set[i] == 0 && setnum != 1) {
        setcount[bitPos] += bit;
      }
      if (reset[i] == 0 && resetnum != 1) {
        resetcount[bitPos] += !bit;
      }
    }

    most = (set[bitPos] >= reset[bitPos]);
    for (i = 0; i < 1000; i++) {
      if (set[i] == 0 && setnum != 1) {
        set[i] = !(nums[i] & (0x01 << bitPos) == most);
        setnum--;
      }
      if (reset[i] == 0 && resetnum != 1) {
        reset[i] = (nums[i] & (0x01 << bitPos) == most);
        resetnum--;
      }
    }
  }

  for (i = 0; i < 1000; i++) {
    if (set[i] == 0) {
      oxygen = nums[i];
    }
    if (reset[i] == 0) {
      co2 = nums[i];
    }
  }

  printf("resetnum %d, setnum %d\n", resetnum, setnum);
  printf ("oxygen is %u\n", oxygen);
  printf ("carbon dioxide is %u\n", co2);
  printf ("life support is %u\n", oxygen * co2);
}

int mask(long num, int bitPos)
{
  int i;

  if (bitPos >= 12 || bitPos < 0) {
    fprintf(stderr, "pos invalid!\n");
    exit(1);
  }

  for (i = 0; i < bitPos; i++) {
    num /= 10;
  }

  return num%10;
}
