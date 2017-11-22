#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "uthread.h"
#include "uthread_sem.h"

#define MAX_ITEMS 10
const int NUM_ITERATIONS = 200;
const int NUM_CONSUMERS  = 2;
const int NUM_PRODUCERS  = 2;

int producer_wait_count;     // # of times producer had to wait
int consumer_wait_count;     // # of times consumer had to wait
int histogram [MAX_ITEMS+1]; // histogram [i] == # of times list stored i items

struct Pool {
    uthread_sem_t notEmpty,notFull,lock;
    int           items;

};

struct Pool* createPool() {
  struct Pool* pool = malloc (sizeof (struct Pool));
  pool->lock    = uthread_sem_create(1);
  pool->notEmpty =  uthread_sem_create(0);
  pool->notFull  = uthread_sem_create(MAX_ITEMS);
  pool->items     = 0;
  return pool;
}

void* producer (void* pv) {
  struct Pool* p = pv;
  for (int i=0; i<NUM_ITERATIONS; i++){
    uthread_sem_wait(p->notFull);
    uthread_sem_wait(p->lock);
    p->items++;
    histogram[p->items] ++;
    uthread_sem_signal(p->notEmpty);
    uthread_sem_signal(p->lock);
  }
  // TODO
  return NULL;
}

void* consumer (void* pv) {
  struct Pool* p = pv;
  for (int i=0; i<NUM_ITERATIONS; i++){
    uthread_sem_wait(p->notEmpty);
    uthread_sem_wait(p->lock);
    p->items--;
    histogram[p->items] ++;
    uthread_sem_signal(p->notFull);
    uthread_sem_signal(p->lock);
  }
  return NULL;
}

int main (int argc, char** argv) {
  uthread_t t[4];

  uthread_init (4);
  struct Pool* p = createPool();

  uthread_t cons1 = uthread_create(consumer, p);
  uthread_t cons2 = uthread_create(consumer, p);
  uthread_t prod1 = uthread_create(producer, p);
  uthread_t prod2 = uthread_create(producer, p);


  uthread_join(cons1, 0);
  uthread_join(cons2, 0);
  uthread_join(prod1, 0);
  uthread_join(prod2, 0);
  

  printf ("producer_wait_count=%d, consumer_wait_count=%d\n", producer_wait_count, consumer_wait_count);
  printf ("items value histogram:\n");
  int sum=0;
  for (int i = 0; i <= MAX_ITEMS; i++) {
    printf ("  items=%d, %d times\n", i, histogram [i]);
    sum += histogram [i];
  }
  assert (sum == sizeof (t) / sizeof (uthread_t) * NUM_ITERATIONS);
}