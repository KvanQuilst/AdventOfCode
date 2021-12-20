///////////////
//
// Advent of Code - Day 20
// Trench Map
//
///////////////

#include <fcntl.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void improveImage(int time);
int countOn(int **img, int h, int w);
int toBin(int win[3][3]);

int main (void)
{
  improveImage(1);
}

void improveImage (int times)
{
  FILE *day20;
  char *line = NULL;
  size_t len;
  int alg[512], **inImg, **outImg, win[3][3];
  int size, length, i, j, k, l;

  day20 = fopen("day20_test.in", "r");
  if (day20 == NULL) {
    fprintf(stderr, "day20 won't open\n");
    exit(1);
  } if (getline (&line, &len, day20)  == -1) {
    fprintf(stderr, "missing info!\n");
    exit(1);
  }

  // set algorithm array
  for (i = 0; i < 512; i++) {
    alg[i] = (line[i] == '#');
  }

  size = 0;
  while (getline (&line, &len, day20) != -1) {
    size++; 
  }
  size--;

  length = 0;
  while (line[length] != 0) {
    length++;
  }
  length--;

  // set input image
  inImg = malloc(size * sizeof(int*));
  rewind(day20);
  getline(&line, &len, day20);
  getline(&line, &len, day20);

  i = 0;
  while (getline(&line, &len, day20) != -1) {
    inImg[i] = malloc(length * sizeof(int)); 
    memset(inImg[i], 0, length);
    for (j = 0; j < length; j++) {
      inImg[i][j] = (line[j] == '#');
      printf("%d", inImg[i][j]);
    }
    printf("\n");
  }
  printf("\n");

  // set output size
  while (times != 0) {
    outImg = malloc(size+4 * sizeof(int*));
    for (i = 0; i < size+4; i++) {
      outImg[i] = malloc((length+4) * sizeof(int));
      memset(outImg[i], 0, length+4);
    }

    for (i = 0; i < size+2; i++) {
      for (j = 0; j < length+2; j++) {
        printf("(%d, %d)\n", i, j);
        for (k = 0; k < 3; k++) {
          for (l = 0; l < 3; l++) {
            if (i+k-1 <= 0 || i+k-1 >= size-2) {
              win[k][l] = 0;
            } else if (j-l-1 <= 0 || j+l-1 >= length-2) {
              win[k][l] = 0;
            } else {
              win[k][l] = inImg[i+k-1][j+l-1];
            }
          }
        }
        outImg[i][j] = alg[toBin(win)];
        printf("here\n");
      }
    }
    free(inImg);
    inImg = outImg;
    times--;
  }
  
  printf("The number of lit pixels is %d\n", countOn(inImg, size, length));
  fclose(day20);
}

int countOn(int **img, int h, int w)
{
  int i, j, on;
  printf("countOn\n");

  on = 0;
  for (i = 0; i < h; i++) {
    for (j = 0; j < w; j++) {
      on += img[i][j];
    }
  }
  
  return on;
}

int toBin(int win[3][3])
{
  int i, j, k, num;
  printf("toBin\n");

  k = 0;
  for (i = 0; i < 3; i++) {
    for (j = 0; j < 3; j++) {
      num |= win[i][j] << k;
      k++;
      printf("%d", win[i][j]);
    }
    printf("\n");
  }
  printf("\n");
  return num;
}
