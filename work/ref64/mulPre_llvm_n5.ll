@llvm_n5_p = dso_local local_unnamed_addr global i320 1067993517960455041197510853084776057301352261178326384973520803911109862890320275011481043468289
@ip = internal unnamed_addr constant i64 18446744073709551615
@pStr = private unnamed_addr constant [83 x i8] c"0x80000000000000000000000000000000000000000000000000000000000000000000000000000001\00"
define i8* @llvm_n5_get_prime()
{
%r2 = bitcast [83 x i8] *@pStr to i8*
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
define private i384 @llvm_n5_mulUnit(i64* noalias %r2, i64 %r3) alwaysinline
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
%r16 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 4)
%r17 = trunc i128 %r16 to i64
%r18 = call i64 @extractHigh64(i128 %r16)
%r19 = zext i64 %r5 to i128
%r20 = zext i64 %r8 to i128
%r21 = shl i128 %r20, 64
%r22 = or i128 %r19, %r21
%r23 = zext i128 %r22 to i192
%r24 = zext i64 %r11 to i192
%r25 = shl i192 %r24, 128
%r26 = or i192 %r23, %r25
%r27 = zext i192 %r26 to i256
%r28 = zext i64 %r14 to i256
%r29 = shl i256 %r28, 192
%r30 = or i256 %r27, %r29
%r31 = zext i256 %r30 to i320
%r32 = zext i64 %r17 to i320
%r33 = shl i320 %r32, 256
%r34 = or i320 %r31, %r33
%r35 = zext i64 %r6 to i128
%r36 = zext i64 %r9 to i128
%r37 = shl i128 %r36, 64
%r38 = or i128 %r35, %r37
%r39 = zext i128 %r38 to i192
%r40 = zext i64 %r12 to i192
%r41 = shl i192 %r40, 128
%r42 = or i192 %r39, %r41
%r43 = zext i192 %r42 to i256
%r44 = zext i64 %r15 to i256
%r45 = shl i256 %r44, 192
%r46 = or i256 %r43, %r45
%r47 = zext i256 %r46 to i320
%r48 = zext i64 %r18 to i320
%r49 = shl i320 %r48, 256
%r50 = or i320 %r47, %r49
%r51 = zext i320 %r34 to i384
%r52 = zext i320 %r50 to i384
%r53 = shl i384 %r52, 64
%r54 = add i384 %r51, %r53
ret i384 %r54
}
define void @llvm_n5_sqrPre(i64* noalias %r1, i64* noalias %r2)
{
%r3 = getelementptr i64, i64* %r2, i32 0
%r4 = load i64, i64* %r3
%r5 = getelementptr i64, i64* %r2, i32 1
%r6 = load i64, i64* %r5
%r7 = getelementptr i64, i64* %r2, i32 2
%r8 = load i64, i64* %r7
%r9 = getelementptr i64, i64* %r2, i32 3
%r10 = load i64, i64* %r9
%r11 = getelementptr i64, i64* %r2, i32 4
%r12 = load i64, i64* %r11
%r13 = zext i64 %r4 to i128
%r14 = zext i64 %r12 to i128
%r15 = mul i128 %r13, %r14
%r16 = zext i64 %r4 to i128
%r17 = zext i64 %r10 to i128
%r18 = mul i128 %r16, %r17
%r19 = zext i64 %r6 to i128
%r20 = zext i64 %r12 to i128
%r21 = mul i128 %r19, %r20
%r22 = zext i128 %r18 to i256
%r23 = zext i128 %r21 to i256
%r24 = shl i256 %r23, 128
%r25 = or i256 %r22, %r24
%r26 = zext i128 %r15 to i256
%r27 = shl i256 %r26, 64
%r28 = add i256 %r27, %r25
%r29 = zext i64 %r4 to i128
%r30 = zext i64 %r8 to i128
%r31 = mul i128 %r29, %r30
%r32 = zext i64 %r6 to i128
%r33 = zext i64 %r10 to i128
%r34 = mul i128 %r32, %r33
%r35 = zext i64 %r8 to i128
%r36 = zext i64 %r12 to i128
%r37 = mul i128 %r35, %r36
%r38 = zext i128 %r31 to i256
%r39 = zext i128 %r34 to i256
%r40 = shl i256 %r39, 128
%r41 = or i256 %r38, %r40
%r42 = zext i256 %r41 to i384
%r43 = zext i128 %r37 to i384
%r44 = shl i384 %r43, 256
%r45 = or i384 %r42, %r44
%r46 = zext i256 %r28 to i384
%r47 = shl i384 %r46, 64
%r48 = add i384 %r47, %r45
%r49 = zext i64 %r4 to i128
%r50 = zext i64 %r6 to i128
%r51 = mul i128 %r49, %r50
%r52 = zext i64 %r6 to i128
%r53 = zext i64 %r8 to i128
%r54 = mul i128 %r52, %r53
%r55 = zext i64 %r8 to i128
%r56 = zext i64 %r10 to i128
%r57 = mul i128 %r55, %r56
%r58 = zext i64 %r10 to i128
%r59 = zext i64 %r12 to i128
%r60 = mul i128 %r58, %r59
%r61 = zext i128 %r51 to i256
%r62 = zext i128 %r54 to i256
%r63 = shl i256 %r62, 128
%r64 = or i256 %r61, %r63
%r65 = zext i256 %r64 to i384
%r66 = zext i128 %r57 to i384
%r67 = shl i384 %r66, 256
%r68 = or i384 %r65, %r67
%r69 = zext i384 %r68 to i512
%r70 = zext i128 %r60 to i512
%r71 = shl i512 %r70, 384
%r72 = or i512 %r69, %r71
%r73 = zext i384 %r48 to i512
%r74 = shl i512 %r73, 64
%r75 = add i512 %r74, %r72
%r76 = zext i512 %r75 to i576
%r77 = add i576 %r76, %r76
%r78 = zext i576 %r77 to i640
%r79 = shl i640 %r78, 64
%r80 = zext i64 %r4 to i128
%r81 = zext i64 %r4 to i128
%r82 = mul i128 %r80, %r81
%r83 = zext i64 %r6 to i128
%r84 = zext i64 %r6 to i128
%r85 = mul i128 %r83, %r84
%r86 = zext i64 %r8 to i128
%r87 = zext i64 %r8 to i128
%r88 = mul i128 %r86, %r87
%r89 = zext i64 %r10 to i128
%r90 = zext i64 %r10 to i128
%r91 = mul i128 %r89, %r90
%r92 = zext i64 %r12 to i128
%r93 = zext i64 %r12 to i128
%r94 = mul i128 %r92, %r93
%r95 = zext i128 %r82 to i256
%r96 = zext i128 %r85 to i256
%r97 = shl i256 %r96, 128
%r98 = or i256 %r95, %r97
%r99 = zext i256 %r98 to i384
%r100 = zext i128 %r88 to i384
%r101 = shl i384 %r100, 256
%r102 = or i384 %r99, %r101
%r103 = zext i384 %r102 to i512
%r104 = zext i128 %r91 to i512
%r105 = shl i512 %r104, 384
%r106 = or i512 %r103, %r105
%r107 = zext i512 %r106 to i640
%r108 = zext i128 %r94 to i640
%r109 = shl i640 %r108, 512
%r110 = or i640 %r107, %r109
%r111 = add i640 %r79, %r110
%r112 = bitcast i64* %r1 to i640*
store i640 %r111, i640* %r112
ret void
}
