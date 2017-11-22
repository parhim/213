#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include "list.h"
#include <string.h>


void str_toNum(element_t* o, element_t i) {
	char* input = (char*) i;
	intptr_t* output = (intptr_t*) o;
	char** input_ptr = &input;
	*output = strtol(input, input_ptr, 10);
	if (*input_ptr != NULL && *output == 0)
		*output = -1;
}


void print_string (element_t evv) {
  char* ele = evv;
  printf ("%s\n", ele);
}

int isPositive(element_t a) {
	intptr_t dull = (intptr_t) a;
	if (dull != -1)
		return 1;
	else 
		return 0;
}

void print_num (element_t e) {
  intptr_t ele = (intptr_t) e;
  printf ("%ld\n", ele);
}

int notNULL (element_t a) {
	char* dull = a;
	if (dull != NULL)
		return 1;
	else
		return 0;
}

void truncString(element_t* rv, element_t av, element_t bv) {
	char* a = av;
	intptr_t b = (intptr_t) bv;
	char** r = (char**) rv;
	*r = strdup(a);
	if (strlen(*r) > b) {
		for (int i = 0; i < strlen(*r); i++) {
			if (i == b) {
				(*r)[i] = '\0';
				return;
			}
		}
	}
}

int maxValue(struct list *l) {
	intptr_t max = (intptr_t)list_get(l, 0);
	for (int i = 0; i < list_len(l); i++) {
		intptr_t a = (intptr_t)list_get(l, i);
		if (a > max) {
			max = a;
		}
	}
	return max;
}

void toNULL(element_t* rv, element_t av, element_t bv) {
	char* a = av;
	intptr_t b = (intptr_t) bv;
	char** r = (char**) rv;
	if (b < 0)
		*r = a;
	else
		*r = 0;
}

int main(int argc, char** argv) {
	
	struct list* list0 = list_create();
	for (int i = 1; i < argc; i++)
		list_append(l0, argv[i]);
	
	struct list* list1 = list_create();
	list_map1(str_toNum, list1, list0);
	
	struct list* list2 = list_create();
	list_map2(toNULL, list2, list0, list1);
	
	struct list* list3 = list_create();
	list_filter(isPositive, list3, list1);

	struct list* list4 = list_create();
	list_filter(notNULL, list4, list2);
	
	struct list* list5 = list_create();
	list_map2(truncString, list5, list4, list3);
	list_foreach(print_string, list5);
	list_foreach(free, list5);
	
	int max = maxValue(list1);
	printf("%ld\n", max);
	
	list_destroy(l0);
	list_destroy(l1);
	list_destroy(l2);
	list_destroy(l3);
	list_destroy(l4);
	list_destroy(l5);
}
