@llvm_n4_p = dso_local local_unnamed_addr global i256 57896044618658097711785492504343953926634992332820282019728792003956564819969
@ip = internal unnamed_addr constant i64 18446744073709551615
@pStr = private unnamed_addr constant [67 x i8] c"0x8000000000000000000000000000000000000000000000000000000000000001\00"
define i8* @llvm_n4_get_prime()
{
%r2 = bitcast [67 x i8] *@pStr to i8*
ret i8* %r2
}
define private i128 @mul64x64L(i64 %r2, i64 %r3)
{
%r4 = zext i64 %r2 to i128
%r5 = zext i64 %r3 to i128
%r6 = mul i128 %r4, %r5
ret i128 %r6
}
define private i64 @extractHigh64(i128 %r2)
{
%r3 = lshr i128 %r2, 64
%r4 = trunc i128 %r3 to i64
ret i64 %r4
}
define private i128 @mulPos64x64(i64* noalias %r2, i64 %r3, i64 %r4)
{
%r5 = getelementptr i64, i64* %r2, i64 %r4
%r6 = load i64, i64* %r5
%r7 = call i128 @mul64x64L(i64 %r6, i64 %r3)
ret i128 %r7
}
define private i320 @llvm_n4_mulUnit(i64* noalias %r2, i64 %r3) alwaysinline
{
%r4 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r5 = trunc i128 %r4 to i64
%r6 = call i64 @extractHigh64(i128 %r4)
%r7 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r8 = trunc i128 %r7 to i64
%r9 = call i64 @extractHigh64(i128 %r7)
%r10 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 2)
%r11 = trunc i128 %r10 to i64
%r12 = call i64 @extractHigh64(i128 %r10)
%r13 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 3)
%r14 = trunc i128 %r13 to i64
%r15 = call i64 @extractHigh64(i128 %r13)
%r16 = zext i64 %r5 to i128
%r17 = zext i64 %r8 to i128
%r18 = shl i128 %r17, 64
%r19 = or i128 %r16, %r18
%r20 = zext i128 %r19 to i192
%r21 = zext i64 %r11 to i192
%r22 = shl i192 %r21, 128
%r23 = or i192 %r20, %r22
%r24 = zext i192 %r23 to i256
%r25 = zext i64 %r14 to i256
%r26 = shl i256 %r25, 192
%r27 = or i256 %r24, %r26
%r28 = zext i64 %r6 to i128
%r29 = zext i64 %r9 to i128
%r30 = shl i128 %r29, 64
%r31 = or i128 %r28, %r30
%r32 = zext i128 %r31 to i192
%r33 = zext i64 %r12 to i192
%r34 = shl i192 %r33, 128
%r35 = or i192 %r32, %r34
%r36 = zext i192 %r35 to i256
%r37 = zext i64 %r15 to i256
%r38 = shl i256 %r37, 192
%r39 = or i256 %r36, %r38
%r40 = zext i256 %r27 to i320
%r41 = zext i256 %r39 to i320
%r42 = shl i320 %r41, 64
%r43 = add i320 %r40, %r42
ret i320 %r43
}
define void @llvm_n4_sqrPre(i64* noalias %r1, i64* noalias %r2)
{
%r3 = getelementptr i64, i64* %r2, i32 0
%r4 = load i64, i64* %r3
%r5 = getelementptr i64, i64* %r2, i32 1
%r6 = load i64, i64* %r5
%r7 = getelementptr i64, i64* %r2, i32 2
%r8 = load i64, i64* %r7
%r9 = getelementptr i64, i64* %r2, i32 3
%r10 = load i64, i64* %r9
%r11 = zext i64 %r4 to i128
%r12 = zext i64 %r10 to i128
%r13 = mul i128 %r11, %r12
%r14 = zext i64 %r4 to i128
%r15 = zext i64 %r8 to i128
%r16 = mul i128 %r14, %r15
%r17 = zext i64 %r6 to i128
%r18 = zext i64 %r10 to i128
%r19 = mul i128 %r17, %r18
%r20 = zext i128 %r16 to i256
%r21 = zext i128 %r19 to i256
%r22 = shl i256 %r21, 128
%r23 = or i256 %r20, %r22
%r24 = zext i128 %r13 to i256
%r25 = shl i256 %r24, 64
%r26 = add i256 %r25, %r23
%r27 = zext i64 %r4 to i128
%r28 = zext i64 %r6 to i128
%r29 = mul i128 %r27, %r28
%r30 = zext i64 %r6 to i128
%r31 = zext i64 %r8 to i128
%r32 = mul i128 %r30, %r31
%r33 = zext i64 %r8 to i128
%r34 = zext i64 %r10 to i128
%r35 = mul i128 %r33, %r34
%r36 = zext i128 %r29 to i256
%r37 = zext i128 %r32 to i256
%r38 = shl i256 %r37, 128
%r39 = or i256 %r36, %r38
%r40 = zext i256 %r39 to i384
%r41 = zext i128 %r35 to i384
%r42 = shl i384 %r41, 256
%r43 = or i384 %r40, %r42
%r44 = zext i256 %r26 to i384
%r45 = shl i384 %r44, 64
%r46 = add i384 %r45, %r43
%r47 = zext i384 %r46 to i448
%r48 = add i448 %r47, %r47
%r49 = zext i448 %r48 to i512
%r50 = shl i512 %r49, 64
%r51 = zext i64 %r4 to i128
%r52 = zext i64 %r4 to i128
%r53 = mul i128 %r51, %r52
%r54 = zext i64 %r6 to i128
%r55 = zext i64 %r6 to i128
%r56 = mul i128 %r54, %r55
%r57 = zext i64 %r8 to i128
%r58 = zext i64 %r8 to i128
%r59 = mul i128 %r57, %r58
%r60 = zext i64 %r10 to i128
%r61 = zext i64 %r10 to i128
%r62 = mul i128 %r60, %r61
%r63 = zext i128 %r53 to i256
%r64 = zext i128 %r56 to i256
%r65 = shl i256 %r64, 128
%r66 = or i256 %r63, %r65
%r67 = zext i256 %r66 to i384
%r68 = zext i128 %r59 to i384
%r69 = shl i384 %r68, 256
%r70 = or i384 %r67, %r69
%r71 = zext i384 %r70 to i512
%r72 = zext i128 %r62 to i512
%r73 = shl i512 %r72, 384
%r74 = or i512 %r71, %r73
%r75 = add i512 %r50, %r74
%r76 = bitcast i64* %r1 to i512*
store i512 %r75, i512* %r76
ret void
}
