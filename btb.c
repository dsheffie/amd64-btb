#include <stdio.h>
#include <stdint.h>
#include <unistd.h>
#include <string.h>
#include <sys/syscall.h>
#include <linux/unistd.h>
#include <linux/perf_event.h>
#include <linux/hw_breakpoint.h>
#include <sys/ioctl.h>

static int cycle_fd = -1;

static inline uint64_t rdcycle() {
  uint64_t x;
  read(cycle_fd, &x, sizeof(x));
  //__asm__ __volatile__ ("rdcycle %0" : "=r"(x));
  return x;
}

uint64_t goto_test4(int);
uint64_t goto_test8(int);
uint64_t goto_test16(int);
uint64_t goto_test32(int);
uint64_t goto_test64(int);
uint64_t goto_test128(int);
uint64_t goto_test256(int);
uint64_t goto_test512(int);
uint64_t goto_test1024(int);
uint64_t goto_test2048(int);
uint64_t goto_test4096(int);
uint64_t goto_test8192(int);
uint64_t goto_test16384(int);
uint64_t goto_test32768(int);
uint64_t goto_test65536(int);

typedef uint64_t (*test_t)(int);

static test_t funcs[] = {goto_test4,
			 goto_test8,
			 goto_test16,
			 goto_test32,
			 goto_test64,
			 goto_test128,
			 goto_test256,
			 goto_test512,
			 goto_test1024,

			 goto_test2048,
			 goto_test4096,
			 goto_test8192,
			 goto_test16384,
			 goto_test32768,
			 goto_test65536
};

static const int n_tests = sizeof(funcs)/sizeof(funcs[0]);
static const int n_iters = 1<<20;

int main() {
  struct perf_event_attr pe;
  memset(&pe, 0, sizeof(pe));
  pe.type = PERF_TYPE_HARDWARE;
  pe.size = sizeof(pe);
  pe.config = PERF_COUNT_HW_CPU_CYCLES;
  pe.pinned = 1;

  cycle_fd = syscall(__NR_perf_event_open, &pe,
		     0, -1,
		     -1, 0);
  if(cycle_fd < 0) perror("WTF");
  
  for(int i = 0; i < n_tests; ++i) {
    uint64_t now = rdcycle();
    uint64_t sz = funcs[i](n_iters);
    now = rdcycle() - now;
    uint64_t jumps = n_iters * sz;
    double cycles_per_j =  ((double)now) / jumps;
    printf("%d,%g\n", sz, cycles_per_j);
  }
  return 0;
}
