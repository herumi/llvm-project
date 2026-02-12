#!/bin/bash
set -e

OPT="-O2 -mattr=+bmi2"

echo "=== Building bench.ll from bench.c ==="
clang-18 -O2 -S -emit-llvm bench.c -o bench.ll

echo ""
echo "=== Compiling with original llc-18 ==="
echo llc-18 $OPT bench.ll -o bench_original.s
llc-18 $OPT bench.ll -o bench_original.s

echo ""
echo "=== Compiling with optimized llc ==="
echo llvm/build/bin/llc $OPT bench.ll -o bench_optimized.s
llvm/build/bin/llc $OPT bench.ll -o bench_optimized.s

echo ""
echo "=== Building executables ==="
clang-18 -no-pie bench_original.s -o bench_original
clang-18 -no-pie bench_optimized.s -o bench_optimized

echo ""
echo "=== Running benchmarks ==="
echo ""
echo "--- Original (llc-18) ---"
./bench_original
./bench_original 1

echo ""
echo "--- Optimized (new llc with udiv optimization) ---"
./bench_optimized
./bench_optimized 1

echo ""
echo "=== Done ==="
