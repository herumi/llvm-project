# Benchmark of wide-integer squaring: original llc vs patched llc vs the
# hand-scheduled sqrPre of mcl-ff. See readme.md.
#   make ref && make && make run            # BIT=64, x86_64 +bmi2
#   make BIT=32 ref bench32.exe run         # 32-bit units on x86_64
#   make BIT=32 TRIPLE=i686 ATTR= TAG=_i686 ref run   # 32-bit units, i386 code (-m32)
#   on Apple M4 the defaults are TRIPLE=arm64-apple-macosx ATTR= (same commands)
#   make TRIPLE=aarch64 ATTR= TAG=_a64 hist   # aarch64 histograms on any host
LLC_ORG?=../llvm/build.org/bin/llc
LLC_NEW?=../llvm/build/bin/llc
MCL_FF?=../../mcl-ff
BIT?=64
N_LIST=2 3 4 5 6 7 8
# host defaults: x86_64 Linux -> x86_64 +bmi2, Apple arm64 -> arm64-apple-macosx
UNAME_M:=$(shell uname -m)
UNAME_S:=$(shell uname -s)
ifeq ($(UNAME_M),arm64)
TRIPLE?=arm64-apple-macosx
ATTR?=
HIST_AWK=hist_a64.awk
else ifeq ($(UNAME_M),aarch64)
TRIPLE?=aarch64
ATTR?=
HIST_AWK=hist_a64.awk
else
TRIPLE?=x86_64
ATTR?=+bmi2
HIST_AWK=hist.awk
endif
ifneq ($(findstring aarch64,$(TRIPLE))$(findstring arm64,$(TRIPLE)),)
HIST_AWK=hist_a64.awk
endif
# pin to one core on Linux; macOS has no taskset
TASKSET:=$(if $(filter Linux,$(UNAME_S)),taskset -c 3,)
# extra llc flags for sqrOpt only (e.g. LLC_EXTRA=-pre-RA-sched=list-hybrid)
LLC_EXTRA?=
LLC_FLAGS=-O2 -mtriple=$(TRIPLE) $(if $(ATTR),-mattr=$(ATTR))
CXX=clang++
CXXFLAGS=-O2 -std=c++17 -Wall -Wextra -DBIT=$(BIT)
ifeq ($(TRIPLE),i686)
CXXFLAGS+=-m32
endif
# output names: sqr.ll / sqr32.ll / sqr32_i686.o ...
TAG?=
SFX=$(if $(filter 64,$(BIT)),,$(BIT))$(TAG)
# the reference IR is target independent: sqrRef.ll / sqrRef32.ll
REF_SFX=$(if $(filter 64,$(BIT)),,$(BIT))
# where the mcl-ff generated IR with llvm_n<N>_sqrPre lives (ref32/ is made by
# gen_ff.py -u 32, see readme.md)
REF_DIR?=$(if $(filter 32,$(BIT)),ref32,$(MCL_FF)/src)

all: bench$(SFX).exe

sqr$(SFX).ll: gen_sqr.py
	python3 $< -pre sqr -u $(BIT) > $@
sqrOpt$(SFX).ll: gen_sqr.py
	python3 $< -pre sqrOpt -u $(BIT) > $@

# reference: extract llvm_n<N>_sqrPre from mcl-ff's generated IR, rename it
# and rewrite the doubling add x,x to shl x,1 (see extract_ref.py)
ref:
	python3 extract_ref.py -dir $(REF_DIR) > sqrRef$(REF_SFX).ll

sqr$(SFX).o: sqr$(SFX).ll
	$(LLC_ORG) $(LLC_FLAGS) -filetype=obj -o $@ $<
sqrRef$(SFX).o: sqrRef$(REF_SFX).ll
	$(LLC_ORG) $(LLC_FLAGS) -filetype=obj -o $@ $<
sqrOpt$(SFX).o: sqrOpt$(SFX).ll
	$(LLC_NEW) $(LLC_FLAGS) $(LLC_EXTRA) -filetype=obj -o $@ $<

sqr$(SFX).s: sqr$(SFX).ll
	$(LLC_ORG) $(LLC_FLAGS) -o $@ $<
sqrRef$(SFX).s: sqrRef$(REF_SFX).ll
	$(LLC_ORG) $(LLC_FLAGS) -o $@ $<
sqrOpt$(SFX).s: sqrOpt$(SFX).ll
	$(LLC_NEW) $(LLC_FLAGS) $(LLC_EXTRA) -o $@ $<

asm: sqr$(SFX).s sqrOpt$(SFX).s sqrRef$(SFX).s

# instruction histogram per function
hist: asm
	@awk -f $(HIST_AWK) sqr$(SFX).s sqrOpt$(SFX).s sqrRef$(SFX).s

bench$(SFX).exe: bench.cpp sqr$(SFX).o sqrOpt$(SFX).o sqrRef$(SFX).o
	$(CXX) $(CXXFLAGS) -o $@ $^

run: bench$(SFX).exe
	$(TASKSET) ./bench$(SFX).exe

clean:
	rm -f sqr*.ll sqrOpt*.ll *.o *.s bench*.exe

.PHONY: all ref asm hist run clean

# Montgomery squaring with the reduction in the same function (mcl's Fp::sqr):
#   make mod && ./benchMod.exe      (gen_sqrmod.py needs ../../mcl-ff and ../../mcl)
sqrMod.ll: gen_sqrmod.py
	python3 $< -pre llvm_ > $@
sqrModOpt.ll: gen_sqrmod.py
	python3 $< -pre llvmOpt_ > $@
# -mul-constant-optimization=false as in mcl-ff: keep the multiplies by the
# constant limbs of p as multiplies
# opt is needed here to inline mulUnit etc. (clang -O2 does); the SLP
# vectorizer of LLVM main hurts sqrPre_raw (readme.md), so it is off by default
OPT?=../llvm/build.org/bin/opt
OPTFLAGS?=-O2 -vectorize-slp=false
sqrMod.o sqrMod.s: sqrMod.ll
	$(OPT) $(OPTFLAGS) -S $< | $(LLC_ORG) $(LLC_FLAGS) -mul-constant-optimization=false -relocation-model=pic $(if $(filter %.o,$@),-filetype=obj) -o $@
sqrModOpt.o sqrModOpt.s: sqrModOpt.ll
	$(OPT) $(OPTFLAGS) -S $< | $(LLC_NEW) $(LLC_FLAGS) $(LLC_EXTRA) -mul-constant-optimization=false -relocation-model=pic $(if $(filter %.o,$@),-filetype=obj) -o $@
benchMod.exe: benchMod.cpp sqrMod.o sqrModOpt.o
	$(CXX) $(CXXFLAGS) -o $@ $^
mod: benchMod.exe sqrMod.s sqrModOpt.s
	@awk -f $(HIST_AWK) sqrMod.s sqrModOpt.s | grep -v 'mul64x64L\|mulPos\|extractHigh\|get_prime'
.PHONY: mod
