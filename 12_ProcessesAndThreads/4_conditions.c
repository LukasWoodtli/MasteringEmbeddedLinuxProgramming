#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

char g_data[128];
pthread_cond_t cv = PTHREAD_COND_INITIALIZER;
pthread_mutex_t mutx = PTHREAD_MUTEX_INITIALIZER;

/* Note that when the consumer thread blocks on the `condvar`, it does so
 * while holding a locke'd mutex, which would seem to be a recipe for
 * deadlock the next time the producer thread tries to update the
 * condition. To avoid this, `pthread_condwait(3)` unlocks the mutex after
 * the thread is blocked, and then locks it again before waking it and
 * returning from the wait. */
void *consumer(void *arg) {
  while (1) {
    pthread_mutex_lock(&mutx);
    while (strlen(g_data) == 0)
      pthread_cond_wait(&cv, &mutx); /* Got data */
    printf("%s\n", g_data);

    /* Truncate to null string again */ g_data[0] = 0;
    pthread_mutex_unlock(&mutx);
  }
  return NULL;
}

void *producer(void *arg) {
  int i = 0;
  while (1) {
    sleep(1);
    pthread_mutex_lock(&mutx);
    sprintf(g_data, "Data item %d", i);
    pthread_mutex_unlock(&mutx);
    pthread_cond_signal(&cv);
    i++;
  }
  return NULL;
}

int main(int argc, char *argv[]) {
  pthread_t producer_thread;
  pthread_t consumer_thread;

  pthread_create(&producer_thread, NULL, producer, NULL);
  pthread_create(&consumer_thread, NULL, consumer, NULL);

  /* Wait for both threads to finish */
  pthread_join(producer_thread, NULL);
  pthread_join(consumer_thread, NULL);

  return 0;
}
