/*
  Montgomery squaring with the reduction in the same function (mcl's Fp::sqr),
  BLS12-381-p, N = 6. Functions from gen_sqrmod.py compiled by the original
  llc (llvm_*) and by the patched llc (llvmOpt_*). See readme.md.
*/
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <chrono>

typedef uint64_t Unit;
const int N = 6;
typedef void (*Mul)(Unit *z, const Unit *x, const Unit *y);
typedef void (*Sqr)(Unit *z, const Unit *x);
extern "C" {
	void llvm_mul(Unit*, const Unit*, const Unit*);
	void llvm_sqrWide(Unit*, const Unit*);
	void llvm_sqrFused(Unit*, const Unit*);
	void llvmOpt_mul(Unit*, const Unit*, const Unit*);
	void llvmOpt_sqrWide(Unit*, const Unit*);
	void llvmOpt_sqrFused(Unit*, const Unit*);
}

struct XorShift {
	uint64_t s = 88172645463325252ull;
	uint64_t get64() { s ^= s << 13; s ^= s >> 7; s ^= s << 17; return s; }
	// x < p (top limb of BLS12-381-p is 0x1a0111ea397fe69a)
	void getFp(Unit *x) { for (int i = 0; i < N; i++) x[i] = get64(); x[N - 1] &= 0x0fffffffffffffffull; }
};

template<class Op>
static double measure(Op op, size_t P, size_t loop)
{
	size_t m = loop / P;
	for (size_t i = 0; i < m / 10; i++) for (size_t k = 0; k < P; k++) op(k);
	auto t0 = std::chrono::steady_clock::now();
	for (size_t i = 0; i < m; i++) for (size_t k = 0; k < P; k++) op(k);
	auto t1 = std::chrono::steady_clock::now();
	return std::chrono::duration<double, std::nano>(t1 - t0).count() / (m * P);
}

struct Entry { const char *name; Mul mulF; Sqr sqrF; };
const Entry tbl[] = {
	{ "mul(x,x) org", llvm_mul, nullptr },
	{ "mul(x,x) opt", llvmOpt_mul, nullptr },
	{ "sqrWide org", nullptr, llvm_sqrWide },
	{ "sqrWide opt", nullptr, llvmOpt_sqrWide },
	{ "sqrFused org", nullptr, llvm_sqrFused },
	{ "sqrFused opt", nullptr, llvmOpt_sqrFused },
};
static void callF(const Entry& e, Unit *z, const Unit *x) { if (e.mulF) e.mulF(z, x, x); else e.sqrF(z, x); }

int main()
{
	XorShift rg;
	for (int i = 0; i < 10000; i++) {
		Unit x[N], zr[N], z[N];
		rg.getFp(x);
		if (i == 0) memset(x, 0, sizeof(x));
		if (i == 1) { memset(x, 0xff, sizeof(x)); x[N - 1] = 0x1a0111ea397fe69aull - 1; } // just below p's top limb
		llvm_mul(zr, x, x);
		for (const auto& e : tbl) {
			memset(z, 0xcc, sizeof(z));
			callF(e, z, x);
			if (memcmp(z, zr, sizeof(z)) != 0) { fprintf(stderr, "ERR %s i=%d\n", e.name, i); exit(1); }
		}
	}
	printf("check ok\n");
	const size_t P = 4, loop = 10000000;
	printf("BLS12-381-p N=%d, ns/op: throughput (P=4) / latency (chain)\n", N);
	Unit a[P][N], dst[P][N];
	for (size_t k = 0; k < P; k++) rg.getFp(a[k]);
	double base = 0;
	for (const auto& e : tbl) {
		double t = measure([&](size_t k) { callF(e, dst[k], a[k]); }, P, loop);
		Unit c[N]; rg.getFp(c);
		double l = measure([&](size_t) { callF(e, c, c); }, 1, loop);
		if (base == 0) base = t;
		printf("%-14s %8.3f (%.2fx) %8.3f\n", e.name, t, t / base, l);
	}
	return 0;
}
