@llvm_n4_p = dso_local local_unnamed_addr global i128 170141183460469231731687303715884105729
@ip = internal unnamed_addr constant i32 4294967295
@pStr = private unnamed_addr constant [35 x i8] c"0x80000000000000000000000000000001\00"
define i8* @llvm_n4_get_prime()
{
%r2 = bitcast [35 x i8] *@pStr to i8*
ret i8* %r2
}
define private i64 @mul32x32L(i32 %r2, i32 %r3)
{
%r4 = zext i32 %r2 to i64
%r5 = zext i32 %r3 to i64
%r6 = mul i64 %r4, %r5
ret i64 %r6
}
define private i32 @extractHigh32(i64 %r2)
{
%r3 = lshr i64 %r2, 32
%r4 = trunc i64 %r3 to i32
ret i32 %r4
}
define private i64 @mulPos32x32(i32* noalias %r2, i32 %r3, i32 %r4)
{
%r5 = getelementptr i32, i32* %r2, i32 %r4
%r6 = load i32, i32* %r5
%r7 = call i64 @mul32x32L(i32 %r6, i32 %r3)
ret i64 %r7
}
define private i160 @llvm_n4_mulUnit(i32* noalias %r2, i32 %r3) alwaysinline
{
%r4 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r5 = trunc i64 %r4 to i32
%r6 = call i32 @extractHigh32(i64 %r4)
%r7 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r8 = trunc i64 %r7 to i32
%r9 = call i32 @extractHigh32(i64 %r7)
%r10 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r11 = trunc i64 %r10 to i32
%r12 = call i32 @extractHigh32(i64 %r10)
%r13 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r14 = trunc i64 %r13 to i32
%r15 = call i32 @extractHigh32(i64 %r13)
%r16 = zext i32 %r5 to i64
%r17 = zext i32 %r8 to i64
%r18 = shl i64 %r17, 32
%r19 = or i64 %r16, %r18
%r20 = zext i64 %r19 to i96
%r21 = zext i32 %r11 to i96
%r22 = shl i96 %r21, 64
%r23 = or i96 %r20, %r22
%r24 = zext i96 %r23 to i128
%r25 = zext i32 %r14 to i128
%r26 = shl i128 %r25, 96
%r27 = or i128 %r24, %r26
%r28 = zext i32 %r6 to i64
%r29 = zext i32 %r9 to i64
%r30 = shl i64 %r29, 32
%r31 = or i64 %r28, %r30
%r32 = zext i64 %r31 to i96
%r33 = zext i32 %r12 to i96
%r34 = shl i96 %r33, 64
%r35 = or i96 %r32, %r34
%r36 = zext i96 %r35 to i128
%r37 = zext i32 %r15 to i128
%r38 = shl i128 %r37, 96
%r39 = or i128 %r36, %r38
%r40 = zext i128 %r27 to i160
%r41 = zext i128 %r39 to i160
%r42 = shl i160 %r41, 32
%r43 = add i160 %r40, %r42
ret i160 %r43
}
define void @llvm_n4_sqrPre(i32* noalias %r1, i32* noalias %r2)
{
%r3 = getelementptr i32, i32* %r2, i32 0
%r4 = load i32, i32* %r3
%r5 = getelementptr i32, i32* %r2, i32 1
%r6 = load i32, i32* %r5
%r7 = getelementptr i32, i32* %r2, i32 2
%r8 = load i32, i32* %r7
%r9 = getelementptr i32, i32* %r2, i32 3
%r10 = load i32, i32* %r9
%r11 = zext i32 %r4 to i64
%r12 = zext i32 %r10 to i64
%r13 = mul i64 %r11, %r12
%r14 = zext i32 %r4 to i64
%r15 = zext i32 %r8 to i64
%r16 = mul i64 %r14, %r15
%r17 = zext i32 %r6 to i64
%r18 = zext i32 %r10 to i64
%r19 = mul i64 %r17, %r18
%r20 = zext i64 %r16 to i128
%r21 = zext i64 %r19 to i128
%r22 = shl i128 %r21, 64
%r23 = or i128 %r20, %r22
%r24 = zext i64 %r13 to i128
%r25 = shl i128 %r24, 32
%r26 = add i128 %r25, %r23
%r27 = zext i32 %r4 to i64
%r28 = zext i32 %r6 to i64
%r29 = mul i64 %r27, %r28
%r30 = zext i32 %r6 to i64
%r31 = zext i32 %r8 to i64
%r32 = mul i64 %r30, %r31
%r33 = zext i32 %r8 to i64
%r34 = zext i32 %r10 to i64
%r35 = mul i64 %r33, %r34
%r36 = zext i64 %r29 to i128
%r37 = zext i64 %r32 to i128
%r38 = shl i128 %r37, 64
%r39 = or i128 %r36, %r38
%r40 = zext i128 %r39 to i192
%r41 = zext i64 %r35 to i192
%r42 = shl i192 %r41, 128
%r43 = or i192 %r40, %r42
%r44 = zext i128 %r26 to i192
%r45 = shl i192 %r44, 32
%r46 = add i192 %r45, %r43
%r47 = zext i192 %r46 to i224
%r48 = add i224 %r47, %r47
%r49 = zext i224 %r48 to i256
%r50 = shl i256 %r49, 32
%r51 = zext i32 %r4 to i64
%r52 = zext i32 %r4 to i64
%r53 = mul i64 %r51, %r52
%r54 = zext i32 %r6 to i64
%r55 = zext i32 %r6 to i64
%r56 = mul i64 %r54, %r55
%r57 = zext i32 %r8 to i64
%r58 = zext i32 %r8 to i64
%r59 = mul i64 %r57, %r58
%r60 = zext i32 %r10 to i64
%r61 = zext i32 %r10 to i64
%r62 = mul i64 %r60, %r61
%r63 = zext i64 %r53 to i128
%r64 = zext i64 %r56 to i128
%r65 = shl i128 %r64, 64
%r66 = or i128 %r63, %r65
%r67 = zext i128 %r66 to i192
%r68 = zext i64 %r59 to i192
%r69 = shl i192 %r68, 128
%r70 = or i192 %r67, %r69
%r71 = zext i192 %r70 to i256
%r72 = zext i64 %r62 to i256
%r73 = shl i256 %r72, 192
%r74 = or i256 %r71, %r73
%r75 = add i256 %r50, %r74
%r76 = bitcast i32* %r1 to i256*
store i256 %r75, i256* %r76
ret void
}
