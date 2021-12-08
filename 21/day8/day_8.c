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
#include <string.h>
#include <unistd.h>

void count_unique(void);
void decode(void);

int main (void)
{
  count_unique();
  decode();
  return 0;
}

void count_unique (void)
{
  FILE *day8;
  char *out, *line = NULL;
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

void decode (void)
{
  FILE *day8;
  char *line = NULL;
  char save;
  int read, ptr1, ptr2, i, j, k;
  long sum;
  size_t len;
 
  char *input[10];
  char *output[4];
  char *digits[10];
  char number[4];
  char sevenSeg[7];
  char one[2];
  char four[2];

  day8 = fopen("day8.in", "r");
  if (day8 == NULL) {
    fprintf(stderr, "day8 won't open\n");
    exit(1);
  }

  sum = 0;
  while ((read = getline (&line, &len, day8)) != -1) {
    memset(sevenSeg, 0, 7 * sizeof(char));
    memset(one, 0, 2 * sizeof(char));
    memset(four, 0, 2 * sizeof(char));
    memset(number, 0, 4 * sizeof(char));

    // Break up

    // Input
    ptr1 = 0;
    ptr2 = 0;
    i = 0;
    while (i < 10) {
      if (line[ptr1] == ' ') {
        line[ptr1] = 0;
        input[i] = &line[ptr2];
        //printf ("%s\n", input[i]);
        i++;
        ptr2 = ptr1+1;
      }
      ptr1++;
    }

    // Output
    ptr1 += 2;
    ptr2 = ptr1;
    i = 0;
    while (i < 4) {
      if (line[ptr1] == ' ' || line[ptr1] == '\n') {
        line[ptr1] = 0;
        output[i] = &line[ptr2];
        //printf ("%s\n", output[i]);
        i++;
        ptr2 = ptr1+1;
      }
      ptr1++;
    }

    // Decode
    
    // One
    i = 0;
    while (one[0] == 0) {
      if (strnlen(input[i], 7) == 2) {
        one[0] = input[i][0];
        one[1] = input[i][1];
        digits[1] = input[i];
      }
      i++;
    }

    // Seven
    i = 0;
    j = 0;
    while (sevenSeg[0] == 0) {
      if (strnlen(input[i], 7) == 3) {
        while (sevenSeg[0] == 0) {
          if (input[i][j] != one[0] && input[i][j] != one[1]) {
            sevenSeg[0] = input[i][j];
            digits[7] = input[i];
          }
          j++;
        }
      }
      i++;
    }

    // Four
    i = 0;
    j = 0;
    k = 0;
    while (four[0] == 0) {
      if (strnlen(input[i], 7) == 4) {
        while (four[1] == 0) {
          if (input[i][j] != one[0] && input[i][j] != one[1]) {
            four[k] = input[i][j];
            digits[4] = input[i];
            k++;
          }
          j++;
        }
      }
      i++;
    }

    // Zero & Six
    i = 0;
    while (sevenSeg[1] == 0 || sevenSeg[5] == 0) {

      // Zero
      if (strnlen(input[i], 7) == 6) {
        j = 0;
        while (j < 6) {
          if (input[i][j] == four[0] || input[i][j] == four[1]) {
            save = input[i][j];
            j++;
            while (j < 6) {
              if (input[i][j] == four[0] || input[i][j] == four[1]) {
                break;
              }
              j++;
            }
            if (j == 6) {
              sevenSeg[1] = save;
              sevenSeg[3] = four[0] == save ? four[1] : four[0];
              digits[0] = input[i];
              i++;
            } else {
              j = 6;
            }
          }
          j++;
        }
      }

      // Six
      if (strnlen(input[i], 7) == 6) {
        j = 0;
        while (j < 6) {
          if (input[i][j] == one[0] || input[i][j] == one[1]) {
            save = input[i][j];
            j++;
            while (j < 6) {
              if (input[i][j] == one[0] || input[i][j] == one[1]) {
                break;
              }
              j++;
            }
            if (j == 6) {
              sevenSeg[2] = save;
              sevenSeg[5] = one[0] == save ? one[1] : one[0];
              digits[6] = input[i];
            } else {
              j = 6;
            }
          }
          j++;
        }
      }

      i++;
    }

    // Nine
    i = 0;
    while (sevenSeg[6] == 0) {
      if (strnlen(input[i], 7) == 6 && 
          strncmp(input[i], digits[0], 6) != 0 && 
          strncmp(input[i], digits[6], 9) != 0) {
        j = 0;
        while (sevenSeg[6] == 0) {
          if (input[i][j] != sevenSeg[0] &&
              input[i][j] != sevenSeg[1] &&
              input[i][j] != sevenSeg[2] &&
              input[i][j] != sevenSeg[3] &&
              input[i][j] != sevenSeg[5]) {
            sevenSeg[6] = input[i][j];
            digits[9] = input[i];
          }
          j++;
        }
      }
      i++;
    }

    // Last letter
    i = 0;
    j = 0;
    while (sevenSeg[4] == 0) {
      if (strnlen(input[i], 7) == 7) {
        while (sevenSeg[4] == 0) {
          if (input[i][j] != sevenSeg[0] &&
              input[i][j] != sevenSeg[1] &&
              input[i][j] != sevenSeg[2] &&
              input[i][j] != sevenSeg[3] &&
              input[i][j] != sevenSeg[5] &&
              input[i][j] != sevenSeg[6]) {
            sevenSeg[4] = input[i][j];
          }
          j++;
        }
      }
      i++;
    }

    // Evaluate  
    for (i = 0; i < 4; i++) {
      j = strnlen(output[i], 7);
      if (j == 2) {
        number[i] = '1';
      } else if (j == 3) {
        number[i] = '7';
      } else if (j == 4) {
        number[i] = '4';
      } else if (j == 7) {
        number[i] = '8';
      } else if (j == 6) {
        k = 0;
        while (k < 6) {
          if (output[i][k] == sevenSeg[3]) {
            k = 0;
            while (number[i] == 0) {
              if (output[i][k] == sevenSeg[2]) {
                number[i] = '9';
                k = 6;
              } else if (output[i][k] == sevenSeg[4]) {
                number[i] = '6';
                k = 6;
              }
              k++;
            }
          }
          k++;
        }
        number[i] = number[i] == 0 ? '0' : number[i];
      } else {
        k = 0;
        while (k < 5) {
          if (output[i][k] == sevenSeg[1]) {
            number[i] = '5';
            k = 5;
          } else if (output[i][k] == sevenSeg[4]) {
            number[i] = '2';
            k = 5;
          }
          k++;
        }
        number[i] = number[i] == 0 ? '3' : number[i];
      }
    }
    //printf ("%s\n", number);

    // Add to sum
    sum += atoi(number);

  }
  
  printf ("The sum is %ld\n", sum);
    
  fclose(day8);
}
