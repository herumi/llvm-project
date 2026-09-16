#!/usr/bin/env python3
# Extract llvm_n<N>_sqrPre from mcl-ff's generated IR (mulPre_llvm_n<N>.ll),
# rename it to sqrRef<N> and rewrite the doubling "add x, x" to "shl x, 1" as
# InstCombine (clang -O2) would do (llc alone keeps it as an adc chain).
# opt -O2 of LLVM main is not used because it reorders the loads (readme.md).
import argparse, re, sys

def main():
    p = argparse.ArgumentParser()
    p.add_argument('-dir', required=True, help='directory of mulPre_llvm_n<N>.ll')
    p.add_argument('-n', default='2,3,4,5,6,7,8')
    opt = p.parse_args()
    add_xx = re.compile(r'^(%r\d+) = add (i\d+) (%r\d+), \3$')
    for n in map(int, opt.n.split(',')):
        name = f'llvm_n{n}_sqrPre'
        out = []
        on = False
        for line in open(f'{opt.dir}/mulPre_llvm_n{n}.ll'):
            line = line.rstrip('\n')
            if line.startswith(f'define void @{name}('):
                on = True
            if on:
                line = line.replace(f'@{name}', f'@sqrRef{n}')
                line = add_xx.sub(r'\1 = shl \2 \3, 1', line)
                out.append(line)
                if line == '}':
                    break
        if not on:
            sys.exit(f'{name} not found')
        print('\n'.join(out))
        print()

if __name__ == '__main__':
    main()
