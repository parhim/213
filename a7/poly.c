#include <stdlib.h>
#include <stdio.h>
#include <string.h>


struct Person_class {
  void*   super;
  void     (* toString) (void *, char *, int);
};

struct Person {
  struct Person_class* class;
  char* name;
};

void Person_toString (void* person,char* mem,int memSize) { 
  struct Person* p = (struct Person*) person;
  snprintf(mem,memSize,"%s %s","Name:",p->name);
   }


struct Person_class Person_class_obj = {NULL, Person_toString};

struct Person* new_Person(char* name) {
  struct Person* obj = malloc (sizeof (struct Person));
  obj->class = &Person_class_obj;
  obj->name = strdup(name);
  return obj;
}




struct Student_class {
  struct Person_class* super;
  void        (* toString) (void *, char *, int);
};

struct Student {
  struct Student_class* class;
  char*     name;
  int       sid;
};

void Student_toString (void* student,char* mem,int memSize){
  Person_toString(student,mem,memSize);
  struct Student* s = (struct Student*) student;
  snprintf(mem,memSize,"%s%s %d",mem,", SID:",s->sid);
}

struct Student_class Student_class_obj = {&Person_class_obj, Student_toString};

struct Student* new_Student(char* name,int id) {
  struct Student* obj = malloc (sizeof (struct Student));
  obj->class = &Student_class_obj;
  obj->name = name;
  obj->sid = id;
  return obj;
}



int main (int argc, char** argv) {
  struct Person* people[2] = {new_Person("Alex"), (struct Person*) new_Student("Alice", 300)};
  for (int i=0;i<2;i++) {
    char* mem = malloc(200);
    struct Person* p = people[i];
    p->class->toString(p,mem,200);
    printf("%s\n",mem);
    free(mem);
  }
}





