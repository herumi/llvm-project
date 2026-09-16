#!/usr/bin/env python3
# Emit sqr<N>(z, x): z[2N] = x[N]^2 as a single wide LLVM mul, the same
# shape as gen_sqrPreWide of mcl-ff/src/gen_ff.py:
#   load i(uN) -> zext to i(2uN) -> mul x, x -> store
# The same IR is compiled by the original and the patched llc, so only the
# symbol prefix differs (-pre sqr / -pre sqrOpt).
import argparse

def main():
    p = argparse.ArgumentParser()
    p.add_argument('-pre', default='sqr', help='function name prefix')
    p.add_argument('-u', type=int, default=64, help='unit bit size (64 or 32)')
    p.add_argument('-n', default='2,3,4,5,6,7,8', help='comma separated limb counts')
    opt = p.parse_args()
    u = opt.u
    for n in map(int, opt.n.split(',')):
        bit = u * n
        print(f'define void @{opt.pre}{n}(ptr noalias %z, ptr noalias %x) {{')
        print(f'  %a = load i{bit}, ptr %x')
        print(f'  %b = zext i{bit} %a to i{bit * 2}')
        print(f'  %c = mul i{bit * 2} %b, %b')
        print(f'  store i{bit * 2} %c, ptr %z')
        print('  ret void')
        print('}')
        print()

if __name__ == '__main__':
    main()
