
#include "prompt.h"

#define FS_PATH "disk"

int main(int argc, char **argv) {
  disk = fopen(FS_PATH, "r+");
  if (disk == NULL)
    return FS_NO_EXIST;
  Start_Shell();
  return 0;
}
