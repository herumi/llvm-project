# ワイド整数 2 乗 (`mul iK %x, %x`) のベンチ

`z[2N] = x[N]^2` (N = 2..8、BIT=64 なら Unit = uint64_t) を 3 通りの生成コードで比べる。他ライブラリに依存しない。

- `sqr<N>`: `mul i(2uN) (zext x), (zext x)` (mcl-ff の sqrPreWide と同じ IR、gen_sqr.py が生成) をオリジナル llc (`../llvm/build.org/bin/llc`) でコンパイル。
- `sqrOpt<N>`: 同じ IR をパッチ付き llc (`../llvm/build/bin/llc`) でコンパイル。
- `sqrRef<N>`: mcl-ff の手組み sqrPre (`../../mcl-ff/src/mulPre_llvm_n<N>.ll` の `llvm_n<N>_sqrPre`、反対角線スケジュール) をオリジナル llc でコンパイルした参照。

すべて `opt -O2` (オリジナル側) を通してから `llc -O2 -mtriple=x86_64 -mattr=+bmi2` で .o にする (mcl-ff の `clang -O2 -mbmi2` 相当。opt なしだと参照 IR の `add x,x` が shl にならず命令数が変わる)。

## 使い方

```
make ref        # sqrRef.ll を mcl-ff の生成済み IR から抽出 (mcl-ff で make 済みであること)
make            # sqr.ll / sqrOpt.ll 生成、.o、bench.exe
make run        # taskset -c 3 ./bench.exe (正しさチェック → throughput → latency)
make hist       # 3 変種の .s を出して関数ごとの命令ヒストグラム
make BIT=32 ... # 32 bit unit (未検証)
```

`bench.exe -nolat` で latency 測定を省く。throughput は P=4 の独立ストリーム、latency は z の下位 N limb を次の x に戻す直列鎖。単位は ns/op。

## 結果 (2026-09-16、Xeon w9-3495X、taskset -c 3、ns/op)

パッチ: `TargetLowering::expandWideSquare` (反対角線スケジュール + 生成ノードごとの IROrder)。

throughput (P=4):

```
 N       sqr    sqrOpt    sqrRef  sqrOpt/sqr  sqrRef/sqr
 2     1.122     1.105     1.091       0.98x       0.97x
 3     2.222     1.961     1.963       0.88x       0.88x
 4     4.289     3.299     3.272       0.77x       0.76x
 5     9.172     4.803     4.819       0.52x       0.53x
 6    10.207     6.940     6.596       0.68x       0.65x
 7    14.711     8.691     9.594       0.59x       0.65x
 8    18.527    10.778    10.804       0.58x       0.58x
```

latency (直列鎖) も同じ傾向 (N=6: 10.23 / 6.90 / 6.60、N=8: 19.03 / 11.25 / 11.10)。

命令ヒストグラム (make hist、N=6): sqr 236 (mulx 21 / adc 58 / add 38 / setb 13 / movzbl 13、rsp 参照 54)、sqrOpt 137 (mulx 21 / adc 30 / add 6 / shld 9、rsp 22)、sqrRef 142 (rsp 26)。

注意: LLVM main の `opt -O2` (SLP vectorizer) は sqrRef の IR のロードを並べ替えて 218 命令 (mov 112) に悪化させるので、この Makefile は opt を通さず、`add x,x` を sed で `shl x,1` にしてから llc だけを使う。

## BIT=32 (Unit = uint32_t、N = 2..8 limb = 64..256 bit、2026-09-16)

参照 IR は `ref32/mulPre_llvm_n<N>.ll` (mcl-ff で `python3 src/gen_ff.py -u 32 -p $(python3 -c "print(hex((1<<(32*N-1))+1))") -pre llvm_nN_ -sqrPre` を N=2..8 で実行して保存したもの)。`make BIT=32 ref` で `sqrRef32.ll` に抽出する。

### x86_64 (+bmi2) で 32 bit unit: `make BIT=32 ref bench32.exe run`

LLVM は 32 bit unit の IR でも i64 limb で展開するので (N=8 の i512 は 64 bit limb 4 個)、32 bit limb で手組みした参照 (mul 36 個) は 2.4〜2.9 倍遅い。sqrOpt の効果は 64 bit limb が 3 個以上になる N=6 以降で 0.77〜0.80x。

```
 N       sqr    sqrOpt    sqrRef  sqrOpt/sqr  sqrRef/sqr
 2     1.021     0.920     1.035       0.90x       1.01x
 4     1.091     1.091     2.833       1.00x       2.60x
 6     2.501     1.994     6.791       0.80x       2.72x
 8     4.361     3.358    12.559       0.77x       2.88x
```

### i686 (-m32、-mattr なし) で 32 bit unit: `make BIT=32 TRIPLE=i686 ATTR= TAG=_i686 ref run`

limb が i32 (mull) になる本来の 32 bit 比較。sqrOpt は元の 0.67〜0.78x で、手組み参照 (0.73〜0.85x) より速い。命令数 N=8: sqr 531 (mul 36 / adc 112 / add 69 / setb 21、sp 参照 257)、sqrOpt 348 (adc 56 / add 9 / shld 13、sp 224)、sqrRef 376 (sp 247)。

```
 N       sqr    sqrOpt    sqrRef  sqrOpt/sqr  sqrRef/sqr
 2     1.917     2.141     2.208       1.12x       1.15x
 3     3.446     3.073     3.926       0.89x       1.14x
 4     7.118     5.585     5.714       0.78x       0.80x
 5    11.022     7.978     8.900       0.72x       0.81x
 6    15.039    11.555    12.833       0.77x       0.85x
 7    23.539    15.705    17.453       0.67x       0.74x
 8    31.293    21.851    22.727       0.70x       0.73x
```

## Apple M4 (macOS、arm64) で測るとき

- `uname -m` が arm64 なら Makefile の既定は `TRIPLE=arm64-apple-macosx`、`ATTR=` (空)、ヒストグラムは `hist_a64.awk`、`run` は taskset なし。コマンドは Linux と同じ (`make ref && make && make run`、`make hist`、BIT=32 は `make BIT=32 ref bench32.exe run`)。
- llc は `../llvm/build.org/bin/llc` (main) と `../llvm/build/bin/llc` (ブランチ sqr-wide-mul) を macOS 上でビルドする (手順は memo.md 2026-09-16 (2))。
- `sqrRef.ll` / `sqrRef32.ll` / `ref32/` は生成済みでターゲット非依存なので、work/ ごとコピーすれば mcl-ff は要らない (`make ref` を実行しなければ上書きされない)。
- Linux で出した aarch64 のヒストグラム (`make TRIPLE=aarch64 ATTR= TAG=_a64 hist`) では sqrOpt と sqrRef はほぼ同一 (N=6: 120 / 119 命令、sp 参照 20 / 19、mul 21 + umulh 21 + adcs 25 + extr 9; N=8: 216 / 215)。元の llc は N=6 187 命令 (adds 46 / adcs 25 / cinc 36)、N=8 379 命令。

## 還元が続く場合 (mcl の Fp::sqr 相当、BLS12-381-p N=6): `make mod && ./benchMod.exe`

gen_sqrmod.py (mcl-ff / mcl の DSL を使う) で 3 形を生成し、`opt -O2 -vectorize-slp=false` (clang-21 相当) → llc でコンパイル。mul(x,x) は CIOS (mcl の現在の Fp::sqr)、sqrWide は `mul i768 (zext x),(zext x)` の後に emit_montRed、sqrFused は sqrPre_raw の後に emit_montRed (mcl-ff の llvm_sqr)。org = 元 llc、opt = パッチ llc。

```
               throughput      latency
mul(x,x) org     19.215 (1.00x)   23.193
mul(x,x) opt     19.433 (1.01x)   22.625
sqrWide org      24.960 (1.30x)   29.321
sqrWide opt      21.344 (1.11x)   25.481
sqrFused org     21.995 (1.14x)   26.361
sqrFused opt     21.489 (1.12x)   25.760
```

- パッチはワイド mul + 還元の形を 25.0 → 21.3 ns (命令 448 → 362、setb 18 → 5) に改善し、手組み融合版 (22.0) に並ぶ。IROrder が還元の命令と重なる副作用は見えない。
- ただし CIOS (mul しながら還元) の 19.2 ns には届かない。2 乗してから還元する形は 12 limb の積が全部生きた状態で還元に入るので、乗算が 72 → 57 に減ってもスピル (sp 参照 98 → 121) に食われる (mcl-ff memo 2026-07-27 と同じ結論)。
- 素の `opt -O2` (LLVM main) だと SLP vectorizer のせいで CIOS の mul まで 335 → 550 命令、19.2 → 32.0 ns に悪化する (opt-21 の -O2 は 335 命令で main の `-vectorize-slp=false` と同じ)。mcl を将来の clang でビルドするときは要確認。
