#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "spinlock.h"

#define MAX_ITEMS 10

int items = 0;

const int NUM_ITERATIONS = 200;
const int NUM_CONSUMERS  = 2;
const int NUM_PRODUCERS  = 2;

int producer_wait_count;     // # of times producer had to wait
int consumer_wait_count;     // # of times consumer had to wait
int histogram [MAX_ITEMS+1]; // histogram [i] == # of times list stored i items
spinlock_t lock1;
spinlock_t lock2;
spinlock_t lock3;

void produce() {
    while (1) {
        while (items==MAX_ITEMS){
            spinlock_lock(&lock2);
            producer_wait_count++;
            spinlock_unlock(%lock2);
        }
        spinlock_lock(&lock1);
        if (items<MAX_ITEMS) {
            break;
        }
        spinlock_unlock(&lock1);
    };
    items++;
    histogram [items] += 1;
    spinlock_unlock(&lock1);
}

void consume() {
    while (1) {
        while (items==0){
            spinlock_lock(&lock3);
            consumer_wait_count++;
            spinlock_unlock(%lock3);
        }
        spinlock_lock(&lock1);
        if (items>0) {
            break;
        }
        spinlock_unlock(&lock1);
    };
    items--;
    histogram [items] += 1;
    spinlock_unlock(&lock1);
}

void producer() {
  for (int i=0; i < NUM_ITERATIONS; i++)
    produce();
}

void consumer() {
    for (int i=0; i< NUM_ITERATIONS; i++)
    consume();
}

int main (int argc, char** argv) {
    spinlock_create(%lock1);
    spinlock_create(%lock2);
    spinlock_create(%lock3);
  printf("Producer wait: %d\nConsumer wait: %d\n",
         producer_wait_count, consumer_wait_count);
  for(int i=0;i<MAX_ITEMS+1;i++)
    printf("items %d count %d\n", i, histogram[i]);
}
