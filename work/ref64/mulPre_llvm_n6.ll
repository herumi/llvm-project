@llvm_n6_p = dso_local local_unnamed_addr global i384 19701003098197239606139520050071806902539869635232723333974146702122860885748605305707133127442457820403313995153409
@ip = internal unnamed_addr constant i64 18446744073709551615
@pStr = private unnamed_addr constant [99 x i8] c"0x800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001\00"
define i8* @llvm_n6_get_prime()
{
%r2 = bitcast [99 x i8] *@pStr to i8*
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
define private i448 @llvm_n6_mulUnit(i64* noalias %r2, i64 %r3) alwaysinline
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
%r19 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 5)
%r20 = trunc i128 %r19 to i64
%r21 = call i64 @extractHigh64(i128 %r19)
%r22 = zext i64 %r5 to i128
%r23 = zext i64 %r8 to i128
%r24 = shl i128 %r23, 64
%r25 = or i128 %r22, %r24
%r26 = zext i128 %r25 to i192
%r27 = zext i64 %r11 to i192
%r28 = shl i192 %r27, 128
%r29 = or i192 %r26, %r28
%r30 = zext i192 %r29 to i256
%r31 = zext i64 %r14 to i256
%r32 = shl i256 %r31, 192
%r33 = or i256 %r30, %r32
%r34 = zext i256 %r33 to i320
%r35 = zext i64 %r17 to i320
%r36 = shl i320 %r35, 256
%r37 = or i320 %r34, %r36
%r38 = zext i320 %r37 to i384
%r39 = zext i64 %r20 to i384
%r40 = shl i384 %r39, 320
%r41 = or i384 %r38, %r40
%r42 = zext i64 %r6 to i128
%r43 = zext i64 %r9 to i128
%r44 = shl i128 %r43, 64
%r45 = or i128 %r42, %r44
%r46 = zext i128 %r45 to i192
%r47 = zext i64 %r12 to i192
%r48 = shl i192 %r47, 128
%r49 = or i192 %r46, %r48
%r50 = zext i192 %r49 to i256
%r51 = zext i64 %r15 to i256
%r52 = shl i256 %r51, 192
%r53 = or i256 %r50, %r52
%r54 = zext i256 %r53 to i320
%r55 = zext i64 %r18 to i320
%r56 = shl i320 %r55, 256
%r57 = or i320 %r54, %r56
%r58 = zext i320 %r57 to i384
%r59 = zext i64 %r21 to i384
%r60 = shl i384 %r59, 320
%r61 = or i384 %r58, %r60
%r62 = zext i384 %r41 to i448
%r63 = zext i384 %r61 to i448
%r64 = shl i448 %r63, 64
%r65 = add i448 %r62, %r64
ret i448 %r65
}
define void @llvm_n6_sqrPre(i64* noalias %r1, i64* noalias %r2)
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
%r13 = getelementptr i64, i64* %r2, i32 5
%r14 = load i64, i64* %r13
%r15 = zext i64 %r4 to i128
%r16 = zext i64 %r14 to i128
%r17 = mul i128 %r15, %r16
%r18 = zext i64 %r4 to i128
%r19 = zext i64 %r12 to i128
%r20 = mul i128 %r18, %r19
%r21 = zext i64 %r6 to i128
%r22 = zext i64 %r14 to i128
%r23 = mul i128 %r21, %r22
%r24 = zext i128 %r20 to i256
%r25 = zext i128 %r23 to i256
%r26 = shl i256 %r25, 128
%r27 = or i256 %r24, %r26
%r28 = zext i128 %r17 to i256
%r29 = shl i256 %r28, 64
%r30 = add i256 %r29, %r27
%r31 = zext i64 %r4 to i128
%r32 = zext i64 %r10 to i128
%r33 = mul i128 %r31, %r32
%r34 = zext i64 %r6 to i128
%r35 = zext i64 %r12 to i128
%r36 = mul i128 %r34, %r35
%r37 = zext i64 %r8 to i128
%r38 = zext i64 %r14 to i128
%r39 = mul i128 %r37, %r38
%r40 = zext i128 %r33 to i256
%r41 = zext i128 %r36 to i256
%r42 = shl i256 %r41, 128
%r43 = or i256 %r40, %r42
%r44 = zext i256 %r43 to i384
%r45 = zext i128 %r39 to i384
%r46 = shl i384 %r45, 256
%r47 = or i384 %r44, %r46
%r48 = zext i256 %r30 to i384
%r49 = shl i384 %r48, 64
%r50 = add i384 %r49, %r47
%r51 = zext i64 %r4 to i128
%r52 = zext i64 %r8 to i128
%r53 = mul i128 %r51, %r52
%r54 = zext i64 %r6 to i128
%r55 = zext i64 %r10 to i128
%r56 = mul i128 %r54, %r55
%r57 = zext i64 %r8 to i128
%r58 = zext i64 %r12 to i128
%r59 = mul i128 %r57, %r58
%r60 = zext i64 %r10 to i128
%r61 = zext i64 %r14 to i128
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
%r75 = zext i384 %r50 to i512
%r76 = shl i512 %r75, 64
%r77 = add i512 %r76, %r74
%r78 = zext i64 %r4 to i128
%r79 = zext i64 %r6 to i128
%r80 = mul i128 %r78, %r79
%r81 = zext i64 %r6 to i128
%r82 = zext i64 %r8 to i128
%r83 = mul i128 %r81, %r82
%r84 = zext i64 %r8 to i128
%r85 = zext i64 %r10 to i128
%r86 = mul i128 %r84, %r85
%r87 = zext i64 %r10 to i128
%r88 = zext i64 %r12 to i128
%r89 = mul i128 %r87, %r88
%r90 = zext i64 %r12 to i128
%r91 = zext i64 %r14 to i128
%r92 = mul i128 %r90, %r91
%r93 = zext i128 %r80 to i256
%r94 = zext i128 %r83 to i256
%r95 = shl i256 %r94, 128
%r96 = or i256 %r93, %r95
%r97 = zext i256 %r96 to i384
%r98 = zext i128 %r86 to i384
%r99 = shl i384 %r98, 256
%r100 = or i384 %r97, %r99
%r101 = zext i384 %r100 to i512
%r102 = zext i128 %r89 to i512
%r103 = shl i512 %r102, 384
%r104 = or i512 %r101, %r103
%r105 = zext i512 %r104 to i640
%r106 = zext i128 %r92 to i640
%r107 = shl i640 %r106, 512
%r108 = or i640 %r105, %r107
%r109 = zext i512 %r77 to i640
%r110 = shl i640 %r109, 64
%r111 = add i640 %r110, %r108
%r112 = zext i640 %r111 to i704
%r113 = add i704 %r112, %r112
%r114 = zext i704 %r113 to i768
%r115 = shl i768 %r114, 64
%r116 = zext i64 %r4 to i128
%r117 = zext i64 %r4 to i128
%r118 = mul i128 %r116, %r117
%r119 = zext i64 %r6 to i128
%r120 = zext i64 %r6 to i128
%r121 = mul i128 %r119, %r120
%r122 = zext i64 %r8 to i128
%r123 = zext i64 %r8 to i128
%r124 = mul i128 %r122, %r123
%r125 = zext i64 %r10 to i128
%r126 = zext i64 %r10 to i128
%r127 = mul i128 %r125, %r126
%r128 = zext i64 %r12 to i128
%r129 = zext i64 %r12 to i128
%r130 = mul i128 %r128, %r129
%r131 = zext i64 %r14 to i128
%r132 = zext i64 %r14 to i128
%r133 = mul i128 %r131, %r132
%r134 = zext i128 %r118 to i256
%r135 = zext i128 %r121 to i256
%r136 = shl i256 %r135, 128
%r137 = or i256 %r134, %r136
%r138 = zext i256 %r137 to i384
%r139 = zext i128 %r124 to i384
%r140 = shl i384 %r139, 256
%r141 = or i384 %r138, %r140
%r142 = zext i384 %r141 to i512
%r143 = zext i128 %r127 to i512
%r144 = shl i512 %r143, 384
%r145 = or i512 %r142, %r144
%r146 = zext i512 %r145 to i640
%r147 = zext i128 %r130 to i640
%r148 = shl i640 %r147, 512
%r149 = or i640 %r146, %r148
%r150 = zext i640 %r149 to i768
%r151 = zext i128 %r133 to i768
%r152 = shl i768 %r151, 640
%r153 = or i768 %r150, %r152
%r154 = add i768 %r115, %r153
%r155 = bitcast i64* %r1 to i768*
store i768 %r154, i768* %r155
ret void
}
