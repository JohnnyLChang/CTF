#include <stdlib.h>
#include <stdio.h>

int s[45] = {0};
int flag[45] = {0};

unsigned char lasmhard[] = {
  0x42, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x4f, 0x00, 0x00, 0x00,
  0x41, 0x00, 0x00, 0x00, 0x4b, 0x00, 0x00, 0x00, 0x4a, 0x00, 0x00, 0x00,
  0x40, 0x00, 0x00, 0x00, 0x48, 0x00, 0x00, 0x00, 0x50, 0x00, 0x00, 0x00,
  0x72, 0x00, 0x00, 0x00, 0x3b, 0x00, 0x00, 0x00, 0x54, 0x00, 0x00, 0x00,
  0x6a, 0x00, 0x00, 0x00, 0x3c, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00,
  0x6b, 0x00, 0x00, 0x00, 0x4f, 0x00, 0x00, 0x00, 0x50, 0x00, 0x00, 0x00,
  0x4d, 0x00, 0x00, 0x00, 0x5f, 0x00, 0x00, 0x00, 0x7b, 0x00, 0x00, 0x00,
  0x61, 0x00, 0x00, 0x00, 0x49, 0x00, 0x00, 0x00, 0x27, 0x00, 0x00, 0x00,
  0x7e, 0x00, 0x00, 0x00, 0x46, 0x00, 0x00, 0x00, 0x70, 0x00, 0x00, 0x00,
  0x6e, 0x00, 0x00, 0x00, 0x52, 0x00, 0x00, 0x00, 0x76, 0x00, 0x00, 0x00,
  0x41, 0x00, 0x00, 0x00, 0x59, 0x00, 0x00, 0x00, 0x55, 0x00, 0x00, 0x00,
  0x4f, 0x00, 0x00, 0x00, 0x61, 0x00, 0x00, 0x00, 0x57, 0x00, 0x00, 0x00,
  0x15, 0x00, 0x00, 0x00, 0x15, 0x00, 0x00, 0x00, 0x48, 0x00, 0x00, 0x00,
  0x5a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
};
unsigned int lasmhard_len = 180;


int *realflag = (int *)lasmhard;

int obfuscation(char c, int i){

}

int main(int argc, char *argv[])
{
    printf("hello world\n");
    for (int i = 0; i < 40; i++)
    {
        for (int j = 0; j < 255; j++)
        {
            int p = j;
            if (p == realflag[i])
            {
                printf("%c", j);
                break;
            }
        }
        //printf("%x ", realflag[i]);
    }
    return 0;
}