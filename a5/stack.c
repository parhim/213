#include <stdlib.h>
#include <stdio.h>
#include <string.h>

struct Element {
  char   name[200];
  struct Element *next;
};

struct Element *top = 0;

void push (char* aName) {
  struct Element* e = malloc (sizeof (*e));    // Not the bug: sizeof (*e) == sizeof(struct Element)
  strncpy (e->name, aName, sizeof (e->name));  // Not the bug: sizeof (e->name) == 200
  e->next  = top;
  top = e;
}

 void pop(char* buf) {
  struct Element* e = top;
  top = e->next;
  strncpy (buf, e->name, sizeof(buf)); 
  free (e);
}

int main (int argc, char** argv) {
  char buf0[200];
  char buf1[200];
  char buf2[200];
  char buf3[200];
  push ("A");
  push ("B");
  pop(buf0);
  push ("C");
  push ("D");
  pop(buf1);
  pop(buf2);
  pop(buf3);
  printf ("%s %s %s %s\n", buf0, buf1, buf2, buf3);
}
