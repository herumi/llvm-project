@llvm_n5_p = dso_local local_unnamed_addr global i160 730750818665451459101842416358141509827966271489
@ip = internal unnamed_addr constant i32 4294967295
@pStr = private unnamed_addr constant [43 x i8] c"0x8000000000000000000000000000000000000001\00"
define i8* @llvm_n5_get_prime()
{
%r2 = bitcast [43 x i8] *@pStr to i8*
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
define private i192 @llvm_n5_mulUnit(i32* noalias %r2, i32 %r3) alwaysinline
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
%r16 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r17 = trunc i64 %r16 to i32
%r18 = call i32 @extractHigh32(i64 %r16)
%r19 = zext i32 %r5 to i64
%r20 = zext i32 %r8 to i64
%r21 = shl i64 %r20, 32
%r22 = or i64 %r19, %r21
%r23 = zext i64 %r22 to i96
%r24 = zext i32 %r11 to i96
%r25 = shl i96 %r24, 64
%r26 = or i96 %r23, %r25
%r27 = zext i96 %r26 to i128
%r28 = zext i32 %r14 to i128
%r29 = shl i128 %r28, 96
%r30 = or i128 %r27, %r29
%r31 = zext i128 %r30 to i160
%r32 = zext i32 %r17 to i160
%r33 = shl i160 %r32, 128
%r34 = or i160 %r31, %r33
%r35 = zext i32 %r6 to i64
%r36 = zext i32 %r9 to i64
%r37 = shl i64 %r36, 32
%r38 = or i64 %r35, %r37
%r39 = zext i64 %r38 to i96
%r40 = zext i32 %r12 to i96
%r41 = shl i96 %r40, 64
%r42 = or i96 %r39, %r41
%r43 = zext i96 %r42 to i128
%r44 = zext i32 %r15 to i128
%r45 = shl i128 %r44, 96
%r46 = or i128 %r43, %r45
%r47 = zext i128 %r46 to i160
%r48 = zext i32 %r18 to i160
%r49 = shl i160 %r48, 128
%r50 = or i160 %r47, %r49
%r51 = zext i160 %r34 to i192
%r52 = zext i160 %r50 to i192
%r53 = shl i192 %r52, 32
%r54 = add i192 %r51, %r53
ret i192 %r54
}
define void @llvm_n5_sqrPre(i32* noalias %r1, i32* noalias %r2)
{
%r3 = getelementptr i32, i32* %r2, i32 0
%r4 = load i32, i32* %r3
%r5 = getelementptr i32, i32* %r2, i32 1
%r6 = load i32, i32* %r5
%r7 = getelementptr i32, i32* %r2, i32 2
%r8 = load i32, i32* %r7
%r9 = getelementptr i32, i32* %r2, i32 3
%r10 = load i32, i32* %r9
%r11 = getelementptr i32, i32* %r2, i32 4
%r12 = load i32, i32* %r11
%r13 = zext i32 %r4 to i64
%r14 = zext i32 %r12 to i64
%r15 = mul i64 %r13, %r14
%r16 = zext i32 %r4 to i64
%r17 = zext i32 %r10 to i64
%r18 = mul i64 %r16, %r17
%r19 = zext i32 %r6 to i64
%r20 = zext i32 %r12 to i64
%r21 = mul i64 %r19, %r20
%r22 = zext i64 %r18 to i128
%r23 = zext i64 %r21 to i128
%r24 = shl i128 %r23, 64
%r25 = or i128 %r22, %r24
%r26 = zext i64 %r15 to i128
%r27 = shl i128 %r26, 32
%r28 = add i128 %r27, %r25
%r29 = zext i32 %r4 to i64
%r30 = zext i32 %r8 to i64
%r31 = mul i64 %r29, %r30
%r32 = zext i32 %r6 to i64
%r33 = zext i32 %r10 to i64
%r34 = mul i64 %r32, %r33
%r35 = zext i32 %r8 to i64
%r36 = zext i32 %r12 to i64
%r37 = mul i64 %r35, %r36
%r38 = zext i64 %r31 to i128
%r39 = zext i64 %r34 to i128
%r40 = shl i128 %r39, 64
%r41 = or i128 %r38, %r40
%r42 = zext i128 %r41 to i192
%r43 = zext i64 %r37 to i192
%r44 = shl i192 %r43, 128
%r45 = or i192 %r42, %r44
%r46 = zext i128 %r28 to i192
%r47 = shl i192 %r46, 32
%r48 = add i192 %r47, %r45
%r49 = zext i32 %r4 to i64
%r50 = zext i32 %r6 to i64
%r51 = mul i64 %r49, %r50
%r52 = zext i32 %r6 to i64
%r53 = zext i32 %r8 to i64
%r54 = mul i64 %r52, %r53
%r55 = zext i32 %r8 to i64
%r56 = zext i32 %r10 to i64
%r57 = mul i64 %r55, %r56
%r58 = zext i32 %r10 to i64
%r59 = zext i32 %r12 to i64
%r60 = mul i64 %r58, %r59
%r61 = zext i64 %r51 to i128
%r62 = zext i64 %r54 to i128
%r63 = shl i128 %r62, 64
%r64 = or i128 %r61, %r63
%r65 = zext i128 %r64 to i192
%r66 = zext i64 %r57 to i192
%r67 = shl i192 %r66, 128
%r68 = or i192 %r65, %r67
%r69 = zext i192 %r68 to i256
%r70 = zext i64 %r60 to i256
%r71 = shl i256 %r70, 192
%r72 = or i256 %r69, %r71
%r73 = zext i192 %r48 to i256
%r74 = shl i256 %r73, 32
%r75 = add i256 %r74, %r72
%r76 = zext i256 %r75 to i288
%r77 = add i288 %r76, %r76
%r78 = zext i288 %r77 to i320
%r79 = shl i320 %r78, 32
%r80 = zext i32 %r4 to i64
%r81 = zext i32 %r4 to i64
%r82 = mul i64 %r80, %r81
%r83 = zext i32 %r6 to i64
%r84 = zext i32 %r6 to i64
%r85 = mul i64 %r83, %r84
%r86 = zext i32 %r8 to i64
%r87 = zext i32 %r8 to i64
%r88 = mul i64 %r86, %r87
%r89 = zext i32 %r10 to i64
%r90 = zext i32 %r10 to i64
%r91 = mul i64 %r89, %r90
%r92 = zext i32 %r12 to i64
%r93 = zext i32 %r12 to i64
%r94 = mul i64 %r92, %r93
%r95 = zext i64 %r82 to i128
%r96 = zext i64 %r85 to i128
%r97 = shl i128 %r96, 64
%r98 = or i128 %r95, %r97
%r99 = zext i128 %r98 to i192
%r100 = zext i64 %r88 to i192
%r101 = shl i192 %r100, 128
%r102 = or i192 %r99, %r101
%r103 = zext i192 %r102 to i256
%r104 = zext i64 %r91 to i256
%r105 = shl i256 %r104, 192
%r106 = or i256 %r103, %r105
%r107 = zext i256 %r106 to i320
%r108 = zext i64 %r94 to i320
%r109 = shl i320 %r108, 256
%r110 = or i320 %r107, %r109
%r111 = add i320 %r79, %r110
%r112 = bitcast i32* %r1 to i320*
store i320 %r111, i320* %r112
ret void
}
