#!/usr/bin/env python3
# Montgomery squaring z = x^2 R^-1 mod p (BLS12-381-p, N = 6 x 64 bit) in three
# shapes, to see how the wide-mul expansion behaves when the reduction follows
# in the same function (mcl's Fp::sqr):
#   {pre}mul(z, x, y)   : CIOS (common.emit_mont), mcl's current Fp::sqr is mul(z, x, x)
#   {pre}sqrWide(z, x)  : mul i768 (zext x), (zext x), then common.emit_montRed
#   {pre}sqrFused(z, x) : common.sqrPre_raw, then common.emit_montRed (mcl-ff's llvm_sqr)
# Uses the DSL and helpers of mcl-ff / mcl (MCLFF_DIR, MCL_DIR).
import os, sys, argparse
mclffDir = os.environ.get('MCLFF_DIR', '../../mcl-ff')
mclDir = os.environ.get('MCL_DIR', '../../mcl')
sys.path.append(os.path.join(mclDir, 'src'))
sys.path.append(os.path.join(mclffDir, 'src'))
from s_xbyak_llvm import *
from mont import *
from primetbl import *
import common

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-pre', default='llvm_')
    parser.add_argument('-type', default='BLS12-381-p')
    parser.add_argument('-u', type=int, default=64)
    opt = parser.parse_args()
    p = primeTbl[opt.type].p
    mont = Montgomery(p, opt.u)
    unit = mont.L
    N = mont.pn
    bit = unit * N
    dataVar = makeVar(f'{opt.pre}p', mont.bit, mont.p, const=False, static=False)
    mulUU = common.gen_mulUU(unit)
    extractHigh = common.gen_extractHigh(unit)
    mulPos = common.gen_mulPos(unit, mulUU)
    mulUnit = common.gen_mulPv(f'{opt.pre}mulUnit', unit, N, mulPos, extractHigh, private=True, alwaysinline=True)

    resetGlobalIdx()
    pz = IntPtr(unit)
    px = IntPtr(unit)
    py = IntPtr(unit)
    with Function(f'{opt.pre}mul', Void, pz, px, py):
        pp = bitcast(dataVar, unit)
        common.emit_mont(unit, N, pz, px, py, pp, mont.ip, mulUnit, mont.isFullBit)
        ret(Void)

    resetGlobalIdx()
    pz = IntPtr(unit)
    px = IntPtr(unit)
    with Function(f'{opt.pre}sqrWide', Void, pz, px):
        pp = bitcast(dataVar, unit)
        x = zext(loadN(px, N), bit * 2)
        xy = mul(x, x)
        lo = trunc(xy, bit)
        p = loadN(pp, N)
        z = common.emit_montRed(unit, N, lo, lambda i: trunc(lshr(xy, bit + i * unit), unit), pp, p, mont.ip, mulUnit, mont.isFullBit)
        storeN(z, pz)
        ret(Void)

    resetGlobalIdx()
    pz = IntPtr(unit)
    px = IntPtr(unit)
    with Function(f'{opt.pre}sqrFused', Void, pz, px):
        pp = bitcast(dataVar, unit)
        x = [load(getelementptr(px, i)) for i in range(N)]
        xy = common.sqrPre_raw(unit, x, N)
        lo = trunc(xy, bit)
        p = loadN(pp, N)
        z = common.emit_montRed(unit, N, lo, lambda i: trunc(lshr(xy, bit + i * unit), unit), pp, p, mont.ip, mulUnit, mont.isFullBit)
        storeN(z, pz)
        ret(Void)
    term()

if __name__ == '__main__':
    main()
