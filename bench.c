#include <stdio.h>
#include <stdint.h>
#include <time.h>

uint32_t div7(uint32_t x) { return x / 7; }
uint32_t div19(uint32_t x) { return x / 19; }
uint32_t div107(uint32_t x) { return x / 107; }

int main(int argc, char *argv[])
{
	time_t begin = clock();
	uint32_t ret = argc * 0x12345678;
	for (int i = 0; i < 1000000000; i++) {
		ret ^= div7(i ^ ret);
		ret ^= div19(i ^ ret);
		ret ^= div107(i ^ ret);
	}
	time_t end = clock();
	printf("ret=%08x time=%.2f sec\n", ret, (end - begin) / (double)CLOCKS_PER_SEC);
}
