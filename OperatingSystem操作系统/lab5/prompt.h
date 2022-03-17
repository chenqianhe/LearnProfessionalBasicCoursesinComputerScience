#include "exec.h"
#define MAXLINE 1024
#define MAXARGS 128


char theme[] = "Here to control file system";

void eval(char *cmdline);
int parseline(const char *cmdline, char **argv);


int Start_Shell() {
  int ret;
  char ch;

  char cmdline[MAXLINE];

  int emit_prompt = 1;

  while (login() != FS_LOGIN) {}
  ret = load_super_block();
  if (ret == FS_RD_ERROR)
    return FS_RD_ERROR;

  printf("%s\n", theme);
  printf("\n");

  while (1) {

    if (emit_prompt) {
      if (developer == 0)
        printf("\e[1;31m[Developer mode] \e[0m");
      printf("\e[1;32m%s \e[0m", path);
      fflush(stdout);
    }
    if ((fgets(cmdline, MAXLINE, stdin) == NULL) && ferror(stdin)) {
      printf("fgets error\n");
      exit(1);
    }
    if (feof(stdin)) {
      printf("[EXIT] Parser reached end-of-file. Terminated!\n");
      fflush(stdout);
      exit(0);
    }

    eval(cmdline);
    fflush(stdout);
  }

  return 0;
}

void eval(char *cmdline) {
  char *argv[MAXARGS];
  char buf[MAXLINE];
  int argc;

  strcpy(buf, cmdline);
  argc = parseline(buf, argv);

  if (argv[0] == NULL)
    return;
  if (!developer_cmd(argc, argv)) {
    if (!builtin_cmd(argv)) {
      if (!py_execute(argv[0], argc, argv))
        printf("sh: command not found: %s\n", argv[0]);
    }
  }
}

/*
 * parseline - Parse the command line and build the argv array.
 */
int parseline(const char *cmdline, char **argv) {
  /* Holds local copy of command line */
  static char array[MAXLINE];
  char *buf = array;
  char *delim;
  int argc;
  
  strcpy(buf, cmdline);
  buf[strlen(buf) - 1] = ' ';
  /* Ignore leading spaces */
  while (*buf && (*buf == ' '))
    buf++;

  /* Build the argv list */
  argc = 0;
  if (*buf == '\'') {
    buf++;
    delim = strchr(buf, '\'');
  }
  else {
    delim = strchr(buf, ' ');
  }

  while(delim) {
    argv[argc++] = buf;
    *delim = '\0';
    buf = delim + 1;
    while (*buf && (*buf == ' '))
      buf++;
    
    if (*buf == '\'') {
      buf++;
      delim = strchr(buf, '\'');
    }
    else {
      delim = strchr(buf, ' ');
    }
  }
  argv[argc] = NULL;
  return argc;
}
